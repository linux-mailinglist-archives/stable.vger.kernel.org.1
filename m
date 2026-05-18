Return-Path: <stable+bounces-249222-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OD2BGCbPCmru8QQAu9opvQ
	(envelope-from <stable+bounces-249222-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 10:34:46 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B7DD568E52
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 10:34:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 384953024D5F
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 08:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 744DC3E3172;
	Mon, 18 May 2026 08:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YEFuiHQp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 352003E3152;
	Mon, 18 May 2026 08:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779092565; cv=none; b=SWLuEVBFA7zbQbuFdZGdumLt0YOF+Eq9ApZZaGnun96My9VeN0P0iNFxcaHdzjtJ07OQ5Urx7hgrYu8sGST3Gbp6cW+61vfY4C09g1XZhdFxVjeyVL2W8wjFI6k0vR4Dm3Um940m3/KCce7vhK7HgLTLh4WX9ZtyqZ6ThHlweqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779092565; c=relaxed/simple;
	bh=Ja8xJYvBHw17MUGizTjwFmkJ2dRz7Z5VWkYWZtCVoog=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NzVUAunD8S4nJ7wMnp8sszTXK0QU4/cpIUUaHzp3LrL4Bfni+zJ8UsL7RGCEPI/FYeFnPf+CwDhJ5dRdfuziDSNdbBSr3DIBRZs1qYcSTL3U7v7qAKm9LX9vtFwdquFQOhe5kfs1nQ6uulN8LVi3Bc477VTO9sv0wkUyLI6m7ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YEFuiHQp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A65E5C2BCB7;
	Mon, 18 May 2026 08:22:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779092565;
	bh=Ja8xJYvBHw17MUGizTjwFmkJ2dRz7Z5VWkYWZtCVoog=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=YEFuiHQpDtqhUhZ3FORIrOHsR0w499XWeUAjyakRRs+GQWxJZc4epb6SHKrRpHGmP
	 nDBO0uGOVzS64kCc/r0tOevkb2pWycBH12kTlFDG47ObtOx/PrLzFU0xixixWDeULu
	 YAyKl1yTlkV6U7NNn2hqDK1K6Pet0dAxt9qArgjzPxss295VOJZXhrMZ34Pyg9itvN
	 JKGR7lPLLYHGL6cR1QmtB+CMhTd1BSwyn2f3WWn8lGaTKhwkWDxx5ttLvUQMX6B2A8
	 Sw2R5uwdiuSIEUOsh2VveriUic99JXBtrZZE40EWth3C5YFuOAjTneq0YMof5U+rtJ
	 CfjD58w2Wh/Rw==
Message-ID: <f9fab2bc-ee1c-4d9c-af76-cde159b29ed9@kernel.org>
Date: Mon, 18 May 2026 10:22:41 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] module: decompress: check return value of
 module_extend_max_pages()
To: Andrii Kuchmenko <capyenglishlite@gmail.com>,
 linux-modules@vger.kernel.org
Cc: mcgrof@kernel.org, dmitry.torokhov@gmail.com,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260517110037.21506-1-capyenglishlite@gmail.com>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <20260517110037.21506-1-capyenglishlite@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 5B7DD568E52
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249222-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chleroy@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	REDIRECTOR_URL(0.00)[aka.ms];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[aka.ms:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action



Le 17/05/2026 à 13:00, Andrii Kuchmenko a écrit :
> [Vous ne recevez pas souvent de courriers de capyenglishlite@gmail.com. Découvrez pourquoi ceci est important à https://aka.ms/LearnAboutSenderIdentification ]
> 
> module_extend_max_pages() calls kvrealloc() internally and returns
> -ENOMEM on allocation failure. The return value is never checked.
> The decompression loop then continues calling module_get_next_page(),
> which writes struct page pointers into info->pages[]. When used_pages
> reaches the stale max_pages value (not updated due to the failed
> extend), a subsequent write to info->pages[used_pages++] goes out of
> bounds into adjacent heap memory.
> 
> Adjacent slab objects in the same kmalloc cache (pipe_buffer,
> seq_operations, cred) can be corrupted, potentially leading to local
> privilege escalation on kernels without SLAB_VIRTUAL mitigation.
> 
> The call order in finit_module() is:
> 
>    module_decompress()    <- vulnerable, runs FIRST
>    load_module()
>      module_sig_check()   <- signature check, runs SECOND
> 
> Decompression happens before signature verification. A crafted
> compressed module submitted via finit_module(MODULE_INIT_COMPRESSED_FILE)
> reaches this code path before any signature gate is applied. On kernels
> with module.sig_enforce=0 (default without SecureBoot) or with
> unprivileged user namespaces (Ubuntu, Debian default), this is
> reachable without CAP_SYS_MODULE.
> 
> Confirmed present in mainline (tested on v6.14-rc3).
> 
> Fix: add the missing error check after module_extend_max_pages() and
> return immediately on failure. This matches the pattern used by every
> other kvrealloc() caller in the module loading path.
> 
> Fixes: 169a58ad824d ("module: add in-kernel support for decompressing")
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: Luis Chamberlain <mcgrof@kernel.org>
> Cc: stable@vger.kernel.org
> Signed-off-by: Andrii Kuchmenko <capyenglishlite@gmail.com>
> ---
>   kernel/module/decompress.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/module/decompress.c b/kernel/module/decompress.c
> index a1b2c3d4e5f6..b7c8d9e0f1a2 100644
> --- a/kernel/module/decompress.c
> +++ b/kernel/module/decompress.c
> @@ -XXX,10 +XXX,13 @@ int module_decompress(struct load_info *info,
>                                  const void *buf, size_t size)
>   {
>          unsigned int n_pages;
> -       int error;
> +       int error = 0;

Please don't do that, this is unnecessary. 'error' is being set 
inconditionaly two lines below and unused before that.

>          ssize_t data_size;
> 
>          n_pages = DIV_ROUND_UP(size, PAGE_SIZE) * 2;
> +

Don't add unrelated blank lines.

>          error = module_extend_max_pages(info, n_pages);
> +       if (error)
> +               return error;
> +
>          data_size = MODULE_DECOMPRESS_FN(info, buf, size);
>          if (data_size < 0) {
>                  error = data_size;
> --
> 2.39.0
> 

On which tree/branch does your patch applies ?

