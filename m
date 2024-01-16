Return-Path: <stable+bounces-11459-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CAF582F6FC
	for <lists+stable@lfdr.de>; Tue, 16 Jan 2024 21:13:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C88A5284516
	for <lists+stable@lfdr.de>; Tue, 16 Jan 2024 20:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BF9864CEE;
	Tue, 16 Jan 2024 19:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gm2DpFUa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC8E464CE9;
	Tue, 16 Jan 2024 19:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705434406; cv=none; b=BjlVlp8WfZMhsqxFJSw1OLFSY+J4K05eB0SSuIyhUyxyDG6i9pAiGSRCAmryHURh1YTZqYXwRULUCOx4RZLgX/YSPEAEZQ9Amgq9fMJSNOXZMeL2rzh3qzKtmKZAVFtVrP3LTGXKRjVIvWPFAZzAmmuVyg18T0lO8UJKm6Owvj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705434406; c=relaxed/simple;
	bh=ggmqyt6RU0MPGhss12KUx3QDeAH4sqmDgbDTps+8gHY=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=E7g56S2KG1iO1ngBEpCDZ7BJ8HcYBT2Jr6Ysmlj3bZl+1iGeFiGrvYvIgb/bsqZdDds6KV2sGdv0sCSIqwOViTJ81zg+1donh8VkAbxVXW8af0jb2+Jzuq4ZvIpTrxd94eij3hwHTWnrX+lA/4MOFNgZAiqe4aj697IrSkNQ2LE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gm2DpFUa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45C19C433A6;
	Tue, 16 Jan 2024 19:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705434406;
	bh=ggmqyt6RU0MPGhss12KUx3QDeAH4sqmDgbDTps+8gHY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Gm2DpFUaM62iWpSeFYdZvszNtSV1D0v2A5go35BKtmaZTvszV78ky/0BOZ2ohMOJj
	 T2vlDOqVCZVdlsIu5JUcy+1PzUtGufxsmdGhS8kuDJ3RyWEs8ieo02hOt+MUr8OMeB
	 M1rpnDv2e+HS2zoCwIZPqzANcA2vnxFU8s6dWgfIQNAtIB0pJzaKq4FaD44kNDn9ch
	 diX5EFmK2rmQyUaOMPR3t/ZeNM/lEDml0qaHjzK8QPfaonxhUdUM9zWTqlbhrZRoW+
	 Qzz434AOm4CF4X69D3xw9CTTAxr2KQApXKtNEwHtO8PkQd983XOp1SdGL2b4EVYjMR
	 MV3sOWgCoi1Uw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: clancy shang <clancy.shang@quectel.com>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	marcel@holtmann.org,
	johan.hedberg@gmail.com,
	luiz.dentz@gmail.com,
	linux-bluetooth@vger.kernel.org
Subject: [PATCH AUTOSEL 6.7 098/108] Bluetooth: hci_sync: fix BR/EDR wakeup bug
Date: Tue, 16 Jan 2024 14:40:04 -0500
Message-ID: <20240116194225.250921-98-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116194225.250921-1-sashal@kernel.org>
References: <20240116194225.250921-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7
Content-Transfer-Encoding: 8bit

From: clancy shang <clancy.shang@quectel.com>

[ Upstream commit d4b70ba1eab450eff9c5ef536f07c01d424b7eda ]

when Bluetooth set the event mask and enter suspend, the controller
has hci mode change event coming, it cause controller can not enter
sleep mode. so it should to set the hci mode change event mask before
enter suspend.

Signed-off-by: clancy shang <clancy.shang@quectel.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bluetooth/hci_sync.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index d85a7091a116..97284d9b2a2e 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -3800,12 +3800,14 @@ static int hci_set_event_mask_sync(struct hci_dev *hdev)
 	if (lmp_bredr_capable(hdev)) {
 		events[4] |= 0x01; /* Flow Specification Complete */
 
-		/* Don't set Disconnect Complete when suspended as that
-		 * would wakeup the host when disconnecting due to
-		 * suspend.
+		/* Don't set Disconnect Complete and mode change when
+		 * suspended as that would wakeup the host when disconnecting
+		 * due to suspend.
 		 */
-		if (hdev->suspended)
+		if (hdev->suspended) {
 			events[0] &= 0xef;
+			events[2] &= 0xf7;
+		}
 	} else {
 		/* Use a different default for LE-only devices */
 		memset(events, 0, sizeof(events));
-- 
2.43.0


