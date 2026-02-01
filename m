Return-Path: <stable+bounces-212994-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id hW7rA6FPf2kmnwIAu9opvQ
	(envelope-from <stable+bounces-212994-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Feb 2026 14:05:37 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A494C5F73
	for <lists+stable@lfdr.de>; Sun, 01 Feb 2026 14:05:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AC072300380F
	for <lists+stable@lfdr.de>; Sun,  1 Feb 2026 13:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 002E73446DA;
	Sun,  1 Feb 2026 13:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kxlccvyf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C1FB1BCA1C;
	Sun,  1 Feb 2026 13:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769951128; cv=none; b=D8/l+hL6MbgfPhLG1lYCMW2FYCZj4oo7Az2F+Xao4bpFprW13/JUorQCATqyAoZRbV+q6P4SWgSKh/T9oPAkZncm4WmCOj+Flj8aLWyygOlGMBkReKlXA7UubLL9CC7JoCFMhUcKkDFQAND18/LfN+zFl39U+EtH2RTnZ/1QOCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769951128; c=relaxed/simple;
	bh=ykDc/mX/B0Knfb1w4d4WmKGX7RhY+JpKLs0BSN0c4RA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C3QpHINMrtxg4GO0RoAqOOk7KryR9BWrUL1lmzGcgwcVZCPNoyqqperwwLy5RkeiQF6jLJU3P2uem2AzUjnZ7w4ip+fow4buzTM7U32xHBXceguZJdNYBGoYX7n7s04rK4M/WNMNgGJcxQrkNmwBrcmErfMTozijvn9+ewkwhbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kxlccvyf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0E8AC4CEF7;
	Sun,  1 Feb 2026 13:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769951127;
	bh=ykDc/mX/B0Knfb1w4d4WmKGX7RhY+JpKLs0BSN0c4RA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kxlccvyfoOQ1mow+24FMMNIHNm5IjaT8eLMQPQqcjv3ikV2UqMrwptxnS9h04GNF1
	 ieQvCoDPHmnmN+yNDVE5Sq7CUp1iT7hPoUQijk54zEXBQhSv2t96GiGvlTIbjSfc8q
	 YdPeg60aEQbIagl3SOJ0kYV/qVa4F6/f5IB2U1b4=
Date: Sun, 1 Feb 2026 14:05:24 +0100
From: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To: Sai Ritvik Tanksalkar <stanksal@purdue.edu>
Cc: "kees@kernel.org" <kees@kernel.org>,
	"tony.luck@intel.com" <tony.luck@intel.com>,
	"gpiccoli@igalia.com" <gpiccoli@igalia.com>,
	"anton.vorontsov@linaro.org" <anton.vorontsov@linaro.org>,
	"linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] pstore/ram: fix buffer overflow in
 persistent_ram_save_old()
Message-ID: <2026020150-nerd-unweave-929a@gregkh>
References: <SJ2PR22MB4268740D8B115ED88EAC4959BE9DA@SJ2PR22MB4268.namprd22.prod.outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <SJ2PR22MB4268740D8B115ED88EAC4959BE9DA@SJ2PR22MB4268.namprd22.prod.outlook.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	FROM_DN_EQ_ADDR(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-212994-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,purdue.edu:email]
X-Rspamd-Queue-Id: 2A494C5F73
X-Rspamd-Action: no action

On Sun, Feb 01, 2026 at 12:59:24PM +0000, Sai Ritvik Tanksalkar wrote:
> persistent_ram_save_old() can be called multiple times for the same
> persistent_ram_zone (e.g., via ramoops_pstore_read -> ramoops_get_next_prz
> for PSTORE_TYPE_DMESG records).
> 
> Currently, the function only allocates prz->old_log when it is NULL,
> but it unconditionally updates prz->old_log_size to the current buffer
> size and then performs memcpy_fromio() using this new size. If the
> buffer size has grown since the first allocation (which can happen
> across different kernel boot cycles), this leads to:
> 
> 1. A heap buffer overflow (OOB write) in the memcpy_fromio() calls.
> 2. A subsequent OOB read when ramoops_pstore_read() accesses the buffer
>    using the incorrect (larger) old_log_size.
> 
> The KASAN splat would look similar to:
>   BUG: KASAN: slab-out-of-bounds in ramoops_pstore_read+0x...
>   Read of size N at addr ... by task ...
> 
> Fix this by freeing and reallocating the buffer when the new size
> exceeds the previously allocated size. This ensures old_log always has
> sufficient space for the data being copied.
> 
> Fixes: 201e4aca5aa1 ("pstore/ram: Should update old dmesg buffer before reading")
> Cc: stable@vger.kernel.org
> Signed-off-by: Pwnverse <stanksal@purdue.edu>
> ---
>  fs/pstore/ram_core.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/fs/pstore/ram_core.c b/fs/pstore/ram_core.c
> index f1848cdd6d34..8df813a42a41 100644
> --- a/fs/pstore/ram_core.c
> +++ b/fs/pstore/ram_core.c
> @@ -298,6 +298,14 @@ void persistent_ram_save_old(struct persistent_ram_zone *prz)
>      if (!size)
>          return;
>  
> +     /*
> +      * If the existing buffer is too small, free it so a new one is
> +      * allocated. This can happen when persistent_ram_save_old() is
> +      * called multiple times with different buffer sizes.
> +      */
> +     if (prz->old_log && prz->old_log_size < size)
> +           persistent_ram_free_old(prz);
> +
>      if (!prz->old_log) {
>          persistent_ram_ecc_old(prz);
>          prz->old_log = kvzalloc(size, GFP_KERNEL);
> -- 
> 2.43.0

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

- Your patch is malformed (tabs converted to spaces, linewrapped, etc.)
  and can not be applied.  Please read the file,
  Documentation/process/email-clients.rst in order to fix this.

- It looks like you did not use your "real" name for the patch on either
  the Signed-off-by: line, or the From: line (both of which have to
  match).  Please read the kernel file,
  Documentation/process/submitting-patches.rst for how to do this
  correctly.

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

