Return-Path: <stable+bounces-249184-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cBH0FhGhCmqL4QQAu9opvQ
	(envelope-from <stable+bounces-249184-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 07:18:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CE657565FA2
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 07:18:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D28CF300FFA9
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 05:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0086F390CB0;
	Mon, 18 May 2026 05:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CNMnG5dz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8DD03909BC;
	Mon, 18 May 2026 05:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779081485; cv=none; b=lAQI+40ofvuKP0SVw5g6R58zmBCRWrbTb1UtokDMFFF8d2TQAZQ7MCNzML/34Vf3c3ZbjIF1FX7fswW4LrsfhCyA9hHG2dKn0snIV/f8xG50Q05nwwCg4u0pR5ZXFnp3fnZRgAgPbLoJGfO4NdCx3GFSPlWiDdPOo2bPtLEccrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779081485; c=relaxed/simple;
	bh=43g81XSFBRuKLnE3nx3m6HcBUveV5+phoYj2i75oaZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ODOyN4UAjSh8hsO1KeIhd+epyMJbd+X/mzl7lx4uZ8UfiOG+A+qLCf1PwP58UBU8oajbWHPoU5ZYbi6ee3KByRrm1tWtxs3BYh3Zmbh4d5nbP5xoeq6AajbAljYNJg0DlkjDOrlngoOkUEiYUlR6ZU3QWSdNaJXVKnSDS1D27kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CNMnG5dz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE423C2BCB7;
	Mon, 18 May 2026 05:18:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1779081484;
	bh=43g81XSFBRuKLnE3nx3m6HcBUveV5+phoYj2i75oaZI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CNMnG5dzDemJqPqjKq53rWd/DAjSsxe8Og06CJIu0Wfy58maPNW6iivpGsZNGGErJ
	 aGnOAtlqDGISKDZL0Lvs70aK2Sm1uX+UNlCvqmAdXkdfCSJTYYxOMlz/a+MWSnsi8d
	 gWJ09kWToXhZXYvL4y4BE3xp0FyK30q7cfudwuao=
Date: Mon, 18 May 2026 07:18:08 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Muhammad Bilal <meatuni001@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
	marcel@holtmann.org, luiz.dentz@gmail.com, johan.hedberg@gmail.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: HIDP: fix missing length checks in
 hidp_input_report()
Message-ID: <2026051801-oops-makeover-da91@gregkh>
References: <20260517234805.116570-1-meatuni001@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260517234805.116570-1-meatuni001@gmail.com>
X-Rspamd-Queue-Id: CE657565FA2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249184-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,holtmann.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:dkim]
X-Rspamd-Action: no action

On Sun, May 17, 2026 at 07:48:05PM -0400, Muhammad Bilal wrote:
> hidp_input_report() reads keyboard and mouse payload data from an skb
> without first verifying that skb->len contains enough data.
> 
> hidp_recv_intr_frame() pulls the 1-byte HIDP header before dispatching
> to hidp_input_report(). If a paired device sends a truncated packet,
> the handler reads beyond the valid skb data, resulting in
> an out-of-bounds read of skb data.
> The OOB bytes may be interpreted as phantom key presses or
> spurious mouse movement.
> 
> Add a check that skb->len is non-zero before the type switch, and
> per-report-type minimum length checks before accessing the payload.
> 
> Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
> ---
>  net/bluetooth/hidp/core.c | 19 ++++++++++++++++---
>  1 file changed, 16 insertions(+), 3 deletions(-)
> 
> diff --git a/net/bluetooth/hidp/core.c b/net/bluetooth/hidp/core.c
> index 976f91eeb..03838a6ff 100644
> --- a/net/bluetooth/hidp/core.c
> +++ b/net/bluetooth/hidp/core.c
> @@ -179,12 +179,22 @@ static void hidp_input_report(struct hidp_session *session, struct sk_buff *skb)
>  {
>  	struct input_dev *dev = session->input;
>  	unsigned char *keys = session->keys;
> -	unsigned char *udata = skb->data + 1;
> -	signed char *sdata = skb->data + 1;
> -	int i, size = skb->len - 1;
> +	unsigned char *udata;
> +	signed char *sdata;
> +	int i, size;
> +
> +	if (!skb->len)
> +		return;
> +
> +	udata = skb->data + 1;
> +	sdata = skb->data + 1;
> +	size = skb->len - 1;
>  
>  	switch (skb->data[0]) {
>  	case 0x01:	/* Keyboard report */
> +		if (size < 8)
> +			break;
> +
>  		for (i = 0; i < 8; i++)
>  			input_report_key(dev, hidp_keycode[i + 224], (udata[0] >> i) & 1);
>  
> @@ -213,6 +223,9 @@ static void hidp_input_report(struct hidp_session *session, struct sk_buff *skb)
>  		break;
>  
>  	case 0x02:	/* Mouse report */
> +		if (size < 3)
> +			break;
> +
>  		input_report_key(dev, BTN_LEFT,   sdata[0] & 0x01);
>  		input_report_key(dev, BTN_RIGHT,  sdata[0] & 0x02);
>  		input_report_key(dev, BTN_MIDDLE, sdata[0] & 0x04);
> -- 
> 2.54.0
> 
> 

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>

