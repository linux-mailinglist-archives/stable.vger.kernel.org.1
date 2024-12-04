Return-Path: <stable+bounces-98567-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F84F9E48A2
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 00:22:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 005E328114A
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 23:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29DE51B0F0E;
	Wed,  4 Dec 2024 23:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lq4F/GZ5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE91819DF66
	for <stable@vger.kernel.org>; Wed,  4 Dec 2024 23:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733354563; cv=none; b=SHe3RbEmbM2S+h7SdNQF6MHrM/Xv2vgx0rDVlIl+bYxA3cGBzPcYqhIbekXa471liHE8Hhj9qttjmM/nFU4I/Mba2AcfsygNTWfJBm5Uc9JRgOemA7HtWL85YvCaaXJS6fSyQknRNZKMn24y5Wg91/cb4nm32PFFnQLmgzyVNVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733354563; c=relaxed/simple;
	bh=CPGtmb5pzgAEV9sCvJitDStXD8b2gbvXuzDH2JfKSds=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NiV5uYoQWMpk+g59kN/LVRVvu/7GnNxjoXN1GKcpl3BUlR89yDfa4iT6ntyqk623zj3eOyxo+Fluij/f0ynpv14P1pjbkzUgIsqvsGbJpUXD3z8ww/Tn7TzRQreDvNKw/LvHGCOZ+hHeqIkM3y0SCzStnGUsE4hFX14233xP2wY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lq4F/GZ5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED043C4CECD;
	Wed,  4 Dec 2024 23:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733354563;
	bh=CPGtmb5pzgAEV9sCvJitDStXD8b2gbvXuzDH2JfKSds=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lq4F/GZ5CaFYCVrngpMBNXx4W7XzE8FLcXOVB+3MeDH7cxKwvn9rIFSuKCh6wAL/X
	 bp9By0aQUhbvWO81LWP+HpRQmrRjdwEhsSlbRfVSQLFCjULmUwHrgePmm2f4/AAazK
	 CDLeQz0CXoaQELnG52qiIQEurJ/EQBMGjC4dS1/9coAsyC4YpAXxBbwjfvDd0CifGM
	 F3SWWCvm2ObrtWWJSRtPTo/Tvx+tPQR5+8unxwO+ORyqqLL36QxeTMBk6JAu1LmCTe
	 at2+l2VxA9zhPfp9LB7SHJyC7oW/DBt6D3P58GDRmh+qM/KqtqRKBIBFFJsQ0obIrI
	 L9gKa19X6EsuQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jing Zhang <jingzhangos@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.4.y 2/3] KVM: arm64: vgic-its: Clear DTE when MAPD unmaps a device
Date: Wed,  4 Dec 2024 17:11:23 -0500
Message-ID: <20241204165123-7cdfc014c7b5df67@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241204202301.2715933-2-jingzhangos@google.com>
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

Note: The patch differs from the upstream commit:
---
1:  e9649129d33dc ! 1:  44c617b100eff KVM: arm64: vgic-its: Clear DTE when MAPD unmaps a device
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
| stable/linux-5.4.y        |  Success    |  Success   |

