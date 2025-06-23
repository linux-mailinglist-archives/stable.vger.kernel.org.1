Return-Path: <stable+bounces-157914-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C41AAE562E
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 00:18:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D0A5165A85
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 22:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B671E221FC7;
	Mon, 23 Jun 2025 22:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mgBgXk2F"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F57B676;
	Mon, 23 Jun 2025 22:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750717028; cv=none; b=dBrn73lD5rOCKi8lyvnwxgPdnzxquZ6P7Y0gO8g2eJdm3SccS6pl6x6OBjRfb9NtqjvSn9UeXajpQUgxVvAEXXz4KdJn+I086CiESAtWYqN4Kje8faWqCKTJOyCEMAvcjWWQ5CrlvFl5GTbLGrJZJYGYrhEY2fzivVECfjW231Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750717028; c=relaxed/simple;
	bh=b9YRZlGd1SIz5rBsBmYhMszyc2kXW98YEbUtsR1HRWM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zq+TKxARJynhYFdE7qFwMm3gihgR0kRuTo0o0NaHQgT1cql+2pIJnFKwLKakzGpegY0a4z05Psq1garvDl5b4ZVmxk71ZfaSAcoTv9bBhgE/TY6dVMidCmNcsA83OX33oIsScQbFUiGSfTiKcZg82hWF/GyyyKKtoL+JDDWQC6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mgBgXk2F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09DBCC4CEEA;
	Mon, 23 Jun 2025 22:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750717028;
	bh=b9YRZlGd1SIz5rBsBmYhMszyc2kXW98YEbUtsR1HRWM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mgBgXk2FE7YNgDiEXc5tCi2CuzY1KkEU1L2njZnZjm+MwtEoF/xqxHDWMgjABlCnN
	 sz5HBpcZKNHHjGbzq1yE3QqI01Hfu4y936yYo+9Mfc6Ozpz88Mk4mLMyWQEjWr+Xt3
	 x6fpHuepV49TC6BeuHbYQszJ4BOK0VdyHIlkSBLU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jim Mattson <jmattson@google.com>,
	Yosry Ahmed <yosry.ahmed@linux.dev>,
	Sean Christopherson <seanjc@google.com>
Subject: [PATCH 6.1 355/508] KVM: SVM: Clear current_vmcb during vCPU free for all *possible* CPUs
Date: Mon, 23 Jun 2025 15:06:40 +0200
Message-ID: <20250623130654.096038126@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250623130645.255320792@linuxfoundation.org>
References: <20250623130645.255320792@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yosry Ahmed <yosry.ahmed@linux.dev>

commit 1bee4838eb3a2c689f23c7170ea66ae87ea7d93a upstream.

When freeing a vCPU and thus its VMCB, clear current_vmcb for all possible
CPUs, not just online CPUs, as it's theoretically possible a CPU could go
offline and come back online in conjunction with KVM reusing the page for
a new VMCB.

Link: https://lore.kernel.org/all/20250320013759.3965869-1-yosry.ahmed@linux.dev
Fixes: fd65d3142f73 ("kvm: svm: Ensure an IBPB on all affected CPUs when freeing a vmcb")
Cc: stable@vger.kernel.org
Cc: Jim Mattson <jmattson@google.com>
Signed-off-by: Yosry Ahmed <yosry.ahmed@linux.dev>
[sean: split to separate patch, write changelog]
Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kvm/svm/svm.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -1426,7 +1426,7 @@ static void svm_clear_current_vmcb(struc
 {
 	int i;
 
-	for_each_online_cpu(i)
+	for_each_possible_cpu(i)
 		cmpxchg(per_cpu_ptr(&svm_data.current_vmcb, i), vmcb, NULL);
 }
 



