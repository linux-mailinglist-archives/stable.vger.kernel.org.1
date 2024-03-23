Return-Path: <stable+bounces-28650-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F24388795A
	for <lists+stable@lfdr.de>; Sat, 23 Mar 2024 17:18:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 004EC28204F
	for <lists+stable@lfdr.de>; Sat, 23 Mar 2024 16:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D161245029;
	Sat, 23 Mar 2024 16:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O+kYI9rw"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D99111EB34
	for <stable@vger.kernel.org>; Sat, 23 Mar 2024 16:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711210692; cv=none; b=oxmYvGOW1OpsAZ14kuuBxtVl1gO32kayNhnZq7TkU1WSKQ5TJkq8jEAda5pGYcRta9RHhVvuNn9u3jcVVtRmu/u7flmZPt9KmNtJabBhRN3rqcKdDPH9Wd9IJjnbglxVBCWT/2pmuKIFjASmifOtRVbKShJJr+HiPVSffvh1kbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711210692; c=relaxed/simple;
	bh=qMWZmmyT8evXf26KRzXzsGkaYbvEfz87ruS8pEi87yM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:References:
	 In-Reply-To:Content-Type; b=tMEa7RCCIS4OXsi6IIeMa1x0o+Jzjgt0OJFu7mYSHK7Dijj3YsAJrZoIwbXfqpL6jAawe3+GdB/NddWMIcrIAiwkOtpFYgPki5c3wMH/3OHy0XZxagJE2N4Z6Br1t3LX4rgsPpgEcYr/44i1Kk8pCpVonh3vQRx/xYgdBEgIhYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O+kYI9rw; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-33ff53528ceso1846017f8f.0
        for <stable@vger.kernel.org>; Sat, 23 Mar 2024 09:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711210689; x=1711815489; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:from:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iPw/8WJzxV7HjFfhMmIei/3rtzbLBOeSOetLCesVtF8=;
        b=O+kYI9rwk4fKI7PuMG+mG1WmRGNkoJFSyiyxACwgC9stmmxetw072SmT6JAovEhjvC
         L79Du7zxGMriYkTbB97TPQcIkfwxjMqzuylP+pYphPR7KcU2LiXOyZoE3Z3CE0Ljs8n7
         uTxGH2Cp6P0gVxmMGsiGaDLflIhtTqHn5jfndwiZ9hFV5iZdKFe5S+Jecttt9RsKehXj
         HgaeA0L/6ONw2GEhF21wNSOhXDJlcNViPgJCelOGyVP6RzqlVobsY1rmh5LU7OBvcoTC
         i7XqQ5ocU3oJ0kfaHgnMQWT1nMpuLIibgINP25egeoTZC4NHz18YilA5cf7VzfQCj/vI
         k+YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711210689; x=1711815489;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iPw/8WJzxV7HjFfhMmIei/3rtzbLBOeSOetLCesVtF8=;
        b=FHAJnePdQAIasQF3rpBsIL8Q56MzyD7mWhuPDWJO1gFZvF2csIRCsTtVZ5mI7E/eCA
         gRjMz/xQkX7fc+nGeLguvAqsxmjaZ4C0K2GdLzl0EjwQT5AOTlaR67yf5Z+MJ+g2Bguj
         76EbawXayOUisbrVJZzj+5w8E3Ab/Is7rWvJc6LtifFTuVv8b+YktzHdu6cKQqnxHoyy
         5OdIkAghtj02J5LgOY1OgW9y3rDCpTm9BLgsbF3ju/En0rdA6zrZ5/CpXeDKbcTbEsgL
         GoLAXsoBwsWxa8tJIXsCxq5u2sWlYE7C1aUnm+Gz7DlFoynA/lvqP3n5GqF1LT3wjRx9
         U8zg==
X-Gm-Message-State: AOJu0YwjH3hTB9BCwKOr/zHayZaujqXktuxRCyCxBIG/yeLVZPBRQlbI
	eSblf78Mlsl9hWoT4UUEkfduQKwt40WAVO4aQe91SYTYfBpy+osjsHIi2QjC
