Return-Path: <stable+bounces-70247-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2977695F5A8
	for <lists+stable@lfdr.de>; Mon, 26 Aug 2024 17:55:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9DA4283288
	for <lists+stable@lfdr.de>; Mon, 26 Aug 2024 15:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F367C194135;
	Mon, 26 Aug 2024 15:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qaPiEsks"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5AA51940BE
	for <stable@vger.kernel.org>; Mon, 26 Aug 2024 15:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724687740; cv=none; b=YlmnFGMjVsn3rjOqUFIFGp4rvMj3xpNf0d2pCqlD6xuQ1Wg7JDDXqdLDTc5FcQPHCHSmHpBnVOS9Ad/v1qcl13LJzquDOQpv32haTQFY0/a6qsK3WGhZB+eWPHOmWNXRz5HkndqTS76jw0OkO31ERGmM1w/Q0bnGfdUMUUjWSRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724687740; c=relaxed/simple;
	bh=5Foxm4LUjNBxiyhUC13TzQIP2psCLF2l2En0faqviN8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pU2b6MvbhOFEbPTCYgR8jwCGfKdiX7l1tonGMaoh3+zrwALEtjwzWycTk4lRSaIGhqsARSa+fs2GJ6VNSMBpkRTYFolhQXU2wGECRuzFTI5BuAOeUjT2+NaECjczXTjxoEvxyfurDc0RqOQrBvshmcNwrspuPKXx0CMFNDK9R34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qaPiEsks; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00591C52FF5;
	Mon, 26 Aug 2024 15:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724687740;
	bh=5Foxm4LUjNBxiyhUC13TzQIP2psCLF2l2En0faqviN8=;
	h=From:To:Cc:Subject:Date:From;
	b=qaPiEsksC5tfukkBH+U0O2GjaxT2oP/q379+K/dtmN0sUxwVRb0IDYDZWpdzJsQom
	 ENtHOKx/SCjkfVcUpEBu3928oCtHimQyhu7a+N+1b11fwCDMKraY708hb4gR92IVMH
	 tL+GF1tOEDKNYe3EQpOHTsliRPgs+txzoId5l+aMg8NLjQko0e+8uIsYdsmLok/agS
	 6NXilYhchb2jvpfkxHhYhKVSQPuXV4lvjKckEFlkaabUR95blSkX/kIKPK3x8WXQLN
	 caETzbG7iehDTrkdZZ8t36Kpi/CiAVPn8k508DTt+GoZE0m2uoBw2bhtrzcsIjeCuE
	 A0ENXWlZr9apQ==
From: Mario Limonciello <superm1@kernel.org>
To: stable@vger.kernel.org
Cc: Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 6.6 0/2] VCN power saving improvements
Date: Mon, 26 Aug 2024 10:55:30 -0500
Message-ID: <20240826155532.2031159-1-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mario Limonciello <mario.limonciello@amd.com>

This is a backport of patches from 6.11-rc1 that improve power savings
for VCN when hardware accelerated video playback is active.

Boyuan Zhang (2):
  drm/amdgpu/vcn: identify unified queue in sw init
  drm/amdgpu/vcn: not pause dpg for unified queue

 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 53 ++++++++++++-------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  1 +
 2 files changed, 27 insertions(+), 27 deletions(-)

-- 
2.43.0


