Return-Path: <stable+bounces-98585-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74FAA9E48B7
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 00:23:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFEC71666FB
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 23:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CF27202C59;
	Wed,  4 Dec 2024 23:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="udbxiBa1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C81B19DF66
	for <stable@vger.kernel.org>; Wed,  4 Dec 2024 23:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733354599; cv=none; b=u5AO+Lonb2n16/QMuWCExr8uoSByRGaGrMMCJsiIMQ3gtRSKfo83p4h9gJyk/6OqFl3F3rY1orDxBFxsWAJf6j+26VhkgipOK3yVl2nJXgReE2YCWpnjVcdDwX+WJxFzco8/00WnlynFJ5ToC6UHLcpJDqNggWg7HgFfPeX3kOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733354599; c=relaxed/simple;
	bh=mnjoe1z3iTB4D0V9Zk9Fwwu4jyQV/J46mUFnHLZ7WSE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Uda1qqz7xrmfPmf73g69lmteWQ00JjbHc/FByP3/YPpJIFpNppsbMofw8t0pkwPFTyjMLdLU29k5TYiQBoXBaLMoO47C4KjKWdcI6DyCcLArwQyZpCbUZimDw3jlZCYKqNbrETJRSCacLhSL518eEmJyNrxbaw44ZF011xOTwus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=udbxiBa1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0ABAC4CECD;
	Wed,  4 Dec 2024 23:23:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733354599;
	bh=mnjoe1z3iTB4D0V9Zk9Fwwu4jyQV/J46mUFnHLZ7WSE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=udbxiBa1CT2KNvze8OGU71IMYo8FmMIH/iFL2K1Kmyf9THIb8EhjVvhTMpwLg3/ip
	 CKNMNGj4vvOcWX4bpzmHqadi6hSOVvlLoQICvkwMfrZb34CPEyIZCUQsa9MflwI0tr
	 hnkPnrlSWbNU+T6TC9tflpBVfUUlcRM+QxOWGEuKw9gkFvaBMon9G0iHPCvp0s+Qrb
	 ow2a5mF4ndGtNRg5m9Gw95M/CNgTLEoxkVisC6CQuucVpdTsNz/EBM5L9PCWSi5HgH
	 FxadNKhkRLPxhHkin/vNltUerHVfACTdnSLDQP6YM39owWMGGPsh8Z+Vjih2o6fDTt
	 bqChW6fVdBAxw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jing Zhang <jingzhangos@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 4.19.y 2/3] KVM: arm64: vgic-its: Clear DTE when MAPD unmaps a device
Date: Wed,  4 Dec 2024 17:11:59 -0500
Message-ID: <20241204161950-40aea11f0db97a14@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241204202038.2714140-2-jingzhangos@google.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

The upstream commit SHA1 provided is correct: e9649129d33dca561305fc590a7c4ba8c3e5675a

WARNING: Author mismatch between patch and upstream commit:
Backport author: Jing Zhang <jingzhangos@google.com>
Commit author: Kunkun Jiang <jiangkunkun@huawei.com>


Status in newer kernel trees:
6.12.y | Present (different SHA1: 3b47865d395e)
6.11.y | Present (different SHA1: 78e981b6b725)
6.6.y | Present (different SHA1: 026af3ce08de)
6.1.y | Not found
5.15.y | Not found
5.10.y | Not found
5.4.y | Not found
4.19.y | Not found

Note: The patch differs from the upstream commit:
---
1:  e9649129d33dc ! 1:  a171225845234 KVM: arm64: vgic-its: Clear DTE when MAPD unmaps a device
    @@ Metadata
      ## Commit message ##
         KVM: arm64: vgic-its: Clear DTE when MAPD unmaps a device
     
    +    commit e9649129d33dca561305fc590a7c4ba8c3e5675a upstream.
    +
         vgic_its_save_device_tables will traverse its->device_list to
         save DTE for each device. vgic_its_restore_device_tables will
         traverse each entry of device table and check if it is valid.
    @@ Commit message
         Link: https://lore.kernel.org/r/20241107214137.428439-5-jingzhangos@google.com
         Signed-off-by: Oliver Upton <oliver.upton@linux.dev>
     
    - ## arch/arm64/kvm/vgic/vgic-its.c ##
    -@@ arch/arm64/kvm/vgic/vgic-its.c: static int vgic_its_cmd_handle_mapd(struct kvm *kvm, struct vgic_its *its,
    + ## virt/kvm/arm/vgic/vgic-its.c ##
    +@@ virt/kvm/arm/vgic/vgic-its.c: static int vgic_its_cmd_handle_mapd(struct kvm *kvm, struct vgic_its *its,
      	bool valid = its_cmd_get_validbit(its_cmd);
      	u8 num_eventid_bits = its_cmd_get_size(its_cmd);
      	gpa_t itt_addr = its_cmd_get_ittaddr(its_cmd);
    @@ arch/arm64/kvm/vgic/vgic-its.c: static int vgic_its_cmd_handle_mapd(struct kvm *
      		return E_ITS_MAPD_DEVICE_OOR;
      
      	if (valid && num_eventid_bits > VITS_TYPER_IDBITS)
    -@@ arch/arm64/kvm/vgic/vgic-its.c: static int vgic_its_cmd_handle_mapd(struct kvm *kvm, struct vgic_its *its,
    +@@ virt/kvm/arm/vgic/vgic-its.c: static int vgic_its_cmd_handle_mapd(struct kvm *kvm, struct vgic_its *its,
      	 * is an error, so we are done in any case.
      	 */
      	if (!valid)
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-4.19.y       |  Success    |  Success   |

