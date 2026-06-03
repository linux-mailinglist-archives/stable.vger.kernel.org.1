Return-Path: <stable+bounces-259961-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8wYLEObAH2rVpQAAu9opvQ
	(envelope-from <stable+bounces-259961-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 03 Jun 2026 07:51:34 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 87640634674
	for <lists+stable@lfdr.de>; Wed, 03 Jun 2026 07:51:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=163.com header.s=s110527 header.b=a5HuuNaC;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-259961-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-259961-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=163.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 11879309D8AA
	for <lists+stable@lfdr.de>; Wed,  3 Jun 2026 05:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD78D3F58E9;
	Wed,  3 Jun 2026 05:45:26 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B203F4DE8;
	Wed,  3 Jun 2026 05:45:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780465526; cv=none; b=PjOKQLXtxNWo/tclxVotM+yxc3CRERtxWrgmjEZIeMb8sNdcTuuQd+WZEYkmU0caO9z9X9IcwX2cjTqBoscWbTB4HepzRfcSHGGP9keUoKj90GewiZuZC8zdo5gZQtLBs0vjHyqtD9fuIU53wTvayZZxKnwikgqEZ3baMdO0rR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780465526; c=relaxed/simple;
	bh=symSjm3ZH2GjANxazWpoRFwkex56H7dQd7H+OGcsrjE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rP+v4kM6OnYn1bqrXvDXP6+UEgKYtcgeCc4zHVwDhbr/Xp5VWQ5mKi5zaNFN2dcUpFdPO5uQouhlKZ0+rXR4pmzzqSgKUuR40H6kyxCoy+xDe1ogYh1qhC5acHwSuYEdMcSPaPNO5/Qm/b2Le+SZyD2DPYDMogNw4VVBXKNIiZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=a5HuuNaC; arc=none smtp.client-ip=220.197.31.3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Sl
	Mtt7KETj9h+My1HPIbLr4kKDAdAHWaVqHghhHynfI=; b=a5HuuNaC3o1oJzkz3T
	NoAsLLqxaL3WeCQQ3QwLOZ02F/Il0wb/FycYYI2nJ/7Fx9/8XgY/D3QDTjPWwI5N
	6HoRCLYRhzamNtE/mKNUNrQJ+498+R3iY78VhpMGcmwJmtOfhnXI+UPjUqWUKFbh
	5spjNn0ppbFD/H+EXLTN2VTQg=
Received: from China-163-team (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgAn9c9gvx9qjXfTAA--.26533S2;
	Wed, 03 Jun 2026 13:45:06 +0800 (CST)
From: Wenshan Lan <jetlan9@163.com>
To: gregkh@linuxfoundation.org,
	sashal@kernel.org,
	stable@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Lee Jones <lee@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Wenshan Lan <jetlan9@163.com>
Subject: [PATCH 5.15.y] HID: core: Mitigate potential OOB by removing bogus memset()
Date: Wed,  3 Jun 2026 13:45:02 +0800
Message-ID: <20260603054503.80261-1-jetlan9@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCgvCgAn9c9gvx9qjXfTAA--.26533S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Ar17ZF43Wr13Xr17ur4xCrg_yoW8Ww1rpF
	Z0kFs0kryqqry8Cw17KF47Za45t34kJF129FW7W34Fvr15Ka4UJr1IvayavrZ8ZrWIyr97
	CF4Dtwn8AF1jv3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pEVyxJUUUUU=
X-CM-SenderInfo: xmhwztjqz6il2tof0z/xtbC7ANqM2ofv2MU+gAA3x
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,163.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259961-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:gregkh@linuxfoundation.org,m:sashal@kernel.org,m:stable@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:lee@kernel.org,m:bentiss@kernel.org,m:jetlan9@163.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[jetlan9@163.com,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[163.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jetlan9@163.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[163.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 87640634674

From: Lee Jones <lee@kernel.org>

[ Upstream commit 0a3fe972a7cb1404f693d6f1711f32bc1d244b1c ]

The memset() in hid_report_raw_event() has the good intention of
clearing out bogus data by zeroing the area from the end of the incoming
data string to the assumed end of the buffer.  However, as we have
previously seen, doing so can easily result in OOB reads and writes in
the subsequent thread of execution.

The current suggestion from one of the HID maintainers is to remove the
memset() and simply return if the incoming event buffer size is not
large enough to fill the associated report.

Suggested-by Benjamin Tissoires <bentiss@kernel.org>

Signed-off-by: Lee Jones <lee@kernel.org>
[bentiss: changed the return value]
Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
[ Replace hid_warn_ratelimited() with hid_warn() in v5.15. ]
Signed-off-by: Wenshan Lan <jetlan9@163.com>
---
 drivers/hid/hid-core.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 4fb573ee31b2..2c2714fa988e 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1807,9 +1807,10 @@ int hid_report_raw_event(struct hid_device *hid, int type, u8 *data, u32 size,
 		rsize = max_buffer_size;
 
 	if (csize < rsize) {
-		dbg_hid("report %d is too short, (%d < %d)\n", report->id,
-				csize, rsize);
-		memset(cdata + csize, 0, rsize - csize);
+		hid_warn(hid, "Event data for report %d was too short (%d vs %d)\n",
+			 report->id, rsize, csize);
+		ret = -EINVAL;
+		goto out;
 	}
 
 	if ((hid->claimed & HID_CLAIMED_HIDDEV) && hid->hiddev_report_event)
-- 
2.43.0


