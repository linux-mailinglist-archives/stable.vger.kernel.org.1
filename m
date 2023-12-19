Return-Path: <stable+bounces-7956-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3FE88193C7
	for <lists+stable@lfdr.de>; Tue, 19 Dec 2023 23:46:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9343D1C24CB4
	for <lists+stable@lfdr.de>; Tue, 19 Dec 2023 22:46:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F4BD39AF3;
	Tue, 19 Dec 2023 22:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UzVyITlm"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61BDE3EA78;
	Tue, 19 Dec 2023 22:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-40c580ba223so63805065e9.3;
        Tue, 19 Dec 2023 14:46:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703025979; x=1703630779; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qg8naDClSZMfxKq9xF+hunOpmcdJyE6zAX983XcttK0=;
        b=UzVyITlmC13N8QI4H9HqA4XlR8GzyqZ7kzvVQMd/yvr6Vfh/G317S+X+WLNe0VhR+/
         LT1eaQtmWjkuruUJC/XhQU21Z5XIEBBL4IpwqnXozSIwk79HsP1WZFh0eB0lVm/Xqrnj
         tXChnRU1xPClns/0sbxXK/v5xBRnoXFc11dQydATUdo+NOOpoBNdV+dSGF0hHn+MDrI8
         EhjJWy1YQn2M7Zo+yeOTRllXf0C+tOaEWmZqkecgiLP7L3kr2Zv9G31HTjS6JyjDAyf+
         8zq/tq3klhBMpFKpNqvdCmBHZ1V/YP/HKT0Cnby9dtzfRsz74hx8Pm7tp6+VWTYPkQCG
         rrmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703025979; x=1703630779;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qg8naDClSZMfxKq9xF+hunOpmcdJyE6zAX983XcttK0=;
        b=kmV5vrpwIoAHOFD/pjNnPAWDN5dWsJY9019lt21sCj1NUOnDifWROysNmhlX1GtPd+
         77E0yw6PzRGP59H2NHKX5aTVtufNJ0YoWVRmVoZay4XgoQWQewJmxqRswF/j85QhoymB
         xbzUCuWDXcglzcTjzTUhokLd5jKs1ISQN7o0qraxwJGWwrfxq0GONBTXJUE/9Rmj3cvX
         wUn8ylO40KWBGyxnfpF8jAwTpljzKWSZ86ifiAeXrHxdix56WCp7tIuPMzT8OL/X4Gqu
         1Rc7vf8M0BinB0MdKZ5BsT1MljkPSTZuqzUGYAEiKzLk/q6jab4hSceLIrwYP2CLE3hx
         ljew==
X-Gm-Message-State: AOJu0YwU2GjhQAkywDWWtVfgPdTsBQLaN+D67nm60WcJcWIPiIk/C+cx
	UZXfIuv3YvCjz7tDbKIiFQTx/uHZV1C0Dw==
X-Google-Smtp-Source: AGHT+IGcgvfUPN5TljD09oQYCBLLUpvwhpt8PdFBlzZTpDiRyi8Oaqxf6OmPKHIRW2R0zoOHHV5cxA==
X-Received: by 2002:a05:600c:1e0c:b0:40d:1c37:c4fd with SMTP id ay12-20020a05600c1e0c00b0040d1c37c4fdmr1690636wmb.175.1703025979338;
        Tue, 19 Dec 2023 14:46:19 -0800 (PST)
Received: from skbuf ([188.27.185.68])
        by smtp.gmail.com with ESMTPSA id ll9-20020a170907190900b00a1cbb289a7csm15832885ejc.183.2023.12.19.14.46.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 14:46:19 -0800 (PST)
Date: Wed, 20 Dec 2023 00:46:16 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Romain Gantois <romain.gantois@bootlin.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Sylvain Girard <sylvain.girard@se.com>,
	Pascal EBERHARD <pascal.eberhard@se.com>,
	Richard Tresidder <rtresidd@electromag.com.au>,
	netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org
Subject: Re: [PATCH net 1/1] net: stmmac: Prevent DSA tags from breaking COE
Message-ID: <20231219224616.pw32w5eq2dbuja5i@skbuf>
References: <20231218162326.173127-1-romain.gantois@bootlin.com>
 <20231218162326.173127-2-romain.gantois@bootlin.com>
 <20231219122034.pg2djgrosa4irubh@skbuf>
 <20231219140754.7a7a8dbd@device-28.home>
 <CACRpkdaxy9u=1-rQ+f+1tb8xyV-GYOuq52xhb4_SRPk9-LpnUA@mail.gmail.com>
 <20231219172932.13f4b0c3@device-28.home>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231219172932.13f4b0c3@device-28.home>

On Tue, Dec 19, 2023 at 05:29:32PM +0100, Maxime Chevallier wrote:
> Hi Linus,
> 
> On Tue, 19 Dec 2023 15:19:45 +0100
> Linus Walleij <linus.walleij@linaro.org> wrote:
> 
> > On Tue, Dec 19, 2023 at 2:07 PM Maxime Chevallier
> > <maxime.chevallier@bootlin.com> wrote:
> > 
> > > So it looks like an acceptable solution would be something along the
> > > lines of what Linus is suggesting here :
> > >
> > > https://lore.kernel.org/netdev/20231216-new-gemini-ethernet-regression-v2-2-64c269413dfa@linaro.org/
> > >
> > > If so, maybe it's worth adding a new helper for that check ?  
> > 
> > Yeah it's a bit annoying when skb->protocol is not == ethertype of buffer.
> > 
> > I can certainly add a helper such as skb_eth_raw_ethertype()
> > to <linux/if_ether.h> that will inspect the actual ethertype in
> > skb->data.
> > 
> > It's the most straight-forward approach.
> 
> Agreed :)

If you rewrite that patch to use skb_vlan_eth_hdr() to get a struct
vlan_ethhdr pointer through which h_vlan_proto and h_vlan_encapsulated_proto
are accessible, I don't see much value in writing that helper. It is
going to beg the question how generic should it be - should it also
treat ETH_P_8021AD, should it treat nested VLANs?

At the end of the day, you are trying to cover in software the cases for
which the hardware engine can perform TX checksum offloading. That is
going to be hardware specific.

> > We could also add something like bool custom_ethertype; to
> > struct sk_buff and set that to true if the tagger adds a custom
> > ethertype. But I don't know how the network developers feel about
> > that.
> 
> I don't think this would be OK, first because sk_buff is pretty
> sensitive when it comes to cache alignment, adding things for this kind
> of use-cases isn't necessarily a good idea. Moreover, populating this
> flag isn't going to be straightforward as well. I guess some ethertype
> would be compatible with checksum engines, while other wouldn't, so
> probably what 'custom_ethertype' means will depend on the MAC driver.
> 
> From my point of view the first approach would indeed be better.

I guess we should first try to answer the questions "what does
skb->protocol represent?" and "does DSA use it correctly?" before
even thinking about adding yet another fuzzy layer on top it.

