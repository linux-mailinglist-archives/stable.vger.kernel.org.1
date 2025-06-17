Return-Path: <stable+bounces-153258-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FAA8ADD37A
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 17:58:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9351D3A69D7
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 15:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADA422ED87A;
	Tue, 17 Jun 2025 15:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hn2XQpUn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 674C72ECD33;
	Tue, 17 Jun 2025 15:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750175377; cv=none; b=ovb5K5hXtMQT4FKmSXIZbflhDBJRro+QTPRO+rP0d6uWMn/gNDkVlGpIPx5uN5KUwbwLKC26oJ78a/2asw0XIoZiOdrKFWipTWjEUN1Sic4cTp6e/jUG+N7UwWszNX5lBAZi5/3dy2x8rXbZCNKPTGiV8M7YAY8C8H6kuAliEUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750175377; c=relaxed/simple;
	bh=0rN6BOkuTqZ/eIWkjHtG6//Vgx6PbFPo1GNXOYA58LQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pqFr2h5hQNutLWPusNZkDpgPVLnuiyhubmqh0wkZYUdXXxjpKKPzGupBdEEoA37jqQ/w7YySOqja47Wq4sIr7pcgKblXzRaELg7xYciTtnefiqdFYKse3jCkXVIsbXryYIYHN2ej1bJX++pXNUVourr9cdf/K+dOn0MtBy8Hje8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hn2XQpUn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC017C4CEE3;
	Tue, 17 Jun 2025 15:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750175377;
	bh=0rN6BOkuTqZ/eIWkjHtG6//Vgx6PbFPo1GNXOYA58LQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hn2XQpUnaTkLGD4Aze3t+BspJmH05MC9fpnt0BE/kfzSMQsOjCLdNv7sWcUWgDwZe
	 cYtiwFDYqm1HQj1iBpe8rKkxuc9LWKsG32hdt18rWAUykf4EdOL26c6AuplBhcIywl
	 Eu8/7yuVSk8xhTmsOf0rEgmkYyooMY+D43XeyZio=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jiaqing Zhao <jiaqing.zhao@linux.intel.com>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.15 076/780] x86/mtrr: Check if fixed-range MTRRs exist in mtrr_save_fixed_ranges()
Date: Tue, 17 Jun 2025 17:16:24 +0200
Message-ID: <20250617152454.605874811@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250617152451.485330293@linuxfoundation.org>
References: <20250617152451.485330293@linuxfoundation.org>
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

6.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jiaqing Zhao <jiaqing.zhao@linux.intel.com>

[ Upstream commit 824c6384e8d9275d4ec7204f3f79a4ac6bc10379 ]

When suspending, save_processor_state() calls mtrr_save_fixed_ranges()
to save fixed-range MTRRs.

On platforms without fixed-range MTRRs like the ACRN hypervisor which
has removed fixed-range MTRR emulation, accessing these MSRs will
trigger an unchecked MSR access error. Make sure fixed-range MTRRs are
supported before access to prevent such error.

Since mtrr_state.have_fixed is only set when MTRRs are present and
enabled, checking the CPU feature flag in mtrr_save_fixed_ranges() is
unnecessary.

Fixes: 3ebad5905609 ("[PATCH] x86: Save and restore the fixed-range MTRRs of the BSP when suspending")
Signed-off-by: Jiaqing Zhao <jiaqing.zhao@linux.intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/20250509170633.3411169-2-jiaqing.zhao@linux.intel.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kernel/cpu/mtrr/generic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/mtrr/generic.c b/arch/x86/kernel/cpu/mtrr/generic.c
index e2c6b471d2302..8c18327eb10bb 100644
--- a/arch/x86/kernel/cpu/mtrr/generic.c
+++ b/arch/x86/kernel/cpu/mtrr/generic.c
@@ -593,7 +593,7 @@ static void get_fixed_ranges(mtrr_type *frs)
 
 void mtrr_save_fixed_ranges(void *info)
 {
-	if (boot_cpu_has(X86_FEATURE_MTRR))
+	if (mtrr_state.have_fixed)
 		get_fixed_ranges(mtrr_state.fixed_ranges);
 }
 
-- 
2.39.5




