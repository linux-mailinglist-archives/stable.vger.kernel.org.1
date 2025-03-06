Return-Path: <stable+bounces-121201-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4143A546B9
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 10:43:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90F8D3B25B7
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 09:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5675F20A5DC;
	Thu,  6 Mar 2025 09:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gMcrM5eS"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65FB0209F57
	for <stable@vger.kernel.org>; Thu,  6 Mar 2025 09:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741254208; cv=none; b=KdoQqaKK6ahjjSwH0G287EOpXnWRELUJ2sEBbGfoFpI2ssNKomj7hKhCrcIgHAqBdR9ID02pKiGU4ijQGJp/HJuSIGgThy9ugTy51kdNQUULZdA+P1mDcnqodLUAqxFiPxNVZwzsLXlWqvmRe61NNT1JdHHd8bnkD8/CBxH2SKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741254208; c=relaxed/simple;
	bh=ij6pw+xGtu8hU4opSEKUyYQbYkETiMrkgi1ZrVOSFIA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n36zSW9mv3HXOJ9GUoR8AjeuULnXGXtVFv/XscB+psED59MaGSyadUCN9knh294fplLe22BrkipF9YBOoSSFZ3pE4Nx/PHelIrvDqIgve63UOpY2cBPGTrdjUc6ACMuTZ8BdIBxfvSwNCTetqMk2p7VAZrbc5KZnA802i/4SroY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gMcrM5eS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741254205;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XX3dakY8scOT7Ne2j8d44b9U4MvBllULAE0kKWIQm8s=;
	b=gMcrM5eSJlyr7/ocMVePdC0Zk2xP04hLyXI8Hok1W+x+1ZryHIZnZIsilpdYVmAuaBglKu
	YlgJXDfmi+1ai/+MQByuNl9sy1aV/7+TuGW0rpjvwhAXPuYXiMtdG8BAvIjT5mkuO92R94
	uGyUgn8kowpEvqbTIr5OO6ZIrvNmV0g=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-211-WDFvM2yANGiKl1nN5xhq7g-1; Thu, 06 Mar 2025 04:43:13 -0500
X-MC-Unique: WDFvM2yANGiKl1nN5xhq7g-1
X-Mimecast-MFC-AGG-ID: WDFvM2yANGiKl1nN5xhq7g_1741254191
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-390f365274dso222992f8f.0
        for <stable@vger.kernel.org>; Thu, 06 Mar 2025 01:43:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741254191; x=1741858991;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XX3dakY8scOT7Ne2j8d44b9U4MvBllULAE0kKWIQm8s=;
        b=Yzg4Nq/Rx7W3xXvDkUD+Pe2qtz1NI1xRJwsr+BiieNy6EVBW5K5VKk7q+3cMXapmDJ
         M/YvYu3i2qRDBfzliz47AWnGSMh9OjgPDQlKn9kKlh2mHb9ef9yD1xSDPNEn8u+hVL4u
         m66QnhIHoiURKzrSiJntk3ZWwWmK8Fw7wZbhwTM2jwCyNxEKgxcfaVvIay5TgUvK5az4
         SgOhPhIkDFAqgPcoc1dsGrOGKxHYVX2e7IT/hGGyGAuEuXTWTGm0HrnvFx72Em/FZvSL
         sFXIjEVVnda1j6VZgvRGFfui4Uy/czF1KuGdg1wNNrQtsnb5z03N+1hdPS0d235p2D89
         3GYQ==
X-Forwarded-Encrypted: i=1; AJvYcCW32/yabju6LmLOO+8w1Dia2ZMqHIyDNoKSFqfkK6Vfk8gPhH0ylY1X6fTfvAhrfyIdfnCgZZQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzuf3cTASPDQDyK8l//wA75Y5ToWP3V8io0MNirFkUMu8r3XGcM
	QxQYzwyh3cP5Teovz1vHZN6YRUc0hNP6ysBEApVb00BGR2JqqiJ3exSUQWO5Asf3I70xBmipiaj
	dgto+EZcKJDx3gdIir+JPbZxeie4Zxtmo28HyIAR/MI34/e70KPv7xQ==
X-Gm-Gg: ASbGncvfYa1Llv5IL72cSjo3HbQjy/NIXrY7bU4Y2h41HR1nVt5w9r+JGDRSLJhLIij
	3ifwteR9cRIbmRkntURbnOdS3nFNQFcLq3s2G5TMzPHvu6d1317GztO5bZPoxDJ2Na2yyftuK6N
	XjssiQVolTeGXLTcU1F9VOA9Olj5mA+tdgxCPUExp81Nk1EhE632yf/lTF6lZfaRMHR9qXq4PZy
	s+POnYQtx9r6XC0r+HL31bNK/TZe2CLKbuFa02b/tzA/Ahn7SoIRG6xu08tiHBTs2jgYvkF/BqG
	hqMaeLta+amBPPITJ62mZszmVIaFIGGZAwt8YdBFqd//yw==
