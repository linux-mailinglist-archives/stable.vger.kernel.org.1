Return-Path: <stable+bounces-235960-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +PGUCHKq3GlfVAkAu9opvQ
	(envelope-from <stable+bounces-235960-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 10:33:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1298D3E92B7
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 10:33:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2633C3006D44
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 08:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74AA83A5451;
	Mon, 13 Apr 2026 08:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FIrCFHKx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36A343A6EF4
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 08:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776069220; cv=none; b=FU5Ru9t+xwD2qIax+TUvO/aUkd0N+9RQ+DyA1r4D9n08CaHAEFwcL249K2ceyAe6Hq+wkKKX8b0VWhReTXODpKpWLscmfduBKmUSOrmKNAkyp8TpGGARKZfTl07JJ3gusjbcVEEvYw0N0X6Zn86jmm4gXBl/GJ+IEhISJm97qag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776069220; c=relaxed/simple;
	bh=WI7/6LsqRmHXNB29kyk8AUW0jN8/vcuvpEodElVOsiU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gk6qcjUjCdttlZZxSVldIE64h5jJqaXwEEutKJCFWerTPb5UEmX7Dga2lpPAofYtUIy90O2tmZbCMBvtFk1N4d1XrA4YkPB6MFU6sVm5jH8zw9WBxikWC49K9UWKyMSuN6bjaKE2Y7QJnh1XqhvIMNrdutAcl6P68QPWuO5zkfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FIrCFHKx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0C83C2BCB1
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 08:33:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776069220;
	bh=WI7/6LsqRmHXNB29kyk8AUW0jN8/vcuvpEodElVOsiU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=FIrCFHKxJfqK0cfeYhy8uGaf9gqf7rBuEbAh64fuCvbDSCW0p9AoXcMgVR2Qn9+U3
	 EIR1QgGmc8YVJz2pDAC0LvuLbzkV9MRMA/32wezJvfAndtgLMsdOg7/Q/etu50x11L
	 LZO628iJ/+H4+Rzi2yWs0X7mbodA7aFXiOxj8mJEHbAcWqeqc5h0YAVOlX10sXBWct
	 dJ3hQ0lqHoZQ/fowT3k73hJbe+cKTcI4xPw9VGYWQUFATQXg0/fW4BY/bQgya66iil
	 TEDkYz5IWGclnrEmeao8dQWhLASVbjpp8DEzwKzKfpw1ghejeUWplyMVVWFwwrgYlu
	 fYKw0Absx7Y0g==
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b9d9971d059so291918266b.2
        for <stable@vger.kernel.org>; Mon, 13 Apr 2026 01:33:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8dufzjAWdpSt1YzKLaDs0GP9n2Fv7H4FbsVrMxsf8Dn6A3/NcUaQ5i9WL3yoH82g8l6QXZTos=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVi/RptHD8Ak0QCbilT0JOMRdPvzdHZNJW6MMsYgOdXc4h5EyK
	riMYDvZvIGRjYK/Mdijxn66ZKo93nVkHYIG+ZLOGTRn38YURP29pzY6aF7EeCH/saV8yt0daKEy
	JET223l6xDchmpu5uy5rNM2xYrXQ38KE=
X-Received: by 2002:a17:907:3d51:b0:b9b:4519:7914 with SMTP id
 a640c23a62f3a-b9d729665efmr731689866b.33.1776069218474; Mon, 13 Apr 2026
 01:33:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260412062828.1734637-1-rong.bao@csmantle.top>
In-Reply-To: <20260412062828.1734637-1-rong.bao@csmantle.top>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Mon, 13 Apr 2026 16:33:45 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4NHEo_JnnDYkWAYdTwiNuyVGNYymyOLL89ZxQVrqRjuA@mail.gmail.com>
X-Gm-Features: AQROBzA1oY5LoVmxfzIL4Q2MwMOGf8vCrHMVNxqJhOk3glrjjDIpOM0X2FfXSoo
Message-ID: <CAAhV-H4NHEo_JnnDYkWAYdTwiNuyVGNYymyOLL89ZxQVrqRjuA@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-235960-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chenhuacai@kernel.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 1298D3E92B7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi, Rong,

On Sun, Apr 12, 2026 at 2:28=E2=80=AFPM Rong Bao <rong.bao@csmantle.top> wr=
ote:
>
> Currently, the initialization of loongarch_jump_ops does not contain an
> assignment to its .free field. This causes disasm_line__free() to fall
> through to ins_ops__delete() for LoongArch jump instructions.
>
> ins_ops__delete() will free ins_operands.source.raw and
> ins_operands.source.name, and these fields overlaps with
> ins_operands.jump.raw_comment and ins_operands.jump.raw_func_start.
> Since in loongarch_jump__parse(), these two fields are populated by
> strchr()-ing the same buffer, trying to free them will lead to undefined
> behavior.
>
> This invalid free usually leads to crashes:
>
>         Process 1712902 (perf) of user 1000 dumped core.
>         Stack trace of thread 1712902:
>         #0  0x00007fffef155c58 n/a (libc.so.6 + 0x95c58)
>         #1  0x00007fffef0f7a94 raise (libc.so.6 + 0x37a94)
>         #2  0x00007fffef0dd6a8 abort (libc.so.6 + 0x1d6a8)
>         #3  0x00007fffef145490 n/a (libc.so.6 + 0x85490)
>         #4  0x00007fffef1646f4 n/a (libc.so.6 + 0xa46f4)
>         #5  0x00007fffef164718 n/a (libc.so.6 + 0xa4718)
>         #6  0x00005555583a6764 __zfree (/home/csmantle/dist/linux-arch/to=
ols/perf/perf + 0x106764)
>         #7  0x000055555854fb70 disasm_line__free (/home/csmantle/dist/lin=
ux-arch/tools/perf/perf + 0x2afb70)
>         #8  0x000055555853d618 annotated_source__purge (/home/csmantle/di=
st/linux-arch/tools/perf/perf + 0x29d618)
>         #9  0x000055555852300c __hist_entry__tui_annotate (/home/csmantle=
/dist/linux-arch/tools/perf/perf + 0x28300c)
>         #10 0x0000555558526718 do_annotate (/home/csmantle/dist/linux-arc=
h/tools/perf/perf + 0x286718)
>         #11 0x000055555852ed94 evsel__hists_browse (/home/csmantle/dist/l=
inux-arch/tools/perf/perf + 0x28ed94)
>         #12 0x000055555831fdd0 cmd_report (/home/csmantle/dist/linux-arch=
/tools/perf/perf + 0x7fdd0)
>         #13 0x000055555839b644 handle_internal_command (/home/csmantle/di=
st/linux-arch/tools/perf/perf + 0xfb644)
>         #14 0x00005555582fe6ac main (/home/csmantle/dist/linux-arch/tools=
/perf/perf + 0x5e6ac)
>         #15 0x00007fffef0ddd90 n/a (libc.so.6 + 0x1dd90)
>         #16 0x00007fffef0ddf0c __libc_start_main (libc.so.6 + 0x1df0c)
>         #17 0x00005555582fed10 _start (/home/csmantle/dist/linux-arch/too=
ls/perf/perf + 0x5ed10)
>         ELF object binary architecture: LoongArch
>
> ... and it can be confirmed with Valgrind:
>
>         =3D=3D1721834=3D=3D Invalid free() / delete / delete[] / realloc(=
)
>         =3D=3D1721834=3D=3D    at 0x4EA9014: free (in /usr/lib/valgrind/v=
gpreload_memcheck-loongarch64-linux.so)
>         =3D=3D1721834=3D=3D    by 0x4106287: __zfree (zalloc.c:13)
>         =3D=3D1721834=3D=3D    by 0x42ADC8F: disasm_line__free (in /home/=
csmantle/dist/linux-arch/tools/perf/perf)
>         =3D=3D1721834=3D=3D    by 0x429B737: annotated_source__purge (in =
/home/csmantle/dist/linux-arch/tools/perf/perf)
>         =3D=3D1721834=3D=3D    by 0x42811EB: __hist_entry__tui_annotate (=
in /home/csmantle/dist/linux-arch/tools/perf/perf)
>         =3D=3D1721834=3D=3D    by 0x42848D7: do_annotate (in /home/csmant=
le/dist/linux-arch/tools/perf/perf)
>         =3D=3D1721834=3D=3D    by 0x428CF33: evsel__hists_browse (in /hom=
e/csmantle/dist/linux-arch/tools/perf/perf)
>         =3D=3D1721834=3D=3D  Address 0x7d34303 is 35 bytes inside a block=
 of size 62 alloc'd
