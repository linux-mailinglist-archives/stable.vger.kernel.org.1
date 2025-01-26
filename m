Return-Path: <stable+bounces-110822-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FDAFA1CE7E
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 21:41:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 762DC1887D20
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 20:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A271155333;
	Sun, 26 Jan 2025 20:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LcNJx6v/"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E6125A658;
	Sun, 26 Jan 2025 20:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737924104; cv=none; b=ksr0+xDh8juSXuTFhPhMa45YykCxsDGs904lK8UGXo8BhwdEysWdcCVsHGXuwbJr4LHdOM61wVG0z6e1kqRVKhlLyf9WtggHbU4mcOCZj6le20I6pVohyIjZzg4TTyHi6e1FQmmm+eXrIt+1LeNor7/tWO/pbkhODAV3rnURiis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737924104; c=relaxed/simple;
	bh=Wb6zthIiLiO8NIv4Szb2inVQzMkdXdqW7mA1SuP925c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PosxvDF+rr+s67iA0hwMP08Mkjw0pXJpGQRw2bwtVF9GouZrvtbrH8ZPxEPc1NWswUoRfTBIl54/v0uosV0efuKjVMJQF2RQpYgp1udxDbkTzLZpbHDiv/1CTXtv77gqv203O6jx8TnKv6QV/ZwcYId89UcoG9TvJ5j6SHvZM4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LcNJx6v/; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2f42992f608so5245316a91.0;
        Sun, 26 Jan 2025 12:41:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737924102; x=1738528902; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7ZOA4W7TAzkQ5vDXza25SSJsYZBCGGHjMPHME96uAxY=;
        b=LcNJx6v/qQYteKVaHINEb80spIXUEvFZW+Gdreai9KySLoVGfG3qhIxJUp5E+g9EWi
         BtEnk8tQSa/hooEPvQgSUkUHdcIAy0X7G68hakQ7qyA0Qzv/lmwRZv8ALgInxyP+PPkh
         gbceZzdqYbZreIgK8O9cLQW5SO3JOqY1DWfCNxolSnbikTzK9ULC46tblZ7pYSByHUZn
         76Fghu5FyERl/BuwjBIac6ZOBE5yOWrdHyILM+bTnjbuknZdU9PJd6ukYNfzNqN1ak5k
         Kpcb0GtwdjcAOOxFlrVhz0BJ+FBbEnS6/LWp4WBBRy2TQA1WWtCq+2QAcEOmHU3K4HHJ
         fVZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737924102; x=1738528902;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7ZOA4W7TAzkQ5vDXza25SSJsYZBCGGHjMPHME96uAxY=;
        b=Qj+4aipvsm2YInuZw7ZJ0tr1ZZG8MRIGUpAJOE6Kao/+rjU8FQVSDSlqY9l0OgtbMO
         +95wvWoDvchqVMqHQFK+xDXYP2Rn0fTVFjvS4A7fp8HXmmUSo65htVMnzs+OQSh6Xi//
         ISyslp2fONIPTcrvnOi3U4i+2H/W3L47AOYqZo8X3daqcXQtdOnlA4mMMd5FR6vRzX9J
         S9dI2wDXFxOpj942thq6bXtcplB0pvcVnxny1FezQVjzRjzoSVPQ/GqBuI/3Fml4Qakx
         81bNgQbWKeTUzPiD3rRlmfXuBnISt66L9ExfesS/j/DjqvejlDvEv1f3aHu0AS8HXAoi
         HSGw==
X-Forwarded-Encrypted: i=1; AJvYcCU5SeMeZ2CMt6WqcrmTkgDHw2YuOS03nQISbb4caH9sbAfrXHE1qyelIPE3wDXvNKbPUs/aZVd/QOrNw9s=@vger.kernel.org, AJvYcCUAvtDo6YxXtEIb1uyOW+S+aL5Y6cNSZbdDQk8FPlwKpACzbPZQ5QOgoW5yk+2Fk0XpUjaej7XN@vger.kernel.org
X-Gm-Message-State: AOJu0YykeIy+IQGNz8wy8SNTXOJ/zUwS5diJ+aVhauyUOaLNAN078kWg
	/H0Xqom6QTHHW9LSXVzKkpz06XAmHi+lVrNbqMyk87oQ/YTmIjo+4fRJLSdXvRgf+ladLdumqe1
	5mmD66hpWOeRHCJxPPW5g1Xn9KBQ=
X-Gm-Gg: ASbGncuh6fMOrt1iCWH8tg5fR8jF34D+52hdmjRzjewFORZNtwPp+rZrghb9GhoGpZG
	1pl6nDu5PrVfuCaoeJt9aVHcBfIyqfIHHfxgjO2p5vrSj2I9ii/+KaBXqOqMAEvi0HLD9Bd4oiM
	L+RNyEqljtdel5DBhUHm0=
X-Google-Smtp-Source: AGHT+IG1eq8ESkAkz/ZUrljUbHMwDCXbLAtJJ3yy2ljP0LE/GfMOTkYd/D08PiJ59vKtjWGYWeAfvkzXJVuXpr3JTRs=
X-Received: by 2002:a17:90a:c888:b0:2ea:37b4:5373 with SMTP id
 98e67ed59e1d1-2f782c6ff50mr57946755a91.10.1737924102141; Sun, 26 Jan 2025
 12:41:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250126150720.961959-1-sashal@kernel.org> <20250126150720.961959-6-sashal@kernel.org>
 <CAP-5=fVMYQPe5qajj34P75oT17Wi_dymJy_DvhoLd7nR4yyX9w@mail.gmail.com>
In-Reply-To: <CAP-5=fVMYQPe5qajj34P75oT17Wi_dymJy_DvhoLd7nR4yyX9w@mail.gmail.com>
From: Namhyung Kim <namhyung@gmail.com>
Date: Sun, 26 Jan 2025 12:41:31 -0800
X-Gm-Features: AWEUYZlvA045A68Utza9CZb8Lc8iGYGTrrBG35zd8OQ4TktHJ25OnImL9heeTuU
Message-ID: <CAM9d7chcUeg0C+MHGrqPuMMy7b8c-8RoUiXseoBnW+GY89O8jQ@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 6.13 06/16] tool api fs: Correctly encode errno
 for read/write open failures
To: Ian Rogers <irogers@google.com>
Cc: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, 
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

Hello,

On Sun, Jan 26, 2025 at 10:27=E2=80=AFAM Ian Rogers <irogers@google.com> wr=
ote:
>
> On Sun, Jan 26, 2025 at 7:07=E2=80=AFAM Sasha Levin <sashal@kernel.org> w=
rote:
> >
> > From: Ian Rogers <irogers@google.com>
> >
> > [ Upstream commit 05be17eed774aaf56f6b1e12714325ca3a266c04 ]
> >
> > Switch from returning -1 to -errno so that callers can determine types
> > of failure.
>
> Hi Sasha,
>
> This change requires changes in the perf tool. The issue is the -1
> gets written to perf.data files in the topology, the -errno value is
> "corrupt." Because of this, I'd suggest not backporting this change.

Agreed.  Please remove this patch from the all stable series.

Thanks,
Namhyung

