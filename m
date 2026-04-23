Return-Path: <stable+bounces-240414-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uNjlJBSo6WmzgQIAu9opvQ
	(envelope-from <stable+bounces-240414-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 07:03:16 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AC6844D20B
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 07:03:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B68DE3025F65
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 05:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB7F7375AAB;
	Thu, 23 Apr 2026 05:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jomhKgJW"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C7B3382FA
	for <stable@vger.kernel.org>; Thu, 23 Apr 2026 05:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776920591; cv=pass; b=NivGqh4qYHiiQ/1+rMUX+Lp7y5Pe74pUKTehIOM4TjbCW/wdeh2cISs5YsNofx4SLXZVsxxzVFlvCfGrzx6SfxpbRTgXoCG14SVgVSy1sbmFC1s+T88kAlztjv+XaKT4J6MJkHbifWokUIMIFHVfMdmuVcU70kp2+p8WbD2Uyms=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776920591; c=relaxed/simple;
	bh=VPV/8+ghMJHMGfdilEVpMeXbQfS5LlsZQbhRWyq4FM0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YQEE36Krovirv/5pO1Yolir/sMSZcPaV0orsWOsiD/4czSwc1Zk96D6JE49Oits5gYLZ2jSzqhNa+eP9ikM1SZXb/vtP/PdrohZ+0L4BJQzOM8A+IH4tJw+uT1GZ1Q5c8NKNv2EcPA8m7TqaA+9sw57PvLpjRn3iuwU/Elya52Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jomhKgJW; arc=pass smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-7baee75f874so40261677b3.2
        for <stable@vger.kernel.org>; Wed, 22 Apr 2026 22:03:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776920589; cv=none;
        d=google.com; s=arc-20240605;
        b=C5Y9Sf7ApsyrkQlWR8AmyE2v+bOXA9Vwl7EmJ9WCQyJPQ5Z1XBMbRt2ov46N/U4ivT
         KsvPFModCZnhi3kcyGsyaUMBosraq1E/gpgncYdveLt+ZNE3sA4raeMxjVT99dR3pH0f
         IKOI1rOwgYMcB4cLsE/f9xT24RS6dLuAxFcXjU6YeH6sy7xoFIF6msHsnjW9sZOt9/Mp
         2+NXZAgMrifS2m56BoJ2t37Use5KTWz94pg/KZ3IdrngjkS5T8wtOq0EP8kERr5IsKsn
         9jR2TtbHrI/c04tyHpVQBmmV+XBuV59gonnDSsKqVtUH3iwfrqIsqPRNgXVrNqVQFjr3
         pEwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CQ6Z9N0RH9PCOrW5N4GvU83a70fB98ANd9Z2VHC/QNU=;
        fh=oTPX/gAO1vwCErJCkXi8fkQzKerE+3nEyk9eeqKgo6A=;
        b=K4w3K6D2Py7mFDzrApgXkXaVYWGvE4eRVdQR6fqmPK/BhIeuSNhm0uvootODj6X61k
         qKKwErDREX1XC+ciM5apAgwkSByP26wYhSvuMbi6D8rpJ4wfMUUbCiYNk+KIGcA7HVnx
         97EjevZGGVXqvXUvFXCb2NpuHYQmBbwsFrwiIZa6n81AO8mP2uBfKg0AStxwutuBrPzn
         0JUKO4RGeF/fpzv+qaPjve/z4q7bsuqvgAKmpmwKcWQn8/k/IsCKAszIrcR1RQ/DRTZw
         jhT40xVcpmMeYik160yhf2OjSnKt4Gkybti4yNpDUp4HRyskMnrz0miXPTGijkKYsSob
         qxwg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776920589; x=1777525389; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CQ6Z9N0RH9PCOrW5N4GvU83a70fB98ANd9Z2VHC/QNU=;
        b=jomhKgJWLPkO2OoLXHNS8muVwtw2zfx+5Ortj3qf7DOccNYMID+Q5sUQ8LqWunjqWN
         H1JBh2PxMzYJC1mo0qdHT2ZyguY/4tjRJ9GctlV4CWQdyrDHDfoShK000jJAGF134xlc
         PzjHVOx64C+NMAf833KW15d0GhQAEKeTqkKYxceB95N5N4EEFtJbz9d/r5Xp0G9BOVDV
         IbBHQ5JpQj0xj9d0YpdqwqBsdjDKRhCBodtDGy34bmKUnfnN1V83nk91WwLcuxnB1tpV
         CRQe7RWH9oJpeRn8skNSWQEwfIiTeuCSsKAN9FMIfrNeG+T3aZ5zhzz21XlWeCXqQUeO
         ytXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776920589; x=1777525389;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CQ6Z9N0RH9PCOrW5N4GvU83a70fB98ANd9Z2VHC/QNU=;
        b=aYE9Lisfd9Lhu7REKnlP3zp18MH4XHaCAdUdBX4AgtOP6ypoCLlKnIQvw/82ay6kx2
         q75pAjNoOWy8w62YFpV8OIwmJw8X595T0vG/XSvXxpF2Dg95sUFw1g+wtp/K6QYCRLTR
         s6R1RPvZ2B5QmeJglcnCbj+6P8EUzA5N5Bv3R4NQ3t47JfurZKp4sueNVY6lSXhXTEmt
         d7Sb0dtlRnhEpXITj6kvTEK8A7cEnzwLYgnrgW0L24ohui0HIgr8Gu8zl5HiTpURwhqn
         6nR5GRjbnwJOrMwI4+ds7G2kDsolq4n4NdolOHEs8XYRtG8TVj/7l49bzQ9JriBYtkxa
         UNWg==
X-Forwarded-Encrypted: i=1; AFNElJ+ITMc5Cc+l4m/93Y44viNdIvI87Z2o/bhSe8nomo4vDzJ6aFz5hxAOj5e0re2fYO3+RHFKt60=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzwUK0rnmA2eipDJrhjhDy1PCbI81rxLtiYSE4Z8On2qembc82
	xBTxoBYQPRWms1iG0zvTsESmVyw3BMlQC3+EyAPBFVa63i1r4mmlYFV8uWVCxo0CosNCTnHbFxk
	fxF33O2oenIQiYlVhRZsjCNPs4tXUptQ=
X-Gm-Gg: AeBDiesvdgwnGnHrXf24wYWhdJQBH3p0DnJw+yViMF8B5qsiCFzJRGX64sZMBh2CI5N
	xGBxPZZmuliBMVL4G3u3q5fn2hqyqdqx/Ns3ZWMZJH1Z3E8BqMPiEFdJzQ5pSfB5UJAdzL5I4vo
	/yf+1xXYQIkJj6/2JRIdMmJj7r//b71q8EIbH/Ps2iz9D2xBxeMUy2oW36xGpJ2GQ1ZNa/6np2g
	0FvVs6gKpjdipJ7sCqUWTIqDKJ+GcV8oE17wVzHZUBRfOe1bqmmWu6zbxCmP0Hg8+8KiZGmihQ+
	9oCKqjVf8d+inUzllPTPV5tM9rmjURvci2r/b/IdjW390n0/98qhQMJa9e4Puro4SsjaHK3X7XE
	c5rVy7s8gCz9lapI14A==
X-Received: by 2002:a05:690c:39c:b0:79a:62a2:b3a6 with SMTP id
 00721157ae682-7b9ecf7af46mr262891557b3.29.1776920589177; Wed, 22 Apr 2026
 22:03:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260422144734.25650-1-kartikey406@gmail.com>
In-Reply-To: <20260422144734.25650-1-kartikey406@gmail.com>
From: Deepanshu Kartikey <kartikey406@gmail.com>
Date: Thu, 23 Apr 2026 10:32:54 +0530
X-Gm-Features: AQROBzC1PgJ3ghR_ZJB330xmBh116E1oJnt1HHUBQPY16fN21xSNK5uurKs1fkg
Message-ID: <CADhLXY5zm0JC2inT9OEWv=zFoW86=NvtT-80Mah7-gi0OFUruQ@mail.gmail.com>
Subject: Re: [PATCH v3] media: rtl2832: fix use-after-free in rtl2832_remove()
To: mchehab@kernel.org
Cc: kees@kernel.org, peda@axentia.se, wsa@kernel.org, crope@iki.fi, 
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, syzbot+019ced393ab913002b75@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-240414-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kartikey406@gmail.com,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable,019ced393ab913002b75];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 0AC6844D20B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 22, 2026 at 8:17=E2=80=AFPM Deepanshu Kartikey
<kartikey406@gmail.com> wrote:
>
> cancel_delayed_work_sync() is called before i2c_mux_del_adapters()
> in rtl2832_remove(). While the cancel waits for any running instance
> of i2c_gate_work to finish, it does not prevent the timer from being
> rescheduled by a concurrent thread.
>
> During probe, the r820t_attach() call attempts I2C transfers through
> the mux adapter. These transfers go through i2c_mux_master_xfer(),
> which calls rtl2832_deselect() after the transfer completes,
> rescheduling i2c_gate_work via schedule_delayed_work(). If this
> transfer is still in flight when rtl2832_remove() runs,
> rtl2832_deselect() can reschedule i2c_gate_work after it has been
> cancelled, causing a use-after-free when kfree(dev) is called.
>
> Fix this by calling i2c_mux_del_adapters() before
> cancel_delayed_work_sync(). Once the mux adapter is unregistered, no
> new I2C transfers can go through it, so rtl2832_deselect() can no
> longer reschedule i2c_gate_work. The subsequent
> cancel_delayed_work_sync() is then guaranteed to be final.
>
> Fixes: cddcc40b1b15 ("[media] rtl2832: convert to use an explicit i2c mux=
 core")
> Cc: stable@vger.kernel.org
> Reported-by: syzbot+019ced393ab913002b75@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D019ced393ab913002b75
> Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
> ---
> v3:
>   - Fix missing PATCH v2 prefix in subject line
> v2:
>   - Fix Signed-off-by email address (lowercase k)
>   - Add Cc: stable@vger.kernel.org for stable backport
> ---
>  drivers/media/dvb-frontends/rtl2832.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/media/dvb-frontends/rtl2832.c b/drivers/media/dvb-fr=
ontends/rtl2832.c
> index d8e1546aea5e..9898f729304a 100644
> --- a/drivers/media/dvb-frontends/rtl2832.c
> +++ b/drivers/media/dvb-frontends/rtl2832.c
> @@ -1115,10 +1115,10 @@ static void rtl2832_remove(struct i2c_client *cli=
ent)
>
>         dev_dbg(&client->dev, "\n");
>
> -       cancel_delayed_work_sync(&dev->i2c_gate_work);
> -
>         i2c_mux_del_adapters(dev->muxc);
>
> +       cancel_delayed_work_sync(&dev->i2c_gate_work);
> +
>         regmap_exit(dev->regmap);
>
>         kfree(dev);
> --
> 2.43.0
>

The CI report shows all tests passing (checkpatch, build,
media-patchstyle, ABI).
The only failure is "Job static" which has no log output, suggesting a
CI infrastructure issue rather than a problem with the patch.

Could a maintainer please take a look?

Thanks
Deepanshu

