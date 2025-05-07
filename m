Return-Path: <stable+bounces-142325-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D1A6AAAEA26
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 20:51:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3A6A1BA5538
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 18:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7CC02116E9;
	Wed,  7 May 2025 18:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AK4WEKgV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86BE41FF5EC;
	Wed,  7 May 2025 18:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746643903; cv=none; b=b4gj5jZhtPljvge6S3BkGZKjUyybGF5O2i+6NmU4abLKPm1tFT6YNgcENrBJByAb/aREEt9jKRdofqTsK2M2hECOXkN1aIXbUWCTfUVgAuhDfRI4VPFOWc0WBCtDulsgGwp+8PF2EoddupNtEMQbMR23Zn4i/oRZ5STTZwihPN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746643903; c=relaxed/simple;
	bh=4TNxaNWm8WyNrEtqXrfPTBJWecbDt7MUhmYnlbBXW+c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ls0q2xMULuuoLY5mgCL37nBjdX0RFUgtad1mZ+aBLVjdTEDhQbFDEv47r7FV7r59Cx+uzfpWAtpGTYCTOxn9KOBnLokGqgeuX/cIN4PVavTnSzaYS0aoBYPh6L4HZY/KH4LokFGBZM6CqsFpMCo8dQbV36uvAPuMZ4wx3v8JI88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AK4WEKgV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D8FFC4CEE2;
	Wed,  7 May 2025 18:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1746643903;
	bh=4TNxaNWm8WyNrEtqXrfPTBJWecbDt7MUhmYnlbBXW+c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AK4WEKgVP6xCFi7J/P5YJXJjTRO2MGZBcHpt5talUCebXcdbtU2+zAHmU6iKiB93O
	 5YdoNbrU3rWLLPS0Y3FsFKUkiCFwiQdzRLLBDV54BOwEJG35SIs1NX19J8nnrGGG7+
	 +1nlp2hLKARZR9pQnzRjFTRnnLn7Aha9aTL5GhJo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.14 056/183] powerpc/boot: Check for ld-option support
Date: Wed,  7 May 2025 20:38:21 +0200
Message-ID: <20250507183826.956401989@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250507183824.682671926@linuxfoundation.org>
References: <20250507183824.682671926@linuxfoundation.org>
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

6.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Madhavan Srinivasan <maddy@linux.ibm.com>

[ Upstream commit b2accfe7ca5bc9f9af28e603b79bdd5ad8df5c0b ]

Commit 579aee9fc594 ("powerpc: suppress some linker warnings in recent linker versions")
enabled support to add linker option "--no-warn-rwx-segments",
if the version is greater than 2.39. Similar build warning were
reported recently from linker version 2.35.2.

ld: warning: arch/powerpc/boot/zImage.epapr has a LOAD segment with RWX permissions
ld: warning: arch/powerpc/boot/zImage.pseries has a LOAD segment with RWX permissions

Fix the warning by checking for "--no-warn-rwx-segments"
option support in linker to enable it, instead of checking
for the version range.

Fixes: 579aee9fc594 ("powerpc: suppress some linker warnings in recent linker versions")
Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Suggested-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Tested-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Closes: https://lore.kernel.org/linuxppc-dev/61cf556c-4947-4bd6-af63-892fc0966dad@linux.ibm.com/
Signed-off-by: Madhavan Srinivasan <maddy@linux.ibm.com>
Link: https://patch.msgid.link/20250401004218.24869-1-maddy@linux.ibm.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/boot/wrapper | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/boot/wrapper b/arch/powerpc/boot/wrapper
index 1db60fe13802d..267ca6d4d9b38 100755
--- a/arch/powerpc/boot/wrapper
+++ b/arch/powerpc/boot/wrapper
@@ -234,10 +234,8 @@ fi
 
 # suppress some warnings in recent ld versions
 nowarn="-z noexecstack"
-if ! ld_is_lld; then
-	if [ "$LD_VERSION" -ge "$(echo 2.39 | ld_version)" ]; then
-		nowarn="$nowarn --no-warn-rwx-segments"
-	fi
+if [ $(${CROSS}ld -v --no-warn-rwx-segments &>/dev/null; echo $?) -eq 0 ]; then
+	nowarn="$nowarn --no-warn-rwx-segments"
 fi
 
 platformo=$object/"$platform".o
-- 
2.39.5




