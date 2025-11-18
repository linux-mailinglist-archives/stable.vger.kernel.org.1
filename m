Return-Path: <stable+bounces-195107-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C6E0C69EE2
	for <lists+stable@lfdr.de>; Tue, 18 Nov 2025 15:25:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 415534E7E0B
	for <lists+stable@lfdr.de>; Tue, 18 Nov 2025 14:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94D8A35BDA1;
	Tue, 18 Nov 2025 14:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gpVloc57";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="eC0zS9wv"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C969235A947
	for <stable@vger.kernel.org>; Tue, 18 Nov 2025 14:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763475274; cv=none; b=oYkC1N/cIFe4pEO/SBXphto7lntITzZQTfufo2iAgDc42Lndozvq2XXFEJMBjTrxglguYCvNLqwuF+KgpXKOTypYWJeKHKB5j6AInZAPE/nMi3prdU3ZqDXRKTuG4zKHrdtIgqQ1+gR67Z/tzuecKNdzangZ/WOaFXtrmfEDo6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763475274; c=relaxed/simple;
	bh=+UUxySwa1RyOvDkLd6z2AV7HI8aMXJ+SkQT3WnPVdcg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kJZ/d5C5+qU8P5dQ5E8VTS939UgMMV1pvH5lFlhx9B4sVn5/UVSpSBXwenaBzdj29lXgfLUV2VcVkKzDeXxwPkAeRVRDmB53A3aXW1mKJlgJhEvPVtGGCDxmNoVNtvexacoy+7QhK9Qm/vwsoni0naIQ0/XQJ+9QaiUltkUj4mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gpVloc57; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=eC0zS9wv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763475271;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A8QBaAWjwS33K+uiN/IGV0CrO2a2hGtLPCcqbQK++rY=;
	b=gpVloc57ayttNji6FmzBozDMii3Brorni8dWBYbd+O11qU0zd5dZpfWL4H9pS1FMLP+iFh
	MAkFIeuOEireWXYrJOiD9MrUzmTZXhmZNBAX3iq9kHh5r7YgoRJVE3U2OtWq65nc5WL8WM
	1X8h5tDsi8QCohj6X1mqPhIWEKtmuQo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-483-vQ0QL6jINoW54MAPmBWWrA-1; Tue, 18 Nov 2025 09:14:30 -0500
X-MC-Unique: vQ0QL6jINoW54MAPmBWWrA-1
X-Mimecast-MFC-AGG-ID: vQ0QL6jINoW54MAPmBWWrA_1763475269
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-42b366a76ffso2778142f8f.1
        for <stable@vger.kernel.org>; Tue, 18 Nov 2025 06:14:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763475269; x=1764080069; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A8QBaAWjwS33K+uiN/IGV0CrO2a2hGtLPCcqbQK++rY=;
        b=eC0zS9wvuh44jxJSXvspKq4LaXjnYkKtTQO+ubmikCcqGgfmKtB9b7bGVMPy/XCkob
         XvVMXrmHla7zLhWZrRwrYL1R3E5lNtL6G7qwJ1pfaZymL79AzMgPaZ+t1/60LaUdWnI6
         67YXj/WPtsv50pCHzI4nYRkZtg7P1ZrdcRajbZjZqyftXjw7Bc1mwHL2nzaCBbNLe2XI
         c3Y6Gv5Ebx+BiznOxqR7mts3DtCBWKzc2u4G3v9Y8rS7yyFpP5RO1HcUCMKyrR75/k7l
         cx/wVxHnQ+cj1+KFzgyFi6i2l+opHP9pWlMvJL5Y7cXt0Vkr3hXXM44BnVytxONMu+H6
         DZVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763475269; x=1764080069;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A8QBaAWjwS33K+uiN/IGV0CrO2a2hGtLPCcqbQK++rY=;
        b=LrxTxQWuVr6aVSq1r+8Q8DwjK0B/h1dO0NSanqyYs582ygI0EQjITvg322+R7BD2G7
         Z4iKn2PWg9oEVKN7ZkMFHPWgrHiuyyGp8/m/vdMdDnr1K8eHJeKlCDEalNvLWuI95uJZ
         Eu+PKBqwryrU7cMXqrGSkMMe2LiaUhLSUC5xnd01D/uM9EknRMWv8cN4MO0mCWUxpe+N
         M9b9fmNPRj1JoJLFcjTkBRtUUUOrSCV5Kyeww4VMVJOVPvsceK71nKuJWIdMFRnNMRp3
         /CP5/e/IAPrL5vuow/+V6i93j3V6OnnfyvxqfqXxqmM340uHbmkuFTSZnSPKrbfHS0Oz
         sH6w==