>         =3D=3D1721834=3D=3D    at 0x4EA59B8: malloc (in /usr/lib/valgrind=
/vgpreload_memcheck-loongarch64-linux.so)
>         =3D=3D1721834=3D=3D    by 0x6B80B6F: strdup (strdup.c:42)
>         =3D=3D1721834=3D=3D    by 0x42AD917: disasm_line__new (in /home/c=
smantle/dist/linux-arch/tools/perf/perf)
>         =3D=3D1721834=3D=3D    by 0x42AE5A3: symbol__disassemble_objdump =
(in /home/csmantle/dist/linux-arch/tools/perf/perf)
>         =3D=3D1721834=3D=3D    by 0x42AF0A7: symbol__disassemble (in /hom=
e/csmantle/dist/linux-arch/tools/perf/perf)
>         =3D=3D1721834=3D=3D    by 0x429B3CF: symbol__annotate (in /home/c=
smantle/dist/linux-arch/tools/perf/perf)
>         =3D=3D1721834=3D=3D    by 0x429C233: symbol__annotate2 (in /home/=
csmantle/dist/linux-arch/tools/perf/perf)
>         =3D=3D1721834=3D=3D    by 0x42804D3: __hist_entry__tui_annotate (=
in /home/csmantle/dist/linux-arch/tools/perf/perf)
>         =3D=3D1721834=3D=3D    by 0x42848D7: do_annotate (in /home/csmant=
le/dist/linux-arch/tools/perf/perf)
>         =3D=3D1721834=3D=3D    by 0x428CF33: evsel__hists_browse (in /hom=
e/csmantle/dist/linux-arch/tools/perf/perf)
>
> This patch adds the missing free() specialization in loongarch_jump_ops,
> which prevents disasm_line__free() from invoking the default cleanup
> function.
>
> Fixes: 4ca0d340ce206 ("perf annotate: Fix instruction association and par=
sing for LoongArch")
The original code works well, you are really fixing fb7fd2a14a503b9a
("perf annotate: Move raw_comment and raw_func_start fields out of
'struct ins_operands'").

And LTS branches (6.12, 6.18) need different fixes because the code
has been restructed.

> Cc: stable@vger.kernel.org
> Cc: WANG Rui <wangrui@loongson.cn>
> Cc: Huacai Chen <chenhuacai@kernel.org>
> Cc: WANG Xuerui <kernel@xen0n.name>
> Cc: loongarch@lists.linux.dev
> Signed-off-by: Rong Bao <rong.bao@csmantle.top>
> ---
>  tools/perf/util/annotate-arch/annotate-loongarch.c | 1 +
>  tools/perf/util/disasm.c                           | 2 +-
>  tools/perf/util/disasm.h                           | 1 +
>  3 files changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/util/annotate-arch/annotate-loongarch.c b/tools/p=
erf/util/annotate-arch/annotate-loongarch.c
> index 950f34e59e5cd..c2addca77320b 100644
> --- a/tools/perf/util/annotate-arch/annotate-loongarch.c
> +++ b/tools/perf/util/annotate-arch/annotate-loongarch.c
> @@ -110,6 +110,7 @@ static int loongarch_jump__parse(const struct arch *a=
rch, struct ins_operands *o
>  }
>
>  static const struct ins_ops loongarch_jump_ops =3D {
> +       .free      =3D jump__delete,
>         .parse     =3D loongarch_jump__parse,
>         .scnprintf =3D jump__scnprintf,
>         .is_jump   =3D true,
> diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
> index 9e0420e14be19..62bd8c3e53051 100644
> --- a/tools/perf/util/disasm.c
> +++ b/tools/perf/util/disasm.c
> @@ -451,7 +451,7 @@ int jump__scnprintf(const struct ins *ins, char *bf, =
size_t size,
>                          ops->target.offset);
>  }
>
> -static void jump__delete(struct ins_operands *ops __maybe_unused)
> +void jump__delete(struct ins_operands *ops __maybe_unused)
>  {
>         /*
>          * The ops->jump.raw_comment and ops->jump.raw_func_start belong =
to the
> diff --git a/tools/perf/util/disasm.h b/tools/perf/util/disasm.h
> index a6e478caf61a9..6b7fef3bbc42f 100644
> --- a/tools/perf/util/disasm.h
> +++ b/tools/perf/util/disasm.h
> @@ -158,6 +158,7 @@ int call__scnprintf(const struct ins *ins, char *bf, =
size_t size,
>                     struct ins_operands *ops, int max_ins_name);
>  int jump__scnprintf(const struct ins *ins, char *bf, size_t size,
>                     struct ins_operands *ops, int max_ins_name);
> +void jump__delete(struct ins_operands *ops);
Don't put it among ***_scnprintf(), put it before ins__raw_scnprintf()
or after mov__scnprintf(), and add a blank line.




Huacai

>  int mov__scnprintf(const struct ins *ins, char *bf, size_t size,
>                    struct ins_operands *ops, int max_ins_name);
>
>
> base-commit: f5459048c38a00fc583658d6dcd0f894aff6df8f
> --
> 2.53.0
>

