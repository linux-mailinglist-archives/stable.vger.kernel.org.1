Return-Path: <stable+bounces-238650-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +HCxJvX75GmEcwEAu9opvQ
	(envelope-from <stable+bounces-238650-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 19 Apr 2026 17:59:49 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 32963424909
	for <lists+stable@lfdr.de>; Sun, 19 Apr 2026 17:59:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 277D630379AB
	for <lists+stable@lfdr.de>; Sun, 19 Apr 2026 15:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17D92283C83;
	Sun, 19 Apr 2026 15:56:51 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C7D40DFC6;
	Sun, 19 Apr 2026 15:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776614210; cv=none; b=FgKIP1J1BwG1yFNMoO3o22SCoNbSZD+G3xSTl27jwr56FMctXD1RWUlCYGSofyo+uwLd3WsF5UKtZnSdN78v28P3Qx3uVDBY8nrJhNKCxp5OpOPI8zYlAFAc7r04d4cwxOcSeOSX1Xl8EyTUSIlF6F4t88YQGPoI6O3cDyqf8mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776614210; c=relaxed/simple;
	bh=09kDJrz2vpE9bRPe2WwTkrvGrZ6nnWkGxmRdgG8zroM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=C3UDi49Z5jureUAVHSAtpxcu7mPUiQ3ot2863wpuBZyHgekaaI07qBLw4/4PUPwdJXtZ5sDDd4n/dHDHkflEYioUCFbBWT+JrIik8QvX9hqRz0zsxvgoMNo/Qnrr7K3Xq5mt7WaRSWmJXvyiEgKyAoPLviK4cFZQAhgZvsRTNOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from edelgard.fodlan.icenowy.me (unknown [112.94.103.130])
	by APP-03 (Coremail) with SMTP id rQCowAAXGcAi++Rp0LKZDg--.3220S2;
	Sun, 19 Apr 2026 23:56:18 +0800 (CST)
Message-ID: <c1c2d445cf5181897229a6eba198646d5b412128.camel@iscas.ac.cn>
Subject: Re: [PATCH] perf unwind-libdw: Fix stale object reference in
 arch/loongarch
From: Icenowy Zheng <zhengxingda@iscas.ac.cn>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo	 <acme@kernel.org>, Namhyung Kim
 <namhyung@kernel.org>, Mark Rutland	 <mark.rutland@arm.com>, Alexander
 Shishkin <alexander.shishkin@linux.intel.com>,  Jiri Olsa
 <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, James Clark	
 <james.clark@linaro.org>, Shimin Guo <shimin.guo@skydio.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Date: Sun, 19 Apr 2026 23:56:17 +0800
In-Reply-To: <CAP-5=fX=+2oNYHDqsNnFrOZya=RxpnPFF_ojZTQP8v8Umt951w@mail.gmail.com>
References: <20260419090756.2190201-1-zhengxingda@iscas.ac.cn>
	 <CAP-5=fX=+2oNYHDqsNnFrOZya=RxpnPFF_ojZTQP8v8Umt951w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:rQCowAAXGcAi++Rp0LKZDg--.3220S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tF1Dtw1kZr1fKr17Jr4fKrg_yoW8XF1Up3
	W7CFnrtF1UW34a9wnF9an5ZFZxXFZa9r95u3Z8trW8ur4fZrnrJF97tr9xWFZFq348WrW0
	vF9xCr90gas5JaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvqb7Iv0xC_tr1lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4
	A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IE
	w4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMc
	vjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY
	1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8Jw
	C20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAF
	wI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjx
	v20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2
	jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0x
	ZFpf9x07j8KsUUUUUU=
X-CM-SenderInfo: x2kh0wp0lqwv3d6l2u1dvotugofq/
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhengxingda@iscas.ac.cn,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[iscas.ac.cn:mid,iscas.ac.cn:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-238650-lists,stable=lfdr.de];
	DMARC_NA(0.00)[iscas.ac.cn];
	FORGED_RECIPIENTS_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: 32963424909
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

=E5=9C=A8 2026-04-19=E6=97=A5=E7=9A=84 08:01 -0700=EF=BC=8CIan Rogers=E5=86=
=99=E9=81=93=EF=BC=9A
> On Sun, Apr 19, 2026 at 2:08=E2=80=AFAM Icenowy Zheng
> <zhengxingda@iscas.ac.cn> wrote:
> >=20
> > The arch/loongarch/util/unwind-libdw.c file is already moved to
> > util/,
> > but the Build statement for it is forgot to be removed.
> >=20
> > Remove the stale Build statement.
> >=20
> > This fixes the build failure of perf tool in kernel v7.0 on
> > LoongArch.
> >=20
> > Fixes: e62fae9d9e85 ("perf unwind-libdw: Fix a cross-arch unwinding
> > bug")
> > Signed-off-by: Icenowy Zheng <zhengxingda@iscas.ac.cn>
> > Cc: stable@vger.kernel.org
>=20
> I think this is already fixed:
> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.=
git/commit/?h=3Dperf-tools-next

Thanks for pointing out!

Thanks,
Icenowy

> I also sent out a fix, fwiw:
> https://lore.kernel.org/linux-perf-users/20260305221927.3237145-3-irogers=
@google.com/
>=20
> Thanks,
> Ian
>=20
> > ---
> > =C2=A0tools/perf/arch/loongarch/util/Build | 1 -
> > =C2=A01 file changed, 1 deletion(-)
> >=20
> > diff --git a/tools/perf/arch/loongarch/util/Build
> > b/tools/perf/arch/loongarch/util/Build
> > index 3ad73d0289f3e..8d91e78d31c94 100644
> > --- a/tools/perf/arch/loongarch/util/Build
> > +++ b/tools/perf/arch/loongarch/util/Build
> > @@ -1,4 +1,3 @@
> > =C2=A0perf-util-y +=3D header.o
> >=20
> > =C2=A0perf-util-$(CONFIG_LOCAL_LIBUNWIND) +=3D unwind-libunwind.o
> > -perf-util-$(CONFIG_LIBDW_DWARF_UNWIND) +=3D unwind-libdw.o
> > --
> > 2.52.0
> >=20


