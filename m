Return-Path: <stable+bounces-241362-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cFLlL5yH72ksCQEAu9opvQ
	(envelope-from <stable+bounces-241362-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 17:58:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 48C8F475C04
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 17:58:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 764AD30ACE1D
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 15:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21BC03446CB;
	Mon, 27 Apr 2026 15:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Gso8sbxx"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B3651A6822
	for <stable@vger.kernel.org>; Mon, 27 Apr 2026 15:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777304339; cv=pass; b=hL6lpHRDXGZKfOg6r8YeONNb02llKTKR+gohgJeJS4tXOwkhxstn1cIMbQM8Apfxh8QbLZhyFq1QtC1bCRzRHXq8d7yVqxzye3SfOj/yxCHGEBZ33wyA3Yo99LK/QV4ExoePaFzgtMsUa+kKt+ilI8c1LHSBTCjG+ah1ujq2rfw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777304339; c=relaxed/simple;
	bh=PJZLfHYeasFj/n+WkgckJg+glyIiZqPAIbNFaCiLTY0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aKBzgjIlZvKp7JdZurB+ULSq9u73htR+toy+Z9z1qwIE+sIQ/ERp2Jjh3gGBU7l6QJW11Fg4VGfPZ8XyYnFm3WPuKs1R3tmZ7eN+/ZxhRKB2KCld7AcwZh46AzPN9Y5p0/A3HZW76O5B8YRd7UWKWimBwwIWuzCqL6GDKCWakPk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Gso8sbxx; arc=pass smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-50e594413c2so58735011cf.0
        for <stable@vger.kernel.org>; Mon, 27 Apr 2026 08:38:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777304337; cv=none;
        d=google.com; s=arc-20240605;
        b=FV0QHc5MzCNUuQ7hoxbUN6vPRdMtje0/Rcy6ts3w8bfHBLwqZbPsraFtPB2YzSRyBz
         M7MJ7m767yRdaxArReEiD75SMvEg4Ddfg7cHtnKfy+l+P1U84xFs+PTKx5BehEW/1E64
         hkRrmRbWAPgPXPMYMbuQOFxAn4UTSvBw3GrYE4nK0Sb9PaFsNzpISvGAj85ahaivBRFZ
         cbWJZaVC1/FuRntMkMmekMHBtQpY9KbDu7cED/o36HjNkDFB6KuFzwP2zZ9gg0nAfliu
         UQPV+WjBPPP3lynisUMVFwpKSDoNKx/FNVZHkBEAbdk1zo3oZmSWIhOIYP/+JSU1CKnf
         NrTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PJZLfHYeasFj/n+WkgckJg+glyIiZqPAIbNFaCiLTY0=;
        fh=C5BDBIvEtWcs0ONKAA0IxSRKpma9HnPUhrI0PDjXEk0=;
        b=lrLn6ViPcf76WQ+aJsGB5AcjUkEUxzcPAj0PMEbgP74P80X6fY5rbi/tjGQmGLs925
         4KRXScqrwezmeu9GqpZyxyKblqioR7+TMKh2dmWHdtNOzG8dSKOcmqwOZVqvmIi0ICK6
         QXwEEVNeSpHeRdVDIBVir6kGacChVChIUtCLaRZf5TZ4cxKf0J7jXqtqtlanWfuGhKBO
         JsJsC4ZxCZQm8dAap7ygK0ixcjsZ4Sa+v5wA11VWpK8ebq9oxS6hw+BWyl3agi543Ajo
         5wkey5jLEckL05tsjDKd3/plTBJr0pKWVnIwBMZu4iIC3stER+qEpbAqoH75qFe5o3eV
         lxWA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777304337; x=1777909137; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PJZLfHYeasFj/n+WkgckJg+glyIiZqPAIbNFaCiLTY0=;
        b=Gso8sbxxdC1A0QODfkzXX2isVSjO2Ls2XkapJ3pPR9Ypy5slQJI0Kz64b5lKX/9uQm
         rZlNjBmqOzIIAVsrqfd6tGZE7Zit2odc3hNMC89hqgQ33cpkFNtArnEKh5fmNGTiKzwh
         WU0BM1PzF72aHggDkHZ5tB7F/nmduLF9VcUFZqwYo8GfkJzWuBnXEb51LP9JGpw0Ntf0
         XARU/UCVmvQz739zViYz2QRxGg5Q05dJ2UIXqfws6VJr55O/ySWqrCJJu2k16axFxXq/
         GjmKpsesZrZx6LI7xdw4p5NlKC/eLjtQSY4sy8EBO069/VM7BOFaZJXWNqMwxZFZ6yKj
         yhNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777304337; x=1777909137;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PJZLfHYeasFj/n+WkgckJg+glyIiZqPAIbNFaCiLTY0=;
        b=VoPmH5VS+7sJasSsXFoEWyJFyS+P9rSoD7MzDsz15NQ76o19bH5/6Rhzk8QzZNrcfZ
         R/jfuKLiK7XoJ6KNYQZ+APHM2I/MtavIIyP2GamsiMZCusykMhEJwX/cJthVLvhdtQMO
         D7ngYxJCBmOmReFf+U/8U3J6vw+p2fm0SHAl0qtvypPbCcYPTFQqQa4ucV4Eh4SC7pcM
         T+oJ5vK0ANvcodeXTYxaXflmBHhnoj9d2048ToLxh9HMmuyWGVoUN9I643FuAXb+0qj1
         YcxBhIYOtPdH8Z3JdiM/0vObNA7p76LTQ+p64nM/mSbsh4f3QI6TbCKrKdoCNx/Y+6wz
         /mtg==
X-Forwarded-Encrypted: i=1; AFNElJ+AQ8YpFEiP5x2R78TD+TlKI3+SEhl6K1A8VqO0bWbqzVH6NVINdDOfba7gpyHCoLhcfUMiWEA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yya8MDzozJNkJD+RY5fIBSDcZBa+5fTTUTaEorJgxy65L5Bt8rp
	eKhF1vXBm80+W1+96x785SInmOtgBWyE6d016qo7c51uKBDQRIcRIoyUT75n0CdZOK55CwodnWd
	opFK7maUUMQT78VWYgYeHFtQ7No4QXZhwQym2KYpN
X-Gm-Gg: AeBDievgef5EQ4hEMcphk51ChGYn39bYeIxWXrenK+IBbnJ5d4k201xIgsF3J7GWZ3p
	Bgl0Tji4VZ1eK14Qaojyk8oMbA8u2qAz/eVQnctaK493Ey7ylZU/jU2I3QvGbOlZ3Be3XOQ0DDq
	cB+rOyMF+Hlh+nAjHZpQuy1jUCGX65HXs1kcV5sod61FPHUdgM1oqUG63MvHe1ip+D2V2Z6XD9s
	PHxpSypODfhGrneUtBfh4RvaeerQmnYcUUpJok7nMkOgLGIhsFECFGtyGFEKdLoqTlwqeqKzlZU
	JKFNCt66fYec3qGTVIBwKzzjf5NZCGfZP82gKfO1kAjz4Oi+U3UAKZJLJ2p9Su67X+WgQqqPi7G
	lBUKUTld5
X-Received: by 2002:a05:622a:4cd:b0:50d:6fd3:421 with SMTP id
 d75a77b69052e-50e365f889fmr531349701cf.6.1777304336427; Mon, 27 Apr 2026
 08:38:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260427152756.1205-1-ankit-aj.jain@broadcom.com>
In-Reply-To: <20260427152756.1205-1-ankit-aj.jain@broadcom.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 27 Apr 2026 08:38:44 -0700
X-Gm-Features: AVHnY4KchnTjsLKiFJZLY86Lr0YZy6QaUQU6xemXPVc-qJuy8UrVFn_1GVaQpw0
Message-ID: <CANn89iJOTxeF30wO7+0GoLmMAZGpCq+JUM5EQe5siNfYzEtZkw@mail.gmail.com>
Subject: Re: [PATCH net] tcp: do not shrink window clamp when SO_RCVBUF is locked
To: Ankit Jain <ankit-aj.jain@broadcom.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, dsahern@kernel.org, 
	ncardwell@google.com, kuniyu@google.com, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, quic_stranche@quicinc.com, quic_subashab@quicinc.com, 
	linux-kernel@vger.kernel.org, karen.badiryan@broadcom.com, 
	ajay.kaher@broadcom.com, alexey.makhalov@broadcom.com, 
	vamsi-krishna.brahmajosyula@broadcom.com, yin.ding@broadcom.com, 
	tapas.kundu@broadcom.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 48C8F475C04
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-241362-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,broadcom.com:email]

