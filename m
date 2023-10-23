Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DC167D31C5
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:13:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233627AbjJWLNC (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:13:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233644AbjJWLNA (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:13:00 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57EA610B
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:12:58 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E65AC433C7;
        Mon, 23 Oct 2023 11:12:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698059577;
        bh=nD6R9MTHvsw460mt64utci+jSpcN+357AA0Zee3xvHE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vjqRMF2UDVAxdNELrGfkWo9cMRNz6kxAGmE8PCPktVES3PIseDzF/dhLts5RTl5aL
         6rZw/pWBcqw9fv71CRO/R6EszZ+In7pOOszKg6l1BYFr43xXlm8EkYT1mZFCduyxTl
         u52QdwJRBpecvBUgojUGMR67RNaokRqz/yd2B2FA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Shrikanth Hegde <sshegde@linux.vnet.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Nysal Jan K.A" <nysal@linux.ibm.com>
Subject: [PATCH 6.5 223/241] powerpc/qspinlock: Fix stale propagated yield_cpu
Date:   Mon, 23 Oct 2023 12:56:49 +0200
Message-ID: <20231023104839.299887627@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023104833.832874523@linuxfoundation.org>
References: <20231023104833.832874523@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nicholas Piggin <npiggin@gmail.com>

commit f9bc9bbe8afdf83412728f0b464979a72a3b9ec2 upstream.

yield_cpu is a sample of a preempted lock holder that gets propagated
back through the queue. Queued waiters use this to yield to the
preempted lock holder without continually sampling the lock word (which
would defeat the purpose of MCS queueing by bouncing the cache line).

The problem is that yield_cpu can become stale. It can take some time to
be passed down the chain, and if any queued waiter gets preempted then
it will cease to propagate the yield_cpu to later waiters.

This can result in yielding to a CPU that no longer holds the lock,
which is bad, but particularly if it is currently in H_CEDE (idle),
then it appears to be preempted and some hypervisors (PowerVM) can
cause very long H_CONFER latencies waiting for H_CEDE wakeup. This
results in latency spikes and hard lockups on oversubscribed
partitions with lock contention.

This is a minimal fix. Before yielding to yield_cpu, sample the lock
word to confirm yield_cpu is still the owner, and bail out of it is not.

Thanks to a bunch of people who reported this and tracked down the
exact problem using tracepoints and dispatch trace logs.

Fixes: 28db61e207ea ("powerpc/qspinlock: allow propagation of yield CPU down the queue")
Cc: stable@vger.kernel.org # v6.2+
Reported-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Reported-by: Laurent Dufour <ldufour@linux.ibm.com>
Reported-by: Shrikanth Hegde <sshegde@linux.vnet.ibm.com>
Debugged-by: "Nysal Jan K.A" <nysal@linux.ibm.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Tested-by: Shrikanth Hegde <sshegde@linux.vnet.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://msgid.link/20231016124305.139923-2-npiggin@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/lib/qspinlock.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/powerpc/lib/qspinlock.c b/arch/powerpc/lib/qspinlock.c
index 253620979d0c..6dd2f46bd3ef 100644
--- a/arch/powerpc/lib/qspinlock.c
+++ b/arch/powerpc/lib/qspinlock.c
@@ -406,6 +406,9 @@ static __always_inline bool yield_to_prev(struct qspinlock *lock, struct qnode *
 	if ((yield_count & 1) == 0)
 		goto yield_prev; /* owner vcpu is running */
 
+	if (get_owner_cpu(READ_ONCE(lock->val)) != yield_cpu)
+		goto yield_prev; /* re-sample lock owner */
+
 	spin_end();
 
 	preempted = true;
-- 
2.42.0



