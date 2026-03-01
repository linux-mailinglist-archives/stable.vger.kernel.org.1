Return-Path: <stable+bounces-222411-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IHWFCHvdo2l5QQUAu9opvQ
	(envelope-from <stable+bounces-222411-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 07:32:27 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 62A931CEA14
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 07:32:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C241A301D047
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 06:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A8D13112D0;
	Sun,  1 Mar 2026 06:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P5XogwF4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ECB621D3E4
	for <stable@vger.kernel.org>; Sun,  1 Mar 2026 06:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772346744; cv=none; b=VChCVz9yj9k1LM5z6DwpBHwlwUX8sg/E1dl34Ads7OuEjECztNFOyx3qMjNmbeXsm/g0M0tavycXvuyC+X/IdMbPu9+l1pALWAlbdyl0HYgVt00Jci2WBzFumn5T/GZC+dLYNcjC0vSzBqjWq4bovQwQUjQheY6JmsMozBjrqcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772346744; c=relaxed/simple;
	bh=TqxBh2p8iwhTysf0T9JFQIrXHKi66jGKvtWigiD8xiU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=coPGp+d4fqAwo+ICvm41vYFvNkS1/SA8lolMBEuhQQGxyc7vylvzbT+Bu8kCfZwc2bMahUNQOGCLNju+lL2IQGfzRX9TID8mtstNroa2dUlW51JSmiEZIIl8BKWazpUCPyfqFdyCJPWPQ4JVZ7sWtIuY46TmfzSWNJcheB+JM8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P5XogwF4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DADCC2BC87
	for <stable@vger.kernel.org>; Sun,  1 Mar 2026 06:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772346743;
	bh=TqxBh2p8iwhTysf0T9JFQIrXHKi66jGKvtWigiD8xiU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=P5XogwF4/KXTK0/iLiAJL1PXflyo7fixxUxNvtJJwS+fxj4sxft0WOxKLKSUKJUmP
	 pPwtTlv8kWZunflgHcbCM9nVXii8urog6/wPCBdEuTakjVOSSCMJywFLXaCz4316RD
	 f2zp+26go0ziJIxBlPPR57nOADF7fqSi/NV12u3uoYn0VuAh2+jGEL8E2BEIS8TFE6
	 CmIgwSWhQY4u+bqyj6cAwrEHJryf2tCAoki9OgTKjzgjiHXqcWQ3oGovFARiU7lfuK
	 vIyucYxztTMavERhuPDp+i8xbv646TqwsOUxvdtlPBVKPZBSXgosdkHbEAAUOqTsIM
	 8L2LokXOBQZtw==
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-65c01595082so5397811a12.3
        for <stable@vger.kernel.org>; Sat, 28 Feb 2026 22:32:23 -0800 (PST)
X-Gm-Message-State: AOJu0Yy2jb2gZ+D9n96nvMilw77tjw6Ne9Q1D4Gry31CeNIMuxUbiDv7
	j+8bTxfKYgP1uqXDcPNq5FwGonmgJ+vuKzvSbSb95lrhnFKG52O5iietKN7CGdOz9Rcl2+U8kEF
	mLz7DxPcBEoxoPi6I8BTt8UsvYu75buM=
X-Received: by 2002:a05:6402:5113:b0:65c:62b6:4be5 with SMTP id
 4fb4d7f45d1cf-65fdd4cc062mr5104870a12.3.1772346742204; Sat, 28 Feb 2026
 22:32:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260301012744.1685320-1-sashal@kernel.org>
In-Reply-To: <20260301012744.1685320-1-sashal@kernel.org>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Sun, 1 Mar 2026 14:32:10 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6VRe5NRpBjo-_FBoDDvJmq-jNCYbvtdPZ-j_TZzFzS4A@mail.gmail.com>
X-Gm-Features: AaiRm50oAUpwLRrnZu2pQjh2ya2n9b_I6Cqis0M5D-p0oiLJEPONeIls3Qd1R84
Message-ID: <CAAhV-H6VRe5NRpBjo-_FBoDDvJmq-jNCYbvtdPZ-j_TZzFzS4A@mail.gmail.com>
Subject: Re: FAILED: Patch "LoongArch: Use %px to print unmodified unwinding
 address" failed to apply to 6.12-stable tree
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, yangtiezhu@loongson.cn, 
	Huacai Chen <chenhuacai@loongson.cn>, loongarch@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-222411-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chenhuacai@kernel.org,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[loongson.cn:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 62A931CEA14
X-Rspamd-Action: no action

Hi, Sasha,

On Sun, Mar 1, 2026 at 9:27=E2=80=AFAM Sasha Levin <sashal@kernel.org> wrot=
e:
>
> The patch below does not apply to the 6.12-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
I'm very confused because it can be applied and already here:
https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/tre=
e/queue-6.12

Huacai

>
> Thanks,
> Sasha
>
> ------------------ original commit in Linus's tree ------------------
>
> From 77403a06d845db1caf9a6b0867b43e9dd8de8e4a Mon Sep 17 00:00:00 2001
> From: Tiezhu Yang <yangtiezhu@loongson.cn>
> Date: Tue, 10 Feb 2026 19:31:13 +0800
> Subject: [PATCH] LoongArch: Use %px to print unmodified unwinding address
>
> Currently, use %p to prevent leaking information about the kernel memory
> layout when printing the PC address, but the kernel log messages are not
> useful to debug problem if bt_address() returns 0. Given that the type of
> "pc" variable is unsigned long, it should use %px to print the unmodified
> unwinding address.
>
> Cc: stable@vger.kernel.org
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> ---
>  arch/loongarch/kernel/unwind_orc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/loongarch/kernel/unwind_orc.c b/arch/loongarch/kernel/u=
nwind_orc.c
> index 8a6e3429a860e..d6b3688a1ce97 100644
> --- a/arch/loongarch/kernel/unwind_orc.c
> +++ b/arch/loongarch/kernel/unwind_orc.c
> @@ -494,7 +494,7 @@ bool unwind_next_frame(struct unwind_state *state)
>
>         state->pc =3D bt_address(pc);
>         if (!state->pc) {
> -               pr_err("cannot find unwind pc at %p\n", (void *)pc);
> +               pr_err("cannot find unwind pc at %px\n", (void *)pc);
>                 goto err;
>         }
>
> --
> 2.51.0
>
>
>
>
>

