Return-Path: <stable+bounces-249736-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SCbfEUEoDWo8twUAu9opvQ
	(envelope-from <stable+bounces-249736-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 05:19:29 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E3397587284
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 05:19:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DDBBF306E9D4
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 03:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D6463264EF;
	Wed, 20 May 2026 03:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q2uVP65B"
X-Original-To: stable@vger.kernel.org
Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1262F5A36
	for <stable@vger.kernel.org>; Wed, 20 May 2026 03:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779247165; cv=pass; b=LXOvqPnd0IfPSfbuCgzlhL3F/GtCIyxwZ+FHZ2tDm3lNJQKib8PJ8aQCXBoQlJr1GjT6yQLlKWGJxdnWpTp+tSzVMJF5Ec1jBdlGQwLwtJ8yDboBgirLE33sZTPZxT3i/Jr+GxXmaAwUazSbTzHZOs5ffG4UhkpgJhxOcUxzDj0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779247165; c=relaxed/simple;
	bh=sNG+6bFeLw1iBghaaykGtH9JRexVRArkpWpqbiV/EEY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eRQ53pQhwPhfssTgJ0rKB28Y57EVsCdffZiGwE4Ukd3MGHAi8MTqvP2LP2hwQ/aGhEQvcnaAzYQMWO18eJEq1c0OvHZEDrw3jfK/7xwKoeHRnkuRRhAjAIqMVBr8ZWbqR4fjJSelKvYz+G10lKCFczNaPz/7SY/be29yHCuz+Gs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q2uVP65B; arc=pass smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-65c3ea2ebf7so5056304d50.0
        for <stable@vger.kernel.org>; Tue, 19 May 2026 20:19:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779247163; cv=none;
        d=google.com; s=arc-20240605;
        b=Jmg5xwxU82/qO+mBRkTAeNlQsAsMiG4QbAxfmzxvP/IMnIYTaY0qEkggP+aL3k6d1K
         y7Om5GGQrUgZffMS+NsPiNfFF9Jv12Twf1A9+TplrF5lx+GKZDnRoBpbCEBMs29LEYaU
         HURV8LvK6gEZ6j4AxO0xlqwMPRbObGtbs92J3c0EhY/LKhKufcodAP7pL05uF+BmaHO2
         9xvuebmCt49Oa/vPJpcPYTfPWiSKz7fvSD/KMfeEJGhH2hrp8PtUxMXyJbd4CxECt/EQ
         poMiJGL/8XyuBWXufSLhqZO0plixGqPEiuGlD9PTHE8Cko8930aMZ4Z/vAN/ZZMbSHf6
         g0EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sNG+6bFeLw1iBghaaykGtH9JRexVRArkpWpqbiV/EEY=;
        fh=N2QecnMBeT4x3QFmIrTwjEqZgJsCDeQwtYIWWrm1eSc=;
        b=Yuuu0jFP+NGSvT72tsN3vt2OW37sHumZc47mIvr2PNXoS8w00cr9hdbdtF3DRM4m13
         RFv73BgYmVN8VVICic6vZ1OfS4pJNsasVag/RJUD847UaBpVFV3a/88XhPgTmGj1Weon
         3YgmdwENwSdfYJI0z0cWhPlxMdIgJ78Phg44xzCiIWZmoxUWOFTc7bBBbEsdQVWzxkan
         fdEbIaA7SS7rsr2uIMAOsYqQ5W+ZMXEcvMfgfn8QaPYV3Fac0kP0hhbnnNAoraPLVHe+
         KM1BgBUrdzplR3RAL20YrEgHRFpWXsDLEgHqIMTQBReNH7zjwcSqlj9JlT4+cQzmTf9Q
         kJaw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779247163; x=1779851963; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sNG+6bFeLw1iBghaaykGtH9JRexVRArkpWpqbiV/EEY=;
        b=Q2uVP65B9wMU0pExsDHv/BKqXUgUi8A4I4aQgJsGjVM5Uf9t/kMRqGocpY6E6+IMWL
         jWDdKRmHWzlgbgPY0bx2LUkWf9kbUmsqB1BxLaOXU1MBT0ZpYkrHKl4EoN0OiTpzqbiX
         ZmCnpyiXhD92yKhZQL1cLifFyk3IDi8QU0WhO95DzpeBwZKHwwoedDYy+V29cCR9TozT
         Z2lVCRGnKtDe+olS1ubO+gziE6xwjE35R+AiZhky6QwBOdYTaWIm4b6C3R7HroFERBGG
         hF/HPYqW2KQsF8WgKO+ktqHs+EJfnIf/6iN5TO6kIk0Y1cBll5wdstPF1xj2ACjZwoRV
         RYSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779247163; x=1779851963;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sNG+6bFeLw1iBghaaykGtH9JRexVRArkpWpqbiV/EEY=;
        b=RME+hdITf4jZP9eOj/JaT00VA6QF5L9di9M6mEA6Nn9nRbGQwNOwmTEpgs8D14mPHD
         sVHjSXsHasQrs0tamUKbAxopNvrWOAzyrphrcNIFPJWCKCukHtLdXzD/yNHib+dd3wLd
         +/YLLvpysYZIwmOrubIbdvERktVp7tHqQ0yU8InEVfIHe+dp0low+5eSSLpCFACWC8/5
         lYW+ZbAYXXKpxsOjLjlN4KRQNJWh9bvOp7uvD2PxnMQTw0U1jD0OLVkaTqa6Dy3MeUJj
         ze+PntHfqYRGClIwBpQiGseBdfFSwcYbRMV5MtbzVsAJg0mm8CXoG4yG4sxHcs0Mwsts
         jMTA==
X-Forwarded-Encrypted: i=1; AFNElJ+IKnypptUy4gqedNYfmNYKUMvBd2Y8J8lLMnQjFaqtDMuRDW4Aj84eakH86SYHDJLFqHQH9Ao=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+40qcXP6g9V/N3urJp+LSR5xp0m15ouCSen7TknspYpn2Bb2Q
	H7xtXFMv7NxBOuTfo2FWopEJhgYEye0t2NIaEgHSqu3qN31EP160wvnZfx0IDzLzSdMhy3C5gzr
	2UlfA7WLnZLiEMjBiWYvoxxZz9kiNEmU=
X-Gm-Gg: Acq92OHhdkPnWShnEbOxehzxeopNsxyHjUOxqXYR2+nqIrbs80pS+KQiaICPAXBBW1m
	AvR/LSCYyg5TIM+BbfCRDWTBVe6P4o2DEIMoVwZ8FADmKPCWJxkE1iCcLXLMvEAgglGCuLrJ49/
	5lsvCKw714N/co/r3/nyT3k+yIzq4ei+P5+aPeL5lH6wgPrLZORPy07XssPK1lj7hX+heoFH//F
	zJhWFHcjdtVNHlaxUKvqebQuQK94NARJ+z21KERIyFCuSIs8AcL9DSx3a+n9SwnsterIRGgXWR0
	6Hu1
X-Received: by 2002:a53:d04a:0:20b0:65c:409b:1cc with SMTP id
 956f58d0204a3-65e227f76c7mr18434081d50.34.1779247162882; Tue, 19 May 2026
 20:19:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260520024153.1647951-1-xinyuili@126.com>
In-Reply-To: <20260520024153.1647951-1-xinyuili@126.com>
From: Maxwell Doose <m32285159@gmail.com>
Date: Tue, 19 May 2026 22:19:12 -0500
X-Gm-Features: AVHnY4K9ybD5EuFHYUdUilJnfUZs0eOI1mGWy_JDtoGhlYPGCYUVHFjVsnL9-oo
Message-ID: <CAKqfh0GLQ=OZYnhNHNc1Cm5X-ZRzs3vGeM0ojCRnOxuLM2hn2A@mail.gmail.com>
Subject: Re: [PATCH] iio: gyro: mpu3050: use devm_iio_trigger_register
To: lixinyu <xinyuili@126.com>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Linus Walleij <linusw@kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249736-lists,stable=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[126.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[m32285159@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: E3397587284
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 19, 2026 at 9:43=E2=80=AFPM lixinyu <xinyuili@126.com> wrote:
>
> mpu3050_trigger_probe() allocates the DRDY trigger with
> devm_iio_trigger_alloc() but registers it with plain
> iio_trigger_register(). The remove callback calls free_irq()
> on the trigger but never calls iio_trigger_unregister(), so on
> module unload the trigger remains in the global trigger list
> while its memory is freed by devm, leaving a dangling entry.
>
> Switch to devm_iio_trigger_register() so the registration is
> undone automatically in the same devm scope as the allocation.
>
> Fixes: 3904b28efb2c ("iio: gyro: Add driver for the MPU-3050 gyroscope")
> Cc: stable@vger.kernel.org
> Signed-off-by: lixinyu <xinyuili@126.com>

Hm...this signed-off-by doesn't look right (unless, of course,
"lixinyu" is your real name and not "Li Xinyu" or something like
that). Please correct if you send v2.

best regards,
max

