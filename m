Return-Path: <stable+bounces-212938-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6U3aI4PyfWliUgIAu9opvQ
	(envelope-from <stable+bounces-212938-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 31 Jan 2026 13:16:03 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 017C9C1C1B
	for <lists+stable@lfdr.de>; Sat, 31 Jan 2026 13:16:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 211E430022F0
	for <lists+stable@lfdr.de>; Sat, 31 Jan 2026 12:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC79C2E11B8;
	Sat, 31 Jan 2026 12:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bJBQYvgm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70277749C;
	Sat, 31 Jan 2026 12:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769861757; cv=none; b=g44yYMuyk102HGow7pgtiYE8n8TcxO2pZu0BvtCa4MFRueZygaCd1vCXujFQ1bqg10E1gvckRAHc25ffJnqxwX/o21r/9jLXuTWWbb1VLIHw58bqUo7TSOt0SbKnF8jPFdpuYYulF0H9ObAyJE5RLGWN4LDpMu8UlCpGYk1IjCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769861757; c=relaxed/simple;
	bh=gt+c62Tv6TQ8lzn2xD/S+YwmYgA5DdEwHUvC1uh6W6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OviXOfiUgZW18fq7b1qRSP9yCfuh9qzO3Pi3YNNArlXY4rck+ESzxDUj2F+ehFuPZh0oFggx4Ia8p/zCmN1MIPEUih29cGZVnbh5aJRuRXOiKjFiQfQR+pVsy0dgOS7fE7G9UvCAEi9mgO/z5m+swoaCwEygTM7v+H3XEXvfYiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bJBQYvgm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E98CC4CEF1;
	Sat, 31 Jan 2026 12:15:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769861756;
	bh=gt+c62Tv6TQ8lzn2xD/S+YwmYgA5DdEwHUvC1uh6W6c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bJBQYvgm1lWsAIo7I6JXEH92WFUhh1sqjCiRTITUqQbqr7ao8vI2GXKBMirWuk6Yt
	 gzyow56O+HWaxEw8cebkVfYMRhI9A488CivpA8ezMqnMUgEhmpoenuSi+clgcguvR6
	 NyfCtruZGZXyA3ihrHWkob5Rw7zzhy21NxhCag4Q=
Date: Sat, 31 Jan 2026 13:15:53 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Guan-Yu Lin <guanyulin@google.com>
Cc: mathias.nyman@intel.com, stern@rowland.harvard.edu,
	wesley.cheng@oss.qualcomm.com, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [RFC PATCH] usb: host: xhci-sideband: fix deadlock in unregister
 path
Message-ID: <2026013133-tamale-massager-3c76@gregkh>
References: <20260130074746.287750-1-guanyulin@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260130074746.287750-1-guanyulin@google.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-212938-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 017C9C1C1B
X-Rspamd-Action: no action

On Fri, Jan 30, 2026 at 07:47:46AM +0000, Guan-Yu Lin wrote:
> When a USB device is disconnected or a driver is unbound, the USB core
> invokes the driver's disconnect callback while holding the udev device
> lock. If the driver calls xhci_sideband_unregister(), it eventually
> reaches usb_offload_put(), which attempts to acquire the same udev
> lock, resulting in a self-deadlock.
> 
> Introduce lockless variants __usb_offload_get() and __usb_offload_put()
> to allow modifying the offload usage count when the device lock is
> already held. These helpers use device_lock_assert() to ensure callers
> meet the locking requirements.

Ugh.  Didn't I warn about this when the original functions were added?

Adding functions with __ is a mess, please make these names, if you
_REALLY_ need them, obvious that this is a no lock function.

And now that you added the lockless functions, are there any in-kernel
users of the locked versions?  At a quick glance I didn't see them, did
I miss it somewhere?

thanks,

greg k-h

