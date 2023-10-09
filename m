Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EEEC7BE139
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:48:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234540AbjJINsS (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:48:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234547AbjJINsS (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:48:18 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B24A94
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:48:16 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D02F3C433C7;
        Mon,  9 Oct 2023 13:48:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696859296;
        bh=qyF+uiVNISqJB+4wetCHUMoeuTR33CU96RKFipLE/jo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QcOC9DfB4wQhacHmEXwpRj9KZSgo1G0EfbnHlbmxn0S+9ynInYMCy50+eilO/4nxY
         JP8sCFO+HV8CsaxZakPNwjag+X+xGuBZutwzzFtSlcokqGOgDm0kqH8wvvtYmqSjMT
         tVHms8LtVQx4oQasPBbn6Q/+MSQgG4Q6OFQ9HeAo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Budimir Markovic <markovicbudimir@gmail.com>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Shaoying Xu <shaoyi@amazon.com>
Subject: [PATCH 4.14 33/55] net/sched: sch_hfsc: Ensure inner classes have fsc curve
Date:   Mon,  9 Oct 2023 15:06:32 +0200
Message-ID: <20231009130108.966422318@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009130107.717692466@linuxfoundation.org>
References: <20231009130107.717692466@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Budimir Markovic <markovicbudimir@gmail.com>

commit b3d26c5702c7d6c45456326e56d2ccf3f103e60f upstream.

HFSC assumes that inner classes have an fsc curve, but it is currently
possible for classes without an fsc curve to become parents. This leads
to bugs including a use-after-free.

Don't allow non-root classes without HFSC_FSC to become parents.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: Budimir Markovic <markovicbudimir@gmail.com>
Signed-off-by: Budimir Markovic <markovicbudimir@gmail.com>
Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
Link: https://lore.kernel.org/r/20230824084905.422-1-markovicbudimir@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ v4.14: Delete NL_SET_ERR_MSG because extack is not added to hfsc_change_class ]
Signed-off-by: Shaoying Xu <shaoyi@amazon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sched/sch_hfsc.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/net/sched/sch_hfsc.c
+++ b/net/sched/sch_hfsc.c
@@ -1020,6 +1020,8 @@ hfsc_change_class(struct Qdisc *sch, u32
 		if (parent == NULL)
 			return -ENOENT;
 	}
+	if (!(parent->cl_flags & HFSC_FSC) && parent != &q->root)
+		return -EINVAL;
 
 	if (classid == 0 || TC_H_MAJ(classid ^ sch->handle) != 0)
 		return -EINVAL;


