Return-Path: <stable+bounces-109298-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27E33A13E9D
	for <lists+stable@lfdr.de>; Thu, 16 Jan 2025 17:00:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 358BE3AF268
	for <lists+stable@lfdr.de>; Thu, 16 Jan 2025 15:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8381322CF03;
	Thu, 16 Jan 2025 15:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XGb2KXfR"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B81DC22A80B
	for <stable@vger.kernel.org>; Thu, 16 Jan 2025 15:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737043116; cv=none; b=bqIHbqM5bRm4IN4AFGIlezZN7nzGOlbBCGYIWugPOOBUF5vumGl3XUOMB9k45PODqC8WWgPb98CJ8sKCNQJslZeM/pnE1zn8926AxdT747vKNWVeDyMztmdGg+590/SoI1JSAknuGYP0LQX+5ZYpzSssPvDy8N1Y2fqhwI5oEto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737043116; c=relaxed/simple;
	bh=TsAFTtAPHFDWqClgUwsN+5G3GYn9qmIlLxL/HqroH30=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mJVRNal16X7yOO3RdqnYmQ5/9rJPrIbk0nvD+5fgtn3ScF9gxvdr1BjSOZhAmDcnVRpwdDj1uh/c2zHc+M7JHbsZvbHUS1pGHVc6bSoAw0LsYKRVj2RcAyftJo6He1aQVb2vVPrWjTu4sBGdU9n00HFP2NewUb3QaPexlXkBS0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XGb2KXfR; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e549dd7201cso1896414276.0
        for <stable@vger.kernel.org>; Thu, 16 Jan 2025 07:58:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737043113; x=1737647913; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xZg7i9Gkt1p2UGCmQVCKIa0P9txKm7ecHDqIrA9B8RM=;
        b=XGb2KXfRVGoR1Eiu2vhPmmbLb2hgGv98FzMH1i/BCE2WlVNjyrK6XSkboDb0+S2R6m
         VwrLtxBm6p/7n1Ivtl3o2OO7KZqbDmRCRSQD4/IDvdgPpoz4tVvtAlpUC9PTkDIAUNpT
         qkSCmD8rAu7ocUUJgPbP8e/4KtcqaUHczLXKmNGhSVPl1ZS1jFZg+3BTbqQrP058bnCs
         2d34r7vb/n845hGfiLdSw5Hkmo65lhMfsVArev4uPOs4/9x9rJ+AMEV6ZwBb+eTqpc3C
         Fc594a6C7iV8EzTzD4JXzI+S1sp7CahklZPtIqDnQvA5BrYTkonhou1sKnWXm96akzn1
         Rm8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737043113; x=1737647913;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xZg7i9Gkt1p2UGCmQVCKIa0P9txKm7ecHDqIrA9B8RM=;
        b=r4thaRDH09RmDDiJOyEVwbxxTKbtOkan7ZkQcLJUuwJS7pvgQAe1jfwn9X5eGVGzR/
         WLUavK7cfmP/parCBUwIXX3PehS5SLPfI5e7+SHhijvy01Hjv7DtNHK3ixqD7Oq177DI
         bBEl9MNF79swT9uAIDFwGnkHlc5h71VUwiZSldRJMweDBE/eUrgZ15u2B8CK5kETq4w9
         SqKmvj4rhNvYK8FU1inqYl4jaU2VaN3YWRmdBv/d2+o3qPGMQj36zuzFjvR9IoaocFnF
         +FTNlQuaG5rUyTPSZkNkydQX6lZAvnkh5SntpqjKTZ0lwSXv1HVeBOJqVpau+WK37Q3g
         f6xA==
X-Forwarded-Encrypted: i=1; AJvYcCWZ9UiQT/4UWJacC6COH91eHUSdDt/EzUOzjWZTvp/exvhsEoO898Qs7xBpIOMazLEMsWSHsJI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz22GxJLo2ydbZqW3ZoMqGTWhe7hkNftWrkBFEU9BHQt8L1nK08
	nY0CQiCiv1M9tvsm7eK+LdLhZDGqXBqcZUlW4EXUpqgLoE3rOSUdxPIbKFrlMoaIzLCPwEz16dL
	fD7tXyUlMpgSpPfUMjKsIW+rF95VI57/j+vxbIw==
X-Gm-Gg: ASbGnctHYwQQnSzfUJNP2v0V8HsBRp3xJbRY9xeKaz87Y51ATyErHXu2mQ/UJ7BJ6tK
	pYudp5v9fQAA1kOkp6mvVtn5uqdZZ41WGSgFTEQk=
X-Google-Smtp-Source: AGHT+IG1qVTRfq3rD5NuthhfaJDGZx9itjIkE76nEv6cFISZ83dbq/vsbg+foxsWE2MrG6pQrDxrf7Opr66/DdtZa/k=
X-Received: by 2002:a05:6902:161b:b0:e57:31f1:972e with SMTP id
 3f1490d57ef6-e5731f1a4b2mr20182789276.29.1737043112819; Thu, 16 Jan 2025
 07:58:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250115014118.4086729-1-xiaolei.wang@windriver.com>
