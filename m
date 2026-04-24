Return-Path: <stable+bounces-240996-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0DooLGuR62lGOgAAu9opvQ
	(envelope-from <stable+bounces-240996-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 17:51:07 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 47C78461010
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 17:51:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7758A3006B46
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 15:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C089372690;
	Fri, 24 Apr 2026 15:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Is4EurYV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F49C335562
	for <stable@vger.kernel.org>; Fri, 24 Apr 2026 15:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777045864; cv=none; b=OfZLu+NPDSRYTOX3Y3SVemXJp9IoidSE7cO4hOYjNWYoa6zAh9+0I3eEDjMSWtNX5hE2H5d/t26sn4hPOoF7zgdS/WpMIO1sL9bHMezSiG4JvcxT8DRApX6NPo/KZkFcc+qvAQqajfF4P4BNbPKNCgQJBNbaOnWpJmf1nA2N/BE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777045864; c=relaxed/simple;
	bh=YjXQNV8OauYeDrdhMsU00T+1ceHJkPAvfGVjsfjyFNY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RyrHyM0CfZWQzdIFTmS1ATJm9uGA9tcvHtzdcaKeFLMlXu+D0OJKd0bA81UvyzkFn79MdbJ61nULiDb1mjkUwQrWzCwqs4p6VDJkcM0+8ehs9fZKKLOHIsegV1mJA5K+g1wbed70zV4iYgTID/IMAUuMwIRYQKBXWDaDaL9htrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Is4EurYV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A731CC19425
	for <stable@vger.kernel.org>; Fri, 24 Apr 2026 15:51:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777045863;
	bh=YjXQNV8OauYeDrdhMsU00T+1ceHJkPAvfGVjsfjyFNY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Is4EurYVIOtYQlO8kACJgD4u/Wyt6HAuKthMo5iWyndVAjM0eKQYhoDezWP98dMv4
	 cHS1RwM3B8yRIHSRs5zkDuNxrz81GAZZB2r0SDcIVL1KTQ3QUnU4FvVt1Y4r5aSkk3
	 tbii5GNch88hdmPRVnaJJVBn3iTjyuxuVRAapSsUBPovozv2I4YFa20z/2Rj5+amlK
	 +9ATb4fXpmJFY3sLOjpcETX5Y7wXqJCQ816yRhapf6srrT3zu0KekxyJSDfrMELeRI
	 7guMCML39qAOdKriWv1HMxX4x1DBKawPvEb/KMMj0+WeXfWGTsbUWhf9Dmh+CJAKsr
	 7zsJImiGdwRpw==
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-8a210c813f8so53960356d6.0
        for <stable@vger.kernel.org>; Fri, 24 Apr 2026 08:51:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9raEetzeyHtR8zCr0jwxqv3gnLzzmHINICeWGOc1BlhN53q98/2HChiOMPQawCXzSG0wQ4iVQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzC6qrXJcw3OFtOxZUCMTkbLR3RomY/J1nwxnPIiGvjOaJ5Lauo
	q0dN7KkOiq7iE4RcpvhpfwIEDG8deJ0/fZRF/oNm8QgWINpeocODohMzRWKk+0V1OYtVafoN9pJ
	VStXs392X1qSTp6E3mkKKObnkN6pqkPo=
X-Received: by 2002:a05:6214:4104:b0:8ac:b053:2b38 with SMTP id
 6a1803df08f44-8b0280ecdd1mr483894586d6.31.1777045862799; Fri, 24 Apr 2026
 08:51:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260424153905.354922-1-jolsa@kernel.org>
In-Reply-To: <20260424153905.354922-1-jolsa@kernel.org>
From: Song Liu <song@kernel.org>
Date: Fri, 24 Apr 2026 08:50:51 -0700
X-Gmail-Original-Message-ID: <CAPhsuW5rcXABPeOy7PFkHkO8WNyfqppGpB5ijTvmMbj7GVWfcg@mail.gmail.com>
X-Gm-Features: AQROBzD7vKe4jUX7_u1aiOXiJ_CocfrwTuDkVypGBAR-nd1KryoIhFlLRJwB_RY
Message-ID: <CAPhsuW5rcXABPeOy7PFkHkO8WNyfqppGpB5ijTvmMbj7GVWfcg@mail.gmail.com>
Subject: Re: [PATCH bpf 1/2] bpf: Do not release trampoline image in case off
 unregister error
To: Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, stable@vger.kernel.org, bpf@vger.kernel.org, 
	Martin KaFai Lau <kafai@fb.com>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <songliubraving@fb.com>, 
	Yonghong Song <yhs@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 47C78461010
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,vger.kernel.org,fb.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-240996-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[song@kernel.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid]

On Fri, Apr 24, 2026 at 8:39=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote:
>
> If unregister_fentry fails we still have trampoline image attached
> to a function, so releasing it could trigger crash. Releasing the
> trampoline image only when the unregister succeeds.
>
> Cc: stable@vger.kernel.org
> Fixes: e21aa341785c ("bpf: Fix fexit trampoline.")
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

The fix looks good.

Acked-by: Song Liu <song@kernel.org>

Can we add a test case that triggers this crash without the fix?

Thanks,
Song

