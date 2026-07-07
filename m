Return-Path: <stable+bounces-272395-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id jhEQKU/KTGpHpwEAu9opvQ
	(envelope-from <stable+bounces-272395-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 07 Jul 2026 11:43:43 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 30D3E719EB5
	for <lists+stable@lfdr.de>; Tue, 07 Jul 2026 11:43:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=canonical.com header.s=20251003 header.b=S7JQDAE4;
	dmarc=pass (policy=reject) header.from=canonical.com;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-272395-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-272395-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6517C306F6E0
	for <lists+stable@lfdr.de>; Tue,  7 Jul 2026 09:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 816993AC0D3;
	Tue,  7 Jul 2026 09:35:46 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A73D03AB267
	for <stable@vger.kernel.org>; Tue,  7 Jul 2026 09:35:43 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783416946; cv=pass; b=teWbng9z+jdAUdq+VLyiv6vLsIPaDBH7eCGit7ne+gYVKZgWrtAq35w8zgrDKSSzgvSmEPri/M+GwKR6RikjuSQv8yvD8gd+MQf9wbg439AgKF8gdWc+l2MGxGKeVVUHHL0ctpPy2OlwEvzj0PKgv1fxmADHUMF7gjzJY+qFaRQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783416946; c=relaxed/simple;
	bh=uLybiMWMjmE4TRojd9HQOPaGaWZeCtzCpL0SPNTzJx4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jwDOMJdRuKN5HVyjYBYiJ7qy77jb6icBZ4WVR6Wa22SxSQuJZvQLrlM1XPveTIKNeDNaBuJwb3bBG+XIJ+tlBqL1BC0gPLlNgdsy7XjnDDJVZq3lW1PrU2rsVesjjWsl9o6DgIB1V8JQ8m5AkVmLPMop+o8s/d8/V+5hrjqcpBo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=S7JQDAE4; arc=pass smtp.client-ip=185.125.188.123
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 658573F16D
	for <stable@vger.kernel.org>; Tue,  7 Jul 2026 09:35:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1783416936;
	bh=bbT/31W+nDI+goBOogRFsrx2+HdUbut6Kmz6fgFzHhY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=S7JQDAE4E5CD/4AHpJ6qVSF1mqvol6EdkTCI/SUrz4xbNguPJFc0eOhr7wC1T4CgE
	 p4w9azv+i5Y1JeX3UJReQ/tpOGdb1drIJu1Ca8095BN7EKshUskm9DgBq6GBfQZ6Es
	 6XDPjt09NB10eWkOw3AU0ZjgMNE7luI7Yo0SggDj3Z+epxUMyoucCmFaztdfRqhWVr
	 L72VJeAT0OnruEV4TY+r+rBYcFRKkRqlrXlVtUGMqIMUbq/tVcKadL1JVFkL2yruDz
	 HXVGXzAQMm2IEAFnicg8eReQoWbpc06/B8dnSYA0NtOSuDzNAigKVTJdkpGU1FufXZ
	 OhHN+L4sFtkJtBeDQqGgpaeiLMjbcTmqzi0PsU3Jrw4ABYSiqfDcQHmDpIrPj0Glvl
	 km8BFcOoB82PLweejoRL8UqWwfCHYHsqUzr7tcyf3Bmwkh1/FV9+xicjeO1dVxNpo7
	 MfTE/NnZ1PPfZQPBxWYeJCePIF+iRxuV1VxGbomaM3t1xe83sb05jubUQBHtOO7kmr
	 Z9pV7k0w0AVnZ99M51QH0W2lRkGxNgaJFJzXZjlNBB6xwwqFRGD8EjirkoVLpBEDs/
	 XQ3uHgDmgyA3jR+55RkJop4SnL+4wWbonjGFCO3OYjMM5HCQl/tqyML5sSDdURi1q6
	 x/QMXU6Pj1NvQAv7qYmt+h2k=
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c96b4f58ddcso3704468a12.3
        for <stable@vger.kernel.org>; Tue, 07 Jul 2026 02:35:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783416935; cv=none;
        d=google.com; s=arc-20260327;
        b=aiuOzLh66rRWUQ366BccTuLD+cDmYvvkDJj7uNZGORXK3EHYrejDM5xiRSTVbdt7BK
         1CNnImoXofTqEjhQwWwlbEx47XGzWdRUS0cpZGMPZpYPELnYRjjOB0YGZhJiMmg9RiqT
         cB6Vkk7t9Hhye/+4ApOGGFqhucgR2iZ3EGrdkKAP+2J+k9DAMnLKq3aPiab8WSZEv+C1
         DlpUzgEOKL5j7xHuvDPXmOxuehp7vIBqbP7zZM5uzwpiJ9Lh4Q2vAXkiL+2QUCPex7ML
         0/7603/nqPjPBfDOpedCSor2FHzyLeyYOOaQ0sIF8O8e9v+lGcembvozUVQ7v4xZaPC0
         ypsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=bbT/31W+nDI+goBOogRFsrx2+HdUbut6Kmz6fgFzHhY=;
        fh=D9SZv+x9ntfsuWVQ5Yf/+No6sGT3zgK7/rA31A6UTW8=;
        b=jNipB9dJ48tz5OrBYGtYYKMYFgJ/sRUqbc+lQy5V3XPQ/OjWQytO7OMKAaER19kvus
         Wr2cvtGPTicSYM+Css/haC+CzyjgssX19T7A1eyJNmV2K07uWkaWzV1Q/qRevQtJydT2
         4z2xgToEbRzVv4bk3Notso7WuefQHzAoD0R7WV5pG1F6Szq4Nqu8z0u3bx1fPOJ84Zmf
         BWk5A6jTgZOmVS/4H0zSYSjJoFKSng8ovAAAksv93gOtRc0nLz5DiNB9HGashigRTNH4
         p8QzMNcdmAhGv/Frj1dbGLVoKXxpQe66DYWkBqEtkBwPsnUvNXZE8yQs3QObK7TrTg9c
         o2KQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783416935; x=1784021735;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bbT/31W+nDI+goBOogRFsrx2+HdUbut6Kmz6fgFzHhY=;
        b=XN8AWlJFeAVBglW1OW5p2o+Smp3fN0sksK7TOBFuMvGRB9lsNWAB7kqbDZ3tL3kG8W
         eWCi56+Qnpp0IK0m/Gd84r1IdeOWpA704q20gLhsCQ87QrZ61+CvokJTPlQLBQiUimaf
         MFvUCGL23UU8yZ7HaOHzcFIMQ27Et9Op0o5ApUrzfVBnNE+7EHbjE3dZ3m1IjiSrADJc
         +RrpXukxdbYxofj7VSrWmkglhNY4IynhwJYWMAoot10SjMcXNEDfCIaDGGGWslRIGAk+
         7gyrPniPQadi1DvS+JKSEVvOAJJmj+8/dMLwEof00bGIOUDTa/Xy61Ip1HA3A+niCnmu
         OvKA==
X-Forwarded-Encrypted: i=1; AHgh+Roga/u7OOHSqwlcBIhTg4hPH0pWHHV7cp4SJKUuwfuMfx/JjAidMOBZ8oc8M+oAwkc+4ZPRVks=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9euCY8f+RJDU5XC9PkkgsymZEsuJ2x8ZpaiqA702vUYDFIvPu
	EMhE/opuFK7geDr3hyn/upSzl4zZ50OBMmsNWQy1WBN7uOgs2odQFuLCqpQWFNjWPijAI8jHiYW
	CsO+mbIEyKSoMjWcidHsmQueO2ZKgrA+bxzJmHICgKdZat9p8r1E068Emy3Bnu8efj3zDm+Zpp6
	twdqHoRokal9m98GOVSfxLIszpUxux2KxUmMnqM4dbnhDjvUdr
X-Gm-Gg: AfdE7ckjOknxRQ3wWLYbrnqEQl1/VlsZlTp7Y8rYsOKrFEsEzSoKcRWZBnkX6op8/oT
	NpNzRMQbcJWWjUwzmE7gut673pE+w46tbiexwFg9mRh6o2au/YNCmmuacxmYCUA0xdmBPZlW9yi
	a/axygrGgVuqKQfOLcC7w5Qg34gzPia/70QH9l+fwLAnmOcDUJhJ1EbxjM+hD3Q9E0Zf/1Te7/Y
	C/VrxlByASWek2NYxj8hCjqgx7JMduW7cHLddEnKBFdJUw57lL+GmK4hGG1pS05jSB2g6F2PCQm
	pY+dCV4=
X-Received: by 2002:a05:6a20:c5aa:b0:3c0:9c1a:8948 with SMTP id adf61e73a8af0-3c09c1a9c1bmr2553468637.64.1783416934874;
        Tue, 07 Jul 2026 02:35:34 -0700 (PDT)
X-Received: by 2002:a05:6a20:c5aa:b0:3c0:9c1a:8948 with SMTP id
 adf61e73a8af0-3c09c1a9c1bmr2553433637.64.1783416934523; Tue, 07 Jul 2026
 02:35:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260630214404.930923-1-anthony.l.nguyen@intel.com>
 <20260630214404.930923-2-anthony.l.nguyen@intel.com> <0496c117-0731-4de4-9f5d-7fdacf34bd71@redhat.com>
In-Reply-To: <0496c117-0731-4de4-9f5d-7fdacf34bd71@redhat.com>
From: Aaron Ma <aaron.ma@canonical.com>
Date: Tue, 7 Jul 2026 17:35:22 +0800
X-Gm-Features: AVVi8CfFkGBoEQGbtTlj_qWkJDI5c9F_6NwSBaUWRPxR7DFsx1-u2mFLOdzGCoU
Message-ID: <CAJ6xRxVwD9nLk96y6-HNSFt1AL8o=24UMUGxCYZdht2_+36Xhg@mail.gmail.com>
Subject: Re: [PATCH net 1/4] ice: wait for reset completion in ice_resume()
To: Paolo Abeni <pabeni@redhat.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, davem@davemloft.net, kuba@kernel.org, 
	edumazet@google.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org, 
	jbrandeb@kernel.org, stable@vger.kernel.org, Kohei Enju <kohei@enjuk.jp>, 
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
	Alexander Nowlin <alexander.nowlin@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[canonical.com,reject];
	R_DKIM_ALLOW(-0.20)[canonical.com:s=20251003];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-272395-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:pabeni@redhat.com,m:anthony.l.nguyen@intel.com,m:davem@davemloft.net,m:kuba@kernel.org,m:edumazet@google.com,m:andrew+netdev@lunn.ch,m:netdev@vger.kernel.org,m:jbrandeb@kernel.org,m:stable@vger.kernel.org,m:kohei@enjuk.jp,m:aleksandr.loktionov@intel.com,m:przemyslaw.kitszel@intel.com,m:alexander.nowlin@intel.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[aaron.ma@canonical.com,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aaron.ma@canonical.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[canonical.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,canonical.com:from_mime,canonical.com:email,canonical.com:dkim,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 30D3E719EB5

On Tue, Jul 7, 2026 at 4:28=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wrot=
e:
>
> On 6/30/26 11:43 PM, Tony Nguyen wrote:
> > From: Aaron Ma <aaron.ma@canonical.com>
> >
> > ice_resume() schedules an asynchronous PF reset and returns
> > immediately. The reset runs later in ice_service_task(). If
> > userspace tries to bring up the net device before the reset
> > finishes, ice_open() fails with -EBUSY:
> >
> >   ice_resume()
> >     ice_schedule_reset()          # sets ICE_PFR_REQ, returns
> >   ...
> >   ice_open()
> >     ice_is_reset_in_progress()    # ICE_PFR_REQ still set, -EBUSY
> >   ...
> >   ice_service_task()
> >     ice_do_reset()
> >       ice_rebuild()               # clears ICE_PFR_REQ, too late
> >
> > Reproduced on E800 series NICs during suspend/resume with irdma
> > enabled, where the aux device probe widens the race window.
> >
> >   ice 0000:81:00.0: can't open net device while reset is in progress
> >
> > Add a best-effort wait (10s timeout, matching ice_devlink_info_get())
> > for the reset to complete before returning from ice_resume(). In
> > practice the reset completes in ~300ms.
>
> Would not be better to (eventually) wait in ice_open()? Why? AFAICS that
> would be also more consistent with i.e. the current wait in
> ice_devlink_info_get().
>
> Otherwise why don't consolidate all the wait at resume time and remove
> the other one in ice_devlink_info_get()?
>

Hi Paolo,

ice_open() is where the failure is observed, but it is not what creates
this race. ice_resume() schedules a PFR and returns success before that
reset/rebuild has completed, so userspace can call open immediately after
resume and hit -EBUSY.

Waiting in ice_resume() keeps the fix scoped to the PM path and to the
reset initiated by resume. Moving the wait into ice_open() would change
all opens during any reset from immediate -EBUSY to sleeping, and ndo_open
runs under RTNL.

The devlink wait should stay because ice_devlink_info_get() is reached by
DEVLINK_CMD_INFO_GET userspace requests and reads device/FW state. That
path still needs protection from resets unrelated to PM resume.

Aaron

> /P
>

