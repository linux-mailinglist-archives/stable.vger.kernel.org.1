Return-Path: <stable+bounces-253997-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oAOQEjmWEmqt1AYAu9opvQ
	(envelope-from <stable+bounces-253997-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 24 May 2026 08:10:01 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ED7F05C1812
	for <lists+stable@lfdr.de>; Sun, 24 May 2026 08:10:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 99B7F300EA84
	for <lists+stable@lfdr.de>; Sun, 24 May 2026 06:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 926993603C9;
	Sun, 24 May 2026 06:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rRmh4M1H"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362DD2AD37;
	Sun, 24 May 2026 06:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779602991; cv=none; b=ZtCJnCyX41dc+IozsVFNqP5ZVEWVL8Xg7zcKK7UDhh3wCdx7inCFdxDNa7XqVsPCMuWQ52somh1TVwCdyXb3mCwECFu3UWMPdYj0z3lUGwQCLnBVzixbdTUf8dhbkFzA0iClfXqsmgF4Ct1OLnmZ4fmkuqodm+nv3h//fuO+mP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779602991; c=relaxed/simple;
	bh=CU5I0O6PQRB3YYkLAsJYC50Igs914ZWHAfeiz9InDzo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LMeqZTY2VEQPS9C9rj/e9a31DZq763on0eCn8PpfBkVjwrmukH9n2Xlu450kjSwD52RIAKotwOekWLfV+geF5IfmOa9pdn/IqwDoI+Dc0tAwj6XOmMoPKQU/UpYHd+Jb8IMKe4RCz5dZq0F2ZM+GpQQxqyWPFthy25NLH7Mx6YQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rRmh4M1H; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A07D1F000E9;
	Sun, 24 May 2026 06:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779602989;
	bh=KYWJD2YdmN9SJac5G8qIRi32OQ/EkGnTIPXgpLZsq6o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=rRmh4M1HcCGMPvYYSV2E8zyFCv9FZH0Z0oMw3QTPxSrje9UuIMFltlJn7Yn7mmPFO
	 RE9VEzcKriQzcRE04NShZN4NsSxxSszW5oe7ypg/BZpYnpE3z0slpM7hey9TJ4H1RM
	 BopnAYgQXgicfJzMvFS4H/umjlYU5lHq2SJl8fvg=
Date: Sun, 24 May 2026 08:09:00 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Johan Hovold <johan@kernel.org>
Cc: Joseph Bursey <jbursey@uci.edu>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+ad2aac2febc3bedf0962@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] USB: iowarrior: fix use-after-free on disconnect
Message-ID: <2026052449-sappy-everglade-4e43@gregkh>
References: <20260523170523.1074563-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260523170523.1074563-1-johan@kernel.org>
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253997-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.917];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable,ad2aac2febc3bedf0962];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: ED7F05C1812
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, May 23, 2026 at 07:05:23PM +0200, Johan Hovold wrote:
> Submitted write URBs are not stopped on close() and therefore need to be
> stopped unconditionally on disconnect() to avoid use-after-free in the
> completion handler.
> 
> Fixes: b5f8d46867ca ("USB: iowarrior: fix use-after-free after driver unbind")
> Fixes: 946b960d13c1 ("USB: add driver for iowarrior devices.")
> Reported-by: syzbot+ad2aac2febc3bedf0962@syzkaller.appspotmail.com
> Link: https://lore.kernel.org/all/6a0ce39b.170a0220.39a13.0007.GAE@google.com/
> Cc: stable@vger.kernel.org
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

