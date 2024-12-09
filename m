Return-Path: <stable+bounces-100263-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53E029EA160
	for <lists+stable@lfdr.de>; Mon,  9 Dec 2024 22:49:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FAB2165C2C
	for <lists+stable@lfdr.de>; Mon,  9 Dec 2024 21:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6FF119CCEA;
	Mon,  9 Dec 2024 21:48:56 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A441137776;
	Mon,  9 Dec 2024 21:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733780936; cv=none; b=lkb5tpvsbJ+OfiLfPUvIg7/3sMdvA2TW5tSRAw86vkZMsrW6ieS0Nqi50kSeREZOSzhG+hjsEat9TlD8Ypl0N75Nm7/MwjC+qND0au4xBYEqWB3da1WJK2POEd4YuzaubRYMSBlrpqgEdgyn+hjDlirB9sDKEDEtKxFSFFzX08U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733780936; c=relaxed/simple;
	bh=mMKyzltzE9gNDdDyhqe6BiBbJhqhmYrX1bn0tNYjKgc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OesrpgrzZvVQ4piH2le8U54BuRvQB6kQseQZ+KNbAFTrAA3mMPiBHVXfzHL3EmTemFfsHmsnRLegyjkugg/6Vk67y+N9ogXfcjCI2xnWtwuAZy28cwcat6HWUtZRlxH4IaGwxSZf8mC9j4m/L16iDP6dVHZv5SF1bDc05xSNZOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7258cf2975fso4217972b3a.0;
        Mon, 09 Dec 2024 13:48:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733780934; x=1734385734;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mMKyzltzE9gNDdDyhqe6BiBbJhqhmYrX1bn0tNYjKgc=;
        b=E9CxwYTVrzppdA/3RSLy8ompuxgjcI16+SUqejXrJ5TP6T+8+v1p6ycMvgGwNhx8WU
         GB8zL/kGHrojNvKCeahiJFj+NTXOz9Y4lOT9+WtnMv5mnpRK6wF6HF0zsy9ckMlXr7TH
         SQ+V2rJfnZ19nrtXJegZvQcZI+8EU3wV/MXwCyL/U4rkYLlqxsg7cdt7gu8UcIDBKHHn
         KAhV0M13aBntss3jFqNo6L+1ysKZbIcZLmKBzpqBmBq9Yt5qu5uBRJDN5TBd2cfIkET5
         Mq1IEOFauUcW5liKIpcprURxlnQ83v3LRSXgX+DYdyMuNVLhYPG9YZx8vE1ss/YLikvC
         SrPA==
X-Forwarded-Encrypted: i=1; AJvYcCU1gK8L8SPgVklz+NL2GQcbnDfKAYk6yQwI8HFeaoN6aMjkuH4xKxrT5GGrU4TSRU4K8P6NWzkDaOBdRI4=@vger.kernel.org, AJvYcCWyE3rpvH0ljBTer9fUSMzPZMZNvzJLUEuFTxOHAr81qr0wG4uyPP+A85uUiAXJUrSqBu2LVYxbvueJrFluNpPCGQ==@vger.kernel.org, AJvYcCXhQmNzNT6pWTVmU29zO6dpWYPtOWQ+LnOr+hZLDXd60vyewb23Ap54yhYwOC6gpHKmqJkUI9BZ@vger.kernel.org
X-Gm-Message-State: AOJu0YyNftz2x2TCn3Yozq3A9k+zcorYNvvkIc86gDZj06ctyY1rZC/8
	1OhoI4b9zCrAatvg15Lqn5mOIQRbyidIxLgeiQuQlQDsxTgSiivfgYlB5rUbOEBt8uQ8RXGvbbe
	zOoGXqC0R3F6tAVPj28gB96j2coq+uQ==
X-Gm-Gg: ASbGnctg/x6tI23grw6p/6x7tVw0LB5d8kFJcq/lQIBxYdUQSAil5XUodY001VoWpFr
	IkUsG06wx/6qqrrlqoNLor+QoKKoSaAHuBg==
X-Google-Smtp-Source: AGHT+IHGGgYK/t9tnM6hmf/m70NafShg+X8SVH9Qz0IDo9gXUayhVuGvz55ZNrixNevRqGrZ7ta6CQhIG+QGL8byEOI=
X-Received: by 2002:a05:6a20:1589:b0:1e1:6ef2:fbe3 with SMTP id
 adf61e73a8af0-1e1b1a79c58mr3239680637.5.1733780934562; Mon, 09 Dec 2024
 13:48:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241209134226.1939163-1-visitorckw@gmail.com>
 <CAM9d7cgL-1rET97eVU2qpz5-V5XqeCX1N92wTwR5y2sp_4sjog@mail.gmail.com> <Z1dSimfbQ5FO7sjU@x1>
In-Reply-To: <Z1dSimfbQ5FO7sjU@x1>
From: Namhyung Kim <namhyung@kernel.org>
Date: Mon, 9 Dec 2024 13:48:43 -0800
Message-ID: <CAM9d7cj4_8LHHq22Gh-9BOPCEQk3qZizuOjF03cyQtrKSWWTRA@mail.gmail.com>
Subject: Re: [PATCH] perf ftrace: Fix undefined behavior in cmp_profile_data()
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Kuan-Wei Chiu <visitorckw@gmail.com>, peterz@infradead.org, mingo@redhat.com, 
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
	irogers@google.com, kan.liang@linux.intel.com, adrian.hunter@intel.com, 
	jserv@ccns.ncku.edu.tw, chuang@cs.nycu.edu.tw, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 9, 2024 at 12:26=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Mon, Dec 09, 2024 at 09:02:24AM -0800, Namhyung Kim wrote:
> > Hello,
> >
> > On Mon, Dec 9, 2024 at 5:42=E2=80=AFAM Kuan-Wei Chiu <visitorckw@gmail.=
com> wrote:
> > >
> > > The comparison function cmp_profile_data() violates the C standard's
> > > requirements for qsort() comparison functions, which mandate symmetry
> > > and transitivity:
> > >
> > > * Symmetry: If x < y, then y > x.
> > > * Transitivity: If x < y and y < z, then x < z.
> > >
> > > When v1 and v2 are equal, the function incorrectly returns 1, breakin=
g
> > > symmetry and transitivity. This causes undefined behavior, which can
> > > lead to memory corruption in certain versions of glibc [1].
> > >
> > > Fix the issue by returning 0 when v1 and v2 are equal, ensuring
> > > compliance with the C standard and preventing undefined behavior.
> > >
> > > Link: https://www.qualys.com/2024/01/30/qsort.txt [1]
> > > Fixes: 0f223813edd0 ("perf ftrace: Add 'profile' command")
> > > Fixes: 74ae366c37b7 ("perf ftrace profile: Add -s/--sort option")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> >
> > Reviewed-by: Namhyung Kim <namhyung@kernel.org>
>
> I'm assuming you'll pick this for perf-tools, ok?
>
> Reviewed-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Yep, sure.

Thanks,
Namhyung

