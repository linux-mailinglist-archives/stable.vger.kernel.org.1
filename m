Return-Path: <stable+bounces-115010-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BDC70A31FF4
	for <lists+stable@lfdr.de>; Wed, 12 Feb 2025 08:27:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B8FD188924A
	for <lists+stable@lfdr.de>; Wed, 12 Feb 2025 07:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30F342045A2;
	Wed, 12 Feb 2025 07:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=easyb-ch.20230601.gappssmtp.com header.i=@easyb-ch.20230601.gappssmtp.com header.b="P5kN9xDp"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57CD32040A7
	for <stable@vger.kernel.org>; Wed, 12 Feb 2025 07:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739345272; cv=none; b=ZnMLa8G5m5vYrd0vBhjoO0h75iu1m1rTS1rhp+UB17GwxfnmjJQXHSgt0WnMv0PJes3OWPESqOtF3/3iMysPfPcwQXpKMKa+ivi8fsHHJLTmDQ7od+ouCDzUCFWe4/KgvT3UQXaWcNhorlvN1F5pik7iq6rKy2ee7hB13xsFiH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739345272; c=relaxed/simple;
	bh=X0SMSmIWGyTCxNlqPUgOBXqGts6xSo3Ri9D6KFMif6U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pZKOIUbCsZTBAUeXoU/ZMzNPCxUgIXwlC1/entJ4ifHQwos6ZmuaedtfCTKvh7hCIxreZDUPSn2cdirzTe7RS3XUwnxHH31kDc9hovsUkX22einHDtM74Q0g1dcDyTXnkK2meBZC+/gAB5l5QarEjJa0FfPtcAy3SGt5200ErtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=easyb.ch; spf=none smtp.mailfrom=easyb.ch; dkim=pass (2048-bit key) header.d=easyb-ch.20230601.gappssmtp.com header.i=@easyb-ch.20230601.gappssmtp.com header.b=P5kN9xDp; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=easyb.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=easyb.ch
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-545074b88aaso3779817e87.3
        for <stable@vger.kernel.org>; Tue, 11 Feb 2025 23:27:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=easyb-ch.20230601.gappssmtp.com; s=20230601; t=1739345268; x=1739950068; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NkpApLmuMSuoEXBLQRnWWTTZmdzVTlEP/UbOXT6BIvI=;
        b=P5kN9xDpAPBYnVsqi0HbJdYhP1qaDDNrTzkA/mFqH0Xv4A8rS2bWLG7dfLJLEPacbo
         O+tt0u8y2dvRLiQPtFpurnroOzJ9aCSL4+SG+KkNQHLgCX0FBWX5nOF1w2XiVtp6JWtX
         HIBxUNtlyRWC5N4i4bhOkVKJ0+oDDXDOxCmPUotjmEZQkoKNnwL8NwXLuj1zC7d3xaBo
         TGb1HaFNT1mXJP1/PZhadMyVroPqESvFc+Z01Xsb9NM63O3vWlq/K/EGj/z5x5Gg/8yk
         R+Qe+P9TIBPEoXXZmTxcTbbOhD8cMPf/k8Xcl6/U40r63zO97VQaAf47FmfJzgtAm5zM
         BHKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739345268; x=1739950068;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NkpApLmuMSuoEXBLQRnWWTTZmdzVTlEP/UbOXT6BIvI=;
        b=gqbbpaWST28FVjxT0vNCaSU155WrdkJBbrgXSd/knashbrZ98WvwQCe6NFPQIBJjSM
         MUhSN1i0qHThBMXx8TQ2IFqv8ZzD9eJWeliq4+ef+iMHdrq9pjJc0x0FEegLZmUzCdUl
         8x5KRTLpdkpwuscIEGciWwnUXR7GlBqVF1NUL9irLpGWJqdehko4Dn9hSnoLjlS3X7/W
         2CQ2gs/QHatPqaMeqw/cgQAlTTNJUBVxq0k1TCUOBqaCqnh2yVz+9H3dyYxTprwiYx3O
         rwsbphjb4TvvdOHkX7Z6QKJ5GPBasGBxleTKeLI28PcJPaRUeh/HIxwopXg3dg2ZEmo/
         CZhA==
