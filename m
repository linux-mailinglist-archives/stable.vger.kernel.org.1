Return-Path: <stable+bounces-213143-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cFW/FmxOgWlMFgMAu9opvQ
	(envelope-from <stable+bounces-213143-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 03 Feb 2026 02:25:00 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 84311D35B5
	for <lists+stable@lfdr.de>; Tue, 03 Feb 2026 02:24:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3A59130312C4
	for <lists+stable@lfdr.de>; Tue,  3 Feb 2026 01:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C741221FBA;
	Tue,  3 Feb 2026 01:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="FQwOZ57B"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D4E17C21C
	for <stable@vger.kernel.org>; Tue,  3 Feb 2026 01:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770081877; cv=none; b=HWGJw09PUZyqI2dsBt6D1H8LlbiE1TPn9cIEVz7VDF7UGMwURJlaTTQxsBe701gNqjOMWOyV6TxG/iWuBGOFZCiquCj1RweTgGnW+ueb4frHRKLiUwzrdfiCJNkVJlmx6S62VIJzq1hxvam1dVX0mMKq3G/l0tkxthrAvyElzic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770081877; c=relaxed/simple;
	bh=rul6O4hlFHiiejZFOF9sFnQUdVywQ77Dl8U0F80+gZA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n7DJxULJbtpoV1DXHRVcOTc037bJw+KSMvpdxpgS408ICSqUKElLRzvovMcGYdjLQY9Pn9LiBPupxC8bfCNlNuSwpDuUKe0n2FhKTxeVq3+cMuZL0nEuPAqKk09L8xnaR9rciaU04u/YkHeLqXq9LrpLyTpnkpa/ji8fDsiem3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=FQwOZ57B; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=z4
	lvX9b/wpHzUUDc4cM8nQsXE3dBaZhyGhbp9VzrFls=; b=FQwOZ57BKKP7gnY+Uf
	TGkCDe/AAPk3HDH3wCxyHd9K8Hy57FC5vGKsc0jH+q/EyMoFvfE315rq1iCGspb7
	2Z+YukrpBD1squdUS6049C6pgHTwJuNZuyNvf1rvRQHOXkUVbR8Army7nH7stxmR
	cGnKZaXiA9G8a1/Eh4v74immU=
Received: from ubuntu24.corp.ad.wrs.com (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wD3lwquTYFpoZcAJA--.30698S5;
	Tue, 03 Feb 2026 09:21:57 +0800 (CST)
From: jetlan9@163.com
To: stable@vger.kernel.org
Cc: Henry Martin <bsdhenrymartin@gmail.com>,
	Jiri Kosina <jkosina@suse.com>,
	Wenshan Lan <jetlan9@163.com>
Subject: [PATCH 5.15.y 2/2] HID: uclogic: Add NULL check in uclogic_input_configured()
Date: Tue,  3 Feb 2026 01:21:44 +0000
Message-ID: <20260203012144.4215-2-jetlan9@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260203012144.4215-1-jetlan9@163.com>
References: <20260203012144.4215-1-jetlan9@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3lwquTYFpoZcAJA--.30698S5
X-Coremail-Antispam: 1Uf129KBjvJXoWrtryfAryUCFW5tF4fZF4Dtwb_yoW8JrW8pF
	WrGFWIyr4kWF1UKw4qva45Za45ua97Gr95uryDuw4UZrn5Xa4kKryak34qqryYyrZYyrnx
	AF95ta1xGa4DGaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRI31_UUUUU=
X-CM-SenderInfo: xmhwztjqz6il2tof0z/xtbC7BU7BGmBTbXi4gAA3W
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-213143-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[stable];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,suse.com:email]
X-Rspamd-Queue-Id: 84311D35B5
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
index 47d88cd95fc0..340f92cfc812 100644
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


