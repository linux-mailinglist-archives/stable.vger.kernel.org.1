Return-Path: <stable+bounces-138472-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8119FAA183B
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 19:57:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D0AD176598
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 17:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B479F253930;
	Tue, 29 Apr 2025 17:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GZ4xjQCq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70AF82512D8;
	Tue, 29 Apr 2025 17:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745949361; cv=none; b=AJ403u6isP37YCtGgcnkKBLP87j3XWGLzueJiedyBRsFBxZHL8n/vaywEDUZpqKp9E5RmY8VMuhO4ASPCcq/FLYR5zdG0fgWNRt0jiu6osAhaQ3K+JpyN9wdTAmkc3sVAmCGSk1hXCImgN/OePpHNnahc6yVknhBnATH7oOzpys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745949361; c=relaxed/simple;
	bh=HXI82mMeE3WmJayrvDGqQm8f6HMVIpNgLndKw1byLWo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ozx7owhAQqBujYlXUuJXvMc0Ig662pAtENSDSiodBiQVV6J9IDOcWhXd8rGBomkMOqgLhMTuj/XmHM9SXWxT21qKNOscowkz11f1hoEZey9KHra7CRSnBxGAM8HSayJf4sR/hDH82xyXnMlircILFSNQHtkRnBL81V+Xt/XReGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GZ4xjQCq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4765DC4CEE3;
	Tue, 29 Apr 2025 17:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745949360;
	bh=HXI82mMeE3WmJayrvDGqQm8f6HMVIpNgLndKw1byLWo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GZ4xjQCqlwR4bNmINO6WQc4344ZeOM7AFg8bDVsXH5NkZG3c2766HvtLGEDm6W6Q0
	 fzSh1RUxsgK6tIMxkWRdrySSNqY3Jc39R7PuKKuYYMrKHLDgtCRtDatNyyQ79IiCsc
	 BcAm9MVfpOQr+WXGyd4QV7uvPSHNnP/CrWe0bAXk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 295/373] iommu/amd: Return an error if vCPU affinity is set for non-vCPU IRTE
Date: Tue, 29 Apr 2025 18:42:52 +0200
Message-ID: <20250429161135.250448696@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250429161123.119104857@linuxfoundation.org>
References: <20250429161123.119104857@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sean Christopherson <seanjc@google.com>

[ Upstream commit 07172206a26dcf3f0bf7c3ecaadd4242b008ea54 ]

Return -EINVAL instead of success if amd_ir_set_vcpu_affinity() is
invoked without use_vapic; lying to KVM about whether or not the IRTE was
configured to post IRQs is all kinds of bad.

Fixes: d98de49a53e4 ("iommu/amd: Enable vAPIC interrupt remapping mode by default")
Signed-off-by: Sean Christopherson <seanjc@google.com>
Message-ID: <20250404193923.1413163-6-seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/amd/iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index d9251af7f3cf6..7d38cc5c04e68 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -3381,7 +3381,7 @@ static int amd_ir_set_vcpu_affinity(struct irq_data *data, void *vcpu_info)
 	 * we should not modify the IRTE
 	 */
 	if (!dev_data || !dev_data->use_vapic)
-		return 0;
+		return -EINVAL;
 
 	ir_data->cfg = irqd_cfg(data);
 	pi_data->ir_data = ir_data;
-- 
2.39.5




