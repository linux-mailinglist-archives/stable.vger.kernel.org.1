Return-Path: <stable+bounces-65337-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D787A946C2F
	for <lists+stable@lfdr.de>; Sun,  4 Aug 2024 07:15:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A636281D9C
	for <lists+stable@lfdr.de>; Sun,  4 Aug 2024 05:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 241D8B658;
	Sun,  4 Aug 2024 05:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="fBYXf47t"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 286818493
	for <stable@vger.kernel.org>; Sun,  4 Aug 2024 05:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722748531; cv=none; b=h9iRkwG4UrJajFDr6PfTdzibMRWFXUd6NqygSjWd8HRx4r9AwAsmmxaEHaoCRUZR+FQ1hUDUe8FTCHGIT8Yj1bZQ4ZhWSGBsM7wICzLpCG2dBa/RSfdvEIWw9n79J5kAWMyQv0lOm/F5ifBUx/N5N4XyghCSioAoYn3XZEhIsRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722748531; c=relaxed/simple;
	bh=hC94lJtk6TXXcWzwvKA6sgtgiBt9hLLyMvUa+xoW4ks=;
	h=From:To:CC:Date:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=F96vlCCoePuViD9KCqaokb3qOJnicYtjswiKS7/X+TXMcCrYlVCHX67Z00CtyWGnj+CvaAS9dmKA3ebVFt7prfPd0R7bkYgJjmg1TGr8x1r+vlDi1xY16P3wMf/HEqCxYK97T9+Vsnwj7xVRbk1bQqloomgyEbY7r8POkeNZfaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=fBYXf47t; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-59f9f59b827so13365204a12.1
        for <stable@vger.kernel.org>; Sat, 03 Aug 2024 22:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1722748528; x=1723353328; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IfRRcniaBVMwO5ZH+xc0aRIPkDBM+y8KvVhsHnScZT8=;
        b=fBYXf47tGu7BavOXI0hpqRURhswbvNgiqXi3vW6LYL6lzJ74eyxD8GLGXXaooelCJW
         o1WRrj+Bepc4eSsTgvPQLSKxMBG3+2So4Al9pqV6UPODM69YgyWDzjaUUrzYKvshT1kR
         XDrJr+hyraGDnp16g6NUybqVv97Om7TGctSbU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722748528; x=1723353328;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IfRRcniaBVMwO5ZH+xc0aRIPkDBM+y8KvVhsHnScZT8=;
        b=Ow+E2BOja9eFfiOs8hLLhKTsHRQQc1V+pRde9q2oXyNJC3F5qbOlDNHFDZlaOX1wPQ
         E0Ioq2aXvl0WXZiXioZuTI/7PUqaYQuibZMhaddA0yPeyDHru+MwwEMJ1xi1ociaZR7M
         8uWVZqMB8wlDUO82zlLj3qwR27q2W7xhXlBmCUOZa4BiJ1V0I8K56mWfABSO+G5fC4//
         /sB6idQlQMnQvmBIfrETs+4hIECuASUmlXEsrcoruUSeIxfSqRZmdoo6Rn1uZsNOrks3
         o9/khWLTew+ydwBMFjvTAVd8m83YQ1ynGbRSwpYQzqxQEvndWWiM3nlKkM7HtzPo15eq
         I0aQ==
X-Forwarded-Encrypted: i=1; AJvYcCVLec6OVzZMD94uvDTjwXlz46aAtYvwXK5leAj2yM42/AUWhDAbwrwchmt6onOX25UNiiJa3eKiu+aHMBznlYvREqVsBnkh
X-Gm-Message-State: AOJu0YwNG+7i46oU/GpNtOXVaLqJvbsVsUCeamv4IteVv5cvur9tkPXp
	5PBlIUam4TgNO+tuS4mnmP2yWSadI2PuYEHK8ggJ+G7t/dsK1l+94SJ53IAyIg==
X-Google-Smtp-Source: AGHT+IGRATyaylaBzEG3ZZ7Q/CU5ff7wZmkBUSPsjwNUhxOc6yzMFhwG4JmIpQNT4OFEDxjCVH6e4g==
X-Received: by 2002:a50:e602:0:b0:5a1:f74d:2d58 with SMTP id 4fb4d7f45d1cf-5b7f541365cmr5444803a12.24.1722748528160;
        Sat, 03 Aug 2024 22:15:28 -0700 (PDT)
