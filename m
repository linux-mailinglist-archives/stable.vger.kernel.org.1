Return-Path: <stable+bounces-144226-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BB2DAB5CAF
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 20:49:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27842866E02
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 18:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D11722BF96B;
	Tue, 13 May 2025 18:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mVmadzI1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C6BE2BFC95
	for <stable@vger.kernel.org>; Tue, 13 May 2025 18:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747162129; cv=none; b=bnN0kOd8Av9sWYpiElpKGFR0YF6hrV68r3uXKdRBp8T8Pyky7Hiye87i3KXC3nyayHTSnIu34jCBDZT/Jkbfiycn3wNofq+EcDVOLXZ1OpQ2wSBkVFVLgTo/bPNWY4N2EJha0OrUoFOvhj6myrmgbVvv9e9/5hQ9kljXOPV7ssA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747162129; c=relaxed/simple;
	bh=1ZHsCM6WblRnRzEO5brB/gbEUCvJTx0Mwq9fKdmpKb4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MinfhCPwebZo5CJIpg2t7lR+VILa9QQNVFYtVOUsZqU39RNqMipVw09RXLr5BP77l9vH1gb8FgqYmkQnz5R58W12ezcubqMlHvsPL+KY2ewvUfmWDBupLLYdnzcMVlOPjs/0JxIVpEUD0BnDS3FMnRAbWhYPUnSl86Mdi+3e4wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mVmadzI1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 907F8C4CEEB;
	Tue, 13 May 2025 18:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747162129;
	bh=1ZHsCM6WblRnRzEO5brB/gbEUCvJTx0Mwq9fKdmpKb4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mVmadzI1cinzLewyIs9lN6SrRO8Gnny22j1hPbnYt4RKMSPHs6X3PHwUoU8eu0HjC
	 jfoUpD2B5beLHBfLPtRFgDLNlbEJbn4ijcLUYVbnU5z2eQYfeLplGEd/pVvPtljsGC
	 Z03maLe+aaf/QZRsh2pUbK9Y1lGWB8YXXVOWlNRPgvUiu/ymRplHbBgPODYsdPVtbU
	 OJjGDv22tYelAPBs8I5CdVjTxczXXePnDHVSvm5/Bf/Jsq2rwQyqF3T9dUExq4fQTk
	 5BLIuJ4eFc6BWClYH2SiSt2VBB97HhnPghyRChTllDEkNa0OaNLEfZxHpb6g0u6aZB
	 kkNJxB5KT+fug==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: bin.lan.cn@windriver.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y] ext4: fix uninitialized ratelimit_state->lock access in __ext4_fill_super()
Date: Tue, 13 May 2025 14:48:44 -0400
Message-Id: <20250513101625-61e710b00c701394@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250513063958.1276890-1-bin.lan.cn@windriver.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

✅ All tests passed successfully. No issues detected.
No action required from the submitter.

The upstream commit SHA1 provided is correct: b4b4fda34e535756f9e774fb2d09c4537b7dfd1c

WARNING: Author mismatch between patch and upstream commit:
Backport author: bin.lan.cn@windriver.com
Commit author: Baokun Li<libaokun1@huawei.com>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: 23afcd52af06)

Note: The patch differs from the upstream commit:
---
1:  b4b4fda34e535 ! 1:  c7207ca9072b9 ext4: fix uninitialized ratelimit_state->lock access in __ext4_fill_super()
    @@ Metadata
      ## Commit message ##
         ext4: fix uninitialized ratelimit_state->lock access in __ext4_fill_super()
     
    +    [ Upstream commit b4b4fda34e535756f9e774fb2d09c4537b7dfd1c ]
    +
         In the following concurrency we will access the uninitialized rs->lock:
     
         ext4_fill_super
    @@ Commit message
         Reviewed-by: Jan Kara <jack@suse.cz>
         Link: https://lore.kernel.org/r/20240102133730.1098120-1-libaokun1@huawei.com
         Signed-off-by: Theodore Ts'o <tytso@mit.edu>
    +    [Minor context change fixed.]
    +    Signed-off-by: Bin Lan <bin.lan.cn@windriver.com>
    +    Signed-off-by: He Zhe <zhe.he@windriver.com>
     
      ## fs/ext4/super.c ##
     @@ fs/ext4/super.c: static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
    @@ fs/ext4/super.c: static int __ext4_fill_super(struct fs_context *fc, struct supe
      
     -failed_mount10:
     +failed_mount9:
    - 	ext4_quotas_off(sb, EXT4_MAXQUOTAS);
    + 	ext4_quota_off_umount(sb);
     -failed_mount9: __maybe_unused
     +failed_mount8: __maybe_unused
      	ext4_release_orphan_info(sb);
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

