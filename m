Return-Path: <stable+bounces-221838-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6IQEG2eao2l4IAUAu9opvQ
	(envelope-from <stable+bounces-221838-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 02:46:15 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 53EDA1CBA26
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 02:46:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 368C83012525
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 01:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E58762DECCB;
	Sun,  1 Mar 2026 01:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GbYadFwK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A87A31A3165;
	Sun,  1 Mar 2026 01:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772329260; cv=none; b=WbM6x7HakvwFv2PvJLiE2zKrztI6X8ZvhQOR7yO6mxt22OhcPj8r8CQ/DRq5IpRvCpNIu8a9Di8EjGsfKj26iHjif7F6ctrkbwLSJlrQ2hkORXtwXzgbw0pF1GQldqZB7gRFFDSMcbpKKT8Y+fOfG2bcOqug2rXwvU9I/97dQSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772329260; c=relaxed/simple;
	bh=GS59sagGSL3vVushhXTDEnUfg409VXXNDkj/4Usf6Qk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uygVMcrLLNFQm34QzWUuJHg/tY5kMhjF/7ov6dIskXByzXX4efrjlTrIfs/XzVI/wez1m2weU8R+J5T3n8RKtI418rW/kcd1XYVt2ZBby/Q1ExfvUoNINPB2vX/37P94NSc287762QZ6esQ+YuJxn43TFphMux67mg9X7hZZu1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GbYadFwK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF85CC2BC86;
	Sun,  1 Mar 2026 01:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772329260;
	bh=GS59sagGSL3vVushhXTDEnUfg409VXXNDkj/4Usf6Qk=;
	h=From:To:Cc:Subject:Date:From;
	b=GbYadFwKhxmpY3XFO62YyNeXY70tOxqSiJQ7msJ4gAbYF/o/GKNDIH3XKHuukFRIB
	 9HBGKX5TsBWmYtH08OCpZ8QBQ1JT2u/jzCHoAHSQnTlNywwIzS84ooF0XlN2jiRrTH
	 aYDRf+K7ikmiqEzPfWxo037cZKjIE3OtQLJJgK8HSgFT2yg84FDWZHtncppVl1yjr0
	 yl6A9bzKaulYPKI0DmSF8UBRFk52Fj54j0K8DZqi6q8pbjy+u/P032tWM8yuo/iGD+
	 qa85vudRuYT8Jff/76Zp0BJvLQdUaRTvtfqCjTu1nZgcOOVYqXanzSA9D0n3ZWJpGF
	 DAywim6vxbcww==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	gnoack@google.com
Cc: Jiri Kosina <jkosina@suse.com>,
	linux-input@vger.kernel.org
Subject: FAILED: Patch "HID: logitech-hidpp: Check maxfield in hidpp_get_report_length()" failed to apply to 6.1-stable tree
Date: Sat, 28 Feb 2026 20:40:58 -0500
Message-ID: <20260301014058.1702423-1-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-221838-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 53EDA1CBA26
X-Rspamd-Action: no action

The patch below does not apply to the 6.1-stable tree.
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





