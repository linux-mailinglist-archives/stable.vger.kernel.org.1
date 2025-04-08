Return-Path: <stable+bounces-131680-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C0BCA80ACF
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 15:09:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E77E97B1F00
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 13:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A079727C856;
	Tue,  8 Apr 2025 12:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="byX4+esf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E92626F479;
	Tue,  8 Apr 2025 12:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744117045; cv=none; b=UIgaTAfGnmTZWdYv7XVPPXu7lsGTBNU8GsXT6Uf4iOOSHqQvfNb4AWWcgtyKCgos2w7+yWJgPuTCF45VWG1kHq1zMAoFRFphewoukakt1Ua3AKIEmzmDzXJhHEDJ9411YpVtOIX1JKlWmm+QOMsCifTSj9MmeHUYWzQ8b9VyXbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744117045; c=relaxed/simple;
	bh=jkp60opZ03krJ9pOT3fwHpy0NdQFjuQ5fBow/LWX+Js=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MNC7J7AWOBfYRLg6MAt0t+0/QRIpsdc6x4k8SEongXOu+xwMlQnHneAczSg1jTTq8iNsLpa5pqus4FKPmsTSFL2+tXmHz6IW40d5SBloQfk3TcunReF0JQwWMmOc1V7OOvm8cW0rk5jqO8I9bHz89rw3BnHcz2iWMGOofGs6oRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=byX4+esf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E591CC4CEE5;
	Tue,  8 Apr 2025 12:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744117045;
	bh=jkp60opZ03krJ9pOT3fwHpy0NdQFjuQ5fBow/LWX+Js=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=byX4+esfS2UcuB2CYZj09Xcu9gLKLmy0IAUWHUuY5Rm75yqsZI6vxZcaHDfu3kLIc
	 BPirc+vidXIDqnk7nPD2XJhgWQ/Zu9njXOLp0O+ijRXQ7MzMeRohp3ZZwyi//UK/7V
	 bSxEJhZWxSODSD08jtiL7cI/QSv8K8jbGneNbK4s=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mingcong Bai <baimingcong@loongson.cn>,
	Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH 6.12 364/423] LoongArch: Increase MAX_IO_PICS up to 8
Date: Tue,  8 Apr 2025 12:51:30 +0200
Message-ID: <20250408104854.341232404@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408104845.675475678@linuxfoundation.org>
References: <20250408104845.675475678@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Huacai Chen <chenhuacai@loongson.cn>

commit ec105cadff5d8c0a029a3dc1084cae46cf3f799d upstream.

Begin with Loongson-3C6000, the number of PCI host can be as many as
8 for multi-chip machines, and this number should be the same for I/O
interrupt controllers. To support these machines we also increase the
MAX_IO_PICS up to 8.

Cc: stable@vger.kernel.org
Tested-by: Mingcong Bai <baimingcong@loongson.cn>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/loongarch/include/asm/irq.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/loongarch/include/asm/irq.h
+++ b/arch/loongarch/include/asm/irq.h
@@ -53,7 +53,7 @@ void spurious_interrupt(void);
 #define arch_trigger_cpumask_backtrace arch_trigger_cpumask_backtrace
 void arch_trigger_cpumask_backtrace(const struct cpumask *mask, int exclude_cpu);
 
-#define MAX_IO_PICS 2
+#define MAX_IO_PICS 8
 #define NR_IRQS	(64 + NR_VECTORS * (NR_CPUS + MAX_IO_PICS))
 
 struct acpi_vector_group {



