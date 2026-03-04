Return-Path: <stable+bounces-223034-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WLTiH/QWqGlTnwAAu9opvQ
	(envelope-from <stable+bounces-223034-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 12:26:44 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 024321FEF75
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 12:26:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 346AD30A052D
	for <lists+stable@lfdr.de>; Wed,  4 Mar 2026 11:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 625D23A875E;
	Wed,  4 Mar 2026 11:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="V6s0UtRu"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD5953A8748
	for <stable@vger.kernel.org>; Wed,  4 Mar 2026 11:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772623525; cv=pass; b=nJNzG/H/4PoPKcbNObZe6AX/HZtUPIU9PxEokqdB16c+U2FEVtjTiOOTWf3lmiIXIM42cn7GiFZmoQd835HR5nwjQuj4j7Yuhn55JGfDQ62pZzGWMtVBQB4h68hYKir2s9A0mlnPq2eU4DEl0pvSZ5NU43Odg4S/rKQUJAtLYV0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772623525; c=relaxed/simple;
	bh=MGVNt7Zv077AR1/6k+SSxZzDXAKG2uIqldi8aMY2xso=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZD/xelVpneSCoiQQKQyX7XHdDfPLiTFbx1oUNToXOe/zqaDSzImV+pqshonzBbV9lIlgvcO62j5oGiRoTnOYK2VqyOveeTpPvxnxBCmBPvAbSPfZSbW0glKDqbKInAPOtF+QcpKSrdlpI0ABpnGpugRSGFV5bhhu6dnaBPc2SLA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=V6s0UtRu; arc=pass smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-386fb2c31e2so122688571fa.1
        for <stable@vger.kernel.org>; Wed, 04 Mar 2026 03:25:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772623522; cv=none;
        d=google.com; s=arc-20240605;
        b=XGxjKSFvK0tLTg8vLb3790/Ief2Y/7J2VrW3aQ+we8hjraUQ+z8tdCNDhyo3Pr/ScX
         n5I0bYWgJMUc+OWsANgUtM2gQ93HAZ9ZhPW5SULeq94BPligiAqLrvQyzwCL2pKBuM74
         XhFap+ysOipjnuDTxSkPlKmvgUcaSOe9fm++JYSi1TSV6Q1ahsi1FjeJY5HULwnKsFmP
         i85edywtEc+oiwdzR1iil6AdvUEWj+oT0h5uEEfG7nMuM4YPXvm3MXRXw6yL38vCm4Jv
         c+hofxdX1WCr4dA0KZrBvkLwJskQf96fyEzIWNdOTMJ3O/tayVOBVm6x0Nho+tkklxjx
         0HZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=jqB5j+E4DSf4EbBKzvqlflmatvTKbzzjeiwDCgjc31o=;
        fh=rvVvcP6qKDwPrzNIppm3/nHDNe3924Nj68Ww0yIgjtk=;
        b=i4w+56cwaDA4Pv8wPgI4TDE85KRInTbiVpwfqSn5rgo0m235xw19gnlaeVjmPr9bLp
         Zk69/mgvQ4havJmGG7efL6eTBcZE5W0JXVh27cYcHUGJtK5ID7w+1J73tXl/zkbvyZGk
         /gWvhZGlWP3T+YAzarsuun9L3eRiBxKO3Vrd2YrPSspPQkwCwypNHhY9ruonvUR/QIeu
         g6UYI/z0+aMzTskRn5M36mrLUl34fKM+wCY4oU9rLC0GkLJLShpIZqAeg0j+OsyW/+3g
         S68MrzOLW+i038gWp+61+KkUT7WdfjUFnlpyY4EDmszMCeYhIldAe4AUd4IveqMZPNYA
         7JqA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1772623522; x=1773228322; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jqB5j+E4DSf4EbBKzvqlflmatvTKbzzjeiwDCgjc31o=;
        b=V6s0UtRujNl/XjhEZJmovto9kDVGiJTPPR1b/xeweJ/Bc1TDzQFeO0GopBaX8i56cg
         ErIXI0hKu1bobTLQc2tD6gtINqAfn5cugOzZDZgM8VbgeeuspX4U6sP3XDAOEIPNxNQx
         9DR3yejUHZD42RJ2sdXMO2DzWhSGEcC/vfqgMSqAbMCQudKmCLehN8cWSud+/2hXKKR+
         uMloTMu+bEjaxSVM11mwwBZQcysRhK73OOUXejLyuUfj3xfJcEowLnu1JtkKebPe2Rx1
         kuQIHCb5oCbG0CS+IZYQxguV/gAPMzjfx2JetwnRePWqVXx66tplpmzSYM9XoO6plhlb
         xZgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772623522; x=1773228322;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jqB5j+E4DSf4EbBKzvqlflmatvTKbzzjeiwDCgjc31o=;
        b=UYUy4MPNy82ADUzjpwnu0RahPgYPJvNfFSfWyvUzbPQkO0HVqHWqPr3AfaiJJn/t2v
         vuRUXnhP8SDUeHM4qce9BTAgvzAkZNti00Tvk5dDZO3TF9DARXoxTgba8W94l6H/k4mQ
         kbPPy9Kp2DhLU1oQoK+2WLC/cADFYx3EU6XEGthL/vlrATR/wsqiWYVNVg7VhKa+U2fP
         zxNOJ54LJqgsjhjwKq/l80Mb9s6ikqdugmdRF/I9Q1pRZpWiM9F0ry8/c8zkQFTb53KG
         KzWDfDRvtnO1lxlqQOoUh+wCR/I+xfpwGRZv24/xzknkG/4mGX62ikrKWdenxhyeiBY4
         P7rA==
X-Forwarded-Encrypted: i=1; AJvYcCVLdHBelMj2cK9driCvDxCyyW9Y7FMmJlRZbIpEOHNfH5Gl6IRapDU9Zxh9MDKIx+a9Tj4ec3I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrIgE44Cjn9md8Q556aRrVPufviW8uEa/svBzk2ItzPlhBD7rY
	IlDh6C1Pli61h8jY8ZJuguHJ5DdPjcS3OxChihsIgchzVSlTZJzZPqHXsO6xWqfr2t/pzXXUZ0/
	t4IgJr9D8shZ305CoTU0hOGAfYRWLj5KotjZcacE0JA==
X-Gm-Gg: ATEYQzx7octub6IJHDdwQrQ+8LIdf6x0euIBjKIwSEcoEgDP6HgJzjyydlaeXloDSZ6
	th/dGeTlE98GLTgQWLKj94eSSQfoD+D8hpzYUhZUEbqR5lhsz/uJOdT9ZQJgsNZIpstGyALONJz
	T172D46VsgLZibTSh8dzpYLStUwf+QYh3OZXKUyhFJtXly1KvgfoNReYUHrS7WAlcW3F2Td8NYX
	4AUZIO5ZtI3mWo1iMwm0Mvx+cXptWRx4KquJ8JrcnXwQ3V2I9t+TKtM82lku2wuObb1WLacSSNL
	ye3M0LNr
X-Received: by 2002:a05:651c:1541:b0:382:fccd:f999 with SMTP id
 38308e7fff4ca-38a2c7bc7c6mr16035541fa.25.1772623521873; Wed, 04 Mar 2026
 03:25:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1771988101-49877-1-git-send-email-shawn.lin@rock-chips.com>
In-Reply-To: <1771988101-49877-1-git-send-email-shawn.lin@rock-chips.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 4 Mar 2026 12:24:45 +0100
X-Gm-Features: AaiRm50bUQu-RI-pXbdDTdDQj139yGzcF2dqA4SgUmdK1yk7k6TutZG0mI55cco
Message-ID: <CAPDyKFrG1GFPPa=H0pnvX-+SpwD30vad8YYsBp7tZd5H_huxUA@mail.gmail.com>
Subject: Re: [PATCH v3] pmdomain: rockchip: Fix PD_VCODEC for RK3588
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Finley Xiao <finley.xiao@rock-chips.com>, Frank Zhang <rmxpzlb@gmail.com>, 
	linux-pm@vger.kernel.org, Sebastian Reichel <sebastian.reichel@collabora.com>, 
	Detlev Casanova <detlev.casanova@collabora.com>, Heiko Stuebner <heiko@sntech.de>, 
	linux-rockchip@lists.infradead.org, stable@vger.kernel.org, 
	Chaoyi Chen <chaoyi.chen@rock-chips.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 024321FEF75
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[rock-chips.com,gmail.com,vger.kernel.org,collabora.com,sntech.de,lists.infradead.org];
	TAGGED_FROM(0.00)[bounces-223034-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linaro.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ulf.hansson@linaro.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid,rock-chips.com:email,linaro.org:dkim]
X-Rspamd-Action: no action

On Wed, 25 Feb 2026 at 03:55, Shawn Lin <shawn.lin@rock-chips.com> wrote:
>
> From the RK3588 TRM Table 7-1 RK3588 Voltage Domain and Power Domain Summary,
> PD_RKVDEC0/1 and PD_VENC0/1 rely on VD_VCODEC which require extra voltages to
> be applied, otherwise it breaks RK3588-evb1-v10 board after vdec support landed[1].
> The panic looks like below:
>
>   rockchip-pm-domain fd8d8000.power-management:power-controller: failed to set domain 'rkvdec0' on, val=0
>   rockchip-pm-domain fd8d8000.power-management:power-controller: failed to set domain 'rkvdec1' on, val=0
>   ...
>   Hardware name: Rockchip RK3588S EVB1 V10 Board (DT)
>   Workqueue: pm genpd_power_off_work_fn
>   Call trace:
>   show_stack+0x18/0x24 (C)
>   dump_stack_lvl+0x40/0x84
>   dump_stack+0x18/0x24
>   vpanic+0x1ec/0x4fc
>   vpanic+0x0/0x4fc
>   check_panic_on_warn+0x0/0x94
>   arm64_serror_panic+0x6c/0x78
>   do_serror+0xc4/0xcc
>   el1h_64_error_handler+0x3c/0x5c
>   el1h_64_error+0x6c/0x70
>   regmap_mmio_read32le+0x18/0x24 (P)
>   regmap_bus_reg_read+0xfc/0x130
>   regmap_read+0x188/0x1ac
>   regmap_read+0x54/0x78
>   rockchip_pd_power+0xcc/0x5f0
>   rockchip_pd_power_off+0x1c/0x4c
>   genpd_power_off+0x84/0x120
>   genpd_power_off+0x1b4/0x260
>   genpd_power_off_work_fn+0x38/0x58
>   process_scheduled_works+0x194/0x2c4
>   worker_thread+0x2ac/0x3d8
>   kthread+0x104/0x124
>   ret_from_fork+0x10/0x20
>   SMP: stopping secondary CPUs
>   Kernel Offset: disabled
>   CPU features: 0x3000000,000e0005,40230521,0400720b
>   Memory Limit: none
>   ---[ end Kernel panic - not syncing: Asynchronous SError Interrupt ]---
>
> Chaoyi pointed out the PD_VCODEC is the parent of PD_RKVDEC0/1 and PD_VENC0/1, so checking
> the PD_VCODEC is enough.
>
> [1] https://lore.kernel.org/linux-rockchip/20251020212009.8852-2-detlev.casanova@collabora.com/
> Fixes: db6df2e3fc16 ("pmdomain: rockchip: add regulator support")
> Cc: stable@vger.kernel.org
> Suggested-by: Chaoyi Chen <chaoyi.chen@rock-chips.com>
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

Applied for fixes, thanks!

Kind regards
Uffe


>
> ---
>
> Changes in v3:
> - drop tags
> - rework it for just changing PD_VCODEC(chaoyi)
>
> Changes in v2:
> - collect tags
> - correct TRM section(Sebastian)
>
>  drivers/pmdomain/rockchip/pm-domains.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pmdomain/rockchip/pm-domains.c b/drivers/pmdomain/rockchip/pm-domains.c
> index 997e93c..44d3484 100644
> --- a/drivers/pmdomain/rockchip/pm-domains.c
> +++ b/drivers/pmdomain/rockchip/pm-domains.c
> @@ -1311,7 +1311,7 @@ static const struct rockchip_domain_info rk3576_pm_domains[] = {
>  static const struct rockchip_domain_info rk3588_pm_domains[] = {
>         [RK3588_PD_GPU]         = DOMAIN_RK3588("gpu",     0x0, BIT(0),  0,       0x0, 0,       BIT(1),  0x0, BIT(0),  BIT(0),  false, true),
>         [RK3588_PD_NPU]         = DOMAIN_RK3588("npu",     0x0, BIT(1),  BIT(1),  0x0, 0,       0,       0x0, 0,       0,       false, true),
> -       [RK3588_PD_VCODEC]      = DOMAIN_RK3588("vcodec",  0x0, BIT(2),  BIT(2),  0x0, 0,       0,       0x0, 0,       0,       false, false),
> +       [RK3588_PD_VCODEC]      = DOMAIN_RK3588("vcodec",  0x0, BIT(2),  BIT(2),  0x0, 0,       0,       0x0, 0,       0,       false, true),
>         [RK3588_PD_NPUTOP]      = DOMAIN_RK3588("nputop",  0x0, BIT(3),  0,       0x0, BIT(11), BIT(2),  0x0, BIT(1),  BIT(1),  false, false),
>         [RK3588_PD_NPU1]        = DOMAIN_RK3588("npu1",    0x0, BIT(4),  0,       0x0, BIT(12), BIT(3),  0x0, BIT(2),  BIT(2),  false, false),
>         [RK3588_PD_NPU2]        = DOMAIN_RK3588("npu2",    0x0, BIT(5),  0,       0x0, BIT(13), BIT(4),  0x0, BIT(3),  BIT(3),  false, false),
> --
> 2.7.4
>

