Return-Path: <stable+bounces-76203-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4255E979E7E
	for <lists+stable@lfdr.de>; Mon, 16 Sep 2024 11:29:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D18B5283253
	for <lists+stable@lfdr.de>; Mon, 16 Sep 2024 09:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0529A14A4F5;
	Mon, 16 Sep 2024 09:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="E/IcgTSG"
X-Original-To: stable@vger.kernel.org
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D4291B85C1;
	Mon, 16 Sep 2024 09:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726478948; cv=none; b=CqE4xm/8cUfJsSSbiu9KwpDOnfKs0X6JjKrotlWnoKj7FHYwJCU65y5s8SoeR5nVwbc5Qm1QGhZE8q0gLaECM+eIyWdnfRYhhZgj+bFtmbUj/p8h8dURZvjO0anWT026Lhb1Xfnr2gdp7ZslIQMby+OVFr3SslW80TPrVqrLxVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726478948; c=relaxed/simple;
	bh=LurvBMAZgV5vSM0HyPmLqsMnwdCNy2bUJ7ttWHTaj4E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KLp9pcKalVRtnklipE7NKL5i6Fn+RxgMrrp6iBtcjmGVp5koveKBtrqMUVXLEkPIQXSFfWwnXKD8wVGmzcT2dK8z/zFj9wrRTYcQY4jLjeA011raK0wi3PRJhAevwyswF1Xdk4To0xmS4C9EG2el6+Q+V9OsZWTf+IJ5+q89d8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=E/IcgTSG; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1726478944;
	bh=/J9ycsKmev+JnOkYZ8ZrOJcZ2sdXEpc0VMnSBiYWn1k=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=E/IcgTSGguDWfkqGBfqxNrPHBSsS4fQBAx2hdXAwZhPVFJ/vX1r9N4IQUKwk+i2S9
	 xS/Mu20mRtueSIa6Wu8UiOWqFzmfF51gndv1VSLvnLVn5yjeBM13WAgopCiniDXOgt
	 9tScvnpEliFXJ3MArv1isjxpq6veS5ioDc4eDoHg=
X-QQ-mid: bizesmtpip3t1726478942tk58g1r
X-QQ-Originating-IP: +2qEEGnAhCVxuAAwv4tZUJOrInBum+BnrvEqM8e9iaw=
Received: from avenger-OMEN-by-HP-Gaming-Lapto ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 16 Sep 2024 17:29:00 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 13749986778819452041
From: WangYuli <wangyuli@uniontech.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org,
	sashal@kernel.org,
	maobibo@loongson.cn,
	guanwentao@uniontech.com,
	zhangdandan@uniontech.com,
	wangyuli@uniontech.com,
	chenhuacai@loongson.cn
Cc: zhaotianrui@loongson.cn,
	kernel@xen0n.name,
	kvm@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 6.10] LoongArch: KVM: Remove undefined a6 argument comment for kvm_hypercall()
Date: Mon, 16 Sep 2024 17:28:57 +0800
Message-ID: <5B13B2AF7C2779A7+20240916092857.433334-1-wangyuli@uniontech.com>
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

From: Dandan Zhang <zhangdandan@uniontech.com>

[ Upstream commit 494b0792d962e8efac72b3a5b6d9bcd4e6fa8cf0 ]

The kvm_hypercall() set for LoongArch is limited to a1-a5. So the
mention of a6 in the comment is undefined that needs to be rectified.

Reviewed-by: Bibo Mao <maobibo@loongson.cn>
Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
Signed-off-by: Dandan Zhang <zhangdandan@uniontech.com>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: WangYuli <wangyuli@uniontech.com>
--
Changlog:
 *v1 -> v2: Correct the commit-msg format.
---
 arch/loongarch/include/asm/kvm_para.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/loongarch/include/asm/kvm_para.h b/arch/loongarch/include/asm/kvm_para.h
index 4ba2312e5f8c..6d5e9b6c5714 100644
--- a/arch/loongarch/include/asm/kvm_para.h
+++ b/arch/loongarch/include/asm/kvm_para.h
@@ -28,9 +28,9 @@
  * Hypercall interface for KVM hypervisor
  *
  * a0: function identifier
- * a1-a6: args
+ * a1-a5: args
  * Return value will be placed in a0.
- * Up to 6 arguments are passed in a1, a2, a3, a4, a5, a6.
+ * Up to 5 arguments are passed in a1, a2, a3, a4, a5.
  */
 static __always_inline long kvm_hypercall0(u64 fid)
 {
-- 
2.43.0


