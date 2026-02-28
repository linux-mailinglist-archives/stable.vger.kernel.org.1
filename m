Return-Path: <stable+bounces-220154-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WOKqLuoqo2kr+AQAu9opvQ
	(envelope-from <stable+bounces-220154-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:50:34 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 49C981C521E
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:50:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 058FA31B1945
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 17:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8A7649250C;
	Sat, 28 Feb 2026 17:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q3ua12Nn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89078492188;
	Sat, 28 Feb 2026 17:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300062; cv=none; b=t3mzIQnDlPC9KI6C+DTEhajAeP7dSP5ePA8p6YyFHPEmw5p4Y1hbKUmleoc8W5LBWFpmUFPgLXAgEVqazogXzsIu6KDeIg/kDCh7I7LjcdlNwHSepue/EELB1AM2E49ynqB/XmEAedjLdi5k0mMmnQM9Yr8USJDVLcW30MXHFlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300062; c=relaxed/simple;
	bh=tJNJ6IxtqMjafIYy7IX3Ga8HA564+B01cMNRrZI8zW0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WhA3AhnFyGoe785I/Ij2qCMAqajghwwNI3UMNeRmEEJgbydpgJGvNGNfncpHoy0VsEHDLhanWAQN532NeyQSEYlBBAtUeh1krOtjPuAG627/0lCOXxJhQ8o5oGCwNXye+QsJlJTTS+OXmQnMHn7bD/v1NOfEwpD5AkNaWQtKnx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q3ua12Nn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D503BC19423;
	Sat, 28 Feb 2026 17:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300062;
	bh=tJNJ6IxtqMjafIYy7IX3Ga8HA564+B01cMNRrZI8zW0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q3ua12NnlnY1bwHa0dqq6YPFNWwn30K3EzTufGyfQNDhzGD8Q0TAK6t4byIR8cmvc
	 VHb2cug6aN6L6ewm0UL9WbB1pP8+06hCF0f6adZInc/VBpRlxPjFY8Rpo+WPlzW4uI
	 hgHEXXYNdrHUR/Spoc/NGDJNDpiM+U1kgGFahP6ODvoCidyJtQWVqImeHt/ytvbtf9
	 9yVm1aDnxW0B6otuT0AyUprF92jbxlrHi95RHKrYllLI5Snz3CzqqvRwLfACJXylz1
	 3O3Z189pu0KQd8dwZt7nYPsLrqp2B3YnXFcQcb5YHsYME96Iqo90/dJAdaMzisDyps
	 wS2ZzWijltoqg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Heinz Mauelshagen <heinzm@redhat.com>,
	Yu Kuai <yukuai@fnnas.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 076/844] md raid: fix hang when stopping arrays with metadata through dm-raid
Date: Sat, 28 Feb 2026 12:19:49 -0500
Message-ID: <20260228173244.1509663-77-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220154-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,fnnas.com:email]
X-Rspamd-Queue-Id: 49C981C521E
X-Rspamd-Action: no action

From: Heinz Mauelshagen <heinzm@redhat.com>

[ Upstream commit cefcb9297fbdb6d94b61787b4f8d84f55b741470 ]

When using device-mapper's dm-raid target, stopping a RAID array can cause
the system to hang under specific conditions.

This occurs when:

- A dm-raid managed device tree is suspended from top to bottom
   (the top-level RAID device is suspended first, followed by its
    underlying metadata and data devices)

- The top-level RAID device is then removed

Removing the top-level device triggers a hang in the following sequence:
the dm-raid destructor calls md_stop(), which tries to flush the
write-intent bitmap by writing to the metadata sub-devices. However, these
devices are already suspended, making them unable to complete the write-intent
operations and causing an indefinite block.

Fix:

- Prevent bitmap flushing when md_stop() is called from dm-raid
destructor context
  and avoid a quiescing/unquescing cycle which could also cause I/O

- Still allow write-intent bitmap flushing when called from dm-raid
suspend context

This ensures that RAID array teardown can complete successfully even when the
underlying devices are in a suspended state.

This second patch uses md_is_rdwr() to distinguish between suspend and
destructor paths as elaborated on above.

Link: https://lore.kernel.org/linux-raid/CAM23VxqYrwkhKEBeQrZeZwQudbiNey2_8B_SEOLqug=pXxaFrA@mail.gmail.com
Signed-off-by: Heinz Mauelshagen <heinzm@redhat.com>
Signed-off-by: Yu Kuai <yukuai@fnnas.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/md.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 6d73f6e196a9f..ac71640ff3a81 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -6848,13 +6848,15 @@ static void __md_stop_writes(struct mddev *mddev)
 {
 	timer_delete_sync(&mddev->safemode_timer);
 
-	if (mddev->pers && mddev->pers->quiesce) {
-		mddev->pers->quiesce(mddev, 1);
-		mddev->pers->quiesce(mddev, 0);
-	}
+	if (md_is_rdwr(mddev) || !mddev_is_dm(mddev)) {
+		if (mddev->pers && mddev->pers->quiesce) {
+			mddev->pers->quiesce(mddev, 1);
+			mddev->pers->quiesce(mddev, 0);
+		}
 
-	if (md_bitmap_enabled(mddev, true))
-		mddev->bitmap_ops->flush(mddev);
+		if (md_bitmap_enabled(mddev, true))
+			mddev->bitmap_ops->flush(mddev);
+	}
 
 	if (md_is_rdwr(mddev) &&
 	    ((!mddev->in_sync && !mddev_is_clustered(mddev)) ||
-- 
2.51.0


