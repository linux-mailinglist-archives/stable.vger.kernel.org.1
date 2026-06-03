Return-Path: <stable+bounces-259958-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 04GGEU2/H2papQAAu9opvQ
	(envelope-from <stable+bounces-259958-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 03 Jun 2026 07:44:45 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C9703634562
	for <lists+stable@lfdr.de>; Wed, 03 Jun 2026 07:44:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=163.com header.s=s110527 header.b=g5CqnB5L;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-259958-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-259958-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=163.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1AC6D302E332
	for <lists+stable@lfdr.de>; Wed,  3 Jun 2026 05:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2630E3C8194;
	Wed,  3 Jun 2026 05:44:42 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4393E397E66;
	Wed,  3 Jun 2026 05:44:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780465481; cv=none; b=r+EeKUnWuazMlf7eD6XcYeJzII7q8QPeUhbUuXVQhm08suSmRN0fZhzHXjC/mlvmSW8YfzbQX+ajhngNAWdSV++DW4Dc1UYPn5VoyC+/EZyIrNqzCSSlxHabjfZh0uHUKQ8XVf4XpsqW5pPAQ0zm5yqzmRlqfrcxt4lCi5ZBfNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780465481; c=relaxed/simple;
	bh=vUPL9K3F2KOWZdXcbk6XWgfMCN5CXdC9BgspglKT3EM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PMKJglFDBAJWFD0YvtSOcL0Ocb/0Q4DaF4lv4HhkGVpe1edk2dtxrmk6naaV4+51bvIn0JlmY4Q9rSnb7F5qsLEI/5X+A5I+r73PH/zBIuPfaWMAMF7+qV8yLgoFl4igNxzAexSoMZpFMSsup+4+xYG9NCiS9m2BacRJg9nxCsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=g5CqnB5L; arc=none smtp.client-ip=117.135.210.4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=pi
	hnl6tV+07np2KM1vmM3V8vLITKZD8jA2XkqjVBMIU=; b=g5CqnB5LpCy7yqpFgy
	GWWCIHVRolVNf6fZhghsD4hvRt4cWtxvvI4h4UdK458ZI064lWAljvyKVrLG2zkt
	gNjkmaX2cyRG/Id4dy/QP1EklVNo0dQwlt8nQjP6iFxt1UTEaHCGDx5q6Fv7Kook
	W47zM0vVkMubRqrY11dRjpSdE=
Received: from China-163-team (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgB3Mv8qvx9qObnJAA--.25958S2;
	Wed, 03 Jun 2026 13:44:13 +0800 (CST)
From: Wenshan Lan <jetlan9@163.com>
To: gregkh@linuxfoundation.org,
	sashal@kernel.org,
	stable@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Lee Jones <lee@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Wenshan Lan <jetlan9@163.com>
Subject: [PATCH 6.12.y] HID: core: Mitigate potential OOB by removing bogus memset()
Date: Wed,  3 Jun 2026 13:43:44 +0800
Message-ID: <20260603054344.80160-1-jetlan9@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PSgvCgB3Mv8qvx9qObnJAA--.25958S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Ar17ZF43Wr13Xr17ur4xCrg_yoW8Ww13pF
	ZIyFs0kryqqa4kCw47GF4xZa45tas5JFy2gFW7Gw4rZw1Yka4UJr1Ivayavrs8urWIyr97
	CF4qyas8GF1jvaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pEeT59UUUUU=
X-CM-SenderInfo: xmhwztjqz6il2tof0z/xtbCxA1dJmofvy0YfgAA3z
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,163.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259958-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[jetlan9@163.com,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:gregkh@linuxfoundation.org,m:sashal@kernel.org,m:stable@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:lee@kernel.org,m:bentiss@kernel.org,m:jetlan9@163.com,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C9703634562

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
[ Replace hid_warn_ratelimited() with hid_warn() in v6.12. ]
Signed-off-by: Wenshan Lan <jetlan9@163.com>
---
 drivers/hid/hid-core.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 294a25330ed0..6d61bf20ec3f 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -2029,9 +2029,10 @@ int hid_report_raw_event(struct hid_device *hid, enum hid_report_type type, u8 *
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


