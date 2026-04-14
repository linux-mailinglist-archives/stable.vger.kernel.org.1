Return-Path: <stable+bounces-237692-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uC+MO/WR3WkLfwkAu9opvQ
	(envelope-from <stable+bounces-237692-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 03:01:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 641613F4B75
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 03:01:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F27983024475
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 00:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D4F02566E9;
	Tue, 14 Apr 2026 00:59:27 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 189EFAD4B
	for <stable@vger.kernel.org>; Tue, 14 Apr 2026 00:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776128367; cv=none; b=AqfJU/dp/KQr4kAA/bzvVRmLFbzrjmEuakPQ9RZ2a836JMmiVYMO/9KwNMYosSr28F0IsDm3CtirdhQ/+ImZQ1Ix4mChzbsin/f7fCmn35viDiHNgbQwz+dNck0dA/kNARu41stnwfz77Qge75hTxyKkns8QR0hKveRkNcFsj78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776128367; c=relaxed/simple;
	bh=Ihx9oGwx/J886HAj3QOwLuigDqYt3I78wkQUSf6TvRo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PVrc0mDqRs5tTheZ+8dmXXLjIQlhQBSCzXhbPLr5I81l+HZK+4+vJXk262ClhVFdwlQEkypyB6pbJpugQLq+xzeteUdntnjRkuTkmSzyDOTwgO1TcUTr1DDLCbn3BiOEBqRegAOH2jVFbL7VbvzbVJSIJ9lbKoCRWkcbU17bsSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [209.85.128.177])
	by gateway (Coremail) with SMTP id _____8Dx8eppkd1pblYAAA--.1792S3;
	Tue, 14 Apr 2026 08:59:21 +0800 (CST)
Received: from mail-yw1-f177.google.com (unknown [209.85.128.177])
	by front1 (Coremail) with SMTP id qMiowJAxVcBlkd1pioZsAA--.38347S2;
	Tue, 14 Apr 2026 08:59:18 +0800 (CST)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-79495b1aaa7so51311727b3.1
        for <stable@vger.kernel.org>; Mon, 13 Apr 2026 17:59:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/YwbDxWC/8je799w/sKuVwfGyPUJf1TwAukNlvQXm8pyFrcs1p/prLamXEN+FjSF8Kvk+rN4A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyolitbil32jctkHrHtbWraiu+nxkLexp7RsQzDRem0wsTCXu5D
	s7gLsK2zOn9l53xAEAm3k4WdmUNqBJ3wuPmh1CzoQ/72AK5WSK0Py2hBEhNQvkSyQZwvj9zUYX+
	X/5GlMGU3aM9x8FERAtLY/2J9tevmxKklS6ZNqmNmog==
X-Received: by 2002:a05:690c:389:b0:79e:b3aa:b352 with SMTP id
 00721157ae682-7af7108b32emr162464617b3.31.1776128356699; Mon, 13 Apr 2026
 17:59:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260413100412.2313688-1-rong.bao@csmantle.top>
In-Reply-To: <20260413100412.2313688-1-rong.bao@csmantle.top>
From: WANG Rui <wangrui@loongson.cn>
Date: Tue, 14 Apr 2026 08:59:04 +0800
X-Gmail-Original-Message-ID: <CAHirt9g7BncuBWsbBT-DpOVyueCb-ut_xyTCKdw_7sMNVznQ6Q@mail.gmail.com>
X-Gm-Features: AQROBzCpdm_echH82j4AKS5BRrFrPP1qbcOjqO98FlGPHAR20FWHC3bU1SgK5yM
Message-ID: <CAHirt9g7BncuBWsbBT-DpOVyueCb-ut_xyTCKdw_7sMNVznQ6Q@mail.gmail.com>
Subject: Re: [PATCH v2] perf annotate: Use jump__delete when freeing LoongArch jumps
To: Rong Bao <rong.bao@csmantle.top>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, stable@vger.kernel.org, 
	Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, loongarch@lists.linux.dev, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CM-TRANSID:qMiowJAxVcBlkd1pioZsAA--.38347S2
X-CM-SenderInfo: pzdqw2txl6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxKr4UuF4DKF13Aw1rXr4DKFX_yoWxKF48pr
	Wq9ryUtw1rGF10gwsxJFWI9Fy5Xr4IvFWF9FyftrZFvr13Xrn2qr97CF9I9FsrXF9Iy3W8
	ZF1vgrs8KFW8J3gCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUyGb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Jr0_Gr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4
	xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v2
	6r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCF04k20xvY0x0EwIxGrw
	CFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE
	14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2
	IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxK
	x2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI
	0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8j-e5UUUUU==
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.999];
	R_DKIM_NA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wangrui@loongson.cn,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-237692-lists,stable=lfdr.de];
	DMARC_NA(0.00)[loongson.cn];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid,xen0n.name:email,linux.dev:email,loongson.cn:email,csmantle.top:email]
X-Rspamd-Queue-Id: 641613F4B75
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 13, 2026 at 6:11=E2=80=AFPM Rong Bao <rong.bao@csmantle.top> wr=
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
> Fixes: fb7fd2a14a503b9a ("perf annotate: Move raw_comment and raw_func_st=
art fields out of 'struct ins_operands'")
> Cc: stable@vger.kernel.org
> Cc: WANG Rui <wangrui@loongson.cn>
> Cc: Huacai Chen <chenhuacai@kernel.org>
> Cc: WANG Xuerui <kernel@xen0n.name>
> Cc: loongarch@lists.linux.dev
> Signed-off-by: Rong Bao <rong.bao@csmantle.top>
> ---
> v1 -> v2: Correct "Fixes:" tag and move declaration of jump__delete()
>           per comments.
>
> v1: https://lore.kernel.org/lkml/20260412062828.1734637-1-rong.bao@csmant=
le.top
>
>  tools/perf/util/annotate-arch/annotate-loongarch.c | 1 +
>  tools/perf/util/disasm.c                           | 2 +-
>  tools/perf/util/disasm.h                           | 2 ++
>  3 files changed, 4 insertions(+), 1 deletion(-)
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
> index a6e478caf61a9..25756e3f47e47 100644
> --- a/tools/perf/util/disasm.h
> +++ b/tools/perf/util/disasm.h
> @@ -161,6 +161,8 @@ int jump__scnprintf(const struct ins *ins, char *bf, =
size_t size,
>  int mov__scnprintf(const struct ins *ins, char *bf, size_t size,
>                    struct ins_operands *ops, int max_ins_name);
>
> +void jump__delete(struct ins_operands *ops);
> +
>  int symbol__disassemble(struct symbol *sym, struct annotate_args *args);
>
>  char *expand_tabs(char *line, char **storage, size_t *storage_len);
>
> base-commit: 028ef9c96e96197026887c0f092424679298aae8
> --
> 2.53.0
>
>

Tested-by: WANG Rui <wangrui@loongson.cn>

Thanks,
Rui


