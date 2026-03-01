Return-Path: <stable+bounces-222233-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KBuJGvSfo2k3IQUAu9opvQ
	(envelope-from <stable+bounces-222233-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 03:09:56 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id AB9C21CD2AF
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 03:09:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0FEE9306B687
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 01:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B324A2EC083;
	Sun,  1 Mar 2026 01:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DYP38pu+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 726222E7637
	for <stable@vger.kernel.org>; Sun,  1 Mar 2026 01:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772330370; cv=none; b=JpINuTyiocACYNSdYTSc3/KbEozxGPUIgmr0+K4iKpbPcq+4xBp2grdv7LIOQSE9fTNA1JMgjK1IN9eS42m0IC9Yyd1iEonzMDVoB/Hs6/hWqYR7tLp179/JyKxd5k3ZTaCfbNQ3porBGOIV8LQx6hWEixUkn2XTzH6aSHGAnhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772330370; c=relaxed/simple;
	bh=CMqus3ITimaUBp6Um8u0hwBq1NnGJYegILemxlcDbBg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n9SY2wgJb5PmuACzxfz4dzBZQnxXe+kyYel0gT3JPi+Q0h1DRgBFo4dDTX01MeGQabtYuG0KQiVEZcVdYE40I2BGMnKSjUb6dU1GlrBc8VNJ5tzg1mclTaJLVgqWty9I5StdzbKxb3MnJlZ6iHzGFbKKw+Q4dwP5VYJu86TdJzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DYP38pu+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B413FC2BC86;
	Sun,  1 Mar 2026 01:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772330370;
	bh=CMqus3ITimaUBp6Um8u0hwBq1NnGJYegILemxlcDbBg=;
	h=From:To:Cc:Subject:Date:From;
	b=DYP38pu+g2BX0r4x4BlFuwAyy1biSSLK56M5C2irsc5jHL0ThEk9WYpdvXlxAT0bp
	 6iNrD8vv/AKQmdnyf0c80SxlfARb63ecVzxbAaBtRUSm3CKjin2dRGq2Sr1nUgHaCy
	 gHw2axNh2TTIlHcCUSiDCvBlx04y/ufahZ84BuqjxDcrLjkBvSdbdOxyGJZ/wUjhoV
	 htuy63tMbMkujOSwXihNRu8kYXAUIiMBirtngKFd3yT1vAAWziSHrWphGryTmoU/8v
	 X21N9oiR5btcSbSeOJYhgZvvqNEyor97yTcLxiHlqppXi4KdzrxGWrsApCnA5iEbJZ
	 dyP8zD1EAyokg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	hanguidong02@gmail.com
Cc: Ioana Ciornei <ioana.ciornei@nxp.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	linuxppc-dev@lists.ozlabs.org
Subject: FAILED: Patch "bus: fsl-mc: fix use-after-free in driver_override_show()" failed to apply to 5.10-stable tree
Date: Sat, 28 Feb 2026 20:59:28 -0500
Message-ID: <20260301015928.1725195-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-222233-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[vger.kernel.org,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AB9C21CD2AF
X-Rspamd-Action: no action

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 148891e95014b5dc5878acefa57f1940c281c431 Mon Sep 17 00:00:00 2001
From: Gui-Dong Han <hanguidong02@gmail.com>
Date: Wed, 3 Dec 2025 01:44:38 +0800
Subject: [PATCH] bus: fsl-mc: fix use-after-free in driver_override_show()

The driver_override_show() function reads the driver_override string
without holding the device_lock. However, driver_override_store() uses
driver_set_override(), which modifies and frees the string while holding
the device_lock.

This can result in a concurrent use-after-free if the string is freed
by the store function while being read by the show function.

Fix this by holding the device_lock around the read operation.

Fixes: 1f86a00c1159 ("bus/fsl-mc: add support for 'driver_override' in the mc-bus")
Cc: stable@vger.kernel.org
Signed-off-by: Gui-Dong Han <hanguidong02@gmail.com>
Reviewed-by: Ioana Ciornei <ioana.ciornei@nxp.com>
Link: https://lore.kernel.org/r/20251202174438.12658-1-hanguidong02@gmail.com
Signed-off-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
---
 drivers/bus/fsl-mc/fsl-mc-bus.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-bus.c
index c08c04047ae2c..08b99b0b342f3 100644
--- a/drivers/bus/fsl-mc/fsl-mc-bus.c
+++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
@@ -231,8 +231,12 @@ static ssize_t driver_override_show(struct device *dev,
 				    struct device_attribute *attr, char *buf)
 {
 	struct fsl_mc_device *mc_dev = to_fsl_mc_device(dev);
+	ssize_t len;
 
-	return sysfs_emit(buf, "%s\n", mc_dev->driver_override);
+	device_lock(dev);
+	len = sysfs_emit(buf, "%s\n", mc_dev->driver_override);
+	device_unlock(dev);
+	return len;
 }
 static DEVICE_ATTR_RW(driver_override);
 
-- 
2.51.0





