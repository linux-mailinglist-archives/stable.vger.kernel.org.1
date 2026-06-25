Return-Path: <stable+bounces-268348-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0/qwGYILPWpawQgAu9opvQ
	(envelope-from <stable+bounces-268348-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 13:05:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C58C46C4F5C
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 13:05:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=eKpMltyx;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268348-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-268348-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BCB323011590
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 11:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37B4D3002B3;
	Thu, 25 Jun 2026 11:05:33 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CAD039935D;
	Thu, 25 Jun 2026 11:05:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782385533; cv=none; b=JFDoAA+toxaW0aH8sFk2wZ6mBwT8w2vPasGXbkXo9ZUIdufojMC4Xxg+SQILKoZDolmpC+V7JnKXjcOTXj0ygqv+QFLQaanZ9RVD+FXXxQClG5Es6Ca9DA34e+nFzZlxcATtDpWXw85B0Ubx1Qh94XORbSfZFzMrm4fAsU1nvgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782385533; c=relaxed/simple;
	bh=uxW6EkWjVTN1sa5ltf9VGrhY0/55bCbObofQQviLjvY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KEZEld0X8efNAESkCCvzVtNpVEtOzztj7OLq0kTXnv8WscgxestXHj9NDEZr9rqmP23nzig4UkPiwsLryyhCUlNy3cHLYVJYREDgkGCPXoGWDvVoBO3DlCGtoNADCVIxgQxZkRCf6bYFWc9+xFpiTyYvpqcv1SdLM0PxjSiPqJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eKpMltyx; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03B681F000E9;
	Thu, 25 Jun 2026 11:05:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1782385531;
	bh=tUkARHxqgFiPuume8xpZyaeJ+B5pIVmsfh78GoOA1qE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=eKpMltyxDNd3u63zTABfLLn42J1MUY4QDC+oCGPrbQh00CuSFRZE+B8xSzuCBYUi4
	 757hv8kjIlASJaGg0Nm/3U7/HlK51gA99GJAJi8SA+VzVZSyRztFanVZCuR8qzC+Bi
	 0Z7Ub5s+KhhMh6HvzMIlU4Nbkfw1qytMCxALM3W0=
Date: Thu, 25 Jun 2026 12:04:19 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Bernard Pidoux <bernard.f6bvp@gmail.com>
Cc: kuba@kernel.org, stable@vger.kernel.org, linux-hams@vger.kernel.org
Subject: Re: [stable request] ROSE memory-safety fixes for 7.0.y and earlier
 (merged out-of-tree in linux-netdev/mod-orphan)
Message-ID: <2026062543-think-rocker-6e19@gregkh>
References: <CAFAa3YBfk2UOjAktrLq3_9+563m6UZuKv9XdBjfp2aB1twV1HQ@mail.gmail.com>
 <2026061625-starless-mascot-691a@gregkh>
 <CAFAa3YBciYSJxDT-SH=4oppyBS3hWUSEwJP_86EgUriJfYkjLw@mail.gmail.com>
 <2026062048-posted-scarf-dcf2@gregkh>
 <CAFAa3YAEDsnqcN6UqUE-4X+y0t7RPmNtwdb0LxExryZmAKU9pw@mail.gmail.com>
 <2026062051-doorframe-crayon-d390@gregkh>
 <CAFAa3YCJXV9uW==2776dbfNFH4PhBPUYnTxDJ2xs7kn0b=4UTA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFAa3YCJXV9uW==2776dbfNFH4PhBPUYnTxDJ2xs7kn0b=4UTA@mail.gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-268348-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:bernard.f6bvp@gmail.com,m:kuba@kernel.org,m:stable@vger.kernel.org,m:linux-hams@vger.kernel.org,m:bernardf6bvp@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linuxfoundation.org:dkim,linuxfoundation.org:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C58C46C4F5C

On Sat, Jun 20, 2026 at 02:42:17PM +0200, Bernard Pidoux wrote:
> Hi Greg,
> 
> Thanks, much appreciated.
> 
> Short answer: yes, the same series applies to 6.18.y, and the same bugs
> exist in the older trees too -- but only 7.0.y and 6.18.y take the series
> as-is. ROSE was removed in 7.1, so every stable line up to and including
> 7.0.y still carries this code and is affected.
> 
> I just test-applied this exact mbox with "git am" against the current
> ROSE files of each tree:
> 
> v7.0.13 : clean, 15/15 (what I sent you)
> linux-6.18.y : clean, 15/15, no conflicts -- the teardown code is
> identical to 7.0.13

Great, I've applied these to both now.

> linux-6.12.y : applies up to patch 3, then conflicts in
> rose_loopback.c (the loopback/timer code predates one
> of the refactors the series builds on)
> linux-6.6.y / 6.1.y / 5.15.y : same, conflict at the same patch
> 
> So for 6.18.y I can send an identical batch right away. For 6.12.y and
> the older LTS lines the fixes are still needed, but they need a rebased
> backport rather than a straight cherry-pick; I'm happy to prepare those
> per-tree once the format is settled.
> 
> My suggestion, matching what you said: let's land this 7.0.y batch first
> to work out the workflow. As soon as it's in I'll send the (identical)
> 6.18.y batch, and then the rebased older-tree batches one line at a time.
> Whatever order is easiest on your side works for me.

What you sent was fine, no problems, if that works for you, it's fine
for me.

thanks,

greg k-h

