Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98C4C761130
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 12:48:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229445AbjGYKs3 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 06:48:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231918AbjGYKs3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 06:48:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46B071990
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 03:48:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C5CA86165E
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 10:48:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5F01C433C8;
        Tue, 25 Jul 2023 10:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690282107;
        bh=1Ko5y/TipNGHIDLvDQZkKivh74YHifplpXB5Pvt7wX0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oL6BOFVOMrdvPJUgEw2348KvI3ApXoR2TZt43dyO796La7O8WxykU1keTt0ZZUziY
         oxdCUY94x3RWGiMVvAVL/FxkakxhdBSNYGHhMGIjEgKBeteGIGB7So00nHFTXgQGxO
         2i3YN7KZkyQQ557ycKjWDO30Xp69/qOPBm1Ecej0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Miguel Ojeda <ojeda@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.4 011/227] prctl: move PR_GET_AUXV out of PR_MCE_KILL
Date:   Tue, 25 Jul 2023 12:42:58 +0200
Message-ID: <20230725104515.257569507@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104514.821564989@linuxfoundation.org>
References: <20230725104514.821564989@linuxfoundation.org>
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

From: Miguel Ojeda <ojeda@kernel.org>

commit 636e348353a7cc52609fdba5ff3270065da140d5 upstream.

Somehow PR_GET_AUXV got added into PR_MCE_KILL's switch when the patch was
applied [1].

Thus move it out of the switch, to the place the patch added it.

In the recently released v6.4 kernel some user could, in principle, be
already using this feature by mapping the right page and passing the
PR_GET_AUXV constant as a pointer:

    prctl(PR_MCE_KILL, PR_GET_AUXV, ...)

So this does change the behavior for users.  We could keep the bug since
the other subcases in PR_MCE_KILL (PR_MCE_KILL_CLEAR and PR_MCE_KILL_SET)
do not overlap.

However, v6.4 may be recent enough (2 weeks old) that moving the lines
(rather than just adding a new case) does not break anybody?  Moreover,
the documentation in man-pages was just committed today [2].

Link: https://lkml.kernel.org/r/20230708233344.361854-1-ojeda@kernel.org
Fixes: ddc65971bb67 ("prctl: add PR_GET_AUXV to copy auxv to userspace")
Link: https://lore.kernel.org/all/d81864a7f7f43bca6afa2a09fc2e850e4050ab42.1680611394.git.josh@joshtriplett.org/ [1]
Link: https://git.kernel.org/pub/scm/docs/man-pages/man-pages.git/commit/?id=8cf0c06bfd3c2b219b044d4151c96f0da50af9ad [2]
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/sys.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -2529,11 +2529,6 @@ SYSCALL_DEFINE5(prctl, int, option, unsi
 			else
 				return -EINVAL;
 			break;
-	case PR_GET_AUXV:
-		if (arg4 || arg5)
-			return -EINVAL;
-		error = prctl_get_auxv((void __user *)arg2, arg3);
-		break;
 		default:
 			return -EINVAL;
 		}
@@ -2688,6 +2683,11 @@ SYSCALL_DEFINE5(prctl, int, option, unsi
 	case PR_SET_VMA:
 		error = prctl_set_vma(arg2, arg3, arg4, arg5);
 		break;
+	case PR_GET_AUXV:
+		if (arg4 || arg5)
+			return -EINVAL;
+		error = prctl_get_auxv((void __user *)arg2, arg3);
+		break;
 #ifdef CONFIG_KSM
 	case PR_SET_MEMORY_MERGE:
 		if (arg3 || arg4 || arg5)


