Return-Path: <stable+bounces-260719-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id l6U3No7oImppfAEAu9opvQ
	(envelope-from <stable+bounces-260719-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 05 Jun 2026 17:17:34 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ACDE649377
	for <lists+stable@lfdr.de>; Fri, 05 Jun 2026 17:17:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=HfT4ihdL;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-260719-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-260719-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 83FB63122D29
	for <lists+stable@lfdr.de>; Fri,  5 Jun 2026 15:04:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C4583FFFA4;
	Fri,  5 Jun 2026 15:04:19 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F9AA3E4C95;
	Fri,  5 Jun 2026 15:04:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780671859; cv=none; b=mkI8cI16TDnBn69LhZf/F3l/o9KpJ32DuzjxGuC3g/aoV3fRMQGyse/R2iG2uyNsokpI3rJsvQ2L2gHe3ajHD/tc+CJPiy/mxgSHF07Be5PohKIvmyKiOQ+bFp3jxcBxJHzv/7T0o0tPEgxIXnwCIegCUPPwskDUtQETFDCW1Fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780671859; c=relaxed/simple;
	bh=ovoYKAB4bYO0m3MdYKhDhzH0Kl5OSVG7wH1T3RYngcw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GvS1leIj2GiVEQBSoTcAu22PV3Pzg54rm+oIH29wsDQgsrCpVd0aSbvg6QQr0FKVGYFjZGt4Wv9+kZzENe4ElbIuzL9pB9IrVlvaik+55xLeTH7O7VsCoh3rRcpx3JW/kIAQyS1+Bjg1iExPQHujvp+LvOg1jEmcRXmM+WMESs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HfT4ihdL; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3BF41F00893;
	Fri,  5 Jun 2026 15:04:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780671858;
	bh=ovoYKAB4bYO0m3MdYKhDhzH0Kl5OSVG7wH1T3RYngcw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=HfT4ihdLgkO9AHGm8VX+cEqicZhNwchUSNhXCuad2gbNbKmjJ2eKkaBN1iC/mO+c4
	 wvU79aEULSrvCw7te/tllY4qkYq2mLx+YlyuI7W6Q5HZXPsMHZ48Nir8IFe2+9aqdk
	 2aRc1++c7EG0NgQzxfJDxaUSLGfPsz9JNEkDrjbs=
Date: Fri, 5 Jun 2026 08:35:17 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: vishalmimani008@gmail.com
Cc: linux-usb@vger.kernel.org, linux-tegra@vger.kernel.org,
	stable@vger.kernel.org, thierry.reding@gmail.com,
	jonathanh@nvidia.com, digetx@gmail.com
Subject: Re: [PATCH] usb: gadget: tegra-xudc: drain EP pipeline before DMA
 unmap
Message-ID: <2026060510-parsnip-tray-1381@gregkh>
References: <6a226993.a5745248.34e478.a9cd@mx.google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a226993.a5745248.34e478.a9cd@mx.google.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,nvidia.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260719-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:vishalmimani008@gmail.com,m:linux-usb@vger.kernel.org,m:linux-tegra@vger.kernel.org,m:stable@vger.kernel.org,m:thierry.reding@gmail.com,m:jonathanh@nvidia.com,m:digetx@gmail.com,m:thierryreding@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,gregkh:mid,linuxfoundation.org:from_mime,linuxfoundation.org:dkim,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7ACDE649377

On Thu, Jun 04, 2026 at 11:15:47PM -0700, vishalmimani008@gmail.com wrote:
> RnJvbTogVmlzaGFsIEt1bWFyIDx2aXNoYWxtaW1hbmkwMDhAZ21haWwuY29tPgpEYXRlOiBGcmks
> IDUgSnVuIDIwMjYgMTQ6MDg6NTQgKzA5MDAKU3ViamVjdDogW1BBVENIXSB1c2I6IGdhZGdldDog

<snip>

Something went wrong :(

