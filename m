Return-Path: <stable+bounces-50148-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2B28903A1A
	for <lists+stable@lfdr.de>; Tue, 11 Jun 2024 13:31:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 637EAB23AF2
	for <lists+stable@lfdr.de>; Tue, 11 Jun 2024 11:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 266F1176ADC;
	Tue, 11 Jun 2024 11:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C0bxs9HJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D612417545;
	Tue, 11 Jun 2024 11:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718105480; cv=none; b=R6Uuz2IRd9AWX+gqPWHlinH8xgIPiB9EB7FxDFPvRY6IVNSIpSdzF13JzVJZYPS8u5/4ZYRWw8OgASGSr5kfsZpdgVODZjT7irLBuqKdwkqNwNqEUX/BJK0OAZTeeY/OTfXal6hcnDb9YAbqrj5TSdCln5XIU1SWQQjikxTgs/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718105480; c=relaxed/simple;
	bh=tMTUMyMGzBKqGaRrsUGf3Ky/bKzEt75mPDQND0DU9KI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DOUcENrLb17fX8vRTcbyGLWxhOc83nxpKLPeWHvUmTFR4TVcVUA6pff4x/KbISC2evc4dkJRlyPmJyA+PlWBYp9iNitUr/+wt1xoWEt42BbMcHnuMYb1gri2+cY88iRnxksAGeflbZQ5KUR1Zzq0Jj14HfssBffr+xVATDRaDfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C0bxs9HJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AE34C2BD10;
	Tue, 11 Jun 2024 11:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718105480;
	bh=tMTUMyMGzBKqGaRrsUGf3Ky/bKzEt75mPDQND0DU9KI=;
	h=From:To:Cc:Subject:Date:From;
	b=C0bxs9HJp/w+63G4i6hHENBEOMMgmaHa4VKOBIkaNEHoRg+Vh38ZLVzJw3hMc3gXl
	 r3XYctdpHGl8vtUHu868/7Yy/1jktyyk/dhLVYQUsJ/tswbRGQ0k9Ph95SyBXOVWc2
	 rguHD4sZ9dP3KVJpZAGY9HF8CyPpoF2+FDGyPjFfhWDmVyxz4KHEjLARfgpDT+aeeO
	 8AOfZ0BFI0YNxrIw5aI6W1oCicHcjOakblULQ3L9yD5o/QMdFLA8Elb9S+kExvdpLr
	 68+EzL4ZwQFe7+9OrInEBuSkLTxcY2vTcqZY0bpUZyCfR78BGL3+djoc04YRaeGOsX
	 h07cTEbjZryNA==
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: bleung@chromium.org,
	groeck@chromium.org
Cc: tzungbi@kernel.org,
	chrome-platform@lists.linux.dev,
	stable@vger.kernel.org
Subject: [PATCH] platform/chrome: cros_ec_debugfs: fix wrong EC message version
Date: Tue, 11 Jun 2024 11:31:10 +0000
Message-ID: <20240611113110.16955-1-tzungbi@kernel.org>
X-Mailer: git-send-email 2.45.2.505.gda0bf45e8d-goog
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ec_read_version_supported() uses ec_params_get_cmd_versions_v1 but it
wrongly uses message version 0.

Fix it.

Cc: stable@vger.kernel.org
Fixes: e86264595225 ("mfd: cros_ec: add debugfs, console log file")
Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
---
 drivers/platform/chrome/cros_ec_debugfs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/platform/chrome/cros_ec_debugfs.c b/drivers/platform/chrome/cros_ec_debugfs.c
index f0e9efb543df..4525ad1b59f4 100644
--- a/drivers/platform/chrome/cros_ec_debugfs.c
+++ b/drivers/platform/chrome/cros_ec_debugfs.c
@@ -334,6 +334,7 @@ static int ec_read_version_supported(struct cros_ec_dev *ec)
 	if (!msg)
 		return 0;
 
+	msg->version = 1;
 	msg->command = EC_CMD_GET_CMD_VERSIONS + ec->cmd_offset;
 	msg->outsize = sizeof(*params);
 	msg->insize = sizeof(*response);
-- 
2.45.2.505.gda0bf45e8d-goog


