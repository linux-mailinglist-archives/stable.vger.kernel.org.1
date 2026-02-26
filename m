Return-Path: <stable+bounces-219814-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IBm2M/FToGlLiQQAu9opvQ
	(envelope-from <stable+bounces-219814-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 15:08:49 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C7441A73B5
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 15:08:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5B07E3030484
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 14:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E25F333372D;
	Thu, 26 Feb 2026 14:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eAF2sFn4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A2D2DA756;
	Thu, 26 Feb 2026 14:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772114895; cv=none; b=IevEXwSa70+0t899LDdS3QZGBlwh34ks2GwF/K74BBhAdH7vbWOQX3cLN78ioCm2Nd2Q+AkcjDrNArvdJ9hAqhqg0h+uZyJaoZzDZnp7/o/BAsreDSVteqSHfYTsZcbtO4AkFG6J33mw5KNat3iVYBOJnt3aRkJDh0RqrTwT68g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772114895; c=relaxed/simple;
	bh=jaI4l3nRDTB82ejX1iS+mncKA/33oPwJ2XkQL9l1CeY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n9wFBBWcb3CL8BvR5efD589S8TQgKkrmuQnWHTIIJ1Jev2Ryhji2aNKPrKFHY1G7jbl95O1wFzoqSOI62dyePC5D+2YBGJ8vF4zBGX04mvYVlpwOjTQF3WI5ftuC3o9J7uqzr2QqwV8uGfg0nJTCFWIYySDhXCSqBe5agnk59mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eAF2sFn4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D23D0C116C6;
	Thu, 26 Feb 2026 14:08:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772114895;
	bh=jaI4l3nRDTB82ejX1iS+mncKA/33oPwJ2XkQL9l1CeY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eAF2sFn44nht9CCsXT0GOKOzMJ1KDp9C774jlDZ1H4LWf3UAVE25fCQtqONnxUGQ0
	 ijuCARL3eyHxlbRyAKCTpoJESk0kCO5hvSGUIIijyxEVeumEEPo9vCF7dyYVz/6z3A
	 8b6TzAZ7IS6OpuaGZpgm8LhVFp2iwze0M6+G/SVGTVQm4yiWXOv/HAIlhuqyGAyXxZ
	 oE9eew7PbQELQo5YGoOC5MflXvXQcRRsEs/fNJBe8vWn/q1ag7LtgbQkYdVDBlX6hG
	 qpolqy5udLKLZJTkFp+Da/wHQLCequLVYYIvnyK5vkz154a8yTgPo/6s4HFcXY6EIk
	 K0C8QY/YoZmCA==
Date: Thu, 26 Feb 2026 14:08:10 +0000
From: Lee Jones <lee@kernel.org>
To: Benjamin Tissoires <bentiss@kernel.org>
Cc: Jiri Kosina <jikos@kernel.org>, David Rheinsberg <david@readahead.eu>,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/1] HID: uhid: Fix out-of-bounds write caused by raw
 events mismanagement
Message-ID: <20260226140810.GD8023@google.com>
References: <20260211164025.171242-1-lee@kernel.org>
 <aZmsTQeeGf26FqvY@plouf>
 <172q4775-616s-p7s4-7n80-p8579n0r3516@xreary.bet>
 <47ro00po-r74n-870q-q178-67s8rpsss12q@xreary.bet>
 <aZ3IKiL91Ya7_iIM@plouf>
 <r6574n79-563r-9rrp-0n92-784532r67o63@xreary.bet>
 <20260226111816.GA8023@google.com>
 <aaA6fioiB9_aiBrA@plouf>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aaA6fioiB9_aiBrA@plouf>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-219814-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lee@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4C7441A73B5
X-Rspamd-Action: no action

On Thu, 26 Feb 2026, Benjamin Tissoires wrote:

> On Feb 26 2026, Lee Jones wrote:
> > On Tue, 24 Feb 2026, Jiri Kosina wrote:
> > 
> > > On Tue, 24 Feb 2026, Benjamin Tissoires wrote:
> > > 
> > > > Long story short: that patch is too intrusive as it makes assumption on
> > > > the behavior of the device. We need to understand where/if the bug was
> > > > spotted and fix the caller of hid_hw_raw_request, not the uhid
> > > > implementation.
> > > 
> > > Thanks a lot for the analysis, Benjamin!
> > > 
> > > I asked about that here:
> > > 
> > > 	https://lore.kernel.org/all/172q4775-616s-p7s4-7n80-p8579n0r3516@xreary.bet/
> > > 
> > > So let's wait for Lee to clarify. Until that, the patch stays out of the 
> > > branch.
> > 
> > Thanks to both of you for looking into this.  I appreciate your efforts.
> > 
> > This is very much real world.
> > 
> > Is there a way to add an errata for the PS3 controller?
> > 
> 
> Unfortunatelly no. uhid merely emulates what a device can do, and HID is
> a convention. So if we were to have a special case to PS3 controllers,
> we would then start having to maintain an endless list of quirks when
> the issue is *not* in uhid, but in the processing of the device after
> (maybe in hid-core?).

Actually I think the issue is in UHID.  At least the way I read it.

Are there legitimate use-cases for devices overwriting the Report ID
contained in the first index of the data buffer?  From my very limited
knowledge of the subsystem, this sounds like an oversight.

-- 
Lee Jones [李琼斯]

