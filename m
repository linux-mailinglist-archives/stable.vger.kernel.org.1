Return-Path: <stable+bounces-260619-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id JrJtAeA9ImrPUAEAu9opvQ
	(envelope-from <stable+bounces-260619-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 05 Jun 2026 05:09:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 39730644CC6
	for <lists+stable@lfdr.de>; Fri, 05 Jun 2026 05:09:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="Gy/68dDg";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-260619-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-260619-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B1A4F302DF6C
	for <lists+stable@lfdr.de>; Fri,  5 Jun 2026 03:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CBEC3B775B;
	Fri,  5 Jun 2026 03:09:15 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7E13B5843;
	Fri,  5 Jun 2026 03:09:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780628954; cv=none; b=LND4f1oSf75ruGrBHhEGYrKD0IW3wlXj+2Fpln3eObkEQZK+XMhbMsHjDsBjviXd0u9r1O/+RZKfpmxe84gI3UQPHcgw1fun3qJIjTq4PglYyeKv3ZEpFtQLb/9oznFZ72VShhotXV7JgBJkyiEsYTY/+zVjDOL4rh4Nex+8+ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780628954; c=relaxed/simple;
	bh=Ou77IkkPnxmgYxU4tvdPlK2a1YNoyWDmXUWGGI4oTr8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UrVcrZv91oMdlB2m+8taqQAKixO+5ArlH18l+qfosdqTMWRJQRkjP9OufBl4aqkgI4V+oCudwKp/A+4tL0hUbCUeXQZE3k9UwhCq0MWDrbRXxzx4/MKpUIq4unMWEmuRJqGA00lryGCGXtYDRbtVL7dO9D7KZ7XCj0hI+TkLtmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gy/68dDg; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAB5D1F00893;
	Fri,  5 Jun 2026 03:09:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780628951;
	bh=RF7lld1C2j/U8LrOMMtbKUk9ujiZNci+5Q5/wnVxTXw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Gy/68dDgaDno8qYLeW7EdfzybY0fEbvhms/oitXKcuUYAGo5IJl6CI6Pyy8UZsMia
	 5cP2d5g7GQUYn43QvItriCrXDBpQ0lc5SD1BX/wheuVMnHerhvpHgN80szcnBU9td7
	 +CdAJ63hTwyVb/tmYjNjX9B+EW4ZikzCzFBesQ2utvUm6IiP32ZlVELPq8L+ApmJ2x
	 qzsypjjJTOl2NKATmMjI4b/G1amYmvy3oCszwX5Avfa8bhoOR/jHzyk5kBFDn5dFrt
	 Ln447Yb8PvNCtT+pWRxOvqDkSH4OM+RdsFq6r8x6B8SfwNyQ4hNLSsdnZ1cckXoeOh
	 YQKipZw4nIkrA==
Date: Thu, 4 Jun 2026 22:09:10 -0500
From: Rob Herring <robh@kernel.org>
To: Muhammad Bilal <meatuni001@gmail.com>
Cc: tomeu@tomeuvizoso.net, ogabbay@kernel.org, tzimmermann@suse.de,
	Frank.Li@nxp.com, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] accel/ethosu: fix IFM region index out-of-bounds in
 command stream parser
Message-ID: <20260605030910.GA1800024-robh@kernel.org>
References: <20260523195159.55801-1-meatuni001@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260523195159.55801-1-meatuni001@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260619-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:meatuni001@gmail.com,m:tomeu@tomeuvizoso.net,m:ogabbay@kernel.org,m:tzimmermann@suse.de,m:Frank.Li@nxp.com,m:dri-devel@lists.freedesktop.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[robh@kernel.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[robh@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 39730644CC6

On Sat, May 23, 2026 at 07:51:59PM +0000, Muhammad Bilal wrote:
> NPU_SET_IFM_REGION extracts the region index with param & 0x7f, giving
> a maximum value of 127. However region_size[] and output_region[] in
> struct ethosu_validated_cmdstream_info are both sized to
> NPU_BASEP_REGION_MAX (8), giving valid indices [0..7].
> 
> Every other region assignment in the same switch uses param & 0x7:
>   NPU_SET_OFM_REGION:  st.ofm.region  = param & 0x7;
>   NPU_SET_IFM2_REGION: st.ifm2.region = param & 0x7;
>   NPU_SET_WEIGHT_REGION: st.weight[0].region = param & 0x7;
>   NPU_SET_SCALE_REGION:  st.scale[0].region  = param & 0x7;
> 
> The 0x7f mask on IFM is inconsistent and appears to be a typo.
> 
> feat_matrix_length() and calc_sizes() use the region index directly
> as an array subscript into the kzalloc'd info struct:
>   info->region_size[fm->region] = max(...);
> 
> A userspace caller supplying NPU_SET_IFM_REGION with param > 7 causes
> a write up to 127*8 = 1016 bytes past the start of region_size[],
> corrupting adjacent kernel heap data.
> 
> Fix by applying the same & 0x7 mask used by all other region
> assignments.
> 
> Fixes: 5a5e9c0228e6 ("accel: Add Arm Ethos-U NPU driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
> ---
>  drivers/accel/ethosu/ethosu_gem.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

I've applied this and the rest of the patches you sent.

Rob

