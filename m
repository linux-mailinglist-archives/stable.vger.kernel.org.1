Return-Path: <stable+bounces-9616-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21059823635
	for <lists+stable@lfdr.de>; Wed,  3 Jan 2024 21:10:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21B0E1C21270
	for <lists+stable@lfdr.de>; Wed,  3 Jan 2024 20:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68B7A1CFBC;
	Wed,  3 Jan 2024 20:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gdek/Ne9"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91EC81CFAE;
	Wed,  3 Jan 2024 20:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a28a6cef709so89236366b.1;
        Wed, 03 Jan 2024 12:10:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704312624; x=1704917424; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TEWitAjG0rxRY6xuTFfAPPp0IKF7z0xEqu0WIKnmO8Q=;
        b=gdek/Ne9CbSpZKDeNGx24BmJaELtqec75e5nQFocF52D1imFgjDDT5xRsJWcFGPJ21
         q2coGfghaDihOQWwclwR38KlOchHFeXOiSB+Oz4K4o+RCYozzGhW8ZeHewr4EifYOjk+
         NL/++oiHk3Hv1SRtEWSQ2t7XfRsQgo18UPWMRhme1fxfY4j4vL/38w242+nyOFpjGyvm
         yljEPB6L9HDoC/63CSSA9r4UOhSGxISEjEM++vRqte7fRkMOjHbT6RwPB0KohsZUNpJI
         q5+obubxMq4A/kfKLUcejHsMZezmaXwrlLHASwBCIGYutRmQQ1O6J27gIl8fRc3FmVrB
         XaKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704312624; x=1704917424;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TEWitAjG0rxRY6xuTFfAPPp0IKF7z0xEqu0WIKnmO8Q=;
        b=gLEBmFHfqLyhXO+0DBhvLgAI0AffKM5cEfCgx1Nr0Hu29TJlnkRGF0EwYJZilCRsx9
         NBPRSxiTDxJlYNzjV+sT35SAScLHeMZgLVvSiphlOipUBLt5/WLXfX0cpAw+jkM8r1SC
         ep/Dofix5MLHYHojl0FZcNU5mZSNz0oFsu+2hblj0Wsv/Jo37icF8MSQemBMBobnx0s1
         bQdsCOCNU3eGh3JcsQHwhFbr8qfXvoJGvZZWo5wHlJqDhgZ0iJvpVqoXS6ym3+srFh2b
         9vtcvs7ykC9yJebVremqQtfJrspVGUHr3OsHjd/arO9vsYYc6t62l34HUBWrtQ0AzAqn
         d4HQ==
X-Gm-Message-State: AOJu0YxB2AfCOjXooMMeEqBeZQSD3x5x5/86sniaIC7TRokRZNRbKb74
	1rEIDC/5PFdalM0K2dpOblQ=
X-Google-Smtp-Source: AGHT+IGJGoQUOiSvT4Z+HaGOUOb+1C6AsGCUQxkqJHEOh2dvB4IyhyPYb3StWVhA73AfEXnqgJITYg==
X-Received: by 2002:a17:906:1db:b0:a26:8c3a:5133 with SMTP id 27-20020a17090601db00b00a268c3a5133mr7854783ejj.99.1704312623657;
        Wed, 03 Jan 2024 12:10:23 -0800 (PST)
Received: from skbuf ([188.25.255.36])
        by smtp.gmail.com with ESMTPSA id vp23-20020a17090712d700b00a27e4d34455sm3625721ejb.183.2024.01.03.12.10.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 12:10:23 -0800 (PST)
Date: Wed, 3 Jan 2024 22:10:21 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Romain Gantois <romain.gantois@bootlin.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Sylvain Girard <sylvain.girard@se.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Pascal EBERHARD <pascal.eberhard@se.com>,
	Richard Tresidder <rtresidd@electromag.com.au>,
	Linus Walleij <linus.walleij@linaro.org>, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org
Subject: Re: [PATCH net v2 1/1] net: stmmac: Prevent DSA tags from breaking
 COE on stmmac
Message-ID: <20240103201021.2ixxndfqe622afnf@skbuf>
References: <20240102162718.268271-1-romain.gantois@bootlin.com>
 <20240102162718.268271-1-romain.gantois@bootlin.com>
 <20240102162718.268271-2-romain.gantois@bootlin.com>
 <20240102162718.268271-2-romain.gantois@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240102162718.268271-2-romain.gantois@bootlin.com>
 <20240102162718.268271-2-romain.gantois@bootlin.com>

On Tue, Jan 02, 2024 at 05:27:15PM +0100, Romain Gantois wrote:
> +/* Check if ethertype will trigger IP
> + * header checks/COE in hardware
> + */
> +static inline bool stmmac_has_ip_ethertype(struct sk_buff *skb)
> +{
> +	__be16 proto = eth_header_parse_protocol(skb);
> +
> +	return (proto == htons(ETH_P_IP)) || (proto == htons(ETH_P_IPV6)) ||
> +		(proto == htons(ETH_P_8021Q));

proto == htons(ETH_P_8021Q) means that the skb has an IP EtherType?
What if an IP header does not follow after the VLAN header?

> +}

