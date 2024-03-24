Return-Path: <stable+bounces-32009-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F2F1889DA0
	for <lists+stable@lfdr.de>; Mon, 25 Mar 2024 12:49:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8EE92A7ADD
	for <lists+stable@lfdr.de>; Mon, 25 Mar 2024 11:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E19C3C0639;
	Mon, 25 Mar 2024 03:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ikQ7Cyxi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EFCA131BC2;
	Sun, 24 Mar 2024 23:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323861; cv=none; b=Y92A86oKiJaM5xyr1+hc2Av3toFRdk7PAhEsPYdXBFQjgF5NONDf9cSiUz4lIlV0Dh/LLIbS+2pnbcyU6oldZLtSDjGjjh/5mKm3o2o7euiGWzS5AXtn6tPSEZN7nIlGB63T74ex34RKbnOqHglLDgIuF+zLuT9mAkCG1PLbpMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323861; c=relaxed/simple;
	bh=rDm185Bh1EDMtEJsFpi2CDlhDA/68UEtjAVW+yRFrLM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mw+ROW6LJFxrhXYHuCuIUCQiAa3757oXIed/0kcq9DDpFILGDXKk8dHpAyi//dnzXAn2eyCe6XGhxXRSuViPdsh9VQeqZ+/K4U1n5vVMVstTBVQcR1QD4BGt2mVCmOcn6mVxY6fiLeHAahOfHB9zPBMi1xqj32Xh/qtfInnKcxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ikQ7Cyxi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1242C43390;
	Sun, 24 Mar 2024 23:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323860;
	bh=rDm185Bh1EDMtEJsFpi2CDlhDA/68UEtjAVW+yRFrLM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ikQ7CyxiOU+KslErxGaqVqJ79XJsHMaZ5zlBR1PrmPFyeXmVVWhkFli+iF14w3eJg
	 7Q+YLIwjTL/ofWx3LHhfp9/x7kp3S+OA+AEWuL1lmlWXz0ArEJtc5uee2PUiuQsbcV
	 L6w27FkYv23dJ7Y+KlZ+vI1rXbtDNuPBybKqp1q5CTagm6UqtwGahz6YXvXmvKilLP
	 r91rQN95d59wEfVRs3ytqQsx2IAq/vzz0eEaGOAT26u0wp2Bt6rp+GtBk3txPJVR9K
	 MaHClbRM4UD5nMGTpIubbz3tcMQ97/yhozq1fuZj8cc1oxwC0GJ1/IkrRh8jUROM1H
	 WLKX5Pugrl86g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 238/238] Linux 5.10.214-rc1
Date: Sun, 24 Mar 2024 19:40:26 -0400
Message-ID: <20240324234027.1354210-239-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234027.1354210-1-sashal@kernel.org>
References: <20240324234027.1354210-1-sashal@kernel.org>
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
index b6af62d53d7a6..980bbbcfc2605 100644
--- a/Makefile
+++ b/Makefile
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 5
 PATCHLEVEL = 10
-SUBLEVEL = 213
-EXTRAVERSION =
+SUBLEVEL = 214
+EXTRAVERSION = -rc1
 NAME = Dare mighty things
 
 # *DOCUMENTATION*
-- 
2.43.0


