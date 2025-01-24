Return-Path: <stable+bounces-110339-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B0BF2A1AE01
	for <lists+stable@lfdr.de>; Fri, 24 Jan 2025 01:51:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE05C1683B4
	for <lists+stable@lfdr.de>; Fri, 24 Jan 2025 00:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD8EC1CCEF8;
	Fri, 24 Jan 2025 00:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gYJV0qMi"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F333F2CA8;
	Fri, 24 Jan 2025 00:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737679892; cv=none; b=cPCR1aSIyYjiQ5RW4VJ8ys/wNlJ4bkXSGH05S0hMrmKRxKRDSlbx3SghccYcijBOv+n2q3NckrscLMY7i9VIJBSQewPE8rMU+HynVARztr0XR6JmFZxM8jhpPWvSX1F4tRV5csQ3P+LiiDxTOZFFxMiRvX0b9U6VWDWoSW1LJP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737679892; c=relaxed/simple;
	bh=zSdHFMEh5R3vcklc5JAWEGNlmIa1A7ADM8hUVCupfww=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tgn9UWpNoOHjLEbpD3kRySaJNZrBSwjZLN5LXHr1X95paL+2y8Rl/CaQ1tjqdbio8Pzg2yx/rJNdkGwHHtUjgixULljtEzdSmSH/uAFsPhOWlUESTaJaUJ3gzY23daSA8jK7oZRJnkWHUo9U3TbB0x+fz1LYrHsn9XcHMV85unU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gYJV0qMi; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5dc10fe4e62so2232921a12.1;
        Thu, 23 Jan 2025 16:51:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737679889; x=1738284689; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xvSBc19ja4PhXLkU+eKAiQdkfhdLW998VM8F+55O/Pk=;
        b=gYJV0qMiy1E9yeMmed9O4LZE+yjyQgfFaZU9Wwn8pQh0VOzFPBJhXKBYUTk0GZtNfK
         tBk67quOSH/dAzmcjYzTUltxX/5a98z40KtWubw7thJKAQhPcFaRSDsR80r0JhSenPXO
         k9kcj12JSex5/OBCanRBy8t7PS2F6GqXBye5h4iBLa20S3Z2TtjDSHwRnSr5DsiqvVRm
         ZZbAS4ee/l7e8ezbs7CFSoJAw9u+lQJAEp1Jwta9rz1hLacE5QdhN748Ln3+VPyQ9/ap
         x2Jv+pbtAiu8mBO5SpoqfC/pRQwmBLx/iP/SPA7ubdts8XP/pHK0kitoLtPlzODvIIlA
         i/xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737679889; x=1738284689;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xvSBc19ja4PhXLkU+eKAiQdkfhdLW998VM8F+55O/Pk=;
        b=iMS4JQBqtwlALfgpmYNPG/GSyqQqoikyN6JgF5f4RVwUbeG2e2ITOwb0md52xvWo8a
         ojn1dsmuRnKF9LSJAmF/Fkta+kAhnWMyrdiBgKSiQ+XKbG/+UOo6/rfEWs7Pxxo9SbwC
         W9HUT14Ho3d/cR6pfQzKdc/6pwN6uzLFaj3Q3Xt5b4qqBxDr0BotMKBPpErFMAqPWqDa
         9rD1t4oG4Mo3+RpREJh7hq+hyhAw27LVUuAkRHpIAABnXdb50vnkyJ1Ay6fmDI5CTyH/
         XFRIZOprKvsFDr+Kvjbbb86GUgi6zJtcPnYezBRKT2ubFTB1XJ7bp9yGGropqCyUi/k4
         aqLA==
X-Forwarded-Encrypted: i=1; AJvYcCUT6csyL1amSwxBAMpZftvb+eszvzjaiRzaXiKUBDgafSwx+1VCVserrKgye/+aa0BskY9ojvG5@vger.kernel.org, AJvYcCUpYR0Ee5oyPEiKIG2POJ4WUXT2KJ89qHDggwNybSN7zZ7YR994Gv9EfBmIQLcnZLF1/OxK6IO2@vger.kernel.org, AJvYcCX1ovOGiaoEtKclVuf2brWPWiexsHAW9E/7cR7DA7Jcw+HGNT8S9sTsXWoQ9RuLUEdp/sum4mPl/I+0DBs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzuq/ztasD4HrY9KRztrkaAv6eiedVQzHVPh6KGRAB9EE0Yjdjo
	aOr7v2UcnVXHmK3bmwn6TBvlEBTMMIXOPQ9D3CBtUDwv8HYj0nE2W64I6MsBfq7BqASMQiUdCdd
	pSmBZGav4k6MV9Wcx7pGQ2sB1zUw=
