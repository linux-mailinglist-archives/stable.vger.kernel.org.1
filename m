Return-Path: <stable+bounces-244475-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oBl1CM3f+2nLGAAAu9opvQ
	(envelope-from <stable+bounces-244475-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 07 May 2026 02:41:49 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id CBB494E1C16
	for <lists+stable@lfdr.de>; Thu, 07 May 2026 02:41:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C4E2D300A300
	for <lists+stable@lfdr.de>; Thu,  7 May 2026 00:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D0651C84BC;
	Thu,  7 May 2026 00:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FfW3pE33"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B10542F87B
	for <stable@vger.kernel.org>; Thu,  7 May 2026 00:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778114503; cv=none; b=gnlNc+sosgGCt1G0RCue6kjZf2zTNMBpLXoeRgpafw+T+L478UdDqvW3G1FHhzidO6DsInKA3Ntgi4w197iBR2OKnWjIs59woJjArrkgN6UuAc84GQwboDruoemrUbH7yzhx8p1Kam6DvaK8synLKFK/AbVFEyqMk7hK7FsnKHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778114503; c=relaxed/simple;
	bh=hozVGdurQuHkwbTkTMzyhB1vqcbTrdKhKFTpfvINR2E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iELijSr2XpDIFzrzytWXhWpKyvLjHVPXzUEOIZbmJrBp/q1VIDEWQ4JrDRBjjQaJr5Ly2Dxc/X4doP7BG9dp2jVqQuhaQhbL8WLsRbbXMnnlzfsaTf8GAiz6fPtyjfyLnpbC5rqKP7+fGqCao2lQrtGrR/toJakXuo3sZRA6Bso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FfW3pE33; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-c798fc1a28cso82780a12.3
        for <stable@vger.kernel.org>; Wed, 06 May 2026 17:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778114502; x=1778719302; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hZ5LFFAZbhjlqv4fN6kLXFN2tALXchu13wJuFe3wZrI=;
        b=FfW3pE336oEhBJFu+R0/Pe+DGVlEEdsyfXU5DlZZP/iSwjmkZakdgVP9kxGMsg0X4Z
         kYtqQnZbzzT055aqahHK3hMai4D7L7PhMclrMQ8/K/JijouKoN5/vVpy+us3ySjEUmm8
         6u4Qh/7De2rLz74RGQladmd7Xc4HHoD4YuzM2bJPlSbizobSkCMMxZuRnckSc2igjlJx
         7ryyWvh96xXJVMnMKItYyjbySOiCzkMkiaD6BmsT+yzNkCo8FB/eSx7IOJqb3QIu4c8x
         rOvOsZ1AyEOhsTSnzYlqTIPhH1ONpQ7YS2R/aJJUpmfp9GZpimQ6aDmKIU+Sis2S6Wws
         UQDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778114502; x=1778719302;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hZ5LFFAZbhjlqv4fN6kLXFN2tALXchu13wJuFe3wZrI=;
        b=DqG64JKzje5beGugvNi0P7TiRtb+GkmZ/Q7m56Y1QsKZS/ii6Pv5SvPH8wFw1sGN9t
         DsE15EWm3yYcHE7PfVA99Yh1MvV/fu7VHjV9YCZ3gatTajMp6yiE5qSIjD/zPub4S+zO
         oyhPzBO2q27VyanHGVZKMBis+1dWT1KBzJ6PaG3506KvDLxFWssRbgVgQFKs25DwrNuz
         u2aD9WCKqmuckHg30KC3py8UMk44FdnN1J34A8Gel3JBvihU5joQ2cKJlentj8ECwr2S
         rJgOVQqBwQSEqbSttqRgA1rpbv6iZBSDwnnzr2zh3sgJmS6jWUjGyinDQbZWyjnwlBgl
         BZyA==
X-Forwarded-Encrypted: i=1; AFNElJ+1i3i/C+OW4jVriunxMzAt3MpMNmf+cCD6Waf2e5KsW4hffFy6z//TAFztS+IO1OuJGYxgQes=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcM7Tna/4ZQjj5xsH4AHAubjohr3D6jqwY6WLAdUCygjujLp95
	Wyur26peGr3snZZarjt2A1NRRneDa3ohk0cHWfomgD3I9wrf0B4zuOqZ
X-Gm-Gg: AeBDievJoSN7mJExBM4x6ySJy0V1RO/O6aC15tV7FQc49aPrTX8hC7B31fOAo3jjQlZ
	xyj0QNDsChInTGa5Wnd4p1RMYmbMy+ie9KrcxzxGlJQnaxsbuLz4sZeSGsoyAotOco2sQc/MgCu
	OEJ1TM+XdS5QkSAV1/4b6zANxVUQC171BP9xpmxQS40xWKenFesWZ5COVwHDk4d22j6qnMIDNdx
	F5EajD4YWLJuyC0V1QapFJr2KQQp28+fSIldFbU/R0GnfUqTAFjZ63IfyBgBPSvySYWJi7pyzml
	V2S5k7hkr819DUeg80uFMZa2fKhBb34tRkC+e7O1PV6z3q9Vtej/riph1KoKe1iMLmWl89BZM4z
	wq9oPZwEGawR4DBBpAY/Jv4gVcmpUKakvtqvCrghGJtNn9ASN+5FcejMUpwmmIBy6cFYAyV/Rrk
	ZFWJq09bmpv3zHJdWxFUBVsBVOd1WjZOZ7cg==
X-Received: by 2002:a05:6a20:431e:b0:3a8:284c:fa3b with SMTP id adf61e73a8af0-3aa5ac98bc1mr5493704637.48.1778114501965;
        Wed, 06 May 2026 17:41:41 -0700 (PDT)
Received: from localhost ([2001:19f0:8001:1b2d:5400:5ff:fefa:a95d])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c8253582a60sm370848a12.1.2026.05.06.17.41.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 17:41:41 -0700 (PDT)
Date: Thu, 7 May 2026 08:41:23 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Lukas Wunner <lukas@wunner.de>, 
	Icenowy Zheng <zhengxingda@iscas.ac.cn>
Cc: Manivannan Sadhasivam <mani@kernel.org>, Han Gao <gaohan@iscas.ac.cn>, 
	Bjorn Helgaas <bhelgaas@google.com>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
	Jonathan Cameron <jonathan.cameron@huawei.com>, Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, 
	Kees Cook <kees@kernel.org>, Chen Wang <unicorn_wang@outlook.com>, linux-pci@vger.kernel.org, 
	sophgo@lists.linux.dev, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	Han Gao <rabenda.cn@gmail.com>, Inochi Amaoto <inochiama@gmail.com>, 
	Vivian Wang <wangruikang@iscas.ac.cn>, Yao Zi <me@ziyao.cc>, stable@vger.kernel.org
Subject: Re: [PATCH 2/2] PCI: Add quirk to disable PCIe port services on
 Sophgo SG2042
Message-ID: <afveQQI-CsQ2L1-N@inochi.infowork>
References: <20260331175658.1015829-1-gaohan@iscas.ac.cn>
 <20260331175658.1015829-3-gaohan@iscas.ac.cn>
 <q6wmn67lzk5c2pgmgkoezcvy3xj3yqecg675gx7xyrw3amjwpi@5pjla6j3krbv>
 <0f42afefd9322779af5463b696c55b08d2296ea8.camel@iscas.ac.cn>
 <afZUxYhkCQ0wG0Uu@wunner.de>
 <68d4a49bf1df785ae906fbc2dd16e64b667ca5f0.camel@iscas.ac.cn>
 <afcMtlBJYeuxSqZr@wunner.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afcMtlBJYeuxSqZr@wunner.de>
X-Rspamd-Queue-Id: CBB494E1C16
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244475-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,iscas.ac.cn,google.com,baylibre.com,huawei.com,linux.intel.com,outlook.com,vger.kernel.org,lists.linux.dev,lists.infradead.org,gmail.com,ziyao.cc];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[inochiama@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,farlepet.github.io:url,inochi.infowork:mid]
X-Rspamd-Action: no action

