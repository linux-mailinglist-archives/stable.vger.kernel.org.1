Return-Path: <stable+bounces-245039-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eMsxA16oAGqTLQEAu9opvQ
	(envelope-from <stable+bounces-245039-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 10 May 2026 17:46:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E1D1D504E93
	for <lists+stable@lfdr.de>; Sun, 10 May 2026 17:46:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 12EA23001864
	for <lists+stable@lfdr.de>; Sun, 10 May 2026 15:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A22B23A0E85;
	Sun, 10 May 2026 15:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rZXx81So"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F1DBCA4E
	for <stable@vger.kernel.org>; Sun, 10 May 2026 15:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778427991; cv=none; b=o0wwiTqqwccP3lOvBdH907O1KdNZxw+cKyresCEcQkJ8AetzdjXryAfHa+xPsnLg3JR0HbY1COGem1tHBhocPlPq9Uj/ZIjIQFVHvJAgU71zIzzDl3RU/aXU+qRblSrS0RNZa3QEwLxhiN6Glg5GyC9eWexefT5oNP8kkcS2LG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778427991; c=relaxed/simple;
	bh=kOA6guZasbxkks6zhguYbxZFIj5pxIZkkcRMcvSmU2M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MFCjOsFkprpWlUUA4rxpSYQhpvpEmhU8EpwXmFAE4hU7+jsiED5SfWLgkbwDAyiooM9pCxAdXx7LKakXhdUyuFcQbTL+MEqVXX1CceHVnlO3MT6TIT29Mrnq/uRp98MVwlWAfhWyeNpt1glQ5+9BbW29BnuCVT3SiBa3j9zshMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rZXx81So; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A5D4C2BCB8;
	Sun, 10 May 2026 15:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778427990;
	bh=kOA6guZasbxkks6zhguYbxZFIj5pxIZkkcRMcvSmU2M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rZXx81Soo0BkbiIVc6pE3vF/futttWrj4xW5P5PHFBr8gX53y0/34q6pTgAI0jks4
	 5TUOzM73iy6/ecLTBDZNb5fay/coKMNULT0p3qd76oE/Z+Rk8Vh/xxtkghc3Avl8XR
	 OwH7S6VBLvhBtiomz1Db6k89xeILGbmJDB4pHicW3I6uOkVCe4BWsPpLYMsAPva7lN
	 j8sr45v/1z9hYcFvwJjPPrXo7XRsHdbe3kNGD4j383zy7Sc2cFuprQBIdrNrdsS3VS
	 jq3oHBFL10T1NFZ1I5gQJQD6swFG1/7p1+LT5u/AyafeLCYHkA1gSK/Sp+gaGRi+Hm
	 +tjFlRFEBCLNw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] ACPI: scan: Use acpi_dev_put() in object add error paths
Date: Sun, 10 May 2026 11:46:27 -0400
Message-ID: <20260510154627.158558-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026050748-hypocrite-astonish-bb51@gregkh>
References: <2026050748-hypocrite-astonish-bb51@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E1D1D504E93
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[gmail.com,rjwysocki.net,kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-245039-lists,stable=lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.997];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: Guangshuo Li <lgs201920130244@gmail.com>

[ Upstream commit 9c0acc169ac71535477caedea8315f7041c5f07c ]

After acpi_init_device_object(), the lifetime of struct acpi_device is
managed by the driver core through reference counting.

Both acpi_add_power_resource() and acpi_add_single_object() call
acpi_init_device_object() and then invoke acpi_device_add(). If that
fails, their error paths call the release callback directly instead of
dropping the device reference through acpi_dev_put().

This bypasses the normal device lifetime rules and frees the object
without releasing the reference acquired by device_initialize(), which
may lead to a refcount leak.

The issue was identified by a static analysis tool I developed and
confirmed by manual review.

Fix both error paths by using acpi_dev_put() and let the release
callback handle the final cleanup.

Fixes: 781d737c7466 ("ACPI: Drop power resources driver")
Fixes: 718fb0de8ff88 ("ACPI: fix NULL bug for HID/UID string")
Cc: All applicable <stable@vger.kernel.org>
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
Link: https://patch.msgid.link/20260413135343.2884481-1-lgs201920130244@gmail.com
Signed-off-by: Rafael J. Wysocki <rjw@rjwysocki.net>
[ preserved 5.10's `return result;` instead of upstream's `return NULL;` since the function returns int ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/power.c | 2 +-
 drivers/acpi/scan.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/power.c b/drivers/acpi/power.c
index 61115ed8b93fb..b00bb1b899e78 100644
--- a/drivers/acpi/power.c
+++ b/drivers/acpi/power.c
@@ -977,7 +977,7 @@ int acpi_add_power_resource(acpi_handle handle)
 	return 0;
 
  err:
-	acpi_release_power_resource(&device->dev);
+	acpi_dev_put(device);
 	return result;
 }
 
diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index f17f48bc13bc0..08a43d1393e0e 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1679,7 +1679,7 @@ static int acpi_add_single_object(struct acpi_device **child,
 
 	result = acpi_device_add(device, acpi_device_release);
 	if (result) {
-		acpi_device_release(&device->dev);
+		acpi_dev_put(device);
 		return result;
 	}
 
-- 
2.53.0


