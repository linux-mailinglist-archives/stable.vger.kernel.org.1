Return-Path: <stable+bounces-141500-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AFB6AAB3D3
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 06:53:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD6C67AE52D
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 04:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C35B734050E;
	Tue,  6 May 2025 00:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="njUReujq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F0F2DBB02;
	Mon,  5 May 2025 23:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486486; cv=none; b=HGojTlEtm+mpvF3L8VZxBZCc05ejitvgqf+mB/RB2jnRa/Xs521AuHQ9CKOvr8I9kMgfUTEEL1Uiv9EUDeUQYJ2jcOI10AqZwHK9LWCiJ15lJYsbTeDFlk3kI4NvvfOXvHjH8dKo8XKuWgqK+aHA+dVXa9D/NSi9dwUwfcxruy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486486; c=relaxed/simple;
	bh=PnKYlJycEJNsBqUYVwar69zrMIukgXwAyTqvk8IyVXo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oKCWQi0ZnTShDm+yzgYAsnCZirlMc92DwfaLDzDwnb0hJr/BCLoUozVueC0O/G1b6QbPwnS68wQXRn6gdHWCz05N1RhU855Tpaa8CLxuw4HfQ/Kep/sJL8y5qOjeJRcsKs8+FUsS0EVKS0gfS03TmM3RVU+lU81a9w7FVU/9azA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=njUReujq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0F40C4CEE4;
	Mon,  5 May 2025 23:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486486;
	bh=PnKYlJycEJNsBqUYVwar69zrMIukgXwAyTqvk8IyVXo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=njUReujqGPJZlQvncVRjofnQlsZaG/JfpSzvON63NkRn+arRQJ8r317r99LReh+0H
	 A7FwgjjlpW5CIX1QkrruR79/VK4tIs0k+SjnH0/SqYV7zagRcdWCPazboJoj5iG+t+
	 J7RyPdGJrx0FJY5nycWoFdPCrAkwaX+ZsNY8fynzVs57QYuyGyYEXHMKU+XgRrZEYp
	 qvHkO9JGFnbvuANnPks71nEHG4uoew955Ly3ul+ILRYdRWigZmqQR1GWZTb8Jt4dAh
	 plCCyvEfwMbNGs8EMSE+1JvejmBE6AX1S1MGMtOb6hR/FyjFK8ivnpVb+y0s7NPvE+
	 8/zxLhI8Twlvg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Seyediman Seyedarab <imandevel@gmail.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 6.1 055/212] kbuild: fix argument parsing in scripts/config
Date: Mon,  5 May 2025 19:03:47 -0400
Message-Id: <20250505230624.2692522-55-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505230624.2692522-1-sashal@kernel.org>
References: <20250505230624.2692522-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.136
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