X-Gm-Message-State: AOJu0YyaBdMX1Wxz35ubsSsAfXx+wYjyfEKNrLKA7G0xLyqssyCxGPsC
	k04mR1eca0JRnGvgd6P0kGgrena4pX1LqZj18UNVKOP40A9HKWbudcGiwVsHCJR6G1Q7Ctlx4lZ
	suYxgulZ3gjrsbyYrC0DwuIigfSig6lOURcfnr1A3YesotTUKiQ3yNliIRg==
X-Gm-Gg: ASbGncsnzWtE/YeUNR/abF2b08Zsw69+7WcUid6cu8TMd+us7BJVfnkFM4TVn/CSGfw
	YSIWZ5ey50kUqrVfMKr2sPxXknAurn3ISEtCAePzORvLcvvTCdKhTOvRIJnCmyOZgNu6zpg6TPn
	nTIi0ttRxcv8NfZvVS8Hm1vA6p+c7s91hsUUsntp2oqWSCdby7Qq8sEH7EuDzu1gtJS32azdK6I
	bJaqH1sGiDDLsYT75xh8Xdg1JJOzKxlMsPEMZfU9oc5gtkNNPd7yruq5EA/+wrQqbzKkJZrrEcM
	hAT2LGBglY5FtTf8mLDdJTcumwoN5ehn053KqbRwTGs4PDuvApTDueYoB9NQH4CeWD0pwyKO/Kn
	W+pgoCgEPPlDf
X-Received: by 2002:a5d:5d0b:0:b0:401:5ad1:682 with SMTP id ffacd0b85a97d-42b5934f412mr14497040f8f.14.1763475269206;
        Tue, 18 Nov 2025 06:14:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFcxBDQhBpTxhdB6tycDhtt6Kr4lffG9wmkpjCj8CTkRRDokxRlP+fXXhgSubRBpG5p+mTGuQ==
X-Received: by 2002:a5d:5d0b:0:b0:401:5ad1:682 with SMTP id ffacd0b85a97d-42b5934f412mr14497011f8f.14.1763475268773;
        Tue, 18 Nov 2025 06:14:28 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.41])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53f0b894sm33597770f8f.26.2025.11.18.06.14.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Nov 2025 06:14:28 -0800 (PST)
Message-ID: <1d2b2c4c-9e52-4ffb-9774-ea98521e95d5@redhat.com>
Date: Tue, 18 Nov 2025 15:14:26 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 1/1] net: dsa: microchip: lan937x: Fix RGMII delay
 tuning
To: Oleksij Rempel <o.rempel@pengutronix.de>,
 "David S. Miller" <davem@davemloft.net>, Andrew Lunn <andrew@lunn.ch>,
 Eric Dumazet <edumazet@google.com>, Florian Fainelli <f.fainelli@gmail.com>,
 Jakub Kicinski <kuba@kernel.org>, Vladimir Oltean <olteanv@gmail.com>,
 Woojung Huh <woojung.huh@microchip.com>,
 Arun Ramadoss <arun.ramadoss@microchip.com>
Cc: stable@vger.kernel.org, kernel@pengutronix.de,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 UNGLinuxDriver@microchip.com
References: <20251114090951.4057261-1-o.rempel@pengutronix.de>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251114090951.4057261-1-o.rempel@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/14/25 10:09 AM, Oleksij Rempel wrote:
> Correct RGMII delay application logic in lan937x_set_tune_adj().
> 
> The function was missing `data16 &= ~PORT_TUNE_ADJ` before setting the
> new delay value. This caused the new value to be bitwise-OR'd with the
> existing PORT_TUNE_ADJ field instead of replacing it.
> 
> For example, when setting the RGMII 2 TX delay on port 4, the
> intended TUNE_ADJUST value of 0 (RGMII_2_TX_DELAY_2NS) was
> incorrectly OR'd with the default 0x1B (from register value 0xDA3),
> leaving the delay at the wrong setting.
> 
> This patch adds the missing mask to clear the field, ensuring the
> correct delay value is written. Physical measurements on the RGMII TX
> lines confirm the fix, showing the delay changing from ~1ns (before
> change) to ~2ns.
> 
> While testing on i.MX 8MP showed this was within the platform's timing
> tolerance, it did not match the intended hardware-characterized value.
> 
> Fixes: b19ac41faa3f ("net: dsa: microchip: apply rgmii tx and rx delay in phylink mac config")
> Cc: stable@vger.kernel.org
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>

Lacking the changelog and reference to the previous submission, it took
me a little to notice that the only difference is the added Cc: tag.

Please:
- ask explicitly before going ahead with such repost, as manual tag
propagation is sometimes preferable
- always include a suitable changelog and reference to prior revisions

Thanks,

Paolo


