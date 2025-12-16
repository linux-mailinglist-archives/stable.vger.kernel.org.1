Return-Path: <stable+bounces-202576-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 16207CC2C3E
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 13:33:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3538A302E7D3
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 12:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8DC0397D09;
	Tue, 16 Dec 2025 12:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="frvz05h/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D27397D06;
	Tue, 16 Dec 2025 12:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765888344; cv=none; b=o/yOguOzNO0C7ZaEqcFU51m8F9AtQ5MkorGlclWcdfFxPMT3/T3dm6khhtLJafxLDj1Wm2sgqCK4CkGXShZ50U4nmVMuz578hjo/fxs6U8iz0eI+FuDhxLntcPkRytrJOrigmot49+frm/RjPQa4fG0Fiq8VnhzfDbv1fsg7kZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765888344; c=relaxed/simple;
	bh=5CXCpobsb0CPotwCt/Ty9MwBVPiSJCy3PT2aIpVb1WI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HsvP/ciwbTa5cQPSBGZMK7aG2NAYUpVCrJra6cDG1gUFptn/BBrtpVSjBTqO3Ui+D11kyzlsquSID+h9xVgSEZAUslvVdv6LxOpkMgXAbx972SNlz9gsLOUcEizj4/rpGo1yLtMRvEa4alHL4uWYYU4DdKxtlQbtMzKyqPkNg4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=frvz05h/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D157FC4CEF1;
	Tue, 16 Dec 2025 12:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1765888344;
	bh=5CXCpobsb0CPotwCt/Ty9MwBVPiSJCy3PT2aIpVb1WI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=frvz05h/n0JOX3Xk4rmAinQS3aV+nUNiLFyGikRNWwH3XWODmN1q2LSh7xFS5PL3V
	 TXRw6oaSJ867s12rEVPZchDdubDEoXjWM03hqQxpzwQ1NHYTxPd6kgD3cI0C2RQFys
	 vJMpmjOHie5NAv+YAkLor9Fd/uCS3dcaH92NmV0g=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	=?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= <noltari@gmail.com>,
	Jonas Gorski <jonas.gorski@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 507/614] net: dsa: b53: fix extracting VID from entry for BCM5325/65
Date: Tue, 16 Dec 2025 12:14:34 +0100
Message-ID: <20251216111419.740192939@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251216111401.280873349@linuxfoundation.org>
References: <20251216111401.280873349@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jonas Gorski <jonas.gorski@gmail.com>

[ Upstream commit 9316012dd01952f75e37035360138ccc786ef727 ]

BCM5325/65's Entry register uses the highest three bits for
VALID/STATIC/AGE, so shifting by 53 only will add these to
b53_arl_entry::vid.

So make sure to mask the vid value as well, to not get invalid VIDs.

Fixes: c45655386e53 ("net: dsa: b53: add support for FDB operations on 5325/5365")
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Tested-by: Álvaro Fernández Rojas <noltari@gmail.com>
Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
Link: https://patch.msgid.link/20251128080625.27181-3-jonas.gorski@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/dsa/b53/b53_priv.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/dsa/b53/b53_priv.h b/drivers/net/dsa/b53/b53_priv.h
index 458775f951643..2f44b3b6a0d9f 100644
--- a/drivers/net/dsa/b53/b53_priv.h
+++ b/drivers/net/dsa/b53/b53_priv.h
@@ -338,7 +338,7 @@ static inline void b53_arl_to_entry_25(struct b53_arl_entry *ent,
 	ent->is_age = !!(mac_vid & ARLTBL_AGE_25);
 	ent->is_static = !!(mac_vid & ARLTBL_STATIC_25);
 	u64_to_ether_addr(mac_vid, ent->mac);
-	ent->vid = mac_vid >> ARLTBL_VID_S_65;
+	ent->vid = (mac_vid >> ARLTBL_VID_S_65) & ARLTBL_VID_MASK_25;
 }
 
 static inline void b53_arl_from_entry(u64 *mac_vid, u32 *fwd_entry,
-- 
2.51.0




