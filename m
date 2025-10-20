Return-Path: <stable+bounces-188267-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 09A20BF3F27
	for <lists+stable@lfdr.de>; Tue, 21 Oct 2025 00:40:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63FC418C577D
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 22:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7C182F3C21;
	Mon, 20 Oct 2025 22:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KtYfQvL3"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4531A2F2909
	for <stable@vger.kernel.org>; Mon, 20 Oct 2025 22:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760999826; cv=none; b=EceH8yoIjPp4pvqLz/HicwRXxa7OT4qmD0brefSrghGR2AVO2aOH9oNQ3WK68YO+Jy/+swYWkc6lAcsU+q129+SPrv1OfJQlk7xlLRWzMohxFKd+wsR0FTwRR6JPR0aqCa11+iRELVazQgM36pnKGxZn4+HFsW7OGEAgiYNqH50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760999826; c=relaxed/simple;
	bh=mbj27Xm81x/GxWhYJzitdrRFZWZq2ZVVz6dFLJ/qS5A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fo5hrfVpKvTLjsFs7NBAAeRt9RDNcYv0ofJUhQTFz3kwthrktul2txOotcaXhLTD26kTfAPK2oYHhnTwbTD30EFN3WsLKCNMc56ExgiXhLpm/YReoRJG7hcWX0tcQfvGUxY6uXXcvnbTNz3vCgEbop2CByQ1Cq+kkzz7LeN8Rho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KtYfQvL3; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2699ef1b4e3so8486255ad.0
        for <stable@vger.kernel.org>; Mon, 20 Oct 2025 15:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760999823; x=1761604623; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3F8kEjxl3GZo7Fb6IKYom5rD8JkawAG6v5GIH7aUxYM=;
        b=KtYfQvL384YbPJmXXliNvs+lzmicO7ztz0ESRmsHueNS39HF2B7LpOoQmefWJgvgvt
         KLecw5TkODSwTHLspQt4cMdnsjOdTBdBXFGmRFer5PUKiwwOGTo0PL5nAiFndx2s42Qx
         bTo6+qf6xwGn8xWET8xInvIi59fb0K2AXEeb7FmZtpzGUWbzAEKzQ8K7EU/ul7LQ+0mZ
         E9jLOh4XLW2thsl1rJQ0yx9Lpa7VjxloGTVGzI8Zb52ECJ4WSKVNTSpfv8juz7W+W5ki
         g3hvtdK1uqo+t24r1YIN7MvLqXSgxng3Q/iVf941kGo6wssLAMU9kchv14U1j11KSQiv
         j8zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760999823; x=1761604623;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3F8kEjxl3GZo7Fb6IKYom5rD8JkawAG6v5GIH7aUxYM=;
        b=reextbPcWahIjJtpXVoWr/W8RdipWLc8RlPB488hHEPVI7Mjd8AqrGIdgGgJZzFd0G
         NgqxyOxyUlzRE3GitSvgN/ya6F8Tf2gsNVG3ZxuyUbH+UeQYYc0LWVHMAy9TiVhKleED
         fuA8CMfVGGp1LMNDrJj7hQNcBK63IdUil1C9rvL11G+ZpbohKNPNa5U5rJrCotqBA9id
         +sD3JgLsJqaoqrM/AfVBAeyx9cymzgPMesmwuuNQSaiAT4ymBHZiF6oWE0IiRc/rWFoO
         EUv/wgu6dlnDZ9zyWQ/uXCsU7yvOTTdn/OOd/TxuJ13QwwaO98jk7xuaohElK1VYeXvj
         wvtw==
X-Forwarded-Encrypted: i=1; AJvYcCVm5Ejs0wgTzLTtmWAyG5JD/3rECUgGbagEAAZt975D2NRLsQ9TGxj5I9COHorTQTq9jk/RaZY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxW99vO0nS+TzYg4nDFZ3PDSzAKhPxJX5TyrMIop9S8rcxBQGxG
	1tWbvI4cQHvJVaw4Aq1glNoc/7xOu/qoMenJoAhIwONfEfbZulAut4k2gXFSp3VpIHzHPrqFNp1
	mwE2D/3zym81tqsi9cNEvAuXsKne+EpcBvQ==
X-Gm-Gg: ASbGncvRQPOLdUux81kNrq1k+/ugfmecNhCWPiH1u18Yu4fYg+jEQt+ntjxzD96URo+
	bxm3C72O6UsLyvO42teJDieGV0MbHEhuk8kF1cmUXHkvF4785feQ7nEU/PGXx8969vxDWfZR0O/
	RvWVrAPblg6ZdsXaHOcryNiaXCUzneLAJsv4Hvt/kTLPTzzDDQ/v28opd5vtlthxu2RDxvfGmXF
	7S57A9sO9SEigwT/4ugrK6YJmLT7XjNZbabN/VRY7t1ecLY4bi8Yguj6G63
X-Google-Smtp-Source: AGHT+IEjJsD4lwTMZU8SCWnFGMQhvt8csQFxanvmaSEnUPrXzmiNzYPorcXAm+yRXLH3p/Nc3Yygx4ZStLTCZHbDUXc=
X-Received: by 2002:a17:903:244f:b0:28e:c6ff:a1d1 with SMTP id
 d9443c01a7336-290ca218a7fmr98217345ad.5.1760999823391; Mon, 20 Oct 2025
 15:37:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251020223434.5977-1-mario.limonciello@amd.com>
In-Reply-To: <20251020223434.5977-1-mario.limonciello@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 20 Oct 2025 18:36:51 -0400
X-Gm-Features: AS18NWBuPr9x-8SexF-JSjyEyHqvA4n3vgla5o3k8taWT3hE0nBOftWwV9eBga8
Message-ID: <CADnq5_P1wajQ_NSwqOrh2XprRJ5eQC=QjQGEAz_t=DCa5efLmg@mail.gmail.com>
Subject: Re: [PATCH] drm/amd: Add missing return for VPE idle handler
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: amd-gfx@lists.freedesktop.org, stable@vger.kernel.org, 
	Sultan Alsawaf <sultan@kerneltoast.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 20, 2025 at 6:35=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> Adjusting the idle handler for DPM0 handling forgot a return statement
> which causes the system to not be able to enter s0i3.
>
> Add the missing return statement.
>
> Cc: stable@vger.kernel.org
> Reported-by: Sultan Alsawaf <sultan@kerneltoast.com>
> Closes: https://lore.kernel.org/amd-gfx/aPawCXBY9eM8oZvG@sultan-box/
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_vpe.c
> index f4932339d79d..aa78c2ee9e21 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
> @@ -356,6 +356,7 @@ static void vpe_idle_work_handler(struct work_struct =
*work)
>                 goto reschedule;
>
>         amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VP=
E, AMD_PG_STATE_GATE);
> +       return;
>
>  reschedule:
>         schedule_delayed_work(&adev->vpe.idle_work, VPE_IDLE_TIMEOUT);
> --
> 2.49.0
>

