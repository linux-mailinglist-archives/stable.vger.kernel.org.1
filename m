Return-Path: <stable+bounces-213151-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qPLBAgdegWmdFwMAu9opvQ
	(envelope-from <stable+bounces-213151-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 03 Feb 2026 03:31:35 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E75ED3CA7
	for <lists+stable@lfdr.de>; Tue, 03 Feb 2026 03:31:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A12D73029267
	for <lists+stable@lfdr.de>; Tue,  3 Feb 2026 02:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E6E82FF153;
	Tue,  3 Feb 2026 02:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ZCus7Zlf"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CE4386348
	for <stable@vger.kernel.org>; Tue,  3 Feb 2026 02:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770085821; cv=none; b=qb45esYPbGXLuLHSwOd23U6NxMeZiQwVRxsHbIR+ojIoZzeHnTcV0QaEO3rzax4MnZRY8vZfs3Ug4sa2jipA/ugz9wIDVak2M1Eaci1YkzcKV2d83nSQONuzd1UyFPbYEbGG/5KqtjNAQwIyGKFMOwXOSQpL2WJxVL+gP1fVgVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770085821; c=relaxed/simple;
	bh=GAsdRMof4q9/VMO64ChMgl6M607PC2SR+hkG/NFrcy0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=g7I/Dem7MvALkXsb7ijSbaOYgM2jelkT2YjM7NZcnQ9CML2NBS5uxC0jeyhA0LNQouYgVlqggG5mkO3RbzDgZ5JdcPHS4vX2eHSi2VkCrEk9A6bjdD3hJ4V/lWnhAs1kW1/4c1Hdku+J/8v1rveKQFWyeJh2Pt8bLKlJbFBm6IU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=ZCus7Zlf; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=uZ
	fgqcSY93/VlhSTF1hI2859lJ+4DAW2ZUf8O+1y6Kc=; b=ZCus7ZlflZUKmx4hYR
	CF6CgB+uMEwDULA97kXWU2U7hgsmigCyb/liLJBNHkV3AKT/9ub090qzux4nCL0k
	GUDub3WLhv7CD9K6YrkiDeuUBzByngDYo7w920SL4KkNz8unVZdnUnEC0FPnQoe/
	Z2GdWwFTEqZhtBO3qqPH/qoDM=
Received: from ubuntu24.corp.ad.wrs.com (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wCn0lyHXYFp5+KlJw--.9853S4;
	Tue, 03 Feb 2026 10:29:33 +0800 (CST)
From: jetlan9@163.com
To: stable@vger.kernel.org
Cc: Rahul Rameshbabu <sergeantsagara@protonmail.com>,
	syzbot+3a0ebe8a52b89c63739d@syzkaller.appspotmail.com,
	Maxime Ripard <mripard@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Wenshan Lan <jetlan9@163.com>
Subject: [PATCH 5.10.y 1/2] HID: uclogic: Correct devm device reference for hidinput input_dev name
Date: Tue,  3 Feb 2026 02:29:24 +0000
Message-ID: <20260203022925.4133-1-jetlan9@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCn0lyHXYFp5+KlJw--.9853S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxXw1xZF4fXry8Cw1rXw4Utwb_yoW5GFWxpF
	WfGan5Kr47Krn2kr4qvay5Za4Yv393Gry5Way7Xw1rZw13ZFyxKr9ayr9Fqr98JrWvkFs0
	yF4SvF48Ka4UX37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zNZXrUUUUUU=
X-CM-SenderInfo: xmhwztjqz6il2tof0z/xtbCxA01-WmBXY38QwAA3G
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[protonmail.com,syzkaller.appspotmail.com,kernel.org,gmail.com,163.com];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-213151-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[163.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jetlan9@163.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[163.com:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable,3a0ebe8a52b89c63739d];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email,protonmail.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5E75ED3CA7
X-Rspamd-Action: no action

From: Rahul Rameshbabu <sergeantsagara@protonmail.com>

[ Upstream commit dd613a4e45f8d35f49a63a2064e5308fa5619e29 ]

Reference the HID device rather than the input device for the devm
allocation of the input_dev name. Referencing the input_dev would lead to a
use-after-free when the input_dev was unregistered and subsequently fires a
uevent that depends on the name. At the point of firing the uevent, the
name would be freed by devres management.

Use devm_kasprintf to simplify the logic for allocating memory and
formatting the input_dev name string.

Reported-by: syzbot+3a0ebe8a52b89c63739d@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/linux-input/ZOZIZCND+L0P1wJc@penguin/T/
Reported-by: Maxime Ripard <mripard@kernel.org>
Closes: https://lore.kernel.org/linux-input/ZOZIZCND+L0P1wJc@penguin/T/#m443f3dce92520f74b6cf6ffa8653f9c92643d4ae
Fixes: cce2dbdf258e ("HID: uclogic: name the input nodes based on their tool")
Suggested-by: Maxime Ripard <mripard@kernel.org>
Suggested-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Rahul Rameshbabu <sergeantsagara@protonmail.com>
Reviewed-by: Maxime Ripard <mripard@kernel.org>
Link: https://lore.kernel.org/r/20230824061308.222021-2-sergeantsagara@protonmail.com
Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
[ Adjust context ]
Signed-off-by: Wenshan Lan <jetlan9@163.com>
---
 drivers/hid/hid-uclogic-core.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/hid/hid-uclogic-core.c b/drivers/hid/hid-uclogic-core.c
index e4811d37ca77..02a3b2aa1bda 100644
--- a/drivers/hid/hid-uclogic-core.c
+++ b/drivers/hid/hid-uclogic-core.c
@@ -104,10 +104,8 @@ static int uclogic_input_configured(struct hid_device *hdev,
 {
 	struct uclogic_drvdata *drvdata = hid_get_drvdata(hdev);
 	struct uclogic_params *params = &drvdata->params;
-	char *name;
 	const char *suffix = NULL;
 	struct hid_field *field;
-	size_t len;
 
 	/* no report associated (HID_QUIRK_MULTI_INPUT not set) */
 	if (!hi->report)
@@ -145,14 +143,9 @@ static int uclogic_input_configured(struct hid_device *hdev,
 		break;
 	}
 
-	if (suffix) {
-		len = strlen(hdev->name) + 2 + strlen(suffix);
-		name = devm_kzalloc(&hi->input->dev, len, GFP_KERNEL);
-		if (name) {
-			snprintf(name, len, "%s %s", hdev->name, suffix);
-			hi->input->name = name;
-		}
-	}
+	if (suffix)
+		hi->input->name = devm_kasprintf(&hdev->dev, GFP_KERNEL,
+						 "%s %s", hdev->name, suffix);
 
 	return 0;
 }
-- 
2.43.0


