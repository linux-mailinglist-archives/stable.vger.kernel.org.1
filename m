Return-Path: <stable+bounces-50743-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57E36906C5E
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 13:50:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BEAE1C21909
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 11:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE7EF143C62;
	Thu, 13 Jun 2024 11:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SNYiPsMK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C186142911;
	Thu, 13 Jun 2024 11:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718279254; cv=none; b=f7CTfLJSaeSEB6mzXhUUPomizT7skukpBGgY1CKFHnqymTTcf+53VUJbwxZ4dLZBDdaMkg4bgRZbLCb/FP3ZN1xlpIIUxfy4//646QS9x4uj9xcmccGbmh77C+wpw5ojFej5IK3Kr8jV6+2tC63AsBQHzTnTo+MIHKsb+MUHqDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718279254; c=relaxed/simple;
	bh=H9SKgpk0zBbI/ydxMPjmLuMvxceMXNW8k5t/Eve/4X0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tDCxFQVDqNMX4ahz1KWSeqaqW73jNDqLO/z2wNbvaOPRKZxyXCVzeum/0crNHMqwkSA1RzmMmGqH1u2n65x/5KxCDSGanNrE8LF2biMIbGpFNnjBu8lw8yARK2nGNKA63BdYWHjKMne4g26eJFcUzU8wWPx/djOub5DsA+NNeY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SNYiPsMK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01BDFC2BBFC;
	Thu, 13 Jun 2024 11:47:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718279254;
	bh=H9SKgpk0zBbI/ydxMPjmLuMvxceMXNW8k5t/Eve/4X0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SNYiPsMKSt32vLFS/ZZ5lQUPDFj3q6QaAUk6CozJG8T0c6LwW9TcTMZbdluQ20I2Y
	 Y/J8exHifodSqeRcxcOZMvIhA1Z+5dF6Oe78nVJN2s4lHjE7s/D3KB/GwfvJs0Zk5a
	 w4MBhHeigPyVp2S5PUiHyW+yWPFRIjxNwLfn3kdU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ping-Ke Shih <pkshih@realtek.com>
Subject: [PATCH 6.9 014/157] wifi: rtw89: correct aSIFSTime for 6GHz band
Date: Thu, 13 Jun 2024 13:32:19 +0200
Message-ID: <20240613113227.958947828@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240613113227.389465891@linuxfoundation.org>
References: <20240613113227.389465891@linuxfoundation.org>
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

6.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ping-Ke Shih <pkshih@realtek.com>

commit f506e3ee547669cd96842e03c8a772aa7df721fa upstream.

aSIFSTime is 10us for 2GHz band and 16us for 5GHz and 6GHz bands.
Originally, it doesn't consider 6GHz band and use wrong value, so correct
it accordingly.

Cc: stable@vger.kernel.org
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Link: https://msgid.link/20240430020515.8399-1-pkshih@realtek.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/realtek/rtw89/mac80211.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/wireless/realtek/rtw89/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw89/mac80211.c
@@ -318,7 +318,7 @@ static u8 rtw89_aifsn_to_aifs(struct rtw
 	u8 sifs;
 
 	slot_time = vif->bss_conf.use_short_slot ? 9 : 20;
-	sifs = chan->band_type == RTW89_BAND_5G ? 16 : 10;
+	sifs = chan->band_type == RTW89_BAND_2G ? 10 : 16;
 
 	return aifsn * slot_time + sifs;
 }



