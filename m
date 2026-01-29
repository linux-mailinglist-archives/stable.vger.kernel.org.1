Return-Path: <stable+bounces-212718-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CEEbN/W2emma9QEAu9opvQ
	(envelope-from <stable+bounces-212718-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 29 Jan 2026 02:25:09 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 805F0AAAEB
	for <lists+stable@lfdr.de>; Thu, 29 Jan 2026 02:25:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EBD56302ED1F
	for <lists+stable@lfdr.de>; Thu, 29 Jan 2026 01:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 124E731B800;
	Thu, 29 Jan 2026 01:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kk/2bljf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8EB12FE566;
	Thu, 29 Jan 2026 01:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769649444; cv=none; b=QA2yiYEecxOe+VzcYkkh8T4hV1985jmHcNKLO0vpxieK9+M7N7TDw1WTZYXCb9oZrxWVNfmX2ZXyMe0y7vUkK9HeTtOCWODZiAewHzlPI0fioQX50MSrr8zJbVWFP2vYvzSa5wKyEUAOKdTk6aQV+qpJzQHGRsgzQ2PsHNuey2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769649444; c=relaxed/simple;
	bh=D/IkbJyJ8dzJu/m0Oq7rZy5LRS0CebRGYUjs9pw88Bw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f3FLqWaDKdhi9/WCcMH5Mn5UnTJ8oEtXcmbOi+otEcsU+kMW0igw+1ipZSgjkF7rHQZlIiLTQRCohBjuaJHl4OyybR7yHZAmSCo6Y0leg2PVIwpaGyNIhL4yc01rcZUZehnZVd7meieIDy7zuuBP2e4UrL6He+5hTxDIvz7p8MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kk/2bljf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 859BFC4CEF1;
	Thu, 29 Jan 2026 01:17:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769649444;
	bh=D/IkbJyJ8dzJu/m0Oq7rZy5LRS0CebRGYUjs9pw88Bw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Kk/2bljfOvlt7Y6FCsrn/g954SLnE/Ew8TaKyl1w6/LHYR4QVD87qS6AoWyA5rpMO
	 TUNxnCCsxqsojp2iYZoeOLETqI6XZpAJ1GfnYseXnNRtoYmScwyXbl28Bj0hirz1kw
	 MdqqwYNcnNfADeTj7vzT3DNJn44iW+rR6dynp1qsYGWYminC3edT88XNu7Rf7JEzwe
	 JaqLPhm1SM8m00w2IRqO3WJTRQ7ULQXHxv9SwVe9764FJ/T8DYia+HHQ2zpGERxzoa
	 zpAGp0SKDd7jMnVcDbKc2CEcea8uXzGMoTvjvgK2Q6bCD4QMhvHtTXP57iOm43Low+
	 uOl1KvShFOSFA==
Date: Wed, 28 Jan 2026 20:17:18 -0500
From: Guo Ren <guoren@kernel.org>
To: Han Gao <gaohan@iscas.ac.cn>
Cc: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	Han Gao <rabenda.cn@gmail.com>, stable@vger.kernel.org
Subject: Re: [PATCH] riscv: compat: fix COMPAT_UTS_MACHINE definition
Message-ID: <aXq1HthMYkBGXx/l@gmail.com>
References: <20260127190711.2264664-1-gaohan@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260127190711.2264664-1-gaohan@iscas.ac.cn>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-212718-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,dabbelt.com,eecs.berkeley.edu,ghiti.fr,lists.infradead.org,vger.kernel.org,gmail.com];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[guoren@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:url,infradead.org:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 805F0AAAEB
X-Rspamd-Action: no action

On Wed, Jan 28, 2026 at 03:07:11AM +0800, Han Gao wrote:
> The COMPAT_UTS_MACHINE for riscv was incorrectly defined as "riscv".
> Change it to "riscv32" to reflect the correct 32-bit compat name.
> 
> Fixes: 06d0e3723647 ("riscv: compat: Add basic compat data type implementation")
> Cc: stable@vger.kernel.org
> 
> Signed-off-by: Han Gao <gaohan@iscas.ac.cn>
> ---
>  arch/riscv/include/asm/compat.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/riscv/include/asm/compat.h b/arch/riscv/include/asm/compat.h
> index 6081327e55f5..28e115eed218 100644
> --- a/arch/riscv/include/asm/compat.h
> +++ b/arch/riscv/include/asm/compat.h
> @@ -2,7 +2,7 @@
>  #ifndef __ASM_COMPAT_H
>  #define __ASM_COMPAT_H
>  
> -#define COMPAT_UTS_MACHINE	"riscv\0\0"
> +#define COMPAT_UTS_MACHINE	"riscv32\0\0"
Good catch, my typo. The UTS_MACHINE is riscv32 in Makefile. Thx for fixup.

Reviewed-by: Guo Ren (Alibaba Damo Academy) <guoren@kernel.org>


>  
>  /*
>   * Architecture specific compatibility types
> -- 
> 2.47.3
> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
> 

