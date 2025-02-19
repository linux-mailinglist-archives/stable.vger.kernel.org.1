Return-Path: <stable+bounces-118312-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEA93A3C62C
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 18:26:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 464BF17966A
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 17:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CDAF21423F;
	Wed, 19 Feb 2025 17:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=criticallink.com header.i=@criticallink.com header.b="Q0q77JbU"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC7F120E6F9
	for <stable@vger.kernel.org>; Wed, 19 Feb 2025 17:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739986005; cv=none; b=VDe/imvG8roeZuyUiunQNe3Av8qPE4McpPcEP3jcefHaJdJPV3fzFbIrCpLuKJHZYEp9VG+7/pd1NUBNCBjZ95mYgqiENRCv7JXw8WmxcSSjHqa3+UO1VaatUNtnruTlkY11nZlt4QYcgTCrvercQBSGQa0PmfR5hQlaTjzwp84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739986005; c=relaxed/simple;
	bh=1XiBNuJTzHPL/MRXYAuMZnQavCaHYjRJito6i20Mj+c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=js7t53ZJuKa7ALeQjprVTp2iRtpHPzQWwpiJnr8gLWcPEpptL7Uygknpx0k316P+Epx9DR9f4oBOYYkvG9HO2S3Q5PxQWg6Yk1xshR/MCkrzAoMmqf2G3CFVsoJaw2rHmBvTdVHbO7Uz84h/92ChNmDMVVQQIG6gZT4RZR+XfCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=criticallink.com; spf=pass smtp.mailfrom=criticallink.com; dkim=pass (2048-bit key) header.d=criticallink.com header.i=@criticallink.com header.b=Q0q77JbU; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=criticallink.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=criticallink.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5462ea9691cso77648e87.2
        for <stable@vger.kernel.org>; Wed, 19 Feb 2025 09:26:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=criticallink.com; s=google; t=1739986001; x=1740590801; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kezi20k2gpXEVyhfLjkzYhktG7Nl+uo5vkpb6jywdqw=;
        b=Q0q77JbUzqj1pn+Q7Mwx6/WdYZwBNpmzLJPOTLZUpryd1v3XFW03+z4mrwb9RcIKbt
         sDy85Lu5O+hnoxRcf/msW6WzA7oTidpTKS8FgVNocmFujFfzy8RTvDmzfSSM2YVcRkOu
         rmQCzYKXyl55yDN8A0PPNqRvxbSBHuMFwtvlrMJOY+TBSrnPsO6ewFvG5AzqxSEph4P6
         LUQIK6CxqzXJyPKieU9eIMhD5gSXqQCTr7lqbiEDo4Iv4VV1fQEM/7msGWfmSUiEA4SI
         b93SYBHNgTf8T36uPiauQN9hmDlLTmMU8jf/7lMT8lOjRiqpbHBTpuLJhmaAqPsimYol
         mSBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739986001; x=1740590801;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kezi20k2gpXEVyhfLjkzYhktG7Nl+uo5vkpb6jywdqw=;
        b=Fommx4euMJX/+hsb5A3mIs1WdlbGWgDMZLfgSLy/g1bDnf9I6ukMGFf5lbw5K6Uewa
         HjhKfxSIgc5j72Ji8CcBIlTHr4FIu2zljGQSvPgzAocxhD+PjABFn8RFXOiIb62dAk9m
         m6t1GqJXjoZ2cexJhQqamNBo+06Hqdtj2tVl57m2Z6dN6G/2pIBNdN3TRVSEzxyexeJm
         nOAvWuK8tOuvpj4HpbqVbgpmvApC74wgSH/6VMKxYsz6/01YsvmyTqvjirNW7fADUUhr
         h+h+RpicW4fyIYW+IPjFxMWp/MrkgOhFek2VLmE2/eVAiNJ+YOVxtqBpe9pNct8iOrsK
         hUGA==
X-Gm-Message-State: AOJu0YzLre0bYVQWS0RLwgipqjdiC5+mkk77/kAKO04oZ5a1t46/FQ6h
	WjvErcNywagVKX263V4OhSGhmAPM4miJPD6401BhcskNA9vkW2v+kk6mr4KewzJEVW/O0CELH0L
	l0+e8WvjnfGfc2vpuDEi7SAYFDgm1/M0xjty9
X-Gm-Gg: ASbGncsaeMlFGSub4KdnvZBoOju5vTAZ3ZTgPn/rseXzcR8XHvlNKcOrVmJKoTh8CWR
	HYxPPsot+ey8uDamAUcgD416sSRLHlSPR+DEEStv5oC7LXcOFIuhLc3bu50b6QipuAd6avyQ=
X-Google-Smtp-Source: AGHT+IFSn1WjrEpk0+T0pG/tczzy4/xOeK+S+Yz0+rQBtSGOk4g/QyXsCji20gb3M6++A2ENSqW+LMiS6KW5PJWbtM0=
X-Received: by 2002:a05:6512:1296:b0:545:95b:a335 with SMTP id
 2adb3069b0e04-5462eedef16mr1624005e87.14.1739986000801; Wed, 19 Feb 2025
 09:26:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250219082652.891560343@linuxfoundation.org> <20250219082714.866086296@linuxfoundation.org>
