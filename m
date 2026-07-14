Return-Path: <stable+bounces-274587-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4fYHHaSzVmpxAQEAu9opvQ
	(envelope-from <stable+bounces-274587-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Jul 2026 00:09:40 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F017175924D
	for <lists+stable@lfdr.de>; Wed, 15 Jul 2026 00:09:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="FTBr/yfG";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-274587-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-274587-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E40E63019168
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 22:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D61F418A46;
	Tue, 14 Jul 2026 22:09:38 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CADC3A641B;
	Tue, 14 Jul 2026 22:09:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784066978; cv=none; b=ihnHmIrpqjmxT0dCh0euMVP23tFqvjaj1hyIj8mPHUFWy/Tp8H7ov6cdygC2X3wkLw4OqAGARSCAujMExsyvrezjvFkRNaKI9pv00QNzylM6B2sNusL45v7ANDUkCwg60NVFfoydZbR+0X9QPim2gyU//gkVs9i3zgknY7h0X4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784066978; c=relaxed/simple;
	bh=dmt/fGiX6on1rUYOUz/R4Sla5mRk7czJAkpAHmUN6i4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BLMuovqt/D8v8VliYSpqQkAB2zEO9wmy4UhE2ep/TyPeCR0FuEZghm74jJ7BzdllbMFVwHqveb5GndSKmd7AYG9QikpxLtANBrsO1kPb94Yvlm2WMSNzNUbSDxy8BJxI0rZNLqf0Co5D6vhSpiFba+QXdoHxXS9h9P0YerZ++2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FTBr/yfG; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E20201F000E9;
	Tue, 14 Jul 2026 22:09:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784066976;
	bh=wxvsj6q5kv46vdKE+rJesB3/rgThH7otn1mWolRYdcc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FTBr/yfGvOtUsR788S9vygjJNjiAUVxeXnC25KDhcmlKsX9lnydoKTIg2KsirLheV
	 18FG2TCNMOZ96EGcM8/dDbMs0Oie5X7lvqPmqWRuSkV2M0MSJ7FH1DZmnsGzBnyvLQ
	 tQOcpdKZhLNyFXfDpJosBQ9bZPwfoN/qcy4orzs+UGMVOvNIqqvfe2m71p/mMJL+rV
	 L08+xhIyossHxPlX1QkcWcPjk+aLoCVMkKWK8Bd0pdqmYb9G68aeCCj3J3BZtMHVmR
	 NNtYCoHu/X5aBIP/n2p1FoFqHVkLXzTPlds13tvcTA8z5VqPFU6273AE5RIVLtr/Ct
	 cHeI0676htQaw==
Date: Wed, 15 Jul 2026 00:09:33 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Xuanqiang Luo <xuanqiang.luo@linux.dev>
Cc: linux-i2c@vger.kernel.org, kblaiech@nvidia.com, asmaa@nvidia.com, 
	vadimp@mellanox.com, wsa@kernel.org, linux-kernel@vger.kernel.org, 
	Xuanqiang Luo <luoxuanqiang@kylinos.cn>, stable@vger.kernel.org
Subject: Re: [PATCH] i2c: mlxbf: Fix use-after-free in
 mlxbf_i2c_init_resource()
Message-ID: <alZyjKuqR-Hs90Dd@zenone.zhora.eu>
References: <20260714150808.85045-1-xuanqiang.luo@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260714150808.85045-1-xuanqiang.luo@linux.dev>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274587-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:xuanqiang.luo@linux.dev,m:linux-i2c@vger.kernel.org,m:kblaiech@nvidia.com,m:asmaa@nvidia.com,m:vadimp@mellanox.com,m:wsa@kernel.org,m:linux-kernel@vger.kernel.org,m:luoxuanqiang@kylinos.cn,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[andi.shyti@kernel.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andi.shyti@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,kylinos.cn:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F017175924D

Hi Xuanqiang,

On Tue, Jul 14, 2026 at 11:08:08PM +0800, Xuanqiang Luo wrote:
> From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
> 
> If devm_platform_get_and_ioremap_resource() returns an error,
> mlxbf_i2c_init_resource() frees tmp_res before reading tmp_res->io to
> get the error code. This results in a use-after-free.
> 
> Save the error code before freeing tmp_res.
> 
> Fixes: b5b5b32081cd ("i2c: mlxbf: I2C SMBus driver for Mellanox BlueField SoC")
> Cc: stable@vger.kernel.org
> Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>

merged to i2c/i2c-fixes.

Thanks,
Andi

