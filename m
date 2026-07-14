Return-Path: <stable+bounces-274241-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2XOFBzk7Vmqg1wAAu9opvQ
	(envelope-from <stable+bounces-274241-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 15:35:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 971A0755375
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 15:35:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=T4f9uwks;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-274241-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-274241-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BF45B323AA2D
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 13:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5436729D270;
	Tue, 14 Jul 2026 13:27:01 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 113233191CE
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 13:27:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784035621; cv=none; b=t3MFVREDZ5dSJreAGh94mOqfq2agV4CGJFCbjAMVODm0L/B/8lF9TVOq//FyFGApwcIFGxhYlJh7uINdi1onis8+ZjsJLKng0n4gJ8Op61MCiISmXzYBnnMWEBHSeWeCc+Xx2Fyg3DU6n4F9MWpQsw/LwCQmzGp7XnVliKpcgs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784035621; c=relaxed/simple;
	bh=JiI38/QADHJWUXtPB3pwoD0Riu6wC80ED2azZwq5tlk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tSDD8I9AfGM3XYTNz7OWhWIFvO28uFfcJkp0u4HDanY5NX/VQZRrYdsLTOdgQdz+tC+83uvgunuaoRIRVdK0TFlu6XffFHB1A/ioT3DP71ItxTNKt7UmFrnuBKhf05uP4ye8ADw7dLJjtTLIxG+c2EZilS9whWbttPqWR7w04W4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T4f9uwks; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74AFE1F000E9;
	Tue, 14 Jul 2026 13:26:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784035620;
	bh=PrFDd1nmGNylw05wT6IgACIk9Z/IryVWQZtl7nJOS2o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=T4f9uwksIwzkzwt8D9TjnmaVxjGM+LPNVgaWqtAj7vORIY0kv4cVuK6vKoFSP+j9M
	 In0hIiBbjYNzxk1ju2axG8xDYTQ1skPaG68SyDJsJHHGCsJYuNByE0C2dHq1aLU9bq
	 IQL/9pM0BBt754YUvknjElyNWMq9b6a7nLLT5hLcpvN8dyClQMZRdBusXv3OfK0iYw
	 uaFytF40/OKVdYmSwItzWj+fKRMDyXT0KtzHsksgz1LQkJgvKZkL0tQgHWYNFpttKg
	 vNFDzQCsk4YNqg3CFOr6R2ma1GL5cHLGpyBksBWTDS/XVTYdYVgV4tv9My4OKiDlVf
	 efyjQ77x/zeBA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Kiran K <kiran.k@intel.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/5] Bluetooth: btintel: Fix offset calculation boot address parameter
Date: Tue, 14 Jul 2026 09:26:53 -0400
Message-ID: <20260714132657.2663805-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071341-glamorous-shower-90f7@gregkh>
References: <2026071341-glamorous-shower-90f7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:kiran.k@intel.com,m:marcel@holtmann.org,m:sashal@kernel.org,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-274241-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,intel.com:email,holtmann.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 971A0755375

From: Kiran K <kiran.k@intel.com>

[ Upstream commit d00745da644d42c2f97293eb3fe19cfd5c0b073c ]

Boot address parameter was not getting updated properly
due to wrong offset

Signed-off-by: Kiran K <kiran.k@intel.com>
Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Stable-dep-of: 3d93e1bb0fb8 ("Bluetooth: btusb: fix wakeup source leak on probe failure")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/bluetooth/btintel.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index 2538bdee31d8ab..a7efbadc3d146e 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -863,7 +863,8 @@ static int btintel_download_firmware_payload(struct hci_dev *hdev,
 			/* The boot parameter is the first 32-bit value
 			 * and rest of 3 octets are reserved.
 			 */
-			*boot_param = get_unaligned_le32(fw_ptr + sizeof(*cmd));
+			*boot_param = get_unaligned_le32(fw_ptr + frag_len +
+							 sizeof(*cmd));
 
 			bt_dev_dbg(hdev, "boot_param=0x%x", *boot_param);
 		}
-- 
2.53.0


