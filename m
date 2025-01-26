Return-Path: <stable+bounces-110705-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 82DD0A1CBA2
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 16:51:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BBC816C472
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 15:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A2252288CF;
	Sun, 26 Jan 2025 15:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NYpft37J"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33BAC1F473F;
	Sun, 26 Jan 2025 15:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737903881; cv=none; b=mMeHC+vNxY/wpoABXNEURSojzAOSrgAq4hEqk4H1o/6dFHjhe1OrgtCAE0fPu9eg/fF0rzFcqm86K7K8E4M8ddy/WQ5KMcJ2j6aO4uV7es1Alc4H2KsqVjDAttCgH4GnH6gYviFMCg/77QLPQN9490qhLu8Lc5tbC8G6f2UD2ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737903881; c=relaxed/simple;
	bh=yFnwoKonHVEi2fs54ci6bdlvYF9LLU+0zKLON3bAkCY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eodgbkOHG2NlW47pXhfdmRo0V0h0imVR5cwCczjwcwCY7TrmJvk6m6LHl/RUeZr35V21fRFKVvNotgQnDRx43bpFADY1iPk5isVYbbmDMYJ2izhwx1OKp4x4iAiKbPJzBok9LzxUFMBPYv5uF3wbaVbH32VLFdP6PKYaip034LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NYpft37J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BDF8C4CED3;
	Sun, 26 Jan 2025 15:04:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737903881;
	bh=yFnwoKonHVEi2fs54ci6bdlvYF9LLU+0zKLON3bAkCY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NYpft37JG4a2qh4u8vk/fI3XgJXYkseinG1xVdGWbvswiTrDq5fHMsR2XNuG/SUp9
	 CS0rKnUQo8kl/zmI33jqaHZg7MwoPTgO1R2U0uKwxY6IbW8qlWDiSeB99MRAFz8RqS
	 yLHlIhRy0uJPywknJAieCbJTyZyQR8DPKYNueWTU9u979zcCFiJrLDTBaOmszAu/FO
	 vzSLIG8d0QOtK+FfDZaivey/jQ4b8Kil/HkTMXwz9B+mowv57N2WPDMbyrdkgmHIOZ
	 IQwLIJ9pbijtGcF+t29JA2lVyETDrDyy2z7kldjQEeSPL3dLIG7MsYueoSa5WGd2dF
	 YAi1ctYgZAlIw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hans de Goede <hdegoede@redhat.com>,
	Andy Shevchenko <andy@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	ptyser@xes-inc.com
Subject: [PATCH AUTOSEL 5.15 05/14] mfd: lpc_ich: Add another Gemini Lake ISA bridge PCI device-id
Date: Sun, 26 Jan 2025 10:04:21 -0500
Message-Id: <20250126150430.958708-5-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250126150430.958708-1-sashal@kernel.org>
References: <20250126150430.958708-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.177
Content-Transfer-Encoding: 8bit

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit 1e89d21f8189d286f80b900e1b7cf57cb1f3037e ]

On N4100 / N4120 Gemini Lake SoCs the ISA bridge PCI device-id is 31e8
rather the 3197 found on e.g. the N4000 / N4020.

While at fix the existing GLK PCI-id table entry breaking the table
being sorted by device-id.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Andy Shevchenko <andy@kernel.org>
Link: https://lore.kernel.org/r/20241114193808.110132-1-hdegoede@redhat.com
Signed-off-by: Lee Jones <lee@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mfd/lpc_ich.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/lpc_ich.c b/drivers/mfd/lpc_ich.c
index 9ffab9aafd81b..15a6004218521 100644
--- a/drivers/mfd/lpc_ich.c
+++ b/drivers/mfd/lpc_ich.c
@@ -688,8 +688,9 @@ static const struct pci_device_id lpc_ich_ids[] = {
 	{ PCI_VDEVICE(INTEL, 0x2917), LPC_ICH9ME},
 	{ PCI_VDEVICE(INTEL, 0x2918), LPC_ICH9},
 	{ PCI_VDEVICE(INTEL, 0x2919), LPC_ICH9M},
-	{ PCI_VDEVICE(INTEL, 0x3197), LPC_GLK},
 	{ PCI_VDEVICE(INTEL, 0x2b9c), LPC_COUGARMOUNTAIN},
+	{ PCI_VDEVICE(INTEL, 0x3197), LPC_GLK},
+	{ PCI_VDEVICE(INTEL, 0x31e8), LPC_GLK},
 	{ PCI_VDEVICE(INTEL, 0x3a14), LPC_ICH10DO},
 	{ PCI_VDEVICE(INTEL, 0x3a16), LPC_ICH10R},
 	{ PCI_VDEVICE(INTEL, 0x3a18), LPC_ICH10},
-- 
2.39.5