In-Reply-To: <20250219082714.866086296@linuxfoundation.org>
From: Jon Cormier <jcormier@criticallink.com>
Date: Wed, 19 Feb 2025 12:26:29 -0500
X-Gm-Features: AWEUYZlxoR0yiPgplmwY2NmGsiO5VeidWdgZtI_l2ShA1DApazlZW5h2Y-FNGG8
Message-ID: <CADL8D3Yf-pQY7nPXK4n7re=BaNNZWPJdY37CkrDi4kfQFfPMqQ@mail.gmail.com>
Subject: Re: [PATCH 6.1 557/578] drm/tidss: Clear the interrupt status for
 interrupts being disabled
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	Devarsh Thakkar <devarsht@ti.com>, Aradhya Bhatia <aradhya.bhatia@linux.dev>, 
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 19, 2025 at 4:33=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> 6.1-stable review patch.  If anyone has any objections, please let me kno=
w.
Looks good to me
>
> ------------------
>
> From: Devarsh Thakkar <devarsht@ti.com>
>
> commit 361a2ebb5cad211732ec3c5d962de49b21895590 upstream.
>
> The driver does not touch the irqstatus register when it is disabling
> interrupts.  This might cause an interrupt to trigger for an interrupt
> that was just disabled.
>
> To fix the issue, clear the irqstatus registers right after disabling
> the interrupts.
>
> Fixes: 32a1795f57ee ("drm/tidss: New driver for TI Keystone platform Disp=
lay SubSystem")
> Cc: stable@vger.kernel.org
> Reported-by: Jonathan Cormier <jcormier@criticallink.com>
> Closes: https://e2e.ti.com/support/processors-group/processors/f/processo=
rs-forum/1394222/am625-issue-about-tidss-rcu_preempt-self-detected-stall-on=
-cpu/5424479#5424479
> Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
> [Tomi: mostly rewrote the patch]
> Reviewed-by: Jonathan Cormier <jcormier@criticallink.com>
> Tested-by: Jonathan Cormier <jcormier@criticallink.com>
> Reviewed-by: Aradhya Bhatia <aradhya.bhatia@linux.dev>
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> Link: https://patchwork.freedesktop.org/patch/msgid/20241021-tidss-irq-fi=
x-v1-5-82ddaec94e4a@ideasonboard.com
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/gpu/drm/tidss/tidss_dispc.c |   10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> --- a/drivers/gpu/drm/tidss/tidss_dispc.c
> +++ b/drivers/gpu/drm/tidss/tidss_dispc.c
> @@ -599,7 +599,7 @@ void dispc_k2g_set_irqenable(struct disp
>  {
>         dispc_irq_t old_mask =3D dispc_k2g_read_irqenable(dispc);
>
> -       /* clear the irqstatus for newly enabled irqs */
> +       /* clear the irqstatus for irqs that will be enabled */
>         dispc_k2g_clear_irqstatus(dispc, (mask ^ old_mask) & mask);
>
>         dispc_k2g_vp_set_irqenable(dispc, 0, mask);
> @@ -607,6 +607,9 @@ void dispc_k2g_set_irqenable(struct disp
>
>         dispc_write(dispc, DISPC_IRQENABLE_SET, (1 << 0) | (1 << 7));
>
> +       /* clear the irqstatus for irqs that were disabled */
> +       dispc_k2g_clear_irqstatus(dispc, (mask ^ old_mask) & old_mask);
> +
>         /* flush posted write */
>         dispc_k2g_read_irqenable(dispc);
>  }
> @@ -738,7 +741,7 @@ static void dispc_k3_set_irqenable(struc
>
>         old_mask =3D dispc_k3_read_irqenable(dispc);
>
> -       /* clear the irqstatus for newly enabled irqs */
> +       /* clear the irqstatus for irqs that will be enabled */
>         dispc_k3_clear_irqstatus(dispc, (old_mask ^ mask) & mask);
>
>         for (i =3D 0; i < dispc->feat->num_vps; ++i) {
> @@ -763,6 +766,9 @@ static void dispc_k3_set_irqenable(struc
>         if (main_disable)
>                 dispc_write(dispc, DISPC_IRQENABLE_CLR, main_disable);
>
> +       /* clear the irqstatus for irqs that were disabled */
> +       dispc_k3_clear_irqstatus(dispc, (old_mask ^ mask) & old_mask);
> +
>         /* Flush posted writes */
>         dispc_read(dispc, DISPC_IRQENABLE_SET);
>  }
>
>


--=20
Jonathan Cormier
Senior Software Engineer

Voice:  315.425.4045 x222

http://www.CriticalLink.com
6712 Brooklawn Parkway, Syracuse, NY 13211

