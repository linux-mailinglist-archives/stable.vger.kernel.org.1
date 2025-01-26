Return-Path: <stable+bounces-110732-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01B2DA1CC39
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 17:04:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1202C3A904D
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 15:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D76AD22FDED;
	Sun, 26 Jan 2025 15:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L+9MtDJZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 924981F666E;
	Sun, 26 Jan 2025 15:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737903938; cv=none; b=mXjW63VATHsSIEwzF4DI11zIfEuFqZAmTQG6dfb1XXxeEe7Y0wb5DeV48XI6UrxzIjhxkkhaHyicEiHsu0ufUfvwdhSA1WtVOd8vS/GYHwQuGxTbLnnPOHV8R06unJN0NgaW77vPdVzNgsNQKuKitFil6ppnu9vQsf8tiyJcj4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737903938; c=relaxed/simple;
	bh=Ln1lZLHF9R6eQm2Js1Wm5kbeOdYIaJ8l0Y3234tRiJ4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NEveO/VSAFlRGvck/LTab+hYCPU/mmHlkgc105QK7n6dhhTgxAaF6ChG1vKXQ6PWJTcPlKbos/10b+5BWMn6yI3BZGUlcIBWARKbI2aCJxz1qN4BWD+r4jW1Xn2MDjqcSy3b884x6yDJK3k+Njn2jC+FgZ9jIxivHy+xbABTlIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L+9MtDJZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41F47C4CEE2;
	Sun, 26 Jan 2025 15:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737903938;
	bh=Ln1lZLHF9R6eQm2Js1Wm5kbeOdYIaJ8l0Y3234tRiJ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L+9MtDJZcd6yWZScFCqycRhqtcRZS60N/FEJvj+V/zR99grEzBQ3rDnH0hoAM1rbn
	 SY8JrZFdHC13vQD/Cot3kjfnenmKSjyG4KyfX9dKnsNjh7ZnNiY3+kIEPZYttoI7QF
	 hKvv8XBghoZ6Jpljf8Hn5jLjcs1RC1kMT4YgPD7ahHGPKf+JIFNpQqSBU1ZQlzLw/b
	 VLgJ2vm9z6B+WIath4BqCYnZUHRq8NemxzuNxWPE8QfF7XPlayZDDtZYssYqgFZqXG
	 ucNyekxjdOqAMpUAzpB+JTjRlb5t4ctLqsGkNkvvRgbgrQNLyIIMEqT/JiXQMeio3T
	 2PofwlfGrxsrA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hans de Goede <hdegoede@redhat.com>,
	Andy Shevchenko <andy@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	ptyser@xes-inc.com
Subject: [PATCH AUTOSEL 5.4 5/7] mfd: lpc_ich: Add another Gemini Lake ISA bridge PCI device-id
Date: Sun, 26 Jan 2025 10:05:25 -0500
Message-Id: <20250126150527.960265-5-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250126150527.960265-1-sashal@kernel.org>
References: <20250126150527.960265-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.289
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
index 3bbb29a7e7a57..d5a3c1923c0af 100644
--- a/drivers/mfd/lpc_ich.c
+++ b/drivers/mfd/lpc_ich.c
@@ -685,8 +685,9 @@ static const struct pci_device_id lpc_ich_ids[] = {
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


