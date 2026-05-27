Return-Path: <stable+bounces-254627-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eLK1BsgXF2px3wcAu9opvQ
	(envelope-from <stable+bounces-254627-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 18:11:52 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F7335E7850
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 18:11:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8E8C430E3165
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 16:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E31B53E92A7;
	Wed, 27 May 2026 16:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ABUJMFL1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC6A223328;
	Wed, 27 May 2026 16:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779898055; cv=none; b=FX2ljEVYsd2rT2jI6NgbT+AEk8XY9iBrOfuetxiDDl0y9kngEDySLOq4FvC2wDG7hO0LLlHYVBUQ6+FEUimn2gOk5yDeQleELgC3uZsGmb+J6HAUpAPOyj+VV3Yi+G02dhUb10N+erJ2UVAxujn80L33WkK99rBgr0EyfK9uAh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779898055; c=relaxed/simple;
	bh=jQxUQxqXDVQ38i3kOKC7Iz08BQGPEPYs34lkaeVW5m0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EcNdzPwVi14oxfny5Sp19OcFe+rLrsCjehdyYh0Cn9Yt4RfQI6isrPA5TdkE76ucOBQuCXLvRJeM1HHG/k8RvK4DWYgw5+bFf47hp92b+3pOZKITi7kwEP/c/opiki0guZGFXmMOl6X8G+5ubMWHWhJvfaUoAGm6tBDcqI0ogZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ABUJMFL1; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7B051F000E9;
	Wed, 27 May 2026 16:07:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779898054;
	bh=G0Froaa75FijA0ZhsFa3lxZ/kcB68VjZUBiIydDsn7c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ABUJMFL1/WeRRa0e5FzKBeao56Lr9oVicMADW0iFxGrfgaDNvcqOc61xVMA9Niait
	 /LyMavljqlJzr3nTp0WasrZCSYu3P8GS56fRSXCOijFE4ngIBjiVFIty39vhVns0pH
	 NSRYSFtNPpm+ooaV7v53019pb9i7tCSQnqi0b5WiB4XiRK5b77TFAEitYhiw7h6njQ
	 UvCLK4sWkVwHIyF3io/RpS00DJMVaA/r8tBrgXZvna7ZLCpLSoSHaZpeL3BCw8l5N0
	 xHx+IMaok1HWK8R8c6LILekK3W1RfsYnydQhoGM5Eg1AutZXDXPX1gQYJhVqy5zWUx
	 R0/UfmRuRsVAA==
Date: Wed, 27 May 2026 17:07:30 +0100
From: Lee Jones <lee@kernel.org>
To: Benjamin Tissoires <bentiss@kernel.org>
Cc: Ping Cheng <pinglinux@gmail.com>, Ping Cheng <ping.cheng@wacom.com>,
	Jason Gerecke <jason.gerecke@wacom.com>,
	Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/1] HID: wacom: Fix OOB write in
 wacom_hid_set_device_mode()
Message-ID: <20260527160730.GE712405@google.com>
References: <20260513075935.1715836-1-lee@kernel.org>
 <CAF8JNhKTMpT3CGq_oDqaGVygqXK0jjvrvjxbAWUerqtWzdB9+Q@mail.gmail.com>
 <20260519111354.GT305027@google.com>
 <ag8ozWBDSDckicSS@beelink>
 <20260521162212.GF3591266@google.com>
 <20260527155753.GD712405@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260527155753.GD712405@google.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,wacom.com,kernel.org,vger.kernel.org];
	URIBL_MULTI_FAIL(0.00)[wacom.com:server fail,tor.lore.kernel.org:server fail];
	TAGGED_FROM(0.00)[bounces-254627-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lee@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[wacom.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 9F7335E7850
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 27 May 2026, Lee Jones wrote:

> On Thu, 21 May 2026, Lee Jones wrote:
> 
> > On Thu, 21 May 2026, Benjamin Tissoires wrote:
> > 
> > > On May 19 2026, Lee Jones wrote:
> > > > On Wed, 13 May 2026, Ping Cheng wrote:
> > > > 
> > > > > On Wed, May 13, 2026 at 1:05 AM Lee Jones <lee@kernel.org> wrote:
> > > > > >
> > > > > > wacom_hid_set_device_mode() currently assumes that the HID_DG_INPUTMODE
> > > > > > usage is always located in the first field (field[0]) of the feature report.
> > > > > > However, a device can specify HID_DG_INPUTMODE in a different field.
> > > > > >
> > > > > > If HID_DG_INPUTMODE is in a field other than the first one and the first
> > > > > > field has a report_count smaller than the usage_index of HID_DG_INPUTMODE,
> > > > > > this leads to an out-of-bounds write to r->field[0]->value.
> > > > > >
> > > > > > Fix this by storing the field index of HID_DG_INPUTMODE in 'struct
> > > > > > hid_data' during feature mapping.  In wacom_hid_set_device_mode(), use
> > > > > > this stored field index to access the correct field and add bounds
> > > > > > checks to ensure both the field index and the value index are within
> > > > > > valid ranges before writing.
> > > > > >
> > > > > > Cc: stable@vger.kernel.org
> > > > > > Fixes: 5ae6e89f7409 ("HID: wacom: implement the finger part of the HID generic handling")
> > > > > > Signed-off-by: Lee Jones <lee@kernel.org>
> > > > > 
> > > > > Patch looks sensible to me. Thank you for your effort, Lee!
> > > > > 
> > > > > Tested-by: Ping Cheng <ping.cheng@wacom.com>
> > > > > Reviewed-by: Ping Cheng <ping.cheng@wacom.com>
> > > > 
> > > > Thank you Ping, I appreciate your review.
> > > > 
> > > > HID folks - any movement on this please?
> > > > 
> > > 
> > > I wanted to apply it today, but the patch conflicts with our current
> > > for-7.1/upstream-fixes.
> > > 
> > > Could you rebase on top of this branch so we can take this without me
> > > messing with your patch?
> > 
> > Sure.  Leave it with me.  Probably be early next week.
> 
> Are you sure this conflicted?
> 
> I just rebased it onto hid/for-7.1/upstream-fixes without issue.

Rebased patch here (not sure if it's actually different:

https://lore.kernel.org/all/20260527160528.847928-1-lee@kernel.org/

-- 
Lee Jones

