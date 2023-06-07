Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE6BD726C52
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 22:32:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233717AbjFGUc3 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 16:32:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233726AbjFGUc2 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 16:32:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF7B31BD3
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 13:32:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 34AC564510
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 20:32:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42CCAC433EF;
        Wed,  7 Jun 2023 20:32:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686169942;
        bh=mQojfCeB84exQ9wFosFHRjVFWEOgQd4jSIPKj2Eg8zY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Pqa/d0LIisg19btlznSiJV4irsg/apmAKvOv8gfIK/jkeQw/+I3A3oWIQOxC7uT35
         T1m2mYSTxs9Qx1D7IU+1lZShEspsqGqKfoNLemuVutpcJeEGcGAJL9Ek/SziTKpYvS
         No9eS0kRF+0AmKMiR6mBYToYiv5rz3x37DWsQCms=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Sean Christopherson <seanjc@google.com>
Subject: [PATCH 6.3 273/286] KVM: x86: Account fastpath-only VM-Exits in vCPU stats
Date:   Wed,  7 Jun 2023 22:16:12 +0200
Message-ID: <20230607200932.215068351@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230607200922.978677727@linuxfoundation.org>
References: <20230607200922.978677727@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Sean Christopherson <seanjc@google.com>

commit 8b703a49c9df5e74870381ad7ba9c85d8a74ed2c upstream.

Increment vcpu->stat.exits when handling a fastpath VM-Exit without
going through any part of the "slow" path.  Not bumping the exits stat
can result in wildly misleading exit counts, e.g. if the primary reason
the guest is exiting is to program the TSC deadline timer.

Fixes: 404d5d7bff0d ("KVM: X86: Introduce more exit_fastpath_completion enum values")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20230602011920.787844-2-seanjc@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kvm/x86.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -10682,6 +10682,9 @@ static int vcpu_enter_guest(struct kvm_v
 			exit_fastpath = EXIT_FASTPATH_EXIT_HANDLED;
 			break;
 		}
+
+		/* Note, VM-Exits that go down the "slow" path are accounted below. */
+		++vcpu->stat.exits;
 	}
 
 	/*


