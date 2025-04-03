Return-Path: <stable+bounces-127908-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39FDDA7AD29
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 21:58:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36486174EF8
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 19:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45022298CA2;
	Thu,  3 Apr 2025 19:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZD4JE/A+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D0325A2CC;
	Thu,  3 Apr 2025 19:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743707363; cv=none; b=UHd5u8A0a+GM+2EN3aGBIWn+2bnEJY9PPFkB1P3l7hJvTnS0VSmfINy0pD9LGg5YOalg1sx1mtC8aB94lkY94snvrBZJlqNBTd4fe1xpvV1zj3skq1IAQqqHXq0ONymkfYSiiHJNBuOwwpFrkXHuKThM1X6swv/DRgD9ZERBsQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743707363; c=relaxed/simple;
	bh=pmaZgZv8/hRPjXGZbgmIZePUKUMbqNqd1OhY3lO6rjM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uOMIMnhOZNBZanga49Yickj+9BXOjlhpaD/iqRt8mz0sF3hxclnscY5sbow+DPhPnQPti8b//yhT1lLTp9FWpHao/YIjhlI8AS6cTmCvkdzam5vlYrDndzeMfHccDkXlmLILEeyIlAw5ONZAARjyDVYhVRSbYQdjQOY9E/V7gWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZD4JE/A+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D47A8C4CEEB;
	Thu,  3 Apr 2025 19:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743707362;
	bh=pmaZgZv8/hRPjXGZbgmIZePUKUMbqNqd1OhY3lO6rjM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZD4JE/A+eBV0rJzbfSLX7g1pqPJtum7PS2nd74qb1dgg1tQWxyOT9HmBMuoSqQDvA
	 qKJXMrKAiddRI5tJJw2LfGQ3gIeosFKukAgIV5z1Q994Lkv04S8ZGjnkLA3mzpxNke
	 x7zsvivrIX82boIt2H9O9Orsp+5yB5KrAJeUD3ZGYGOt8H8lb956YPm4oj5cIVOoPc
	 znweYoEsihMHfKehVWn62Y9Ic17OVEnMB2qXqUoD4F18WUhXQoMBJCjftK+021S8/W
	 4EkjwZZv5QcpBWmUjcifBlgudtb4T+Cgm/F2irUjPSRpp1bOWq/DpE/RKNWSQphM1f
	 NnwFCbnUI5PAw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Arseniy Krasnov <avkrasnov@salutedevices.com>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	marcel@holtmann.org,
	luiz.dentz@gmail.com,
	linux-bluetooth@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 17/18] Bluetooth: hci_uart: fix race during initialization
Date: Thu,  3 Apr 2025 15:08:43 -0400
Message-Id: <20250403190845.2678025-17-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250403190845.2678025-1-sashal@kernel.org>
References: <20250403190845.2678025-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.132
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
index c1feebd9e3a03..5dc2f38c7b9a7 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -709,12 +709,13 @@ static int hci_uart_set_proto(struct hci_uart *hu, int id)
 
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


