Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10A957E2576
	for <lists+stable@lfdr.de>; Mon,  6 Nov 2023 14:32:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232723AbjKFNcR (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 6 Nov 2023 08:32:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232754AbjKFNcQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 6 Nov 2023 08:32:16 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEAADF1
        for <stable@vger.kernel.org>; Mon,  6 Nov 2023 05:32:13 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A047C433C9;
        Mon,  6 Nov 2023 13:32:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699277533;
        bh=Q6quCzg0GUrGe+CUYVlCe4XqJUYcYsKc8fU7iD3Hf6c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xXGxm5GOOAaY/tbFMGEI4G+awjwTT6AsW0Jvm6ja9vYYh9dCfdyLcDqWaFp8ARON7
         ugbnQXPiMp30NHxDEi8WgjlXqSYh7TjBYOJnU/rQViCiRK+DaH3d6FahTO807cliOz
         9RFkz6dzBsfELegZ15u/yCmWtGYcgf2KakzeAjNk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, John Sperbeck <jsperbeck@google.com>
Subject: [PATCH 5.10 53/95] objtool/x86: add missing embedded_insn check
Date:   Mon,  6 Nov 2023 14:04:21 +0100
Message-ID: <20231106130306.637911460@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231106130304.678610325@linuxfoundation.org>
References: <20231106130304.678610325@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: John Sperbeck <jsperbeck@google.com>

When dbf460087755 ("objtool/x86: Fixup frame-pointer vs rethunk")
was backported to some stable branches, the check for dest->embedded_insn
in is_special_call() was missed.  The result is that the warning it
was intended to suppress still appears.  For example on 6.1 (on kernels
before 6.1, the '-s' argument would instead be 'check'):

$ tools/objtool/objtool -s arch/x86/lib/retpoline.o
arch/x86/lib/retpoline.o: warning: objtool: srso_untrain_ret+0xd:
    call without frame pointer save/setup

With this patch, the warning is correctly suppressed, and the
kernel still passes the normal Google kernel developer tests.

Signed-off-by: John Sperbeck <jsperbeck@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/objtool/check.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -2107,7 +2107,7 @@ static bool is_special_call(struct instr
 		if (!dest)
 			return false;
 
-		if (dest->fentry)
+		if (dest->fentry || dest->embedded_insn)
 			return true;
 	}
 


