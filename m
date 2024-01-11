Return-Path: <stable+bounces-10505-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0BA182ADEA
	for <lists+stable@lfdr.de>; Thu, 11 Jan 2024 12:51:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C6F3289357
	for <lists+stable@lfdr.de>; Thu, 11 Jan 2024 11:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C758515AE3;
	Thu, 11 Jan 2024 11:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JU1xmeoX"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3398B15ADA
	for <stable@vger.kernel.org>; Thu, 11 Jan 2024 11:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704973792;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=O339ytT7WQS/mz6ThBsLjHwMM27x0AHZpuQTCAvJmKc=;
	b=JU1xmeoXbSffPhtNwXq5GjFE/TmIiPVGF8GgqlTd7a+WWIFLyG9xCT73GWJaizZx583HVu
	dkwd91C1KNUZeJJ5SgqPLUd0QxeTKttzL3R5fUNET60jErEojAJ1PQKOCdo+7KheKYMPpl
	J/O0ZbtoIlRILLhks6thAHTuBNz2SDE=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-QU_xmcwpPiibkFownV3a1g-1; Thu, 11 Jan 2024 06:49:51 -0500
X-MC-Unique: QU_xmcwpPiibkFownV3a1g-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-50e743156d0so938750e87.1
        for <stable@vger.kernel.org>; Thu, 11 Jan 2024 03:49:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704973790; x=1705578590;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O339ytT7WQS/mz6ThBsLjHwMM27x0AHZpuQTCAvJmKc=;
        b=sRoLXvDWwFH5wBch83Nx1QB0oeiJs+pY0mm5nIAUjuXbnEyXyFCArjpiYnCUGrFfeR
         GlBnqnoBebgfEXRrJ1uhqIUy/auXtPB9+KZfXm1BtoGfdN5JmGS/KyYExk7uvpciGn5f
         0Qstw8XuXaBmKRHFqlrWgl2dLsPrVDf3yTc0/6PMVolynFDNftijZcm1XBiXI8zTCl2Z
         jYa0icxSrMgo/d6n6XjH1K+wTZNg5plnJOTmLWIPAuzAINJNKgoO7qveDw4J57UWQgEu
         WH1tvGyH8MAC8mX1DEB2FiPsPhZsi6aqcwmYdq9MwjjlvyOTKpZyfA3IIYBGq82A00bQ
         iwdQ==
X-Gm-Message-State: AOJu0YyVn7MMhfWXqgdYZ8Hz+BIEMhWCel9DsQGxCqcu2G5rRJI85FJG
	NIy3Aa5jQ7OybESxQ9AS640obrbYNSNlR5BXiKGpHbrTlj9rONY5fApacjFiTeWxLjOf7SXB+Rw
	lePepZt3ODR68M/owvCny1hbP
X-Received: by 2002:ac2:4da4:0:b0:50e:7f87:f5aa with SMTP id h4-20020ac24da4000000b0050e7f87f5aamr928946lfe.3.1704973790121;
        Thu, 11 Jan 2024 03:49:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFI378QhuYp2UQudVWK3AP6tcwFcz+mTcKeZe04t5CZGv6IoqWyHL06T+sf9NMZGGkUSzcOKA==
X-Received: by 2002:ac2:4da4:0:b0:50e:7f87:f5aa with SMTP id h4-20020ac24da4000000b0050e7f87f5aamr928923lfe.3.1704973789743;
        Thu, 11 Jan 2024 03:49:49 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-244-191.dyn.eolo.it. [146.241.244.191])
        by smtp.gmail.com with ESMTPSA id a22-20020a05600c349600b0040d83ab2ecdsm1699415wmq.21.2024.01.11.03.49.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jan 2024 03:49:49 -0800 (PST)
Message-ID: <99289be4aa940932acbf728ba6a926c67eb5484a.camel@redhat.com>
Subject: Re: [PATCH v4] net: stmmac: Prevent DSA tags from breaking COE
From: Paolo Abeni <pabeni@redhat.com>
To: Romain Gantois <romain.gantois@bootlin.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>, Miquel Raynal
 <miquel.raynal@bootlin.com>, Maxime Chevallier
 <maxime.chevallier@bootlin.com>,  Sylvain Girard <sylvain.girard@se.com>,
 Pascal EBERHARD <pascal.eberhard@se.com>, Richard Tresidder
 <rtresidd@electromag.com.au>, Linus Walleij <linus.walleij@linaro.org>, 
 Vladimir Oltean <olteanv@gmail.com>, Andrew Lunn <andrew@lunn.ch>, Thomas
 Petazzoni <thomas.petazzoni@bootlin.com>,  netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org, Vladimir
 Oltean <vladimir.oltean@nxp.com>
Date: Thu, 11 Jan 2024 12:49:47 +0100
In-Reply-To: <20240109-prevent_dsa_tags-v4-1-f888771fa2f6@bootlin.com>
References: <20240109-prevent_dsa_tags-v4-1-f888771fa2f6@bootlin.com>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.2 (3.50.2-1.fc39) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-01-09 at 15:42 +0100, Romain Gantois wrote:
> Some DSA tagging protocols change the EtherType field in the MAC header
> e.g.  DSA_TAG_PROTO_(DSA/EDSA/BRCM/MTK/RTL4C_A/SJA1105). On TX these tagg=
ed
> frames are ignored by the checksum offload engine and IP header checker o=
f
> some stmmac cores.
>=20
> On RX, the stmmac driver wrongly assumes that checksums have been compute=
d
> for these tagged packets, and sets CHECKSUM_UNNECESSARY.
>=20
> Add an additional check in the stmmac TX and RX hotpaths so that COE is
> deactivated for packets with ethertypes that will not trigger the COE and
> IP header checks.
>=20
> Fixes: 6b2c6e4a938f ("net: stmmac: propagate feature flags to vlan")
> Cc:  <stable@vger.kernel.org>
> Reported-by: Richard Tresidder <rtresidd@electromag.com.au>
> Link: https://lore.kernel.org/netdev/e5c6c75f-2dfa-4e50-a1fb-6bf4cdb617c2=
@electromag.com.au/
> Reported-by: Romain Gantois <romain.gantois@bootlin.com>
> Link: https://lore.kernel.org/netdev/c57283ed-6b9b-b0e6-ee12-5655c1c54495=
@bootlin.com/
> Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> Signed-off-by: Romain Gantois <romain.gantois@bootlin.com>

Unfortunately, you dropped the target tree tag ('net') from the
subject, and did not allow our CI to trigger properly.

Since we can't merge this patch ATM ('net' is currently frozen since we
merge back the net-next PR), I think it's better if you resubmit with a
proper tag. You can retain all Vladimir Rb tag.

Cheers,

Paolo


