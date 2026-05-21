Return-Path: <stable+bounces-253615-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8F5mDqQ1D2qSHgYAu9opvQ
	(envelope-from <stable+bounces-253615-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 18:41:08 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C50385A976B
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 18:41:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 33F06301476F
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 16:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C26D37DAA2;
	Thu, 21 May 2026 16:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IBXqNOBl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C8CC37C0FF;
	Thu, 21 May 2026 16:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779380538; cv=none; b=E7ebCMpojsm9q6zPfp47Jt1jZ9NEF6cl5qZeuy8vGQvqwnef3+S8rieigEeQXkVYCE/TPUc7ImuBi1hR2ZOJ5ASEu32rscYIb6E6iq0Dqf4w+FBP9oUWDtzp5nPcsamwCfe92DFsSFjzYfk88gWypmIGSJZ9ebq/hh+lawUCZtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779380538; c=relaxed/simple;
	bh=q8Q2jpBtXatWT29rDC57gjt4sWgE5S+dPfPEhR97NOc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R409eTQ5vc+/mr6/TtmQDfJWS1kqMDmoH9CseQOgjecUQ7hQZvC10LjcbKe2CFPIwjlgrBbCdtkNVJhbqtSiCdKQlgFklT4+kSfPAxIgDWk9M0jf54pxvbTsc61ySdbJLW0jS5SRb0C3vzyI8fE/KJcEMS38qdHR8v0qRtXBNGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IBXqNOBl; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72BD21F00A3B;
	Thu, 21 May 2026 16:22:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779380537;
	bh=aQWxwOMswQz9QvIcXH52mV3CznI+xMEdKpdDsI1gY6o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=IBXqNOBlk9tOnlOcKsU+1bFcgV3IqqHgTXByqJMETzw6Bkx+LbUiUw9sS2iVTGfDp
	 JjS7CS+XzKfPDUwubJi3B23fUqqtjTBPdJLl1/4496mIIHxk7N4SfkXi9/oQDnfd6u
	 IuLPjh0YH/NMR4wOpBdsA9xuechjR29usDVcWhOpvhID4HIV8LqwPD3eKunCEeQyDC
	 ewo2mcfdLKKStlUzaV9LFXSqTu+5Ux65bzqMI6lACHZ2u1ShN34CKAMy/q/l/3zPuo
	 FrH4Tjn+OAELBc/KwaI5khrnTG4kPpJnvOSvkVYQ3GBivBPmxh9z7udeaQAcPqzk7j
	 0s4lqo76PFdQA==
Date: Thu, 21 May 2026 17:22:12 +0100
From: Lee Jones <lee@kernel.org>
To: Benjamin Tissoires <bentiss@kernel.org>
Cc: Ping Cheng <pinglinux@gmail.com>, Ping Cheng <ping.cheng@wacom.com>,
	Jason Gerecke <jason.gerecke@wacom.com>,
	Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/1] HID: wacom: Fix OOB write in
 wacom_hid_set_device_mode()
Message-ID: <20260521162212.GF3591266@google.com>
References: <20260513075935.1715836-1-lee@kernel.org>
 <CAF8JNhKTMpT3CGq_oDqaGVygqXK0jjvrvjxbAWUerqtWzdB9+Q@mail.gmail.com>
 <20260519111354.GT305027@google.com>
 <ag8ozWBDSDckicSS@beelink>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ag8ozWBDSDckicSS@beelink>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-253615-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,wacom.com,kernel.org,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lee@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,wacom.com:email]
X-Rspamd-Queue-Id: C50385A976B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 21 May 2026, Benjamin Tissoires wrote:

> On May 19 2026, Lee Jones wrote:
> > On Wed, 13 May 2026, Ping Cheng wrote:
> > 
> > > On Wed, May 13, 2026 at 1:05 AM Lee Jones <lee@kernel.org> wrote:
> > > >
> > > > wacom_hid_set_device_mode() currently assumes that the HID_DG_INPUTMODE
> > > > usage is always located in the first field (field[0]) of the feature report.
> > > > However, a device can specify HID_DG_INPUTMODE in a different field.
> > > >
> > > > If HID_DG_INPUTMODE is in a field other than the first one and the first
> > > > field has a report_count smaller than the usage_index of HID_DG_INPUTMODE,
> > > > this leads to an out-of-bounds write to r->field[0]->value.
> > > >
> > > > Fix this by storing the field index of HID_DG_INPUTMODE in 'struct
> > > > hid_data' during feature mapping.  In wacom_hid_set_device_mode(), use
> > > > this stored field index to access the correct field and add bounds
> > > > checks to ensure both the field index and the value index are within
> > > > valid ranges before writing.
> > > >
> > > > Cc: stable@vger.kernel.org
> > > > Fixes: 5ae6e89f7409 ("HID: wacom: implement the finger part of the HID generic handling")
> > > > Signed-off-by: Lee Jones <lee@kernel.org>
> > > 
> > > Patch looks sensible to me. Thank you for your effort, Lee!
> > > 
> > > Tested-by: Ping Cheng <ping.cheng@wacom.com>
> > > Reviewed-by: Ping Cheng <ping.cheng@wacom.com>
> > 
> > Thank you Ping, I appreciate your review.
> > 
> > HID folks - any movement on this please?
> > 
> 
> I wanted to apply it today, but the patch conflicts with our current
> for-7.1/upstream-fixes.
> 
> Could you rebase on top of this branch so we can take this without me
> messing with your patch?

Sure.  Leave it with me.  Probably be early next week.

-- 
Lee Jones