In-Reply-To: <20250115014118.4086729-1-xiaolei.wang@windriver.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 16 Jan 2025 16:57:56 +0100
X-Gm-Features: AbW1kvYIxEEhaAOaS13it3QYjlHMEzrYgUS_q1Twane_cAE7ZLMDO-j-7TvLw_Y
Message-ID: <CAPDyKFrpwPLjk+fzAC+1=z5rWJ0UiSTndbq2hET64KDcwsNzKw@mail.gmail.com>
Subject: Re: [PATCH v3] pmdomain: imx8mp-blk-ctrl: add missing loop break condition
To: Xiaolei Wang <xiaolei.wang@windriver.com>
Cc: shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, 
	festevam@gmail.com, Frank.Li@nxp.com, ping.bai@nxp.com, 
	l.stach@pengutronix.de, marex@denx.de, aford173@gmail.com, 
	linux-pm@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 15 Jan 2025 at 02:41, Xiaolei Wang <xiaolei.wang@windriver.com> wrote:
>
> Currently imx8mp_blk_ctrl_remove() will continue the for loop
> until an out-of-bounds exception occurs.
>
> pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> pc : dev_pm_domain_detach+0x8/0x48
> lr : imx8mp_blk_ctrl_shutdown+0x58/0x90
> sp : ffffffc084f8bbf0
> x29: ffffffc084f8bbf0 x28: ffffff80daf32ac0 x27: 0000000000000000
> x26: ffffffc081658d78 x25: 0000000000000001 x24: ffffffc08201b028
> x23: ffffff80d0db9490 x22: ffffffc082340a78 x21: 00000000000005b0
> x20: ffffff80d19bc180 x19: 000000000000000a x18: ffffffffffffffff
> x17: ffffffc080a39e08 x16: ffffffc080a39c98 x15: 4f435f464f006c72
> x14: 0000000000000004 x13: ffffff80d0172110 x12: 0000000000000000
> x11: ffffff80d0537740 x10: ffffff80d05376c0 x9 : ffffffc0808ed2d8
> x8 : ffffffc084f8bab0 x7 : 0000000000000000 x6 : 0000000000000000
> x5 : ffffff80d19b9420 x4 : fffffffe03466e60 x3 : 0000000080800077
> x2 : 0000000000000000 x1 : 0000000000000001 x0 : 0000000000000000
> Call trace:
>  dev_pm_domain_detach+0x8/0x48
>  platform_shutdown+0x2c/0x48
>  device_shutdown+0x158/0x268
>  kernel_restart_prepare+0x40/0x58
>  kernel_kexec+0x58/0xe8
>  __do_sys_reboot+0x198/0x258
>  __arm64_sys_reboot+0x2c/0x40
>  invoke_syscall+0x5c/0x138
>  el0_svc_common.constprop.0+0x48/0xf0
>  do_el0_svc+0x24/0x38
>  el0_svc+0x38/0xc8
>  el0t_64_sync_handler+0x120/0x130
>  el0t_64_sync+0x190/0x198
> Code: 8128c2d0 ffffffc0 aa1e03e9 d503201f
>
> Fixes: 556f5cf9568a ("soc: imx: add i.MX8MP HSIO blk-ctrl")
> Cc: stable@vger.kernel.org
> Signed-off-by: Xiaolei Wang <xiaolei.wang@windriver.com>
> Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
> Reviewed-by: Fabio Estevam <festevam@gmail.com>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>

Applied for fixes, thanks!

Kind regards
Uffe


> ---
> v1:
>   https://patchwork.kernel.org/project/imx/patch/20250113045609.842243-1-xiaolei.wang@windriver.com/
>
> v2:
>   Update commit subject
>
> v3:
>   cc stable
>
>  drivers/pmdomain/imx/imx8mp-blk-ctrl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pmdomain/imx/imx8mp-blk-ctrl.c b/drivers/pmdomain/imx/imx8mp-blk-ctrl.c
> index e3a0f64c144c..3668fe66b22c 100644
> --- a/drivers/pmdomain/imx/imx8mp-blk-ctrl.c
> +++ b/drivers/pmdomain/imx/imx8mp-blk-ctrl.c
> @@ -770,7 +770,7 @@ static void imx8mp_blk_ctrl_remove(struct platform_device *pdev)
>
>         of_genpd_del_provider(pdev->dev.of_node);
>
> -       for (i = 0; bc->onecell_data.num_domains; i++) {
> +       for (i = 0; i < bc->onecell_data.num_domains; i++) {
>                 struct imx8mp_blk_ctrl_domain *domain = &bc->domains[i];
>
>                 pm_genpd_remove(&domain->genpd);
> --
> 2.25.1
>

