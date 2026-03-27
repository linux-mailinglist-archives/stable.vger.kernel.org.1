Return-Path: <stable+bounces-230718-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OJN3OlnqxmloQAUAu9opvQ
	(envelope-from <stable+bounces-230718-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 21:36:41 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A13CF34B177
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 21:36:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D67A4311C1A4
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 20:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF41E38F920;
	Fri, 27 Mar 2026 20:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="De2NAo2D"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208BA25A2DD
	for <stable@vger.kernel.org>; Fri, 27 Mar 2026 20:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774643098; cv=none; b=S9Vx9bexvP2aJTa03HnTxkDqqGxscJ7vpDgHiWWepAn0fjCCFin1gmxZ2o+8Aj5d+eR4sJjAcqLfe/aS0jXxfkhm0koDky6Ci+4AYKDoXnSxqmc0JVqy8YYLbETz5prhaLkfStdwz4QGhes76olaODlvdVyN3sMrPq6m7Z0NtF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774643098; c=relaxed/simple;
	bh=swThcw62wEd3H5pw5KNX3NWQmvNjefzJw7RWl41kJTk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NAtBAblIzxrs8kIFKtGOQbL9zx6SWlSuV8V7WsdYifEvSFDU4MmKmMHhqPT46CmXIr/zIPrlix/GIdDIUgegjiYfsKaj3fKMp0HIusDGk/MGPFY/m5gH0wNRvKYNSPnUzhF5OYP7OmS7L8uFt+ojJLaDfol+Fy+6gnwnmzX8jf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=De2NAo2D; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-66b582b72aaso677934a12.1
        for <stable@vger.kernel.org>; Fri, 27 Mar 2026 13:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1774643092; x=1775247892; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aW530qvB5irXoR+XfSPgDc8867LrOfDfRACII/Dw240=;
        b=De2NAo2DPnX3OkoxxdLar9X9QkOeLuQBPgPfpuj7pMwDVEqTzZnKc6zStDv6Ld//67
         snTWcQHHT2Xb4cfCXv6yGFVcxGrkkyzA8IePIY4o6crNIpeqAXE82+VjsO5BoZYi+Y0V
         8HLuLJ9jeA1WKremJN7aQp4HMhMsnslrtvBno=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774643092; x=1775247892;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aW530qvB5irXoR+XfSPgDc8867LrOfDfRACII/Dw240=;
        b=dkcgpowMd3KOiv96iFfzQn3QVh6SojJNfyS03BYVPIWWjicztYdSsYgKhtcjo3EFIj
         xCHKXnVaSYP+ugc24tfpcynrIX+F4qXfQY7zlZfywAGPm/2jAO2mbwoVA974MyFuYLdh
         0qA2WDGAZVpNc9ozjGfHbiCoWsRsdO4IsFpHEFcWFsbAAlPYa1W5+Vzd3DDAqfioFSHu
         f6O+FVWjzz0v7gAdtNCi9ECZFFmhp3O1/7RoFZL1MPUI4Dg/lrTzaTDGMKHnYUOBsKrq
         MK3zN3NzKV6/xkrmZkXuMx+w67HrHqrBP6CAR/26eM8GejrpJwafT6yoGc1qF/uX1R7J
         HUpg==
X-Forwarded-Encrypted: i=1; AJvYcCVkC8SCiQ4i7DfwCFO6wa0i7pVuy92b9u6MDSRJ6n6hsiipwi461c7iAR4uAbVu5SMAwmelx80=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzj5uWv/t0KQtgmGvM9AoYp+IgOByc59wa+5RCeD1A4ZK4LnFbv
	C2NV5tz98Banqx9/PAafNCZU+W3IUXTd5r+HEXiCtfDQWvVi7zVL0CjM8to29EuAMowB2CaBNLj
	pE62GjA==
X-Gm-Gg: ATEYQzyh36UQhfZi+Eo+XKIYYpBTbhDvdcs6S9HA35IvDDvJxV9siz2VF/5qFcsFevR
	wWW9KKlXDWTrh4mGBUZHXEgRlreqysvrBYYaDsIndPDV7zdn9tN7k2UmZemZtKna9dJ8Ht4YK5a
	lPZ5ZSX1X0y+wk9vi+Wxor3+i3AL1zq4Aw4xy49rDtrod1PghzdKDGDXlqRCyxZusar60SppfCG
	tC3McIZDiXna2wD07KTnSZP9VB5rgynh5TSlCm0OWJ+XraAFsgacoA9eqhfaTtCn5+fakuzrhHu
	YHwbLM9a5Vjhp0t6KVJUT8d6dx3N1Hr0+ICpn1uAJCjiEKQ8SzmmutdJaQxFQFgCWX1Kx3r7Zsg
	Ehx1nwuLE0cD1bYCRXPS/JikYPUsr+GQlwWeieA1IicpFQeX983q9JivGSPl48sW/QBFtE0E82R
	7BFM+NK9h+hyjauCns/LJmgQZ5OtpPdAJg2Hs03qdyTJfwSB3RFthWNHWduvcXGw==
X-Received: by 2002:a05:6402:20d9:b0:669:4aad:6338 with SMTP id 4fb4d7f45d1cf-66b2855fb18mr2006220a12.8.1774643091907;
        Fri, 27 Mar 2026 13:24:51 -0700 (PDT)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com. [209.85.128.54])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-66b761851d4sm33474a12.31.2026.03.27.13.24.50
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Mar 2026 13:24:51 -0700 (PDT)
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-48374014a77so30492885e9.3
        for <stable@vger.kernel.org>; Fri, 27 Mar 2026 13:24:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUDM8epVs/6t71CQPOBrZ2NK3gUZSciEDrhI/15IgPZS3/m1BVllohQoJekQb1R65I0kUgLrDM=@vger.kernel.org
