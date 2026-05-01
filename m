Return-Path: <stable+bounces-242447-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GGqYMIu79GkwEAIAu9opvQ
	(envelope-from <stable+bounces-242447-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 16:41:15 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C7794AD559
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 16:41:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A9755301B17E
	for <lists+stable@lfdr.de>; Fri,  1 May 2026 14:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B78D53CCA12;
	Fri,  1 May 2026 14:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kq4+umvl"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0181C3A542C
	for <stable@vger.kernel.org>; Fri,  1 May 2026 14:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777646399; cv=pass; b=dovbeXCcBvHojo6KwaxK2PbhleFrr++fJDUGs60Qdi8sInTL8k3Dur3gfYev6iR4FVLDWYb34LvS5ErOeSre93yrwb2o9ougPD8q+w7RdGgVpff5vcFMo4AyGVEjj1jLAdqBvXO3e8OrYcRcNZhILtwhkgYGz4JHSndZ21489eU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777646399; c=relaxed/simple;
	bh=S8fve2HFcCTBx3SnwVrIBbes1OGaEfXXe9hynclioBQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XQBgdi1U0tsf+o+giwQu7yI3qkLGAShybcZRHVWgF23ND+DoUx+Q1N4TSIjZ+/GYoPgIBXT8hcZ60J03BBHxfHcBc8TlHOCBev2sscNF9JKgjFY+B0cqVSNaiWalopw03O2QPfNHkdvGoB4vu1UECARGRWnU8Igo0vJeP9XG4hA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kq4+umvl; arc=pass smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-479d4df9035so1844960b6e.0
        for <stable@vger.kernel.org>; Fri, 01 May 2026 07:39:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777646396; cv=none;
        d=google.com; s=arc-20240605;
        b=KWh3Qfs5rG9kdvWippvLROrK4Lw0pioHWDjzwpyal0i7iEiFWm9lzeNu/YI174vgY0
         3ehh6lx4MhYj3l432DIP9Yx7p21mH/uQGLZIcHFjO3Go3bonfGMX50CTKpilcliwwtlO
         A7D4qDEB9XwSju9uwTt15a3gGjcQxnfNY/n1xLfwcXGG33jqDxj1TrvoCfMj/XwsT1dJ
         Tr3jCwRRqTZpj+waHlz4qIpBh1hvSWp4hnLxncLXfC0u5aucDoJjWEGHQVFW+x98mXxN
         hJ1F2MBDix9I/zuC7Dy/BmNTwpBlBCUtLVYBumM56HzhKtUXOjBsCfxPhwe0FEQ5w8dl
         kU2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=NftTzy9Ln5DqXKSRJIZ/qHTlNehEhTWv0Pbo/cmQRj0=;
        fh=3uoYQEzz6iDCVaEQ78yhbEUR/t0aHaym0kpVWFWQ/jc=;
        b=W6OFfRrwVmVilm2wegBuJil+scVWiI15MXcjkLArNH5QYyHmB1hgeeeX+LNC5v/vj3
         HB42v8rOMPTDbW5GwGOwY57XLntRSlgHhXM7fRn/IUqqt1HnaVxZqeHf08k9/ha/uogq
         HEHMmsuwTi8lh+tqxrZZvu2dkezGvmGxzUXv6DVs2cqXdjPFhbkkE7LfSCfxq38gNas6
         jAaPdtL5GJzEsm7ollMbkqEyfQhzKWOCIZr4IpqrnkXwpqkdgzrvalq+vwz9kYPj2qmi
         vreiiSajiOcQDU+KSbU4/1NM8ZwJ76xQgEjBi8IP3fggaatcFBIf1hvvLzRkTkQ5A/RK
         fUgg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777646396; x=1778251196; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NftTzy9Ln5DqXKSRJIZ/qHTlNehEhTWv0Pbo/cmQRj0=;
        b=Kq4+umvl9GaLHNKjf1HxbtCWRRaH6sJvZ7EDfMgE9MwBKACTwog7ES+0lFKVWN4pZ1
         AIxn4Oh6qOGwju7RmNi9ggNAf/M3TOCGPgh6AMyS+PmdZVtuMfLyuU5CseSyzsZzTn+g
         RrC9ax+acJDtTmZiqIVFJwiBJWI2CQiuJMZT4lXclKZkjlt60hw/+Vgc3tYe6NQuioSr
         JlnvezqT921g83jgSGf2ZCF9Fm71T9bN4q7o+xQkBuVzqzh8FWhzFLXuelHCP6HBqS4F
         4GGNvoZ3ce0d0C6MCH8eVkHlcE8WPIr2naFAiYiT/RGZDoF3eGib7oM7NSuEsaBwtnGg
         OahQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777646396; x=1778251196;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NftTzy9Ln5DqXKSRJIZ/qHTlNehEhTWv0Pbo/cmQRj0=;
        b=K7k9K2l1u0fh8j4dW7KFq+Ec4WkjBry3/JWX2i9WnXRf1hwfUG2nX8RZoj4UQHRLU2
         m5MMrR2aDOY95T4OVkVQR5UqywMmqwYPeYNkcFTtcnn7zrRtXbQEFLJjphf7bH4czvBD
         sFtKktD/Vw03GYORQ/mUkjugC8zWRqYm1iBrY99GXi3DvLjFO6FPXW5aLxO3KneW9xTI
         46/e45vqjl3Ys7p9OI98m9gdrEQnvcCe5dDDbPumD8EjjVYJaIofQlc7VXcDpPRCD9lW
         opRJzXein8sptRsuYxBde2ST0Qhqxn9eZYWIGMPXLazqTll0f4kqYnp3MTd9+NtwZAaQ
         XZRQ==
X-Forwarded-Encrypted: i=1; AFNElJ9n6qIresjcTU9/KZnElq6GwJqBjW6kn/w7VvMsNErzLH9LM1AwZM20zYO7diDL79Aammm8gd4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMUPaSy7xKmn3VWZZ6X7hXtxI3DyrnxLjyJhMIRnBC14DZJmfQ
	R8gX/gMENj1XYdwE+Ikp8kwPP/tDySO1xxNdOeBNT0T6ODGefFiupLiJXD61k8aVOk06RC9u5i7
	6GJ2QCEggX63/Hq+X9BzXvYKVJfpPWI8=
X-Gm-Gg: AeBDiesbUaIXfTRg9HM68GdlBMVqJKK8fBHp7XvycsJrnHUv/mqRoqX9bL2k6stK3EW
	EEj/uXco7eHggTtwugTUMDP5wp7h4l4eG7ibPae/8Gy/FL5iHF3O7fuu/ANbDg1pAeCIHyP25fQ
	dMwUo7z0+Fty30qiP+1fkJRFBcRxKKwX0cdlXrm/VInXNISDSHTrIRN6UF5pwJ1YmUiK839Q6ou
	URs6IC2nMHbFMTnWsHxyOA9X/XPeaL5cFLXfqop+MPs/LbqKbSVqQ8zpvlsZoYb7K1yO+7B9aFm
	KNZ769he/jf+aorEqh0G5qvO4aL+zlslI3g9Ris8js07Q9Ux
X-Received: by 2002:a05:6808:bc3:b0:47c:34fd:d3be with SMTP id
 5614622812f47-47c62120f95mr2972379b6e.25.1777646395848; Fri, 01 May 2026
 07:39:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260430062033.20428-1-devnexen@gmail.com> <20260501130046.16008-1-devnexen@gmail.com>
 <ba78786c-881e-4cf4-91d1-7e9d21194454@gmail.com>
In-Reply-To: <ba78786c-881e-4cf4-91d1-7e9d21194454@gmail.com>
From: David CARLIER <devnexen@gmail.com>
Date: Fri, 1 May 2026 15:39:43 +0100
X-Gm-Features: AVHnY4JZoZ6HEd13u2rB4qAfp7JhHIIU5be_x8vaILgtsy2LYp44cmL4Y3uE-e4
Message-ID: <CA+XhMqxJoSVkoOOqM8idGJD1TFxb7ksQesQZ8R27BTU7Kg6DdQ@mail.gmail.com>
Subject: Re: [PATCH net v2] psp: strip variable-length PSP header in psp_dev_rcv()
To: Daniel Zahka <daniel.zahka@gmail.com>
Cc: kuba@kernel.org, willemdebruijn.kernel@gmail.com, davem@davemloft.net, 
	edumazet@google.com, pabeni@redhat.com, horms@kernel.org, raeds@nvidia.com, 
	kees@kernel.org, cratiu@nvidia.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 4C7794AD559
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-242447-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnexen@gmail.com,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,davemloft.net,google.com,redhat.com,nvidia.com,vger.kernel.org];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

