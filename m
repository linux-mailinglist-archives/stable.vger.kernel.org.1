Return-Path: <stable+bounces-79369-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1039F98D7E5
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 15:54:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40C721C229BC
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 13:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6348C1D0488;
	Wed,  2 Oct 2024 13:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fMsWpO0d"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 218B129CE7;
	Wed,  2 Oct 2024 13:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727877242; cv=none; b=RamhKrPjKHcRaw0z1ohxkXzNdjHz/Rg7OVxyOH/eDjy3DKLHV11ONTv+UaqZB7cGpjEsF9YjJrCpX79wZ+S0q4XiXwjFN5acPhhTLQOaU36WjT/Ki+XZqyFWBiufkj4FG5BEwMZ8NmpygCJ8+I8EidD96F08VNTWprLAvtDooGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727877242; c=relaxed/simple;
	bh=xBQ+i+rXfKfvHS7A8Zlo2MY8KhQ6Jr7KB8iDmr820U0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GPeWu4KbjpSrty4LR6D0f46vUzayLvFbcoL6tEOgeKJV8Yo/WxOBi59VWMj0+iFE3XBeJlo3xpdxT8pHECtJOSFOlWzVY0pbOJYIDBOjcZwRw+ahdZF8TkNUgWdMzbmmJyFzPpNEDAFMwghiwYeCLXbJrl5AlBwXA+ybbVVw4vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fMsWpO0d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A0F8C4CEC2;
	Wed,  2 Oct 2024 13:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727877242;
	bh=xBQ+i+rXfKfvHS7A8Zlo2MY8KhQ6Jr7KB8iDmr820U0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fMsWpO0dg3NapZsNdCgt95NBKvsEHlvoXDppEef07M95hXKjic4HoduEd9gfLFhgC
	 rpQ8TWIZdCIwWv9/Slis4qJkgjO/IP3xW8MuNXZwsLL1MRAgIBr5FNMVqcmEr76aZb
	 ZAtiHlQbIuOV8Kqx0+kLC1xO8gnpHSdnAbzlPeZs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ping-Ke Shih <pkshih@realtek.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.10 017/634] wifi: rtw89: remove unused C2H event ID RTW89_MAC_C2H_FUNC_READ_WOW_CAM to prevent out-of-bounds reading
Date: Wed,  2 Oct 2024 14:51:57 +0200
Message-ID: <20241002125811.773862001@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241002125811.070689334@linuxfoundation.org>
References: <20241002125811.070689334@linuxfoundation.org>
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

6.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ping-Ke Shih <pkshih@realtek.com>

[ Upstream commit 56310ddb50b190b3390fdc974aec455d0a516bd2 ]

The handler of firmware C2H event RTW89_MAC_C2H_FUNC_READ_WOW_CAM isn't
implemented, but driver expects number of handlers is
NUM_OF_RTW89_MAC_C2H_FUNC_WOW causing out-of-bounds access. Fix it by
removing ID.

Addresses-Coverity-ID: 1598775 ("Out-of-bounds read")

Fixes: ff53fce5c78b ("wifi: rtw89: wow: update latest PTK GTK info to mac80211 after resume")
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Link: https://patch.msgid.link/20240809072012.84152-4-pkshih@realtek.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/realtek/rtw89/mac.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/mac.h b/drivers/net/wireless/realtek/rtw89/mac.h
index a580cb7192337..755a55c8bc20b 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.h
+++ b/drivers/net/wireless/realtek/rtw89/mac.h
@@ -421,7 +421,6 @@ enum rtw89_mac_c2h_mrc_func {
 
 enum rtw89_mac_c2h_wow_func {
 	RTW89_MAC_C2H_FUNC_AOAC_REPORT,
-	RTW89_MAC_C2H_FUNC_READ_WOW_CAM,
 
 	NUM_OF_RTW89_MAC_C2H_FUNC_WOW,
 };
-- 
2.43.0




