Return-Path: <stable+bounces-221600-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wJHNDW2Xo2neHgUAu9opvQ
	(envelope-from <stable+bounces-221600-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 02:33:33 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id EF18C1CAF5E
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 02:33:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EEB343024ECA
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 01:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B94822C21FF;
	Sun,  1 Mar 2026 01:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R5tSMuef"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BBDB2C11DE;
	Sun,  1 Mar 2026 01:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772328679; cv=none; b=jAgvPqvFGgMHaQQ6ZNQDTOXW2WmDlvlXphJ4mE3x/kEUSHn6Dy6iMHhrlDcdNQMyeUdepE6uzlwTlqWFFhJHogFKVnhOM0HN3QZ/RlIDN5ddTQWH0i4dFnQLhqGBuWwBhqJR03NiMYCnhe8xNB/EReIXAxxZC20fjNvDVHnNGI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772328679; c=relaxed/simple;
	bh=bQrNLFrPjj/VCEwEAP7SvQM38/Sn3WNNKapt5K2JJKY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=T9he8HpvTpU6xPYRVVm+q/dQRLihgfL1d+KegSImG46G7mG0fivEDgkJqrDnzoiQ6aljaSC7IlRAalFCunvj9TbMEmoHdyv3+WF3S7mp7xQgSnNya2H/uuYdf6/jXufzawv91u0wdWNuheG8kUDFUkiJWuiaBBM/yftlcg9yQGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R5tSMuef; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEEF6C19421;
	Sun,  1 Mar 2026 01:31:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772328679;
	bh=bQrNLFrPjj/VCEwEAP7SvQM38/Sn3WNNKapt5K2JJKY=;
	h=From:To:Cc:Subject:Date:From;
	b=R5tSMuefKJobhw+x9LAx5BKVV7GXRmdVNOZileeG8CNH/KUx6rS98wKWSo4Byz0Ka
	 IjVLL/xUsBtVy1o58jtcOGniBNw7T9xySFLWjtphPCWIaM8kpwxAhpZlmmTG31oeVJ
	 62gjpgXJEKEwvhZ5PCjBj6qUhrrmL9cDEKiK6tm81nAlRYbwOTcpuQAvKPddcvBUJV
	 UkyeQcVpCbZilgSKOApuhEc5NgX0oTUA+n4DBq3+450aqYasLldcw6ZLLcLIH2KduQ
	 /2dmOCtutvDM6EY2iLu5ftS7nrAEyTAtM8fe5DwsaULGEsS+lGFupHaNUfAgGB/Nfz
	 6oCE4f/eYLeaw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	gnoack@google.com
Cc: Jiri Kosina <jkosina@suse.com>,
	linux-input@vger.kernel.org
Subject: FAILED: Patch "HID: magicmouse: Do not crash on missing msc->input" failed to apply to 6.6-stable tree
Date: Sat, 28 Feb 2026 20:31:17 -0500
Message-ID: <20260301013117.1689760-1-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-221600-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: EF18C1CAF5E
X-Rspamd-Action: no action

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 17abd396548035fbd6179ee1a431bd75d49676a7 Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>
Date: Fri, 9 Jan 2026 11:57:14 +0100
Subject: [PATCH] HID: magicmouse: Do not crash on missing msc->input
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Fake USB devices can send their own report descriptors for which the
input_mapping() hook does not get called.  In this case, msc->input stays NULL,
leading to a crash at a later time.

Detect this condition in the input_configured() hook and reject the device.

This is not supposed to happen with actual magic mouse devices, but can be
provoked by imposing as a magic mouse USB device.

Cc: stable@vger.kernel.org
Signed-off-by: Günther Noack <gnoack@google.com>
Signed-off-by: Jiri Kosina <jkosina@suse.com>
---
 drivers/hid/hid-magicmouse.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/hid/hid-magicmouse.c b/drivers/hid/hid-magicmouse.c
index 7d4a25c6de0eb..91f621ceb924b 100644
--- a/drivers/hid/hid-magicmouse.c
+++ b/drivers/hid/hid-magicmouse.c
@@ -725,6 +725,11 @@ static int magicmouse_input_configured(struct hid_device *hdev,
 	struct magicmouse_sc *msc = hid_get_drvdata(hdev);
 	int ret;
 
+	if (!msc->input) {
+		hid_err(hdev, "magicmouse setup input failed (no input)");
+		return -EINVAL;
+	}
+
 	ret = magicmouse_setup_input(msc->input, hdev);
 	if (ret) {
 		hid_err(hdev, "magicmouse setup input failed (%d)\n", ret);
-- 
2.51.0





