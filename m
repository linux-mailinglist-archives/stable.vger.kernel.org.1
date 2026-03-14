Return-Path: <stable+bounces-225436-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QNNLLdyntWll3AAAu9opvQ
	(envelope-from <stable+bounces-225436-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 14 Mar 2026 19:24:28 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id AC69028E6A2
	for <lists+stable@lfdr.de>; Sat, 14 Mar 2026 19:24:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E8FC4300D4CB
	for <lists+stable@lfdr.de>; Sat, 14 Mar 2026 18:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 686713358B8;
	Sat, 14 Mar 2026 18:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="mOrbolmk"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0025C336885
	for <stable@vger.kernel.org>; Sat, 14 Mar 2026 18:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773512665; cv=pass; b=R3nwnnMsxXWqIw4NP12q4zSZnNNTUy6T1+YbTF8BhPXY6kbQd/q/sndHUzKZZzoMh2nkfpd37Ny0/t5ljuzd72p/CVjVLEu24zxWkNXY4WEsy10kFiBS1WXl9qHKaVE7wDU+N5/aDZE58SbctruquPD8bGAYHZNDf0KLzR7+SFg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773512665; c=relaxed/simple;
	bh=RGueu44f3311svWUAZ3Nm2CC7jiHSV/Gihk1oWbAqXA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=claDPePn09NO8HAFZtPAmji1UzT+GBUGwCi4JX7enI8aNbFv+bT9irvt0GkD0k4LmFE2vwkjzA/P9qZfyvXa6B+bYkX/OqLHQ+l3y67Am1teO543XRLBq5DtCk1hf9X9g45jzHIHNJXsSuQcvilPsx3AfBJh/cnIwyEP5pOSFic=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=mOrbolmk; arc=pass smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-1273349c56bso4855879c88.0
        for <stable@vger.kernel.org>; Sat, 14 Mar 2026 11:24:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773512663; cv=none;
        d=google.com; s=arc-20240605;
        b=Rz5gCFBXOkwawQX0lfGR0VbG3KNN5n6hXraEjrFQrqe6JW1lKVee8ifCDNy6W3uE4b
         GyPUXmzkiPsKN1b4XPlsvgHjdsKmYR2WdFK4KXT4R8s/5Ft/1kvuwRSw4xZBWWU9mlC7
         DBlztPs4QRV///Z6354sXANXP79zUjma5sCiTBbh8JyMOLAHej3eucaLmzyHLYCaL8f2
         qi+J9C/7pHBm4kviY8mVFW3Zv8elje/3ZlguFanFrJkgD8D0ldqDHd05g9oUuKa68FcW
         ichbme8guMIiTuvt243m4p6It8w1G5U3KnFQHu5Lsksa0ehAd0ZmWchzajSiLcYYoDss
         DRww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fvNl2IYSFSlpzaWdwoGLoNSu2ighwO6e4fTkkZTILus=;
        fh=VWVVIwx01ERQfDwFqywfc84c4hXCuzXO6/HbOjjrZKE=;
        b=AOmaHmdKevLDriGxxr5yZx96Nc6QHWoZfBguqTnV9LrMOw/xMVnaOTPj5ScKXWetu+
         uHjaSxPhIXBAw4wmQWywxG4B2vpyXT5gySBTgR2X+h1evfWJ94EsBeIsJAG7YqGLDgTN
         C2m0WnWYPnGGib+QsFEavjxQdxWR/dArv3oGbPTa+oyxh+uY/qoyAvILtc7ll8XfIegD
         VkKKnVjGEICcC9jnNl6mZ++sFXpPhb6dI/oLoqX/LpqE7ZoVPSSVoM3pnz1bIi4vJWs7
         eisk7f4VrK8grdM7pyJJP24x1zQ0bxKU0QW26dOn+RPcMvK156VegRo8TB6r1mB4yjfQ
         1B2A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1773512663; x=1774117463; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fvNl2IYSFSlpzaWdwoGLoNSu2ighwO6e4fTkkZTILus=;
        b=mOrbolmkUFZF9XJfpiRHG5VALT7rG3kC6kpOLWuPsoSc7uF1V4+g/gYnXjLcnp1ctx
         Jhr9GvsVLbYrEDaaAl3/1wui7ty5EqAklw4p2dtFeNmWlAHDV2C6ZBvUvB0B8XX0RsdP
         ldzyHSvVp5g6qvfrWFtLgSpEFEKHnuYKI/8FfpBcxH+s/1IMt84ZRxhqtliOi/C2A3jy
         cIQUdWmL92oA5hN5eakjOtNbgTEelR3Np86TnKGEubymaEKf1hrfK1nx+1WuCksGqLG5
         xf109DyI7ewYr3Kp/wlRrmLOnKp9DP79IXi+OK/niRKHUPLcN207tN6I5I2ulJjdWQWr
         ggcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773512663; x=1774117463;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fvNl2IYSFSlpzaWdwoGLoNSu2ighwO6e4fTkkZTILus=;
        b=sTlYJ6iu0G5ACul3+OTlKV3iRmW9TYTTJyjTON4c/qv9Coosl8TyHEtIlZl8nk46dX
         twktLlIR/YsZ0HYEeNbyJFk7i4aXqQHND7dToXnStD2lNE1DJXoW+6YmfQuI5GmVoUgs
         m7/s2eJCqEaZBK7wCaQYqstwzFGCHXlEswWDs33b6dlTp6qwnuwuyvmUCWBynGWbPPtU
         FB/DRickJ6NtbGdZ6ZxUrIf14S9deHgTEz+YNi53a+SvLGfVPFWoRQZfMjltzJy+cNxu
         xjd6U1YoSCmlxjMs/75fHks/kyaOd1rLsNK1VXXEwOJZpggFz0GT5pV6vT0YXdafit1m
         VvhQ==
X-Forwarded-Encrypted: i=1; AJvYcCW8LFWI9kt9OD4Mm+T/ge74O01nblSewBCiBp/9f3mGYEcOnCR8joPq+xTvdeDDAr+b/HRa7oA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqOjTqxUvaqApi4yc9VKoxtz6+4/k38fRJa5a8odagY3tzfF64
	dWUz5/9mi4U3YE/EyapWrhGmgDQkvel7TUI1bYQuAZ3QLEJOqE/fBrHhhq1I8Fwp0uBDEt6PXV5
	KZ9Hn7yBmFeLW8u3F+puVfWViL5qaTMm8ybthFHZEWg==
X-Gm-Gg: ATEYQzzhYLknQCY+iaZHrI67+C0IyBTjftwBXUnuRAtv2Rc33E2MEEVA9BCf22/NNik
	z6vX8xuKSluZBsonF0lc7vPx4fvfI2unbUd+uepMR61SR7DbwzIou9lJXgCnyKpzGByZxkX6qpJ
	UBtzHhpxq1hPEjyUVHbIu7s6rRwbQ8oWAzaL5jJjaHLriFx589PmzhmTw7KNO/nD1OzTK9hSaGH
	GcNBRfOT9yLYTnopJbGI5Krj4tdToKt3AoSkN94Xj/mlOXMnNhD6NhfpBNIOa+uCCI/TMajv+CP
	YmxWIADwjlGRdr45FUCgAA90Gp9gxUC6aDfL4NMEnw==
X-Received: by 2002:a05:7022:4186:b0:128:cea1:7e3b with SMTP id
 a92af1059eb24-128f3dd13a3mr2716046c88.23.1773512662881; Sat, 14 Mar 2026
 11:24:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ad8652c5e9f8aeee05e2103f4987589cdd4a3fd0.1772659768.git.josef@toxicpanda.com>
 <20260312134025.GJ1469476@ziepe.ca>
In-Reply-To: <20260312134025.GJ1469476@ziepe.ca>
From: Josef Bacik <josef@toxicpanda.com>
Date: Sat, 14 Mar 2026 14:24:11 -0400
X-Gm-Features: AaiRm52ccBWuyu-tZMzjnnT5VJAWfzUfSpPntwRU0mPlzJvdhZLstFUq8yI2JNo
Message-ID: <CAEzrpqeO68eg1dFr2fm8FNXSodJWSxT_9Gk0EHSK=hzRAQgJHQ@mail.gmail.com>
Subject: Re: [PATCH] amd/iommu: do not split domain flushes when flushing the
 entire range
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: joro@8bytes.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[toxicpanda.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[toxicpanda.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-225436-lists,stable=lfdr.de];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[josef@toxicpanda.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[toxicpanda.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid,toxicpanda.com:dkim]
X-Rspamd-Queue-Id: AC69028E6A2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 12, 2026 at 9:40=E2=80=AFAM Jason Gunthorpe <jgg@ziepe.ca> wrot=
e:
>
> On Wed, Mar 04, 2026 at 04:30:03PM -0500, Josef Bacik wrote:
> > We are hitting the following soft lockup in production on v6.6 and
> > v6.12, but the bug exists in all versions
> >
> > watchdog: BUG: soft lockup - CPU#24 stuck for 31s! [tokio-runtime-w:127=
4919]
> > CPU: 24 PID: 1274919 Comm: tokio-runtime-w Not tainted 6.6.105+ #1
> > Hardware name: Google Google Compute Engine/Google Comput Engine, BIOS =
Google 10/25/2025
> > RIP: 0010:__raw_spin_unlock_irqrestore+0x21/0x30
> > Call Trace:
> >  <TASK>
> >  amd_iommu_attach_device+0x69/0x450
> >  __iommu_device_set_domain+0x7b/0x190
> >  __iommu_group_set_core_domain+0x61/0xd0
> >  iommu_detatch_group+0x27/0x40
> >  vfio_iommu_type1_detach_group+0x157/0x780 [vfio_iommu_type1]
> >  vfio_group_detach_container+0x59/0x160 [vfio]
> >  vfio_group_fops_release+0x4d/0x90 [vfio]
> >  __fput+0x95/0x2a0
> >  task_work_run+0x93/0xc0
> >  do_exit+0x321/0x950
> >  do_group_exit+0x7f/0xa0
> >  get_signal_0x77d/0x780
> >  </TASK>
> >
> > This occurs because we're a VM and we're splitting up the size
> > CMD_INV_IOMMU_ALL_PAGES_ADDRESS we get from
> > amd_iommu_domain_flush_tlb_pde() into a bunch of smaller flushes.
>
> This function doesn't exist in the upstream kernel anymore, and the
> new code doesn't generate CMD_INV_IOMMU_ALL_PAGES_ADDRESS flushes at
> all, AFAIK.

This was based on linus/master as of March 4th, and we get here via
amd_iommu_flush_tlb_all, which definitely still exists, so what
specifically are you talking about? Thanks,

Josef