Received: from [192.168.178.38] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5baff14989fsm521960a12.55.2024.08.03.22.15.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Aug 2024 22:15:27 -0700 (PDT)
From: Arend Van Spriel <arend.vanspriel@broadcom.com>
To: Aditya Garg <gargaditya08@live.com>, <devnull+j.jannau.net@kernel.org>
CC: <asahi@lists.linux.dev>, <brcm80211-dev-list.pdl@broadcom.com>, <brcm80211@lists.linux.dev>, <j@jannau.net>, <kvalo@kernel.org>, <linus.walleij@linaro.org>, <linux-kernel@vger.kernel.org>, <linux-wireless@vger.kernel.org>, <marcan@marcan.st>, <stable@vger.kernel.org>
Date: Sun, 04 Aug 2024 07:15:27 +0200
Message-ID: <1911bd06198.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
In-Reply-To: <MA0P287MB021718EE92FC809CB2BB0F82B8BD2@MA0P287MB0217.INDP287.PROD.OUTLOOK.COM>
References: <MA0P287MB021718EE92FC809CB2BB0F82B8BD2@MA0P287MB0217.INDP287.PROD.OUTLOOK.COM>
User-Agent: AquaMail/1.51.5 (build: 105105504)
Subject: Re: [PATCH] wifi: brcmfmac: cfg80211: Handle SSID based pmksa deletion
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="us-ascii"
Content-Transfer-Encoding: 8bit

On August 4, 2024 5:11:00 AM Aditya Garg <gargaditya08@live.com> wrote:

> Hi
>
> wpa_supplicant 2.11 broke Wi-Fi on T2 Macs as well, but this patch doesn't 
> seem to be fixing Wi-Fi. Instead, it's breaking it even on older 2.10 
> wpa_supplicant. Tested by a user on bcm4364b2 wifi chip with a WPA2-PSK 
> [AES] network. dmesg output:
>
> However dmesg outputs more info

Not seeing much info in this output which indicate an issue.

> [    5.852978] usbcore: registered new interface driver brcmfmac
> [    5.853114] brcmfmac 0000:01:00.0: enabling device (0000 -> 0002)
> [    5.992212] brcmfmac: brcmf_fw_alloc_request: using 
> brcm/brcmfmac4364b2-pcie for chip BCM4364/3
> [    5.993923] brcmfmac 0000:01:00.0: Direct firmware load for 
> brcm/brcmfmac4364b2-pcie.apple,maui-HRPN-u-7.5-X0.bin failed with error -2
> [    5.993968] brcmfmac 0000:01:00.0: Direct firmware load for 
> brcm/brcmfmac4364b2-pcie.apple,maui-HRPN-u-7.5.bin failed with error -2
> [    5.994004] brcmfmac 0000:01:00.0: Direct firmware load for 
> brcm/brcmfmac4364b2-pcie.apple,maui-HRPN-u.bin failed with error -2
> [    5.994041] brcmfmac 0000:01:00.0: Direct firmware load for 
> brcm/brcmfmac4364b2-pcie.apple,maui-HRPN.bin failed with error -2
> [    5.994076] brcmfmac 0000:01:00.0: Direct firmware load for 
> brcm/brcmfmac4364b2-pcie.apple,maui-X0.bin failed with error -2
> [    6.162830] Bluetooth: hci0: BCM: 'brcm/BCM.hcd'
> [    6.796637] brcmfmac: brcmf_c_process_txcap_blob: TxCap blob found, loading
> [    6.798396] brcmfmac: brcmf_c_preinit_dcmds: Firmware: BCM4364/3 wl0: 
> Jul 10 2023 12:30:19 version 9.30.503.0.32.5.92 FWID 01-88a8883

This message means the firmware download was completed successfully.

> [    6.885876] brcmfmac 0000:01:00.0 wlp1s0: renamed from wlan0
> [    8.195243] ieee80211 phy0: brcmf_p2p_set_firmware: failed to update 
> device address ret -52
> [    8.196584] ieee80211 phy0: brcmf_p2p_create_p2pdev: set p2p_disc error
> [    8.196588] ieee80211 phy0: brcmf_cfg80211_add_iface: add iface 
> p2p-dev-wlp1s0 type 10 failed: err=-52

The creation of P2P device fails, but this only disables P2P aka 
WiFi-Direct. A full kernel log would be helpful. Even better to build the 
driver with CONFIG_BRCMDBG and load the driver with modparam 
'debug=0x9416'. That will show a lot more driver logging which may provide 
more clues.

Regards,
Arend




