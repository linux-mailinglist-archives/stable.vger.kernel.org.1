Return-Path: <stable+bounces-141720-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9101AAAB5D5
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 07:37:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BD2D188174F
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 05:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94B8F34D2CC;
	Tue,  6 May 2025 00:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RVR2luCa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8363E3BAF89;
	Mon,  5 May 2025 23:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746487348; cv=none; b=jlQSUcieflgTXNIa6w2R7EQTFHFTJKc6lKZYWvFMa8L/fINAWOd0GwYLo3Qf2zhVTRBDfiyN3GsZcEg5cmOZjl2NwUV0gCUy7RI9vZFbPVvFljbraRiuXbMiHdy9VL3AYJh09u/iuoodmVAK+7MGgI+FLHS/hIM7g/8vAuqvsjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746487348; c=relaxed/simple;
	bh=JFgqoAx4qm9ESF434DIhxonx7TZFPDGHqvsGOtFP3aQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ROUO6KZ/COM8Dmtf0acRy4XUBoel0X0omtbWcsNxO/5EQoVz1A4dZBM0uWBvXUNw/JfiWWA1bHIMKV9shPjNHjBVv4CD6zQSDzIa/WU6+gMkY9uWYbBHtUJDhq1+nGlMmpsbPR3PHWwf3lfjwE4ymuYIlTtRjJLCKuidv9jSiGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RVR2luCa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0E46C4CEE4;
	Mon,  5 May 2025 23:22:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746487348;
	bh=JFgqoAx4qm9ESF434DIhxonx7TZFPDGHqvsGOtFP3aQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RVR2luCagItNzMv69VRDzGdayxIKwio3Kicy1SSSt1bDnzHcwjAbUqyvYpTNszYKx
	 is0WBfTOioB4AIjX4gYOrDGTFbmI232RUPq0i5S32DXRwYPR1SCBy80ZYthiHL3dTw
	 Sxbi7SK0MhBKiuCXFjgeKILG65Ows7hzdc1flxHAUw7BXWdm9y2yUKee1o+I8Xd2Wk
	 KlD4x6qEUUugzgVvOXvfMuiLDlYoMmVW3F9bU2sVnJaLHj1+HdT7cxeI5U0ZeNrKVE
	 UI3DezJJfL66fAV9QYylo1/kmc+bft49jiydHLWr0k5Rir1VH6A0bVjKL4W8nGT98l
	 HcKuabPWO04RQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Seyediman Seyedarab <imandevel@gmail.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.4 21/79] kbuild: fix argument parsing in scripts/config
Date: Mon,  5 May 2025 19:20:53 -0400
Message-Id: <20250505232151.2698893-21-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505232151.2698893-1-sashal@kernel.org>
References: <20250505232151.2698893-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.293
Content-Transfer-Encoding: 8bit

From: Seyediman Seyedarab <imandevel@gmail.com>

[ Upstream commit f757f6011c92b5a01db742c39149bed9e526478f ]

The script previously assumed --file was always the first argument,
which caused issues when it appeared later. This patch updates the
parsing logic to scan all arguments to find --file, sets the config
file correctly, and resets the argument list with the remaining
commands.

It also fixes --refresh to respect --file by passing KCONFIG_CONFIG=$FN
to make oldconfig.

Signed-off-by: Seyediman Seyedarab <imandevel@gmail.com>
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 scripts/config | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/scripts/config b/scripts/config
index 8c8d7c3d7accc..330bef88fd5ef 100755
--- a/scripts/config
+++ b/scripts/config
@@ -32,6 +32,7 @@ commands:
                              Disable option directly after other option
 	--module-after|-M beforeopt option
                              Turn option into module directly after other option
+	--refresh            Refresh the config using old settings
 
 	commands can be repeated multiple times
 
@@ -124,16 +125,22 @@ undef_var() {
 	txt_delete "^# $name is not set" "$FN"
 }
 
-if [ "$1" = "--file" ]; then
-	FN="$2"
-	if [ "$FN" = "" ] ; then
-		usage
+FN=.config
+CMDS=()
+while [[ $# -gt 0 ]]; do
+	if [ "$1" = "--file" ]; then
+		if [ "$2" = "" ]; then
+			usage
+		fi
+		FN="$2"
+		shift 2
+	else
+		CMDS+=("$1")
+		shift
 	fi
-	shift 2
-else
-	FN=.config
-fi
+done
 
+set -- "${CMDS[@]}"
 if [ "$1" = "" ] ; then
 	usage
 fi
@@ -217,9 +224,8 @@ while [ "$1" != "" ] ; do
 		set_var "${CONFIG_}$B" "${CONFIG_}$B=m" "${CONFIG_}$A"
 		;;
 
-	# undocumented because it ignores --file (fixme)
 	--refresh)
-		yes "" | make oldconfig
+		yes "" | make oldconfig KCONFIG_CONFIG=$FN
 		;;
 
 	*)
-- 
2.39.5


