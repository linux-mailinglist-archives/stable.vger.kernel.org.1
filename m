Return-Path: <stable+bounces-76200-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02267979E4D
	for <lists+stable@lfdr.de>; Mon, 16 Sep 2024 11:21:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 975582827B4
	for <lists+stable@lfdr.de>; Mon, 16 Sep 2024 09:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 321FA1487E9;
	Mon, 16 Sep 2024 09:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="lgixKXbJ"
X-Original-To: stable@vger.kernel.org
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D82A1B85C1
	for <stable@vger.kernel.org>; Mon, 16 Sep 2024 09:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726478479; cv=none; b=sl+WPWpNMJzoUpTLkcif69D04OHVMcfsaUHll3d4g4gD1wB9X73eYo567eNj/UAG1RKurqW2r6BVRRAI00C2zMW6fFSVPtqgP+7DZ6aDEAXjJfxTYZ24j71QBiwyjJbYuC9FAYt9c6xKIeFXlXLpMTYNmf+Y8tgI4PMZcef77rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726478479; c=relaxed/simple;
	bh=Pn4Mb45YuQUUz8lez6aSq4b1LZilNyAo+E6GTIEbwcI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YyomJKvxc+LRGwIpF3qgFuUmgyTipKxkXgS4B7E2HUpISHzSKAk7iF5/SnJe8YPduL655/TQp/5gekg1WGzPA0+AgzTYTfMB4xw5j+U43l4bZzhU6KxiufbAm6+04iCLpHEjXekufZUvaXY9HmR/xeHbR4pJRLSis1UsCm7Uylo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=lgixKXbJ; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1726478466;
	bh=FF2mH2iaHnQrrYcfAju7qxAlGrPt1j84vZARlsclC5I=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=lgixKXbJOElUMKqkvEQz0rSg4ktOB1p06+WW9k2h0HcEnYmGVkRKkHeO0WAh2S/IQ
	 mslO4MtkpBO3SVPcxEFAy9tIGvq1h/aVW57hbro3bA++zEg8Rziz+d9Q8aKpID9GRH
	 XGeZvWjVEc7v7x2ceR65Hr88IFE6FUor7ju/UorM=
X-QQ-mid: bizesmtpip4t1726478463t5ngxjr
X-QQ-Originating-IP: BaCeIgj2n06C8T+oUrEoS915inZDaCMbjGl6EasPm5o=
Received: from avenger-OMEN-by-HP-Gaming-Lapto ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 16 Sep 2024 17:21:01 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 573196331074452442
From: WangYuli <wangyuli@uniontech.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org,
	sashal@kernel.org,
	maobibo@loongson.cn,
	guanwentao@uniontech.com,
	wangyuli@uniontech.com,
	chenhuacai@loongson.cn
Cc: zhaotianrui@loongson.cn,
	kernel@xen0n.name,
	kvm@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 6.10] LoongArch: KVM: Remove unnecessary definition of KVM_PRIVATE_MEM_SLOTS
Date: Mon, 16 Sep 2024 17:20:52 +0800
Message-ID: <796C6F09389EF61B+20240916092052.422948-1-wangyuli@uniontech.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1

From: Yuli Wang <wangyuli@uniontech.com>

[ Upstream commit 296b03ce389b4f7b3d7ea5664e53d432fb17e745 ]

1. "KVM_PRIVATE_MEM_SLOTS" is renamed as "KVM_INTERNAL_MEM_SLOTS".

2. "KVM_INTERNAL_MEM_SLOTS" defaults to zero, so it is not necessary to
define it in LoongArch's asm/kvm_host.h.

Link: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?id=bdd1c37a315bc50ab14066c4852bc8dcf070451e
Link: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?id=b075450868dbc0950f0942617f222eeb989cad10
Reviewed-by: Bibo Mao <maobibo@loongson.cn>
Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
Signed-off-by: Yuli Wang <wangyuli@uniontech.com>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 arch/loongarch/include/asm/kvm_host.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/loongarch/include/asm/kvm_host.h b/arch/loongarch/include/asm/kvm_host.h
index c87b6ea0ec47..d348005d143e 100644
--- a/arch/loongarch/include/asm/kvm_host.h
+++ b/arch/loongarch/include/asm/kvm_host.h
@@ -26,8 +26,6 @@
 
 #define KVM_MAX_VCPUS			256
 #define KVM_MAX_CPUCFG_REGS		21
-/* memory slots that does not exposed to userspace */
-#define KVM_PRIVATE_MEM_SLOTS		0
 
 #define KVM_HALT_POLL_NS_DEFAULT	500000
 
-- 
2.43.0


