Return-Path: <stable+bounces-146775-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D3B6BAC5480
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 19:01:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1D801BA4E05
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 17:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 332701D88D7;
	Tue, 27 May 2025 17:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vDTTRZZu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3349154C15;
	Tue, 27 May 2025 17:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748365271; cv=none; b=HZf/5Nt1ujcXg/R3PFjS2UhfebM068nA9UGqa2Xf3XIMEqg8XcuTM7BnyiUhulrfjV0fywcFb5Y3iF1xVP18qdPmQ96QOcz5Z9Hqtq77PF0SvYsiZbFncDcTrx2jC3vq2Xsa8tDd4ZOOdWlhWmEbpIRNDkuSr0ZgaHtlkxrePTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748365271; c=relaxed/simple;
	bh=wYC1gx4FWXz9lF3pQqQi9V4Z3DzgBS/J2nJkcQcK0hY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YMfyemA1YKgIn36ySJt92Yzx23RAMk8DwNwrDNtYdH3N6V33GeEVxXWaO4Q6wjIwaVp+jDDrDx208DW3PBx77X4SpA5h+wQbmRNNt1swQBiB/cbOL9TFj7xlc/evZc2fa4Qis/qO3DxoI7GJ4fjKjm6VpLk/0U1BGMNCn5JeBCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vDTTRZZu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A9AFC4CEE9;
	Tue, 27 May 2025 17:01:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748365270;
	bh=wYC1gx4FWXz9lF3pQqQi9V4Z3DzgBS/J2nJkcQcK0hY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vDTTRZZulEV7f12E+YiHxVHB92idnneFndbAmaxeT79j4LwOajXhhsFxVTF8YeFRE
	 H+0mE2TObpB/mJMiLIZrzjti8lirE6pSMpvMjBpH0B1xFeonVPA2NxHb4K1GUw1Gra
	 pyWM2eTV42wdQ5tXUOJgltRWUJ/Y3qC8gt7ov/LA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ping-Ke Shih <pkshih@realtek.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 322/626] wifi: rtw89: fw: get sb_sel_ver via get_unaligned_le32()
Date: Tue, 27 May 2025 18:23:35 +0200
Message-ID: <20250527162458.119879646@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250527162445.028718347@linuxfoundation.org>
References: <20250527162445.028718347@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ping-Ke Shih <pkshih@realtek.com>

[ Upstream commit 2f9da853f4d848d23bade4c22931ea0f5a011674 ]

The sb_sel_ver is selection version for secure boot recorded in firmware
binary data, and its size is 4 and offset is 58 (not natural alignment).
Use get_unaligned_le32() to get this value safely. Find this by reviewing.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Link: https://patch.msgid.link/20250217064308.43559-3-pkshih@realtek.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/realtek/rtw89/fw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 9d26502a2885a..f0e87af68d8cb 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -285,7 +285,7 @@ static int __parse_formatted_mssc(struct rtw89_dev *rtwdev,
 	if (!sec->secure_boot)
 		goto out;
 
-	sb_sel_ver = le32_to_cpu(section_content->sb_sel_ver.v);
+	sb_sel_ver = get_unaligned_le32(&section_content->sb_sel_ver.v);
 	if (sb_sel_ver && sb_sel_ver != sec->sb_sel_mgn)
 		goto ignore;
 
-- 
2.39.5




