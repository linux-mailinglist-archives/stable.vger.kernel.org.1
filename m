Return-Path: <stable+bounces-135838-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B97F5A9905C
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 17:19:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 421C317ADC5
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 15:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECB4128A41A;
	Wed, 23 Apr 2025 15:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yh33ppBt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A714528A40A;
	Wed, 23 Apr 2025 15:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745420976; cv=none; b=o0UpBiYQw7Uo0a3RVSoF4c/3xdp57Ys5Nc2z8I9Y3u7TvHTXC9BcstdnKQZQjWP9PXgFRmlwKUKcoPWzGfSgibQ7+fJcsYK76g1WXjSDSFvAGLOWHmzM3dtBP2mzJUQX0u8xykSscBI8TP0RNC1MbUxcIKhWRBp7WCVu1JwW8qM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745420976; c=relaxed/simple;
	bh=UIOkD4mI+DE60hTEklUhXNNsIOTd6nFz7hEDICpXx1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VjW/AA3WNej00KRy/v8tv2d4Gsmqn8i2Lc8AWRjIo2TxMi7Ov20bHnJP54ee49cuAFIpTGfj2Vc85FvNCZ2qTOsxJW2zl0H9GOcGRnPyIf3HvfyQrUbj7RtDwYYnL+Q7/rGSBck6LDVk8EA6H+veVvcXwwaAGWMbKnnlunxPP/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yh33ppBt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE946C4CEE3;
	Wed, 23 Apr 2025 15:09:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745420976;
	bh=UIOkD4mI+DE60hTEklUhXNNsIOTd6nFz7hEDICpXx1Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=yh33ppBtA2lrq/LuIBDWB17ZBINwhtS9+m+jhTGiUxHcB9uy82HSK8t3+4HKO/TZI
	 dzo2S80AscH1pNjhKIPaIy0/7XnYUsf6AemSwOYOJeEqoRwQbZ3KRe0mzDqOxk3Q0i
	 8Ww++gyvG/Dw17Mfly6cQ4t33iqGnumamlw37msg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	Quentin Perret <qperret@google.com>,
	Will Deacon <will@kernel.org>
Subject: [PATCH 6.6 132/393] KVM: arm64: Tear down vGIC on failed vCPU creation
Date: Wed, 23 Apr 2025 16:40:28 +0200
Message-ID: <20250423142648.821364277@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250423142643.246005366@linuxfoundation.org>
References: <20250423142643.246005366@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Will Deacon <will@kernel.org>

commit 250f25367b58d8c65a1b060a2dda037eea09a672 upstream.

If kvm_arch_vcpu_create() fails to share the vCPU page with the
hypervisor, we propagate the error back to the ioctl but leave the
vGIC vCPU data initialised. Note only does this leak the corresponding
memory when the vCPU is destroyed but it can also lead to use-after-free
if the redistributor device handling tries to walk into the vCPU.

Add the missing cleanup to kvm_arch_vcpu_create(), ensuring that the
vGIC vCPU structures are destroyed on error.

Cc: <stable@vger.kernel.org>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Oliver Upton <oliver.upton@linux.dev>
Cc: Quentin Perret <qperret@google.com>
Signed-off-by: Will Deacon <will@kernel.org>
Reviewed-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20250314133409.9123-1-will@kernel.org
Signed-off-by: Oliver Upton <oliver.upton@linux.dev>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/kvm/arm.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -391,7 +391,11 @@ int kvm_arch_vcpu_create(struct kvm_vcpu
 	if (err)
 		return err;
 
-	return kvm_share_hyp(vcpu, vcpu + 1);
+	err = kvm_share_hyp(vcpu, vcpu + 1);
+	if (err)
+		kvm_vgic_vcpu_destroy(vcpu);
+
+	return err;
 }
 
 void kvm_arch_vcpu_postcreate(struct kvm_vcpu *vcpu)



