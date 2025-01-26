Return-Path: <stable+bounces-110815-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 211CCA1CD6A
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 19:27:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59F12166312
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 18:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEA7D15D5C4;
	Sun, 26 Jan 2025 18:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JMkazggQ"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15386156C72
	for <stable@vger.kernel.org>; Sun, 26 Jan 2025 18:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737916034; cv=none; b=pB2Zjn8yiWnVnMom5WPEJZ3ycQztHgR92bw0uww78hslgMi3sGo9U55Q/six+5n8t5KP2g38uRYEJjB21MvfPT8mEtMbECZ6sgIY4rI+rxPsBwkhbc9Pfit5OFy2knEjbHoENx9vtsTmQPOFuWO17FcOjmOp2EIfUkkhQMwkV2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737916034; c=relaxed/simple;
	bh=a1AQeDuFQMD9Ho9vY8E08NTlKlQuaQfVumETYm3RGCU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e2CcED0DG4tEojh+JyLbgXU1eG8dp5xLpWJml7x1WVjy+UbuAv2hJ8nPLGcQmD+acbfFsvuiPnEXTVo96wKCgzvTcHe8plMTCBasTfFmD60LyZw0MVA7btbULhk0Dfo3JIX6Rl9jLhZQDpTFmzEq8n7+nQ7/HXxL5yVK2dbl8B0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JMkazggQ; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3a814c54742so222555ab.1
        for <stable@vger.kernel.org>; Sun, 26 Jan 2025 10:27:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737916032; x=1738520832; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Un6SMsmKG6Qbkixth5lbM3vAOhqyqiKhK64rgCR+8n0=;
        b=JMkazggQpe1DZRQ5iGazkSFV6ZsRUvr2y02qMm0uuDNYo+/mUAWPwBwPung9pqf6hU
         R8mwJuoLZt6MYFimhl9dhO2+U6FR5s/59UJvfAv9vCfrr647IcdDqlz3WqCEXARApdns
         qtjwZnqfPnIzwCXKi1L2YWwqVWVW0DbN8cXwiUzinv5XTTIVNLdeo0Mg5dtul0h+5WAe
         /E+m/QaFYWguuPT9FGCMVRcZ+uAl9l4khlQ7CX9sV4SAcbxvHCWFlqcjx1QeEQGfWvHh
         z35cSGRIj7MXAiccvQyahu2pHxaXzvCY1UaLx86Ba3PLgceB6T4M7wim0Kg8ebAkrC4w
         eYJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737916032; x=1738520832;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Un6SMsmKG6Qbkixth5lbM3vAOhqyqiKhK64rgCR+8n0=;
        b=NXFk/3UdFpccNQu7EO502GVlM0GwhuILgBFreYjemzBkgPn/0V27g+JgvjkwGBU2OO
         ch+dYZ+k6rWLr1u1s6RlS3Jpi1udpJcwp24b/gsbjnwM2ztM9lQzmof4F9yf8Toa8wAS
         ybDAVC6bldRDh00+deukG7/Wgb0l03n57Gp6D5BCXq8q85tO+TqmXj1qWksW8YaJ+bk1
         BS86IAZDAwUjdIDETzNYkJFbHgroAKI+3EyLeDZvwNZkWE+jjcMEAq2YGeAHBfXh43Nc
         HkyJRLYxtzjhiEZfx62WpV46XJe/gMHhIXo2xG2nx3za7jNj+2sRUyRCmx/hqOQFZyfa
         P2nA==
X-Forwarded-Encrypted: i=1; AJvYcCUabVEYgOQkbHurgHPGU3SjFRwuLatVYzh3FWvTjZEpXNL4DI1BnRbs5P1CsWL0ynLbnKW9ggA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywu466u8CosFQanLXlwm92/V7MK3o1CtBl3+xdgUJrFh5DEhb3E
	clcVW+wyQ12m9tC3aAqhbA3LbRWFBmcs+eNgWdZe6iWEYd/6esTd3qKKwN84qWBxBDPxglFb3Dr
	RkAzDVLtsRSnD9Y0MyT+hm/A2CiEHadgulcnn
X-Gm-Gg: ASbGncstQubWt+igPfdEBWpTwMwt7A63S3FXq3Fw/CMEaaAb5WQz7I0zcWAxbYRSoCt
	wGVZc/M0X4Jjjx56ILq7prfHM1Xi9Jvh2aYGrzhmhgnFQaAnp3TwwxydhTLQ/o94=
X-Google-Smtp-Source: AGHT+IEQTKdDPLxVkalZSpWFH/IHk7UV/DGwqb5FoD30QE5P3zJCGSDEGAUt/rBf/4J+LcPpllI3K4eukZryiirHvpk=
X-Received: by 2002:a05:6e02:120f:b0:3ce:3711:3229 with SMTP id
 e9e14a558f8ab-3cfd14f160fmr3120535ab.14.1737916031940; Sun, 26 Jan 2025
 10:27:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250126150720.961959-1-sashal@kernel.org> <20250126150720.961959-6-sashal@kernel.org>
