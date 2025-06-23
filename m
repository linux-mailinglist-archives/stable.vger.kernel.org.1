Return-Path: <stable+bounces-158207-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06C68AE580E
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 01:35:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6D513BF306
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 23:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A06022CBF1;
	Mon, 23 Jun 2025 23:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b="CL9i9zyJ"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D2CD218596
	for <stable@vger.kernel.org>; Mon, 23 Jun 2025 23:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750721706; cv=none; b=qxTKmhDJwjGcIwIEMzk2u8EYhjPaS7+nnWd/5ibr7oFKNsUw7PCbkKaNZqLB/loYCEB74K1bpaCRZjK+wAA+81waUDX5pnkggrpj/bIO2mzzyAttADfyjJab0wVoetD0AsjwOSwLufkSGbya4gy0O9TY3PyZpvKjfWP40p4ME8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750721706; c=relaxed/simple;
	bh=UTPQdHjFwKTkGB9t0kUTkGNQ/g2HisdMouEZ4e40bws=;
	h=Date:Subject:In-Reply-To:CC:From:To:Message-ID:Mime-Version:
	 Content-Type; b=Q97NOcPx+Zc3O7nOoDJk5HTVzdsofeo7s3/l6urE7dFVZDqZ5owzTM/+QC40fU6vM1wjaP3MjRXT3sXcKhUtYVIgqhMFxklzcSlZffLF9x5npksVoQoH1J5uILiZOcOvBsHPDG+7lAVfWL2LT0Gj4U2kyaOMVVFj2kcHuUqTgbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com; spf=pass smtp.mailfrom=dabbelt.com; dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b=CL9i9zyJ; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dabbelt.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-23636167b30so43955105ad.1
        for <stable@vger.kernel.org>; Mon, 23 Jun 2025 16:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1750721702; x=1751326502; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3C1HBX/7TnNGVwZTeosVdWMVJ7HcYu8ETqN6upndI5g=;
        b=CL9i9zyJnQ7MizxHw3iYMDKz2YejFofDA513x+30WiE/UitLAUHV+16YOFl65GeWCB
         1XAJh2Kfju2oh51HML9pN5n+6thQbhhKl3LcBEByVnLOM94ECNsrjQ4Mjeb/j+Eyx4LM
         jXrYM8THpobU5FqcFaG552hMhnN0uSqL0zCg68Z2SGOG8BwKVx3XKy8rkkTggHyVj+N/
         4Zd9wNrHcGBKuehY1412PKEQpAeDdn9IYbcprwklML74catWfnQKnlt0/PTpqxH3MBni
         dfmtINCWVV7zuOewR/YSaQSCDNoRAh5xI/UOgSPNy7Fsen/E1V5rUErXAKz/Ci0aGV6o
         4/Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750721702; x=1751326502;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3C1HBX/7TnNGVwZTeosVdWMVJ7HcYu8ETqN6upndI5g=;
        b=lWDf4b8LlBc9ecZj+OJAZ2u7Yii5OBgN8UBErrmw2Q4/aluwEo6xDP9fHTjxclmE75
         WOoZauIatHZrMHLMTThQdEu8bV8bqxNkYG4IrO47qvMHLcOQCmSPXM77NUJb+Eb/tb5K
         LrJwEY9zgmEyI/ngv3AhCZrqC+loM1lFGJb0UcmheKqY3CsCoMJ37YvpT6K3roYQZiZZ
         gnAqJQ1jB/uG7KhiLDn+XTNFiWUbwo6dQUrUHTmWV9GHakNISzt2p23M0xCQOfWmjLFt
         YqUuZqRLTqG2N/uCqIc79VwYJ/c7doAvWlY5yo9LNP1d5kNqEmaQSa6w1d+tMzVx7aGi
         0UKA==
X-Forwarded-Encrypted: i=1; AJvYcCWknlchlEIgJsYObchXQHnaGAqWI3RYbMul8NAbkyG8bDwgphvcTp/mEowHVM+8UHSaPzel+o4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxth6DkvXzsN5uu75G3FBivTT2/bxz2766pBzhHu9zRGDmgJYhx
	QqSYZ2mqo7v+at76bLQushaoyF6dvjAcEmr3J23F4Z7vCdasw9pwB939m1hSGVDYQFQ=
