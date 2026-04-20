Return-Path: <stable+bounces-239953-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qC8xFZ9b5mkwvQEAu9opvQ
	(envelope-from <stable+bounces-239953-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 19:00:15 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C6B6F4305BB
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 19:00:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D61B1300B1B7
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 16:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4810B37AA9E;
	Mon, 20 Apr 2026 16:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lvkasz.us header.i=@lvkasz.us header.b="gSf26RAz"
X-Original-To: stable@vger.kernel.org
Received: from mail.lvkasz.us (mail.lvkasz.us [116.203.126.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1909367F48;
	Mon, 20 Apr 2026 16:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.126.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776704393; cv=none; b=aSGR3Nrjy24LaPdVvmGNH9LuQKcOzwbr/TGJuck2oQn3UQ/IN3AHsyrY3UnNI8GFVKP5mk/K3afg520TQPKtn1iYX6GQX+0kPWRVA3VimGX5GvSeudNfoQFmqevoYq0A+Jx9Ty8FU56YOHcXn2S+wI36DDAPQQckRDpFQyk/XE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776704393; c=relaxed/simple;
	bh=2IHn37+cMsbWYkDsy6cJEMCnVMxpyEd3hiZhGarHxt4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IOMWaJ+Jo3H9QQhF5SDDYMy+xfDKnslhgis66ydoEzqyNl5c9B7pzTb9cym3/bxhLqvd5/n8fGlXRQWdRB5+ChEBh2bCXk4FQartaBL79dfh1XjCFv4WZ0qnrw4IE5Jec1PqPBSSTEOF+b8CVNiW99RjXIe3ylXYnDpDHG4JiQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=lvkasz.us; spf=pass smtp.mailfrom=lvkasz.us; dkim=pass (2048-bit key) header.d=lvkasz.us header.i=@lvkasz.us header.b=gSf26RAz; arc=none smtp.client-ip=116.203.126.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=lvkasz.us
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lvkasz.us
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lvkasz.us; s=vps;
	t=1776703920; bh=2IHn37+cMsbWYkDsy6cJEMCnVMxpyEd3hiZhGarHxt4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=gSf26RAzleLxCuDaz1ZlUE6GSUTBEsw+vqGcDicob5TfGtK4hlqYFantxpgi4Q+BX
	 hNGMlh1tqvCwWF88GDM3ZZOxdhbLq2NWlN9NYEs/QFOoaQCe3XFw+w4SOYeIvSNzj+
	 tQ0M0F2EK3nrGwrqO8dQ/9Vw9OAe+jLY/PeAkrarK1qS2XQP2hBd+V7cqImsg+3gPi
	 wZJhMIP92WpYu8GLvV1ryQHld3iC9UQ9KFBEM20gch8NPkHPIvfDe2KgG+r4VdyYX/
	 PgylcGPBA3EGvcy6jEQJVWI4v/cAYbLpDxVdd9WPUFkJ6FbsNNM2xdQN5sI6m84pQJ
	 P0cmFVvrl5xzA==
Received: from [10.30.1.147] (5.185.72.109.ipv4.public.orange.pl [5.185.72.109])
	by mail.lvkasz.us (Postfix) with ESMTPSA id 36A60E061C;
	Mon, 20 Apr 2026 18:51:59 +0200 (CEST)
Message-ID: <84f4bc8a-f94d-495e-9ab2-7997798953c2@lvkasz.us>
Date: Mon, 20 Apr 2026 18:51:57 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] phy: exynos5-usbdrd: fix USB 2.0 HS PHY tuning values
 for Exynos7870
To: vkoul@kernel.org
Cc: neil.armstrong@linaro.org, krzk@kernel.org, alim.akhtar@samsung.com,
 andre.draszik@linaro.org, pritam.sutar@samsung.com, kauschluss@disroot.org,
 johan@kernel.org, ivo.ivanov.ivanov1@gmail.com,
 linux-phy@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
References: <20260406135627.234835-1-kernel@lvkasz.us>
Content-Language: en-US, pl-PL
From: =?UTF-8?B?xYF1a2FzeiBMZWJpZWR6acWEc2tp?= <kernel@lvkasz.us>
In-Reply-To: <20260406135627.234835-1-kernel@lvkasz.us>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lvkasz.us,quarantine];
	R_DKIM_ALLOW(-0.20)[lvkasz.us:s=vps];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-239953-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linaro.org,kernel.org,samsung.com,disroot.org,gmail.com,lists.infradead.org,vger.kernel.org,oss.qualcomm.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kernel@lvkasz.us,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[lvkasz.us:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[disroot.org:email,qualcomm.com:email,lvkasz.us:email,lvkasz.us:dkim,lvkasz.us:mid]
X-Rspamd-Queue-Id: C6B6F4305BB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/6/26 15:56, Łukasz Lebiedziński wrote:
> The existing PHYPARAM0 tuning values for Exynos7870 are incorrect,
> causing the USB 2.0 PHY to fail high-speed negotiation and fall back
> to full-speed (12Mbps) operation.
> 
> Fix TXVREFTUNE (transmitter voltage reference) from 14 to 3,
> TXRESTUNE (transmitter impedance) from 3 to 2, and SQRXTUNE
> (squelch threshold) from 6 to 5. Also explicitly set
> TXPREEMPPULSETUNE to 0, which was previously missing from the
> tuning table despite being included in the register mask.
> 
> All values are derived from the vendor kernel for the Samsung
> Galaxy A6 (SM-A600FN), as no public hardware documentation is
> available for the Exynos7870 USB DRD PHY. With these corrections,
> the PHY successfully negotiates high-speed (480Mbps) operation.
> 
> Fixes: 588d5d20ca8d ("phy: exynos5-usbdrd: add exynos7870 USBDRD support")
> Cc: stable@vger.kernel.org
> Tested-by: Kaustabh Chakraborty <kauschluss@disroot.org>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> Signed-off-by: Łukasz Lebiedziński <kernel@lvkasz.us>

Friendly ping.

I'd also like to mention that this patch was tested on two devices:
Samsung Galaxy A6 (SM-A600FN) by me and Samsung Galaxy J6 (SM-J600FN)
by Kaustabh Chakraborty <kauschluss@disroot.org>.


Regards,
Łukasz

