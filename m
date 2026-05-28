Return-Path: <stable+bounces-254729-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kHqUBojvF2q5WAgAu9opvQ
	(envelope-from <stable+bounces-254729-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 09:32:24 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2632A5EDBDB
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 09:32:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E2A5A300BC42
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 07:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06C2933FE0A;
	Thu, 28 May 2026 07:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RIowjc01"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E93B93264DF;
	Thu, 28 May 2026 07:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779953535; cv=none; b=jNLmt1ztqzS4Zh+cuJl2tfUsA40iVR115rqFS81Wo3K4s8y2pb7E1b5VEcAhe6QIltFNAn/ot29htwbEfRi6LPCBsAYlx75rtaYZSlIiTavMXExZRCJp5dSQwxkG9BIMUBhEcRqXmw1gEm7G/i3QRZOqln9NJNhRs0I1HBsa66Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779953535; c=relaxed/simple;
	bh=wiJKq5nMzGxB9u6tT9Q1xvF1aSEmX3a0/u8Lv3/59+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VMjfc3bjxhXJW+qDI2277BVWMyR7OHg5f3iz+r+RL23rYHit8AOKWwhwLNN6RPRxmlPfE1TF/oBMzd15tOCt7/dVeZzdHf//Qr7JfJ4+8LoKCqEFIQWlT7okaRYlrENfGhSwM21Onbmrd3sLj3ieabxLBf4O3U/jj363+pgB7Wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RIowjc01; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D3EE1F000E9;
	Thu, 28 May 2026 07:32:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779953532;
	bh=dSrILXwzPv+4lVYCkEg3KFDYgl8OcXdicI8nBzDEgU0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RIowjc01S7iRugRtWBcafcWBiIomWoIuTfdpxvuQRV9OOKVVOVuaV/3uCkjNIcVv9
	 O8jnrbFMVvhPlSYdXdEMBMq8IcQG28x6HvqPPaSnmE4e8ca/QxiBT8NOI4Ra169cxg
	 /DGPiow942EBZjbSO/V6oY1fJoIpfrZ6NYZ3vDVE=
Date: Thu, 28 May 2026 09:31:19 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Ian Klatzco <iklatzco@gmail.com>
Cc: stable@vger.kernel.org, yeoreum.yun@arm.com, sashal@kernel.org,
	peterz@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: stable: please backport 3b7a34aebbdf to 6.{6,12,13,14,15}.y
 ("perf: Fix dangling cgroup pointer in cpuctx")
Message-ID: <2026052848-gangly-pound-2b1f@gregkh>
References: <CAB=irMzhVj6B=T6XS7VyN9K_5Q+gCHD7dsw7fKSPWuNfjEATvA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAB=irMzhVj6B=T6XS7VyN9K_5Q+gCHD7dsw7fKSPWuNfjEATvA@mail.gmail.com>
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254729-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 2632A5EDBDB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 27, 2026 at 05:25:13PM -0700, Ian Klatzco wrote:
> Hi all,
> 
> linux-6.12.y has the regression commit e9c928807239 ("perf/core: Fix
> child_total_time_enabled accounting bug at task exit", backport of
> mainline a3c3c6667) but is missing the follow-up fix commit 3b7a34aebbdf
> ("perf: Fix dangling cgroup pointer in cpuctx", Yeoreum Yun, mainline
> v6.16-rc).
> 
> The following branches are impacted:
> 
>   linux-6.6.y
>   linux-6.12.y
>   linux-6.13.y
>   linux-6.14.y
>   linux-6.15.y
> 
> The regression silently bypasses perf_cgroup_event_disable() on the
> event-removal path when the event is non-ACTIVE at close time, leaving
> cpuctx->cgrp dangling at a soon-to-be-freed perf_cgroup struct.  See
> 3b7a34aebbdf's commit message for the precise description.
> 
> The minimum viable patch is as follows:
> 
>     @@ in __perf_remove_from_context, after event_sched_out(...):
>     +    if (event->state > PERF_EVENT_STATE_OFF)
>     +        perf_cgroup_event_disable(event, ctx);
>     +
> 
> I can prepare per-branch backports if useful; please let me know.

Please send backports for the trees we currently support (as listed on
the front page of kernel.org).

thanks,

greg k-h

