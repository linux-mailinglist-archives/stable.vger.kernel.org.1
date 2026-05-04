Return-Path: <stable+bounces-242829-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ACK4EYkb+GnCpwIAu9opvQ
	(envelope-from <stable+bounces-242829-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 06:07:37 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D5C84B84A6
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 06:07:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1386F300BC8A
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 04:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7808D1DC9B3;
	Mon,  4 May 2026 04:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="L12JVhGo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IIHU4632"
X-Original-To: stable@vger.kernel.org
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7406240DFD1;
	Mon,  4 May 2026 04:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777867650; cv=none; b=PWGgz4WqjVPff/cNNq+MX1wiYieZGPBEPqRn506MTjpANZ9dxy9ZSzixNxWJIj7T35dddRSU45cz8PeIR1d0rm1LTnBjl/Zr0mWJilosX6fDvgxtJKGZwx8MpZC3/5bMMCIiTftIQoXQT+TGYjoUQXsEFi407yn3dlD9D2tyBUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777867650; c=relaxed/simple;
	bh=MNLfm31CuSD9bY0fB2ljoYFQmQ0yfp1g+94VYHm6ffo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hskl1/gV/zP9yYh13YY+bIdeVe2ykIkYHkSSJqosxxE1eCyOioyMVAdW0CYybk8soIZJwhI+SkkATMOS+qM5G4M/+tpHbSOWXH+RuSpLtsW7WEp/6YJ38BRcKiZJXsD8Vkq6p3HnOyN3k//A5zmSjSUsLeEURyNC4q61XeKLu3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=L12JVhGo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IIHU4632; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 889081400065;
	Mon,  4 May 2026 00:07:26 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 04 May 2026 00:07:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm3;
	 t=1777867646; x=1777954046; bh=umlJXxAcNxZ9Q2Ni2iGink1BMJ+a6L1A
	SXDw2P3E0s8=; b=L12JVhGo6Bhd51mZ0iBkKnO0FXg0oyxoPCig2IF0O5esKfzX
	0FG1HLxqZsd104NZXZ/BEUspQfoJyc4tVO4qRnH+vJ1P6kwT9E9c3u+v/VHHbBiw
	n+sN1ubCLJNj/qVZLySyViCo0gbOc2LRPf4svF00qInwtbHa6HEC6CoCK0J80RIJ
	kWqCazS8kELn1LPpVa2fwX29nIEiLo1F1J6Qe8KDjp9TBI5ROPSqnOl/iYICjvKp
	+B9M9SUGwHmjPvSKmiYrn/GGUgnMAgt2bZTjKVgF3DqTIDgvc7xd9AqPvTknoIPO
	ArkfK6jX91RGv4gxT80UxAIXPLwoXn6l0v3t4w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1777867646; x=
	1777954046; bh=umlJXxAcNxZ9Q2Ni2iGink1BMJ+a6L1ASXDw2P3E0s8=; b=I
	IHU4632/4OFqGYSMke/fs+xURqhcyOkmbNlhqMjmlT6QtFP/ScmkVqJyC/f1zAVu
	Q07a6MKv+mX9/ZRcdWMg+s/XuPe2Z+PdjDkfvSPIyWfpvofgIusJf268SvHpeNBb
	S728xWCDOQGljKB4AXaK5i/hHyKmbaPsYvEDBSGsBn1IoVjzHPNTOBYPjELr+iYs
	sjRVYubr0bLu2INAtcx59VnYFCJhk2iw4+k+mdvdX6lxwtGx6W7Vp/r0t0jQtkZG
	AgM/+VpWjQPSV61bD+J7ZoRHsOx6APdRolnLGSGicgrdayObGVGa2vCWg3QR57Pt
	sF6/aHb/YO7gIbQ1Jb57A==
X-ME-Sender: <xms:fRv4aYKf_bf_gxhEeo0LUPz_w9wKcUv40JJJ_zgiS3Ci2S1zP98m6Q>
    <xme:fRv4aSMWcU6cpHw-GPxVcw0lzvHb9waMn6r8mKLMZf9KOFVtb1EAPgHHycck-Yx-U
    yb7op-vegBFkPBPfuCUrccwdJwKjb4m_0frMqfpI_2djaoaoSY0DYE>
X-ME-Received: <xmr:fRv4aYk6KDbDL2iJg1PlLFNrVJMn7FshEwwgDJ5pX9xzbP9s62v3y4V7D8uacfwYkQVoQ6vMqEsCNWqBEAYbgVBJEEfSMmY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeljeekgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtugfgjgesthekredttddtudenucfhrhhomhepvfgrkhgrshhh
    ihcuufgrkhgrmhhothhouceoohdqthgrkhgrshhhihesshgrkhgrmhhotggthhhirdhjph
    eqnecuggftrfgrthhtvghrnhepieffjeetjedvgfejffekuefgtdehjefhgeethfehvdej
    ueffueduteejtdfghfejnecuffhomhgrihhnpehmshhgihgurdhlihhnkhenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehoqdhtrghkrghshhhi
    sehsrghkrghmohgttghhihdrjhhppdhnsggprhgtphhtthhopeejpdhmohguvgepshhmth
    hpohhuthdprhgtphhtthhopegtrghsshhiohhgrggsrhhivghltghonhhtrghtohesghhm
    rghilhdrtghomhdprhgtphhtthhopegtlhgvmhgvnhhssehlrgguihhstghhrdguvgdprh
    gtphhtthhopehtihifrghisehsuhhsvgdrtghomhdprhgtphhtthhopehpvghrvgigsehp
    vghrvgigrdgtiidprhgtphhtthhopehlihhnuhigqdhsohhunhgusehvghgvrhdrkhgvrh
    hnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepshhtrggslhgvsehvghgvrhdrkhgvrhhnvghlrd
    horhhg
X-ME-Proxy: <xmx:fRv4aW79bIbX_ips3UzZAp5jc1CSmJjmNai-d8Wop3lFXV0Wysogjw>
    <xmx:fRv4ac15DcFHCkLxrLLmt_VX2u8WCTAAX_iqlRZN24luCkyYIUmiAg>
    <xmx:fRv4aREoENJRD02g8o_jtPh2claU4-6V6hQ7rQIumjOlFfWe0Ceexg>
    <xmx:fRv4abjjyspJq1rkg0n1nflo__kvBnBxUnYUI-WO_Mk4I6dRRQ_WEA>
    <xmx:fhv4adwVfNt4rmqvpvNgUPLtYkoj4pEuXbmRPj8P00GH_5LLUZGKx4MY>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 4 May 2026 00:07:24 -0400 (EDT)
Date: Mon, 4 May 2026 13:07:21 +0900
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: =?iso-8859-1?Q?C=E1ssio?= Gabriel <cassiogabrielcontato@gmail.com>
Cc: Clemens Ladisch <clemens@ladisch.de>, Takashi Iwai <tiwai@suse.com>,
	Jaroslav Kysela <perex@perex.cz>, linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] ALSA: firewire-tascam: Do not drop unread control
 events