On Sun, May 03, 2026 at 10:52:06AM +0200, Lukas Wunner wrote:
> On Sun, May 03, 2026 at 03:10:58PM +0800, Icenowy Zheng wrote:
> > It's used in multiple products, but only one of them (EVBv1, which is
> > just an early EVB available for a few people including me) lacks an
> > onboard switch, because SG2042 is short on on-chip peripherals. All
> > other devices (including two mainlined ones, EVBv2 and Milk-V Pioneer,
> > and unmainlined dual socket rack servers; Milk-V Pioneer should be the
> > most popular device because it was on shelf) have an onboard switch to
> > mitigate the lack of on-chip peripherals in SG2042.
> 
> Who knows, maybe someone will design a product which doesn't attach
> a PCIe switch to the SoC, maybe the lack of peripherals isn't a
> problem for them.
> 
> It seems reasonable to accommodate such non-switch use cases as well,
> so I think you definitely do not want to quirk all products using that
> SoC but only those that need it, regardless whether it's the majority.
> 

I think it is possible to quirk all the SG2042 products, because the
typical usage already shows MSI shortage (And this is why SG2044 has
512 MSIs). Although it may left some MSIs in the test case, MSI shortage
is a common issue in a real scenario. And the Sophgo already maintains
a whitelist to limit the MSI usage of most devices in their vendor
kernel. So I think it is fine to quirk all the products that use SG2042.

Regards,
Inochi

> > > My point is, you want to constrain this to a specific product, not to
> > > the SoC.  Can you maybe solve this by not specifying interrupts in
> > > the devicetree for the PCIe switch?
> > 
> > The PCIe switches are not described in the device tree at all, because
> > they're all just discoverable; can we describe them in the DT and
> > redirect their interrupts to void?
> 
> Yes, somebody did a writeup how to represent switches and endpoints
> in the devicetree:
> 
> https://farlepet.github.io/linux/2024/02/20/using-linux-device-tree-with-pcie-devices.html
> 
> And then I would try providing an empty "interrupts" property for
> those switch ports for which you want to avoid port services being
> instantiated.
> 
> That way you could selectively *enable* port services for specific
> ports where it's useful.  Let's say you need DPC on a specific port
> to contain errors of an attached NVMe drive.  Just assign a single
> MSI for that port and assign no MSIs for all the others.  Much more
> flexible than globally disabling port services.
> 
> Thanks,
> 
> Lukas