X-Forwarded-Encrypted: i=1; AJvYcCUV5T9k73a/NVBIXam8TR1h6v0mzSNQiWBfL8FuF/pCnY70d3T6QLf78MOXcMKkfLHixN3fHOY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0Ttf0uQSuYhyzM4Mn2uNXuAa5LLHUl3wvX5rvfnbB93Ae1Smm
	jeii+jZ1msjoBFZcXJ4pxvkgD5k985YcwzE8OcXOPhn91GArhEZAuJCxtFVb06DvAIHQPX+8S24
	rwsjXZ7jbnM+CxgtlstUYJhObgB27VbQNllUaag==
X-Gm-Gg: ASbGncuaFmPnUCs1QCgpq9pgy0zmbOSYVV6kMEIGm4IFU2zbn0NQ5ZAidDkY4+R669U
	tBEEqSLMXha2hXIk15KL3g1807c4Sk2o9JBdo9AyMKCwAURSoHN+BH8U/ULDaO01eOOmazuo9IG
	hom908auWRVDM1Ju/MkgNFKpjp0Jk=
X-Google-Smtp-Source: AGHT+IHBuOV1u76P+sliG1ZLyRYbTKiqx9yn/XwZRRCZd7FDQnrrgDlhR9/jciNljT0bWlE6m70c+Cc75Sta0/soFRE=
X-Received: by 2002:a05:6512:3a8a:b0:545:c7d:178d with SMTP id
 2adb3069b0e04-5451810906emr456277e87.12.1739345267946; Tue, 11 Feb 2025
 23:27:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <be323425-2465-423a-a6f4-affbaa1efe09@bytedance.com> <20250212064002.55598-1-zhengqi.arch@bytedance.com>
In-Reply-To: <20250212064002.55598-1-zhengqi.arch@bytedance.com>
From: Ezra Buehler <ezra@easyb.ch>
Date: Wed, 12 Feb 2025 08:27:11 +0100
X-Gm-Features: AWEUYZmZw_dR7xZ0V1G7gpsQgXY4quV-0zHZqZHrTMP56-HGWMQZHyZg-iRxnUM
Message-ID: <CAM1KZSnWFivV-7nc55MBAEtdP1LXfW4eLKa-94HPZaTP0AOPrg@mail.gmail.com>
Subject: Re: [PATCH] arm: pgtable: fix NULL pointer dereference issue
To: Qi Zheng <zhengqi.arch@bytedance.com>
Cc: linux@armlinux.org.uk, david@redhat.com, hughd@google.com, 
	ryan.roberts@arm.com, akpm@linux-foundation.org, muchun.song@linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Qi,

Thanks for the fix. I will test it as well as I can.

On Wed, Feb 12, 2025 at 7:41=E2=80=AFAM Qi Zheng <zhengqi.arch@bytedance.co=
m> wrote:
>
> When update_mmu_cache_range() is called by update_mmu_cache(), the vmf
> parameter is NULL, which will cause a NULL pointer dereference issue in
> adjust_pte():
>
> Unable to handle kernel NULL pointer dereference at virtual address 00000=
030 when read
> Hardware name: Atmel AT91SAM9
> PC is at update_mmu_cache_range+0x1e0/0x278
> LR is at pte_offset_map_rw_nolock+0x18/0x2c
> Call trace:
>  update_mmu_cache_range from remove_migration_pte+0x29c/0x2ec
>  remove_migration_pte from rmap_walk_file+0xcc/0x130
>  rmap_walk_file from remove_migration_ptes+0x90/0xa4
>  remove_migration_ptes from migrate_pages_batch+0x6d4/0x858
>  migrate_pages_batch from migrate_pages+0x188/0x488
>  migrate_pages from compact_zone+0x56c/0x954
>  compact_zone from compact_node+0x90/0xf0
>  compact_node from kcompactd+0x1d4/0x204
>  kcompactd from kthread+0x120/0x12c
>  kthread from ret_from_fork+0x14/0x38
> Exception stack(0xc0d8bfb0 to 0xc0d8bff8)
>
> To fix it, do not rely on whether 'ptl' is equal to decide whether to hol=
d
> the pte lock, but decide it by whether CONFIG_SPLIT_PTE_PTLOCKS is
> enabled. In addition, if two vmas map to the same PTE page, there is no
> need to hold the pte lock again, otherwise a deadlock will occur. Just ad=
d
> the need_lock parameter to let adjust_pte() know this information.
>
> Reported-by: Ezra Buehler <ezra@easyb.ch>

Perhaps a detail but, maybe better use "Ezra Buehler
<ezra.buehler@husqvarnagroup.com>" here.

Cheers,
Ezra.

