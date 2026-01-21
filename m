Return-Path: <stable+bounces-210702-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CL5AHIt1cGktYAAAu9opvQ
	(envelope-from <stable+bounces-210702-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 07:43:23 +0100
X-Original-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 98EAE523D4
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 07:43:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8EB186C0EF1
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 06:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9410449EAF;
	Wed, 21 Jan 2026 06:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PZzmT6Vv"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F6A8426D15
	for <stable@vger.kernel.org>; Wed, 21 Jan 2026 06:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768977663; cv=none; b=ePG+BK8BcnkQNOGQ0NPvdWFDx/dwR+LdoxhygBX5eOfvNsDpJa8XlkB7C4rN/ufPDi2doXExQEtsHy6B3v0BHhVAaGldun87xOyypZSrszP2uGvkyWRcaxXWYwIvpoa/1YS6HSAvdIAG7KEpxBStgCekWCiW+3mhu70PuA3+NU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768977663; c=relaxed/simple;
	bh=0VwuN9/IjqODQZh9DgW6KWamSmxw251Z9dlyrHTtyUk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CnOGlsugeFp4Ed7S5ZJC/Acow756WsL6naLq0n3futnVRzBbAUBCJq68ffmWqVNXVUuE7IjUvJ0AlKr6rB8g+S+YGi61StRx52a10tsu+Ecc4SNdb2Xf1N+nNhMu54Z0PFYJOS50C2uvK/ZA/4drfBGHzF9drUE34uwpELqxDPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PZzmT6Vv; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-81f416c0473so5317007b3a.3
        for <stable@vger.kernel.org>; Tue, 20 Jan 2026 22:41:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768977661; x=1769582461; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mkqmypmkTIuPWsY5B5pc0P3WmdN0p6dQtsQrpbKtq3k=;
        b=PZzmT6VvkW6SabKT1DHfyulMWAENwq/B2k1U+ijWGlu3ihENu6V/Aq8kT4j1/O0D3j
         7KcWMrniJMRd3zN4wpDK6EIaltDhDCw17p3qR28BWR/F/f77R7nJSrf1EF1o22ZWGXyp
         kGF2KI8iLV38EDrS1uih+0J15MvpO2Yirpf8djQ1tS6xRWN90HDnFhbTwtnEpUdyOyHx
         ps3v+kr0kWSuZztljpb7PtHZarLpBZV3nAdu81QNjY2am6qxXJwAzttqMxj3aPBWPPSe
         kNFa06QlxmpvTLWoV71cGe1n+VzopXG1VH8+G3YUV41Aj5HrLqdRcfR3bjchxAhARbo9
         weUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768977661; x=1769582461;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mkqmypmkTIuPWsY5B5pc0P3WmdN0p6dQtsQrpbKtq3k=;
        b=j3nbvM+p1biaC4f/U8o5bzxxdbl2UC8yIVRo97lGfRdUOuFdz/jPPnRA2gh3g7fjf5
         N2JsetgtPF3ynVbGD1/cyO1qFJZhHWQX2MVSiUELQhPecc7RfpTm47bW7YX9YSpQXU5F
         f9zGjWopMZZveL9cYMMWw/dqq2sOHiql0a7qYLA4b8AQD0Zj4jTuo0CTY+briy6WNhF7
         2AJBfbOeO29aqK5v6AmlaFx0RYII991CZbMukakbqLIO4du0OuxtlVWII7KDNNZmn4P2
         DYqHkd9w0uUCs/k+88fcgtRNB1D9h7El0WtdpDU9IYwpfeTXldK2PRlt0Vw7rnR8ni2o
         CYKg==
X-Forwarded-Encrypted: i=1; AJvYcCVAazTI28AbwPFUIcfpZRHWxHfXnZVsIVZebhhKNK5s2HtHMccZtJx/erKkdahHL33yfT86xd0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzm5IAyZZarSaQWy4jYJRqKGCpF54O7TJ0ueIMnz0QJOQ/DShN9
	mrvUHPx8gAYVtW3OAbcAsF0iOLSNsb4FhZjyke82pgOxTtbJmz2soQGg
X-Gm-Gg: AZuq6aIouY7nyYcmds2sNUk0RtSksTQKkJb1jTk3wbifGRbWEgnb9L2XXFpS9Y1L1Ky
	muYv2tMTCrzB4fkAf+AwqHmqFs6HqRs5Gf6QkGeMmfhtqIvYkyZoJGLPEqWHjiRuG/ooqohcAy3
	+v2EFafE6OczMg7ieR3vJNxLaSOif5MyWOIl3B6ciQJI7kLjxr6YsSbEZVLhvSdFPMuDtS83YrN
	aPMd4QRaKEBjjEYQcK8fXJ7QFFor4mEfedZNrFnPwZV1f5Y4/fGr5/gYrlSFpQjvF0XZ+DjcAC8
	SwYNCCMa+IcIoPn9KoY73OvEQ0up1nVJmY+0uN3DDW18iNk4oK7uDUQ8+nuBM6a57SXnxSk0Dkj
	AT/+MKsW2lzdxdLDdVxx19AgLrlJoL6j3lko9pcMQXl6u7L2nyppdDXRv3P0c2FXq8R7Eg79Fck
	5ZHoQZoqQqzjk0fOB/VYs3EySFWVVancFgibzsnUzc
X-Received: by 2002:a05:6a00:244d:b0:81e:2bca:d133 with SMTP id d2e1a72fcca58-81fe87dcc5emr4313356b3a.24.1768977661233;
        Tue, 20 Jan 2026 22:41:01 -0800 (PST)
Received: from localhost.localdomain ([121.190.139.95])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-81fa10bda5csm13898092b3a.19.2026.01.20.22.40.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 22:41:00 -0800 (PST)
From: Minseong Kim <ii4gsp@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Minseong Kim <ii4gsp@gmail.com>
Subject: [PATCH v2] Input: synaptics_i2c - guard polling restart in resume
Date: Wed, 21 Jan 2026 15:37:38 +0900
Message-ID: <20260121063738.799967-1-ii4gsp@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.46 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-210702-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ii4gsp@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 98EAE523D4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

synaptics_i2c_resume() restarts delayed work unconditionally, even when
the input device is not opened. Guard the polling restart by taking the
input device mutex and checking input_device_enabled() before re-queuing
the delayed work.

Fixes: eef3e4cab72ea ("Input: add driver for Synaptics I2C touchpad")
Cc: stable@vger.kernel.org
Signed-off-by: Minseong Kim <ii4gsp@gmail.com>
---
 drivers/input/mouse/synaptics_i2c.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/input/mouse/synaptics_i2c.c b/drivers/input/mouse/synaptics_i2c.c
index a0d707e47d93..fc65e28c1b31 100644
--- a/drivers/input/mouse/synaptics_i2c.c
+++ b/drivers/input/mouse/synaptics_i2c.c
@@ -615,13 +615,17 @@ static int synaptics_i2c_resume(struct device *dev)
 	int ret;
 	struct i2c_client *client = to_i2c_client(dev);
 	struct synaptics_i2c *touch = i2c_get_clientdata(client);
+	struct input_dev *input = touch->input;
 
 	ret = synaptics_i2c_reset_config(client);
 	if (ret)
 		return ret;
 
-	mod_delayed_work(system_wq, &touch->dwork,
+	mutex_lock(&input->mutex);
+	if (input_device_enabled(input))
+		mod_delayed_work(system_wq, &touch->dwork,
 				msecs_to_jiffies(NO_DATA_SLEEP_MSECS));
+	mutex_unlock(&input->mutex);
 
 	return 0;
 }
-- 
2.48.1