X-Gm-Gg: ASbGncvBLpTSZKRqUXy78pdz71y4m8v/B0aATuj0OJT9jWy9W5sZCvxDoSrCbpxL3Gf
	tV/R5fMlcjHTEU96DLUGiF0AHfIHO7yJHhyuJzmQtMSUh//Ya17Ghe0pr2KVUSLpPKNMxExPEbO
	6xsgPJM/cal0UCgWcToXTgpQG7gaJ4qnuu43dUSasiyL/+gI0xJ8jjeWx5yGSEgmHM93pJWPANn
	tTDrth3knCpMo4ddhnAN8vx6O4hAzWwYkCnPswV3f8gin5fCeHkX5tqTZIJimhlXbgkoUxc+gCF
	2IBb5Pu+Xaw9c9BdMZlxw+3w5eedD6Oj6oRRKU3rYe0chsZU85HFRCHyCVcsGdniEbe1nSQ=
X-Google-Smtp-Source: AGHT+IEWQhK1ybI3F/dHuMp7BGaRHJD1DU/MK1xVISPFslSP0vZBJeLT7Qmd8Fs0FSYtyxoSaqreEQ==
X-Received: by 2002:a17:903:287:b0:235:ed02:288b with SMTP id d9443c01a7336-237d98f1a1emr169782885ad.30.1750721702579;
        Mon, 23 Jun 2025 16:35:02 -0700 (PDT)
Received: from localhost ([2620:10d:c090:500::4:8d10])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-237d83d0bedsm92289545ad.67.2025.06.23.16.35.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 16:35:01 -0700 (PDT)
Date: Mon, 23 Jun 2025 16:35:01 -0700 (PDT)
X-Google-Original-Date: Mon, 23 Jun 2025 16:34:57 PDT (-0700)
Subject:     Re: [PATCH] riscv: export boot_cpu_hartid
In-Reply-To: <20250619-rummage-cache-93f48564b7fb@wendy>
CC: klarasmodin@gmail.com, Paul Walmsley <paul.walmsley@sifive.com>,
  aou@eecs.berkeley.edu, Alexandre Ghiti <alex@ghiti.fr>, valentina.fernandezalanis@microchip.com,
  linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
From: Palmer Dabbelt <palmer@dabbelt.com>
To: Conor Dooley <conor.dooley@microchip.com>
Message-ID: <mhng-38FFE919-5F5F-4F1E-A06E-85946E791E4B@palmerdabbelt-mac>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On Thu, 19 Jun 2025 03:25:16 PDT (-0700), Conor Dooley wrote:
> On Tue, Jun 17, 2025 at 02:58:47PM +0200, Klara Modin wrote:
>> The mailbox controller driver for the Microchip Inter-processor
>> Communication can be built as a module. It uses cpuid_to_hartid_map and
>> commit 4783ce32b080 ("riscv: export __cpuid_to_hartid_map") enables that
>> to work for SMP. However, cpuid_to_hartid_map uses boot_cpu_hartid on
>> non-SMP kernels and this driver can be useful in such configurations[1].
>> 
>> Export boot_cpu_hartid so the driver can be built as a module on non-SMP
>> kernels as well.
>> 
>> Link: https://lore.kernel.org/lkml/20250617-confess-reimburse-876101e099cb@spud/ [1]
>> Cc: stable@vger.kernel.org
>> Fixes: e4b1d67e7141 ("mailbox: add Microchip IPC support")
>
> I'm not sure that this fixes tag is really right, but I have no better
> suggestions

Seems OK to me, the driver is what causes the symbol to need the 
definition, so that patch is the first place we'd need this (unless some 
other drivers want it, which wouldn't be surprising).

I'm throwing it at the tester, it should show up on fixes soon.

Thanks!

> Acked-by: Conor Dooley <conor.dooley@microchip.com>
>
>> Signed-off-by: Klara Modin <klarasmodin@gmail.com>
>> ---
>>  arch/riscv/kernel/setup.c | 1 +
>>  1 file changed, 1 insertion(+)
>> 
>> diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
>> index f7c9a1caa83e..14888e5ea19a 100644
>> --- a/arch/riscv/kernel/setup.c
>> +++ b/arch/riscv/kernel/setup.c
>> @@ -50,6 +50,7 @@ atomic_t hart_lottery __section(".sdata")
>>  #endif
>>  ;
>>  unsigned long boot_cpu_hartid;
>> +EXPORT_SYMBOL_GPL(boot_cpu_hartid);
>>  
>>  /*
>>   * Place kernel memory regions on the resource tree so that
>> -- 
>> 2.49.0
>> 

