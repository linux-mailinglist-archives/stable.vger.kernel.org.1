Return-Path: <stable+bounces-10869-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C11F82D728
	for <lists+stable@lfdr.de>; Mon, 15 Jan 2024 11:22:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F6B01F21F03
	for <lists+stable@lfdr.de>; Mon, 15 Jan 2024 10:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB12EFBF4;
	Mon, 15 Jan 2024 10:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dHpok5xG"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B571F9EC
	for <stable@vger.kernel.org>; Mon, 15 Jan 2024 10:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705314126;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=K4+D1x6d473u1B/OH3x1vFCMppzL+VsC3/Prb9EM8Ro=;
	b=dHpok5xGUu2z3MDk80cYUiiYmF0JooetD1kEqOyg9Fii5ISUmiQZ/yOzGIiEe6mkRBxtrF
	9YqNCnkK4vSc2cYHxTEFOvvFeBxAAEF1H8Yl/5W79iTwEuJD9fLKs5sgscBHUcUoCxBnNp
	JbpswPjvGg8z5IhwPtVFiJ2m7v/1ZPE=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-618-SCEiNkgOOBiQVJbTq6k_VQ-1; Mon, 15 Jan 2024 05:22:05 -0500
X-MC-Unique: SCEiNkgOOBiQVJbTq6k_VQ-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a2b068401b4so641501566b.1
        for <stable@vger.kernel.org>; Mon, 15 Jan 2024 02:22:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705314124; x=1705918924;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K4+D1x6d473u1B/OH3x1vFCMppzL+VsC3/Prb9EM8Ro=;
        b=qywZe+n25dRLrA/mL5znpiqnTqTaTPil/AziPji8q1r/CS6/0PGrXH1SmHIswlfs9V
         vKnUcXXJ9ZDrAo54dO+TOzMG8PDz6oKLpvVy+dibkVCFwr2RELSRj1fNWTWJgXctItuc
         XHhoiXH158WUvkXEdkMKN9LKhy9DI3/NVKHHO4LZh2gTfuIEMe8ODaJuwQuCzsgIHV3i
         Gk//DRZt/PZMCnootY5HhJZRZT4YHCC4L3TGgADg21IWCitDoZINtySxaQpVyFP25Nqg
         aDWu0Ttf1VwsHeOzFTCHTzCFDj4DE5s68l6xeX6UTWW8UuZyOo40tsqNBPL9BhpsLx23
         c6fQ==
X-Gm-Message-State: AOJu0YyPA99pdJB9SXayV4WHqMmYgP/WP8rmti1nEHHsrv8rgWHaQiC+
	FtYDmrQE1nK8J81f7WWygToX+Z/DsEhxnpD1B4gLETAM7BlPgVd2PzR7cHgcfoYjpdtJPsH1VHy
	9qrCq+oOj7SLhhdxTNfknwo+j
X-Received: by 2002:a17:906:2304:b0:a29:905d:1815 with SMTP id l4-20020a170906230400b00a29905d1815mr5191189eja.60.1705314124041;
        Mon, 15 Jan 2024 02:22:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFOqbjQ332BDbGcd20NfCd7fMuM6DUwLFuPXHwpfw8JH8XhdeGykcj3xaokj37ZrmlwciADbw==
X-Received: by 2002:a17:906:2304:b0:a29:905d:1815 with SMTP id l4-20020a170906230400b00a29905d1815mr5191179eja.60.1705314123650;
        Mon, 15 Jan 2024 02:22:03 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
        by smtp.gmail.com with ESMTPSA id f11-20020a170906084b00b00a2c32b6053dsm5110933ejd.166.2024.01.15.02.22.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jan 2024 02:22:02 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org,
	x86@kernel.org,
	Borislav Petkov <bp@suse.de>,
	Dave Hansen <dave.hansen@linux.intel.com>
Subject: [PATCH stable] x86/microcode: do not cache microcode if it will not be used
Date: Mon, 15 Jan 2024 11:22:02 +0100
Message-ID: <20240115102202.1321115-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

[ Upstream commit a7939f01672034a58ad3fdbce69bb6c665ce0024 ]

Builtin/initrd microcode will not be used the ucode loader is disabled.
But currently, save_microcode_in_initrd is always performed and it
accesses MSR_IA32_UCODE_REV even if dis_ucode_ldr is true, and in
particular even if X86_FEATURE_HYPERVISOR is set; the TDX module does not
implement the MSR and the result is a call trace at boot for TDX guests.

Mainline Linux fixed this as part of a more complex rework of microcode
caching that went into 6.7 (see in particular commits dd5e3e3ca6,
"x86/microcode/intel: Simplify early loading"; and a7939f0167203,
"x86/microcode/amd: Cache builtin/initrd microcode early").  Do the bare
minimum in stable kernels, setting initrd_gone just like mainline Linux
does in mark_initrd_gone().

Note that save_microcode_in_initrd() is not in the microcode application
path, which runs with paging disabled on 32-bit systems, so it can (and
has to) use dis_ucode_ldr instead of check_loader_disabled_ap().

Cc: stable@vger.kernel.org # v6.6+
Cc: x86@kernel.org # v6.6+
Cc: Borislav Petkov <bp@suse.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kernel/cpu/microcode/core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
index 35d39a13dc90..503b5da56685 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -214,6 +214,11 @@ static int __init save_microcode_in_initrd(void)
 	struct cpuinfo_x86 *c = &boot_cpu_data;
 	int ret = -EINVAL;
 
+	if (dis_ucode_ldr) {
+		ret = 0;
+		goto out;
+	}
+
 	switch (c->x86_vendor) {
 	case X86_VENDOR_INTEL:
 		if (c->x86 >= 6)
@@ -227,6 +230,7 @@ static int __init save_microcode_in_initrd(void)
 		break;
 	}
 
+out:
 	initrd_gone = true;
 
 	return ret;
-- 
2.43.0


