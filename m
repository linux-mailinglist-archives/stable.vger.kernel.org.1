Return-Path: <stable+bounces-147477-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C10EDAC57D2
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 19:37:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBFD816651E
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 17:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6AFD27F16D;
	Tue, 27 May 2025 17:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZffztVR1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7499627CCF0;
	Tue, 27 May 2025 17:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748367461; cv=none; b=TjETJiof6+/lYFxuy5hZ3WQAggQlFe26GfsdaT/GNNX/ug5GuwfK/KoniMZP3pCW06We+8W4mfldKhRP9hUwEuhXDIaFe/c+EuAJk9iYtUNSbl/AF2hml5c3hkaPfBXoiUilPoKbUZSmhxgcqKQ6Ci3+58Qp7C+2o8pIIHyTM4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748367461; c=relaxed/simple;
	bh=GHqaqdbCPPbR7T1tTeCG/r9Ec4yRqRa3Sik2Mk894eI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yyk9anpgEMRvPitpxszJhlGJRgR4eMjApIWwrIH3+hFYGaUrT6cdmX497Nsc396mYw8IxW/Z1aX08Gcp8YAV626ScmA5NX2nWBf8Vs3xSpaxLEwfN5Ex3fgJsnNTxc0w1CNu7iPWHAkwZcWrrwdtzbM4cKnkteTbzepifTUXD7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZffztVR1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD48CC4CEE9;
	Tue, 27 May 2025 17:37:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748367461;
	bh=GHqaqdbCPPbR7T1tTeCG/r9Ec4yRqRa3Sik2Mk894eI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZffztVR10EUseTbDCnVYbwSC/NhJD1gmLOfl/qvYrLJNWLp6Ruu3A4FNpHWhI6259
	 7kd7qq/H1oKTFKZZW5lvRdcjVfVkb+Y7Ef+k/8pKauJTP4LeXnNzqzgUftpwa7HP0Y
	 rvpIn37J143mF0xP3ie9TITb2BTU41a5vOFnZkQQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ping-Ke Shih <pkshih@realtek.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.14 396/783] wifi: rtw89: fw: propagate error code from rtw89_h2c_tx()
Date: Tue, 27 May 2025 18:23:13 +0200
Message-ID: <20250527162529.219226472@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250527162513.035720581@linuxfoundation.org>
References: <20250527162513.035720581@linuxfoundation.org>
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

From: Ping-Ke Shih <pkshih@realtek.com>

[ Upstream commit 56e1acaa0f80620b8e2c3410db35b4b975782b0a ]

The error code should be propagated to callers during downloading firmware
header and body. Remove unnecessary assignment of -1.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Link: https://patch.msgid.link/20250217064308.43559-4-pkshih@realtek.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/realtek/rtw89/fw.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 2f3869c700696..4727eeb55b486 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -1322,7 +1322,6 @@ static int __rtw89_fw_download_hdr(struct rtw89_dev *rtwdev,
 	ret = rtw89_h2c_tx(rtwdev, skb, false);
 	if (ret) {
 		rtw89_err(rtwdev, "failed to send h2c\n");
-		ret = -1;
 		goto fail;
 	}
 
@@ -1409,7 +1408,6 @@ static int __rtw89_fw_download_main(struct rtw89_dev *rtwdev,
 		ret = rtw89_h2c_tx(rtwdev, skb, true);
 		if (ret) {
 			rtw89_err(rtwdev, "failed to send h2c\n");
-			ret = -1;
 			goto fail;
 		}
 
-- 
2.39.5




