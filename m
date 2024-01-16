Return-Path: <stable+bounces-11795-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B51D982FC6E
	for <lists+stable@lfdr.de>; Tue, 16 Jan 2024 23:20:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66F511F295DB
	for <lists+stable@lfdr.de>; Tue, 16 Jan 2024 22:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03C8428DDA;
	Tue, 16 Jan 2024 20:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ja7Z0+pF"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F9DC28DCB;
	Tue, 16 Jan 2024 20:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705438610; cv=none; b=WYk/4lHqmwZ9pfWAf4VInAJ1l2NuWYDZhWpWN+ltSFELGLcQ9RjTWAf//XrvNZhTi5rhzi8A38AWVpeF8C6AZbMO2wHWk5CYjF1tW8fPG8oGD9e/+ZH9bL1D6sAVMVMhB91DXNsZtJZQeGmfw8P0WIcHTAdVhV7NlPSq1pL0aaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705438610; c=relaxed/simple;
	bh=8CNNTT1i7VrOSC1wVxqb7zDjW/vvY/QNbaMwM5TT3rA=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:Content-Language:
	 To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding; b=trZrgOPyOLRFTX0xT3yDphqYNMKSaDYc1t+GWmUEZUfbs41wVofpWvjorQ1NZt5h0HxO7bc8hfpNQ4A4kfM2huia8FOHqyDBlWtQDQnad62iBf/06Ovwn45jScAQxaxJfC462l2wjhXPDYct5GPTvOutEThMuo810M9LITV7wtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ja7Z0+pF; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-783182d4a09so1227024385a.2;
        Tue, 16 Jan 2024 12:56:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705438608; x=1706043408; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L6sTQ65U6A8ITpkEUOdf6EqefqmO1TtLddPAd4Z4We4=;
        b=ja7Z0+pFusJOHSh4qbCafKm5qK0tR8zPi+zABJHIk0TKKrtNaMICid1el0VdXsCxF1
         A76dtTqN0FSTua4ibyMs3qnxeWFBEWOMuaAYfvtDtlBjvo6v4dmWWbZQG+X7iPWUgerK
         QXsslcxxfNHW4OW+juj4tuat51sUCe3wW0ggUKt5VWW4A5MAFwCQl6HN/Va296icErtG
         XK1Rl10p/IVu+NIHD0yMyZWL6oTNe9QR4+RaPFOTX9nAMhVhy2nW82CrXBG9+G9ALAbp
         b5Jzk2h4xgP3cNs0LXEIBshkZNgC8b1e/IoEkts7++apcbwpdoqZx3Nt2UgIE0urXdQU
         KltQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705438608; x=1706043408;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L6sTQ65U6A8ITpkEUOdf6EqefqmO1TtLddPAd4Z4We4=;
        b=THn8IJHd5SS+IAgPYTjWuw6j8+RAVBGNtg6efKhRghQJ5HE+ZpXLzfJL4P03uPgLQj
         jXQ9zguV0FF4YpWyXTw6ViFVpNW9sGeDNzELLBZg8u75Q4DJartJpjt2bl7m+cX2WAaO
         dc/tqeeSbR1h9t2Nfwx3xJYr7ikp0vHeugzy0KEAsYM102heKFm5rkOiyMda+GYSA50M
         PY4KWrJ7xRTX4jKuSthumXzn7Rsz/zylQlk9AdDLIa7pjiCY4Uov/XLjV1oKXthn8KoK
         8vun5sbLccGuyBd5yd+hWZjPK6o83gIGRgVZ4gbMBX8RZFIbOvHnL9ENxQkb3MHIn/PX
         EFQA==
X-Gm-Message-State: AOJu0Yw5hKHfxWvLLEyfFDbI6G07Urr6yRSNU4Kx5vT+5+v+UsTpTOFO
	1f3X2ntywecTlAX69b0B02w=
X-Google-Smtp-Source: AGHT+IHz0uzBk0u4ED2kfYEZ9yMEhdws58vq7kMoR1kk+FYU+sLQs6/0tij/7mi3eeld1/aht75/Cw==
X-Received: by 2002:a05:620a:29d1:b0:783:5a17:a8f6 with SMTP id s17-20020a05620a29d100b007835a17a8f6mr5689097qkp.130.1705438608045;
        Tue, 16 Jan 2024 12:56:48 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id o11-20020a05620a22cb00b00781823ddd45sm4006376qki.18.2024.01.16.12.56.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jan 2024 12:56:47 -0800 (PST)
Message-ID: <fe6452a6-2e34-4c22-b3d4-af3a4d592fdf@gmail.com>
Date: Tue, 16 Jan 2024 12:56:38 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v6] net: stmmac: Prevent DSA tags from breaking COE
Content-Language: en-US
To: Romain Gantois <romain.gantois@bootlin.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Jose Abreu <joabreu@synopsys.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Sylvain Girard <sylvain.girard@se.com>,
 Pascal EBERHARD <pascal.eberhard@se.com>,
 Richard Tresidder <rtresidd@electromag.com.au>,
 Linus Walleij <linus.walleij@linaro.org>, Vladimir Oltean
 <olteanv@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org,
 Vladimir Oltean <vladimir.oltean@nxp.com>
References: <20240116-prevent_dsa_tags-v6-1-ec44ed59744b@bootlin.com>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20240116-prevent_dsa_tags-v6-1-ec44ed59744b@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/16/24 04:19, Romain Gantois wrote:
> Some DSA tagging protocols change the EtherType field in the MAC header
> e.g.  DSA_TAG_PROTO_(DSA/EDSA/BRCM/MTK/RTL4C_A/SJA1105). On TX these tagged
> frames are ignored by the checksum offload engine and IP header checker of
> some stmmac cores.
> 
> On RX, the stmmac driver wrongly assumes that checksums have been computed
> for these tagged packets, and sets CHECKSUM_UNNECESSARY.
> 
> Add an additional check in the stmmac TX and RX hotpaths so that COE is
> deactivated for packets with ethertypes that will not trigger the COE and
> IP header checks.
> 
> Fixes: 6b2c6e4a938f ("net: stmmac: propagate feature flags to vlan")
> Cc:  <stable@vger.kernel.org>
> Reported-by: Richard Tresidder <rtresidd@electromag.com.au>
> Link: https://lore.kernel.org/netdev/e5c6c75f-2dfa-4e50-a1fb-6bf4cdb617c2@electromag.com.au/
> Reported-by: Romain Gantois <romain.gantois@bootlin.com>
> Link: https://lore.kernel.org/netdev/c57283ed-6b9b-b0e6-ee12-5655c1c54495@bootlin.com/
> Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Romain Gantois <romain.gantois@bootlin.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


