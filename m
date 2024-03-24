Return-Path: <stable+bounces-32102-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D27A889E2F
	for <lists+stable@lfdr.de>; Mon, 25 Mar 2024 13:03:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C13681F373D3
	for <lists+stable@lfdr.de>; Mon, 25 Mar 2024 12:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33C3E3D3AF7;
	Mon, 25 Mar 2024 03:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sfe4jBWR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5DB7184435;
	Sun, 24 Mar 2024 23:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324275; cv=none; b=P2DroZEzLg3zQsDzDKs63RQEyFU4l21PkHCUzS7BFTxeJ6PJiQC6mZUiwZbSr22WlFcShgG6b30eSwPMasOVUCSCH1G2GntTKQYI5Xg3769tmMm/ZHMrpPkrF5oKSB8lO8OWHAFaDK/eGUYmmI5gJr5/6adu5WP9Jq+exgYnCbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324275; c=relaxed/simple;
	bh=PiF46aRx2uACoNISWlyOPAv5iPvh0dEnjtRpiyJfEoA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qt3zEMrjLdlSycd1yhgzKS3WtaZhnKrOjOEnWvjnMTzphMCTsSKY/ooY54AN9cjoyT3uHcMrIDbIYTNvdhmlBiqD4aDfZhHRNM3NE0HXsEOly9f8R7q4qRxfWmow4MA4F/go5vVIj1nM0yeSbUB24lkPKuzMAIKlwL4tRhUqC54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sfe4jBWR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16A1FC43399;
	Sun, 24 Mar 2024 23:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324274;
	bh=PiF46aRx2uACoNISWlyOPAv5iPvh0dEnjtRpiyJfEoA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Sfe4jBWRtrUaCLs5icVkNQCUoM6d3iB10j4qY9uQ2zeQT/uPSXH4yzrl+fBpNcw3z
	 oNKxoJrFsgOEam11pyxoIWK7n2uQZXBtnedVVEUeWN/D5vbTdWcy6J0Rm7Q8BTJz4C
	 Su3u8n4E5rIyazAdXTI/w+sH5wwgGet3dVk0VM79ulxqF4jTCYi8dWZR5qPuHAIK40
	 IvzlJrcRrJYJ3g5Vg7d6mo5zqnAUNrrR2MaPUyk1x5f/lb49lcdf8Taj6zbqMUL6/3
	 0TI1IjorTb3tOHH2an+oZRmATesUwiPIloAPjXuQYZztp5wpz1k3NilT8DiOj2hTUD
	 7mCgU7//q0/Xw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 053/148] Bluetooth: hci_core: Fix possible buffer overflow
Date: Sun, 24 Mar 2024 19:48:37 -0400
Message-ID: <20240324235012.1356413-54-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324235012.1356413-1-sashal@kernel.org>
References: <20240324235012.1356413-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

[ Upstream commit 81137162bfaa7278785b24c1fd2e9e74f082e8e4 ]

struct hci_dev_info has a fixed size name[8] field so in the event that
hdev->name is bigger than that strcpy would attempt to write past its
size, so this fixes this problem by switching to use strscpy.

Fixes: dcda165706b9 ("Bluetooth: hci_core: Fix build warnings")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bluetooth/hci_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index f455a503f5b04..47f1eec0eb35f 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2074,7 +2074,7 @@ int hci_get_dev_info(void __user *arg)
 	else
 		flags = hdev->flags;
 
-	strcpy(di.name, hdev->name);
+	strscpy(di.name, hdev->name, sizeof(di.name));
 	di.bdaddr   = hdev->bdaddr;
 	di.type     = (hdev->bus & 0x0f) | ((hdev->dev_type & 0x03) << 4);
 	di.flags    = flags;
-- 
2.43.0


