Return-Path: <stable+bounces-260068-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /+xDIj8fIGrGwAAAu9opvQ
	(envelope-from <stable+bounces-260068-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 03 Jun 2026 14:34:07 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EEDA76378D2
	for <lists+stable@lfdr.de>; Wed, 03 Jun 2026 14:34:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=GctvyTuA;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-260068-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-260068-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8FAA93123B24
	for <lists+stable@lfdr.de>; Wed,  3 Jun 2026 12:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C372257423;
	Wed,  3 Jun 2026 12:16:39 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01FF02D6409;
	Wed,  3 Jun 2026 12:16:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780488999; cv=none; b=NILYlSGEd9DFRsxNq5EO1Sr6iHf8iUKFdMMMocgJ9tXmCEu34ydyB2v329wVXg5y8UBp8+Htl9DlA/FN5YV2Nab1JBRVZYbiCraxjbB8wN/Tnbtir0nIbY3vynay7ENlIFU0X4nIu06p/wmkB+1+hD1KeToIMPNuFBIm+hir97E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780488999; c=relaxed/simple;
	bh=Jj8AhTxhMZAhMj3pbdYkU0lnW7s9GRwgSShW11COAk4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ur54YCHKdOAGumjGTTSjaGbswkIjSKRgZmucTqDe8H1sWuVj91oPZSgQ7+p8ogUvXFjzNASga4ykU9/WeN/bv8mjBK5XhTXmzsfocExNokAYphozlMAdKKGZzctQLBaog82MvCJ2VRMoWChL1Q7/0Gz2CTRH1iXqsqnb9LRLQUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GctvyTuA; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 327A81F00893;
	Wed,  3 Jun 2026 12:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780488996;
	bh=YlpiRAkQUmR4tQifgz0RJ9o4kdHlazxXBxV7ULuGi/w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=GctvyTuADoWhn0fG9iSL/X7GG3pHMWds9t0xuExW/d+NzpZwe0a/4+bb3NahAAi20
	 DeuQU8/tOpWOsqXJgnuoYhrqUJkCsllJXGggBNmUqEyyDZ23kORFHjyjDpM2+6KMk0
	 spxuV2tkQJ38F/sIH73iAUwqug2PEMVQeT8oGVjJcQlSHhW/V9coKyJ6Ih9lgTB9GW
	 o0Sv4fz/QlnSQcMN2C8a2qXZreQICpjqFGsQJXLI8M9vscPRlP71O5pcb+brc+1uJc
	 xSnx0O4OI8MGaXnaFnW1ms+Jz0P7IjcVaYwobxTHeZzu0bUFVsr9n0/ZKitCVwIFAx
	 JgK+BG9at2uSg==
Date: Wed, 3 Jun 2026 13:16:32 +0100
From: Lee Jones <lee@kernel.org>
To: Wenshan Lan <jetlan9@163.com>
Cc: Benjamin Tissoires <bentiss@kernel.org>, gregkh@linuxfoundation.org,
	sashal@kernel.org, stable@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6.12.y] HID: core: Mitigate potential OOB by removing
 bogus memset()
Message-ID: <20260603121632.GB9653@google.com>
References: <20260603054344.80160-1-jetlan9@163.com>
 <ah_RiLcNbfyfDHko@beelink>
 <e62974e5-f341-47e5-9563-354df51aa6db@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e62974e5-f341-47e5-9563-354df51aa6db@163.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:jetlan9@163.com,m:bentiss@kernel.org,m:gregkh@linuxfoundation.org,m:sashal@kernel.org,m:stable@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[lee@kernel.org,stable@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-260068-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[163.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lee@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EEDA76378D2

On Wed, 03 Jun 2026, Wenshan Lan wrote:

> 
> On 6/3/2026 3:04 PM, Benjamin Tissoires wrote:
> > On Jun 03 2026, Wenshan Lan wrote:
> > > From: Lee Jones <lee@kernel.org>
> > > 
> > > [ Upstream commit 0a3fe972a7cb1404f693d6f1711f32bc1d244b1c ]
> > > 
> > > The memset() in hid_report_raw_event() has the good intention of
> > > clearing out bogus data by zeroing the area from the end of the incoming
> > > data string to the assumed end of the buffer.  However, as we have
> > > previously seen, doing so can easily result in OOB reads and writes in
> > > the subsequent thread of execution.
> > > 
> > > The current suggestion from one of the HID maintainers is to remove the
> > > memset() and simply return if the incoming event buffer size is not
> > > large enough to fill the associated report.
> > > 
> > > Suggested-by Benjamin Tissoires <bentiss@kernel.org>
> > > 
> > > Signed-off-by: Lee Jones <lee@kernel.org>
> > > [bentiss: changed the return value]
> > > Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
> > > [ Replace hid_warn_ratelimited() with hid_warn() in v6.12. ]
> > > Signed-off-by: Wenshan Lan <jetlan9@163.com>
> > > ---
> > This commit is known for breaking devices. You can't backport this
> > without the following 3 fixes:
> > 4d3a2a466b8d ("HID: core: Fix size_t specifier in hid_report_raw_event()")
> > 206342541fc8 ("HID: core: introduce hid_safe_input_report()")
> > 2c85c61d1332 ("HID: pass the buffer size to hid_report_raw_event")
> > 
> > Note that this is the same for your 6.6, 6.1 and 5.15 patches.
> 
> Thanks for your suggestion, I will send a V2 later.

https://lore.kernel.org/all/20260601083642.908433-1-lee@kernel.org/

-- 
Lee Jones

