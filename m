Return-Path: <stable+bounces-198784-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AB0BCA0D3F
	for <lists+stable@lfdr.de>; Wed, 03 Dec 2025 19:13:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D40C8308C7AE
	for <lists+stable@lfdr.de>; Wed,  3 Dec 2025 17:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE33134AB07;
	Wed,  3 Dec 2025 16:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NnQT3M3S"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE5134AAFD;
	Wed,  3 Dec 2025 16:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764777673; cv=none; b=Vx5oTXMvldGWZ80S5gQFkRA/LYbBiTVIveIwLWcMG15kUPsnoPLrSSNB4YeOM1LWFFFL+Cy8nOMPfphnRkX+tZ3UW4ZxzE2DmBuCHDLDI/a7985MLNr6aQW21mmeVULuhWOeosKhYPeiuVP4maG+JzpiDBUAbKz3zb7ONpFOqbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764777673; c=relaxed/simple;
	bh=HwepmzbbVJ1s0m6FtF5GA33VTIVyIfp8qbQuL1M6nps=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F9bc1WmQBaOsrBYrjZ/8ZD6z9JTMCEynVE0XTxdwN9A3ooc+F0invJeTNRo1BeGHI8vACaGDZqBHva+Uyj4fnpgj3jw30gUpmhhI0enR+SB3pdkVGFP+kZOUCUf8lIiBR3c6Hc2Nr5K/Xd0XyeAi5/Xt4Z0yPCgUnELSGXn0IEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NnQT3M3S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFB8BC4CEF5;
	Wed,  3 Dec 2025 16:01:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1764777673;
	bh=HwepmzbbVJ1s0m6FtF5GA33VTIVyIfp8qbQuL1M6nps=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NnQT3M3S7BJv39geahu48iJm8SZgpvTlg4Qx0UN3QiV6zABA+84NHftCygj7d0P9J
	 yDyUGjcZNuF18zkiOuvDQrZZudTmAcBqrSzraTY/gMbT4XYtEn3Rog+Ff/Ki5gwEP4
	 PsLTxtOWUI4ZwI4PoPDKUjR/61qC4YibVlKjWH1Y=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Thadeu Lima de Souza Cascardo <cascardo@igalia.com>,
	Zijun Hu <zijun.hu@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 111/392] char: misc: Does not request module for miscdevice with dynamic minor
Date: Wed,  3 Dec 2025 16:24:21 +0100
Message-ID: <20251203152418.182000759@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251203152414.082328008@linuxfoundation.org>
References: <20251203152414.082328008@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zijun Hu <zijun.hu@oss.qualcomm.com>

[ Upstream commit 1ba0fb42aa6a5f072b1b8c0b0520b32ad4ef4b45 ]

misc_open() may request module for miscdevice with dynamic minor, which
is meaningless since:

- The dynamic minor allocated is unknown in advance without registering
  miscdevice firstly.
- Macro MODULE_ALIAS_MISCDEV() is not applicable for dynamic minor.

Fix by only requesting module for miscdevice with fixed minor.

Acked-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Signed-off-by: Zijun Hu <zijun.hu@oss.qualcomm.com>
Link: https://lore.kernel.org/r/20250714-rfc_miscdev-v6-6-2ed949665bde@oss.qualcomm.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/char/misc.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/char/misc.c b/drivers/char/misc.c
index ca5141ed5ef34..90929fb2b56e3 100644
--- a/drivers/char/misc.c
+++ b/drivers/char/misc.c
@@ -113,7 +113,8 @@ static int misc_open(struct inode *inode, struct file *file)
 		}
 	}
 
-	if (!new_fops) {
+	/* Only request module for fixed minor code */
+	if (!new_fops && minor < MISC_DYNAMIC_MINOR) {
 		mutex_unlock(&misc_mtx);
 		request_module("char-major-%d-%d", MISC_MAJOR, minor);
 		mutex_lock(&misc_mtx);
@@ -124,10 +125,11 @@ static int misc_open(struct inode *inode, struct file *file)
 				break;
 			}
 		}
-		if (!new_fops)
-			goto fail;
 	}
 
+	if (!new_fops)
+		goto fail;
+
 	/*
 	 * Place the miscdevice in the file's
 	 * private_data so it can be used by the
-- 
2.51.0




