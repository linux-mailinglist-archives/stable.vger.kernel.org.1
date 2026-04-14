Return-Path: <stable+bounces-237870-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sJ48AQE/3mlJpwkAu9opvQ
	(envelope-from <stable+bounces-237870-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 15:20:01 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AF333FA680
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 15:20:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 70A50302F71B
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 13:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C0083E6DCF;
	Tue, 14 Apr 2026 13:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IJ4QDpd+"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF0813E63A7
	for <stable@vger.kernel.org>; Tue, 14 Apr 2026 13:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776172451; cv=pass; b=Rq3kg7JoDImZfcYkIjdBCU2Gi3AozlKsgOJrZ1DKeeyt97GOoOEOi4TEL39AQohy61fpXaITjgFXo+Ai1DWyxXFo7Xumk/FWlAA2t3eudm8ouXbQBbGcO61ER0a0iFpQdJQ1VC07KYXgaiWDQKAiDB/HUSGEWcduoWplKRqIli8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776172451; c=relaxed/simple;
	bh=jOsViN4NIKUTK2djxj/LqGafrFIIjSXC4TelnhrR6zA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MQccnFAktddibJ61u0R93EA5ntTeVDq0hwVdA4wLvSiwm3v0zDGsqdzB5poBQRdX0IXXIDpW9iYuNaxiK6FxHzt29tXFm7C0kY5tN9KNRDp8N5vnQsiw+SyfKOLqRmh5S6mOmEi0/MdqNhY16wEtwxuSFA/yNhTPN/8qoEgXohs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IJ4QDpd+; arc=pass smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2b46da8c48eso59815ad.1
        for <stable@vger.kernel.org>; Tue, 14 Apr 2026 06:14:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776172449; cv=none;
        d=google.com; s=arc-20240605;
        b=HrUNaF3LTvzOKOTzf15TWWcbcH3rxnJjoC8HWLqAA97sKZJv+0zb/MsUYXLJCkWuP0
         0Sh9fus3j2NWTVdIK8W/2QsEVDQ/2tHj9BHqmayxtt6xmzjDPDUPtGhG4ML4UUqVVx2f
         OCs40gwOxmahKa8ZRvFnigDreh1kSHcpdjfNHjK2j/8BVO3TAkBjH8qU5j4VX2CTPl64
         Mx2HiBp11TNXi/FkK69RPzClATe9rF5AwHViexlCorrCs56U3PI43EHRphaUft/f32F8
         bjSdVZiGM+bTrVs7R+4xaS4CpG55J+pdBPPwSX3RsL1Ap4rrGKuNWH7Vo5nsesgvCVS5
         ASiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UJQ/3w1DBcgGlnLHAerUmdd07zGHcm64GaPdH458Eu0=;
        fh=m6GDtpI5x9xyqFcCDZKqTVPg4s0rjhZgGGhAfDscPHE=;
        b=h2deAAZOGoAgZGQyi3tScwB/FGDd2zpSsqgC6/hhXqDyjd19n6KsxPbg81lRzbCNPa
         AFly4R9mck2pHaqdsB06rGy0Li1z7sPRqSxxgHBFN1MJ3NhzcgeBsq3Sfuls4/pnRbvQ
         j/wThK6/K87/h6KqQ0qwiuQOz0SUaNlnj57ahuw4xUzncMPuqtNFlwv/PyZBUg23wG36
         zZPuwW+7jjeK8gt66pk3hTs0OuV3jT5lANafAmQv0t7322YgR9g1fix934SVsB3zwUmM
         ufK6Td1pCrEz3VmaPiyvl3KG0lGQzzN8hUskcKRCohuQ90E/nsUq97Rmrl2K0eszYEeI
         yvkQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776172449; x=1776777249; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UJQ/3w1DBcgGlnLHAerUmdd07zGHcm64GaPdH458Eu0=;
        b=IJ4QDpd+dv5883rCErhENnX0qwehzP3e390o7PUBl9DLskSl6GdTG2rLtJ914HJF2V
         +oNQ7IDOeLqayWSygauXeJzS2z52oYTT6ZspHgjVh+9N3z99KPWxChiQj3MyPk4iE0tx
         yRPH7T59EJmBXNN8dDZEdv1aW/R9DmleCzaVyzzy0Qjewn9hWFfqtxPwamHUhGMdSBS0
         D0rZkkTYxZlnMkpnpVRhBRKqde8LjaCt2pOXw7+AM+jG0fyVaURWqAIevWvum5nT8RjQ
         hQ6cgpdZqz2b8rtS8424ofv2KqRGBDofeTJrsoTrc17AC7GtlnHdEji8FxGgwvDYQMJW
         Xg/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776172449; x=1776777249;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UJQ/3w1DBcgGlnLHAerUmdd07zGHcm64GaPdH458Eu0=;
        b=M8oAQNj8GWw6AzmLB1172P7b3Wc7T2Xw/eb04eKCFMU8YTehXHVwrFuebR3Anx2n8q
         MSKVOvqBN/iFzMr14PP1nX9vOOQkOfILCXSACyY2M0VvauBd8UGDQfEqClDHJQWzk9Lq
         grL7xZxXAMqlVlc28v5KDuAE5LlBlu6sUOV3edDT6tsoWz9bKseQD/NgHYAxi3aom7hD
         28CCykl7LztrKJaRJJANkIe1YPWm8dBFYh3ky4Cv3gCOSJ6vPNf2HHyvwDRu13OvKQvI
         llD5NYGhiGcxzVB/36aJlM10Ue3pQFUZUaQZnJ/d2zQnYIDJt0oMETlNfAbJKc2Ld4QS
         OLRQ==
X-Forwarded-Encrypted: i=1; AFNElJ91/Fi9lUANK3PtXKXocbblKcnojYrEE4IaIPwF6eJ5kNxKGA38uV/eoTfacaFPmDEYe3ue83g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMychgbta049NA0VjAUUlX4EYBSLUfqzAGTAk1imRUDgxpAaUm
	o77StN/Xc8OBDYv1HKUw904WNVeRK3Ay/toUZQcGtw/nFRAONOLAlU0trhUB7HNINpa0EGkb57u
	joU4cq/RAjWom+TtI15YGveoV2jPp0aWsUObt8jYV
X-Gm-Gg: AeBDiesSK0Ey/eiYRZNhdYMs35qupSdwj0NHxMDFQCBw/GLZwCrf5Ba8wJG6P/tTL6i
	/aeIsa4UetgJdpAu1H7FW70Ehf2uBVabZbfrFJDD+b9PC3/U1tg7dUBZKyd4VebEqTTMSYfeywh
	zP2A4Pi0LKxeCMrxF4ROntiX9eum5XDx9RsW0/Wkd9dYleNuiKFoV4ETeeSzEEFSZ2tfO/+C/o9
	YfA27LfsPAtwty0qcb9FurtLYUXZ7KKg4g4VnknPxCfow3F9NHIohOec408iM3Pcya2QAlpXdoC
	PyLlMt8wMEHyzNxPMqSCzXZ6B/KDHA==
X-Received: by 2002:a17:902:d28a:b0:2b0:b458:2dc3 with SMTP id
 d9443c01a7336-2b468152a26mr964615ad.21.1776172448591; Tue, 14 Apr 2026
 06:14:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260414071242.95637-1-mgsharm@amazon.com>
In-Reply-To: <20260414071242.95637-1-mgsharm@amazon.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 14 Apr 2026 06:13:55 -0700
X-Gm-Features: AQROBzCo-GKeDRA6Lk3sTQXMfYYJ12DlhceopjwbpJatt3xI7c_OxYLcfadMFHc
Message-ID: <CAP-5=fUPfjhyh4N6CqgAwwR=tQXOOVjS=YoEJSGkz70rHCp0Zw@mail.gmail.com>
Subject: Re: [PATCH] libperf: fix parallel build race with header install
To: Gaurav Sharma <sgaurav00719@gmail.com>
Cc: linux-perf-users@vger.kernel.org, acme@kernel.org, namhyung@kernel.org, 
	stable@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Gaurav Sharma <mgsharm@amazon.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-237870-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[google.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[irogers@google.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7AF333FA680
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 14, 2026 at 12:13=E2=80=AFAM Gaurav Sharma <sgaurav00719@gmail.=
com> wrote:
>
> When perf is built with high parallelism (-j128), there is a race
> condition between the install_headers and libperf.a targets in the
> libperf sub-build. Both are invoked as targets of a single make
> invocation from Makefile.perf:
>
>   $(MAKE) -C $(LIBPERF_DIR) ... $@ install_headers
>
> The perf tool's exported CFLAGS includes -I$(LIBPERF_OUTPUT)/include
> which points to the header install destination. The coreutils install
> command creates the destination file (truncated) before writing content.
> If the compiler runs between file creation and content write, it
> includes an empty header, causing incomplete type and missing prototype
> errors in the libperf source files.
>
> Fix this by making the libperf compilation target depend on
> install_headers, ensuring all headers are fully installed before any
> source files are compiled.
>
> Fixes: 91009a3a9913 ("perf build: Install libperf locally when building")
> Cc: stable@vger.kernel.org
> Signed-off-by: Gaurav Sharma <mgsharm@amazon.com>

I believe this was addressed by:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/commit/tools/lib/perf/Makefile?h=3Dperf-tools-next&id=3D8c5b40678c63be6b8=
5f1c2dc8c8b89d632faf988

Thanks,
Ian

> ---
>  tools/lib/perf/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/lib/perf/Makefile b/tools/lib/perf/Makefile
> index 32301a1d8f0c..8372cd9919b7 100644
> --- a/tools/lib/perf/Makefile
> +++ b/tools/lib/perf/Makefile
> @@ -99,7 +99,7 @@ $(LIBAPI)-clean:
>         $(call QUIET_CLEAN, libapi)
>         $(Q)$(MAKE) -C $(LIB_DIR) O=3D$(OUTPUT) clean >/dev/null
>
> -$(LIBPERF_IN): FORCE
> +$(LIBPERF_IN): install_headers FORCE
>         $(Q)$(MAKE) $(build)=3Dlibperf
>
>  $(LIBPERF_A): $(LIBPERF_IN)
> --
> 2.50.1 (Apple Git-155)
>

