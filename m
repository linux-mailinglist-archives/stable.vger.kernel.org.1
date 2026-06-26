Return-Path: <stable+bounces-268859-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8lpQB/NnPmr4FQkAu9opvQ
	(envelope-from <stable+bounces-268859-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 13:52:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6230D6CCA68
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 13:52:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268859-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-268859-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 981853034DE9
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 11:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAA5A3E023E;
	Fri, 26 Jun 2026 11:50:29 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF1173AD510;
	Fri, 26 Jun 2026 11:50:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782474629; cv=none; b=FTmHh3t2U9NFzZCQPvLsIny1u9HWbTQgPPr8zo6Uar4J7FG1e7Y+dL3navwDdDAZxgr4LOrb5vlcIuzV8HwJoZ1h7PcoLhDkMDd3k47SEfRcVfY/CMn1z/wGzj3eIan0D/PXGE9iwuD4f905KLmPrASEYt08ZvonKe7mecXK+YM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782474629; c=relaxed/simple;
	bh=I21B8/3HOSEy9OZXZ5WD0nyj4Y1xvBR+ZCAAEHwSv6k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Atrbn2YIJ18pfyCSBvH7NrmcO744M7V8N161YPnoZ3v1jL7iIcEw9jd/M2GLEp7PfBAjKLV+FSqeKYwNde94tAAjSZ4hW15SD/jLPjZAdCrRZS7vcLV42lsNUgNDHjctRzDFSqk0plL5yFIhxOFsEP4KbEdIKYUXQmEBfp3/JUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Received: from localhost.localdomain (unknown [117.182.75.66])
	by APP-05 (Coremail) with SMTP id zQCowAAngNN_Zz5qrq5mFQ--.22227S2;
	Fri, 26 Jun 2026 19:50:24 +0800 (CST)
From: WenTao Liang <vulab@iscas.ac.cn>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	WenTao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] fix: bluetooth: virtbt_probe: open_failed path calls hci_free_dev instead   of hci_unregister_dev
Date: Fri, 26 Jun 2026 19:50:19 +0800
Message-Id: <20260626115019.33300-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAAngNN_Zz5qrq5mFQ--.22227S2
X-Coremail-Antispam: 1UD129KBjvdXoWrtr1fAw4kKw1xJr1fZrW3Awb_yoWDCFX_Ga
	4fZ347WFn8CF12k3W2kF4fZrn0vasYgFs2q3yaq3s3WryDur47Xw42qr1DAF1xX348CF15
	Cw4Yqr4Sk34fujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbcAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s
	1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0
	cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8Jw
	ACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_JF0_
	Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxV
	WUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI
	7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r
	4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI
	42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUYNVyDUUUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwsKA2o+TTtPwwAAsr
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:marcel@holtmann.org,m:luiz.dentz@gmail.com,m:linux-bluetooth@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:vulab@iscas.ac.cn,m:stable@vger.kernel.org,m:luizdentz@gmail.com,s:lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	DMARC_NA(0.00)[iscas.ac.cn];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[vulab@iscas.ac.cn,stable@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[holtmann.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268859-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vulab@iscas.ac.cn,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,iscas.ac.cn:email,iscas.ac.cn:mid,iscas.ac.cn:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6230D6CCA68

When virtbt_open_vdev fails after hci_register_dev succeeds, the
  open_failed error path calls hci_free_dev, which only releases the
  allocation reference. The Bluetooth subsystem still holds a registration
  reference and keeps the device on hci_dev_list. Fix by calling
  hci_unregister_dev first, then hci_free_dev, matching the pattern in
  virtbt_remove.

Cc: stable@vger.kernel.org
Fixes: dc65b4b0f90a ("Bluetooth: virtio_bt: fix device removal")
Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>
---
 drivers/bluetooth/virtio_bt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/virtio_bt.c b/drivers/bluetooth/virtio_bt.c
index 140ab55c9fc5..bf6827431bb8 100644
--- a/drivers/bluetooth/virtio_bt.c
+++ b/drivers/bluetooth/virtio_bt.c
@@ -397,6 +397,7 @@ static int virtbt_probe(struct virtio_device *vdev)
 	return 0;
 
 open_failed:
+	hci_unregister_dev(hdev);
 	hci_free_dev(hdev);
 failed:
 	vdev->config->del_vqs(vdev);
-- 
2.39.5 (Apple Git-154)


