Return-Path: <stable+bounces-263538-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vnxYIarVMGpdXwUAu9opvQ
	(envelope-from <stable+bounces-263538-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 06:48:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 043ED68BF21
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 06:48:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=e8XJB3qN;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-263538-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-263538-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3FE07301416F
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 04:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B2293C454E;
	Tue, 16 Jun 2026 04:48:37 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0177D2750ED;
	Tue, 16 Jun 2026 04:48:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781585317; cv=none; b=nreUF1Psf/muToJaiD7Amb6XeNxpYGFsVHaMD3leGGt5c8cFPM9b8rniurun4FWANjLThX7Vrglc7Vx91S4kRYo4WCbRpezgAeyn21x5LfuxjkYSyV9Gr3IzfjhA2RkQAvFjII01fsqU13wA5gsj3OtjRSkM4M7+kr9l8kbEQFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781585317; c=relaxed/simple;
	bh=+GAzhuOVqYflmhuwdTsSL+/EE2isHEZUlqKl3kdaaSg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ctSgDYwlFBZeNFa5CvihMp4cEtYwiS9qulso6v3C1D1HYBL02zAn3eVMR1/DXPUPphGjCJ9pxvwK4+T1qWwQSLgzw6gwZwhApu/5l+vYY/2+YMjO+06JKvY69OC2KxQXTpI18bZbUnXjjJTjdzuc3DS5RGf2LN/uwbz7ggSzcq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=e8XJB3qN; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E8671F000E9;
	Tue, 16 Jun 2026 04:48:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781585315;
	bh=59eSE6Ypmdqidr8SEUba7qcDtoyeflow3dPcMaCCM1o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=e8XJB3qNY3Iia94LYouqyZznnC3rhYx8DuLLujNzA8u7k4pc7aXmt0u9DmxcJFZ4e
	 +LnAFumMEsx4qzMgPHrn3TDLyxxvfW5JQFrBLww206+nSOjAG4ZsNotZKywj4t0u/r
	 y0lfXc/2AVxNGdi01bFU6opnQOYlYzB2rJ5O3eDw=
Date: Tue, 16 Jun 2026 10:17:31 +0530
From: Greg KH <gregkh@linuxfoundation.org>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Sasha Levin <sashal@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
	AVKrasnov@sberdevices.ru, edumazet@google.com, eperezma@redhat.com,
	jasowang@redhat.com, kuba@kernel.org, leonardi@redhat.com,
	stefanha@redhat.com, virtualization@lists.linux.dev,
	xuanzhuo@linux.alibaba.com, stable-commits@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: Patch "vsock/virtio: fix potential unbounded skb queue" has been
 added to the 6.6-stable tree
Message-ID: <2026061624-harbor-capture-a5bf@gregkh>
References: <2026051553-santa-unretired-a417@gregkh>
 <20260515113503-mutt-send-email-mst@kernel.org>
 <2026051526-banish-strife-6dba@gregkh>
 <20260515114521-mutt-send-email-mst@kernel.org>
 <20260516170159.vsock-virtio-unbounded-drop@kernel.org>
 <ag8EvTp29B-Q3nCq@sgarzare-redhat>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ag8EvTp29B-Q3nCq@sgarzare-redhat>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:sgarzare@redhat.com,m:sashal@kernel.org,m:mst@redhat.com,m:AVKrasnov@sberdevices.ru,m:edumazet@google.com,m:eperezma@redhat.com,m:jasowang@redhat.com,m:kuba@kernel.org,m:leonardi@redhat.com,m:stefanha@redhat.com,m:virtualization@lists.linux.dev,m:xuanzhuo@linux.alibaba.com,m:stable-commits@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-263538-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:from_mime,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,gregkh:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 043ED68BF21

On Thu, May 21, 2026 at 03:15:54PM +0200, Stefano Garzarella wrote:
> On Sun, May 17, 2026 at 09:33:06AM -0400, Sasha Levin wrote:
> > > > What's the status of that fix?
> > > 
> > > Stefano posted v3 and is working on v4.
> > > 
> > > >  Should it be reverted elsewhere?
> > > 
> > > Donnu. With the change we have no DoS but the socket gets silently
> > > broken.  Eric felt given the brokenness is upstream already it's better
> > > to work on a fix on top, not revert.
> > 
> > Dropped from the 6.6, 6.12, 6.18, and 7.0 queues. We'll pick up Stefano's
> > follow-up once it lands upstream.
> 
> FYI v4 is now merged in the net tree, so I guess they will land upstream
> soon. I CCed stable on both patches:
> 
> a4f0b001782b ("vsock/virtio: reset connection on receiving queue overflow")
> c6087c5aaad6 ("vsock/virtio: fix skb overhead accounting to preserve full
> buf_alloc")
> 
> Both are related, but the second is the main fix of this patch.

THe second one doesn't apply at all :(

