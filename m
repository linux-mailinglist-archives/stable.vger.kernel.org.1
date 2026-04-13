Return-Path: <stable+bounces-237609-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eH0GNvIq3WmVaQkAu9opvQ
	(envelope-from <stable+bounces-237609-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 19:42:10 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A4993F19B2
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 19:42:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 77B173000B81
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 17:36:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFCA636E477;
	Mon, 13 Apr 2026 17:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=b4.vu header.i=@b4.vu header.b="DIIiiSME"
X-Original-To: stable@vger.kernel.org
Received: from m.b4.vu (m.b4.vu [203.16.231.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71332368976
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 17:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.16.231.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776101803; cv=none; b=arjAHQhWrj0UgcgtQa7+l38RYfoI9oC4OsAlKpvpDsOcBuXP0DDJsrk2oPPQj+Z9MbCs4gP3F55zBGra4JreIxsIax7iaJpAJR5zw9ZKSQgz0Y6mHIWOTReFubjH7Get6oF4UOfeidjI2BSNRLn9OKM1/d7Ez5T8km4FzFjkH6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776101803; c=relaxed/simple;
	bh=XlgeJl5wBVfw9nuMUnPkUGmt9Ox2hxBnPakvkJZP5pU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZmsGQhxHEmzpoREKeNKmWOt/8Jtycwv5VByWXaOoBysrQW44VnhWjvT7P/kkWP6zN5TInvOzc740J4ZwtO9JpTl8za/bLgAAcDuQ1BAV7rYXkG3Ontb6bXr1S2MHAoeXYZggmURmVS8D32yD2+7OKJdIfR1kQWaBA66a1fww/7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=b4.vu; spf=pass smtp.mailfrom=b4.vu; dkim=pass (2048-bit key) header.d=b4.vu header.i=@b4.vu header.b=DIIiiSME; arc=none smtp.client-ip=203.16.231.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=b4.vu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=b4.vu
Received: by m.b4.vu (Postfix, from userid 1000)
	id 1D5E8672E00C; Tue, 14 Apr 2026 03:06:40 +0930 (ACST)
DKIM-Filter: OpenDKIM Filter v2.11.0 m.b4.vu 1D5E8672E00C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=b4.vu; s=m1;
	t=1776101800; bh=rEJ6c/zAc+h50OhGRwWlQ4KB4pLhTZQS9ChfN+bgxvs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DIIiiSMEOhBL9EA7xNoSDn456kUIWMQgSI5c2x0NvvJMAScDRHpqoQPEJK56whTFj
	 a9i3X9QKyWBVAzQRZK8jbLK9va0AS28zUtfdpSAdDbGvrtUPGPCO3RDpIv+ueUsdf7
	 sJPL1N8ie0U2atslqtKqK6R+JGD15vtEanr7FfHlKa5EgrDdlDnYK8Nqqrto5E86uz
	 Aks5OfF9C92b0XEOiK5TSN6B0M3ytkdlFrihBl8+uDOVhHH0BEiJL8NRtXFAZR6hHx
	 GC7VhX+ljYTp9L+HhZHtmW9Wg3WKgyfNmCgN1Hhxbfvb2Ao8I4K45Sf3bVM6vKRP5o
	 7zWJX+nOsURSg==
Date: Tue, 14 Apr 2026 03:06:40 +0930
From: "Geoffrey D. Bennett" <g@b4.vu>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	Takashi Iwai <tiwai@suse.de>, Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15 005/570] ALSA: usb-audio: Remove VALIDATE_RATES
 quirk for Focusrite devices
Message-ID: <ad0pqOwdPW1s3t4U@m.b4.vu>
References: <20260413155830.386096114@linuxfoundation.org>
 <20260413155830.596728908@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260413155830.596728908@linuxfoundation.org>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[b4.vu,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[b4.vu:s=m1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-237609-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[b4.vu:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[g@b4.vu,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8A4993F19B2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 13, 2026 at 05:52:16PM +0200, Greg Kroah-Hartman wrote:
> 5.15-stable review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: Geoffrey D. Bennett <g@b4.vu>
> 
> [ Upstream commit a8cc55bf81a45772cad44c83ea7bb0e98431094a ]
> 
> Remove QUIRK_FLAG_VALIDATE_RATES for Focusrite. With the previous
> commit, focusrite_valid_sample_rate() produces correct rate tables
> without USB probing.

Hi Greg,

This commit depends on its predecessor 24d2d3c5f940 ("ALSA: usb-audio:
Improve Focusrite sample rate filtering") which was not picked up for
stable because it didn't have a Fixes tag. It has been added to 6.19
and 6.18 but not 6.12, 6.6, 6.1, 5.15.

Without the rate filtering patch, the Focusrite Scarlett 18i8 3rd Gen
gets all sample rates advertised on every altsetting instead of the
correct per-altsetting subset.

There are also subsequent fixes:

a0dafdbd1049 ALSA: usb-audio: Exclude Scarlett 2i2 1st Gen (8016) from SKIP_IFACE_SETUP
f025ac8c698a ALSA: usb-audio: Exclude Scarlett Solo 1st Gen from SKIP_IFACE_SETUP
990a8b0732cf ALSA: usb-audio: Exclude Scarlett 2i4 1st Gen from SKIP_IFACE_SETUP
8780f561f671 ALSA: usb-audio: Exclude Scarlett 2i2 1st Gen from SKIP_IFACE_SETUP

and a just-submitted fix for the Scarlett 18i20 1st Gen.

Regards,
Geoffrey.

