Return-Path: <stable+bounces-127889-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 58CDEA7ACE2
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 21:52:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 159031892701
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 19:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BEAD2857CD;
	Thu,  3 Apr 2025 19:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="le5ud1b1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B112857C2;
	Thu,  3 Apr 2025 19:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743707323; cv=none; b=PrEscr7K1I+Sk1OYYH0kgZVyqKAVisigG4fYEAlb6kFaOyr2Zi+3UCvNZ1eTR0lxNihF/qjfBocEUG1xm4pAFUOAzoazXa5rB/+NrEcp7Nmn556wRdUM4SOZtCsdYk+ssALDBCV0NfI6zcdUSpJmOSEbO5wTwX3j/aaTG8iuM5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743707323; c=relaxed/simple;
	bh=B6oIAl7BBkL26Kg0NLgwIVaWGxKSSfchm2eaYhaefKA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=E2BK0zNRZCsQ9ZAbu1yltFSI5gy7nzS7GEiOceJhuVqhZFV3n9cbqBmc98esHTUS/fFZQ2My/Pf+kiDsWThOWDbXhVMU5wiKyUh7GVy+8iNNULP4DAH2PXLAzbiIKNH+fI0xtEZd6RrSMGLNrMx5V7MyRJ/dYDA3OjZpsv7oT+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=le5ud1b1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E99B3C4CEE3;
	Thu,  3 Apr 2025 19:08:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743707322;
	bh=B6oIAl7BBkL26Kg0NLgwIVaWGxKSSfchm2eaYhaefKA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=le5ud1b1xN/UKZ7m3SZgUeo0pSpiM5bZ25hV+XyFZpVrgT/GkZHjHnPg+Eexg3YJB
	 icqVrh/71LS+bIoOZYW4PMkE2izb2kM9GiAWaP1kTKbTAtj5Nl8RlIhzRzdToSalXI
	 8U6tTkEcA73kcZnwz7mg0Go+FuiQK75Gn1ckC++ZZ9a/MoAQgUba6LLVydUwSs4WaR
	 5MEQdEMbF8UjWPUsgWNkQ6a81zXpC9VAYg8I9yqZS1q8cvPMDgUOEbicyLV2Ddqh8o
	 TdQdVTdBITKB/ekmNLrMCXmGULP3BTCHMBIkgz3BDxfDbI4lGqtfdZzI87qQPOEiMo
	 cDSz93IfV4zKg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Arseniy Krasnov <avkrasnov@salutedevices.com>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	marcel@holtmann.org,
	luiz.dentz@gmail.com,
	linux-bluetooth@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 25/26] Bluetooth: hci_uart: fix race during initialization
Date: Thu,  3 Apr 2025 15:07:44 -0400
Message-Id: <20250403190745.2677620-25-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250403190745.2677620-1-sashal@kernel.org>
References: <20250403190745.2677620-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.85
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
index 17a2f158a0dfa..b67023d69e03d 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -704,12 +704,13 @@ static int hci_uart_set_proto(struct hci_uart *hu, int id)
 
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


