Return-Path: <stable+bounces-97261-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3428F9E2B4D
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 19:46:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E8BBBC36FD
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 15:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CA3D204F89;
	Tue,  3 Dec 2024 15:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0ZAXSG4l"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB4421F75A4;
	Tue,  3 Dec 2024 15:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733239978; cv=none; b=GsVL1labn4aNSHhcmw3gFCxrP4MDCMo+Y0+vIqukSlj3qB9vOMr+yi05heiwyrlfJ3P9uQt6y4R6H33rrVRVrhq8ZK5cBDPZKdah4Z673m58dUWaw7DxS5dGsYglrOmub3NrzYmFiUq+CL9B56LOS2oZ8Hlc61E0RabAeMXtkRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733239978; c=relaxed/simple;
	bh=8eDXQpC4ePyaAQ63NFtVRDTBgLw2F+zmxOX3zojT7nE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mj0clsDzzRU3Sf+ZXgg/WDxoxpmJ3BWB4vShH9coARoaBIp1URlZOViXASndnoWGnywidV0mD13EXuCFrIJelRR6nsUn4ZjfFGsFcuGBQ0OdDqB4kmqiAwvQNaIbEZo23k2MDaJHKe9KoPjYmLjTe+zpOWYLZAzlq5RpSKUe6NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0ZAXSG4l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ED76C4CED8;
	Tue,  3 Dec 2024 15:32:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733239977;
	bh=8eDXQpC4ePyaAQ63NFtVRDTBgLw2F+zmxOX3zojT7nE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=0ZAXSG4l/mbMaXOhh+0kfne4F2RirU7vPqdw08Ud7lRbEKGASKHlRikZjCY2lMZNh
	 4pDErY8gKD3vo6/wLJ96PFOjgZryiva2L/1ks3YaYiKTh7GZJXLn1K1hVZvItlJWK9
	 wu5eBUAX+dTJHWfJAoGr3ZNx7ms+txxAWGz02Gz4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Matt Fleming <mfleming@cloudflare.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.11 799/817] kbuild: deb-pkg: Dont fail if modules.order is missing
Date: Tue,  3 Dec 2024 15:46:11 +0100
Message-ID: <20241203144027.200159861@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241203143955.605130076@linuxfoundation.org>
References: <20241203143955.605130076@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.11-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Matt Fleming <mfleming@cloudflare.com>

[ Upstream commit bcbbf493f2fa6fa1f0832f6b5b4c80a65de242d6 ]

Kernels built without CONFIG_MODULES might still want to create -dbg deb
packages but install_linux_image_dbg() assumes modules.order always
exists. This obviously isn't true if no modules were built, so we should
skip reading modules.order in that case.

Fixes: 16c36f8864e3 ("kbuild: deb-pkg: use build ID instead of debug link for dbg package")
Signed-off-by: Matt Fleming <mfleming@cloudflare.com>
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 scripts/package/builddeb | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/scripts/package/builddeb b/scripts/package/builddeb
index c1757db6aa8a8..718fbf99e2cea 100755
--- a/scripts/package/builddeb
+++ b/scripts/package/builddeb
@@ -97,16 +97,18 @@ install_linux_image_dbg () {
 
 	# Parse modules.order directly because 'make modules_install' may sign,
 	# compress modules, and then run unneeded depmod.
-	while read -r mod; do
-		mod="${mod%.o}.ko"
-		dbg="${pdir}/usr/lib/debug/lib/modules/${KERNELRELEASE}/kernel/${mod}"
-		buildid=$("${READELF}" -n "${mod}" | sed -n 's@^.*Build ID: \(..\)\(.*\)@\1/\2@p')
-		link="${pdir}/usr/lib/debug/.build-id/${buildid}.debug"
-
-		mkdir -p "${dbg%/*}" "${link%/*}"
-		"${OBJCOPY}" --only-keep-debug "${mod}" "${dbg}"
-		ln -sf --relative "${dbg}" "${link}"
-	done < modules.order
+	if is_enabled CONFIG_MODULES; then
+		while read -r mod; do
+			mod="${mod%.o}.ko"
+			dbg="${pdir}/usr/lib/debug/lib/modules/${KERNELRELEASE}/kernel/${mod}"
+			buildid=$("${READELF}" -n "${mod}" | sed -n 's@^.*Build ID: \(..\)\(.*\)@\1/\2@p')
+			link="${pdir}/usr/lib/debug/.build-id/${buildid}.debug"
+
+			mkdir -p "${dbg%/*}" "${link%/*}"
+			"${OBJCOPY}" --only-keep-debug "${mod}" "${dbg}"
+			ln -sf --relative "${dbg}" "${link}"
+		done < modules.order
+	fi
 
 	# Build debug package
 	# Different tools want the image in different locations
-- 
2.43.0




