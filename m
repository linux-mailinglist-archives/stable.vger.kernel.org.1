Return-Path: <stable+bounces-110672-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C5A39A1CB25
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 16:40:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B9A918877F1
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 15:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3F4C21A429;
	Sun, 26 Jan 2025 15:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KOkP+/kP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E71219A8E;
	Sun, 26 Jan 2025 15:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737903808; cv=none; b=ZKh/vBs3uyt01sQalmOq5VivtaKVfjpxvFo2B110L5JYX+/FcUzj/1NlQUqPHZvPuQywt3kyXsVqXihvsC0JAAP8BeQKz5ANNT+c3sRn7FFiyVS1NBK/cw6komD6mAYrd4gNODeXYur4v1gBiTwxj9PSZB0AfA1Zw+Um3v+2V8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737903808; c=relaxed/simple;
	bh=S+TT1a07YLwKpDsU9KvkyTpwGHYmBWYne8Em3eS41Tg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MfknhmpPACju9bchfXeNR9MhJMOYlNvo8srKYlvxWGKZdaFv0BWFDiW21j/nQdGYoA5vW6gJXOVmj+9+3ebbP2hrb4r+5ckjWvjmSnWEB4TfmF9el4EEAvG5OSEGWYmYf3xRgsO5q2GSLwImPnpNgTB/ZEj2Q3KkkU0OTTT191s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KOkP+/kP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1D39C4CEE2;
	Sun, 26 Jan 2025 15:03:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737903808;
	bh=S+TT1a07YLwKpDsU9KvkyTpwGHYmBWYne8Em3eS41Tg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KOkP+/kPyIxGVNaIBN11A1N97F4kmNLKyyekFoBwxTt18G579HlGhhUpji3JiGbxm
	 0I9QwNtJdSKf9yt/jwV29MtGeJWDiWAeEYOZkxXumWAivTPTaBCfp8qfXa5Joy+uMk
	 T3Ly+5DKD0P3RFyPhUQg4Yo8GeHlykNbXjYmz5OzxvCOfUqjb4a4P6J4Bnb5W6D0KN
	 qUm5RyljctbzuCONqoNK14XAMAE5fHkCXyv6E2AfWw9J4nQmMIfHeUdf7iQnp41rbg
	 mq3DeCgbqP6j9gddRu4wndqW0CULKOpV4UKQsuBhEifqDL0+eaeff0jXhrsntOzX1r
	 FHuOS5ZgHsQXQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hans de Goede <hdegoede@redhat.com>,
	Andy Shevchenko <andy@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	ptyser@xes-inc.com
Subject: [PATCH AUTOSEL 6.6 07/19] mfd: lpc_ich: Add another Gemini Lake ISA bridge PCI device-id
Date: Sun, 26 Jan 2025 10:03:02 -0500
Message-Id: <20250126150315.956795-7-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250126150315.956795-1-sashal@kernel.org>
References: <20250126150315.956795-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.74
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
index 7b1c597b6879f..03367fcac42a7 100644
--- a/drivers/mfd/lpc_ich.c
+++ b/drivers/mfd/lpc_ich.c
@@ -756,8 +756,9 @@ static const struct pci_device_id lpc_ich_ids[] = {
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


