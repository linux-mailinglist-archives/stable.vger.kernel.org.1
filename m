Return-Path: <stable+bounces-146081-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 33B0EAC0B74
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 14:17:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95DF41891254
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 12:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1921289E2E;
	Thu, 22 May 2025 12:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="AY1gHKJF"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f68.google.com (mail-ej1-f68.google.com [209.85.218.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A1391E51D
	for <stable@vger.kernel.org>; Thu, 22 May 2025 12:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747916232; cv=none; b=gQkYFlG3juzgZmKLR0kjKZvyCEYEs/yD5FIZl5v84mMz0iADMD82DGADPwS7xcfjFGbSljtQlAjoClvW+UI9L4El/XalO4Z814Y0WLCWxjTyM9pVRi5pi4+cfMebRKEqwEkFkm+NXtODDL6LYXMtbq+OT0/eRU/bw/jUT+ExRtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747916232; c=relaxed/simple;
	bh=eiUAPtWkklVAkMrYR4Bk7yeefVmpei03jtQi4YPJahM=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=nNNpxLdOgRVmb5jgqQblEx6wHZihyQB3Kxz3UG8M+v2lfFxGC6pd1c8OYB/5bSIovH+GJcdPgrR/SRllX4ajF9IiXpccsFfOK+tWwifXoamdmpnVot9EofdAQa9CMdQIgQUJ/OgL87/KmsVUCILlufOk/3tnuP9+x8ZAKfLWPIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=AY1gHKJF; arc=none smtp.client-ip=209.85.218.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f68.google.com with SMTP id a640c23a62f3a-ad5767b448aso55246666b.3
        for <stable@vger.kernel.org>; Thu, 22 May 2025 05:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1747916228; x=1748521028; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :subject:cc:to:from:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eiUAPtWkklVAkMrYR4Bk7yeefVmpei03jtQi4YPJahM=;
        b=AY1gHKJFaUKV1+1KsHChtdmUTfeaq/+H16DnkSa1m5DDXNl/HWhdJMBGVfhbh1V79x
         3YkMTNCWAru9XSIKBjkKHKgRbPtQ+iAAIefvK9g5l6IldZpr9u0Iplk9jjPdB8FLdaly
         b7k7R3uV7dtKeUD3xCg5KFJZCBs2QQXXsSPl8SQY65L8GpJG9NspaO9U8hx2ToUmdSQd
         9Z2SPFBjLPwtheRGFVB087xtrwsp6oNe0cmIHkwdia4YE1+5zCx2Yn7oFHtdMZ5X84fG
         ogFsyBk7NHGUPjPD3SC737mSu6QdnOBUDSdKa8OxUWlN6bG7Uq/kPLpg75wjek0iezUP
         tRzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747916228; x=1748521028;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :subject:cc:to:from:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eiUAPtWkklVAkMrYR4Bk7yeefVmpei03jtQi4YPJahM=;
        b=VusHr38DHotctp8KHpthdv/LnVhWZbEdvHpRjZfykD3XN1k1llX4HABY0XD9VYB3lt
         u4TzGK3T5wa7Z04czRpeCAQ+1z4dulkasxGj/hFF3JKYNnFPpRlr+TpGNm6CRJN8F9IA
         ECjvh/oFtZp8HeCns0uLfDGrYZq1TjFHu920tL/0grD7xeHhsLa7nsLfCpEEOzk2pBOv
         1gTeRhevhKaQhtbOJs3t8jMKflm/HHI6sOxJ0R1liTov4oCSMDB95Cu0oHshhZbRsrwU
         xCWh1OSyitOExzuMkcl0JdnT3T0gOkeR66Vzc2s3lA9tSqcDQxJ4b6v6AXPFV23kRN7K
         D+ww==
X-Forwarded-Encrypted: i=1; AJvYcCUhYq8O2d1d82yFfe3knmW88PPKd9NdLvvNAhOxqVHQF7pHiuw47PY/rkReiuys6lyowNKrDUE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXY1aspgT8rK2tnX/Nkfe1PupHwWVfb24K4E6gm7L5hoYYkY1C
	EFnjiGM9XDRSnEZBkpxEACtPtRJvFoyQS7M2WBFNnZsM/+0a2TxcW+a9VAxxwkJFZEs=
X-Gm-Gg: ASbGncvYPgoEP1ltZlw+Xv7XNX7ZlhE0Mghf+fyn2y2J/nkJyTrWelxK/1OnEO2xT5/
	r0KvjSB5VE2j/sQ5G2BanJp4byZ5gR+G/ZRW02U11lNFgA4uL4kVYNUDJMZe7OnxoyBkrZaJ0M0
	EqmViKe06wOxM7+g+KYZVYSzJnDsaWETf6nYkNVyPPgVxnVV8Qhl2+fP8Ud1qOybk4KVWvrF3QZ
	VFtNIhbG/iapomf3AKufzLsjmNvZbl95W6F9ZyMVvVLXbyt0nQOcpcZ9hbz8KbuSUPeEGDrpFFI
	VEFqb7JraO+q7xJWMJafBvfqudul7THpcbKD5rTSv8E+H5/RJilz7QbOIVATM96LrSeHCcIchA=
	=
X-Google-Smtp-Source: AGHT+IGlOm7kKNiIMa4LYQU01uE9DXQXr/EXxT9p4EDhhkg8mLhr6eFDmP3LkE+YOmae5nnJZU74TQ==
X-Received: by 2002:a17:907:28d1:b0:acb:7de1:28b9 with SMTP id a640c23a62f3a-ad52d49b404mr686859466b.5.1747916228283;
        Thu, 22 May 2025 05:17:08 -0700 (PDT)
Received: from lb02065.fkb.profitbricks.net ([212.227.34.98])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad52d047bd6sm1055733066b.29.2025.05.22.05.17.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 May 2025 05:17:08 -0700 (PDT)
Message-ID: <682f15c4.170a0220.3893a.e498@mx.google.com>
X-Google-Original-Message-ID: <20250521165909.834545-2-pchelkin@ispras.ru> (raw)
From: Jack Wang <jinpu.wang@ionos.com>
To: pchelkin@ispras.ru,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org
Cc: bp@alien8.de,
	dave.hansen@linux.intel.com,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	mark.rutland@arm.com,
	mhiramat@kernel.org,
	mingo@redhat.com,
	peterz@infradead.org,
	rostedt@goodmis.org,
	rppt@kernel.org,
	tglx@linutronix.de,
	x86@kernel.org
Subject: [PATCH 6.1 1/1] x86/modules: Set VM_FLUSH_RESET_PERMS in module_alloc()
Date: Thu, 22 May 2025 14:17:06 +0200
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250521165909.834545-1-pchelkin@ispras.ru>
References: <20250521165909.834545-2-pchelkin@ispras.ru>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fedor Pchelkin <pchelkin@ispras.ru>

From: Thomas Gleixner <tglx@linutronix.de>

commit 4c4eb3ecc91f4fee6d6bf7cfbc1e21f2e38d19ff upstream.

Instead of resetting permissions all over the place when freeing module
memory tell the vmalloc code to do so. Avoids the exercise for the next
upcoming user.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20220915111143.406703869@infradead.org
Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>

I confirm this patch fixed the random crashing ontop of 6.1.139 I've experienced
on our Icelake and Cascadelake servers, servers are working fine after appling
the fix, thx!

Tested-by: Jack Wang <jinpu.wang@ionos.com>