X-Received: by 2002:a05:6000:1888:b0:391:b93:c971 with SMTP id ffacd0b85a97d-3912982e94amr1698923f8f.20.1741254191197;
        Thu, 06 Mar 2025 01:43:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGuWB1xxLyGYJud3m2Orc+jQD9bwgMtC8fEkj+pgDtO5dg4XKxw8lCcj7dXngVsWSVLL5GgjQ==
X-Received: by 2002:a05:6000:1888:b0:391:b93:c971 with SMTP id ffacd0b85a97d-3912982e94amr1698907f8f.20.1741254190790;
        Thu, 06 Mar 2025 01:43:10 -0800 (PST)
Received: from [192.168.88.253] (146-241-81-153.dyn.eolo.it. [146.241.81.153])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912bfdfde7sm1507615f8f.32.2025.03.06.01.43.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Mar 2025 01:43:10 -0800 (PST)
Message-ID: <7c14179c-0262-47e5-a13e-a53c2061da9b@redhat.com>
Date: Thu, 6 Mar 2025 10:43:09 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 1/2] net: phy: nxp-c45-tja11xx: add TJA112X PHY
 configuration errata
To: Andrei Botila <andrei.botila@oss.nxp.com>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, s32@nxp.com,
 Christophe Lizzi <clizzi@redhat.com>, Alberto Ruiz <aruizrui@redhat.com>,
 Enric Balletbo <eballetb@redhat.com>, stable@vger.kernel.org
References: <20250304160619.181046-1-andrei.botila@oss.nxp.com>
 <20250304160619.181046-2-andrei.botila@oss.nxp.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250304160619.181046-2-andrei.botila@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 3/4/25 5:06 PM, Andrei Botila wrote:
> diff --git a/drivers/net/phy/nxp-c45-tja11xx.c b/drivers/net/phy/nxp-c45-tja11xx.c
> index 34231b5b9175..709d6c9f7cba 100644
> --- a/drivers/net/phy/nxp-c45-tja11xx.c
> +++ b/drivers/net/phy/nxp-c45-tja11xx.c
> @@ -22,6 +22,11 @@
>  #define PHY_ID_TJA_1103			0x001BB010
>  #define PHY_ID_TJA_1120			0x001BB031
>  
> +#define VEND1_DEVICE_ID3		0x0004
> +#define TJA1120_DEV_ID3_SILICON_VERSION	GENMASK(15, 12)
> +#define TJA1120_DEV_ID3_SAMPLE_TYPE	GENMASK(11, 8)
> +#define DEVICE_ID3_SAMPLE_TYPE_R	0x9
> +
>  #define VEND1_DEVICE_CONTROL		0x0040
>  #define DEVICE_CONTROL_RESET		BIT(15)
>  #define DEVICE_CONTROL_CONFIG_GLOBAL_EN	BIT(14)
> @@ -1593,6 +1598,50 @@ static int nxp_c45_set_phy_mode(struct phy_device *phydev)
>  	return 0;
>  }
>  
> +/* Errata: ES_TJA1120 and ES_TJA1121 Rev. 1.0 — 28 November 2024 Section 3.1 */
> +static void nxp_c45_tja1120_errata(struct phy_device *phydev)
> +{
> +	int silicon_version, sample_type;
> +	bool macsec_ability;
> +	int phy_abilities;
> +	int ret = 0;
> +
> +	ret = phy_read_mmd(phydev, MDIO_MMD_VEND1, VEND1_DEVICE_ID3);
> +	if (ret < 0)
> +		return;
> +
> +	sample_type = FIELD_GET(TJA1120_DEV_ID3_SAMPLE_TYPE, ret);
> +	if (sample_type != DEVICE_ID3_SAMPLE_TYPE_R)
> +		return;
> +
> +	silicon_version = FIELD_GET(TJA1120_DEV_ID3_SILICON_VERSION, ret);
> +
> +	phy_abilities = phy_read_mmd(phydev, MDIO_MMD_VEND1,
> +				     VEND1_PORT_ABILITIES);
> +	macsec_ability = !!(phy_abilities & MACSEC_ABILITY);
> +	if ((!macsec_ability && silicon_version == 2) ||
> +	    (macsec_ability && silicon_version == 1)) {
> +		/* TJA1120/TJA1121 PHY configuration errata workaround.
> +		 * Apply PHY writes sequence before link up.
> +		 */
> +		if (!macsec_ability) {
> +			phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x01F8, 0x4b95);
> +			phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x01F9, 0xf3cd);
> +		} else {
> +			phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x01F8, 0x89c7);
> +			phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x01F9, 0x0893);
> +		}
> +
> +		phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x0476, 0x58a0);
> +
> +		phy_write_mmd(phydev, MDIO_MMD_PMAPMD, 0x8921, 0xa3a);
> +		phy_write_mmd(phydev, MDIO_MMD_PMAPMD, 0x89F1, 0x16c1);
> +
> +		phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x01F8, 0x0);
> +		phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x01F9, 0x0);

Please add macro with meaningful names for all the magic numbers used
above, thanks!

Paolo


