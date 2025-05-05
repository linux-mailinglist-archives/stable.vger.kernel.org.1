Return-Path: <stable+bounces-140991-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAE44AAB00A
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 05:30:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 236F63B16B4
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 03:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5584027AC2D;
	Mon,  5 May 2025 23:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RvB8I8OH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA332F7C34;
	Mon,  5 May 2025 23:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746487170; cv=none; b=qTaLiGM50L6DaYnrAjX5WvYqnze7I18Yw6Ue7ImZdOt2JCn2bq2f+PsptYyOcMx4MUppk6dKUYLmmXO5TPfvTLCW1NcjSdFVewiiQW5LJmFiTD7NMr0nTBYSxB6hHnyJKAG46NXmF3OG264jt71qnhwhy0m+wHiDtxatUSeqHDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746487170; c=relaxed/simple;
	bh=7GP6ZKiKPbgAQFMXfpN5Irld7+9/L3EwltMzGZmJATs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=goA5903OptTL8BAGRrLr8jWNh5SipDxkN3T8Z51jpPm+DC6uH8XEAxvtQXoYGUbKJ33TT+4uZoongLDA5HVlfI28uAfiCnLAeYtH9No21L6pwDbuidXdXaaTGG5y+0GjqLPX/S+r/rpSxtVbOtit9V7MJtTeWBC1rerecnzn5hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RvB8I8OH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59BD2C4CEE4;
	Mon,  5 May 2025 23:19:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746487169;
	bh=7GP6ZKiKPbgAQFMXfpN5Irld7+9/L3EwltMzGZmJATs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RvB8I8OHPzavoq+ckuO06bMqKNBOQjBccDhBnJslMZe/moapYV8k0HY5cHhdCV5Ot
	 sIn6TD1rdzvZOWje8hwu1RKwZ0ARB3Uojh7Xm2Ld3Of4cc15mFlvLTY5h75au5zYo+
	 Tf1s+K8l2lohiKre6xKlvKUI6r0rHtItheNz2MJNs+NTln3lnOMq+9KR0HYMikiRke
	 Wqzy15BLKsQzhqCu0J7oOfKN9lJQgWdggysrefhH97jt/dOPAECNNlFFdWngJCgE00
	 1GgzOhwJlFq2t3zFpaO903eSCOfzikCcxsGclmb7atgR1WUs4WgVsHXD/J/BrP50MM
	 b8t1hDs1eKcfQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Andreas Schwab <schwab@linux-m68k.org>,
	Rob Herring <robh@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>,
	mpe@ellerman.id.au,
	sourabhjain@linux.ibm.com,
	mahesh@linux.ibm.com,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH AUTOSEL 5.10 038/114] powerpc/prom_init: Fixup missing #size-cells on PowerBook6,7
Date: Mon,  5 May 2025 19:17:01 -0400
Message-Id: <20250505231817.2697367-38-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505231817.2697367-1-sashal@kernel.org>
References: <20250505231817.2697367-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.237
Content-Transfer-Encoding: 8bit

From: Andreas Schwab <schwab@linux-m68k.org>

[ Upstream commit 7e67ef889c9ab7246547db73d524459f47403a77 ]

Similar to the PowerMac3,1, the PowerBook6,7 is missing the #size-cells
property on the i2s node.

Depends-on: commit 045b14ca5c36 ("of: WARN on deprecated #address-cells/#size-cells handling")
Signed-off-by: Andreas Schwab <schwab@linux-m68k.org>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
[maddy: added "commit" work in depends-on to avoid checkpatch error]
Signed-off-by: Madhavan Srinivasan <maddy@linux.ibm.com>
Link: https://patch.msgid.link/875xmizl6a.fsf@igel.home
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/kernel/prom_init.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
index 9a753c4dafab6..b29135dd73342 100644
--- a/arch/powerpc/kernel/prom_init.c
+++ b/arch/powerpc/kernel/prom_init.c
@@ -2944,11 +2944,11 @@ static void __init fixup_device_tree_pmac(void)
 	char type[8];
 	phandle node;
 
-	// Some pmacs are missing #size-cells on escc nodes
+	// Some pmacs are missing #size-cells on escc or i2s nodes
 	for (node = 0; prom_next_node(&node); ) {
 		type[0] = '\0';
 		prom_getprop(node, "device_type", type, sizeof(type));
-		if (prom_strcmp(type, "escc"))
+		if (prom_strcmp(type, "escc") && prom_strcmp(type, "i2s"))
 			continue;
 
 		if (prom_getproplen(node, "#size-cells") != PROM_ERROR)
-- 
2.39.5


