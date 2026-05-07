Return-Path: <stable+bounces-244535-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KLZPDuBS/GlOOAAAu9opvQ
	(envelope-from <stable+bounces-244535-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 07 May 2026 10:52:48 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D3D824E5281
	for <lists+stable@lfdr.de>; Thu, 07 May 2026 10:52:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1DD8D300748B
	for <lists+stable@lfdr.de>; Thu,  7 May 2026 08:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C994D39C645;
	Thu,  7 May 2026 08:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DyfjQvl0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9057340A6A;
	Thu,  7 May 2026 08:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778143958; cv=none; b=g6ioqgGlE0Lm5FRCYddTzbu6cgETLyqs3ntsp0d26+REkFvfxl3X7AeJHxQ/F7mJkEzLpodMHvuSnFD9VGGm9rECMVtfoOVRwpr/ulwuo9n0lom9TwuYMehwKbYRHv3PyALIK5Gr6EhrJl1Ptas4G30L+IzLAZ389T+zwfBT30k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778143958; c=relaxed/simple;
	bh=e2KUBzxwA3gtOemcz+CllnnM9kBcLQ+NeToRBmvqxJw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E5SsBd0SPwnWj5Ipe2Y0OkrGZM9v4rd0O4F29GX94cd7wZ+V48ZCqYo08g+vv8gdvNfQp3fs1bL9zEUUCyP7b7GTGAKjTBrCmZVPC4yiHEZ5y39Ry+iv6Gi7L5h6ji6zDG/Z61d6okps5xaqW9StSeWJildFPfuGqCCfqHN0GY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DyfjQvl0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8D18C2BCB2;
	Thu,  7 May 2026 08:52:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778143958;
	bh=e2KUBzxwA3gtOemcz+CllnnM9kBcLQ+NeToRBmvqxJw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DyfjQvl0OFDtLsJMtcOX4gRAOKpz3gYKE1lcWfQuti3f0wwiRd+58C4XXmi4yKJYY
	 8xySrStcmoAWhSiITh0Nc8J8JHW+KK98c5c+1rbZHLu3TpLwjIwvuPDXRThNBg8lbU
	 tKo75ABwT0P8No3ghKUFJ8WzyTUhwc2uSX1W76n2krgEfyLpvCdupG1G9Nmg6Q9EX4
	 F7PYiM8qW+lzXIVlsN6WIjICPsbxmvbICo6Lakhzoz/WP0USd6MsWdx/1YSVmOOwdZ
	 C8Dz67PhQ4UGsG6jGyI9xtGSMVCHi2lo3sLlpHYKDv8Wc/1pZl5r7sgdfrUb9cNx2n
	 o/Sfi306SjVEw==
Date: Thu, 7 May 2026 14:22:25 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Inochi Amaoto <inochiama@gmail.com>
Cc: Lukas Wunner <lukas@wunner.de>, 
	Icenowy Zheng <zhengxingda@iscas.ac.cn>, Han Gao <gaohan@iscas.ac.cn>, 
	Bjorn Helgaas <bhelgaas@google.com>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
	Jonathan Cameron <jonathan.cameron@huawei.com>, Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, 
	Kees Cook <kees@kernel.org>, Chen Wang <unicorn_wang@outlook.com>, linux-pci@vger.kernel.org, 
	sophgo@lists.linux.dev, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	Han Gao <rabenda.cn@gmail.com>, Vivian Wang <wangruikang@iscas.ac.cn>, Yao Zi <me@ziyao.cc>, 
	stable@vger.kernel.org
Subject: Re: [PATCH 2/2] PCI: Add quirk to disable PCIe port services on
 Sophgo SG2042
Message-ID: <wy4voivjmaekmevp6upwo2roooskfd7kughnxir7opzv3px4jx@h42kmtsjsoex>
References: <20260331175658.1015829-1-gaohan@iscas.ac.cn>
 <20260331175658.1015829-3-gaohan@iscas.ac.cn>
 <q6wmn67lzk5c2pgmgkoezcvy3xj3yqecg675gx7xyrw3amjwpi@5pjla6j3krbv>
 <0f42afefd9322779af5463b696c55b08d2296ea8.camel@iscas.ac.cn>
 <afZUxYhkCQ0wG0Uu@wunner.de>
 <68d4a49bf1df785ae906fbc2dd16e64b667ca5f0.camel@iscas.ac.cn>
 <afcMtlBJYeuxSqZr@wunner.de>
 <afveQQI-CsQ2L1-N@inochi.infowork>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <afveQQI-CsQ2L1-N@inochi.infowork>
X-Rspamd-Queue-Id: D3D824E5281
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-244535-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[wunner.de,iscas.ac.cn,google.com,baylibre.com,huawei.com,linux.intel.com,kernel.org,outlook.com,vger.kernel.org,lists.linux.dev,lists.infradead.org,gmail.com,ziyao.cc];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mani@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On Thu, May 07, 2026 at 08:41:23AM +0800, Inochi Amaoto wrote:
> On Sun, May 03, 2026 at 10:52:06AM +0200, Lukas Wunner wrote:
> > On Sun, May 03, 2026 at 03:10:58PM +0800, Icenowy Zheng wrote:
> > > It's used in multiple products, but only one of them (EVBv1, which is
> > > just an early EVB available for a few people including me) lacks an
> > > onboard switch, because SG2042 is short on on-chip peripherals. All
> > > other devices (including two mainlined ones, EVBv2 and Milk-V Pioneer,
> > > and unmainlined dual socket rack servers; Milk-V Pioneer should be the
> > > most popular device because it was on shelf) have an onboard switch to
> > > mitigate the lack of on-chip peripherals in SG2042.
> > 
> > Who knows, maybe someone will design a product which doesn't attach
> > a PCIe switch to the SoC, maybe the lack of peripherals isn't a
> > problem for them.
> > 
> > It seems reasonable to accommodate such non-switch use cases as well,
> > so I think you definitely do not want to quirk all products using that
> > SoC but only those that need it, regardless whether it's the majority.
> > 
> 
> I think it is possible to quirk all the SG2042 products, because the
> typical usage already shows MSI shortage (And this is why SG2044 has
> 512 MSIs). Although it may left some MSIs in the test case, MSI shortage
> is a common issue in a real scenario. And the Sophgo already maintains
> a whitelist to limit the MSI usage of most devices in their vendor
> kernel. So I think it is fine to quirk all the products that use SG2042.
> 

I'm not too sure about quirk. We usually add quirks to workaround the hardware
issues. But what you are seeing is a platform limitation, which is a common
scenario. So adding a cmdline param would help other platforms as well (without
any more code changes).

- Mani

-- 
மணிவண்ணன் சதாசிவம்

