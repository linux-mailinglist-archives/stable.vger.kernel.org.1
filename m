Return-Path: <stable+bounces-222241-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AAdPBBigo2noIgUAu9opvQ
	(envelope-from <stable+bounces-222241-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 03:10:32 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 53DB01CD316
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 03:10:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4D514307017D
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 01:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EEB52F4A18;
	Sun,  1 Mar 2026 01:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V0oGMMaB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 328D8262FEC;
	Sun,  1 Mar 2026 01:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772330389; cv=none; b=MR8Iw7KsghsikWFmGuKA6EN+J1p+SZ5J1x8Nz/YarF3wMc4TqhFiwpqHcxo+T4mjFyB+jynxA8XZVyQXun9FIEYGUPbTXFtBtjhJBMvlmOqvoGCp2sccVAZbyqZX3Q8HzrofEkA5vm2gYplFSMl4lIxWxKeM9thkqGZSZLcg2QU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772330389; c=relaxed/simple;
	bh=4//siI1gkvZKxirz1w809X4fINe88q2vYRDNWZOzVq0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JYDT4y3BFrItdfkQKfOhZlqJELXUVnyxpfTjX3V/MrD42HH8b3soQujNFj8723E1jBkm/wZljXNbi+886NwIgfIXo+FjKBh4VucEl4zGP+B0S0XkXt7s9oiylTez18H8JkfqqOF0Qpe4Qqxkc2MLP1OYvyWdgVRKprMl15E6no8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V0oGMMaB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9019EC19421;
	Sun,  1 Mar 2026 01:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772330389;
	bh=4//siI1gkvZKxirz1w809X4fINe88q2vYRDNWZOzVq0=;
	h=From:To:Cc:Subject:Date:From;
	b=V0oGMMaBjfjVr6BCcGaw43eyV7EE1UsgH/2IUhSqfMaUvVLdvE6h3flfd9/dsl8Th
	 jByCTpZSn2zsYAEdvIXr4f8FkSUMJsoQS/SpyXdwznnXpuDY19wPhK/T8K3eQidAyy
	 r11++1f4ngDvgJ09o0Hb4hkxfcHoHZAemZaJmbGBb7XMR2R1tiybVF+05aoOUF7rDT
	 9DgKcTyUsqZKDf0yh6xR73GJy7fx7eJocGaGs6IgsUlUTwqraiEAUHqQWLB+jDAquM
	 Lt2tnjnQpu3XdEl0Z2WielztewpUTlazVxm9vmstQdAXgwgi0FS09K0FJLajDdmsnB
	 0JrJb5gvuue/g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	gnoack@google.com
Cc: Jiri Kosina <jkosina@suse.com>,
	linux-input@vger.kernel.org
Subject: FAILED: Patch "HID: logitech-hidpp: Check maxfield in hidpp_get_report_length()" failed to apply to 5.10-stable tree
Date: Sat, 28 Feb 2026 20:59:47 -0500
Message-ID: <20260301015947.1725656-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-222241-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 53DB01CD316
X-Rspamd-Action: no action

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 1547d41f9f19d691c2c9ce4c29f746297baef9e9 Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>
Date: Fri, 9 Jan 2026 13:25:58 +0100
Subject: [PATCH] HID: logitech-hidpp: Check maxfield in
 hidpp_get_report_length()
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Do not crash when a report has no fields.

Fake USB gadgets can send their own HID report descriptors and can define report
structures without valid fields.  This can be used to crash the kernel over USB.

Cc: stable@vger.kernel.org
Signed-off-by: Günther Noack <gnoack@google.com>
Signed-off-by: Jiri Kosina <jkosina@suse.com>
---
 drivers/hid/hid-logitech-hidpp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index e871f1729d4b3..d0a38eff9cfa8 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -4314,7 +4314,7 @@ static int hidpp_get_report_length(struct hid_device *hdev, int id)
 
 	re = &(hdev->report_enum[HID_OUTPUT_REPORT]);
 	report = re->report_id_hash[id];
-	if (!report)
+	if (!report || !report->maxfield)
 		return 0;
 
 	return report->field[0]->report_count + 1;
-- 
2.51.0





