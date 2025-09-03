Return-Path: <stable+bounces-177564-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A6BC1B412BB
	for <lists+stable@lfdr.de>; Wed,  3 Sep 2025 05:03:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EFDE1B62AF7
	for <lists+stable@lfdr.de>; Wed,  3 Sep 2025 03:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2274A2D062F;
	Wed,  3 Sep 2025 03:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="f9v3HJRt"
X-Original-To: stable@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB452D060D
	for <stable@vger.kernel.org>; Wed,  3 Sep 2025 03:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756868554; cv=none; b=kcozEd1/dTwbmZfEl2fdUB9YqHRkMu9gSn1qKrBHON72/fYU8wOUWdZiH/0WqDTPvvBTWIwbMUvYMT8pzQeEIn3G3wzSGl3ONg4jKqBAl7JouLFSnTgOLFC85NIchcDuEGvCHmQa5I+knZaE5SfK1Mn/drDE+sWQCAZwBdhkPWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756868554; c=relaxed/simple;
	bh=kZD+S95HMcR2nglnxtv9Ct+84C8o9d//zBGkBPOOi/c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Z00/KOUuTbj0VNXJ1j8K89lPunmIoaBtzQJsQgJqiwtyWYd8KmJN6Y2xGKFqAOwsqVBVP+nhhTsKdcGen1vsG0iUmSQr2EeDWtt1gqnlxjPhziXKYpAzcwmN0GcNNWCxyBmgsc6kwuIlpBbn5p6dfRw9TvzDnbG9FhzvYXM0paY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=f9v3HJRt; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756868551;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/Tx2jEMYoq+JZmLfU1X2XC0TcFq4rDCnPfS8rv1Co/4=;
	b=f9v3HJRtEPoHVtsb36i9AJ/EENH+XT+9tVrfyaZTy3JbfQuhVfbkgVbbAzrPkV3wXlyk9v
	BC8vBd2c9cNKyItzFfSAiyg8WmUd5l2HssYD4wv/w5Hw9J0dO4uWAeSDg18akW9pPSvx6X
	DkBPHzNd+MHZif29SmTlWwaKDS2k8lo=
From: Youling Tang <youling.tang@linux.dev>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: WANG Xuerui <kernel@xen0n.name>,
	Baoquan He <bhe@redhat.com>,
	Yao Zi <ziyao@disroot.org>,
	kexec@lists.infradead.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	youling.tang@linux.dev,
	Youling Tang <tangyouling@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH v4 6/7] LoongArch: Automatically disable kaslr when the kernel loads from kexec_file
Date: Wed,  3 Sep 2025 11:00:59 +0800
Message-Id: <20250903030100.196744-7-youling.tang@linux.dev>
In-Reply-To: <20250903030100.196744-1-youling.tang@linux.dev>
References: <20250903030100.196744-1-youling.tang@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Youling Tang <tangyouling@kylinos.cn>

Automatically disable kaslr when the kernel loads from kexec_file.

kexec_file loads the secondary kernel image to a non-linked address,
inherently providing KASLR-like randomization.

However, on LoongArch where System RAM may be non-contiguous, enabling
KASLR for the second kernel could relocate it to an invalid memory
region and cause boot failure. Thus, we disable KASLR when
"kexec_file" is detected in the command line.

To ensure compatibility with older kernels loaded via kexec_file,
this patch need be backported to stable branches.

Cc: stable@vger.kernel.org
Signed-off-by: Youling Tang <tangyouling@kylinos.cn>
---
 arch/loongarch/kernel/relocate.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/loongarch/kernel/relocate.c b/arch/loongarch/kernel/relocate.c
index 50c469067f3a..4c097532cb88 100644
--- a/arch/loongarch/kernel/relocate.c
+++ b/arch/loongarch/kernel/relocate.c
@@ -140,6 +140,10 @@ static inline __init bool kaslr_disabled(void)
 	if (str == boot_command_line || (str > boot_command_line && *(str - 1) == ' '))
 		return true;
 
+	str = strstr(boot_command_line, "kexec_file");
+	if (str == boot_command_line || (str > boot_command_line && *(str - 1) == ' '))
+		return true;
+
 #ifdef CONFIG_HIBERNATION
 	str = strstr(builtin_cmdline, "nohibernate");
 	if (str == builtin_cmdline || (str > builtin_cmdline && *(str - 1) == ' '))
-- 
2.43.0


