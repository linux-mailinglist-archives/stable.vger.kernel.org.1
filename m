Return-Path: <stable+bounces-273015-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id PDgeFWXnT2oKqAIAu9opvQ
	(envelope-from <stable+bounces-273015-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 09 Jul 2026 20:24:37 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B87F87343CB
	for <lists+stable@lfdr.de>; Thu, 09 Jul 2026 20:24:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=fluxnic.net header.s=fm2 header.b=pdDqmS1D;
	dkim=pass header.d=messagingengine.com header.s=fm2 header.b=OLEuGeDO;
	dmarc=pass (policy=none) header.from=fluxnic.net;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-273015-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-273015-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1B5033016BAB
	for <lists+stable@lfdr.de>; Thu,  9 Jul 2026 18:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10E0B4DC543;
	Thu,  9 Jul 2026 18:24:34 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B624DB546;
	Thu,  9 Jul 2026 18:24:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783621473; cv=none; b=T1kMWuXVQiCqiaX8nu9Vpn35h1i2U9hn4VtZL8JE7X+gihmaf7GUZlHcitrrgavXBrV0JyX+Or3PcbDm9J7yfySi3qg6UguZlJY2RyOGxyDfYCn1n8dkzb4+8Nur+md31nMTxFdVix7lRJLwiEtM3NX/HgAQTJFOgDM12aV4dbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783621473; c=relaxed/simple;
	bh=RZuEVF3rOBFmmVy3QJeWbG99EhjesbP20IjwAIOYuUM=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Oor8blM8eppWx9iXPgYaw/ZnhXptDFsx9gYnJtmRw14DsuvgtVMpv8iJsPdR0pdYB2DnbQz5sN5MBP5NQInaYJRbevdNuLR268fZWc9K1eIYmMqHQYfjVO9zVKWzBgnpTqND9+5SJJJuoT+N6x+e1Mnt70mhnNzORs+FDbqxlwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fluxnic.net; spf=pass smtp.mailfrom=fluxnic.net; dkim=pass (2048-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b=pdDqmS1D; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OLEuGeDO; arc=none smtp.client-ip=202.12.124.152
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 41C0F7A0065;
	Thu,  9 Jul 2026 14:24:31 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Thu, 09 Jul 2026 14:24:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fluxnic.net; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1783621471; x=1783707871; bh=rdKAgsnqRu
	FEUZ24WOR22k/vyl0AlnXcVRldF7qQol8=; b=pdDqmS1DtFxeRt7WQtpH31iLqP
	f3lD9ZZ5s8ACBhf37eHKogldg6bqm4UNjbUbbX0MfaIWRJSfyFE7+81+q61PjC7a
	qZ4NOq3kTrKWTV4wT4BWyKDcwICTwKDhw/ePKmwXMhEtNDo6j2yAKY3hcHBLOflE
	seWvRa2z+n2yBKQibH5CrTGHO5WCP8rUW5iE517+FItUvVrHC1VP9vkBoRu0zLrT
	TByPo38a/kOwp+HWqE749JsWxFruw/h0egZgeM2U+pI1ZnQrPRhO6T/F2EeCoI6k
	PwpK8qVVJr2QlnMwyR5yDYbm+FkuYNaa3NEa4b7lLxuAcXM3K/szJcJ0MwYw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783621471; x=1783707871; bh=rdKAgsnqRuFEUZ24WOR22k/vyl0AlnXcVRl
	dF7qQol8=; b=OLEuGeDO+np9rtPsgTpDqTH2XRr3GLQtoy7Lh6anQ21mPgMphFZ
	TajNN7j758uI0fGLCoq+cYFspO5xLW3SreWGZCfyg3klvueuNJojOEUKj9gVCuoI
	wLGKGLKnduOvj2p+NuVTifBdb1fgyEjjOEVQFSJRnmc0MLs+y3rDbYp4DeVUahFe
	3msK1UHl3YzlCcnDGlUIoGgH//JJlb0LgoXadCn5ZHnl00t0V6uh6Hr/4fyWKTjV
	B9+FTMnVmKQDQ6k3U3FJYAcsAljn9J5LmdzXE+GrsnfnMVehL/3iUiPfHA+grRCs
	XndG7wz4bIyrhMzrXhpJUxwxXklQtUd5jNA==
X-ME-Sender: <xms:XudPariH_458YgD4noIezIlmSveWsS7sFmj5US5IIxnqB3hc6DLRlw>
    <xme:XudPanEUxbJz1w8LI_qzsWsJ1ClhS3B3w732Xw4kJTgIWqLUnqPjSFmcDT9PED75k
    C-MDtz_RvA0bhUeWpleibJpSaUvDDWT6rhs_Kncd6CPC2Njw38mIWA>
X-ME-Received: <xmr:XudPahT4_5drGjjvQv1niDmnJYf1fRAAhiWngdDpu2fsALkA4MEOdOjAaeI4fuaiD9XsFfF1EIUJBSpTtcVV_wFLVjFLUnSLCBMRMdSBcXNxFg4>
X-ME-Proxy-Cause: dmFkZTGhb4zd4dCmOsyP3vEQaE5cokq/UZiR2tM9QWwyqyIdA/1M6z2/iBUu0X0iYU9j1g
    6ifwS00D13nYbpBr6Ml0R3NrsCtRtFzQGDPRsp1K+H1CfyKq7yxgzibfBaCVppI9NEGj5D
    JihF2iMQ9dL33/4gUoMSG8ouWUmnezHH114a7OApU+N9NguaWY3WbqAvuh8UUQU6DIannV
    blYSSitjaacSB4DNiRkgThCs/4gib7i3nc1yePyA+s+CNsl7+WPqAwz6aPxt5e8psfaszu
    P+2Ajy6stMkAzst+odIUZ43klIU34q7HQusx9u4u+0niQpxWmR/q2qOHbwmmkjI1a3LdUN
    sYwmtU8QnsyHEFWVjNQhYGeO3g7lf9fNgTAYI6vM63tmXkXEjqXYwVyayBYpt2f2qLzcIB
    RoNmOGTRkkRwRkaimJ/OvRXpgCozKpqkASUA77tfq1lv6YxMr0eiaNAUWCNtRAydS6dHmX
    NWMJUqYP3JeaDuZX5rXp7xgq2AR/f0SHLycUcpSpK0Y71fdiQz/ApNrZ/BzCp2Vp6WOOd6
    TT9wrrYakpb6VORD0ifSh0/m8+kog2WF74U35xX3xEdf7fBGG4wRIsmPY6EWo2/spekEd3
    X+pOUPG6LhEPDToSJlQIFBVZ+drH55dpDMl+fQEPYtoNU+NibsLHI3k5qDmQ
X-ME-Proxy: <xmx:XudPaky2NzD-i9d5Pa9KmNIdbU89bNC6lpQR68tz2eIOqpMTxRgunw>
    <xmx:XudPatd0z7NbMkuHdDrhElATgmod4VKFGyYMV40K0h6gQcilp9c_kg>
    <xmx:XudPanPnOftU5P1q4UnGndyb976AyquK6-u2GnlEVTDoGV6_6Rs_iA>
    <xmx:XudPaosuYJjGE2N8Db4triB44bp4m85cYm8_tsqQQcgrYdyhw0Dv0w>
    <xmx:X-dPakcSOrdNXxPMBp4fvp32l7l8i6U_G_bgTy90dupK8U5Uw_N-dy_6>
Feedback-ID: i58514971:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Jul 2026 14:24:30 -0400 (EDT)
Received: from xanadu (xanadu.lan [192.168.1.120])
	by yoda.fluxnic.net (Postfix) with ESMTPSA id E7FAC16BAFF7;
	Thu, 09 Jul 2026 14:24:29 -0400 (EDT)
Date: Thu, 9 Jul 2026 14:24:29 -0400 (EDT)
From: Nicolas Pitre <nico@fluxnic.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Jiri Slaby <jirislaby@kernel.org>
cc: Alexey Gladkov <legion@kernel.org>, linux-serial@vger.kernel.org, 
    linux-kernel@vger.kernel.org, stable@vger.kernel.org, kbd@lists.linux.dev
Subject: Re: [PATCH] vt: fix spurious modifier in CSI/cursor key sequences
In-Reply-To: <20260626024833.3419086-1-nico@fluxnic.net>
Message-ID: <4ro94n6o-r585-9693-07op-6p196oo273no@syhkavp.arg>
References: <20260626024833.3419086-1-nico@fluxnic.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[fluxnic.net,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[fluxnic.net:s=fm2,messagingengine.com:s=fm2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[fluxnic.net:+,messagingengine.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-273015-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[nico@fluxnic.net,stable@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:gregkh@linuxfoundation.org,m:jirislaby@kernel.org,m:legion@kernel.org,m:linux-serial@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:kbd@lists.linux.dev,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,messagingengine.com:dkim,vger.kernel.org:from_smtp,fluxnic.net:from_mime,fluxnic.net:dkim,syhkavp.arg:mid];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nico@fluxnic.net,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B87F87343CB


Ping.

On Thu, 25 Jun 2026, Nicolas Pitre wrote:

> From: Nicolas Pitre <npitre@baylibre.com>
> 
> csi_modifier_param() builds the xterm modifier parameter from
> shift_state, counting KG_SHIFTL/KG_SHIFTR as Shift, KG_ALTGR as Alt
> and KG_CTRLL/KG_CTRLR as Ctrl in addition to the canonical KG_SHIFT,
> KG_ALT and KG_CTRL.
> 
> That is wrong when those weights are not plain modifiers. Keymaps
> derived from XKB layouts (by kbd's xkbsupport, and by the
> console-setup used in Debian, Ubuntu and others) encode the active
> layout group using KG_SHIFTL/KG_SHIFTR:
> 
> 	group 1: -
> 	group 2: shiftl
> 	group 3: shiftr
> 	group 4: shiftl | shiftr
> 
> So while a non-default layout group is selected, KG_SHIFTL and/or
> KG_SHIFTR are set in shift_state with no Shift key held.
> csi_modifier_param() then adds a spurious Shift to every cursor and
> CSI key: pressing Up while group 2 is active emits ESC[1;2A (Shift+Up)
> instead of ESC[A. KG_ALTGR has the same problem since it is the
> standard third-level selector.
> 
> Normal keymaps bind the physical Shift/Ctrl/Alt keys to KG_SHIFT,
> KG_CTRL and KG_ALT, leaving the left/right and AltGr weights free for
> layout and level selection. Count only those canonical weights, so
> genuine modifiers are still encoded while layout/level selectors are
> not.
> 
> Fixes: 4af70f151671 ("vt: add modifier support to cursor keys")
> Reported-by: Alexey Gladkov <legion@kernel.org>
> Closes: https://lore.kernel.org/kbd/aj2gR0Y7sM6i9s2G@example.org/
> Cc: stable@vger.kernel.org
> Signed-off-by: Nicolas Pitre <npitre@baylibre.com>
> ---
>  drivers/tty/vt/keyboard.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/tty/vt/keyboard.c b/drivers/tty/vt/keyboard.c
> index dfdea0842149..763a3f1b7be0 100644
> --- a/drivers/tty/vt/keyboard.c
> +++ b/drivers/tty/vt/keyboard.c
> @@ -765,16 +765,22 @@ static void k_fn(struct vc_data *vc, unsigned char value, char up_flag)
>  /*
>   * Compute xterm-style modifier parameter for CSI sequences.
>   * Returns 1 + (shift ? 1 : 0) + (alt ? 2 : 0) + (ctrl ? 4 : 0)
> + *
> + * Only the canonical modifier weights are counted. The left/right variants
> + * (KG_SHIFTL, KG_SHIFTR, KG_CTRLL, KG_CTRLR) and KG_ALTGR are commonly
> + * repurposed as keymap layout-group or level selectors rather than as plain
> + * modifiers (for instance XKB-derived keymaps select the layout group with
> + * KG_SHIFTL/KG_SHIFTR), so counting them would encode a spurious modifier.
>   */
>  static int csi_modifier_param(void)
>  {
>  	int mod = 1;
>  
> -	if (shift_state & (BIT(KG_SHIFT) | BIT(KG_SHIFTL) | BIT(KG_SHIFTR)))
> +	if (shift_state & BIT(KG_SHIFT))
>  		mod += 1;
> -	if (shift_state & (BIT(KG_ALT) | BIT(KG_ALTGR)))
> +	if (shift_state & BIT(KG_ALT))
>  		mod += 2;
> -	if (shift_state & (BIT(KG_CTRL) | BIT(KG_CTRLL) | BIT(KG_CTRLR)))
> +	if (shift_state & BIT(KG_CTRL))
>  		mod += 4;
>  	return mod;
>  }
> -- 
> 2.54.0
> 
> 

