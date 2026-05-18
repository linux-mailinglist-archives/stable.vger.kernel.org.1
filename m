Return-Path: <stable+bounces-249272-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oMitIIwOC2pN/gQAu9opvQ
	(envelope-from <stable+bounces-249272-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 15:05:16 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F08456D41E
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 15:05:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B3FC73034A2B
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 12:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 419874657C2;
	Mon, 18 May 2026 12:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="I26H2lA0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E608C4534AE;
	Mon, 18 May 2026 12:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779109063; cv=none; b=NZB3FFRSUBegQm0zQl/Y2F6V+iW1yyh0pDWfNqIMxfL5nNYbCgEMhsNk5K08uHtjIce7IiN+QUwTc2Oeb1BfDdVIvTaTTmrvnrDklGok2xIeUtHF8t8zJsWPvQRPm0WT9ewglNODCpWA3tecvWiEixH9QDfcERgIh418YjO0Jvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779109063; c=relaxed/simple;
	bh=YRRrljfx2AYP0ODnBJBnxldou5SjjyxCVajUiH70kvA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CC2dvppQAseD/0r5wvVWzJLZ/qriV6u9Tm0QQT43j3lAJqndM2wjqe8kylfR2vpuA9/AQ2anpxN4/SZ/mhWIGf9IywQZeAYA/5WC7KJABUV+C537OXKxgSMFEJqLvVyZsNAAf2GR1dfzxPLdJX71MxIMPMJdrAnEvZogJ2FGcAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=I26H2lA0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6492EC2BCB7;
	Mon, 18 May 2026 12:57:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1779109062;
	bh=YRRrljfx2AYP0ODnBJBnxldou5SjjyxCVajUiH70kvA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I26H2lA0o6c2g+XH7+UBuLV3SlbuESQt7X07rvzTavBrGoQUE9aj3+RNsCENJadOK
	 qJOx4XGDO8g60sGcQwJSBu9opZE+4dJXagVajpBLUeqGLgLpMnOhZjooBlAXJS1zas
	 asa3QksVn5KkHMPP+bSxZehBRvfx7QIR+D9Fd2Ms=
Date: Mon, 18 May 2026 14:57:46 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Andrii Kuchmenko <capyenglishlite@gmail.com>
Cc: linux-modules@vger.kernel.org, chleroy@kernel.org, mcgrof@kernel.org,
	dmitry.torokhov@gmail.com, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] module: decompress: check return value of
 module_extend_max_pages()
Message-ID: <2026051832-mystify-gaffe-0d5a@gregkh>
References: <20260518121858.3071-1-capyenglishlite@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260518121858.3071-1-capyenglishlite@gmail.com>
X-Rspamd-Queue-Id: 1F08456D41E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-249272-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On Mon, May 18, 2026 at 03:18:58PM +0300, Andrii Kuchmenko wrote:
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
>   module_decompress()    <- vulnerable, runs FIRST
>   load_module()
>     module_sig_check()   <- signature check, runs SECOND
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
>  kernel/module/decompress.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/kernel/module/decompress.c b/kernel/module/decompress.c
> --- a/kernel/module/decompress.c
> +++ b/kernel/module/decompress.c
> @@ -XXX,9 +XXX,12 @@ int module_decompress(struct load_info *info,
>  				const void *buf, size_t size)
>  {
>  	unsigned int n_pages;
>  	int error;
>  	ssize_t data_size;
>  
>  	n_pages = DIV_ROUND_UP(size, PAGE_SIZE) * 2;
>  	error = module_extend_max_pages(info, n_pages);
> +	if (error)
> +		return error;
>  	data_size = MODULE_DECOMPRESS_FN(info, buf, size);
>  	if (data_size < 0) {
>  		error = data_size;
> -- 
> 2.39.0
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- This looks like a new version of a previously submitted patch, but you
  did not list below the --- line any changes from the previous version.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/process/submitting-patches.rst for what
  needs to be done here to properly describe this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot

