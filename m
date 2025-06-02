Return-Path: <stable+bounces-149339-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AFABBACB25E
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 16:30:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACA621945AFF
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 14:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CDC9225419;
	Mon,  2 Jun 2025 14:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="q1liiMkL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF232253BA;
	Mon,  2 Jun 2025 14:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748873664; cv=none; b=sbZZY/MkhcvbdWI6znv+sN/okVCTDwuhgyt6fNWCKV3lLBKz1/7Yqjd31bYlFCMIfvxeFO21EX4St2/9Db2t6rNiL3q2uCeu016ls6DL+S9hR7KWoQgAWYZlOSiPLl0w8iHAzXzxnDyjcfKDHEhhAE55LTQOhBIEha/Dxl16LrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748873664; c=relaxed/simple;
	bh=67DM/IaDiD1GEhO+wtONZyHf9i/6jQSG/lRhMnVblFE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DWXhio15mvMu+VV/fqspjDs0A7kSMCDH9hScXV4MGFmkEQUrkLiw7qkaABFyFehtJkhx5+N8DK+DVLN8D/nlT2KlhMlcXNQhWNcPN6Wti5UOI1y0yFMmgHakoq68mYB5R6vBdrd2LuYWoyoE9z8C+g/3axVRWkseW0t+o0AO9Dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=q1liiMkL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62878C4CEEB;
	Mon,  2 Jun 2025 14:14:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748873663;
	bh=67DM/IaDiD1GEhO+wtONZyHf9i/6jQSG/lRhMnVblFE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q1liiMkLpt94pGnj8HOCotFyytp7xblvn0SY5Elw5/ASOFIoGd2Z+g0Wzy17Lhmny
	 izZ0PfQq9LxpSHILWDdq6rowcUR3z9lOgarqEO+/v7J9ivs74qUQ9H0DX4csqB49AW
	 BXCzag9By7xQYfaPlYs2MNEKs+EMaysrCaoFfevc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Bitterblue Smith <rtl8821cerfe2@gmail.com>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 205/444] wifi: rtw88: Fix rtw_desc_to_mcsrate() to handle MCS16-31
Date: Mon,  2 Jun 2025 15:44:29 +0200
Message-ID: <20250602134349.223512869@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250602134340.906731340@linuxfoundation.org>
References: <20250602134340.906731340@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bitterblue Smith <rtl8821cerfe2@gmail.com>

[ Upstream commit 86d04f8f991a0509e318fe886d5a1cf795736c7d ]

This function translates the rate number reported by the hardware into
something mac80211 can understand. It was ignoring the 3SS and 4SS HT
rates. Translate them too.

Also set *nss to 0 for the HT rates, just to make sure it's
initialised.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Acked-by: Ping-Ke Shih <pkshih@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Link: https://patch.msgid.link/d0a5a86b-4869-47f6-a5a7-01c0f987cc7f@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/realtek/rtw88/util.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw88/util.c b/drivers/net/wireless/realtek/rtw88/util.c
index e222d3c01a77e..66819f6944055 100644
--- a/drivers/net/wireless/realtek/rtw88/util.c
+++ b/drivers/net/wireless/realtek/rtw88/util.c
@@ -101,7 +101,8 @@ void rtw_desc_to_mcsrate(u16 rate, u8 *mcs, u8 *nss)
 		*nss = 4;
 		*mcs = rate - DESC_RATEVHT4SS_MCS0;
 	} else if (rate >= DESC_RATEMCS0 &&
-		   rate <= DESC_RATEMCS15) {
+		   rate <= DESC_RATEMCS31) {
+		*nss = 0;
 		*mcs = rate - DESC_RATEMCS0;
 	}
 }
-- 
2.39.5




