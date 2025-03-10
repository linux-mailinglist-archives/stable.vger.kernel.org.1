Return-Path: <stable+bounces-122205-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE994A59E5A
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 18:30:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F2517A2749
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 17:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54B0822FF40;
	Mon, 10 Mar 2025 17:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="L5n63lCS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 115F881E;
	Mon, 10 Mar 2025 17:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741627827; cv=none; b=thqWvqyJLYt0iuLbRnhRFWXkZvt7QJwTmPgyUQ25hjl4sNSfQ6pCPmD/AREK+cdtM6S0yM3Deg4gkgTF/Mnk8FEiCwwHcKPuOQnepJV0baMR1hSkLAVTqTuhNo3TRlb+b4lGNHnyr4eCEzR48M0QTea5s52ipGP7KbM4NfutoC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741627827; c=relaxed/simple;
	bh=OMlUQmkpNma5SzczMSOHLTZYJ1lelsbN6NCw+9vvAIo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pifMTTkx02R5CZBxfPckicQl772k3GDO9FAPmwxiQ+0zHNQ89SCMtk+RZbH1ZH/yGIYzH6sRZRL1BrVQJ3hKF0XNnBo0PBbzRS0PFGMd+oaRZHfx9lxRnHXsT6wdW3wHF04NrMhYn4nTPHvUa0UV5uIlYnyQhAHUWApHMip1RhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=L5n63lCS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B96EC4CEE5;
	Mon, 10 Mar 2025 17:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741627826;
	bh=OMlUQmkpNma5SzczMSOHLTZYJ1lelsbN6NCw+9vvAIo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L5n63lCSHKW0brFW+RcKUWoSRF3fRGjeyrjWUhgdIqKOBTNfwopcQ9niAsPzaUgrk
	 olvVdrpvBAoWU5Lnz6zXcGOweNp4E26brVAXyK13FA5rTwwvnKX1APd9cN5bxrKuwi
	 hkgha3NF8CJtaFWNiXCVreFBebsmy70wqWpwobXI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 6.12 264/269] Revert "KVM: PPC: e500: Mark "struct page" pfn accessed before dropping mmu_lock"
Date: Mon, 10 Mar 2025 18:06:57 +0100
Message-ID: <20250310170508.308321638@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250310170457.700086763@linuxfoundation.org>
References: <20250310170457.700086763@linuxfoundation.org>
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

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

This reverts commit f2623aec7fdc2675667042c85f87502c9139c098 which is
commit 84cf78dcd9d65c45ab73998d4ad50f433d53fb93 upstream.

It should not have been applied.

Link: https://lore.kernel.org/r/CABgObfb5U9zwTQBPkPB=mKu-vMrRspPCm4wfxoQpB+SyAnb5WQ@mail.gmail.com
Reported-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/kvm/e500_mmu_host.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/arch/powerpc/kvm/e500_mmu_host.c
+++ b/arch/powerpc/kvm/e500_mmu_host.c
@@ -498,9 +498,11 @@ static inline int kvmppc_e500_shadow_map
 	kvmppc_mmu_flush_icache(pfn);
 
 out:
+	spin_unlock(&kvm->mmu_lock);
+
 	/* Drop refcount on page, so that mmu notifiers can clear it */
 	kvm_release_pfn_clean(pfn);
-	spin_unlock(&kvm->mmu_lock);
+
 	return ret;
 }
 



