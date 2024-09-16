Return-Path: <stable+bounces-76201-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0B8B979E6D
	for <lists+stable@lfdr.de>; Mon, 16 Sep 2024 11:26:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E6AC1F22B7C
	for <lists+stable@lfdr.de>; Mon, 16 Sep 2024 09:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 741E414A4E0;
	Mon, 16 Sep 2024 09:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="n5Px2110"
X-Original-To: stable@vger.kernel.org
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD8C146586;
	Mon, 16 Sep 2024 09:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726478775; cv=none; b=ZZr2vmh70/fK0W6moUDE9pgdv1LvVD90KQrRRQ7kYVhpjyHTq4XekZDY7OjW/S/X9uMXbop9UMM58oM829dxuVzdRWjU+SEYX85oHZm6VVV7QiDf0QjYuJeRoFhom9E4iCNQPf7HeKhsS6JwE4GqZRfqRvo7Vb368c/fRtju3Rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726478775; c=relaxed/simple;
	bh=aQkPuDpvwEae30GhlJo8cTrxC0ZYLwt1xKZE9oUNego=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f9fIhljv9Lg898axWYhmaR+Rd1WxOBRVf9u6NWRiXzhArLprNLmaLVnvO5jsOJymlYqFXlP61Vs0nDmHlp8Kc5rMvpel2HeiL4porTdlyXVNpSNrTKlhVQaVr3DYbW4WemG1KjwnPN9zneJlxPCTwXKVSYIjdxQye4WQPq9q8Es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=n5Px2110; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1726478759;
	bh=5C0HaDNv0z40Dq3FSjo9w53WFVCZuvNtTiGz93K91R0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=n5Px21108kW6uvaDJUby4SvZrloSti/oICfeoE40G351nbnKXDilLyH+9RRdCkgLt
	 Z9Hexp4Zz0KRgQwwC4VNQjY8QMgCQJY1ihq4YfzQPL3TygCpIN5TifkkiXwG9e1JWF
	 CHHl3ZtGeMG9fAuvvVuXvvmRXwGNZ0wM1KTaNFzA=
X-QQ-mid: bizesmtpip3t1726478756ti9l687
X-QQ-Originating-IP: /gJoNUlmd+IboF2jL9DFoR2xzAYrz7MGcmEmwBftpMY=
Received: from avenger-OMEN-by-HP-Gaming-Lapto ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 16 Sep 2024 17:25:54 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 4414229508549440317
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
Subject: [PATCH 6.10] LoongArch: KVM: Remove undefined a6 argument comment for kvm_hypercall()
Date: Mon, 16 Sep 2024 17:25:46 +0800
Message-ID: <8EFAA3851253EB9A+20240916092546.429464-1-wangyuli@uniontech.com>
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

The kvm_hypercall() set for LoongArch is limited to a1-a5. So the
mention of a6 in the comment is undefined that needs to be rectified.

Reviewed-by: Bibo Mao <maobibo@loongson.cn>
Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
Signed-off-by: Dandan Zhang <zhangdandan@uniontech.com>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: WangYuli <wangyuli@uniontech.com>
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