Message-ID: <20260504040721.GA398619@sakamocchi.jp>
Mail-Followup-To: Takashi Sakamoto <o-takashi@sakamocchi.jp>,
	=?iso-8859-1?Q?C=E1ssio?= Gabriel <cassiogabrielcontato@gmail.com>,
	Clemens Ladisch <clemens@ladisch.de>, Takashi Iwai <tiwai@suse.com>,
	Jaroslav Kysela <perex@perex.cz>, linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260503-alsa-firewire-tascam-read-queue-v2-1-126c6efd7642@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260503-alsa-firewire-tascam-read-queue-v2-1-126c6efd7642@gmail.com>
X-Rspamd-Queue-Id: 9D5C84B84A6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[sakamocchi.jp,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[sakamocchi.jp:s=fm3,messagingengine.com:s=fm3];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[sakamocchi.jp:+,messagingengine.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-242829-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[o-takashi@sakamocchi.jp,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sakamocchi.jp:email,sakamocchi.jp:dkim,sakamocchi.jp:mid]

Hi,

On Sun, May 03, 2026 at 09:55:52PM -0300, Cássio Gabriel wrote:
> tscm_hwdep_read_queue() copies as many queued control events as fit in
> the userspace buffer. When the buffer is smaller than the current
> contiguous queue segment, length is rounded down to the number of bytes
> that can be copied.
> 
> However, after copying that shortened length, the code advances pull_pos
> to the original tail_pos, marking the whole contiguous segment as
> consumed. Any events between the copied portion and tail_pos are lost.
> 
> Limit tail_pos to the position after the entries actually copied before
> updating pull_pos. When the whole segment fits, this is equivalent to the
> old tail_pos update; when the buffer is smaller, the remaining events
> stay queued for the next read.
> 
> Fixes: a8c0d13267a4 ("ALSA: firewire-tascam: notify events of change of state for userspace applications")
> Cc: stable@vger.kernel.org
> Suggested-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
> Signed-off-by: Cássio Gabriel <cassiogabrielcontato@gmail.com>
> ---
> Changes in v2:
> - Recompute tail_pos after shortening length instead of adding a separate
>   entries_copied variable, as suggested.
> - Add Suggested-by tag.
> - Link to v1: https://patch.msgid.link/20260501-alsa-firewire-tascam-read-queue-v1-1-7baa4ba1a4de@gmail.com
> ---
>  sound/firewire/tascam/tascam-hwdep.c | 1 +
>  1 file changed, 1 insertion(+)

Looks good to me;)

Reviewed-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>

Or as a second Co-Author,
    Co-developed-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
    Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>

To maintainer, please feel free to assign the above tags according to
your preferences.


Thanks

Takashi Sakamoto

