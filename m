Return-Path: <stable+bounces-141614-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4708DAAB4EC
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 07:18:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E16094E4E7D
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 05:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 467C8486600;
	Tue,  6 May 2025 00:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b/bMhvMy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF9822F3657;
	Mon,  5 May 2025 23:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486881; cv=none; b=mPU78G79Pk7V0MX4/Qqyuo/GYKwKs1Hi6Les/LCVI5dTfeUA7TPpIdgS/E5GXqSDzivVtbydbC/IroGifeno03qAnFRv42dBOrFEHnkwrRqi5Q64Y50iIKCek1p83e9+TZ2LKUtrvScM1FndQOr8ja6jb0Eyq8dA1BMl4UkEOMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486881; c=relaxed/simple;
	bh=PnKYlJycEJNsBqUYVwar69zrMIukgXwAyTqvk8IyVXo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=i8JtoWZOk8DOucHQQDc6CrRxt0fedKxLuJ3eNsg0/vaXj6nHsJMZJMoEFTdgyJ/CsHl6Wh+FBSofpEs1MLViAf4jmEh1vifF22n2NqO0PjedX8solT3ZdAUC4vNZ+/T91pt4vDoM3ub3bQYgyHRHdoOlb6XxaiegXOKgwwtvzxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b/bMhvMy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20316C4CEE4;
	Mon,  5 May 2025 23:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486880;
	bh=PnKYlJycEJNsBqUYVwar69zrMIukgXwAyTqvk8IyVXo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=b/bMhvMysFeUubTxLJ5XTph2toqEfBGTK2TKWT3sbWNQWH9k0m8NQ/jcluxyVu2yd
	 YWmWnvq7eAcntoIiTpMQtUNtKzvyP5RDU+Hc92etv1Ouz/JlGZCFM5L4bexHwXw8sa
	 VHjeBCO8oSuRYq/tr53J6XsqfrPDDsAjZbtUOpgjr0ZTfoQY1BQ/CSu5D8VsQ5DSiL
	 j1ABVbKWSA0SXfZ7V+6lEDwEb5P3bukgCOOncH5s4PFbPuWAcSoY5nJr2xwEODtFGo
	 4p34eExMPvxvQbXgITpFWxulpPCZwgi5pJzNDXUWjZgv5pm0Al50fXgO+CvRNaB6DR
	 oQdD2Ql46Af6w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Seyediman Seyedarab <imandevel@gmail.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.15 040/153] kbuild: fix argument parsing in scripts/config
Date: Mon,  5 May 2025 19:11:27 -0400
Message-Id: <20250505231320.2695319-40-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505231320.2695319-1-sashal@kernel.org>
References: <20250505231320.2695319-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.181
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
index ff88e2faefd35..ea475c07de283 100755
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


