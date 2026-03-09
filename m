Return-Path: <stable+bounces-223679-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8Bp8KFHfrmm/JQIAu9opvQ
	(envelope-from <stable+bounces-223679-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 15:55:13 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E92523B001
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 15:55:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D52F8300E69B
	for <lists+stable@lfdr.de>; Mon,  9 Mar 2026 14:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D91DC3D6660;
	Mon,  9 Mar 2026 14:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GoGipUzp"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F5A33D648C
	for <stable@vger.kernel.org>; Mon,  9 Mar 2026 14:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773068006; cv=pass; b=fkWbY+ENs9mj92hgS6a+khmRRap4dWyBou5OFwXx9T59BCUQNSsroqzN5daVSxJbBnS7VJ5PIxgSKrLsItgh9vHgUEF8Fh1hWNN0ga4MZUItvixzJjFPQBWH7e5+BDAsnE/dvsIzFx0kNnxF7sEmnI7ajEQnV5wyRs9OJxMivxs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773068006; c=relaxed/simple;
	bh=EW2Wun4H7Ifhb3gEMef7RTX2YMaXQ+iw7OUkzEIv8G4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hlEk/VvT7Raqcd5Yf8DVDZTYJ4ZhbTS1cIZ0p/h5wb3JDRzPKBAz/fo9r8So/HmyQ1x3GhG+a1fgxZXmAfcS4viPTZM9rGcylJ3LPmoirGrMcPwW/PDH/9bRSci5yGbMJ58HJqWmQCIeI4rbDrxXb4UJc+xG6pkSUUtvry/Gfus=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GoGipUzp; arc=pass smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2ae49120e97so150125ad.0
        for <stable@vger.kernel.org>; Mon, 09 Mar 2026 07:53:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773068003; cv=none;
        d=google.com; s=arc-20240605;
        b=hKrxSV8ZMIuh9OS8vUFfRgz7PTld0p0o7/pq6zMPHnS+Ndf0/I/gaBIxtyBT19TEBL
         QN99HUmy8gxONKpPHHF7piHIhOyukncDv4nysB/XVMVfqugeSJUQC4ANXonwQRh4i+hJ
         oSrj0yrZNARSQ/r+rP4NWvX2MyPQKreP4zvVzTZl4kJO/mG1NXodggKfcOXKXheNesgq
         zcfyYdgKXTYNsSzhbeT8moY47Xnbr7lzHstOV42t4rVNCbBqOPeFAdU1iqhdzLYlOq87
         3jkDGqVnrjwjMlSSn2Z5xULLECzhHz5CmgdjzgRp/eB8OYjsYBS2HZV2P5e8dBAr4WzP
         BUCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GTJevzKbq2qvlzA5h0ob01g0D8BUD7hihJoTYK8oUBE=;
        fh=rarMIpZbmRgTKFg52Io5XLvCVWBvrxeI9PEXtVepCbk=;
        b=VplmQs3uJ18/kACs2xL+mdm3x72EFkxMEPeoh2lHjuMHNT2sHUFLxno2RoNcQOgj5E
         lKEPRXByyhTCXBREwY0ez4OZpjvGZHpY5iQJMK+srjMe6GEt8Qfgoqtm0VX4GshKhzP6
         uXIEQIg1LldookzgbA4BGYakXPne0R7Qr4OEINZY50fcWv/RKvB3JmTFfeLMgdFwiIQh
         UGWDlKiwZuJX63r+ur8aYns00XSMPDzMw4tZwnPUPfn6HOrCwVhWJ6YZWDblJmp5tLel
         y9vAlsMEbzyUwvJaHg4uNpH5WP+2RRqmFhtC3cyPY1dDsl1XrAwUsJwg8NNibbm7e5dR
         YCnQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773068003; x=1773672803; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GTJevzKbq2qvlzA5h0ob01g0D8BUD7hihJoTYK8oUBE=;
        b=GoGipUzpAuspfUxaUBveL6wM4GODqy8/U/4likmUmbbXC4UyK40gE30TTJ3Z1u3D+g
         pY3/8hFCP4n7IlWETLnGU+7FcqIzt5jHuuZcz8qYIQ7PSQqrAnS61x13FTfMh1WXudV7
         cY3t5A+YsESBcUbi1I5vtk6+nSlx4lRmAg3DeJr+ZfdZn8nHwAVWA0lHgamZJrppPRO7
         H6y6wtTqKAYd9urlUU2xl/BskV6SxJydWToBQBkK8zXUPkp4k65A80xu1wfNviyHz5UC
         5jE2ZRQQJumNZot8iHQw8l1gUuQpAQ5XNa/AI2wswFvbEN/ByoTZT/dmeAmCzqew3zxc
         Splw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773068003; x=1773672803;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GTJevzKbq2qvlzA5h0ob01g0D8BUD7hihJoTYK8oUBE=;
        b=iahfNLOlMdsqKMf535HMXFY7ZVBsfSHhYSi/3LS2jQ0adNnTkm1lT/ZkM3jyHKzsZ8
         L/Q2HUsHjWvoEXnNl2m3dV+9fhFUVdb1dwEM182ZgT7SLXtkcWt/VPallE6G8oQrRVTK
         cN5fDD/lSBVYitSntdPYw+m0D28rYC0lOZu7w5Im7U2MYqGd/BKlluRsYgy7O619r3yR
         hv5/oOXHvDkYvnmQ3IFmYEhFMR90LWyzwyD4nKskC63jyQwiqceeKopMPQUz0WYpMtYS
         PvXOqcXTrYTGQDfkTCjkQpeMJ2YyzupXkE3LCgIoy7D6XT4oxD7xN6KLOn+5t7l3O8dX
         pbRg==
X-Forwarded-Encrypted: i=1; AJvYcCUjdjJ4qpFVZHwyEqkaflhzTuMlxyS4XWCeBMSLEDLyZV+PgZN1VcgClzLUnOcG5LYrhMc0xo4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPR/yd5PEO9IEFKVeC4DAcYAb46sxidEykFfSahKZdb76jR8LO
	fFIz9Lk5DZ3EzMjwTiT5r8WFFGXD0MzVL2QuwesI+L9cWgL6ZD0w7gUbs/2LQup2yzKhXJZjsyU
	VBG6rGTxi6dpFZ8lTGMqKgHYtgo0J0dNtbL+6hrOr
X-Gm-Gg: ATEYQzwbUnEEOUvT+I/dXSKj4zPrfdKpiI73QLYUwgBylRrpXk00pviHi892rFi8kYk
	QghIOcHIrHQa0R77iu8/B849GH4ou5tWSxvxTMNe087pH1FknZ3AimsHS9QlZ12xFN2/AroRbKf
	iEQbueX6ff3NxNA6b/3xAxlTxZMLwcAjhzEiRsmdtN6WDXd6Z8fFepBdvYx9pUmoYAJX3RHHICi
	9a189piK1RXPAtlljEg2wAk83fXwJbN96v5ROOgYeiQ4HBgl2E7uZSeXseR8rci6GT8kmNRXtQR
	HhrKuB5eobkcXQHsnnE7oJZyHj+cd1CQkbxVPgOiFYGSoapq
X-Received: by 2002:a17:902:e88f:b0:2ae:4f95:df55 with SMTP id
 d9443c01a7336-2ae8ba8b4cdmr4017515ad.25.1773068002573; Mon, 09 Mar 2026
 07:53:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260228173244.1509663-1-sashal@kernel.org> <20260228173244.1509663-28-sashal@kernel.org>
 <072e2a07-5c6f-47b5-9695-0a3ffe854ac8@kernel.org> <2026030924-recount-halved-605d@gregkh>
In-Reply-To: <2026030924-recount-halved-605d@gregkh>
From: Ian Rogers <irogers@google.com>
Date: Mon, 9 Mar 2026 07:53:10 -0700
X-Gm-Features: AaiRm51bK9riRtII1a1kbiJkYAyxOLQOqALrMqFdmSTmZtAqxEhiVmAkFBbkrFg
Message-ID: <CAP-5=fW6Rz14GszEm+bnh_qAFrLwf51khzfUzDapHyYJ2dpdkA@mail.gmail.com>
Subject: Re: [PATCH 6.19 027/844] perf metricgroup: Don't early exit if no
 CPUID table exists
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>, Sasha Levin <sashal@kernel.org>, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Leo Yan <leo.yan@arm.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, 
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Arnaldo Carvalho de Melo <acme@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 8E92523B001
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-223679-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[irogers@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-0.946];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,mail.gmail.com:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Mon, Mar 9, 2026 at 6:40=E2=80=AFAM Greg KH <gregkh@linuxfoundation.org>=
 wrote:
>
> On Mon, Mar 09, 2026 at 08:40:33AM +0100, Jiri Slaby wrote:
> > On 28. 02. 26, 18:19, Sasha Levin wrote:
> > > From: Ian Rogers <irogers@google.com>
> > >
> > > [ Upstream commit cee275edcdb1acfdc8270f80e96f30750b633220 ]
> >
> > This breaks (userspace) perf:
> > $ ./perf stat -a -d -p 1 sleep 5
> > PID/TID switch overriding SYSTEM
> > Error:
> > No supported events found.
> >
> > Any ideas?
>
> Is it also broken in 7.0-rc3?  Or is this only a 6.19.y issue?

There was a fix:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/commit/tools/perf/util/metricgroup.c?h=3Dperf-tools-next&id=3Dc5a244bf17c=
af2de22f9e100832b75f72b31d3e6
was that applied to 6.19.y?

Thanks,
Ian

