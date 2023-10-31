Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC6F77DD570
	for <lists+stable@lfdr.de>; Tue, 31 Oct 2023 18:50:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236471AbjJaRuy (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 31 Oct 2023 13:50:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236461AbjJaRux (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 31 Oct 2023 13:50:53 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2191A2
        for <stable@vger.kernel.org>; Tue, 31 Oct 2023 10:50:50 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A017C433C8;
        Tue, 31 Oct 2023 17:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698774650;
        bh=wOsHDKWvUZSzeWzizJiZBiybIymL2/TYwf0l+936aIM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cbfKFBlmR8uJSDqdWrtRq6qWhMkvwkGRVFjoM4vvkT1hckgo2VlwX+W+Q+WCG8VRP
         3so7vjd0rWXL+XCGUQRHGPeO9j+SwyAo0fpgGlmGLxUjwy+OOxCjMssCTztKyj2Wnv
         ReiCU1uVmmYuiyArolXg05r80h1D6/cxXAC6vnvU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Sam Ravnborg <sam@ravnborg.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 6.5 106/112] sparc32: fix a braino in fault handling in csum_and_copy_..._user()
Date:   Tue, 31 Oct 2023 18:01:47 +0100
Message-ID: <20231031165904.611422815@linuxfoundation.org>
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

From: Al Viro <viro@zeniv.linux.org.uk>

commit 1f36cd05e0081f2c75769a551d584c4ffb2a5660 upstream.

Fault handler used to make non-trivial calls, so it needed
to set a stack frame up.  Used to be
	save ... - grab a stack frame, old %o... become %i...
	....
	ret	- go back to address originally in %o7, currently %i7
	 restore - switch to previous stack frame, in delay slot
Non-trivial calls had been gone since ab5e8b331244 and that code should
have become
	retl	- go back to address in %o7
	 clr %o0 - have return value set to 0
What it had become instead was
	ret	- go back to address in %i7 - return address of *caller*
	 clr %o0 - have return value set to 0
which is not good, to put it mildly - we forcibly return 0 from
csum_and_copy_{from,to}_iter() (which is what the call of that
thing had been inlined into) and do that without dropping the
stack frame of said csum_and_copy_..._iter().  Confuses the
hell out of the caller of csum_and_copy_..._iter(), obviously...

Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
Fixes: ab5e8b331244 "sparc32: propagate the calling conventions change down to __csum_partial_copy_sparc_generic()"
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/sparc/lib/checksum_32.S |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/sparc/lib/checksum_32.S
+++ b/arch/sparc/lib/checksum_32.S
@@ -453,5 +453,5 @@ ccslow:	cmp	%g1, 0
  * we only bother with faults on loads... */
 
 cc_fault:
-	ret
+	retl
 	 clr	%o0


