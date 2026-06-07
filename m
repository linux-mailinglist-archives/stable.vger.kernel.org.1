Return-Path: <stable+bounces-261360-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id JDjwNjxJJWqIGAIAu9opvQ
	(envelope-from <stable+bounces-261360-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:34:36 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 44D4864FCF2
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:34:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=NUgqgvX0;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-261360-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-261360-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A9F1E3005D2D
	for <lists+stable@lfdr.de>; Sun,  7 Jun 2026 10:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF2BC32AAA3;
	Sun,  7 Jun 2026 10:30:49 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E043290AD;
	Sun,  7 Jun 2026 10:30:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780828249; cv=none; b=O+1RQ+eRElyLSf7nvrrbEwYRmgCM/KLCR0mtm6M/BPabH3igc6z1KYKr2wlv/IjNJRUDkzIzFFiVZQu0CKFutbhgicBpqA+gJwgJRQTu4nwNP4ub3EzTQ3itZcf/aHVU2ZF/RTBrDCc4wc7HsabJZup72qjb+Pg68vrSCpPmHko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780828249; c=relaxed/simple;
	bh=06SYuUsHwRzeFoiLNBWzlJyWmV/4uKQl4IfR+n4wRl8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aSiqMvIBFhmgo/EdUAg4/DIQB6AimIRokkFVpndI3N0noesWQYSZbNOHKczBak3c0JMS+A3refXuAraefBXZ34+YTyTKhSG+vq2xGbIF3yLvYeftaOtyZP6VKV4ImkaeK6YjC4gvWhFxWL11Y81j+zZahhiOnB1NCLVqxYaOOx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NUgqgvX0; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B05191F00893;
	Sun,  7 Jun 2026 10:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780828248;
	bh=WYN/BLZ/u0HQvG8PXene2kbkEC3lT6YuMw90C+gmook=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NUgqgvX0LriR2i0XeZuHSKqwag2WpWn4fMyFqkFzjjmlvF7BaxZ8hOOeryIUO7/bb
	 GqCTja9/jpIsu8CCuvuDm+fHNO9uJMYbGcDEwJmkH195AiyXX4TIYIifLLI9Cxtw9Z
	 K8KKYvnD1OYy1pOIFnj2o736Vvt0Le9D5xKdVTiI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Shuai Zhang <shuai.zhang@oss.qualcomm.com>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Subject: [PATCH 6.18 134/315] Bluetooth: hci_qca: Use 100 ms SSR delay for rampatch and NVM loading
Date: Sun,  7 Jun 2026 11:58:41 +0200
Message-ID: <20260607095732.532086379@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260607095727.528828913@linuxfoundation.org>
References: <20260607095727.528828913@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-261360-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:dmitry.baryshkov@oss.qualcomm.com,m:shuai.zhang@oss.qualcomm.com,m:luiz.von.dentz@intel.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,linuxfoundation.org:from_mime,linuxfoundation.org:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 44D4864FCF2

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shuai Zhang <shuai.zhang@oss.qualcomm.com>

commit fa21e86caba2347e89eb65af926205a36a097c53 upstream.

When bt_en is pulled high by hardware, the host does not re-download
the firmware after SSR. The controller loads the rampatch and NVM
internally.

On HMT chip, the rampatch is ~264 KB and the NVM is ~9.4 KB. The
loading process takes approximately 70 ms. The previous 50 ms delay is
too short, causing the controller to not respond to the reset command
sent by the host, which leads to BT initialization failure:

 Bluetooth: hci0: QCA memdump Done, received 458752, total 458752
 Bluetooth: hci0: mem_dump_status: 2
 Bluetooth: hci0: Opcode 0x0c03 failed: -110

Increase the delay to 100 ms, which was confirmed as a safe value by
the controller, to ensure the controller has finished loading the
firmware before the host sends commands.

Steps to reproduce:
1. Trigger SSR and wait for SSR to complete:
   hcitool cmd 0x3f 0c 26
2. Run "bluetoothctl power on" and observe that BT fails to start.

Fixes: fce1a9244a0f ("Bluetooth: hci_qca: Fix SSR (SubSystem Restart) fail when BT_EN is pulled up by hw")
Cc: stable@vger.kernel.org
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Shuai Zhang <shuai.zhang@oss.qualcomm.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/bluetooth/hci_qca.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -1676,8 +1676,8 @@ static void qca_hw_error(struct hci_dev
 		mod_timer(&qca->tx_idle_timer, jiffies +
 				  msecs_to_jiffies(qca->tx_idle_delay));
 
-		/* Controller reset completion time is 50ms */
-		msleep(50);
+		/* Wait for the controller to load the rampatch and NVM. */
+		msleep(100);
 
 		clear_bit(QCA_SSR_TRIGGERED, &qca->flags);
 		clear_bit(QCA_IBS_DISABLED, &qca->flags);



