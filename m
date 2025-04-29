Return-Path: <stable+bounces-138802-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52E1AAA19BF
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 20:15:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EACFB4C4C67
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 18:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B37F2517AB;
	Tue, 29 Apr 2025 18:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NXlDKobF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE5F24729A;
	Tue, 29 Apr 2025 18:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745950396; cv=none; b=u1Pylfv7EpbexhYDuTiadhfoUxIKQdzw2JF8bKiErxkUnp3kZp7+sFbcA6t1Id6SfnEPx0daF1kqVbBbko4mjU53aYpnegKu/UcGefHNyOqqne31WYzxjQGoYXnqTicRbuUahO9QCxxmN9qPxYFSm0q2ufT123iu5TWXar4WCVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745950396; c=relaxed/simple;
	bh=HiNFoV7djFrQt5+uBeQQqOu2A2iKgjU8UFOef4VzJTI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BO5wrSJSgiCJ7Qo+qrnP3ZvAsXzD9YfT+Ofv0npMEnZAaMoFscdFN5ZV+u9FqoAMzqcIJG5aTId6ijeGESHGiR11jhhc7rVt82+C6ie5lHepLCjKqWqtDnLgSkEY7OO+M6fzxyuK9kQ7XHvDCeanw79T2GebrZnDJ7joPbmfZW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NXlDKobF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38901C4CEE9;
	Tue, 29 Apr 2025 18:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745950396;
	bh=HiNFoV7djFrQt5+uBeQQqOu2A2iKgjU8UFOef4VzJTI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NXlDKobFzzouMANJS9T71zZT6VCEGk+Q1+0FJeZMFRTkcn//fmWO5T1Y22FoEIvNS
	 ZDfPo0cEC7N67N8bDABdci2AFS1EokTAJRol4CavELY8mEyCwl9qR/GNTRzNBRiTqb
	 J7EK/iRFNv80DctTwzXflnAVDTaxpe8BpBOsy/94=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 065/204] iommu/amd: Return an error if vCPU affinity is set for non-vCPU IRTE
Date: Tue, 29 Apr 2025 18:42:33 +0200
Message-ID: <20250429161102.086830589@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250429161059.396852607@linuxfoundation.org>
References: <20250429161059.396852607@linuxfoundation.org>
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
index 95bd7c25ba6f3..83c5d786686d0 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -3619,7 +3619,7 @@ static int amd_ir_set_vcpu_affinity(struct irq_data *data, void *vcpu_info)
 	 * we should not modify the IRTE
 	 */
 	if (!dev_data || !dev_data->use_vapic)
-		return 0;
+		return -EINVAL;
 
 	ir_data->cfg = irqd_cfg(data);
 	pi_data->ir_data = ir_data;
-- 
2.39.5




