Return-Path: <stable+bounces-274237-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6oalAEU6VmpG1wAAu9opvQ
	(envelope-from <stable+bounces-274237-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 15:31:49 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A2F1755280
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 15:31:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=JcLsElDU;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-274237-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-274237-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2CA453056F2E
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 13:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41B1D320A00;
	Tue, 14 Jul 2026 13:26:54 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 142342BEC23
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 13:26:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784035614; cv=none; b=CLKO03sqS0rKqjwVL+yu76de12dLm1KgQJ/wt2qZ4eP3SfkJCpik1vXgeWS3K/nkjPnCY3pHtYOFN/W91K7dQU63XM4efevNSFh8P098la+SlDUasNQFBSUcQb7yf+Zxaum/17Bu6Pv5bUgyTqcmCPQ9yOcDbWpdgu2z1s9tp0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784035614; c=relaxed/simple;
	bh=UmcvbKMXZBKtr/70K2aFTPQQ4an2RvyDVGPcypOzLPI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s1PN1y+S/5EKvirFxXAt3FLAWdbLkE5EcrL7Y0pcQb/FDGLxjFN3P1OzBqwjjpGHPaNs53GAPOoRQyBYpChrVn12CCctYD75SGsKLBlHqciR7koy6zi2/YAN5TTSlZCkuOkLlLYd30UFsmpqTv0zGgDCt35fedkbIybnu4OjI6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JcLsElDU; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4980B1F000E9;
	Tue, 14 Jul 2026 13:26:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784035612;
	bh=0FolU50PUQYoKq2eoRAz6snyE5uNhUgpusbIJoC8Opg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JcLsElDUwXzUeZtGXc+yOvpvyobwpYZsrFtiOUKyIb7+71HiHweF02BfKWc9aLZRC
	 WyjG6vpdA0oAV9D0unFx3SHC4CWQGK+CFhS7xrrOulY1M3FFjS5gXlS7pza3+dhC9+
	 4Dxo7tpBklZbIXP1MhgHIBlGgMWXkxOYQr2+RpjN+24W2lPuwRhAOOK1Ax7b2jMDcl
	 HxkZdMipanqMu3LJ01ZIyP2owktqShSvFF0SWae7DrILDo94X9gW9+srOGPKKhXvuB
	 UV8H0rRZbvr1pbPXjJ0rm2IkCg59RvzYtAIUJVXvmps/SOLQjxaRcQgpm9Y8BV7c5t
	 Ud4yZdB9uj3Ew==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Kiran K <kiran.k@intel.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/4] Bluetooth: btintel: Fix offset calculation boot address parameter
Date: Tue, 14 Jul 2026 09:26:47 -0400
Message-ID: <20260714132650.2663656-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071309-contempt-purposely-3c5c@gregkh>
References: <2026071309-contempt-purposely-3c5c@gregkh>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:kiran.k@intel.com,m:marcel@holtmann.org,m:sashal@kernel.org,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-274237-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,holtmann.org:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7A2F1755280

From: Kiran K <kiran.k@intel.com>

[ Upstream commit d00745da644d42c2f97293eb3fe19cfd5c0b073c ]

Boot address parameter was not getting updated properly
due to wrong offset

Signed-off-by: Kiran K <kiran.k@intel.com>
Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Stable-dep-of: c5b600a3c05b ("Bluetooth: btusb: fix use-after-free on marvell probe failure")
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


