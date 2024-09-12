Return-Path: <stable+bounces-76009-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7577A976E2F
	for <lists+stable@lfdr.de>; Thu, 12 Sep 2024 17:52:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 719C91C23B0E
	for <lists+stable@lfdr.de>; Thu, 12 Sep 2024 15:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73EA81AD256;
	Thu, 12 Sep 2024 15:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qRgDhjZZ"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C40691AE845
	for <stable@vger.kernel.org>; Thu, 12 Sep 2024 15:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726156327; cv=none; b=fI2wFjHFUXndr63fz3PkbbARkDahYExSp63DOevGEUxxQzg7CfBfNpHwMyPMIVNTFAQnmRwXTMZXQ2O+0z66BI5a4X/X2mVo8r8J75QAyBeq07+oUOf+raLoWl3wtgwgPQb2R8FYlKNntDUnstUIoEcZORynxihiS79wkT6S1tM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726156327; c=relaxed/simple;
	bh=YezmWpeZ9VSPUA0ukgdqKU2YkESG/xVBdN+gFUJACig=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=INyOKk1mJQZZWYjJLtXCy8QvCjUpiWA8mnjRrIyqqizzfq3Fk/T2cBE7vLDQpP8W6EsNBT0UhK6Xk5dkhso6NTnZt1ONBnsy8nf4/BSE0CyeFtr/eJct1sE6BLh5tBntIDVjsfklAOUW4SlVtg1isLMQodq1cR+bulBmnjB0wrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qRgDhjZZ; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e03623b24ddso2057492276.1
        for <stable@vger.kernel.org>; Thu, 12 Sep 2024 08:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726156324; x=1726761124; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+6IeGNcZT5xpb/RoyFddkias/4tHQZMY5eNb96jVXQ8=;
        b=qRgDhjZZClqOiZtpOFdazSeChl+rapRF52H67WjSbdHkfHQppOhLxa395H+YMkqRq+
         r4jYP26z2WIQn+0bbP+KclT/18ZYF5gLisRrajQ7eYo0ccmR2aDrHTCtbp2IPIWmbq1y
         k6eVLQtSyatg1tgouPdepiQf5mn+sX0jVycH1+L5Ofs/uNQ9+MooXIKRk6U5d2c3AUhX
         RZzcJdDWBVMdvyYzr5E8mqsTyHUYCzwarC7lxdj+OhJ6gP97/gGTkFGbgJZ1vt1islk/
         2h5EV5vrrFAy1YAgqBcds/JwD4Uk1wfMdZsBkSH9hhV9n/8v3Gzp1x8x6Yu8jrU75U3v
         EXIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726156324; x=1726761124;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+6IeGNcZT5xpb/RoyFddkias/4tHQZMY5eNb96jVXQ8=;
        b=g9nrjbvnGmrTDkRuptmhIHza4hVFDuaG/mX6RjJRrKLvHeAGxaDgQ163Ghv5CU9P2k
         Fco9KhiY2Yy6gTh1jJ1F6JzMECuZtABT1v3jKXnLB3eQa0O+eHm4AcJ4lSGOf8IVOqB6
         WG6Z4/SenQyKIwTTwTJO24B+906TtzM1CCUi3IX75+X97g+3eEk133bOm6r9eVBC7VC/
         Bn6ydXo8h3sV5LtYwaBNkFnPMkpV2ua8N2QoxJ1gI0QeZ0KdLalVOMr4Hq1q/OW2+zcP
         Xwlrko6xb76fCp9L+d5mSGa1h2H1THBBM8hKLLjHWzfXsv2XF3ADr2qbMvyN5ZbhIO1F
         yI1g==
X-Forwarded-Encrypted: i=1; AJvYcCUKLAu5JD0SU4wd6wXbg/AMbaG5GzsrBO8Q/3u1gSKe7iFPLRb0KOhVh7+1Ss/jy0AJvwiMzis=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkV8243o5H8ZDWHuwFo4GKN8ZVcoCgwXAregJrTu6ol94DFB/i
	PVaSVl1uOOHEl6FE4ds2s6fN858aNNhfnevKyr95F7T7aDd1sWgj4nUiPSe4XdiQdhB76g==
X-Google-Smtp-Source: AGHT+IEaFrTaUbZMAdb/oNCgMY9WERez272JGPYIYXm2jin3aYEbtG6HFvgUb4cCXwOddl+LYX9j0zsK
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:7b:198d:ac11:8138])
 (user=ardb job=sendgmr) by 2002:a25:ec02:0:b0:e1d:2e2:f6fe with SMTP id
 3f1490d57ef6-e1d9dc66ffdmr6457276.11.1726156324559; Thu, 12 Sep 2024 08:52:04
 -0700 (PDT)
Date: Thu, 12 Sep 2024 17:52:00 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1651; i=ardb@kernel.org;
 h=from:subject; bh=9jEAXdaHNXB4dtbQr0AWEtURl6TwUgvit3ZL8yfX20k=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIe0xn0L7mY/pYaxs+/euYudqORZTfsQ7vW3Kg44l9btCF
 /q1fdzSUcrCIMbBICumyCIw+++7nacnStU6z5KFmcPKBDKEgYtTACbysZ2R4U/c8d03c5NY7R+f
 0GJ8Hxi/O3ProWvaNtfvpaf5MVfNec/I8PmNzPKE1z8FTC4s3LtRbWJkgtFn/W8eC+f2Xf428aL VPg4A
X-Mailer: git-send-email 2.46.0.662.g92d0881bb0-goog
Message-ID: <20240912155159.1951792-2-ardb+git@google.com>
Subject: [PATCH] efistub/tpm: Use ACPI reclaim memory for event log to avoid corruption
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-efi@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>, stable@vger.kernel.org, 
	Breno Leitao <leitao@debian.org>, Usama Arif <usamaarif642@gmail.com>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

The TPM event log table is a Linux specific construct, where the data
produced by the GetEventLog() boot service is cached in memory, and
passed on to the OS using a EFI configuration table.

The use of EFI_LOADER_DATA here results in the region being left
unreserved in the E820 memory map constructed by the EFI stub, and this
is the memory description that is passed on to the incoming kernel by
kexec, which is therefore unaware that the region should be reserved.

Even though the utility of the TPM2 event log after a kexec is
questionable, any corruption might send the parsing code off into the
weeds and crash the kernel. So let's use EFI_ACPI_RECLAIM_MEMORY
instead, which is always treated as reserved by the E820 conversion
logic.

Cc: <stable@vger.kernel.org>
Reported-by: Breno Leitao <leitao@debian.org>
Tested-by: Usama Arif <usamaarif642@gmail.com>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/tpm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/libstub/tpm.c b/drivers/firmware/efi/libstub/tpm.c
index df3182f2e63a..1fd6823248ab 100644
--- a/drivers/firmware/efi/libstub/tpm.c
+++ b/drivers/firmware/efi/libstub/tpm.c
@@ -96,7 +96,7 @@ static void efi_retrieve_tcg2_eventlog(int version, efi_physical_addr_t log_loca
 	}
 
 	/* Allocate space for the logs and copy them. */
-	status = efi_bs_call(allocate_pool, EFI_LOADER_DATA,
+	status = efi_bs_call(allocate_pool, EFI_ACPI_RECLAIM_MEMORY,
 			     sizeof(*log_tbl) + log_size, (void **)&log_tbl);
 
 	if (status != EFI_SUCCESS) {
-- 
2.46.0.662.g92d0881bb0-goog