On Mon, Apr 27, 2026 at 8:32=E2=80=AFAM Ankit Jain <ankit-aj.jain@broadcom.=
com> wrote:
>
> When an application explicitly sets SO_RCVBUF, the window clamp should
> not be dynamically recalculated based on the memory scaling_ratio.
>
> Currently, tcp_measure_rcv_mss() aggressively crushes the window clamp
> down when it sees a poor skb->len to skb->truesize ratio. If the
> application explicitly locked the buffer via SO_RCVBUF, this
> recalculation causes the advertised window to drop severely.
>
> If the window drops below the interface MSS, it triggers Silly Window
> Syndrome (SWS) avoidance on the sender. The sender defers transmission
> and drops the connection into a perpetual 200ms PROBE0 timer loop,
> drastically reducing throughput.
>
> This is highly reproducible on loopback interfaces (MTU 65536) using
> Java-based workloads (like Tomcat/GemFire) where the JVM sets SO_RCVBUF
> to 32K or 64K. The bloated loopback truesize forces the scaling ratio
> to drop, crushing the window clamp to ~26K, instantly triggering SWS
> stalls and causing gigabyte transfers to take minutes instead of
> milliseconds.
>
> Since the application locked the buffer, the kernel should respect the
> clamp boundary and not dynamically crush it based on runtime ratios.
>
> Fixes: a2cbb1603943 ("tcp: Update window clamping condition")
> Cc: stable@vger.kernel.org
> Reported-by: Karen Badiryan <karen.badiryan@broadcom.com>
> Signed-off-by: Ankit Jain <ankit-aj.jain@broadcom.com>

Make sure to add a selftests (in ./tools/testing/selftests/net/packetdrill/=
 )

Thanks.

