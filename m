Return-Path: <stable+bounces-241442-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IJiMMzHJ72knGAEAu9opvQ
	(envelope-from <stable+bounces-241442-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 22:38:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3649647A1C1
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 22:38:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1EFD23020D5B
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 20:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5737037186F;
	Mon, 27 Apr 2026 20:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mvXwaBcV"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C681A36167F
	for <stable@vger.kernel.org>; Mon, 27 Apr 2026 20:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777322006; cv=pass; b=h4/WIvQojJn5qpXG6E+e1nrkEDHvsVi/ELSw3JVwBak8dAq+VtyBHwLuVIRk+iqIIeHggNDeXsbDKthN8OpNOE+VNWpz54PKuBwlYw36I52yk99AiixcSCigZPGLzalaGt/OBjpA2H13XpBPvijH8efGQl3YzlKPx2GGkmjO/sU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777322006; c=relaxed/simple;
	bh=CobAvn/jQGALxkNFzKl9iXP6Ja55B83/PV3wYG+HxX4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Uh0pVvsewHDu7wyYT6wXe7xnCTItI3gALpHFBC8yxm6BKijiyt1zwctFB8GrHfhEo38Bxncrf5UzRWBfP2PYTW5Us9oabyOGJ5cQoVW9+klBvpISPg1Z2PD2GH/9wIqnNbHf+fUTAwkwluuCVa3JaTKo5CxrnsqjgR6P4ZmmiV8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mvXwaBcV; arc=pass smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-56faf1cfe04so3144523e0c.3
        for <stable@vger.kernel.org>; Mon, 27 Apr 2026 13:33:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777322004; cv=none;
        d=google.com; s=arc-20240605;
        b=ENCtPg/CyFbMU18EVxfKMIobpWL7yt3Glrx0ff1Pu0/rmFPkcsi0xSk0rnsFdkd83/
         6bEakmxL5rCOAnC3/G3zMKCO4gdEDVpO6cu3Xab/G2AIDQzECbqRTMx4TlROLDJPoK//
         lxzLhg3chGRZq2SXoLTdMjDzaibMxfln0ykIYmSRnwHA6dAnQAgmRitlnBcBeZT+MOXj
         ylKbRvIdMMdNUYFYbb4+H2EMH4gVarlX0NZQEnRRNKqPx5cU+qgrZKxZxAtCKr5OHj9b
         BAecyccpGwEAMzHk50WcGvlSP2IK3eVcP67hxb8hvo+qDg6Q5K7dpV7TjGXLRt84Eta+
         CP7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+SstvA5AW/BxiN8uTf52BL5YEBmf06jlLuYINdEdE6c=;
        fh=He1KVTWzzeKeyfCuXWRMlvtIi5Q3iYR/K5ge3c+XNnY=;
        b=EzIxATevTxtct6piNprdnFakT3g4wC7ZHtVF7E2hkQPTce94Oo+tGsZ2vzW6GxnJUj
         oyhe8/md8qlTmiMS6HoHBAaATglGkzt63/ZOugQ7GAMyCMC6AHblmQEupqCxJ/RGwwxW
         RHAt/r2s9ymN5KeJR80hHqfur0p284EK047pHScRQHLcQL3KhIP2uiTYpkh7O7d3jfd3
         6/J1ChgbpMy1nxpxK3sQn/ZDOq36EReTeRYbExIeAybn+Zc+ixLpi3tABQ8HW+2q4dYD
         nJtjKJaAcPjGHbjPKB9vMCxIxxj6f4ywIELn2xQYgcffS0pBpaBSl89JgaUyfktlV6Rw
         Qmiw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777322004; x=1777926804; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+SstvA5AW/BxiN8uTf52BL5YEBmf06jlLuYINdEdE6c=;
        b=mvXwaBcVA5ri3TfJ7h76fNKEW+drwO5JQTG6EsZv5VFkAfRwV4slUjCdhIvR2CLfa9
         ZeIvHd7vKHRCBN9FGkMfnybFo7mkpJHJwQWnGi1kjnytp30jUdE9Cm13WiIvYmt6QDQx
         NvBNhxiZQUbqAzGZOeSG4sUuURku9RVJbOwiQwbSCB6RlIzEShfOju6QHqA/o0I8X00x
         whjwmjxQTE7Gmh1JTOrRTh/hOMQO2LY7yBemo42gwpQL8SFRQM05M+pgLUVN2LwdVj6A
         c1KAAvzD7uy66P13HgG2c3vfeMb5wD8dlbfWGCuCUfLdyA8xfmuVTFdEdm+uSVWeCcoT
         YKvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777322004; x=1777926804;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+SstvA5AW/BxiN8uTf52BL5YEBmf06jlLuYINdEdE6c=;
        b=Ns0pB0aj7FT8UT61O666XlzHFyE9fZuNg4zoe7tn+OgRZLECG68HMlU++ve5gFxxAi
         FgPpH1HZA/GY6KDhE6s18jUg8OSTJdQgg8UVGi55OH6qdET/yYaSjlO2LCPRWrK12fjC
         5FDZBVU2yag0njdpQx5MCsNlbotKn8LFaKSq3c1mD8S5VGYCdeckQA8ESXFgfRaWUy1v
         MdQULhU3rnTDlE2YI0uP8979lx9dAnqGzQ71+9yGvSQopkd1IJgeTar/uO3eXfrz3RZP
         r1XNS1GQwC7+Us/7mtG3XnQx0J6qm7+ZWZpzBflZiUzzCxU+H5SHFW1o20cKyNFdjO4V
         43bg==
X-Forwarded-Encrypted: i=1; AFNElJ9hAuwUObAyznI5A+fsTf7+gfCsDaWewHJJXsciBQ1nxSVQthNdJmuSbrWNvNdeb/eMRxKU2Qg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPA+mu5QsIW897GSMec9cYUBxrbMpqUukrBouweaacr7NgOg9i
	6f1mRx6pWIsW5HSBhKQSX8pCauCwQXaquIG/LEGqVIbe6bOtZUDZaqgT+WzyCdf52J+3D0hOptJ
	zFexytTgfwmKK+X7DqrMcpHpDip1MV8GrXz9Uhi0y
X-Gm-Gg: AeBDietliuiLcyPxLOKVkh2u5sa7+urXOefvJ0gT7al15L1h1/diyL6RQqo5anrcdfz
	l+ZUo8QE5k/Xp6IfMA+BqFLIc7Qlb0IJg+XrUNWhHodakfPxfdPMeK+o2mX/Z60h6ie4244eOvu
	8TWw08N/qpT8wvDWsVxTVIAI+pfdx1gIzzBx1lI52Idvl0bYRSDuhcsEiHiRiSVecY9AWKqVb/5
	SayJLp5wcD+dk8CM8vsrxg4gUpWds43PX3Am6CDL7SGEezZugwGFBaWolVapRjzb8kvfpOPCfY8
	vKrB2/bPapz9bc49Jjprnx5kTpVVaEzH1J0KLflCle7sZcQHdMgl/360GmM=
X-Received: by 2002:a05:6122:8cb:b0:56b:5e7e:d3fa with SMTP id
 71dfb90a1353d-573a55dc4e6mr142397e0c.7.1777322003187; Mon, 27 Apr 2026
 13:33:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260425002450.163421-1-hramamurthy@google.com> <20260425002450.163421-4-hramamurthy@google.com>
In-Reply-To: <20260425002450.163421-4-hramamurthy@google.com>
From: Pin-yen Lin <treapking@google.com>
Date: Mon, 27 Apr 2026 13:33:10 -0700
X-Gm-Features: AVHnY4IQZITODK5ibGdvChpzY0Tg9aR1g0ToRx_WbNw1myIw4KniYkh88AsedOM
Message-ID: <CAHwYsir6s21mHkR1wvsk1d0q68=oBB461MTncKFK97txH3Au0w@mail.gmail.com>
Subject: Re: [PATCH net v2 3/4] gve: Use default min ring size when device
 option values are 0
To: Harshitha Ramamurthy <hramamurthy@google.com>
Cc: netdev@vger.kernel.org, joshwash@google.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	willemb@google.com, maolson@google.com, nktgrg@google.com, jfraker@google.com, 
	ziweixiao@google.com, jacob.e.keller@intel.com, pkaligineedi@google.com, 
	shailend@google.com, jordanrhee@google.com, stable@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 3649647A1C1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-241442-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[treapking@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable,netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]

On Fri, Apr 24, 2026 at 5:25=E2=80=AFPM Harshitha Ramamurthy
<hramamurthy@google.com> wrote:
>
> From: Pin-yen Lin <treapking@google.com>
>
> On gvnic devices that support reporting minimum ring sizes, the device
> option always includes the min_(rx|tx)_ring_size fields, and the values
> will be 0 if they are not configured to be exposed. This makes the
> driver allow unexpected small ring size configurations from the
> userspace.
>
> Use the default ring size in the driver if the min ring sizes from the
> device option are 0.
>
> This was discovered by drivers/net/ring_reconfig.py selftest.
>
> Cc: stable@vger.kernel.org
> Fixes: ed4fb326947d ("gve: add support to read ring size ranges from the =
device")
> Reviewed-by: Joshua Washington <joshwash@google.com>
> Reviewed-by: Jordan Rhee <jordanrhee@google.com>
> Signed-off-by: Pin-yen Lin <treapking@google.com>
> Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
> ---
>  drivers/net/ethernet/google/gve/gve_adminq.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/google/gve/gve_adminq.c b/drivers/net/e=
thernet/google/gve/gve_adminq.c
> index 08587bf40ed4..2cd0dd6ced94 100644
> --- a/drivers/net/ethernet/google/gve/gve_adminq.c
> +++ b/drivers/net/ethernet/google/gve/gve_adminq.c
> @@ -189,7 +189,9 @@ void gve_parse_device_option(struct gve_priv *priv,
>                 *dev_op_modify_ring =3D (void *)(option + 1);
>
>                 /* device has not provided min ring size */
> -               if (option_length =3D=3D GVE_DEVICE_OPTION_NO_MIN_RING_SI=
ZE)
> +               if (option_length =3D=3D GVE_DEVICE_OPTION_NO_MIN_RING_SI=
ZE ||
> +                   be16_to_cpu((*dev_op_modify_ring)->min_rx_ring_size) =
=3D=3D 0 ||
> +                   be16_to_cpu((*dev_op_modify_ring)->min_tx_ring_size) =
=3D=3D 0)

Sashiko says:

Could this cause an out-of-bounds memory read when processing malformed
device option lengths?
Looking at the earlier validation in gve_parse_device_option() for
GVE_DEV_OPT_ID_MODIFY_RING, the length is only verified to be at least
GVE_DEVICE_OPTION_NO_MIN_RING_SIZE (8 bytes), while the full
struct gve_device_option_modify_ring is 12 bytes:
    if (option_length < GVE_DEVICE_OPTION_NO_MIN_RING_SIZE ||
        req_feat_mask !=3D GVE_DEV_OPT_REQ_FEAT_MASK_MODIFY_RING) {
If the device provides an option_length of 9, 10, or 11, the initial
option_length =3D=3D 8 check will evaluate to false. The code will then
evaluate the next conditions and read min_rx_ring_size and
min_tx_ring_size.
Since these fields are located at offsets 8-11, this reads past the end
of the provided option payload.
Because the descriptor buffer is allocated via a page-aligned dma_pool_allo=
c
of exactly GVE_ADMINQ_BUFFER_SIZE, if the malformed option ends exactly at
the page boundary, could this read cross into adjacent, potentially unmappe=
d
memory and result in a page fault?
Would it be safer to verify that option_length is large enough to contain
the minimum ring size fields before dereferencing them?

GVNIC will never return an option length of 9, 10, or 11, so this
shouldn't be an issue.
>                         priv->default_min_ring_size =3D true;
>                 break;
>         case GVE_DEV_OPT_ID_FLOW_STEERING:
> --
> 2.54.0.545.g6539524ca2-goog
>

Regards,
Pin-yen

