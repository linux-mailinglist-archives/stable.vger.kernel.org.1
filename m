Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B08A726DB7
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 22:45:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234705AbjFGUos (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 16:44:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234706AbjFGUoo (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 16:44:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20F9626BF
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 13:44:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3BD896464F
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 20:44:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 505C3C433EF;
        Wed,  7 Jun 2023 20:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686170666;
        bh=5DwqsY8jX3cH76DHY0a72VrqD2LzZ4K6+l06hTIRTzs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=av6N8iPZcFdDNWZ2HaG/Ai/I9uRps9xElKfvhI9/1NOWobaxcmhBQM92DaSmi5Pmn
         RUdiD9XPICbKrz2N9SJnN0WjZo3sAZkM5yxIO5e6lCkokxgW4esWHnk6K+iikSDTJ9
         W8MVEfUMCwO02ucQmtJfzCuXfncZAuzFmsthUk6A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Christian Kujau <lists@nerdbynature.de>,
        Juergen Gross <jgross@suse.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>,
        Jason Andryuk <jandryuk@gmail.com>
Subject: [PATCH 6.1 171/225] x86/mtrr: Revert 90b926e68f50 ("x86/pat: Fix pat_x_mtrr_type() for MTRR disabled case")
Date:   Wed,  7 Jun 2023 22:16:04 +0200
Message-ID: <20230607200919.984425789@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230607200913.334991024@linuxfoundation.org>
References: <20230607200913.334991024@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Juergen Gross <jgross@suse.com>

commit f9f57da2c2d119dbf109e3f6e1ceab7659294046 upstream.

Commit

  90b926e68f50 ("x86/pat: Fix pat_x_mtrr_type() for MTRR disabled case")

broke the use case of running Xen dom0 kernels on machines with an
external disk enclosure attached via USB, see Link tag.

What this commit was originally fixing - SEV-SNP guests on Hyper-V - is
a more specialized situation which has other issues at the moment anyway
so reverting this now and addressing the issue properly later is the
prudent thing to do.

So revert it in time for the 6.2 proper release.

  [ bp: Rewrite commit message. ]

Reported-by: Christian Kujau <lists@nerdbynature.de>
Tested-by: Christian Kujau <lists@nerdbynature.de>
Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/4fe9541e-4d4c-2b2a-f8c8-2d34a7284930@nerdbynature.de
Cc: Jason Andryuk <jandryuk@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/mm/pat/memtype.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/arch/x86/mm/pat/memtype.c
+++ b/arch/x86/mm/pat/memtype.c
@@ -434,8 +434,7 @@ static unsigned long pat_x_mtrr_type(u64
 		u8 mtrr_type, uniform;
 
 		mtrr_type = mtrr_type_lookup(start, end, &uniform);
-		if (mtrr_type != MTRR_TYPE_WRBACK &&
-		    mtrr_type != MTRR_TYPE_INVALID)
+		if (mtrr_type != MTRR_TYPE_WRBACK)
 			return _PAGE_CACHE_MODE_UC_MINUS;
 
 		return _PAGE_CACHE_MODE_WB;


