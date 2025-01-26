Return-Path: <stable+bounces-110494-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D3DEDA1C969
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 15:59:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 736F51622D1
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 14:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3E1D1DDC23;
	Sun, 26 Jan 2025 14:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q2NWhH4L"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8883F194A53;
	Sun, 26 Jan 2025 14:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737903056; cv=none; b=lujfWKr1/i3HQYOLtHjNJiktEChn/3s0Y0ZnWcQE9R9zrdkRgXfXWsf8aORnOkWpq1ajVawpbycsWRwVDc/JyC+SZkrNTYsi8V2y7RtrGm3JNqgMEI6S4d7f+LzdSE883zVOrE7GnXWmL39fQvkjhardQPyHE3Z0M9iEmC3SWsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737903056; c=relaxed/simple;
	bh=2Uc3Y057+o43MSppaGxy+ruKwB3kZ7+rSvxfRI2DXR4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=M2+YEs2qkFfFlUA4cGXN9CKlMJcEbPeldidgUcpmwtnHDlN90WfVXmw1n2m8VlvHruk4EtuRa924G4YWG2zi74zLY3RMoaOs2Hu16perHWoB9wJBGmb3gLlK9RckXgturTNpE7ww8HvYp24gvNRAhk+RGy3jE/8xRQ+XxDZ/Z08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q2NWhH4L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19D58C4CED3;
	Sun, 26 Jan 2025 14:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737903056;
	bh=2Uc3Y057+o43MSppaGxy+ruKwB3kZ7+rSvxfRI2DXR4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q2NWhH4Lo+gHhlQYDxpWTaQMGHjR6Opu6urUJadCBx4gGSoUpAvPcS8ry//7SMysu
	 +t/eGUC5x8vuQjK1IneXUSWNanH/ArFzmcEQbAmmLff0ouEYIGfKSVXiEBRfqpnTA/
	 FdghAweZUiZsEzQ/Efrq4OAT7bftDFZKWrZlIDkDk7byexnI1N9IGKyei6yqZ+7nYp
	 zZs2arR9SAiiqxj4/bc+JfRhWIU4WeEyLmgkR53PG5iz3ZZlO23k/mBzk1BCN9IkqV
	 EgDxXiMye7H84BYzMu0SKeFrbwL0vPc24hWbRXdwB9lFMY0y2/JSgoVECNzgxE5RFY
	 ZDRSqA36OoerQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Yazen Ghannam <yazen.ghannam@amd.com>,
	Borislav Petkov <bp@alien8.de>,
	Sasha Levin <sashal@kernel.org>,
	tglx@linutronix.de,
	mingo@redhat.com,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	Shyam-sundar.S-k@amd.com,
	mario.limonciello@amd.com,
	richard.gong@amd.com
Subject: [PATCH AUTOSEL 6.1 3/3] x86/amd_nb: Restrict init function to AMD-based systems
Date: Sun, 26 Jan 2025 09:50:49 -0500
Message-Id: <20250126145050.926016-3-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250126145050.926016-1-sashal@kernel.org>
References: <20250126145050.926016-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.127
Content-Transfer-Encoding: 8bit

From: Yazen Ghannam <yazen.ghannam@amd.com>

[ Upstream commit bee9e840609cc67d0a7d82f22a2130fb7a0a766d ]

The code implicitly operates on AMD-based systems by matching on PCI
IDs. However, the use of these IDs is going away.

Add an explicit CPU vendor check instead of relying on PCI IDs.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20241206161210.163701-3-yazen.ghannam@amd.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kernel/amd_nb.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/kernel/amd_nb.c b/arch/x86/kernel/amd_nb.c
index e8cc042e4905c..8992a6bce9f00 100644
--- a/arch/x86/kernel/amd_nb.c
+++ b/arch/x86/kernel/amd_nb.c
@@ -519,6 +519,10 @@ static __init void fix_erratum_688(void)
 
 static __init int init_amd_nbs(void)
 {
+	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD &&
+	    boot_cpu_data.x86_vendor != X86_VENDOR_HYGON)
+		return 0;
+
 	amd_cache_northbridges();
 	amd_cache_gart();
 
-- 
2.39.5


