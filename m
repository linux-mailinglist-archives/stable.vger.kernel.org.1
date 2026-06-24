Return-Path: <stable+bounces-268102-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8+/0Ms+YO2qmaAgAu9opvQ
	(envelope-from <stable+bounces-268102-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 24 Jun 2026 10:43:59 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FE716BCA45
	for <lists+stable@lfdr.de>; Wed, 24 Jun 2026 10:43:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=163.com header.s=s110527 header.b="Xlp0zDt/";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268102-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-268102-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=163.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 41B90301EB7B
	for <lists+stable@lfdr.de>; Wed, 24 Jun 2026 08:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81006385D73;
	Wed, 24 Jun 2026 08:43:56 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C37C822B8DF;
	Wed, 24 Jun 2026 08:43:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782290636; cv=none; b=lTNrrCtybm1GMPatZaJhs0YPOUS22ZKRDlIIVDQ7WZS7TtL1kCjd95ch2rNbJCzXdaUHHhlaWrwX9SOHcpwh4+Zu+H550KINrtMDZAwznlDkdOWjQiSHfrM7brGYRc9wNaox0S0x23X6fpujM8MHETR4lZQWR7snUgvnsiD9zKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782290636; c=relaxed/simple;
	bh=SPl8N+LX0W9W8KZQYj+TKjVE5Jqlk6gJPgpm2Pzdte0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QNi+8Uu6K1iTX7P89OTZYDoc5eAiOsI5HmuGzqcVK8ZnBOPbfmRNvKSAs2EajmcGbMErhof/mjvtNAvGAa7RXHSsCND3vCxYcy0PGI8RzA/pLUHVIs6XsTH2z6rHDGMIxs5mWkur0d7fGJPdX04HwvYJ27vbbRDnQQpudwdgG9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Xlp0zDt/; arc=none smtp.client-ip=220.197.31.4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=oh
	9GWboCg/S+iUEI4vGWSlCCtUS5zDUEpxjpbq4TjhE=; b=Xlp0zDt/vGmcYLTB65
	Y+0sR6oV2yu71EkiU1dpAIPKT9qDG2jtJrDaxh0dRQn1gu4LRP8YtAq+SFwms6Q4
	4Pi8aZrGvoEPhiy2yrKb3UMhDE20G3SQ3rGlJ8Lier0SspwhHVzDz1JtjWJthQKx
	FTTEqEDEnrx9hQNoRjkF54/hw=
Received: from localhost.localdomain (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgB3hR22mDtqP8pfDw--.40893S2;
	Wed, 24 Jun 2026 16:43:36 +0800 (CST)
From: Haoxiang Li <haoxiang_li2024@163.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	yangyingliang@huawei.com,
	mst@redhat.com,
	error27@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Haoxiang Li <haoxiang_li2024@163.com>,
	stable@vger.kernel.org
Subject: [PATCH] Bluetooth: virtio_bt: unregister HCI device on open failure
Date: Wed, 24 Jun 2026 16:43:33 +0800
Message-Id: <20260624084333.2885144-1-haoxiang_li2024@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCgvCgB3hR22mDtqP8pfDw--.40893S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7JFyfCrW8Xw4fAr1kCrWrAFb_yoW3Kwb_C3
	WxZ347uFn5CF10ka4a9FsxZw42ya4SgFs3Xw1aq3s5WryUur47Ww12qr98tF1xW3s8Cr1U
	Cr4jqFs7C34fCjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRNo7KUUUUUU==
X-CM-SenderInfo: xkdr5xpdqjszblsqjki6rwjhhfrp/xtbCxhi9LGo7mLgpYgAA31
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268102-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[haoxiang_li2024@163.com,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:marcel@holtmann.org,m:luiz.dentz@gmail.com,m:yangyingliang@huawei.com,m:mst@redhat.com,m:error27@gmail.com,m:linux-bluetooth@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:haoxiang_li2024@163.com,m:stable@vger.kernel.org,m:luizdentz@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[holtmann.org,gmail.com,huawei.com,redhat.com];
	DKIM_TRACE(0.00)[163.com:+];
	FREEMAIL_FROM(0.00)[163.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[haoxiang_li2024@163.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,163.com];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2FE716BCA45

virtbt_probe() registers the HCI device before calling
virtbt_open_vdev(). If opening the virtio Bluetooth
device fails, the error path frees the HCI device without
unregistering it.

Fixes: dc65b4b0f90a ("Bluetooth: virtio_bt: fix device removal")
Cc: stable@vger.kernel.org
Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
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
2.25.1


