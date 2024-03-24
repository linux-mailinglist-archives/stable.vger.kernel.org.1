Return-Path: <stable+bounces-30957-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 557A8888D7F
	for <lists+stable@lfdr.de>; Mon, 25 Mar 2024 05:50:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 906A41C2A9FE
	for <lists+stable@lfdr.de>; Mon, 25 Mar 2024 04:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 648F7305494;
	Mon, 25 Mar 2024 01:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E6IS4zPC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C387B28FEAA;
	Sun, 24 Mar 2024 23:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324195; cv=none; b=N+bFoZMyZaTQT7N1pbFq13u+WmC758CGypQ2LcvJ62Er7BQjFauc8bGuQLPDDz2KA2LIEUQeqYCT+gb2Y/C1rFsOUvqpHaO3wMPwlkPHFWuBcU/Z1SP0Yi3Z0IVi4k9I6u9QkNLs9XmTz11SMS2Tb080ASk1RBlZ6r3L6680YxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324195; c=relaxed/simple;
	bh=BGr5Kim+ObIEgA059GrzTSmPeFp/yrDV29RR3h9nPwY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QQyBDkuf0HkH7vWHNd2dxJ5OKePnPijMVWM5TRxT+PSqLYvmdvJvAi8vBoSt3pWcvrRY55FTr0Ru8Rjixwy+atWoXSNKB13vCgh5gfE+odNOAsktMckuU3PISf5zi0Nl0C0RSOjV6WFkPApuMqEiNEzBSFzXqtSdyA/hPZX9YiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E6IS4zPC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30BB7C43394;
	Sun, 24 Mar 2024 23:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324194;
	bh=BGr5Kim+ObIEgA059GrzTSmPeFp/yrDV29RR3h9nPwY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E6IS4zPClcPiVvae77JvBEDL+ZBFF+fDmCmYgO1sK2JkmOe80KJdAE/gA6gDoU9NJ
	 H239Cikrtc/YTvHyhzXFEGNk2FxqYdwaZna6kY0ZqqOoj8Z+XzeMFPiQnhLeR0pms9
	 uOwHGlZZJ8MFRE226Mi1FrPDA5WMHaD0KA5/v5lB+uUw+rtH3hr2svxK8cl0g3M+A7
	 FcBAsi94m/dlao8UquL6R/R+as5TGdbGyz3dJ2q/iEBf+ny/C+y+7VZQ38faM5oH2Z
	 /oPeky7leSDiCp/fsgoBeZ8vjlWDHMeZzBj7dTpGK7zR3nuj4mJMAH7f6nM5AujTln
	 2RhqpV/HhfozQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 183/183] Linux 5.4.273-rc1
Date: Sun, 24 Mar 2024 19:46:36 -0400
Message-ID: <20240324234638.1355609-184-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234638.1355609-1-sashal@kernel.org>
References: <20240324234638.1355609-1-sashal@kernel.org>
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
index 184b31e84b99c..f6ceb2cc87f25 100644
--- a/Makefile
+++ b/Makefile
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 5
 PATCHLEVEL = 4
-SUBLEVEL = 272
-EXTRAVERSION =
+SUBLEVEL = 273
+EXTRAVERSION = -rc1
 NAME = Kleptomaniac Octopus
 
 # *DOCUMENTATION*
-- 
2.43.0


