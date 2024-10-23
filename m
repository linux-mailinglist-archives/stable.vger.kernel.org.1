Return-Path: <stable+bounces-87963-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D14C79AD8AF
	for <lists+stable@lfdr.de>; Thu, 24 Oct 2024 01:52:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5CB3BB21DC6
	for <lists+stable@lfdr.de>; Wed, 23 Oct 2024 23:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 936151F9439;
	Wed, 23 Oct 2024 23:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="YpRvGYef"
X-Original-To: stable@vger.kernel.org
Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9776B1553AB;
	Wed, 23 Oct 2024 23:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729727541; cv=none; b=sunLlLeh+YNw/9vROwdZqm9NBi7a53mm71q9u/eJGsLSOknLQhDeQWuUKa9Ek2wL/hlVu7IQfz7pr1I7dWb/B1Aj/olHTAGSo+R74h7FFF6jAOwvfxR7vxwhFmLYtfVDYO9CL+ynF790CbRYjQhbFMvU37OxuCJpu0hv4iW3Zuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729727541; c=relaxed/simple;
	bh=O/vy4mrWdabPdlolsfFrNgZCD6OvMhLbP+0E3oS7FTo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Dj2Yhco7NLcMtGFBK3TWXykMF0ktFPs7sLAfg0m9Lum4vzNe3GYIwq3vuiLyhQNKoc+6un1Cr+qxHPNKmL5edwRZ5Zbwt6pTD79Vkj2QJr84rsiTeiL3SHMJMU586VPXwgUYngzK2oaa2+P5qzDbspVergU0IPqbrN0aBO1iYw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=YpRvGYef; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id EB32E14C1E1;
	Thu, 24 Oct 2024 01:52:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1729727538;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=3amPHg8ShNxpKjTjXddp/0Req2pjfWNLLptqKj3Vw4U=;
	b=YpRvGYefW8lc5XWUlUNnhIqHOUEPilhc6tRLedjdEg1rLdPsjSg9vq/5Yv5sCZCox3WYem
	NgYlGikJGkfBiOgji/r2yGSYhwFs5HqZptnej807XALuXBs9+BaAQuc3DJnl2fbhve2AK4
	twphGDpeuRwy/JO7Px5ogPGBI9RRK0+tu3M8c6UXPUP80flivqwNaMLzP08Q4pesI1wx1R
	XKBT65x4FkeCyFrSrV2E1/jYj2xqqIZnY87/YCTsHjRnqRT8YgTlvLlElAoNNTcFReNEWy
	vkNtV7wHGWpZeZ5cPIl0b+gSePG38Fupj86XpGPULq4tzOGWbsi2Pk7czbsl8Q==
Received: from [127.0.0.1] (localhost.lan [::1])
	by gaia.codewreck.org (OpenSMTPD) with ESMTP id deeb55f8;
	Wed, 23 Oct 2024 23:52:14 +0000 (UTC)
From: Dominique Martinet <asmadeus@codewreck.org>
Subject: [PATCH 0/4] 9p: revert broken inode lookup simplifications
Date: Thu, 24 Oct 2024 08:52:09 +0900
Message-Id: <20241024-revert_iget-v1-0-4cac63d25f72@codewreck.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACmMGWcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxNDINYFKkotKonPTE8t0U01TjFKSU42TzQxSVQC6igoSk3LrACbFh1bWws
 AmDpVMF0AAAA=
To: Eric Van Hensbergen <ericvh@kernel.org>, 
 Latchesar Ionkov <lucho@ionkov.net>, 
 Christian Schoenebeck <linux_oss@crudebyte.com>
Cc: "Linux regression tracking (Thorsten Leemhuis)" <regressions@leemhuis.info>, 
 v9fs@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Dominique Martinet <asmadeus@codewreck.org>, Will Deacon <will@kernel.org>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14-dev-87f09
X-Developer-Signature: v=1; a=openpgp-sha256; l=901; i=asmadeus@codewreck.org;
 h=from:subject:message-id; bh=O/vy4mrWdabPdlolsfFrNgZCD6OvMhLbP+0E3oS7FTo=;
 b=owEBbQKS/ZANAwAIAatOm+xqmOZwAcsmYgBnGYwtTTXV0Vzf3tHyTCdQnx0mr5iu7qLpyQlaD
 L4Se1+saVSJAjMEAAEIAB0WIQT8g9txgG5a3TOhiE6rTpvsapjmcAUCZxmMLQAKCRCrTpvsapjm
 cAFXD/oCPVsgekQYLGCfNhd0yjR5HERUpD3mLTD3ol4NM3At4XCDf7/W5V1GYxgjy/D3jFppfPn
 3/mPUHR9StlW5OSbURM5I8xQnvdUM/DokAGTYAPi07h34BIB7p+mUWDDMUVBQFCDzJhpyrSHIlG
 uDPnTA/uGp7Tst0Hwg2CwlOtvuCxetSv24e3v1sydhWvBMAy5yk9GkEakbibqE0szcHmFrfmmd+
 hY+uP3miYpukyknMFVfvFYeKE6KjQqpqz51dewKpxpWUiZPvMGs6My99bBayG7P9GDqXOaqr8YE
 GBkSWhP7sPHIVmLwof2GWIS4HW70xPPDBGU6jmsWoK7zFQdp1VHOuKxkAvxvtp706MGOdSRReUM
 15iGymhcn9x8fq60/HqY/FiKKdP/Wtu+5DJ2xSYNoDc6aOOXNgX9vyGxiWLAzLM87pc60MQYkdg
 KiwBhvOYHBEcxMFTZQAHhxMoUoJqri78wr9NsvScFWMI84se3m88zFYJTRwfMvVsTm5jKrUZh4z
 eEjR54hUsmPSXkYPi2M62/LKBnItfhYjZqggKSxmAu4O2w4gMUpKWc44cAHTFioNgHB85pxJu/B
 yjvC6t63P206Ho8uVXUhExISx2CwGB+esU89BsbnKsHallBg77wyxLTIkAKOEQNMNrwsB88GtFs
 vnXuwuRoU6Pl9KQ==
X-Developer-Key: i=asmadeus@codewreck.org; a=openpgp;
 fpr=B894379F662089525B3FB1B9333F1F391BBBB00A

See commit 4's message for details

Unless anyone complains I'll send this to Linus on Saturday

Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>
---
Dominique Martinet (4):
      Revert " fs/9p: mitigate inode collisions"
      Revert "fs/9p: remove redundant pointer v9ses"
      Revert "fs/9p: fix uaf in in v9fs_stat2inode_dotl"
      Revert "fs/9p: simplify iget to remove unnecessary paths"

 fs/9p/v9fs.h           |  34 ++++++++++---
 fs/9p/v9fs_vfs.h       |   2 +-
 fs/9p/vfs_inode.c      | 129 +++++++++++++++++++++++++++++++------------------
 fs/9p/vfs_inode_dotl.c | 112 ++++++++++++++++++++++++++++++------------
 fs/9p/vfs_super.c      |   2 +-
 5 files changed, 192 insertions(+), 87 deletions(-)
---
base-commit: 42f7652d3eb527d03665b09edac47f85fb600924
change-id: 20241024-revert_iget-e3d2dcc7a44a

Best regards,
-- 
Dominique Martinet | Asmadeus


