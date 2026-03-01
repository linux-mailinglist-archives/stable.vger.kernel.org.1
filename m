Return-Path: <stable+bounces-222239-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QJQvKayio2mRIwUAu9opvQ
	(envelope-from <stable+bounces-222239-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 03:21:32 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 06A551CD79B
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 03:21:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 700B132E886E
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 01:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1E232D9EFF;
	Sun,  1 Mar 2026 01:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TGbMsARq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B55AA262FEC;
	Sun,  1 Mar 2026 01:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772330384; cv=none; b=QgRphihp9n2FCRoKcR3yM5DyOo4jMBD8Tba8a+mr4fc77sap2WJaDngcYZY5kVkKWXefDSvZJvCfJrldgLhRQQmdfIWsvkUeV7J4YZbBFFNDj1EifFXarJEHYHkkJzWSFNFJCoCNjnVAeBDSCd13cJQGkp/ApV8B54nSaqkLyfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772330384; c=relaxed/simple;
	bh=1zWDYg5M7TjTsSKKhijND2IsOvupbPn0TGe3GKgWnUI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZMLN3ZinxZ5JXSlDMymZzQtDyv7WOfh8bKBEEC/UIMD8TscngvpZTDj7FssOmKxTaMcSUlHh85cOj5ikc/QTvtSRb44CXzi+D8lOJ4AF2JJBRg4T7DY3RFsLaZN8LOJMA7EuJI0ssuOabeaC0S76J2YhZEGFQ950O627cVjTUEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TGbMsARq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 239CFC19424;
	Sun,  1 Mar 2026 01:59:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772330384;
	bh=1zWDYg5M7TjTsSKKhijND2IsOvupbPn0TGe3GKgWnUI=;
	h=From:To:Cc:Subject:Date:From;
	b=TGbMsARqhVaNJPmbCznu7kkOCIRDqHYnrwfw7LnYe8fvpnQ44hV2DjYlIGer66svP
	 DDMDqq1PZMFp3QdWcF1tCExVUon3d/S8M6lrl0vpJTQk+s3rCbhpgBOmF6qfZix46s
	 GkhBv1+IGHzjkTZiyB+pyBqRPzOuQxAJygjYL0CK6xrmnl010tqmHKGYsK+a/tjLdB
	 15+d5cPLNR6CX/+zrRLcUkOoJZiZM5mwCf+o1qYNgNzI6PoZRVF2gt7gevkqLXRdga
	 W3QJsRw0dpUEMd1+CHuuOSHj5URv8lXkxiu3NzENNu8zZOyMN+jOlLIs/qirOs9P6f
	 FoQ4C2zunHpaA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	gnoack@google.com
Cc: Jiri Kosina <jkosina@suse.com>,
	linux-input@vger.kernel.org
Subject: FAILED: Patch "HID: magicmouse: Do not crash on missing msc->input" failed to apply to 5.10-stable tree
Date: Sat, 28 Feb 2026 20:59:42 -0500
Message-ID: <20260301015942.1725562-1-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-222239-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.com:email]
X-Rspamd-Queue-Id: 06A551CD79B
X-Rspamd-Action: no action

The patch below does not apply to the 5.10-stable tree.
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





