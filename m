Return-Path: <stable+bounces-216682-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gJ53KI3qkmlSzwEAu9opvQ
	(envelope-from <stable+bounces-216682-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 16 Feb 2026 10:59:41 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DD961422B2
	for <lists+stable@lfdr.de>; Mon, 16 Feb 2026 10:59:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C157E301624A
	for <lists+stable@lfdr.de>; Mon, 16 Feb 2026 09:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BDEA2ED154;
	Mon, 16 Feb 2026 09:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hjIhysGO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F393726E175
	for <stable@vger.kernel.org>; Mon, 16 Feb 2026 09:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771235928; cv=none; b=teiL1TfW1xLmL5wnmbgGiSVPIO7svrMTN0WuDYjCZ33QAXIRV6Me3TPascaqpi5WOKvo1+shYLZI4Id2MjkBqti0o+76o7nFBUw6KIehwu4Jw+xLoUmQ1TVaRXoTMBNyB2TnDmhg/A08SIdpTUtxMzmNvuMSPlmBdNf7M0FlRGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771235928; c=relaxed/simple;
	bh=xLnxBPoxz7jY7mQDTiHj1tRiku2s/hDA7dXnusnpYro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fk28yCkEWkrcWl32U9aGcpc5N58xbqWPsrBFgXceBCZnnA+gzN9A9xQ3ubk+pYakl946QGUoin891kHJamgsDtqtHK3CXsfCCmT0VcdA7vhWg5vzNGaWOr6Zy7B0fbaFvC5qkl/QoHU+vrGmFrGHbboZM6RfQ3H++Eq9Iey0hNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hjIhysGO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26BBFC116C6;
	Mon, 16 Feb 2026 09:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771235927;
	bh=xLnxBPoxz7jY7mQDTiHj1tRiku2s/hDA7dXnusnpYro=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hjIhysGOyKetYaC2yHCgtw+7W0pXqLm2SYiYuh0LmJ3H6JUa3UGwJM0I7YpOI0PlG
	 bWP7qIbEvEyJbEYo+wZ2M52QRbOBoHrZFj65bvagan2KGwVonl1ToxfQ5hdBImXAAr
	 6dGLeW7GCX8RD8Q31TyXr3L8TaWoXfMu5P41NpcA=
Date: Mon, 16 Feb 2026 10:58:44 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Joshua Washington <joshwash@google.com>
Cc: stable@vger.kernel.org, Ankit Garg <nktgrg@google.com>,
	Jordan Rhee <jordanrhee@google.com>,
	Harshitha Ramamurthy <hramamurthy@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH 6.6.y] gve: defer interrupt enabling until NAPI
 registration
Message-ID: <2026021654-catsup-occupier-6753@gregkh>
References: <20260213211702.447894-1-joshwash@google.com>
 <20260213211702.447894-4-joshwash@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260213211702.447894-4-joshwash@google.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-216682-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:dkim,msgid.link:url]
X-Rspamd-Queue-Id: 1DD961422B2
X-Rspamd-Action: no action

On Fri, Feb 13, 2026 at 01:17:02PM -0800, Joshua Washington wrote:
> From: Ankit Garg <nktgrg@google.com>
> 
> [ Upstream commit 3d970eda003441f66551a91fda16478ac0711617 ]
> 
> Currently, interrupts are automatically enabled immediately upon
> request. This allows interrupt to fire before the associated NAPI
> context is fully initialized and cause failures like below:
> 
> [    0.946369] Call Trace:
> [    0.946369]  <IRQ>
> [    0.946369]  __napi_poll+0x2a/0x1e0
> [    0.946369]  net_rx_action+0x2f9/0x3f0
> [    0.946369]  handle_softirqs+0xd6/0x2c0
> [    0.946369]  ? handle_edge_irq+0xc1/0x1b0
> [    0.946369]  __irq_exit_rcu+0xc3/0xe0
> [    0.946369]  common_interrupt+0x81/0xa0
> [    0.946369]  </IRQ>
> [    0.946369]  <TASK>
> [    0.946369]  asm_common_interrupt+0x22/0x40
> [    0.946369] RIP: 0010:pv_native_safe_halt+0xb/0x10
> 
> Use the `IRQF_NO_AUTOEN` flag when requesting interrupts to prevent auto
> enablement and explicitly enable the interrupt in NAPI initialization
> path (and disable it during NAPI teardown).
> 
> This ensures that interrupt lifecycle is strictly coupled with
> readiness of NAPI context.
> 
> Cc: stable@vger.kernel.org
> Fixes: 893ce44df565 ("gve: Add basic driver framework for Compute Engine Virtual NIC")

Why did you change the Fixes line here?  Did the original commit lie
about it?  If so, that's fine, but this is really going to cause tools a
mess to keep track of...


> Signed-off-by: Ankit Garg <nktgrg@google.com>
> Reviewed-by: Jordan Rhee <jordanrhee@google.com>
> Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
> Link: https://patch.msgid.link/20251219102945.2193617-1-hramamurthy@google.com
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> Signed-off-by: Joshua Washington <joshwash@google.com>
> ---
> 
> Note: This patch has been modified form the original to re-introduce the
> irq member to struct gve_notify_block, which was introuduced in commit
> 9a5e0776d11f ("gve: Avoid rescheduling napi if on wrong cpu").

Can you put this in a "comment" above your signed off like:

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
[ modified to re-introduce the irq member to struct gve_notify_block,
  which was introuduced in commit 9a5e0776d11f ("gve: Avoid rescheduling
  napi if on wrong cpu"). ]
Signed-off-by: Joshua Washington <joshwash@google.com>

Also, it's "from", not "form" :)

Same for all of the other backports here, can you fix them all up
please and send a v2?

thanks,

greg k-h

