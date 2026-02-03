Return-Path: <stable+bounces-213150-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SEgsIKxdgWmdFwMAu9opvQ
	(envelope-from <stable+bounces-213150-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 03 Feb 2026 03:30:04 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 04D4CD3C6D
	for <lists+stable@lfdr.de>; Tue, 03 Feb 2026 03:30:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B81F430107E8
	for <lists+stable@lfdr.de>; Tue,  3 Feb 2026 02:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAFA42F3621;
	Tue,  3 Feb 2026 02:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Gec0CA/I"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD56086348
	for <stable@vger.kernel.org>; Tue,  3 Feb 2026 02:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770085787; cv=none; b=Cs87+kDF43C+X/uh+ZpmVP+IyNYQspzBrpKxhoX5IZUKHoLN9d/z37hGeY9DR7Iaju3DO3Qu5VH4AB1wolsSuuDWu3Qg/oOXYnFRLnTJjlfIKWisxp5WgVotnQtOB+PmzqTTJIqH6FqpxWumIeLyaW1rK702ggVyjK6KR38hMNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770085787; c=relaxed/simple;
	bh=0W9pcmJvL0nEs3y162/O/epqW5VVnOc/KbAh3xBiA+g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gsObkHnP2qrwDaCWllLyTpSWmXqN/uHD51qo3JiZfkmb3u1MstxQMEEH3ju7fZ7SAak33vzkqJlv5FB2nXZ5fDiIaTro4lDMrf2caQ6hYFmZs5mFrDuniMaUZWlQlaCU7LR8VnWAC+2nvh/xi/Tb+Wm1kx8YVUsZYvgmbvtZaIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Gec0CA/I; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=BU
	oJq8Q1DXIey+0sg1xrThDPCz40A7ULnUISMvUjijg=; b=Gec0CA/IwlugcLCqiK
	zC2vnfmtFnBTvMJjbTz0TM4weOC06AZan/jf1KG2pMIRXO5TnAHjrNSZ8zgWPfFK
	4fUhAuH2WXkwEvZ2J1cRtp7wlEa0iEWxrKnCEs4KWcVqc17rwBkKblQPS1LL6xLZ
	AuI5FB61PPHwwR5kKXVF30JQc=
Received: from ubuntu24.corp.ad.wrs.com (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wCn0lyHXYFp5+KlJw--.9853S5;
	Tue, 03 Feb 2026 10:29:34 +0800 (CST)
From: jetlan9@163.com
To: stable@vger.kernel.org
Cc: Henry Martin <bsdhenrymartin@gmail.com>,
	Jiri Kosina <jkosina@suse.com>,
	Wenshan Lan <jetlan9@163.com>
Subject: [PATCH 5.10.y 2/2] HID: uclogic: Add NULL check in uclogic_input_configured()
Date: Tue,  3 Feb 2026 02:29:25 +0000
Message-ID: <20260203022925.4133-2-jetlan9@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260203022925.4133-1-jetlan9@163.com>
References: <20260203022925.4133-1-jetlan9@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCn0lyHXYFp5+KlJw--.9853S5
X-Coremail-Antispam: 1Uf129KBjvJXoWrtryfAryUCFW5tF4fZF4Dtwb_yoW8JrW8pF
	Z5GFWIyr4kWF1UKr4qqa43Za45Za97Gr95uryq93yUZrn3Xa4kKryak34qqryYyrZYyrsx
	AF95ta1xGa4DGaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRI31_UUUUU=
X-CM-SenderInfo: xmhwztjqz6il2tof0z/xtbC6w81-WmBXY-lxgAA31
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-213150-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,suse.com,163.com];
	DKIM_TRACE(0.00)[163.com:+];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jetlan9@163.com,stable@vger.kernel.org];
	FREEMAIL_FROM(0.00)[163.com];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.com:email]
X-Rspamd-Queue-Id: 04D4CD3C6D
X-Rspamd-Action: no action

From: Henry Martin <bsdhenrymartin@gmail.com>

[ Upstream commit bd07f751208ba190f9b0db5e5b7f35d5bb4a8a1e ]

devm_kasprintf() returns NULL when memory allocation fails. Currently,
uclogic_input_configured() does not check for this case, which results
in a NULL pointer dereference.

Add NULL check after devm_kasprintf() to prevent this issue.

Fixes: dd613a4e45f8 ("HID: uclogic: Correct devm device reference for hidinput input_dev name")
Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
Signed-off-by: Jiri Kosina <jkosina@suse.com>
[ Adjust context ]
Signed-off-by: Wenshan Lan <jetlan9@163.com>
---
 drivers/hid/hid-uclogic-core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-uclogic-core.c b/drivers/hid/hid-uclogic-core.c
index 02a3b2aa1bda..c0d56b7ca19e 100644
--- a/drivers/hid/hid-uclogic-core.c
+++ b/drivers/hid/hid-uclogic-core.c
@@ -143,9 +143,12 @@ static int uclogic_input_configured(struct hid_device *hdev,
 		break;
 	}
 
-	if (suffix)
+	if (suffix) {
 		hi->input->name = devm_kasprintf(&hdev->dev, GFP_KERNEL,
 						 "%s %s", hdev->name, suffix);
+		if (!hi->input->name)
+			return -ENOMEM;
+	}
 
 	return 0;
 }
-- 
2.43.0


