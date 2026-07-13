Return-Path: <stable+bounces-273844-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id rWHHLM30VGrchwAAu9opvQ
	(envelope-from <stable+bounces-273844-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 16:23:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 031B574C55F
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 16:23:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=E2Ea1hUg;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-273844-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-273844-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 748A8338E935
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 14:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D82BF439014;
	Mon, 13 Jul 2026 14:02:09 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA3343712D;
	Mon, 13 Jul 2026 14:02:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783951329; cv=none; b=VBmEeGYIm3GPiaRzUnYItSm6zyTvnbyk/tEf5RiD/v+GrJPg+xlN3SFTt9RIYmSzB3CZ/J4jJ55XyPpFIWOfHHKwwKTGGW6DIx9+zqIHwudpBfV1UjqlzhbjCu3ugrLhB+X5wZnCC2ax8ClKyiF5hsJ7pPNyDhcwDz4TXRKzNX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783951329; c=relaxed/simple;
	bh=rAoflZ7dU2zWOKzTwefMVaAJ9I7PYu3c3DG0uX0OyiY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QI297dZ3FC2QPydeDukH30ObbbXpGm1brsL/pNLaIEZDz8iwguHW3DiMVnuh0vz6Y2fScGVaR0XAfuiRg/XNteVruZDgVNbBvTqmcjZLPYAz4/H/Vg8bDayI24Ck3VhO1tNRrj/yVcUPudQVEpOLTwPbrtgbpnrURvmZmkgKQVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E2Ea1hUg; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A5531F000E9;
	Mon, 13 Jul 2026 14:02:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783951328;
	bh=VHWWX3igIqoXlkJhrdkPaM1ZU2q8wVQ+l2OU8Gbgv7I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=E2Ea1hUgzgQf/KfQ2FGfuS8rdPCCpAQbyalFan22o6o8Dmf+69zVGJsG8DinLoq7y
	 41e/rNM5YeoOIzb0+i5EYATrxa6PYu3q0GsiBSLIeOadnAS3r9XqFWFwVbgs8H4DOB
	 o3I1nPQO8pt2QL2NvmUJLbgu9itj4tMeo0xg5gkWMRx4zG/rxi+rtYFMQxUxAdL5l7
	 PXk6p+dT4HMddlUHt+rCbcfcpWnAzax/cBcf275RaY+WRfbWG7wPCFg+41KPmDmfNV
	 exyhzzHVxlAVFjeKFQ/mFymX8n18ZYIOYFKY120cv/YWLqOpl2ozCR8CYhKq6ZCpfB
	 qWkAuXNWJUASQ==
Received: from johan by xi.lan with local (Exim 4.99.4)
	(envelope-from <johan@kernel.org>)
	id 1wjHEU-000000052Jh-01m8;
	Mon, 13 Jul 2026 16:02:06 +0200
Date: Mon, 13 Jul 2026 16:02:06 +0200
From: Johan Hovold <johan@kernel.org>
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] intel_th: Fix MSC output device reference leak
Message-ID: <alTv3j9hIH2qjJ2Z@hovoldconsulting.com>
References: <20260713120205.1003691-1-lgs201920130244@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260713120205.1003691-1-lgs201920130244@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:lgs201920130244@gmail.com,m:alexander.shishkin@linux.intel.com,m:gregkh@linuxfoundation.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[johan@kernel.org,stable@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-273844-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johan@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,hovoldconsulting.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 031B574C55F

On Mon, Jul 13, 2026 at 08:02:05PM +0800, Guangshuo Li wrote:
> intel_th_output_open() looks up the output device with
> bus_find_device_by_devt(), which returns the device with a reference that
> must be dropped after use.
> 
> The reference is currently intended to be dropped from
> intel_th_output_release(). However, a successful open replaces
> file->f_op with the output driver's file operations before returning, so
> close runs the output driver's release method rather than
> intel_th_output_release().
> 
> For MSC outputs, close runs intel_th_msc_release(). That release path
> only removes the per-file iterator and does not drop the device
> reference taken by intel_th_output_open(), so every successful MSC open
> leaks one device reference.
> 
> Drop the device reference from intel_th_msc_release(), which is the
> release path that is actually used for MSC output files.
> 
> Fixes: 95fc36a234da ("intel_th: fix device leak on output open()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---
> v2:
>   - Add Cc stable.
>   - No code changes.

You forgot to remove the intel_th_output_fops release callback as I
mentioned here:

	https://lore.kernel.org/all/aktZDK0NZrTdEqOm@hovoldconsulting.com/

Johan

