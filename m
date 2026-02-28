Return-Path: <stable+bounces-220400-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EPKrC0o0o2mX+QQAu9opvQ
	(envelope-from <stable+bounces-220400-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:30:34 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B5271C5E10
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:30:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3537033B0F08
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C12CB3AC608;
	Sat, 28 Feb 2026 17:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QnH1Ot3A"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F673AC600;
	Sat, 28 Feb 2026 17:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300292; cv=none; b=p4mN08bprZ/hgGKXsClEiDrF1Ni29UMEjcBmwwRtl8VXpAXDVJQN9bmoytbfTApSWy4pjW7E1jhUmfhLz4PjIiO7Ak4k+PEqDMoaOYtoo20rZKv/GxqNVxv/1OkP9Zlef4j2CvFS4dw7pH3WymnL+2JobI8LkiBztLjBSudUiVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300292; c=relaxed/simple;
	bh=Fuk0VkTbDtCRNIW9UwQry52EKbge60CQXU3QbaxKbjE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e4YHI3tugh5FwsCvgegovgfnoFzT7UR+51s5JJygz5jgVFoyBkiocY1RCsjbbwleIu5Ej25vIAdSF/bP1LVRdQCjb5SQxNjF5BEI/EpzwTZBKTtPTfR6GCfay9XbvStvDwyhirRLstwwtq5Qp0FOUUjXJQbJzeqBkC+KdMmBW2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QnH1Ot3A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 888BFC19423;
	Sat, 28 Feb 2026 17:38:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300292;
	bh=Fuk0VkTbDtCRNIW9UwQry52EKbge60CQXU3QbaxKbjE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QnH1Ot3AXU0KcLWUygNhgFpcg7bB88VlJRDdp0wk0JQ1U5I1iMKA4+0XVbMp4Noxo
	 3eDIJuRg3CPSTFpy00Jibwt2h266UWYcADh4oAMLaBo2Us+rYoFsH1PugL0wjnlW6a
	 DnbqLjuXlCTPFgtW3PGV+ZXt0LYFHGcm153dKjh75mLjDhBVSIxb1DBcbadhJLQMU7
	 VloUQ0sZ5NBpZBrmCgzMZEkfRfXrU6023BTvK/g/QfmxDPciZ2rr36+U5EWI/NgtSW
	 ID2w6w1xDAujk7UkDcXoqsnQ8Cte0jxKYqySKUl3igqNDZlcOHMbNF3nnE9XqVbpa0
	 S2vB1kLyYE91Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jacopo Scannella <code@charlie.cat>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 321/844] Bluetooth: btusb: Add device ID for Realtek RTL8761BU
Date: Sat, 28 Feb 2026 12:23:54 -0500
Message-ID: <20260228173244.1509663-322-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-220400-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 9B5271C5E10
X-Rspamd-Action: no action

From: Jacopo Scannella <code@charlie.cat>

[ Upstream commit cc6383d4f0cf6127c0552f94cae517a06ccc6b17 ]

Add USB device ID 0x2c0a:0x8761 to the btusb driver fo the Realtek
RTL8761BU Bluetooth adapter.

Reference:
https://www.startech.com/en-us/networking-io/av53c1-usb-bluetooth

Signed-off-by: Jacopo Scannella <code@charlie.cat>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/bluetooth/btusb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index f177569978d36..a41bb1e2a279a 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -781,6 +781,7 @@ static const struct usb_device_id quirks_table[] = {
 
 	/* Additional Realtek 8723BU Bluetooth devices */
 	{ USB_DEVICE(0x7392, 0xa611), .driver_info = BTUSB_REALTEK },
+	{ USB_DEVICE(0x2c0a, 0x8761), .driver_info = BTUSB_REALTEK },
 
 	/* Additional Realtek 8723DE Bluetooth devices */
 	{ USB_DEVICE(0x0bda, 0xb009), .driver_info = BTUSB_REALTEK },
-- 
2.51.0