X-Google-Smtp-Source: AGHT+IH0KC1CyjfyzssjwDhcDNgOXXC/Go93IwgPHlwEBk0miUYrlJ5rIbq5jhZmn4xZcMykR7qkqA==
X-Received: by 2002:a5d:5685:0:b0:341:c4d0:4b93 with SMTP id f5-20020a5d5685000000b00341c4d04b93mr706379wrv.43.1711210689043;
        Sat, 23 Mar 2024 09:18:09 -0700 (PDT)
Received: from [192.168.1.50] ([79.119.240.211])
        by smtp.gmail.com with ESMTPSA id bs2-20020a056000070200b00341c310bd4bsm1259472wrb.30.2024.03.23.09.18.08
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Mar 2024 09:18:08 -0700 (PDT)
Message-ID: <aa20f8ba-d626-4f82-9312-6cc2a4cfc097@gmail.com>
Date: Sat, 23 Mar 2024 18:18:07 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: [PATCH] wifi: rtw88: 8821cu: Fix connection failure
To: stable@vger.kernel.org
References: <f12ed39d-28e8-4b8b-8d22-447bcf295afc@gmail.com>
Content-Language: en-US
In-Reply-To: <f12ed39d-28e8-4b8b-8d22-447bcf295afc@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

From: Bitterblue Smith <rtl8821cerfe2@gmail.com>

[ Upstream commit 605d7c0b05eecb985273b1647070497142c470d3 ]

Clear bit 8 of REG_SYS_STATUS1 after MAC power on.

Without this, some RTL8821CU and RTL8811CU cannot connect to any
network:

Feb 19 13:33:11 ideapad2 kernel: wlp3s0f3u2: send auth to
	90:55:de:__:__:__ (try 1/3)
Feb 19 13:33:13 ideapad2 kernel: wlp3s0f3u2: send auth to
	90:55:de:__:__:__ (try 2/3)
Feb 19 13:33:14 ideapad2 kernel: wlp3s0f3u2: send auth to
	90:55:de:__:__:__ (try 3/3)
Feb 19 13:33:15 ideapad2 kernel: wlp3s0f3u2: authentication with
	90:55:de:__:__:__ timed out

The RTL8822CU and RTL8822BU out-of-tree drivers do this as well, so do
it for all three types of chips.

Tested with RTL8811CU (Tenda U9 V2.0).

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Acked-by: Ping-Ke Shih <pkshih@realtek.com>
Signed-off-by: Kalle Valo <kvalo@kernel.org>
Link: https://msgid.link/aeeefad9-27c8-4506-a510-ef9a9a8731a4@gmail.com
---
 drivers/net/wireless/realtek/rtw88/mac.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw88/mac.c b/drivers/net/wireless/realtek/rtw88/mac.c
index 298663b03580..0c1c1ff31085 100644
--- a/drivers/net/wireless/realtek/rtw88/mac.c
+++ b/drivers/net/wireless/realtek/rtw88/mac.c
@@ -309,6 +309,13 @@ static int rtw_mac_power_switch(struct rtw_dev *rtwdev, bool pwr_on)
 	pwr_seq = pwr_on ? chip->pwr_on_seq : chip->pwr_off_seq;
 	ret = rtw_pwr_seq_parser(rtwdev, pwr_seq);
 
+	if (pwr_on && rtw_hci_type(rtwdev) == RTW_HCI_TYPE_USB) {
+		if (chip->id == RTW_CHIP_TYPE_8822C ||
+		    chip->id == RTW_CHIP_TYPE_8822B ||
+		    chip->id == RTW_CHIP_TYPE_8821C)
+			rtw_write8_clr(rtwdev, REG_SYS_STATUS1 + 1, BIT(0));
+	}
+
 	if (rtw_hci_type(rtwdev) == RTW_HCI_TYPE_SDIO)
 		rtw_write32(rtwdev, REG_SDIO_HIMR, imr);
 
-- 
2.43.2

