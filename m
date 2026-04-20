Return-Path: <stable+bounces-239987-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aCdfJS155mkHxAEAu9opvQ
	(envelope-from <stable+bounces-239987-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 21:06:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C9757433279
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 21:06:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A609B301624F
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 19:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86D763AE712;
	Mon, 20 Apr 2026 19:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nt3IbHiQ"
X-Original-To: stable@vger.kernel.org
Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D65583845B1
	for <stable@vger.kernel.org>; Mon, 20 Apr 2026 19:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776711978; cv=pass; b=OVTkQ/59IrjU9p9G7fbJnplEKJZKSjVpItFhQXkXs2fROxQf0MoQl6DnAwfV04YnSoTztWtaBsYnaWIEIndQAtmVTVPptDkxXF5FaSbvTJmOnLpgAWlQAaHurgB9DPE0Pd/0uUqj1gKNFbEyGy5/e1vTv/cXrbRlChmhg0x1IZ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776711978; c=relaxed/simple;
	bh=ITDRCLL6iQtCAcNDw1CfvU0dYmsh4uuQ5HG+bBBQaes=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=le53i2wH1e58ArY04mjXonKnFS+thjJ9+cYcT1DP+5H1o/6AoqAVGC8b6hp/tYb7wRwxdjT6aY/Gr34wiFgVHe/3TJT3pQjO1CVvw/YYXcKNna/j1vtNPWJwpoTN03qMAYOUPho1hspG6TLuc6Eiwp8OX5vaw6Mkjx0ManG6WHA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nt3IbHiQ; arc=pass smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-64eaf8aa893so2750604d50.3
        for <stable@vger.kernel.org>; Mon, 20 Apr 2026 12:06:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776711976; cv=none;
        d=google.com; s=arc-20240605;
        b=C0ZmhjivNgzJGUFDNv7ESWwrn7Jmd3XnS37lZ8dZjXbw6pL16OgpANAnEKeVhhjcM7
         lvqtYjU20ESwhXOVo+gAKTO1H1M3VKc/kdYOIAw+69QeVLaKfEd0/y2bEIh5xYsH6iSb
         J0C5kGV9uauJHL97exJ7UgI6fm0LLrOrFEbZfYchhUar7gcQtbyeiOxY3PP8OzMkqVFT
         XClySOWI2+nT8cd9uOZWhxMYFGVsOhvtJ22MGLptSZDT8+NITAdHi7gHrTWbPYyZwTlX
         dlccVUp1pxhTLjp8hj3tsUOlmDQXWHWM2m/31JsLmNmFQOTJHUVIPDZAUbfI0JTKU6bf
         b69A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UYWI4absxQ/bp1qKiQ6rfgUeoAwdmHId6fE4xEEnoNk=;
        fh=36p1VixTBcX83H60EJD9VV+64RgCyVimoJpax6HkY1I=;
        b=H0NQdRfYRhYojHnyMYiZUBy1Jd2IkCjH+4XDXWF4cn+dmc50eaMF0zc1ifHz7ObH5F
         bdnznLu1ln/gFH8XjZrllxGLAwFIH6rtW7gvgbY3YCEMRxWXs+GtYtw2Jd3UzcZ3jHUu
         4NRzcBpnF0uSWOb9/0g2Fp8NsnddrTdA+wvMKz7Q3krgim4KHym6vFNRKpm0AICuEUYZ
         S0xSB+1BymkAi5YVehB7MZ+E2YSPzR+hL3m98U4aGmVjUmJXTZ6ZD20xEtTJfu6VIlUz
         AqgJY+ApLp6xBGwHFYOIYiTXkiZcuzsaCXYw3mR6F6AWWntSUXh8KYKC1/VRbl0ZABmd
         bIyg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776711976; x=1777316776; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UYWI4absxQ/bp1qKiQ6rfgUeoAwdmHId6fE4xEEnoNk=;
        b=Nt3IbHiQqugtvpayEewre+vrWDDt1dguf3k/vIQgSeYuornpmvz5DDe5/QamLOvsV2
         Nr4CXRTe68XZ6R+5Uuu26A4VTE79/JbX65viFQDS611dHVrh+VkRmeoLXsingIGCJSRZ
         3S9fGG+JrYjne9wYvi5wOwhey6w8r9iNYSwOX5ae2CwlajX0qeKbzERUrpeszuHCM3ws
         0DOzlfA8491wTBKlRwaOFs8YrH2k7tnMYF1+LZ6S2NMtrTK3qqWiobsasxw+9K3iGzqy
         eqXTOfP1vIpMUYTjTbgLLajgg7N+wTBIf+LmOM5osFSibLsr8VthiQrfrNkbVr5YfDCA
         Fkpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776711976; x=1777316776;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UYWI4absxQ/bp1qKiQ6rfgUeoAwdmHId6fE4xEEnoNk=;
        b=PislcNMlY81q7HSGinYl6ibbzWMz3wkMCGv3FoEZQ/BN9BnOR5ePrPcvI96ujCZgAk
         aKCcLMTgwCJmihzNTrteVQ6SzQZDUlB3ajXXI4Yt5ae8aUecbtT0HhFwtGWarld+AnJi
         5Iox/a/Q90XRGWlOltosFOEvpOfo0Y/6n3iJMwHl47PkyOJDVhy5/lXMoZruTRwDDSCV
         wmOWU1L9MoZh2xr/7ITXxLtl7OYItDo5ap6/jJs4EZ49NaJ3P9EE2vUtQyERKHPRnfZm
         mVsAFbgpl77nBOmqCBm5CmTtAm2v26hVyViq1xzlDcD02+IIbfiWPr1LRODrJ2cBTmpj
         iYMw==
X-Forwarded-Encrypted: i=1; AFNElJ+JnIlmh3XdU7EzvSS8oBbYUgXerHR3tViiA06kYAB2zQOzEWgqSQqPXfp8wSP/HnzE3tLYuLk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7bRkYv7Aq6N7BubLZ0QwtuWRAXhjsQsv3/GR6UjB7cNLd3/IL
	blrSu+drkS5MtLpnEYUbwUSXUoNdWu/ip7/+J813QMDIhv+Ij58lwCkElRHgIa+07Fh2e1GxCkO
	1FI8/57ShneD+FGSbEjEbyJK57kNs1ZQ=
X-Gm-Gg: AeBDiesL0zPah7bbcGwpmBZEu8jEgn4Gr/UiPFfnemPUXMDbSvwre7wPP/VKdOwBKrn
	xG05JdV4rae3p/aoMkoS7ImhCcFbueWk1XHRi4IQBSdHbmMaJr8tXDKVEh8//cTdf+Qe8DbLyzI
	ZSc2WQsJv4oANx2IfO4Qrqc97tCsUESJKld8guxQO1lB1myq2X/rV2vwSF8+I8TNPAhcXuWCHvv
	BW5/PPNZN09E+96KBjik5vbOWmEMZ7MrYHoO9AGDtUHnhHUMc+pDDpFK6evkVkUWOI7WPO+qUiZ
	B0VHef1H2rD7AyePTzdQJlghuheweXAKLnouT0GJZsR5pDz4Yko9ipCL3Ayp6Y6sUpbf+No89Rv
	jaA==
X-Received: by 2002:a05:690e:1592:20b0:651:be8b:e87e with SMTP id
 956f58d0204a3-65310a2c1ccmr10986168d50.34.1776711975711; Mon, 20 Apr 2026
 12:06:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260417221628.1674866-1-michael.bommarito@gmail.com>
In-Reply-To: <20260417221628.1674866-1-michael.bommarito@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 20 Apr 2026 15:06:04 -0400
X-Gm-Features: AQROBzBslDU4lfxJ3rMX5ZoFfuxzh4odzH9UJusA1VXQPZvYBJe0ECmBeMBLMww
Message-ID: <CABBYNZ+f3pur4cSsanQ1kvv-yORp2E0qmVLt9si_+FnnJup4Ng@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: L2CAP: handle zero txwin_size in ERTM RFC option
To: Michael Bommarito <michael.bommarito@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Mat Martineau <martineau@kernel.org>, 
	Hyunwoo Kim <imv4bel@gmail.com>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-239987-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[holtmann.org,kernel.org,gmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luizdentz@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid,sashiko.dev:url]
X-Rspamd-Queue-Id: C9757433279
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Michael,

On Fri, Apr 17, 2026 at 6:16=E2=80=AFPM Michael Bommarito
<michael.bommarito@gmail.com> wrote:
>
> Bluetooth L2CAP ERTM configuration (RFC option, type 0x04) carries an
> unsigned 8-bit txwin_size field.  Core Spec v5.3, Vol 3 Part A, section
> 5.4 specifies a valid range of 1..63 (or 1..0x3fff under the Extended
> Window Size extension).  A peer-supplied value of zero is out of spec
> but the current l2cap_parse_conf_req() path stores it into
> chan->remote_tx_win unchanged whenever CONF_EWS_RECV is not set.
>
> The zero then reaches l2cap_seq_list_init(size =3D 0), which computes
> alloc_size =3D roundup_pow_of_two(size).  Per include/linux/log2.h the
> result is undefined for size =3D=3D 0.  The runtime behaviour is
> architecture-dependent:
>
>   * x86, arm64, RISC-V, MIPS, s390x, LoongArch: the ISA shift
>     instruction masks the shift count by (word_bits - 1), so
>     1UL << word_bits evaluates to 1 rather than 0.
>     kmalloc_array(1, sizeof(u16)) returns a valid 2-byte slab
>     allocation with seq_list->mask =3D=3D 0.  ERTM retransmission
>     silently collapses every reqseq onto slot 0 (correctness bug,
>     no memory corruption).
>
>   * ARMv7 (AArch32), PowerPC 32-bit (slw), PowerPC 64-bit (sld):
>     the shift instruction returns 0 for shift counts >=3D word
>     width.  1UL << word_bits therefore evaluates to 0,
>     kmalloc_array(0, sizeof(u16)) returns ZERO_SIZE_PTR, and
>     seq_list->mask becomes ULONG_MAX.  Any subsequent access to
>     seq_list->list dereferences ZERO_SIZE_PTR (0x10), which is
>     always an unmapped low-memory address, and the kernel Oopses.
>     This is a remote kernel panic driven by a single peer-sent
>     CONFIG_REQ; it is not a demonstrated code-execution primitive.
>
> Verified on qemu-system-arm -M virt -cpu cortex-a15 (ARMv7-A, same
> LSL register-shift semantics as the Cortex-A9 class still shipping
> in automotive infotainment on NXP i.MX6 with long-term availability
> through 2028).  A KASAN-inline kernel built from mainline panics in
> l2cap_seq_list_init on the first peer CONFIG_REQ carrying
> mode =3D L2CAP_MODE_ERTM and txwin_size =3D 0:
>
>   Unable to handle kernel paging request at virtual address
>   9f000002 when read
>   Internal error: Oops: 5 [#1] SMP ARM
>   PC is at l2cap_seq_list_init+0x140/0x28c
>   r2 : 00000010   r1 : ffffffff
>   Register r2 information: zero-size pointer
>   Mode SVC_32  ISA ARM
>   Call trace:
>    l2cap_seq_list_init from l2cap_ertm_init+0x588/0x758
>    l2cap_ertm_init    from l2cap_config_rsp+0xeac/0x1158
>    l2cap_config_rsp   from l2cap_recv_frame+0x1260/0x8000
>    l2cap_recv_frame   from l2cap_recv_acldata+0xb78/0xdb0
>    l2cap_recv_acldata from hci_rx_work
>
> r2 =3D 0x10 is ZERO_SIZE_PTR (the kernel's own decoder annotates it
> as such).  r1 =3D 0xFFFFFFFF is seq_list->mask after the 0 - 1
> underflow.  Faulting address 0x9f000002 is the KASAN shadow for
> pointer 0x10 (shadow_offset 0x9f000000 + (0x10 >> 3)).
>
> Trigger is one peer-supplied CONFIG_REQ on an L2CAP ERTM channel;
> no local privileges required, no pairing required, no local
> interaction beyond being within BR/EDR radio range of an affected
> host.
>
> Fix in two places:
>
>   * l2cap_parse_conf_req(): when the peer sends txwin_size =3D 0 in
>     the RFC option, clamp it up to L2CAP_DEFAULT_TX_WINDOW before
>     the chan->remote_tx_win assignment.  This matches the existing
>     clamp on the CONF_EWS_RECV branch in the same function and
>     mirrors the shape of commit 25f420a0d4cf ("Bluetooth: L2CAP:
>     Fix ERTM re-init and zero pdu_len infinite loop") for the
>     sibling RFC max_pdu_size field.  This is the primary fix: it
>     prevents zero from ever reaching l2cap_seq_list_init() on the
>     normal config path.
>
>   * l2cap_seq_list_init(): return -EINVAL on size =3D=3D 0 as a
>     defence-in-depth check for any current or future caller that
>     might pass an unclamped value.  The existing error-propagation
>     in l2cap_ertm_init() and its callers already tears the channel
>     down on error, so the peer simply loses the ERTM channel
>     rather than silently corrupting an unmapped ZERO_SIZE_PTR
>     allocation.
>
> Related but distinct from commit 25f420a0d4cf ("Bluetooth: L2CAP:
> Fix ERTM re-init and zero pdu_len infinite loop") which addressed
> the sibling zero-value issue on the RFC max_pdu_size field.
>
> Fixes: 3c588192b5e5 ("Bluetooth: Add the l2cap_seq_list structure for tra=
cking frames")
> Cc: stable@vger.kernel.org
> Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
> Assisted-by: Claude:claude-opus-4-7
> ---
>  net/bluetooth/l2cap_core.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index 95c65fece39b..b2fe094263ca 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -323,6 +323,17 @@ static int l2cap_seq_list_init(struct l2cap_seq_list=
 *seq_list, u16 size)
>  {
>         size_t alloc_size, i;
>
> +       /*
> +        * A peer may send an ERTM RFC option with txwin_size =3D 0, whic=
h
> +        * propagates here as size =3D 0.  roundup_pow_of_two(0) is
> +        * documented UB (see include/linux/log2.h) and produces a
> +        * semantically broken seq_list that silently drops every
> +        * retransmission slot.  Reject size =3D 0 explicitly so the call=
er
> +        * (l2cap_ertm_init) tears the channel down cleanly instead.
> +        */
> +       if (!size)
> +               return -EINVAL;
> +
>         /* Allocated size is a power of 2 to map sequence numbers
>          * (which may be up to 14 bits) in to a smaller array that is
>          * sized for the negotiated ERTM transmit windows.
> @@ -3593,6 +3604,17 @@ static int l2cap_parse_conf_req(struct l2cap_chan =
*chan, void *data, size_t data
>                         break;
>
>                 case L2CAP_MODE_ERTM:
> +                       /*
> +                        * Peer-supplied RFC txwin_size =3D 0 is out of s=
pec
> +                        * (Core Spec v5.3 Vol 3 Part A 5.4: ERTM tx wind=
ow
> +                        * range is 1..63, or 1..0x3fff with EWS).  Clamp=
 up
> +                        * to the default window so the subsequent
> +                        * l2cap_seq_list_init(remote_tx_win) does not
> +                        * receive a zero size.
> +                        */
> +                       if (!rfc.txwin_size)
> +                               rfc.txwin_size =3D L2CAP_DEFAULT_TX_WINDO=
W;
> +
>                         if (!test_bit(CONF_EWS_RECV, &chan->conf_state))
>                                 chan->remote_tx_win =3D rfc.txwin_size;
>                         else
> --
> 2.53.0

https://sashiko.dev/#/patchset/20260417221628.1674866-1-michael.bommarito%4=
0gmail.com

We should probably fix the double free if it can occur; perhaps the
others should be addressed in different patches.


--=20
Luiz Augusto von Dentz

