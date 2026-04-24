Return-Path: <stable+bounces-240547-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mKlzCfrG6mlfDgAAu9opvQ
	(envelope-from <stable+bounces-240547-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 03:27:22 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 57957458B5D
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 03:27:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F2364300C5A9
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 01:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 468BB23EAB0;
	Fri, 24 Apr 2026 01:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qcAn7kqo"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C28FA1A9F96
	for <stable@vger.kernel.org>; Fri, 24 Apr 2026 01:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776994039; cv=pass; b=aguXNdAT5eV0+dl5L+x/Ew3Fl0+XY36uBmvRYYQsFGq4exKDssaKkaSJJiQlK3wVaGuqr79IY/wotV9p4KNW5ZI6sz1SCJ7deRTrpDHdiBD09ZUpJZe+KSC0uLc5rvmJCdzjcT9rJJHxvLGqHuJzyFzS3qsAx5twvShuWxp3al0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776994039; c=relaxed/simple;
	bh=P8CrcBNyuD0EXJ3oU77h+9EZ6+vBM8t5CK+EywCDcNE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ocq/dSC0mBSiLtAltVcjJ53I0WjldvSXq5fGj4cDhcpqI2rhRiXFIW+NsxZT4ymE8Zid+aM4Fe+NfZGK+E0j2+FFrOP+Bsev4VB7CnU9R20f42mZ6I1zQiM3dj60HmrCJ/vmeKz6AvhfEWBQ1KWRoP1YASP3fKhqGRuDxbcm4L8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qcAn7kqo; arc=pass smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-35fb166b0c6so4132992a91.0
        for <stable@vger.kernel.org>; Thu, 23 Apr 2026 18:27:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776994037; cv=none;
        d=google.com; s=arc-20240605;
        b=JzmEh+ABXLJIVaroBKRmd0KjssYzZfToNEsTN1liejE4R8lytITlDSBrFXvyOfhzWk
         Za99oRlLiZ5IOmo4Bm2U4TS8jK1MDvATQ2KTwN+u7OEJHjfq+vvX0Ep2zrfj6JOGLZhy
         gcy+7FWljF0mACXaAD0g0QyvdPjeJgVMC6lBLJAblgMHhFKpSeLQN+uQyENBn50alUoT
         klYqAMojs+n4tMSsbeKiIH8Hxlt0CGnxdLisI9dnE3kdhNWxrAhLfFWcLPaW9q5Ua/W+
         8R4Lybb5EcqdjCnvN8WHyKVF/COvTWnkmVtWKVhyhFzr7LsN99Sn7En/ndpTYi3PM64v
         XXGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/JFz7/atFKKa6Hg5z6nTuES4M46dTzQ7QvOnxwxtvc8=;
        fh=GJPSVVIn+30VLIwi5Db/cbTC+u+whxk8jeep2G3lKa8=;
        b=kK4rbc+T3BIzZNezlCu9IgF1z1O/aPZ03+Q6+4nMd6RXor6zMCfISd2w0pdT33sLUw
         PaB7qQv5yaxz8zAvGrGzIiExbm1hUwJXAojJJyz6GD5ZG9FLqduRtiHcjBLqDE6Kk/4G
         sCZ363zgh7QGKUBn5Dn9VLX10zvqPXhN28SgtW3kCL3h2UZmWEnd2uVVnmH9PW36Xnuq
         HSvFqyoRAL5xYVLIzLAck1Q/vQKevwbWwPmGg0Hwg8Y0Xh9vHrHV26+818/JzYc46fdg
         qLv0lVFmEZ52WzE8xODd/TPx/nxfWQS/rOOVR8l1k8KvaG3iE2UIvUTdTy8yoU7GvBmI
         RX+Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776994037; x=1777598837; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/JFz7/atFKKa6Hg5z6nTuES4M46dTzQ7QvOnxwxtvc8=;
        b=qcAn7kqoI784fayv0J4ki2in6onFryd6lFCoYqjVFD0cy1H3kzuO7WXaMDeXr7QLJs
         y48rsiA46+levV+T7L8ZEkXK3GxuIfX4ouDqaZgPU4WA8yT3dZwqoDvLWWQm114LJ1dp
         n2V34ShbP+nZ9Ij/9FmcUxEa4NrFWA7JwRAtRxvnTG5pEll/A5x7D6HLwA0XgYRcTdI5
         +CItUoddsawRpObi10oKdkZuDToewVZn4nkfdOWgKoTj3cck+z0U7C8hKbbCCpGkdbFz
         mCVlcT6AvQlRTXO/PISSeOxLM4kVY6Njc1TdsvBo/VVe7nUR9Z73W2toVcvIe0/FhfQt
         39DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776994037; x=1777598837;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/JFz7/atFKKa6Hg5z6nTuES4M46dTzQ7QvOnxwxtvc8=;
        b=nYOSJQK/6wDXW1TaONyNAky/EumaN4HtbsGilp4AGkkd02Q8scEsNUVG5HaF/6QS4W
         PoWpvXp2bFICi//rMY+QvS7+dYs74YUUtm+ReGU2CKvF9TiRDyC8KsCVPu1WVDr8cPWK
         LWpTPwg7tAosjdh1XSoudzF0SAjR8z6LDUSu4fl7wz/QnAeG4e5jDHNhkVdBj7XYl+Vk
         3Vd1R4eHKiWxxr6XuNJE5miSY8Nu8unQgeJJh9LLRPU0EgulslawS+SspRCrPH1xahfZ
         cPRmBAU8+XZAkA7XmBYzMJWA8lzfaflh5wGnrLTXrSb02VvAiQPiZj8QJzNoXf9vVvm1
         Vdxw==
X-Forwarded-Encrypted: i=1; AFNElJ+lAiom1hC0nWFoyZZi8+rEdHt83eWgZ5GZuhhzzE6Aa9aVIqWkaWjTKHFRrQyQwmYu97ACr4E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyDlB8LTv1eHXgyjrCquyh3UaJoTC6pzbwHarGkHibuSlzUMKZ
	Nmg+LolGjDQi6vQAlfUlZlDdyFVKrQS4WEiz8ExtoZX81D3FBnvxM02XotQEBXqUuYb6UCNmc6G
	7zV4SVcyWy/VAkeLJshH4v15b39oNUMadgg3xkgHS
X-Gm-Gg: AeBDiet8DQ8oztVIwFdJyQSWo7ggQzHvPATPXFG9XV5x1UeJroIuojUiWxBnfAQaWom
	E5Z0Ux5rELYeo6/3ffdwiBzLYUUgP3filLoNkZq4MqA87mmcufDJnf7YJhEd5/4Oe8W2o6u4jDd
	DolXhBJvmCn1WAVOqvMArVUoYE51mboUNt+BfoR4g4Opf8/VotPlSka6KE8PzbxgT+fwDy2f6HX
	CdCz26Y4uJYUC/B8wtnlj13bui7bXnWVItEFuKkRBZVBm6RhlrB8dq8KOlnvYAVdO40sukC5ZMo
	NiZza1OrnZ9iWSIWCiYdcQaoWe16VVyCw4+SPLL/xIYzokj5tft+fQuFLg==
X-Received: by 2002:a17:90b:558e:b0:35f:c1cc:fee0 with SMTP id
 98e67ed59e1d1-36140290941mr19499419a91.8.1776994036645; Thu, 23 Apr 2026
 18:27:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260420171837.455487-1-hramamurthy@google.com> <20260420171837.455487-4-hramamurthy@google.com>
In-Reply-To: <20260420171837.455487-4-hramamurthy@google.com>
From: Pin-yen Lin <treapking@google.com>
Date: Thu, 23 Apr 2026 18:27:05 -0700
X-Gm-Features: AQROBzDKUrV_a--ZisFLZXpEGCggKgtRs207BgeNtBKiJ3TvnYZsvXcXguGHBMU
Message-ID: <CAHwYsirB8rkyuZ90h57OSC=MTW8L7Bs0GfJcHfA9PyJY-7DYaw@mail.gmail.com>
Subject: Re: [PATCH net 3/4] gve: Use default min ring size when device option
 values are 0
To: Harshitha Ramamurthy <hramamurthy@google.com>
Cc: netdev@vger.kernel.org, joshwash@google.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	willemb@google.com, maolson@google.com, nktgrg@google.com, jfraker@google.com, 
	ziweixiao@google.com, jacob.e.keller@intel.com, pkaligineedi@google.com, 
	shailend@google.com, jordanrhee@google.com, stable@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 57957458B5D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-240547-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Mon, Apr 20, 2026 at 10:18=E2=80=AFAM Harshitha Ramamurthy
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
> index b72cc0fa2ba2..57d898f6fa82 100644
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

Does this introduce an out-of-bounds read regression if the option length
is between 9 and 11?
The length check earlier in the switch case only ensures option_length is a=
t
least GVE_DEVICE_OPTION_NO_MIN_RING_SIZE (which is 8). The new condition
reads min_tx_ring_size, which sits at bytes 10-11 of the structure.
If an option length of 10 is provided, the condition would read past the
provided data length. Could this trigger a page fault if the option payload
happens to be placed at the very end of an unmapped DMA page boundary?
Could this introduce a time-of-check to time-of-use regression? Can these
values be modified by the device between this check and when they are used
later?
Since dev_op_modify_ring points into shared DMA memory, the values are
fetched here for validation. If the device alters the DMA memory to 0 after
this check has completed, would the driver bypass this validation when
applying the values later, leading to a minimum ring size of 0?
Does this introduce a logic regression by discarding a valid configuration
for one ring if the other ring's size is 0?
For example, if min_rx_ring_size is 0 but min_tx_ring_size is explicitly
configured to a valid size like 1024, setting a single default_min_ring_siz=
e
flag seems to force both rings to use their default fallback values instead
of evaluating their validity independently.

This should not be an issue because the GVNIC never returns an option
length between 9 and 11. Depending on the GVNIC version, it either
omits the ring sizes or includes both RX and TX ring sizes (even if
the values are 0).

>                         priv->default_min_ring_size =3D true;
>                 break;
>         case GVE_DEV_OPT_ID_FLOW_STEERING:
> --
> 2.54.0.rc0.605.g598a273b03-goog
>

Regards,
Pin-yen

