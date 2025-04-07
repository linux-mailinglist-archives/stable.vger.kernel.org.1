Return-Path: <stable+bounces-128520-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 88851A7DC9C
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 13:44:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A39C188846E
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 11:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5842D23E259;
	Mon,  7 Apr 2025 11:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eZ7zOKDF"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 619FE22E41C
	for <stable@vger.kernel.org>; Mon,  7 Apr 2025 11:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744026279; cv=none; b=WLUvkhNQ9SFtETp5uMltb7eN4qNnjOfAoe36doNrXPabLLClEIo7AHGwSuePssrJuQ5ibuZzP2+Z7NPwt8TJ0TM7tTCxKMHUk/7m+tOqr5L8L+SOVvYWIHUAY4itIBtCecDMb0H+vj0YRsyE6PQwM7IfNzI6wg757UE0d8FuhuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744026279; c=relaxed/simple;
	bh=ksAYSibSo8Wq1luwHuqroopCEKvYxb5ZuOdwbHCPpUg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KrxTF6PskJxhvBcse9iyefB7Yut5xpjfetZ4I0hjbBdXwKUjtfhNQUTPuQoWabVJFVho+H0q1MCZ9MrC8b0wbhXgKoNubmyJGdzTaWQ8OTxZQiw5Fh7SEBLGul9HPtDytUUhGP1UpPhCJkIBVFQXjHldC6fFQyrbENaTivG8/S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eZ7zOKDF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744026276;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=aBshJz3O4BkmJV0YxapwwLE5fSu4IiUM8iRAkf0MK20=;
	b=eZ7zOKDFropgqe4oxzoeWR72O8lhmOVXgOo4rDsyLQS3978B1P0GFew8aCbu1lK1ugKABc
	DuJNnBQquV0t0svJGbL8mcdOTCub/G5E20IVWISMqWi20TdfB9LA8xVC5McPKO/tzU0KOv
	bkeLGhFDx0B4vSGQ/X3Mf+jYyegxZvA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-465-BFPH23IrNVSJzRL7RTNRfw-1; Mon, 07 Apr 2025 07:44:34 -0400
X-MC-Unique: BFPH23IrNVSJzRL7RTNRfw-1
X-Mimecast-MFC-AGG-ID: BFPH23IrNVSJzRL7RTNRfw_1744026274
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3913d8d7c3eso2299328f8f.0
        for <stable@vger.kernel.org>; Mon, 07 Apr 2025 04:44:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744026273; x=1744631073;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aBshJz3O4BkmJV0YxapwwLE5fSu4IiUM8iRAkf0MK20=;
        b=eU461aSVzn5WgSLj6XOxpKXiIayt01SHdKfS5JmbcHQuENLqtEf3pw6Ic7BfGgWMG4
         GF1+DBxuc8KRtXkTkLiD0mk7CfVAmUSMIsEPCsXji5qWuJapVriZ/MV5WEUjnLsXB1e7
         fPNkuOChD/PEOcVqOOYOJMmOD/jFpagfhuxuQz2j/aUD55TSDmCG4W69zZWmdBvy4pEJ
         XWvUkq09VgJOqRd4g9Dj/F2leoyDWcBVVQJot74vy/sTkpSqmKgemD8LXdMhsfll+HW4
         3PvqEnNnhBfa+AA7Ta4TgRVZEavgZhxe9NiO9TmNq2dx49WtulwcntiBWgBfdXGtdn6g
         D0YQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZrf4vy5KT5bhI72w7oRcxrO9TeaK4FS07a/4q/vIF5HkD/u2Cc0zXqWCmPJZ8ko+A66784zU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7xjnl3ZWci3ep169/NZCNWtnh05K2pS8BuHOOvQqTpQqdEafr
	vrEH4vtvrUL2in8+rOmOJDKwrt7BRRwAJqtI6FzUEaTHUUqAoi/EfRM3wx4z4e+kcmpyMWvYUwO
	ilUlb/SCdALgPbT2HCBUYAS6RQ+xKVimaDlKjAiKH8LmdEYmZLxcf212bNlFmwBph
X-Gm-Gg: ASbGncuOrKI6IFxIepfPLHWD0IAEuumGCkvrQkt3pPolRYFA57Oj+thxD/GOCjPzf+6
	eN3GV/cV3n1hsHJCFI/6sC7wct7neTRCE4EPbp1I6RHX2eGmC7Xkjv5++a8Qiu7JmpUHKg0MILI
	psB3hZTW88GVqB9R6eWquAijxETa/7Lagj/UNbzddnY7yIJnL9iyUQH0ZB3Nklk5nm/LsJDVj5v
	3wLUk5pbHTJ6lQblpP5y1RuGcKuD4uLkOtJ52ZLU/C00/GMAC0ewX87TTQa7WSu+c4SdE4+q0Ne
	39KxDXoV6T0WTcyOn7tr5cSwTCG3qQzmBniyZTMXUA==
X-Received: by 2002:a5d:5849:0:b0:38f:39e5:6b5d with SMTP id ffacd0b85a97d-39d0de66a96mr11260761f8f.44.1744026273638;
        Mon, 07 Apr 2025 04:44:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGEWXlqrP/re+Sk6pAWJZpdkT1N/4Lq9lK2bgw5EGkIBM2LLPGUe1aIGmx1ILTGNUEo+PKnmw==
