Return-Path: <stable+bounces-224056-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CDHqDtj8r2mmdwIAu9opvQ
	(envelope-from <stable+bounces-224056-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:13:28 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C38EB24A24E
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:13:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 073D43035F6F
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 11:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F8CF387577;
	Tue, 10 Mar 2026 11:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jG137keq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F7A352C4F;
	Tue, 10 Mar 2026 11:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773141189; cv=none; b=Rz5MastjMZK4zRFvnqLndrdC+t+pLX1GRugC+QFHmftQw9GBMfQnGfWdU73Em/Y2L9s8Hb59MuRS5TRKCz1UbT9clgbvqqQDvKODDR61UcerdBAcTxhmDxx3eIcYKVAGRNlWDCyu/0ViJMtOJSd+7lKDZQX1PZA8d+Zjdi7SGzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773141189; c=relaxed/simple;
	bh=ZAuG8IKAu45hV2mMVEd4KoN4NMaMHWFK5R0z0/qDGpY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JKny9aS08mJVVvREpTRz+bq0yzd7lO9PPAy6UXvxYmt/QcMW4C7r+IQGvzHX3jFxDduiwfwXOtUlzIU//b+5ls7wYNoy+Y5tnhCr+rCD0hDMl2Y6fPuNvCai/B19PqT1imeVwEtQAyMEgZbi6ZLYjqwWJt/1HiudK2Ue1BqmliQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jG137keq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1D84C19423;
	Tue, 10 Mar 2026 11:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773141189;
	bh=ZAuG8IKAu45hV2mMVEd4KoN4NMaMHWFK5R0z0/qDGpY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jG137keqWyoZjxerhUjJY2Z8M1KOZjshUrviEwUC/Kv1Xtf5ttyGRpOYIgBKdlzoc
	 jxDpxQiUwNkCPu3fAE/llFWM1HLzv74Pxs/gWGUSwS2T/yByIZ6cjv40RIHVIa1F8R
	 ZNmkAJJwzBIl9wKqfUQ6XP9WFkNl+tqPM5UBVUrDnfvHLPlFosHeD69P3U9/lu/sXI
	 JPbPTDq2OrsJV4Mi+DtuahzvkBWnaMopFz8AtIUY+OyG5Tky78wbaCY6BsdI7V6+Md
	 AhnokrkxZPIMjv5gv3xacPcgeOyXl9zC0a1BLpyCapWcikgau/8J7Yzmrqi0Aa0S19
	 Adw/jNZBGPmfA==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Bart Van Assche <bvanassche@acm.org>,
	Frank Crawford <frank@crawford.emu.id.au>,
	Guenter Roeck <linux@roeck-us.net>,
	Jean Delvare <jdelvare@suse.com>,
	linux-hwmon@vger.kernel.org,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 191/311] hwmon: (it87) Check the it87_lock() return value
Date: Tue, 10 Mar 2026 07:03:58 -0400
Message-ID: <7d981cf6f5f0b15b6683f709c343d9bfae468994.1773140655.git.sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1773140654.git.sashal@kernel.org>
References: <cover.1773140654.git.sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C38EB24A24E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-224056-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,acm.org:email]
X-Rspamd-Action: no action

From: Bart Van Assche <bvanassche@acm.org>

[ Upstream commit 07ed4f05bbfd2bc014974dcc4297fd3aa1cb88c0 ]

Return early in it87_resume() if it87_lock() fails instead of ignoring the
return value of that function. This patch suppresses a Clang thread-safety
warning.

Cc: Frank Crawford <frank@crawford.emu.id.au>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: Jean Delvare <jdelvare@suse.com>
Cc: linux-hwmon@vger.kernel.org
Fixes: 376e1a937b30 ("hwmon: (it87) Add calls to smbus_enable/smbus_disable as required")
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
Link: https://lore.kernel.org/r/20260223220102.2158611-15-bart.vanassche@linux.dev
[groeck: Declare 'ret' at the beginning of it87_resume()]
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwmon/it87.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/it87.c b/drivers/hwmon/it87.c
index e233aafa8856c..5cfb98a0512f0 100644
--- a/drivers/hwmon/it87.c
+++ b/drivers/hwmon/it87.c
@@ -3590,10 +3590,13 @@ static int it87_resume(struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);
 	struct it87_data *data = dev_get_drvdata(dev);
+	int err;
 
 	it87_resume_sio(pdev);
 
-	it87_lock(data);
+	err = it87_lock(data);
+	if (err)
+		return err;
 
 	it87_check_pwm(dev);
 	it87_check_limit_regs(data);
-- 
2.51.0


