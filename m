Return-Path: <stable+bounces-249667-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gGalFCmyDGrdkwUAu9opvQ
	(envelope-from <stable+bounces-249667-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 20:55:37 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ADE94583ECB
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 20:55:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E76463013A9B
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 18:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7409C376A14;
	Tue, 19 May 2026 18:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i9Kthbg8"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00BA9376A15
	for <stable@vger.kernel.org>; Tue, 19 May 2026 18:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779216928; cv=pass; b=VGt/sy5LB9LHd/tO8vpIwkwCWfuSHApH2v2+RpyUD6K5KUOBXtDhajFTJI+smPJtYOV1FO2lpm8PFn4BRgZJ3kAVHnG2DBZlaSfy1p4+1MbnL51Rx9fl3WOY8EL2Rr7jcQ4EFlLIH3YrTchPlSVSvYrCUkbiOC1AXAXWmdbQIks=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779216928; c=relaxed/simple;
	bh=7jJuTFyxIQFgGbFSaoiVo+0a3X/OYWa6i6xQj0whl7A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pvjTm0hQIeWi1+YnCPK/GWFCeRwrzi0w6CXUCppc71GagoMqvguYdF+jXhjeLnSyfrRGICETjo/0DResFfcmGyOKV3wP4u0rpgk8ZTJOzJhL6vLT1SkJDa2MDdW4uCRw4q4jESaKSvKE6jrGtIsMKqEIAy9Q4YI6YaCgx88xZK8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=i9Kthbg8; arc=pass smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2ba3b9bcf69so235ad.0
        for <stable@vger.kernel.org>; Tue, 19 May 2026 11:55:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779216924; cv=none;
        d=google.com; s=arc-20240605;
        b=Jabuu27sJgAdQ9F0tYCnyJ09qdHuFHtHLzRs/MZ98PLf6bX6MOenIRtBKo+aWsQzSd
         dIQAoTbVzjEwZlX86RZC30Aq8BeQeGLXv+kl2MsPWa9jXi73JQkwGGwe9T+VdpK+kogP
         Ay/iPnUOOjiLpVOeFKWLiutNgH/dTa/1n+rCoKXB16FLGsqEHZ/he/V+z0lJMQ0lyPsH
         QModmP1kAw2Q7Q1UhspdijWiS99KMSmJPhZLPPCdwGRHsTF8e8ZPlea7VBHxV37WU1ea
         8ccmui3Zuf0Jv0H3swf49iiSu2TnMJ4iRoHEMYKsvvZ8zR7eRB568UcOn92l1mA721A2
         ETIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pQ3Jvwmd3/jYVoY+5T+/jl2kd+9Tp3/RpWPQ69jbyeo=;
        fh=mJ8L7hSWz9a9B2hQnOcIqJpHYyjmlfj53PP53JWaiC8=;
        b=INoFf/1/cavoq+yXAY7A/0HHHmmgeY8cn41p8gDuhNoPsEY7HZfTk233dlyqOt29ZE
         0gD6+kSyyMvs3ow36NyrZcIhPBQTBMacY1TbO8y+FuDITxH/QrACiU1wZQTFw+bwRj3Z
         t5ctBfVFWXnwShBUTIem/HRv27M2sCs/vvWQhU1Q0R3HHZisPJgiXuT4SlXgIgSY+s7c
         riCyLQm+ffp1NhpYreeRVxBJrQpH1QtBsJV9tdB6M6mv9/S13OqB7gtbnBOUGy8Vknv0
         CKnGheM5ejKBKDIatShbQvQlhyPpSgsKagUWqnt3y/gR21KB/3oroXyg++wntp2+/NHq
         zckg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779216924; x=1779821724; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pQ3Jvwmd3/jYVoY+5T+/jl2kd+9Tp3/RpWPQ69jbyeo=;
        b=i9Kthbg87uGSj60qNgX++RI5HMot2mTo3Z80iB6m5FOj0vdvFLe7BuCS7ZS8KGawiq
         lJId5S1ibyfqKS0qyYnf37u+KESGNRRj91238j93W2ptP0dEmJxunzy87oV0dtmO6B+d
         XVFf8YTxVP2oUgGbrwdUs5oOJCxdROc2JlpozFST32x4Nb4Y3NoM6NdTEZOxZdhYndr0
         AK4g3OjtiZ/Z/2HBg1thGhNicI8pTk+dI7iwXSzg8wRAH2+ournVmExK7FzjJgx3wNUp
         +VtdzzbSW0ZqGzgsQzMVwEAGozV2vp//HxoEhg2KOgSdZaH71FElFrP2C8fCD1HiR82A
         BJog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779216924; x=1779821724;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pQ3Jvwmd3/jYVoY+5T+/jl2kd+9Tp3/RpWPQ69jbyeo=;
        b=EpoXQ1cb7ZL+dVM7sA7iSRU1K8tCXZc14LXfKM2jtKbm4jkRvB1imYpiaLHtYPWqpt
         Qs0KpVU85WQF982nr08Jud5YzrC3FJ4iXG0nInFiyFdlP5KGcUgS1fIisg4CFq/M/bkw
         FyYtW8gVK9yzam/oWlbJyk12ishGNkqbM6/y1ITUcO3YHqutPxQcAQFjAFrVfCWaIErn
         iZJIivThYdm9W5uuTJfAY8Ygjlqa2D8ZzW6+S9DWBD7TgHLTvdDemlUDFkag8PE8RC8B
         QnVfwGNRkgu0hOFDYhERV42ww+K+YyMl46TOKPZ8C4JDBvGSD9GzKZ351dBCRlMOWqS6
         lxDA==
X-Gm-Message-State: AOJu0Yzr+JKsEzfmIDma8ReIcTZZAJgACYgWfbTv5OhK9mRF2InTQX62
	4Gt1uDNDbWim5DsD6TY6R/6MDKp319XjIu9fn49VAmZcf1WSoWV0+LH1MJxOXWFAEnkLZmwkxAm
	FNcTlLibWHZoW7XRibTf59ykVHD7LGjQYFwQTtut8
X-Gm-Gg: Acq92OFgyUPjgNSQxTrYJ4q1IF9WxViS4SpLsKlWv0lvYSlQuMJCx5NktgimPcb3beK
	b6g7UDbWZlyYuuOv56vvp8yuJxnH8aQlVwmOoFZW6ulSEsLV+QVC6d8Wi1j7mxK1gUm/Tocbx+z
	frvO+SQIH9I/uPnKQhokZeXRHrfPfNW3Bac9YZLBAhOW7Sa9kCWMQ76d+URyp6flvP3Kg4PWoBK
	rbR5iZduCwPB86xXvagG37L+QeK+Qd6kY59NS6wTtsNLA+00lG4X5fypWG0vJTCzN1MVvM87aBC
	fRmpF41AQaK7huEXMSKW0GtIcs7sLhyWv40tDrH+RTCH1LIZ
X-Received: by 2002:a17:903:2f03:b0:2bd:6727:d689 with SMTP id
 d9443c01a7336-2bdb03a2b85mr7785775ad.12.1779216923701; Tue, 19 May 2026
 11:55:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260519185154.2987285-1-florian.fainelli@broadcom.com>
In-Reply-To: <20260519185154.2987285-1-florian.fainelli@broadcom.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 19 May 2026 11:55:12 -0700
X-Gm-Features: AVHnY4JlPZT2y2KVD2Jea3uptVn6tXWN7jpuqmjhnpWHibNi0RSzYBZXKWi7G-M
Message-ID: <CAP-5=fUuhNRj2Dwz9FmMnWKwXjM3RCFV1oQKO4e3X20EOHstEg@mail.gmail.com>
Subject: Re: [PATCH stable 6.1 0/3] perf build fixes
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: stable@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Tom Rix <trix@redhat.com>, 
	"open list:PERFORMANCE EVENTS SUBSYSTEM" <linux-perf-users@vger.kernel.org>, 
	"open list:PERFORMANCE EVENTS SUBSYSTEM" <linux-kernel@vger.kernel.org>, "open list:BPF [MISC]" <bpf@vger.kernel.org>, 
	"open list:CLANG/LLVM BUILD SUPPORT" <llvm@lists.linux.dev>, bcm-kernel-feedback-list@broadcom.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249667-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[irogers@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,broadcom.com:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: ADE94583ECB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 19, 2026 at 11:51=E2=80=AFAM Florian Fainelli
<florian.fainelli@broadcom.com> wrote:
>
> This patch series contains "perf" build fixes specific to 6.1. We have
> seen occasional build failures in our CI looking like these:
>
> util/parse-events-bison.c: In function 'yy_symbol_print':
> util/parse-events-bison.c:901: error: unterminated #if
>   901 | #if YYDEBUG
>       |
> util/parse-events-bison.c:1020:62: error: '_p' undeclared (first use in t=
his function)
>  1020 |   yy_symbol_value_print (yyo, yykind, yyvaluep, yylocationp, _par=
se_state, scanner);
>       |                                                              ^~
> util/parse-events-bison.c:1020:62: note: each undeclared identifier is re=
ported only once for each function it appears in
> util/parse-events-bison.c:1020:64: error: expected ')' at end of input
>  1020 |   yy_symbol_value_print (yyo, yykind, yyvaluep, yylocationp, _par=
se_state, scanner);
>       |                         ~                                      ^
>       |                                                                )
>  1021 |   YYFPRINTF (yyo, ")");
>       |
> util/parse-events-bison.c:1020:3: error: too few arguments to function 'y=
y_symbol_value_print'
>  1020 |   yy_symbol_value_print (yyo, yykind, yyvaluep, yylocationp, _par=
se_state, scanner);
>       |   ^~~~~~~~~~~~~~~~~~~~~
> util/parse-events-bison.c:991:1: note: declared here
>   991 | yy_symbol_value_print (FILE *yyo,
>       | ^~~~~~~~~~~~~~~~~~~~~
>
> which are resolved by these patches.

Lgtm, but the changes should be unnecessary as perf from Linux 7.1
should run on Linux 6.1 and with more and better features.

Thanks,
Ian

> Ian Rogers (3):
>   perf build: Conditionally define NDEBUG
>   perf parse-events: Make YYDEBUG dependent on doing a debug build
>   perf build: Disable fewer bison warnings
>
>  tools/perf/Makefile.config     |  1 +
>  tools/perf/util/Build          | 12 ++++++++----
>  tools/perf/util/expr.y         |  4 +++-
>  tools/perf/util/parse-events.y |  3 +++
>  tools/perf/util/pmu.y          |  3 +++
>  5 files changed, 18 insertions(+), 5 deletions(-)
>
> --
> 2.34.1
>

