Return-Path: <stable+bounces-29435-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C9A88885A6
	for <lists+stable@lfdr.de>; Mon, 25 Mar 2024 02:13:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4F1E2869CD
	for <lists+stable@lfdr.de>; Mon, 25 Mar 2024 01:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B24551CE6BA;
	Sun, 24 Mar 2024 22:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KInKxFWC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA5D51CE978;
	Sun, 24 Mar 2024 22:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320408; cv=none; b=llD13DoOdauh6ZCGrRKPaVjB1WriITvqHywbZrLg12d4GyLN5IdHFZ1NF9xebpPly9oovrC2xwzaBcM1voVaCc9gcfueVqb2WgxIMiczUw9R2yTDdy+pGkz8iA6K2ovxIqhI0iY2e8rhqLvVG0Yre0zJxix7kGhaMwI+sBXslG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320408; c=relaxed/simple;
	bh=ocCOP0nM/hJzVNCyRk0ImT6jXL9Dqq6Hay6ga6zftt0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IDf29JXkIdGC33yeGTl2PkeQxFitPxoO1ds0KWrc1WJOQUCqXHS6TMNZ+7peORCGoX9+mFJVHCeH8iDiPbqHGbGVJcYy8k1Oxakf7/rexbt6L0AZHmub2iIfde+BuDO5c9vTwTPTgREKPpjxK3l/AWmFkAcTIZRP5cRBKsGztXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KInKxFWC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 309EEC433F1;
	Sun, 24 Mar 2024 22:46:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320408;
	bh=ocCOP0nM/hJzVNCyRk0ImT6jXL9Dqq6Hay6ga6zftt0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KInKxFWCMFxaZoYvNPU5NhFhT/VjhAUZvBy5iLSJlAZF4h3Sg5m89rWftZD8XysMi
	 xQFAhK1RAFEGVwwW8YzTJifdoLBxrs+s1lDYLVPA2Y8QHtgbBCIaXo7In2amLkMEln
	 bhSfBqHpBnD9xCmUYXERuOQnIR8xMGqYAu2FwCdcx9bDfhQEFbm3tArPuJwpg4Kh4o
	 FPO5szXGPQ6C975vyfHTUxAkaDWyk5inCIqjzD1rXE1zKzYfJI7Wy1DvjkvU/WKNN5
	 G/9VPDk8Fibz/EZAhRnloDb6+Y5PI+dYCnKwy+x3wnMCCtkA42BnCgwdl18nK7ic82
	 +TUVL0jCR5cgQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 715/715] Linux 6.8.2-rc1
Date: Sun, 24 Mar 2024 18:34:54 -0400
Message-ID: <20240324223455.1342824-716-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 95b320ada47c4..f74f798c2e5f5 100644
--- a/Makefile
+++ b/Makefile
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 6
 PATCHLEVEL = 8
-SUBLEVEL = 1
-EXTRAVERSION =
+SUBLEVEL = 2
+EXTRAVERSION = -rc1
 NAME = Hurr durr I'ma ninja sloth
 
 # *DOCUMENTATION*
-- 
2.43.0