In-Reply-To: <20250126150720.961959-6-sashal@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Sun, 26 Jan 2025 10:27:00 -0800
X-Gm-Features: AWEUYZkFOGTpzTNsm22w9CniwJxxWak2HAjbWLkVTlyx5yx8Ead16hNM3AuNtKM
Message-ID: <CAP-5=fVMYQPe5qajj34P75oT17Wi_dymJy_DvhoLd7nR4yyX9w@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 6.13 06/16] tool api fs: Correctly encode errno
 for read/write open failures
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Namhyung Kim <namhyung@kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Ben Gainey <ben.gainey@arm.com>, 
	Colin Ian King <colin.i.king@gmail.com>, Dominique Martinet <asmadeus@codewreck.org>, 
	Ilkka Koskinen <ilkka@os.amperecomputing.com>, Ingo Molnar <mingo@redhat.com>, 
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>, 
	Kan Liang <kan.liang@linux.intel.com>, Mark Rutland <mark.rutland@arm.com>, 
	Oliver Upton <oliver.upton@linux.dev>, Paran Lee <p4ranlee@gmail.com>, 
	Peter Zijlstra <peterz@infradead.org>, "Steinar H . Gunderson" <sesse@google.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Thomas Falcon <thomas.falcon@intel.com>, 
	Weilin Wang <weilin.wang@intel.com>, Yang Jihong <yangjihong@bytedance.com>, 
	Yang Li <yang.lee@linux.alibaba.com>, Ze Gao <zegao2021@gmail.com>, 
	Zixian Cai <fzczx123@gmail.com>, zhaimingbing <zhaimingbing@cmss.chinamobile.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 26, 2025 at 7:07=E2=80=AFAM Sasha Levin <sashal@kernel.org> wro=
te:
>
> From: Ian Rogers <irogers@google.com>
>
> [ Upstream commit 05be17eed774aaf56f6b1e12714325ca3a266c04 ]
>
> Switch from returning -1 to -errno so that callers can determine types
> of failure.

Hi Sasha,

This change requires changes in the perf tool. The issue is the -1
gets written to perf.data files in the topology, the -errno value is
"corrupt." Because of this, I'd suggest not backporting this change.

Thanks,
Ian

> Reviewed-by: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Ian Rogers <irogers@google.com>
> Acked-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Andi Kleen <ak@linux.intel.com>
> Cc: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
> Cc: Ben Gainey <ben.gainey@arm.com>
> Cc: Colin Ian King <colin.i.king@gmail.com>
> Cc: Dominique Martinet <asmadeus@codewreck.org>
> Cc: Ilkka Koskinen <ilkka@os.amperecomputing.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: James Clark <james.clark@linaro.org>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Kan Liang <kan.liang@linux.intel.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Oliver Upton <oliver.upton@linux.dev>
> Cc: Paran Lee <p4ranlee@gmail.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Steinar H. Gunderson <sesse@google.com>
> Cc: Steven Rostedt (VMware) <rostedt@goodmis.org>
> Cc: Thomas Falcon <thomas.falcon@intel.com>
> Cc: Weilin Wang <weilin.wang@intel.com>
> Cc: Yang Jihong <yangjihong@bytedance.com>
> Cc: Yang Li <yang.lee@linux.alibaba.com>
> Cc: Ze Gao <zegao2021@gmail.com>
> Cc: Zixian Cai <fzczx123@gmail.com>
> Cc: zhaimingbing <zhaimingbing@cmss.chinamobile.com>
> Link: https://lore.kernel.org/r/20241118225345.889810-3-irogers@google.co=
m
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  tools/lib/api/fs/fs.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/tools/lib/api/fs/fs.c b/tools/lib/api/fs/fs.c
> index 337fde770e45f..edec23406dbc6 100644
> --- a/tools/lib/api/fs/fs.c
> +++ b/tools/lib/api/fs/fs.c
> @@ -296,7 +296,7 @@ int filename__read_int(const char *filename, int *val=
ue)
>         int fd =3D open(filename, O_RDONLY), err =3D -1;
>
>         if (fd < 0)
> -               return -1;
> +               return -errno;
>
>         if (read(fd, line, sizeof(line)) > 0) {
>                 *value =3D atoi(line);
> @@ -314,7 +314,7 @@ static int filename__read_ull_base(const char *filena=
me,
>         int fd =3D open(filename, O_RDONLY), err =3D -1;
>
>         if (fd < 0)
> -               return -1;
> +               return -errno;
>
>         if (read(fd, line, sizeof(line)) > 0) {
>                 *value =3D strtoull(line, NULL, base);
> @@ -372,7 +372,7 @@ int filename__write_int(const char *filename, int val=
ue)
>         char buf[64];
>
>         if (fd < 0)
> -               return err;
> +               return -errno;
>
>         sprintf(buf, "%d", value);
>         if (write(fd, buf, sizeof(buf)) =3D=3D sizeof(buf))
> --
> 2.39.5
>

