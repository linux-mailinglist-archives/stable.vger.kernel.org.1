Return-Path: <stable+bounces-25911-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A46D9870050
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 12:21:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D612D1C233D0
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 11:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5451539859;
	Mon,  4 Mar 2024 11:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mz5id7zi"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B563A39AE4
	for <stable@vger.kernel.org>; Mon,  4 Mar 2024 11:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709551263; cv=none; b=sDYAickHvIwUUOt/7pKuArd4123Ea/6jZerbomJIg1VnHnIwA/LuA3NbcoyQnnUVyq+jpUS3AIS2k96m8uIIl4qdmVbgyEj/HcXIL2li5/t7+Ni47Evk5NuXgRN8lOZUJYDkhpq7achEsaAPXsTTs/6ygRV9Tssy+IbwYxhQ6Io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709551263; c=relaxed/simple;
	bh=SiRuBvFXfWgYRGWDK2UFAk0wMNPUXFduDrIgBf9pIvI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KNRseY9hQ5j9D7tMCwm65lfxtuB2HtsgRyniA9PTNMhcTRth3bNswEOFiYH3TDWDCY1Jvrdt0oM6JwY13LTllLJMFSC6uf/fp8LtmHoBGKAbV78FFDj2WNcPBBO20sUPgsWIYDag6DwJ/aUHYXh7o2MX4IyyiWqf89upJR11kts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mz5id7zi; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc64e0fc7c8so6574728276.2
        for <stable@vger.kernel.org>; Mon, 04 Mar 2024 03:21:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709551260; x=1710156060; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tpha/KNJyQv84fGNiqeVwTYqNX49SKaHmnMYJdTq9Kk=;
        b=mz5id7zi005oycD8f8pRuAwKf+tuTwdgMIHt+6q4s74Iy27hk1hHCvgPLMN8DYGRAw
         oFoLYFfl+4CLlKTvBVjE/Qh367YKf0NoKx4NUafmi6oMmMoj7aCjgxR+5SOvbvMWnfir
         h4f3JSuUowqiDTFQWU0YHSwOa7XX7+ZP/uaUetJtOGrdb3KZpbuc8tn8jxNtewC4Fh9T
         gT6+PA3G/tPDcOZ9285leyuntugZP+Nva8/iej9io89G/cYNth8mmVKttvYxgwDhun5s
         GNPiUp/mz8A/FmA3EwHII4gfaivrLjH4zxgLmqxkM1QNw3vqPfBMivFFo1/j+jE52S6T
         BQJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709551260; x=1710156060;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tpha/KNJyQv84fGNiqeVwTYqNX49SKaHmnMYJdTq9Kk=;
        b=scnsPlrQUTz1agrxTTQrlcsVQF2hfY6WDYJkDt8LkSU3sd571i2m8zkmRq+VCSNLfq
         zIsNV6N/UxFGKRaz0ddKdASRFDBnk9kMnovm3k7Y/0wmZPaSNvIdUzproQfQQKXvD4uG
         HAssESuHClSd9z+jfuOU6Xiibz9W04R35UX+KAGs71ca9Jo7a1pjAk6ftS0Dhab/EqcA
         5kVppnsMzlqSyzqMBI5QqTjXUr1PTGsBOd6rfak3BZmcsZsLaQejITAABG2BRvzGzn0S
         FzMoo80sefGqfvG0H1Xb4a4E/nVTVeqbXSaWmsuov93V24f+3Suk7If5Adrck5M9Bvt9
         uv0g==
X-Gm-Message-State: AOJu0Yzxg3AWpJ1Z20s5rZfki0q+qElFOeg0hOiPOs10npa+NrUWmAdQ
	Nt2Xe1woXHQKRVOvttcK2q1uKITUpXo2m9W8oSoFsrYgiTyM9iaX+yhcUF5hrkNLvlomQ5LPYnO
	S8cYs34eZGHJ4ZUezyVteWAK/+lHD2GE6dmnfLTPMj+NOXpp8pksO+bQTSC2oazeIeJAoypzQ2O
	vDZIeTI7YKokrBLhWrQk5hyA==
X-Google-Smtp-Source: AGHT+IFMkKU6+kKDgecabJjeHlyNqB7f1kpMXpC+Zq3+zXKd60t0b6dX8VgyMLn59VRAHqIJaGy46Mcu
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a05:6902:1549:b0:dc6:e647:3fae with SMTP id
 r9-20020a056902154900b00dc6e6473faemr349799ybu.2.1709551260684; Mon, 04 Mar
 2024 03:21:00 -0800 (PST)
Date: Mon,  4 Mar 2024 12:19:56 +0100
In-Reply-To: <20240304111937.2556102-20-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240304111937.2556102-20-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1435; i=ardb@kernel.org;
 h=from:subject; bh=CvB/yLkFluxJVLLHov5wL1+Mp1biqu25YHg1tyI0nLg=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIfXpuliDhjUrxG5tlzpbd42zYON0XrZzq1rPfy14LbKyW
 GNTk8uDjlIWBjEOBlkxRRaB2X/f7Tw9UarWeZYszBxWJpAhDFycAjCR3R8YGTaXHv6+PTw/1Wum
 qkvMzeM3LCRuNAeWTz3zUv6Zd97975kM//Ma1q66O3Vj/X9+j2/O+ROW7HU2VEgNrrWef7hs09I YZxYA
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240304111937.2556102-38-ardb+git@google.com>
Subject: [PATCH stable-v6.1 18/18] efi/x86: Fix the missing KASLR_FLAG bit in boot_params->hdr.loadflags
From: Ard Biesheuvel <ardb+git@google.com>
To: stable@vger.kernel.org
Cc: linux-efi@vger.kernel.org, Yuntao Wang <ytcoode@gmail.com>, 
	Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Yuntao Wang <ytcoode@gmail.com>

[ Commit 01638431c465741e071ab34acf3bef3c2570f878 upstream ]

When KASLR is enabled, the KASLR_FLAG bit in boot_params->hdr.loadflags
should be set to 1 to propagate KASLR status from compressed kernel to
kernel, just as the choose_random_location() function does.

Currently, when the kernel is booted via the EFI stub, the KASLR_FLAG
bit in boot_params->hdr.loadflags is not set, even though it should be.
This causes some functions, such as kernel_randomize_memory(), not to
execute as expected. Fix it.

Fixes: a1b87d54f4e4 ("x86/efistub: Avoid legacy decompressor when doing EFI boot")
Signed-off-by: Yuntao Wang <ytcoode@gmail.com>
[ardb: drop 'else' branch clearing KASLR_FLAG]
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/x86-stub.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index b183b40195ee..a0757a37b482 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -781,6 +781,8 @@ static efi_status_t efi_decompress_kernel(unsigned long *kernel_entry)
 			efi_debug("AMI firmware v2.0 or older detected - disabling physical KASLR\n");
 			seed[0] = 0;
 		}
+
+		boot_params_ptr->hdr.loadflags |= KASLR_FLAG;
 	}
 
 	status = efi_random_alloc(alloc_size, CONFIG_PHYSICAL_ALIGN, &addr,
-- 
2.44.0.278.ge034bb2e1d-goog