X-Gm-Gg: ASbGncsYDIurPAsR+vDqEACC8z/esYRrUvYCTtPvMGXPxXPPwhB44NenvbW7m5E8Oa5
	FNgqNHv0M8uzJldEd1IIJe/kN7mxhH6PybicYE5bPVzFSC2O0sgSa9q7VOXhWgOw=
X-Google-Smtp-Source: AGHT+IF1tqPGeWCO56Ui3/IF5YtLZ4HffGAy69gdkDNqHgnKMo4KAe5zXHUVSHRRevF0akyAOQ+jxWNHKxrP9D0F6UA=
X-Received: by 2002:a05:6402:5203:b0:5d3:e766:6143 with SMTP id
 4fb4d7f45d1cf-5db7db078a1mr28496955a12.30.1737679889079; Thu, 23 Jan 2025
 16:51:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250122023745.584995-1-2045gemini@gmail.com> <20250123071201.3d38d8f6@kernel.org>
In-Reply-To: <20250123071201.3d38d8f6@kernel.org>
From: Gui-Dong Han <2045gemini@gmail.com>
Date: Fri, 24 Jan 2025 08:50:50 +0800
X-Gm-Features: AWEUYZme8_EJ9mqW8EvRGKPAM6vQW9SNxA7jizwJTxsupziLlDboLeknK7dO-_0
Message-ID: <CAOPYjvbqkDwMt-PdUOhQXQtZEBvryCjyQ3O1=TNtwrYWdhzb2g@mail.gmail.com>
Subject: Re: [PATCH v2] atm/fore200e: Fix possible data race in fore200e_open()
To: Jakub Kicinski <kuba@kernel.org>
Cc: 3chas3@gmail.com, linux-atm-general@lists.sourceforge.net, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, baijiaju1990@gmail.com, 
	horms@kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 23, 2025 at 11:12=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> On Wed, 22 Jan 2025 02:37:45 +0000 Gui-Dong Han wrote:
> > Protect access to fore200e->available_cell_rate with rate_mtx lock to
> > prevent potential data race.
> >
> > In this case, since the update depends on a prior read, a data race
> > could lead to a wrong fore200e.available_cell_rate value.
> >
> > The field fore200e.available_cell_rate is generally protected by the lo=
ck
> > fore200e.rate_mtx when accessed. In all other read and write cases, thi=
s
> > field is consistently protected by the lock, except for this case and
> > during initialization.
>
> Please describe the call paths which interact to cause the race.

The fore200e.available_cell_rate is a shared resource used to track
the available bandwidth for allocation.

The functions fore200e_open(), fore200e_close(), and
fore200e_change_qos(), which modify fore200e.available_cell_rate to
reflect bandwidth availability, may interact and cause a race
condition.

fore200e_open(struct atm_vcc *vcc)
{
    ...
    /* Pseudo-CBR bandwidth requested? */
    if ((vcc->qos.txtp.traffic_class =3D=3D ATM_CBR) &&
(vcc->qos.txtp.max_pcr > 0)) {

        mutex_lock(&fore200e->rate_mtx);
        if (fore200e->available_cell_rate < vcc->qos.txtp.max_pcr) {
            mutex_unlock(&fore200e->rate_mtx);
            ... // Error handling code
            return -EAGAIN;
        }

        /* Reserve bandwidth */
        fore200e->available_cell_rate -=3D vcc->qos.txtp.max_pcr;
        mutex_unlock(&fore200e->rate_mtx);
    }
    ...
    if (fore200e_activate_vcin(fore200e, 1, vcc, vcc->qos.rxtp.max_sdu) < 0=
) {
        ... // Error handling code
        fore200e->available_cell_rate +=3D vcc->qos.txtp.max_pcr;
        ... // Error handling code
        return -EINVAL;
    }
}

There is further evidence within fore200e_open() itself. The function
correctly takes the lock when subtracting vcc->qos.txtp.max_pcr from
fore200e.available_cell_rate to reserve bandwidth, but later, in the
error handling path, it adds vcc->qos.txtp.max_pcr back without
holding the lock. There is no justification for modifying a shared
resource without the corresponding lock in this case.

Regards,
Han