X-Received: by 2002:a05:600c:3b24:b0:485:6ec7:2df with SMTP id
 5b1f17b1804b1-48727d5f7a5mr61669335e9.8.1774643089905; Fri, 27 Mar 2026
 13:24:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260322171752.608486-1-jassisinghbrar@gmail.com>
In-Reply-To: <20260322171752.608486-1-jassisinghbrar@gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 27 Mar 2026 13:24:38 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VUOvwep2MeHfOzzH+a+QKtnnR5JhrfFXq7YGSyy-KNag@mail.gmail.com>
X-Gm-Features: AQROBzAYATlS_6ouS5s_yD1CPKYng7i69F-k_C5EZKwEWeb_CvOdWaEnKgnIilE
Message-ID: <CAD=FV=VUOvwep2MeHfOzzH+a+QKtnnR5JhrfFXq7YGSyy-KNag@mail.gmail.com>
Subject: Re: [PATCH] mailbox: Fix NULL message support in mbox_send_message()
To: jassisinghbrar@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	shawn.guo@linaro.org, maz@kernel.org, stable@vger.kernel.org, 
	andersson@kernel.org, tglx@kernel.org, joonwonkang@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[chromium.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[chromium.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[chromium.org:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230718-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dianders@chromium.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid,chromium.org:dkim,chromium.org:email]
X-Rspamd-Queue-Id: A13CF34B177
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Jassi,

On Sun, Mar 22, 2026 at 10:18=E2=80=AFAM <jassisinghbrar@gmail.com> wrote:
>
> From: Jassi Brar <jassisinghbrar@gmail.com>
>
> The active_req field serves double duty as both the "is a TX in
> flight" flag (NULL means idle) and the storage for the in-flight
> message pointer. When a client sends NULL via mbox_send_message(),
> active_req is set to NULL, which the framework misinterprets as
> "no active request". This breaks the TX state machine by:
>
>  - tx_tick() short-circuits on (!mssg), skipping the tx_done
>    callback and the tx_complete completion
>  - txdone_hrtimer() skips the channel entirely since active_req
>    is NULL, so poll-based TX-done detection never fires.
>
> Fix this by introducing a MBOX_NO_MSG sentinel value that means
> "no active request," freeing NULL to be valid message data. The
> sentinel is defined in the subsystem-internal mailbox.h so that
> controller drivers within drivers/mailbox/ can reference it, but
> it is not exposed to clients outside the subsystem.
>
> Fifteen in-tree callers send NULL (doorbell-style IPCs on Qualcomm,
> Tegra, TI, Xilinx, i.MX, SCMI, and PCC platforms). All were
> audited for regression:
>
>  - Most already work around the bug via knows_txdone=3Dtrue with a
>    manual mbox_client_txdone() call, making the framework's
>    tracking irrelevant. These are unaffected.
>
>  - Poll-based callers (Xilinx zynqmp/r5) are strictly better off:
>    the poll timer now correctly detects NULL-active channels
>    instead of silently skipping them.
>
>  - irq-qcom-mpm.c was a pre-existing bug -- the only Qualcomm
>    caller that omitted the knows_txdone + mbox_client_txdone()
>    pattern. Fixed in a companion commit ("irqchip/qcom-mpm: Fix
>    missing mailbox TX done acknowledgment").
>
>  - No caller sets both a tx_done callback and sends NULL, nor
>    combines tx_block=3Dtrue with NULL sends, so the newly reachable
>    callback/completion paths are never exercised.
>
> Also update tegra-hsp's flush callback, which directly inspects
> active_req to wait for the channel to drain: the old "!=3D NULL"
> check becomes "!=3D MBOX_NO_MSG", otherwise flush spins until
> timeout since the sentinel is non-NULL.
>
> The only tradeoff is that 'MBOX_NO_MSG' can not be used as a message
> by clients.
>
> Signed-off-by: Jassi Brar <jassisinghbrar@gmail.com>
> ---
>  drivers/mailbox/mailbox.c   | 13 +++++++------
>  drivers/mailbox/mailbox.h   |  3 +++
>  drivers/mailbox/tegra-hsp.c |  2 +-
>  3 files changed, 11 insertions(+), 7 deletions(-)

This looks reasonable to me. I have one nit, though. Can you please
add a snippet to the beginning of mbox_send_message() that looks like:

if (mssg =3D=3D MBOX_NO_MSG)
  return -EINVAL

I just want to ensure a client doesn't decide to simulate the
old/weird behavior by sending this sentinel value. ;-)

Other than that:

Reviewed-by: Douglas Anderson <dianders@chromium.org>


-Doug

