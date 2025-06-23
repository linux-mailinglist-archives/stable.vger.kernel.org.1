Return-Path: <stable+bounces-157179-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53675AE52E0
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 23:48:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D8313AD0CC
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 21:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6DF9223DD0;
	Mon, 23 Jun 2025 21:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PbQEUncR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B3E4414;
	Mon, 23 Jun 2025 21:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750715230; cv=none; b=lJy1s+uhs2RZeu7LoQC6UwuhtsITUybAA2/C4Uhx+Bz0TmJtrcJkzLfNVKKZLvb022hZ+CZxs4eMOpfZu/5CWno4sbQyQxI7jOeY+ks2fa83TR/EDpaGZrqtt8B7xx1Qqd5L5gXdXlQ+USjkLBuDAG7ziua6pyEB/tWgsKEzgDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750715230; c=relaxed/simple;
	bh=oq5/pMU/qIrZA2Zf30Cr0nCgDS+Fnig8DQNeD3lFbcI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jQGtLDB+A8Y0sXWI+jo8edk82ARLMmi963js7iKMW9ZNw0C5P0oPm3wop8/VAL3cYK2zM5cLfHHQeiBvydwoI+nKa4pNzLF/eC68zmxmMuZ7N2qlRTmSIpnnwcb3gtrqBpAGF4vZUiJ0gm+jZhPXv5NErHwzylLuEzRi/CL0s5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PbQEUncR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A272C4CEEA;
	Mon, 23 Jun 2025 21:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750715230;
	bh=oq5/pMU/qIrZA2Zf30Cr0nCgDS+Fnig8DQNeD3lFbcI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PbQEUncR5SfZLQaM3FaeoyDNUFZyGvYUs5oGJW2FlyVINWTRvVQwa/glLZlFMpg+p
	 WiDkdcrhba9kajnAufZCF1FKvFKfrvKobhZ4sN9EAkxkznf/6g0nDpuzLgU7pj9Mfx
	 bnzN5U/hIZUC8VJxyBfba+uo66BTrzXwBpgBazBU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	David.Kaplan@amd.com,
	peterz@infradead.org,
	pawan.kumar.gupta@linux.intel.com,
	mingo@kernel.org,
	brad.spengler@opensrcsec.com,
	Salvatore Bonaccorso <carnil@debian.org>,
	Breno Leitao <leitao@debian.org>
Subject: [PATCH 5.10 283/355] Revert "x86/bugs: Make spectre user default depend on MITIGATION_SPECTRE_V2" on v6.6 and older
Date: Mon, 23 Jun 2025 15:08:04 +0200
Message-ID: <20250623130635.287667119@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250623130626.716971725@linuxfoundation.org>
References: <20250623130626.716971725@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Breno Leitao <leitao@debian.org>

This reverts commit 0aa2553778b7531c70de77d729a38aea77626544 which is
commit 98fdaeb296f51ef08e727a7cc72e5b5c864c4f4d upstream.

commit 7adb96687ce8 ("x86/bugs: Make spectre user default depend on
MITIGATION_SPECTRE_V2") depends on commit 72c70f480a70 ("x86/bugs: Add
a separate config for Spectre V2"), which introduced
MITIGATION_SPECTRE_V2.

commit 72c70f480a70 ("x86/bugs: Add a separate config for Spectre V2")
never landed in stable tree, thus, stable tree doesn't have
MITIGATION_SPECTRE_V2, that said, commit 7adb96687ce8 ("x86/bugs: Make
spectre user default depend on MITIGATION_SPECTRE_V2") has no value if
the dependecy was not applied.

Revert commit 7adb96687ce8 ("x86/bugs: Make spectre user default
depend on MITIGATION_SPECTRE_V2")  in stable kernel which landed in in
5.4.294, 5.10.238, 5.15.185, 6.1.141 and 6.6.93 stable versions.

Cc: David.Kaplan@amd.com
Cc: peterz@infradead.org
Cc: pawan.kumar.gupta@linux.intel.com
Cc: mingo@kernel.org
Cc: brad.spengler@opensrcsec.com
Cc: stable@vger.kernel.org # 6.6 6.1 5.15 5.10 5.4
Reported-by: Brad Spengler <brad.spengler@opensrcsec.com>
Reported-by: Salvatore Bonaccorso <carnil@debian.org>
Signed-off-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Documentation/admin-guide/kernel-parameters.txt |    2 --
 arch/x86/kernel/cpu/bugs.c                      |   10 +++-------
 2 files changed, 3 insertions(+), 9 deletions(-)

--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5122,8 +5122,6 @@
 
 			Selecting 'on' will also enable the mitigation
 			against user space to user space task attacks.
-			Selecting specific mitigation does not force enable
-			user mitigations.
 
 			Selecting 'off' will disable both the kernel and
 			the user space protections.
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -1231,13 +1231,9 @@ static __ro_after_init enum spectre_v2_m
 static enum spectre_v2_user_cmd __init
 spectre_v2_parse_user_cmdline(void)
 {
-	enum spectre_v2_user_cmd mode;
 	char arg[20];
 	int ret, i;
 
-	mode = IS_ENABLED(CONFIG_MITIGATION_SPECTRE_V2) ?
-		SPECTRE_V2_USER_CMD_AUTO : SPECTRE_V2_USER_CMD_NONE;
-
 	switch (spectre_v2_cmd) {
 	case SPECTRE_V2_CMD_NONE:
 		return SPECTRE_V2_USER_CMD_NONE;
@@ -1250,7 +1246,7 @@ spectre_v2_parse_user_cmdline(void)
 	ret = cmdline_find_option(boot_command_line, "spectre_v2_user",
 				  arg, sizeof(arg));
 	if (ret < 0)
-		return mode;
+		return SPECTRE_V2_USER_CMD_AUTO;
 
 	for (i = 0; i < ARRAY_SIZE(v2_user_options); i++) {
 		if (match_option(arg, ret, v2_user_options[i].option)) {
@@ -1260,8 +1256,8 @@ spectre_v2_parse_user_cmdline(void)
 		}
 	}
 
-	pr_err("Unknown user space protection option (%s). Switching to default\n", arg);
-	return mode;
+	pr_err("Unknown user space protection option (%s). Switching to AUTO select\n", arg);
+	return SPECTRE_V2_USER_CMD_AUTO;
 }
 
 static inline bool spectre_v2_in_eibrs_mode(enum spectre_v2_mitigation mode)



