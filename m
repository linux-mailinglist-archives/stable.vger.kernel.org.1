Return-Path: <stable+bounces-72820-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D2C7969B33
	for <lists+stable@lfdr.de>; Tue,  3 Sep 2024 13:08:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8C321F242C1
	for <lists+stable@lfdr.de>; Tue,  3 Sep 2024 11:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 517941A42BA;
	Tue,  3 Sep 2024 11:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hp0hZZI5"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 833D41A42B1;
	Tue,  3 Sep 2024 11:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725361682; cv=none; b=q9egKryt5MUvGYB+m0bmKM+XOyEsvLKNQNWrBguW40LLCODWlYUPvZlU6cQOWrIrW8iyNw5VWK9CDT7xdNExIeVXWEsIMGqNyoUEBEjxiXcFfiWJcSlBWEIjmZhGZJBNJKmvbEsBPl9q2ZXD0pizcuY3QWFTKav14d4L7UfL3zM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725361682; c=relaxed/simple;
	bh=mEcVNbYHLKu3C+nsiFwIVKcYGx2+N3Fz0vSzgHmdgr4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NKOMk5/6iwttSXWV64DCmS8ng0hRQDRs3JY6R56YgJtjsk13l2lyQJ6djvANGGE5MNLzt9eKNUHori9fwnTpRSbsGDarfgeYdY16DPcxym6CxV9C0/hMNtPAuiGLWVoWUSlf5yvqisD8KT3yVpeRqRqgqIEBnxSSHad/d1EZwr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hp0hZZI5; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a869f6ce2b9so561943066b.2;
        Tue, 03 Sep 2024 04:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725361679; x=1725966479; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hFIlnHarQIbKAMrxp4Fmgj4Ee9vqqjajNpLRTZv79c8=;
        b=Hp0hZZI5nKir0hy0vt2TMJcbg2Wd4h2lP1uiVrz8fM4WYV4iXTJcrt19wAbLOZUUH6
         nt3YLqbYmXr5C17D3lvQ/pueLxutmWlWaB6pwsslXrf3QDG8D5pC32ler05K6DCsezuc
         r/nRdxpJMNGgozs5HP2i6up1DAiCwzkn8VWEPwZvHJVVaaf8D5idRHXWMzBHq3KFDrqa
         cKJxlMJNp3s+zTyasaGnqZW3BMKxKqPuIGg6+Py9qrs5Orueg9sWZhxhgMfnMxZRLkBa
         CHc3+8/TiwIGssG19xmRh+8prqi10+IUF6jjR2rbFtdvPyb9xoVRKdVeV0ogy/G0HJmc
         F1uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725361679; x=1725966479;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hFIlnHarQIbKAMrxp4Fmgj4Ee9vqqjajNpLRTZv79c8=;
        b=KYQT8NBQCj/rvdIqJHALw7DmEnpcnX1c4aoDERkG61PnpVuGteunyX6jPqYTTZOKSC
         dj5Se4L8EsWzSeXSWLFIHSYMKuHi36E5va/MvPSYSVZH4q0H1ciXFQkQoGha7lZ3FC5R
         TFerhZsT6TT9c/M5yrWLN4XWfVOwdv+XvjJXHqkW88JHqMsbkg5GghdN4mL7zt1kMqnt
         JZPS1BgMXV4uadNMVL7HwImvwGzms2nc8FjGSs8/4JZa/10MKufnQOEVI/s9yQoXY0IL
         u8gUhmvZ8tCvFXgBdhe85dXcCQKICne/52r3sEXH7k4BQW3JkvGd0Pd2rv4IeRIcvOL9
         k2fA==
X-Forwarded-Encrypted: i=1; AJvYcCUZokdJ2amrTrfBKUe0j3KGN1k5cukAuXiEqHgqTGy6ceECuSPNIaJ0dKK7t1GMrLkCN9hiDkRT@vger.kernel.org, AJvYcCWNIFiiVyg2cZt9yxOv5C5oXliG1YetOTWDo9YzHzt2GljkWZlkWhfZDDj8m2wMpeN8xaN833dprbj/UJ2jb9r6I0JE@vger.kernel.org
X-Gm-Message-State: AOJu0YyG378jWmppkVk9ihDD1NWkgOItZKcRn9hLg+79qo8nKhIZ9f2i
	ytgsxXI+elvsyb6Kg69LvwBllstBf0RfvYamFwn0ZnWgNWjz4eYtHSfjcU8w636MsPPekYvJIfM
	I9C2OoQ8iQgS67t4vqgHekwkTw2g=
X-Google-Smtp-Source: AGHT+IGeLCVCGuTrDCP1v7sTj9PmT3VL0UJVY0431V7YlpLsPEdNsB9QwdkX17CttcryF4QkEsWzG3I/jvnVBqn/r+I=
X-Received: by 2002:a17:907:2d9e:b0:a86:8368:860a with SMTP id
 a640c23a62f3a-a8a32edcf75mr24166866b.35.1725361678499; Tue, 03 Sep 2024
 04:07:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240903083533.9403-1-hdegoede@redhat.com> <20240903083533.9403-2-hdegoede@redhat.com>
 <a22f5196-7fa4-6fc4-7354-3fcf8e99c2d8@linux.intel.com>
In-Reply-To: <a22f5196-7fa4-6fc4-7354-3fcf8e99c2d8@linux.intel.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 3 Sep 2024 14:07:22 +0300
Message-ID: <CAHp75VdWUqza=rEmWeRcYYmRRscYSAJhpskgrY74m_45ua7xJQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] platform/x86: panasonic-laptop: Allocate 1 entry
 extra in the sinf array
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>, Andy Shevchenko <andy@kernel.org>, 
	James Harmison <jharmison@redhat.com>, platform-driver-x86@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 3, 2024 at 1:33=E2=80=AFPM Ilpo J=C3=A4rvinen
<ilpo.jarvinen@linux.intel.com> wrote:
> On Tue, 3 Sep 2024, Hans de Goede wrote:

> > Some DSDT-s have an of by one bug where the SINF package count is
>
> of -> off

I even dare to ask for an "off-by-one" form (similar (grammatically!)
to step-by-step).

> > one higher then the SQTY reported value, allocate 1 entry extra.

than

> > +     /*
> > +      * Some DSDT-s have an of by one bug where the SINF package count=
 is
>
> off

Ditto.

> > +      * one higher then the SQTY reported value, allocate 1 entry extr=
a.

than

> > +      */

--=20
With Best Regards,
Andy Shevchenko

