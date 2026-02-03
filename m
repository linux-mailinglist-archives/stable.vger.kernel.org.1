Return-Path: <stable+bounces-213270-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AATNOLwZgmmZPAMAu9opvQ
	(envelope-from <stable+bounces-213270-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 03 Feb 2026 16:52:28 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 81FD8DB88A
	for <lists+stable@lfdr.de>; Tue, 03 Feb 2026 16:52:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B49D03030982
	for <lists+stable@lfdr.de>; Tue,  3 Feb 2026 15:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E2973AEF53;
	Tue,  3 Feb 2026 15:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="q9Ij2QGu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC38190462;
	Tue,  3 Feb 2026 15:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770133943; cv=none; b=LmLJ3voGK0dyYAyov1XBrhxVqPY6urhQWM2RKmwqJ1znpLQviFJ6DdvKFbP+ZORzIHOfeiqqo8uQ7W5ZcgLQSRN5v+eJ/rY8bR7Ez+4buqW2tRoaHHRK2xbM9IwG8CZXfqApWwAkB5IQbJ0zJMnvSEabKOoCzAyNl5hP09KXgeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770133943; c=relaxed/simple;
	bh=aU8HVDfYOEcGL4QoZz/vYGLNX2VmtgaaGqNM3xFnLGg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rdn9WWi4gnA/K+SCSNtlYv5yLs1Gwk2K2H0LZ5zJFCEl0Mq5B+YqRFNe6UdVz3Fu4Z5Ob7I3pFu/M8hl87AssKw8vnnFZg4RbgJOIEnLP4tlsi43liFyflVvAosK+jcGLAi0SGbg/2Zp7pUDfuohY8KjmEgplqO2knb+i3a7Jdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=q9Ij2QGu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6458FC116D0;
	Tue,  3 Feb 2026 15:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770133942;
	bh=aU8HVDfYOEcGL4QoZz/vYGLNX2VmtgaaGqNM3xFnLGg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q9Ij2QGugS0SIxGCE2jHVvlvAknKsx20i+dQRxC1HDcDuHZKae59gFSYT0X7Tjjht
	 HKzs08/i+GQXzC+ZC37bu/T8lKqWLffGOM4djgMvwTM9aCxQqPDu4CSzQ6m6CAiBgC
	 UgEFDkM707gdfJr8NbQkj2gf925VU6gbMuTnke+M=
Date: Tue, 3 Feb 2026 16:52:19 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: wen.yang@linux.dev
Cc: stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6.1 0/3] net: Backlog NAPI threading for PREEMPT_RT
Message-ID: <2026020340-preseason-matchless-e51c@gregkh>
References: <cover.1768754220.git.wen.yang@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1768754220.git.wen.yang@linux.dev>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-213270-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.dev:email]
X-Rspamd-Queue-Id: 81FD8DB88A
X-Rspamd-Action: no action

On Mon, Jan 19, 2026 at 12:40:30AM +0800, wen.yang@linux.dev wrote:
> From: Wen Yang <wen.yang@linux.dev>
> 
> Backport three upstream commits to fix a warning on PREEMPT_RT kernels
> where raising SOFTIRQ from smp_call_functio triggers WARN_ON_ONCE()
> in do_softirq_post_smp_call_flush().

But PREEMPT_RT showed up for real in 6.12.y, NOT 6.1.y. We are reverting
PREEMPT_RT-only patches from the latest 6.6.y tree at the moment, why
are these needed here for 6.1.y at all?

confused,

greg k-h

