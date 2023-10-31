Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A58907DD56E
	for <lists+stable@lfdr.de>; Tue, 31 Oct 2023 18:50:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236433AbjJaRur (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 31 Oct 2023 13:50:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236471AbjJaRur (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 31 Oct 2023 13:50:47 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB694B4
        for <stable@vger.kernel.org>; Tue, 31 Oct 2023 10:50:44 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B80BC433C9;
        Tue, 31 Oct 2023 17:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698774644;
        bh=Bs3XP0BsloPrT3sn9EmpV687UrJfOQXH2Gsg5KUyCsA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IiA94Fpuh0sp5n1AOqph3Wg8TlfhWW3QAMdINMspAarn/pN7VPexNgkNwfEXoNDIl
         g47R9g2RJe7vxctCJ9Kw8gPTL40ZTZJNidz5sUY8GFftQsm3oyLelRQxc/yVGRvaDf
         WBAK8jKXlCvpNIIXRFpf9249+Re8DIuD5YuJJzxI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Tony Luck <tony.luck@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: [PATCH 6.5 104/112] x86/cpu: Add model number for Intel Arrow Lake mobile processor
Date:   Tue, 31 Oct 2023 18:01:45 +0100
Message-ID: <20231031165904.551353848@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231031165901.318222981@linuxfoundation.org>
References: <20231031165901.318222981@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tony Luck <tony.luck@intel.com>

commit b99d70c0d1380f1368fd4a82271280c4fd28558b upstream.

For "reasons" Intel has code-named this CPU with a "_H" suffix.

[ dhansen: As usual, apply this and send it upstream quickly to
	   make it easier for anyone who is doing work that
	   consumes this. ]

Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lore.kernel.org/all/20231025202513.12358-1-tony.luck%40intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/include/asm/intel-family.h |    2 ++
 1 file changed, 2 insertions(+)

--- a/arch/x86/include/asm/intel-family.h
+++ b/arch/x86/include/asm/intel-family.h
@@ -27,6 +27,7 @@
  *		_X	- regular server parts
  *		_D	- micro server parts
  *		_N,_P	- other mobile parts
+ *		_H	- premium mobile parts
  *		_S	- other client parts
  *
  *		Historical OPTDIFFs:
@@ -125,6 +126,7 @@
 
 #define INTEL_FAM6_LUNARLAKE_M		0xBD
 
+#define INTEL_FAM6_ARROWLAKE_H		0xC5
 #define INTEL_FAM6_ARROWLAKE		0xC6
 
 /* "Small Core" Processors (Atom/E-Core) */


