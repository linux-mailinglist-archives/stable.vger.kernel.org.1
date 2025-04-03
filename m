Return-Path: <stable+bounces-127859-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B2D6A7AC7A
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 21:42:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A542188EE99
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 19:39:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A2EA27BF9A;
	Thu,  3 Apr 2025 19:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qwgUy2lG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51AFF2580F0;
	Thu,  3 Apr 2025 19:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743707256; cv=none; b=asuF7FaokO5fK2+Kp361l6pejZfqNkMGl07zSkFOe79yRwAAm1imLmKdAuhBPbpphzDvTM0TNFk6qhBOpZWeNy6TwX6UaapUC1LcsjZpwoecTM/GRhuuf3KDCl9Uke7UckM+O61u1lbWeOMVewxiXkzGspDYbSXUJj5hhx3EGA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743707256; c=relaxed/simple;
	bh=Kl9ppF1QSBXusOfJOzuBGCWn7GSZsqZaGeSpGAHc+HU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ghXhOpiTJTxtXk4wSvD2/s+zQZA0aCn6aLfDcDIYMnrIIUgFJ4xozn+SpKw1NuvaIO4wuWiu4NC1SKUdfvA7azE1HshLLg+6H061eDhO904xQaNFH/6X/DlX7mBHfsv+MbgE3ScELf9ty8Z1imY3kjtCy5bPJ4qcAL3axhGAlKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qwgUy2lG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E343C4CEEE;
	Thu,  3 Apr 2025 19:07:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743707256;
	bh=Kl9ppF1QSBXusOfJOzuBGCWn7GSZsqZaGeSpGAHc+HU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qwgUy2lGyoGYp692uMdQTgwSh2RZ3/iwbWP49/QbW8kXbMrTMHmjUQvFRy7U7A1Ie
	 bSNHBnmhAsRxy5EmgeReqPt/kigfxCYsYXKkEv4pAr5YV2FdCGgTuV/P1IbkF4iAWQ
	 Y1cSyzGTcd7JwPOMJgEoT7iaZzpJ9H4eIG4LCayjPv4am51uPsMl0ZSqUgEd7MknIH
	 TXqAHWYf10yO0BKXmOGrsn7E96rc8CQNG+cx4PMIGZmZtzwTWwDywpHaTqrMbUoGW/
	 kfbpzWRmQfaNasaxOkXaVXyaL1AvER/Ew3enFUyrJcjQYLr464/yTPufXzRKlnwiul
	 BRCOdsgh+tFoQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Arseniy Krasnov <avkrasnov@salutedevices.com>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	marcel@holtmann.org,
	luiz.dentz@gmail.com,
	linux-bluetooth@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 42/47] Bluetooth: hci_uart: fix race during initialization
Date: Thu,  3 Apr 2025 15:05:50 -0400
Message-Id: <20250403190555.2677001-42-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250403190555.2677001-1-sashal@kernel.org>
References: <20250403190555.2677001-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.21
Content-Transfer-Encoding: 8bit

From: Arseniy Krasnov <avkrasnov@salutedevices.com>

[ Upstream commit 366ceff495f902182d42b6f41525c2474caf3f9a ]

'hci_register_dev()' calls power up function, which is executed by
kworker - 'hci_power_on()'. This function does access to bluetooth chip
using callbacks from 'hci_ldisc.c', for example 'hci_uart_send_frame()'.
Now 'hci_uart_send_frame()' checks 'HCI_UART_PROTO_READY' bit set, and
if not - it fails. Problem is that 'HCI_UART_PROTO_READY' is set after
'hci_register_dev()', and there is tiny chance that 'hci_power_on()' will
be executed before setting this bit. In that case HCI init logic fails.

Patch moves setting of 'HCI_UART_PROTO_READY' before calling function
'hci_uart_register_dev()'.

Signed-off-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/bluetooth/hci_ldisc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index 395d66e32a2ea..2651e2e33f2a1 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -707,12 +707,13 @@ static int hci_uart_set_proto(struct hci_uart *hu, int id)
 
 	hu->proto = p;
 
+	set_bit(HCI_UART_PROTO_READY, &hu->flags);
+
 	err = hci_uart_register_dev(hu);
 	if (err) {
 		return err;
 	}
 
-	set_bit(HCI_UART_PROTO_READY, &hu->flags);
 	return 0;
 }
 
-- 
2.39.5