X-Received: by 2002:a5d:5849:0:b0:38f:39e5:6b5d with SMTP id ffacd0b85a97d-39d0de66a96mr11260738f8f.44.1744026273278;
        Mon, 07 Apr 2025 04:44:33 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.35])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c3020d980sm11998426f8f.61.2025.04.07.04.44.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 04:44:32 -0700 (PDT)
Message-ID: <1ba35cb3e9dff4065f4df397e8a775a97b83302b.camel@redhat.com>
Subject: Re: [PATCH 2/2] drm: Schedule the HPD poll work on the system
 unbound workqueue
From: Gabriele Monaco <gmonaco@redhat.com>
To: Imre Deak <imre.deak@intel.com>, intel-gfx@lists.freedesktop.org
Cc: Tejun Heo <tj@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>, 
	stable@vger.kernel.org, dri-devel@lists.freedesktop.org
Date: Mon, 07 Apr 2025 13:44:30 +0200
In-Reply-To: <20230901140403.2821777-2-imre.deak@intel.com>
References: <20230901140403.2821777-1-imre.deak@intel.com>
	 <20230901140403.2821777-2-imre.deak@intel.com>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0ByZWRoYXQuY29tPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmbiuWMCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfJzZgD/TXjnqCyqaZH/Y2w+YVbvm93WX2eqBqiVZ6VEjTuGNs8A/iPrKbzdWC7AicnK
 xyhmqeUWOzFx5P43S1E1dhsrLWgP
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2023-09-01 at 17:04 +0300, Imre Deak wrote:
> On some i915 platforms at least the HPD poll work involves I2C
> bit-banging using udelay()s to probe for monitor EDIDs. This in turn
> may trigger the
>=20
> =C2=A0workqueue: output_poll_execute [drm_kms_helper] hogged CPU for
> >10000us 4 times, consider switching to WQ_UNBOUND
>=20
> warning. Fix this by scheduling drm_mode_config::output_poll_work on
> a
> WQ_UNBOUND workqueue.
>=20
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Heiner Kallweit <hkallweit1@gmail.com>
> CC: stable@vger.kernel.org=C2=A0# 6.5
> Cc: dri-devel@lists.freedesktop.org
> Suggested-by: Tejun Heo <tj@kernel.org>
> Suggested-by: Heiner Kallweit <hkallweit1@gmail.com>
> Reported-by: Heiner Kallweit <hkallweit1@gmail.com>
> Closes: https://gitlab.freedesktop.org/drm/intel/-/issues/9245
> Link:
> https://lore.kernel.org/all/f7e21caa-e98d-e5b5-932a-fe12d27fde9b@gmail.co=
m
> Signed-off-by: Imre Deak <imre.deak@intel.com>
> ---
> =C2=A0drivers/gpu/drm/drm_probe_helper.c | 8 +++++---
> =C2=A01 file changed, 5 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/drm_probe_helper.c
> b/drivers/gpu/drm/drm_probe_helper.c
> index 3f479483d7d80..72eac0cd25e74 100644
> --- a/drivers/gpu/drm/drm_probe_helper.c
> +++ b/drivers/gpu/drm/drm_probe_helper.c
> @@ -279,7 +279,8 @@ static void reschedule_output_poll_work(struct
> drm_device *dev)
> =C2=A0		 */
> =C2=A0		delay =3D HZ;
> =C2=A0
> -	schedule_delayed_work(&dev->mode_config.output_poll_work,
> delay);
> +	queue_delayed_work(system_unbound_wq,
> +			=C2=A0=C2=A0 &dev->mode_config.output_poll_work,
> delay);
> =C2=A0}
> =C2=A0
> =C2=A0/**
> @@ -614,7 +615,7 @@ int
> drm_helper_probe_single_connector_modes(struct drm_connector
> *connector,
> =C2=A0		 */
> =C2=A0		dev->mode_config.delayed_event =3D true;
> =C2=A0		if (dev->mode_config.poll_enabled)
> -			mod_delayed_work(system_wq,
> +			mod_delayed_work(system_unbound_wq,
> =C2=A0					 &dev-
> >mode_config.output_poll_work,
> =C2=A0					 0);
> =C2=A0	}
> @@ -838,7 +839,8 @@ static void output_poll_execute(struct
> work_struct *work)
> =C2=A0		drm_kms_helper_hotplug_event(dev);
> =C2=A0
> =C2=A0	if (repoll)
> -		schedule_delayed_work(delayed_work,
> DRM_OUTPUT_POLL_PERIOD);
> +		queue_delayed_work(system_unbound_wq,
> +				=C2=A0=C2=A0 delayed_work,
> DRM_OUTPUT_POLL_PERIOD);
> =C2=A0}
> =C2=A0
> =C2=A0/**

Hello all,

why was this patch never included?
Especially this 2/2 seems to solve a latency issue we are observing:
the work can last milliseconds and run on isolated cores, affecting
latency requirements in some real time scenarios (e.g. oslat).

Thanks,
Gabriele


