Return-Path: <stable+bounces-235629-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CIBcIP4R2Wl+lggAu9opvQ
	(envelope-from <stable+bounces-235629-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 17:06:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BE4EF3D8F35
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 17:06:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 769C33047521
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 15:02:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F38E93D902A;
	Fri, 10 Apr 2026 15:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gkKMSHsa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4EB93D891B;
	Fri, 10 Apr 2026 15:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775833362; cv=none; b=gGtpuQvZDAgNLdDJ6evKnBRvlGQG5XXpR04ujVX0+36gu2wWrFuVGinnFUfZ9OzBYC5fV9ANfkvKdqnVXnoAqenrYcAehUrXukTkBzQfoxExQh+YbFGp2azxn6AixMAKhHqNs2Zph2IH5YdMw3bgIZu6ax6c/DOnAa1NofME0WA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775833362; c=relaxed/simple;
	bh=atcdLfEzGCk7sNy6PlWGj//0B89T1lqmjP4hSanhbAo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gpjaG1Fvg2hZvTCBjWTMghN8W1vgp3Di6dOFfkSpcPY1ipCksZdnk/W6zS0fmJX9lFP20hS/nJ3GwLZ0nmbPzuAm7mfl7NIKfu/LMNWnWvCIi42IYLYjtwDnT7/vpq92C/vnxbovYLny3t29wTAZlYryAoFZ+89rFZEQA30oWms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gkKMSHsa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFF82C2BC87;
	Fri, 10 Apr 2026 15:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775833362;
	bh=atcdLfEzGCk7sNy6PlWGj//0B89T1lqmjP4hSanhbAo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=gkKMSHsaFUxtGTMBpEQovhvqntBsuEEVDg+N/o0y3EUyJR+fX8ZDmXFW1vQHheZR/
	 gDAceUB3mJ5Dn8UTmLlwZnnnfHu9Xgmt6Mzfc5yM+KuEvi9xCxAh2Sdvk52ThR4Klz
	 M7ozUcNZiXQBdrZiGUNevzXwUqb5b0Nl4AZnQn5RxYY336ADdWT5pq5ElFitFedjj/
	 gsa7OYH1OoMjA3pJzsZmN2ZaqWHaZddMLqiL5tcDaXPiZ5ZKp+hpBLTAiZxryTY3zy
	 YS/lO/DgPOU6Y+N5hHhRT2lJFf1IPeFHK3Qt4HljQ5H/byl8s3qOQ0L3a07ct6vZGj
	 BUhnQn5LkNleA==
From: Thomas Gleixner <tglx@kernel.org>
To: George Guo <dongtai.guo@linux.dev>, chenhuacai@kernel.org,
 jiaxun.yang@flygoat.com
Cc: linux-kernel@vger.kernel.org, George Guo <guodongtai@kylinos.cn>,
 stable@vger.kernel.org, Kexin Liu <liukexin@kylinos.cn>
Subject: Re: [PATCH 1/1] irqchip/loongson-pch-pic: Fix vec_count reading for
 32-bit and 64-bit
In-Reply-To: <20260410013053.3877-1-dongtai.guo@linux.dev>
References: <20260410013053.3877-1-dongtai.guo@linux.dev>
Date: Fri, 10 Apr 2026 17:02:39 +0200
Message-ID: <871pgm2700.ffs@tglx>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [2.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-235629-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tglx@kernel.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.996];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,kylinos.cn:email]
X-Rspamd-Queue-Id: BE4EF3D8F35
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 10 2026 at 09:30, George Guo wrote:
> From: George Guo <guodongtai@kylinos.cn>
>
> Commit 0370a5e740f2 ("irqchip/loongson-pch-pic: Adjust irqchip driver for
> 32BIT/64BIT") changed vec_count reading from readq() to readl() to support
> both 32-bit and 64-bit platforms. However, on virtual 64-bit platforms
> (QEMU 8.2.0) this causes incorrect vec_count value, leading to panic:

Is this problem limited to qemu?

> WARNING: drivers/acpi/irq.c:63 at acpi_register_gsi+0xe8/0x108
> Call Trace:
> [<900000000024c634>] show_stack+0x64/0x188
> [<9000000000245154>] dump_stack_lvl+0x6c/0x9c

Please trim your backtrace as documented:

https://www.kernel.org/doc/html/latest/process/submitting-patches.html#backtraces

> @@ -343,7 +343,12 @@ static int pch_pic_init(phys_addr_t addr, unsigned long size, int vec_base,
>  		priv->table[i] = PIC_UNDEF_VECTOR;
>  
>  	priv->ht_vec_base = vec_base;
> -	priv->vec_count = ((readl(priv->base + 4) >> 16) & 0xff) + 1;
> +
> +	if (IS_ENABLED(CONFIG_64BIT))
> +		priv->vec_count = ((readq(priv->base) >> 48) & 0xff) + 1;
> +	else
> +		priv->vec_count = ((readl(priv->base + 4) >> 16) & 0xff) + 1;

This does not make sense at all.

     readl(base + 4) >> 16

is fully equivalent to

     readq(base) >> 48

on a little endian machine, no?

This needs a better explanation in the change log about the root cause
and why this is the correct solution to fix the problem.

If there is no other solution then this needs a big fat comment in the
code explaining the reason. Otherwise the next AI agent will notice the
equivalence and people will send cleanup patches....

Thanks,

        tglx

