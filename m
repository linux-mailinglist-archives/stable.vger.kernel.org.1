Return-Path: <stable+bounces-235980-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qCVtLnG63GlCVwkAu9opvQ
	(envelope-from <stable+bounces-235980-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 11:42:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2175A3E9F5E
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 11:42:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 49A603037411
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 09:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4CE03B19B0;
	Mon, 13 Apr 2026 09:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lCZV7Hnk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 668AD3AC0C4
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 09:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776073277; cv=none; b=MmnF+pSrbRh0zOLnd0iJDiUpk52O4dmgEODVUhVvfDGCCPGQRSFXwfTkeHHFXlVerRmxvHDMySkwqVt+NLmUvfUGpyoWo7Fq1+tLNe+pbBFNiimHhszZZhlWdBVCA4fbXb2LSN3cWwZjMIsSDrXG1ABHnsgKzjCBRR10jMdm6dI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776073277; c=relaxed/simple;
	bh=jKgobCvhnClXPs9ic9AUlX/vjH6nWNDxSdU8/oPK5ew=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ffyMva78Mo8R6gNfRY3LrPg1qI2GvDn314K4m2sZP4pdOjVGtOYvhK0wIKN0asfPCDxX2XfKueGooLEoZEaL098dAi+XgnMXXI88mqSO15Vdnr2W4y97caTzJQbWcYsSX5C/z/LeCU/ej3md9n1OQUjqw/HhMR3mhx3JlEQK7y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lCZV7Hnk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A778C116C6
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 09:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776073277;
	bh=jKgobCvhnClXPs9ic9AUlX/vjH6nWNDxSdU8/oPK5ew=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=lCZV7HnkEg9qjrt5yJt3B6UOUUNsvSheWS3hlh67TvGgdHhuIQyvzH4RfyBBEd/DD
	 t49mzpzz83wOOvLHSaHoa7qvoTNB3FdFlcBtOY34a0pwope9YFuQXyQMy71m3Draba
	 xuvvRSBw2xtk3ZOAMwhwuO3AEh7XuH9M3kcu1SuhIYvxLOGFvrlMUooeZB8y6cIb8B
	 pnJIowqu01HBLZWG+0QUfR1b5iMXBZwELHm8BcsXuSmKUVWAZnpvrdlTFBO1aglQnz
	 kx6E6ty3UBynRFt3GHLAGGpELrJI8uQ3xQyMfrmTefDLlvqGQjmmapcM47CTum6C6W
	 CvdS2yGByNeyg==
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6714fa8b955so1724125a12.0
        for <stable@vger.kernel.org>; Mon, 13 Apr 2026 02:41:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+3lSX1GDwATkqak8r97mfSLxaRgTEYEYs07sWINRHvRnHA63xW5txfKya4esqnULBy3vaXxpE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKu1rbVkoi4UQ1t1SvMfap8wuBhpWE3ME3r9L0ypIXalSqgoIy
	IhZKKOpZfUfNkVfkbjDpel9P8+Mpl9pWUJmfUa5rAxRRUztGNq7zbnSRe2v8Bfvs5PvZvCbkkmB
	z03JTRAFsiZUoHKnCmoUI+OkwRWfJG4k=
X-Received: by 2002:a17:906:6a03:b0:b97:cf49:efb8 with SMTP id
 a640c23a62f3a-b9d72796ab2mr732859066b.49.1776073275535; Mon, 13 Apr 2026
 02:41:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260412062828.1734637-1-rong.bao@csmantle.top>
 <CAAhV-H4NHEo_JnnDYkWAYdTwiNuyVGNYymyOLL89ZxQVrqRjuA@mail.gmail.com> <0160f8e5-56f5-4024-8e4f-a72c4ab19f97@csmantle.top>
In-Reply-To: <0160f8e5-56f5-4024-8e4f-a72c4ab19f97@csmantle.top>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Mon, 13 Apr 2026 17:41:23 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4ovjm_rHz5B4QKFxfGNVU78qaGCDqRQSgOxFHwWaQLVw@mail.gmail.com>
X-Gm-Features: AQROBzCCZvPEnqMbAcjzq1O6x3uVH944P_fNpz845jE1Jc5SAkHHOnlJdBgr5fo
Message-ID: <CAAhV-H4ovjm_rHz5B4QKFxfGNVU78qaGCDqRQSgOxFHwWaQLVw@mail.gmail.com>
Subject: Re: [PATCH] perf annotate: Use jump__delete when freeing LoongArch jumps
To: Rong Bao <rong.bao@csmantle.top>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, stable@vger.kernel.org, 
	WANG Rui <wangrui@loongson.cn>, WANG Xuerui <kernel@xen0n.name>, loongarch@lists.linux.dev, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-235980-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chenhuacai@kernel.org,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[csmantle.top:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 2175A3E9F5E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 13, 2026 at 4:49=E2=80=AFPM Rong Bao <rong.bao@csmantle.top> wr=
ote:
>
> Hi Huacai,
>
> On 2026-04-13 16:33, Huacai Chen wrote:
> > Hi, Rong,
> >
> > On Sun, Apr 12, 2026 at 2:28=E2=80=AFPM Rong Bao <rong.bao@csmantle.top=
> wrote:
> >> [...]
> >> This patch adds the missing free() specialization in loongarch_jump_op=
s,
> >> which prevents disasm_line__free() from invoking the default cleanup
> >> function.
> >>
> >> Fixes: 4ca0d340ce206 ("perf annotate: Fix instruction association and =
parsing for LoongArch")
> > The original code works well, you are really fixing fb7fd2a14a503b9a
> > ("perf annotate: Move raw_comment and raw_func_start fields out of
> > 'struct ins_operands'").
>
> Thanks, I'll fix the reference in v2.
>
> > And LTS branches (6.12, 6.18) need different fixes because the code
> > has been restructed.
>
> I locally have a version based on the linux-6.19.y branch. Would you
> mind providing me some pointers to the standard approach to submitting
> this rebased version? I'm new to the process.
Just send V2 for upstream is OK.

If you want to fix 6.12/6.18/6.19, you can send dedicated patches as
follows after the upstream version is merged.
https://lore.kernel.org/loongarch/20260413023627.1363488-1-chenhuacai@loong=
son.cn/T/#u


Huacai

> >> [...]
> >> diff --git a/tools/perf/util/disasm.h b/tools/perf/util/disasm.h
> >> index a6e478caf61a9..6b7fef3bbc42f 100644
> >> --- a/tools/perf/util/disasm.h
> >> +++ b/tools/perf/util/disasm.h
> >> @@ -158,6 +158,7 @@ int call__scnprintf(const struct ins *ins, char *b=
f, size_t size,
> >>                      struct ins_operands *ops, int max_ins_name);
> >>   int jump__scnprintf(const struct ins *ins, char *bf, size_t size,
> >>                      struct ins_operands *ops, int max_ins_name);
> >> +void jump__delete(struct ins_operands *ops);
> > Don't put it among ***_scnprintf(), put it before ins__raw_scnprintf()
> > or after mov__scnprintf(), and add a blank line.
>
> Sure. This will be fixed in v2.
>
> >
> > Huacai
> >
> >> [...]
>
> --
> Regards,
> Rong Bao
>

