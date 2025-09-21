Return-Path: <stable+bounces-180763-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B043B8DAC5
	for <lists+stable@lfdr.de>; Sun, 21 Sep 2025 14:24:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F443176C39
	for <lists+stable@lfdr.de>; Sun, 21 Sep 2025 12:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B749B2459D1;
	Sun, 21 Sep 2025 12:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KLMwtuwB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74D9A2E40B
	for <stable@vger.kernel.org>; Sun, 21 Sep 2025 12:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758457462; cv=none; b=AXnGLV8pfdRBuA3LwGwfBenCxuk+4oSnHk9qRjnjlztzZrftmnwQTAz9OCNy/mVk55SP2OxTzWFpNJIIo8xPeWRlMADzx/Dlog0c3CNqvBTTml+JOUntvzuC1yrM+PLIIXKeOP2LU9K5+JsJbTMKSvKYGikFzc9lExBgbxj9h2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758457462; c=relaxed/simple;
	bh=jtLzdEE/92ZEOhSMFF/9HoxYpmevQs8iZffpZChGXLQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=gKFVgzW92LFxLHTxTS+5wvmvU9gUC+gJZU9oLDdXBeEVmGYWIKHSijdIV700xFXhPEc0IIaxi8sdozbCeJt9ZEAQMM5SDQsLYtjIUdtcsjEhC+Bi1nB/2x8av/HzRt2LUfZSL/Eq067bSgY6cBN9QwgPd+dButfGS+E5jJxBNNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KLMwtuwB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 794D5C4CEE7;
	Sun, 21 Sep 2025 12:24:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758457461;
	bh=jtLzdEE/92ZEOhSMFF/9HoxYpmevQs8iZffpZChGXLQ=;
	h=Subject:To:Cc:From:Date:From;
	b=KLMwtuwBt+IPYVTEt6adIccf5UFDZfIAIe1KtbXD6UBZxmOYQVgBy7JmROx9keTtA
	 OPRMDiW7DaJ8rS+VRhwkT04LDrboeKIyJto4VYIj+EpOZNoGdAsrbCZaVRyFBMdQu6
	 ZZjS28qlT57CD/omVZlDyxgcRLJ5idcoaRE+kgXE=
Subject: WTF: patch "[PATCH] LoongArch: KVM: Remove unused returns and semicolons" was seriously submitted to be applied to the 6.16-stable tree?
To: cuitao@kylinos.cn,chenhuacai@loongson.cn,maobibo@loongson.cn
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 21 Sep 2025 14:24:17 +0200
Message-ID: <2025092117-veto-napping-489f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit

The patch below was submitted to be applied to the 6.16-stable tree.

I fail to see how this patch meets the stable kernel rules as found at
Documentation/process/stable-kernel-rules.rst.

I could be totally wrong, and if so, please respond to 
<stable@vger.kernel.org> and let me know why this patch should be
applied.  Otherwise, it is now dropped from my patch queues, never to be
seen again.

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 091b29d53fe645781c5c1f405bc9fcd50ce5792b Mon Sep 17 00:00:00 2001
From: Tao Cui <cuitao@kylinos.cn>
Date: Thu, 18 Sep 2025 19:44:22 +0800
Subject: [PATCH] LoongArch: KVM: Remove unused returns and semicolons

The default branch has already handled all undefined cases, so the final
return statement is redundant. Redundant semicolons are removed, too.

Cc: stable@vger.kernel.org
Reviewed-by: Bibo Mao <maobibo@loongson.cn>
Signed-off-by: Tao Cui <cuitao@kylinos.cn>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>

diff --git a/arch/loongarch/kvm/exit.c b/arch/loongarch/kvm/exit.c
index 2ce41f93b2a4..6c9c7de7226b 100644
--- a/arch/loongarch/kvm/exit.c
+++ b/arch/loongarch/kvm/exit.c
@@ -778,10 +778,8 @@ static long kvm_save_notify(struct kvm_vcpu *vcpu)
 		return 0;
 	default:
 		return KVM_HCALL_INVALID_CODE;
-	};
-
-	return KVM_HCALL_INVALID_CODE;
-};
+	}
+}
 
 /*
  * kvm_handle_lsx_disabled() - Guest used LSX while disabled in root.


