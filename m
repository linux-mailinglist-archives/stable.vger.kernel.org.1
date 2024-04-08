Return-Path: <stable+bounces-36788-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C89F089C1C8
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 15:24:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B868B25D73
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 13:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ABAA78285;
	Mon,  8 Apr 2024 13:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mV1YiHfb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F557F7F1;
	Mon,  8 Apr 2024 13:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712582346; cv=none; b=Lo3XB2yunZVPJ+u0y5fsHzDShMM/Q7NgaSOq+MPXiC18c18FLLvhTu4sxPrccYYpCzJzAf0zsbpK80E09OuUWwlZdSAVyyIU+L0YaFOxoWB5FMPXjF6jbeYd0XXNbhTpOwLWyebvfIyLL9IcjWt1v3zq40jYlI9pcFCkPnULY5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712582346; c=relaxed/simple;
	bh=v3iIek2qoWk4yzbzKWlqByHGxWuemazey+7DfrP00MA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ERX63iIX7XsdhH/U3os/2bNJl77z5q2CrcXptyTt05O31Ojk0g7ZKEOa4SErbBLr1nX7yMBybUh8I3ILsNklDy0tgXyG8thaAfO4FUnr7OwJD56ejVNosBxeWc3q/IkTPBn6RTHQWKJDHl5Fa/CDJvqcRpnqQk/nxdhAtpi1NGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mV1YiHfb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C791FC433F1;
	Mon,  8 Apr 2024 13:19:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712582346;
	bh=v3iIek2qoWk4yzbzKWlqByHGxWuemazey+7DfrP00MA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mV1YiHfb3aPYa/z23R8iF+42XClM04PxhBojwvg9nj/lLbFRjq5IfkDVGCzc7wuE9
	 0MrvvkTW/KvnSduMlNywRehHeMc676AFvXBBjcM9rVvm0MAVUjbe1q/kZa3wPLsiNN
	 7mz/gpNWNnqY31OaDg1JuwkEUEYdiaOpBv0ZnMMo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ard Biesheuvel <ardb@kernel.org>,
	Marc Zyngier <maz@kernel.org>,
	Wujie Duan <wjduan@linx-info.com>,
	Oliver Upton <oliver.upton@linux.dev>
Subject: [PATCH 6.8 067/273] KVM: arm64: Fix out-of-IPA space translation fault handling
Date: Mon,  8 Apr 2024 14:55:42 +0200
Message-ID: <20240408125311.384418407@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240408125309.280181634@linuxfoundation.org>
References: <20240408125309.280181634@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.8-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Wujie Duan <wjduan@linx-info.com>

commit f5fe0adeed6019df495497a64cb57d563ead2296 upstream.

Commit 11e5ea5242e3 ("KVM: arm64: Use helpers to classify exception
types reported via ESR") tried to abstract the translation fault
check when handling an out-of IPA space condition, but incorrectly
replaced it with a permission fault check.

Restore the previous translation fault check.

Fixes: 11e5ea5242e3 ("KVM: arm64: Use helpers to classify exception types reported via ESR")
Acked-by: Ard Biesheuvel <ardb@kernel.org>
Reviewed-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Wujie Duan <wjduan@linx-info.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/kvmarm/864jd3269g.wl-maz@kernel.org/
Signed-off-by: Oliver Upton <oliver.upton@linux.dev>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/kvm/mmu.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -1631,7 +1631,7 @@ int kvm_handle_guest_abort(struct kvm_vc
 	fault_ipa = kvm_vcpu_get_fault_ipa(vcpu);
 	is_iabt = kvm_vcpu_trap_is_iabt(vcpu);
 
-	if (esr_fsc_is_permission_fault(esr)) {
+	if (esr_fsc_is_translation_fault(esr)) {
 		/* Beyond sanitised PARange (which is the IPA limit) */
 		if (fault_ipa >= BIT_ULL(get_kvm_ipa_limit())) {
 			kvm_inject_size_fault(vcpu);



