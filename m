Return-Path: <stable+bounces-249779-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oFm2LKlqDWqHxAUAu9opvQ
	(envelope-from <stable+bounces-249779-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 10:02:49 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 328FD589508
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 10:02:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BF497301E7F4
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 08:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29105369219;
	Wed, 20 May 2026 08:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mUk6DGpA"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A261C34B1A6
	for <stable@vger.kernel.org>; Wed, 20 May 2026 08:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779264163; cv=pass; b=sR1NKR3XKhXhgO3uwd2PtXwO8BkGWfKXraQTrsYI1r4EG0J6jml3FBAfSK41+joUjNEgZWwWUjjY/oqqFQG1nyyojjYzXO4HuOeAGx5eFePK+081acktrp9nt9goxhD1ftgr9ct+/XpDD6tfvLGv5dQKnC8KTKPVxrMQ0JK3k8Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779264163; c=relaxed/simple;
	bh=1/a4gL1PZz1slytsd4o4d8lYxRZ0OcTJf4YPwN0h7pk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FZ708Y5vB8YKwE1sWE41N+9S7rEzAc16OIChVUYS40BTjccsbymkWMn42wYfJTXdUpNeCfARZIf/GPR5tlFSFlMOIu8IztH2C+qTOERb1CBBAFI8UrSagrAWetOuhj4DR457U9/GlZ4WtckeITlV26EZtLyt4BkSpZmSHnC+Z4w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mUk6DGpA; arc=pass smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-479ef2b7979so3564493b6e.3
        for <stable@vger.kernel.org>; Wed, 20 May 2026 01:02:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779264161; cv=none;
        d=google.com; s=arc-20240605;
        b=Ht7/mdLjih2m3cS8Gx+41geRMCx1FZs0vGf+EqeuYq0P3Acl57+PYVPwmK0TgcQyEu
         kMz24t91XlyPkapBOgztH4Tp0VSbgzIt5Nfy2SXF78atLaLq8kOdmAYbCBSnO6UngKct
         TrhHwOYycYAEttxL+yTO/SQK43rSsazNjuUG4UtEwUGb0hVQHTL5wdyxU3xeVE3TwIX2
         g+6aU2EK3QMVp4C3zZXsk6MSvUzpSw7nrlzWw7OJFZcdWCSGXlMPQKp/P4Qtj8xTA1Hm
         xqa1xZPaZE7hnxthdxdkNwVPi9NTe7PGTgBTFvd0Wtl8vxwoVVNpw/MgRKF5+tDGWRpC
         Cq4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1/a4gL1PZz1slytsd4o4d8lYxRZ0OcTJf4YPwN0h7pk=;
        fh=3aXb0QOsef58J/DT3yQUzeGXfL8w964OSRJ0yOkkrXM=;
        b=Of4loYmjc18WqRer8WHaV9M8iLegM85lsfVd8pl7MZrqsd5THJpMO/qbNC83m/LWac
         vVle0L0Lxiov6MnG88HnnxUJSyM9KYvMeyRuaQmx7xXhLa08LlYhuR5Twv+npqb9FRKo
         6iDY3Inox33VxdS0SQSVpWNgPxcG3uTjVIgq6m0KsATy0qVH3EwZeXdZHBOuyizjAJQK
         Cy2y6h/ggdDQ9DkSiOfnz/5wtpClxFPZTk1OF5ysE1G84lS+RAsLvgt07oL3ShKzH9vY
         jAzviJZWGY8Q9fzj10OOPJ0Nj4eMGCl7eKJ+V0SLitkaUMZ2iNvXchDgRc9Dx1IGMjcq
         z73Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779264161; x=1779868961; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1/a4gL1PZz1slytsd4o4d8lYxRZ0OcTJf4YPwN0h7pk=;
        b=mUk6DGpA1Ue03dWnFJ4DWPhYDmO5VoToee+2uXT06ymRm9FFByjpUeIMlMFnRa+ZL1
         LV+/dG5AD0mAnkq0XitHp0F4euLbVl+KS0u2KCo/y9dtuCfPESFlTVNLNlKUzhg/NI5r
         HeRduZtz0sjHUT6O2Al2Q/1e8jyqzcLLSuro78lFD1sOLZac7IDEHZjHu9Yel7qLZtKz
         Mij7ue6uar/OJjYk8GAstk1rFIEqWh/nxUKCKNkXg8OVrLwIX8RQokldTp4m0LmrQ6ju
         1FqjsInPYO94iHi9ljny6mGPybnX+0UVlz77To0GLNh8duePgc1cF3CQxsHGfc6PN7MW
         225g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779264161; x=1779868961;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1/a4gL1PZz1slytsd4o4d8lYxRZ0OcTJf4YPwN0h7pk=;
        b=p5qBBA9//O7nqYuj8slquSgwBS3E+LZa1DTl99mjPw5Z4hiKRQTHxcAVS1y8RuEAFz
         Io0uyuzMC0wBdOtaQIe3Rsr5oprEmZg43lqrKT7nIURJ/BZm/hOxI0OvOOxHvU/ppy9I
         tDBwHBrO3Hklx57E0RN7CLiq311ebN8Ile4Ip7uPMVLUvdq2LI2RbHtcyCM5cxJtEbs2
         6cUgyRXLP4760VEGWUbsTn7STnUIWvaAdfdpz0MwaIdt4fl8rwdY9Bb8VE3bdypN5/qx
         cGKDwiOMc0Bp7RTRukDroM/nH+icTmUBtri99sQIcpiXNrG7ms4YdaLsCGWOl0HWtS26
         OdXQ==
X-Forwarded-Encrypted: i=1; AFNElJ/HkXBQ8pv/ZfL82fe5umJg/UNYvfkKypg6yX3SLmw2PEnAsiw7A2etYv3Qd+XkOyNsGq4wGds=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZG3vMS8EjYuEUVDspsrwZk/T0t3CKyjsQEw2H8ljscu50SofE
	kSUBkDZSQVRw/aackP7HB9+qIupSygZvPJyJ5mSiYk2EmRQxtnjZbYdwwYTIIIUev/qyGI1S5e7
	9MPyNpSgB6GQbRUu97wWhq/sIPpFkfaA=
X-Gm-Gg: Acq92OEh04Ddehqt/so8z94/ACrDmdSCqgYRWu+xmKc6NLCS0xbabkIfhZ2/ApxFH8t
	e026YBlggJFpSV9Ei9J/EDlSjRMQJZ6B4vKIBdYSi0ard7MidtOJK4xkDqUQmHiOhm7RHQyJQD4
	dbZQr0/iKbrYIaqgi4dWnXXCD7954JF0W3ftsb3AMFvsVIvsoN5QOcUkIImuBGbZY0mqqZWiddP
	MOpdcknTklykfl7r6FgH319UTAAeL8eKGOZpQRK13hm0o1QrhyHpAbL8p+zGcTtwJBNFuLgh185
	rA3Ne/KC
X-Received: by 2002:a05:6808:2388:b0:479:d779:353e with SMTP id
 5614622812f47-482e57c9a13mr16207337b6e.24.1779264161542; Wed, 20 May 2026
 01:02:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260518170147.13885-1-lucid_duck@justthetip.ca>
 <20260519235713.49109-1-lucid_duck@justthetip.ca> <20260519235713.49109-2-lucid_duck@justthetip.ca>
 <CA+bbHrUcwtNhatzV+ufa8O3Wrku2_W4-UL=3XMy4-kg9qiOdXw@mail.gmail.com> <a36b5712dd420da4090bfa8868e78b1b2b90c916.camel@sipsolutions.net>
In-Reply-To: <a36b5712dd420da4090bfa8868e78b1b2b90c916.camel@sipsolutions.net>
From: =?UTF-8?B?w5NzY2FyIEFsZm9uc28gRMOtYXo=?= <oscar.alfonso.diaz@gmail.com>
Date: Wed, 20 May 2026 10:02:30 +0200
X-Gm-Features: AVHnY4KgIzywot1ftSi28n3qwN3PfKiGgB8NJ8ybz3nZj9W9LlE5FGmH5nqW-RA
Message-ID: <CA+bbHrV3fFHWevyDGPtAS=2M2mc+LxP6=xA-5fXaiTKTD=R31g@mail.gmail.com>
Subject: Re: [PATCH v4] wifi: mac80211: fix monitor mode frame capture for
 real chanctx drivers
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Devin Wittmayer <lucid_duck@justthetip.ca>, linux-wireless@vger.kernel.org, 
	Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, fjhhz1997@gmail.com, 
	Brite <brite.airgeddon@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.10 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_MIXED_CHARSET(0.56)[subject];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-249779-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[justthetip.ca,vger.kernel.org,nbd.name,kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[oscaralfonsodiaz@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sipsolutions.net:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 328FD589508
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

I tested it on 6.18.12

Let me know if you need me to test it again or whatever. I remember
during my testing with the Brite's different patches that is not the
same testing it on 6.18.x than 6.19 . Some stuff changed and the patch
needed to be different. I've added Brite to the thread, he can add
more useful data for you.

Regarding the approach of fixing the bug on the driver side... I've
emailed and contacted by IRC to Lorenzo explaining the problem... but
I got no response. So if we feel yet like this is something that needs
to be fixed from the "driver side"... how to say it softly... we are
f***ed up :) . Maybe the "hack" way dealing with the vif null var is
not bad idea after all as it seems the only way to move forward.

Let me know if somebody needs more testing.

Thanks.
--
Oscar

OpenPGP Key: DA9C60E9 ||
https://pgp.mit.edu/pks/lookup?op=3Dget&search=3D0x79B17260DA9C60E9
4F74 B302 354D 817D DE38 0A43 79B1 7260 DA9C 60E9
--

El mi=C3=A9, 20 may 2026 a las 9:42, Johannes Berg
(<johannes@sipsolutions.net>) escribi=C3=B3:
>
> On Wed, 2026-05-20 at 08:49 +0200, =C3=93scar Alfonso D=C3=ADaz wrote:
> > Let me know if any testing of a concrete patch is needed when you feel
> > it is completely fixed.
>
> I guess Devin is saying it's fixed, and I'm saying it's the same as mine
> so can't be really fixed unless something else happened in the kernel.
>
> Do you recall which kernel version you tested with? (I don't.) Perhaps
> something else in the kernel changed and it's now OK to make this
> change, but we know it wasn't working when you tested before, and I'd
> rather have it not work than crash.
>
> johannes

