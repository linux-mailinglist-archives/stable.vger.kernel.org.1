Return-Path: <stable+bounces-240997-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kOcxEK+R62lxOgAAu9opvQ
	(envelope-from <stable+bounces-240997-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 17:52:15 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BE5846105A
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 17:52:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3A08C30028DA
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 15:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1C1F3CF697;
	Fri, 24 Apr 2026 15:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DtE8SwK/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84DF3371D16
	for <stable@vger.kernel.org>; Fri, 24 Apr 2026 15:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777045927; cv=none; b=JqPo/yVZ8ksdgypOmnvNPIDUluji7lrRQGlrCw4Tmu4Ddc2BJGp1jXfY70/R7U43B0/Vt5PbkxdgGdsG6ZachoZwdtKL+MLDweZouGeJwMwQBvs5Wp+bumgwVDjUhN1GUAiduQ5ahFWVtqmLSdJXMzbiL43EdS/216IuVTmQAEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777045927; c=relaxed/simple;
	bh=Q3t67leeswQbfHpqp0eums4/vkXiYlW7pS+Ion7RKLA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Oavk3tZ6H2m/RIbvAk3Az07R7u1gUbtL3AMN5zikOqlF2HG78zVO/3D+Hwsiy+izI1MMJj0gtVNCyPimneJjW4/KSGKCx/moJ71Nnk+/aHAMzMETfQWz24B9fA3zzvHqPBQcoI3MTYqA5sbDH1eBIS980K+OKu7AM77tpowSIBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DtE8SwK/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63049C4AF0B
	for <stable@vger.kernel.org>; Fri, 24 Apr 2026 15:52:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777045927;
	bh=Q3t67leeswQbfHpqp0eums4/vkXiYlW7pS+Ion7RKLA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=DtE8SwK/pJ6JFFS73e/pmrJPUZMIIhnJpSlRT5a7AtEcuA5TjvogYW+Kq4QmWOjNk
	 OGMnAxRPIuSUzcyXSCahz+oAOJUhQcyqobk2R7INzOJ/VnQiS9NJITiDvjCJVwBWHU
	 1v9jWzMpe3GakRN9gm1TGTy3WUx8wWbdyNsfCpCHZH3tZo7bG9XDG+fe0d5pjF3j/D
	 dl4DW6IvsHtp34eByUFBq6raGeaZQP/Z8JSUi6yJva/z/uCLDTnlryE4g7x4rlp+sj
	 kNEdhGpuhyUN1/b6pVeNZBOiFWS28r72ER2IOmgUA/p83WqKgjpGBAL9inBm++2hAo
	 jB8gwLcd6lbxQ==
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-506a6cf8242so57730661cf.1
        for <stable@vger.kernel.org>; Fri, 24 Apr 2026 08:52:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+o2wnlBhTo9tEp97p9L0kCLPP++OqkqgrxWdCnJI97PW9ziu6ie8j9dXIE66v4e7XoEO8g/kM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuzU31Re7t0OdJlfO8cZpZYYk85ABENh+u+eevMTsXnLHbAsS0
	m2ph2/ZDW0w1bOmRpmUtqyDLIZscyon6U2mdaO6Z7WdO5zOy2ZfXGoevq6uyavOgFRC5Koy2adE
	/FJA19PFwvfR8zIGp1Y8M2t5939maK6o=
X-Received: by 2002:ac8:5d12:0:b0:50f:ba44:ce4e with SMTP id
 d75a77b69052e-50fba44d76fmr223489571cf.6.1777045926451; Fri, 24 Apr 2026
 08:52:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260424153905.354922-1-jolsa@kernel.org> <20260424153905.354922-2-jolsa@kernel.org>
In-Reply-To: <20260424153905.354922-2-jolsa@kernel.org>
From: Song Liu <song@kernel.org>
Date: Fri, 24 Apr 2026 08:51:55 -0700
X-Gmail-Original-Message-ID: <CAPhsuW5yaQknFEbEpgUCcY=-6BYxSC_ey3kNspuaCceV=biP-Q@mail.gmail.com>
X-Gm-Features: AQROBzAVtnyxqxfN_3xUoX52-BQR60ZtqeDjSuWopfcpUcBXzWKjx56oygONXm0
Message-ID: <CAPhsuW5yaQknFEbEpgUCcY=-6BYxSC_ey3kNspuaCceV=biP-Q@mail.gmail.com>
Subject: Re: [PATCH bpf 2/2] bpf: Remove obsolete WARN_ON call
To: Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, stable@vger.kernel.org, bpf@vger.kernel.org, 
	Martin KaFai Lau <kafai@fb.com>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <songliubraving@fb.com>, 
	Yonghong Song <yhs@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 7BE5846105A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,vger.kernel.org,fb.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-240997-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[song@kernel.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

On Fri, Apr 24, 2026 at 8:39=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote:
>
> The WARN_ON call in bpf_trampoline_update could never hit, because we
> direct the code path with (total =3D=3D 0) to out label, which effectivel=
y
> skips the WARN_ON call.
>
> The WARN_ON made sense back then when it checked tr->selector, but now
> with total being set just inside the function it's useless.
>
> Cc: stable@vger.kernel.org
> Fixes: 47e79cbeea4b ("bpf: Remove bpf trampoline selector")
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

Acked-by: Song Liu <song@kernel.org>