On Fri, 1 May 2026 at 15:13, Daniel Zahka <daniel.zahka@gmail.com> wrote:
>
>
> On 5/1/26 9:00 AM, David Carlier wrote:
> > psp_dev_rcv() unconditionally removes a fixed PSP_ENCAP_HLEN, even
> > when psph->hdrlen indicates that the PSP header carries optional
> > fields. A frame whose PSP header advertises a non-zero VC or any
> > extension would therefore be silently mis-decapsulated: option bytes
> > would spill into the inner packet head and downstream parsing would
> > fail on a corrupted skb.
> >
> > Compute the full PSP header length from psph->hdrlen, pull the
> > optional bytes into the linear region, and strip the whole header
> > when decapsulating. Optional fields (VC, ...) are still ignored,
> > just discarded with the rest of the header instead of leaking.
> > crypt_offset and the VIRT flag are intentionally not validated here
> > - callers know their device's PSP implementation and can decide.
> >
> > Both in-tree callers gate on hardware-validated PSP, so this is a
> > correctness fix rather than a reachable corruption path under
> > current configurations.
> >
> > Fixes: 0eddb8023cee ("psp: provide decapsulation and receive helper for drivers")
> > Suggested-by: Daniel Zahka <daniel.zahka@gmail.com>
>
>
> No need for the suggested tag here.
>
>
> > Cc: stable@vger.kernel.org
> > Signed-off-by: David Carlier <devnexen@gmail.com>
> > ---
> > v1 -> v2 (per Daniel Zahka):
> >    - strip the variable-length PSP header (psph->hdrlen) instead of
> >      rejecting opt-bearing frames; VC/options are ignored, not refused
> >    - drop the crypt_offset and PSPHDR_VERFL_VIRT checks
> >    - refresh kerneldoc above psp_dev_rcv()
> >    - retarget at net (was net-next)
> >
> >   net/psp/psp_main.c | 41 +++++++++++++++++++++++++++++++----------
> >   1 file changed, 31 insertions(+), 10 deletions(-)
> >
> > diff --git a/net/psp/psp_main.c b/net/psp/psp_main.c
> > index 9508b6c38003..b040345d7273 100644
> > --- a/net/psp/psp_main.c
> > +++ b/net/psp/psp_main.c
> > @@ -263,15 +263,17 @@ EXPORT_SYMBOL(psp_dev_encapsulate);
> >
> >   /* Receive handler for PSP packets.
> >    *
> > - * Presently it accepts only already-authenticated packets and does not
> > - * support optional fields, such as virtualization cookies. The caller should
> > - * ensure that skb->data is pointing to the mac header, and that skb->mac_len
> > - * is set. This function does not currently adjust skb->csum (CHECKSUM_COMPLETE
> > - * is not supported).
> > + * Accepts only already-authenticated packets. The full PSP header is
> > + * stripped according to psph->hdrlen; any optional fields it advertises
> > + * (virtualization cookies, etc.) are ignored and discarded along with the
> > + * rest of the header. The caller should ensure that skb->data is pointing
> > + * to the mac header, and that skb->mac_len is set. This function does not
> > + * currently adjust skb->csum (CHECKSUM_COMPLETE is not supported).
> >    */
> >   int psp_dev_rcv(struct sk_buff *skb, u16 dev_id, u8 generation, bool strip_icv)
> >   {
> >       int l2_hlen = 0, l3_hlen, encap;
> > +     u32 psp_hdr_len;
>
>
> There is a style convention in the networking subsystem that
> declarations are sorted longest to shortest from top to bottom. Let's
> maintain that here.
>
> nit: int psp_hlen might be more consistent with the types/names of the
> other local vars.
>
>
> >       struct psp_skb_ext *pse;
> >       struct psphdr *psph;
> >       struct ethhdr *eth;
> > @@ -312,18 +314,36 @@ int psp_dev_rcv(struct sk_buff *skb, u16 dev_id, u8 generation, bool strip_icv)
> >       if (unlikely(uh->dest != htons(PSP_DEFAULT_UDP_PORT)))
> >               return -EINVAL;
> >
> > -     pse = skb_ext_add(skb, SKB_EXT_PSP);
> > -     if (!pse)
> > +     psph = (struct psphdr *)(skb->data + l2_hlen + l3_hlen +
> > +                              sizeof(struct udphdr));
> > +
> > +     /* Strip the full PSP header per psph->hdrlen; VC/options are pulled
> > +      * into the linear region only so they can be discarded with the
> > +      * rest of the header.
> > +      */
> > +     psp_hdr_len = ((u32)psph->hdrlen + 1) * 8;
>
>
> I don't believe casting psph->hdrlen to u32 is necessary for correctness
> here.
>
>
> > +
> > +     if (unlikely(psp_hdr_len < sizeof(struct psphdr)))
> > +             return -EINVAL;
> > +
> > +     if (psp_hdr_len > sizeof(struct psphdr) &&
> > +         !pskb_may_pull(skb, l2_hlen + l3_hlen +
> > +                             sizeof(struct udphdr) + psp_hdr_len))
> >               return -EINVAL;
> >
> >       psph = (struct psphdr *)(skb->data + l2_hlen + l3_hlen +
> >                                sizeof(struct udphdr));
> > +
> > +     pse = skb_ext_add(skb, SKB_EXT_PSP);
> > +     if (!pse)
> > +             return -EINVAL;
> > +
> >       pse->spi = psph->spi;
> >       pse->dev_id = dev_id;
> >       pse->generation = generation;
> >       pse->version = FIELD_GET(PSPHDR_VERFL_VERSION, psph->verfl);
> >
> > -     encap = PSP_ENCAP_HLEN;
> > +     encap = sizeof(struct udphdr) + psp_hdr_len;
> >       encap += strip_icv ? PSP_TRL_SIZE : 0;
> >
> >       if (proto == htons(ETH_P_IP)) {
> > @@ -340,8 +360,9 @@ int psp_dev_rcv(struct sk_buff *skb, u16 dev_id, u8 generation, bool strip_icv)
> >               ipv6h->payload_len = htons(ntohs(ipv6h->payload_len) - encap);
> >       }
> >
> > -     memmove(skb->data + PSP_ENCAP_HLEN, skb->data, l2_hlen + l3_hlen);
> > -     skb_pull(skb, PSP_ENCAP_HLEN);
> > +     memmove(skb->data + sizeof(struct udphdr) + psp_hdr_len,
> > +             skb->data, l2_hlen + l3_hlen);
> > +     skb_pull(skb, sizeof(struct udphdr) + psp_hdr_len);
> >
> >       if (strip_icv)
> >               pskb_trim(skb, skb->len - PSP_TRL_SIZE);
>
>
> Minor comments, but otherwise lgtm.
>
> Reviewed-by: Daniel Zahka <daniel.zahka@gmail.com>
>

ACK, will resend tomorrow, Cheers !

