Return-Path: <stable+bounces-20291-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1924B8568A3
	for <lists+stable@lfdr.de>; Thu, 15 Feb 2024 17:00:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1A3A1F2316D
	for <lists+stable@lfdr.de>; Thu, 15 Feb 2024 16:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB7FD13343A;
	Thu, 15 Feb 2024 16:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gb4NZeTO"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 454B27CF03
	for <stable@vger.kernel.org>; Thu, 15 Feb 2024 16:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708012813; cv=none; b=p8fHsBnZyIYEUyi6hw39YSkQvESQyiomIScFXNn6Hdw15hqexhOoebjBDWH2B3Oa54eRORjLokBxYD7GCg06ZnhAnx5AnsDETNeBAwTFvp9Hq/rIg0AYX83bRUBDmqQqd98GTBpXgzidOuGEOSoOfKkXlOLHjta1AsnD2SeJuIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708012813; c=relaxed/simple;
	bh=efI7EHUWyJpw9Gi9WGbXXvUfsFilS5UqiJK0pzRwJgA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=Qg2o2XG2/0HTJwop9k0Qt6gudye41QU90sQ8cPJy/W6Sd9HlxGVi0MFKY4fe3lbu+Nt29Fnf6EtOwrSdZS0IeZS1q/tL/seYhIfYX8XpG/GagpJy9c1lx39ZWbll5GtPm5s8tox9pF1pm2+PNmWeyLarQ+kgLKqskBx6klFUhJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gb4NZeTO; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-dcbd1d4904dso1047185276.3
        for <stable@vger.kernel.org>; Thu, 15 Feb 2024 08:00:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708012811; x=1708617611; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WBfIQ5c2kGyikGze5eL8WFjT+JDTVayrtF6yiNuBoDE=;
        b=Gb4NZeTOEldZIbaSogfX3GfuYGs6qE+eR9znELWHzvjUItq1QNCa1RMh3ULHVuI+Pl
         4MsinaUE21s1n9ZuBvomw8Ok1qS3nWQH/I6/dKrbvRVNghY+EU4qCwEFudyVUZUZLG1o
         EfInVq8GFWzQeyq76xz/HJEZrFeSWgSyEQb9ooGELn/G8VxYt6bxze5iFAgFXx8BTsrq
         jYX4XZYVgUaOwcu9wOesI4VeAlbrFJR4kzIuqRcQPSv17N2UMuuhaSViojBJGEQBj7mr
         8PvPEjSiDaRNQ0DEKd9y4EmNSytdbYeNWMybuxbeGPRHoJt0PLslkqSvKbhBhVfgWuMF
         Q9nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708012811; x=1708617611;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WBfIQ5c2kGyikGze5eL8WFjT+JDTVayrtF6yiNuBoDE=;
        b=IIK4dSvnaf6mCQOsgi5KfychbPt3Ww3xWiKcz/8zXNkkmhp8ou6Zzpaq0yMofpOC8d
         1AhgJJWJU6qTcGGDxtT22tNbYS1eHEatG0JZiGjN9dpJw4J7XcXLje+pVfd0RNlrpH8q
         n0ByZcz06ZGa6uxkYTCQXWggPGr7mB69gL9VhdFI9X3z67mXK4xBXA1Vz8n1zdT88zXT
         FG2w3BGt2eMjxsFqlMNLxx9wwGbZhLMJ/gKFGpR/ciTcDPjEMPc/ra2Nf9OW/0qcI6UY
         GBDnDRLLjPDszMLTQXsc9BQFVIwRSWcVFtqtUwTq6UqswGE/z/zn/mu8QcX+b50YHQPA
         j6/A==
X-Gm-Message-State: AOJu0Yy+y/CS6yNph7dfmR4bwVlZWD38ToB2im4yHC8ejnbIb5mx89hF
	TfyHipqHKmiUJte3JO2k0zxbOU/WK8d7NmzIXKIWIfnK3Wv6zOr1fxiPZS/tl62BTp0L680pjod
	FjBwjHGqa1P4yLqspAM143Qg/H/2zKaD0
X-Google-Smtp-Source: AGHT+IEC7Yr2xkVFfFo2EkfVLZ3HtG6ag/dgxB5SUrBFGcbmGbfPaqyH5GtGlX64LalJLOiXH4r2CqPQ56qLoQpRQvo=
X-Received: by 2002:a25:b904:0:b0:dc7:8c3a:4e42 with SMTP id
 x4-20020a25b904000000b00dc78c3a4e42mr1780417ybj.30.1708012810912; Thu, 15 Feb
 2024 08:00:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Michael Zimmermann <sigmaepsilon92@gmail.com>
Date: Thu, 15 Feb 2024 16:59:59 +0100
Message-ID: <CAN9vWDLbM3tiBQRz0rNxfrLP4bMrEOiTNLRd4avvYKiEcpUr4g@mail.gmail.com>
Subject: 7840U amdgpu MMVM_L2_PROTECTION_FAULT_STATUS
To: stable@vger.kernel.org
Cc: regressions@lists.linux.dev, Alex Deucher <alexander.deucher@amd.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	"Pan, Xinhui" <Xinhui.Pan@amd.com>
Content-Type: text/plain; charset="UTF-8"

I have a Framework 13 with a 7840U and started having massive GPU
driver issues a few weeks ago (including system freezes).
Unfortunately the information of when exactly this started to happen
is gone, but It should be somewhere in between 6.6.0 and 6.7.4.
I got many different and random dmesg-errors and system behaviors, but
I currently can only reproduce one, so let's focus on that for now.

First some basic info:
I'm on Arch Linux using the `linux` kernel package.(currently at 6.7.4).
I have an external monitor connected via a thinkpad thunderbolt 4 dock.
I am using amdgpu.sg_display=0 and VRAM sharing is configured to
UMA_GAME_OPTIMIZED in the firmware settings.

If I start playing a youtube video in firefox with hardware
acceleration enabled, it stutters until it stops playing after a few
seconds. I can see this in the kernel log. I see this multiple times
for many different addresses.
[ 5641.070540] amdgpu 0000:c1:00.0: amdgpu: [mmhub] page fault
(src_id:0 ring:40 vmid:1 pasid:32786, for process RDD Process pid 3680
thread firefox-bi:cs0 pid 3852)
[ 5641.070549] amdgpu 0000:c1:00.0: amdgpu:   in page starting at
address 0x0000000000020000 from client 18
[ 5641.070553] amdgpu 0000:c1:00.0: amdgpu:
MMVM_L2_PROTECTION_FAULT_STATUS:0x00143A51
[ 5641.070556] amdgpu 0000:c1:00.0: amdgpu:      Faulty UTCL2 client
ID: unknown (0x1d)
[ 5641.070559] amdgpu 0000:c1:00.0: amdgpu:      MORE_FAULTS: 0x1
[ 5641.070561] amdgpu 0000:c1:00.0: amdgpu:      WALKER_ERROR: 0x0
[ 5641.070563] amdgpu 0000:c1:00.0: amdgpu:      PERMISSION_FAULTS: 0x5
[ 5641.070565] amdgpu 0000:c1:00.0: amdgpu:      MAPPING_ERROR: 0x0
[ 5641.070567] amdgpu 0000:c1:00.0: amdgpu:      RW: 0x1

Thanks
Michael

