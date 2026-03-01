Return-Path: <stable+bounces-221259-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MAGVG5mTo2khHQUAu9opvQ
	(envelope-from <stable+bounces-221259-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 02:17:13 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FBB21CA08F
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 02:17:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 38EE53019FF0
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 01:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E84423C4F2;
	Sun,  1 Mar 2026 01:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dt+SESX7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 508AE207A32;
	Sun,  1 Mar 2026 01:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772327825; cv=none; b=VuPVoVpOBykn8kzsLa2d3XLe8tzwWmn8AZ4EvnjcEExwJvyWsUsKILc00hFtqe/JZV3Bc63bPHAi2r2LrbhRFhOSXQoEvXt5js+l9lrOEKVBQWZAaBmCIrbG3eAUs1/jTyOT5B/jbZBPl0XTm7H1tvFs2E5qXeO0yz3AxBnrq6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772327825; c=relaxed/simple;
	bh=x9qs5BZNYmkmUXV41y0KEx9ZYOMew/fE5gQQXaKz2Eg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o7PO2D/Bo7xlfLA69trwEJ4k3V/glWR8/avw4bJExSdtdID1+YOz3b/3XT1GVRjVMlv2Edhle3/9vJxdNCjhtL0Xn8eFC5Yk105/EiljDMmMhTdjwmI/tY4QgmxEHdjCzudgdMba7ub4GE1sP7zQ3T7BUl9Z88LIYJTPGPUXlNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dt+SESX7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4F40C19421;
	Sun,  1 Mar 2026 01:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772327825;
	bh=x9qs5BZNYmkmUXV41y0KEx9ZYOMew/fE5gQQXaKz2Eg=;
	h=From:To:Cc:Subject:Date:From;
	b=dt+SESX7hEjLHCck8Cj/58XdYwaCKToSaeZcJ2+bxbgg+9WfACfOgyk8nL5vvD+e9
	 THYml6+Xdk52tf2VLnAn2eDWIENEAbCakIiFAorr8kSbpTS6Tsj+zZApbEE4l78yGo
	 vh5I894Ix4wAjZKDPeYwmuVZVDo84ndcXFjHW31FxLdUpSfrc/ag6ElP+dd+LX8zla
	 lEjKOlh/VVuwAYnXFtHWBHNppRg3PIrbznmFA/RjHH39H8C1cxSqxd8yZPotG2TX9J
	 YGsgsCd38uZ2IGfeGl59zGvE2QHr09dYGL/8RNcLJf+fqFaK2+8KJqnBClQ2ZsLqah
	 WZCYqFCMtgC+Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	ii4gsp@gmail.com
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-input@vger.kernel.org
Subject: FAILED: Patch "Input: synaptics_i2c - guard polling restart in resume" failed to apply to 6.18-stable tree
Date: Sat, 28 Feb 2026 20:17:03 -0500
Message-ID: <20260301011703.1670858-1-sashal@kernel.org>
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
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-221259-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2FBB21CA08F
X-Rspamd-Action: no action

The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 870c2e7cd881d7a10abb91f2b38135622d9f9f65 Mon Sep 17 00:00:00 2001
From: Minseong Kim <ii4gsp@gmail.com>
Date: Wed, 21 Jan 2026 10:02:02 -0800
Subject: [PATCH] Input: synaptics_i2c - guard polling restart in resume

synaptics_i2c_resume() restarts delayed work unconditionally, even when
the input device is not opened. Guard the polling restart by taking the
input device mutex and checking input_device_enabled() before re-queuing
the delayed work.

Fixes: eef3e4cab72ea ("Input: add driver for Synaptics I2C touchpad")
Signed-off-by: Minseong Kim <ii4gsp@gmail.com>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260121063738.799967-1-ii4gsp@gmail.com
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/mouse/synaptics_i2c.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/input/mouse/synaptics_i2c.c b/drivers/input/mouse/synaptics_i2c.c
index c8ddfff2605ff..29da66af36d74 100644
--- a/drivers/input/mouse/synaptics_i2c.c
+++ b/drivers/input/mouse/synaptics_i2c.c
@@ -615,13 +615,16 @@ static int synaptics_i2c_resume(struct device *dev)
 	int ret;
 	struct i2c_client *client = to_i2c_client(dev);
 	struct synaptics_i2c *touch = i2c_get_clientdata(client);
+	struct input_dev *input = touch->input;
 
 	ret = synaptics_i2c_reset_config(client);
 	if (ret)
 		return ret;
 
-	mod_delayed_work(system_dfl_wq, &touch->dwork,
-				msecs_to_jiffies(NO_DATA_SLEEP_MSECS));
+	guard(mutex)(&input->mutex);
+	if (input_device_enabled(input))
+		mod_delayed_work(system_dfl_wq, &touch->dwork,
+				 msecs_to_jiffies(NO_DATA_SLEEP_MSECS));
 
 	return 0;
 }
-- 
2.51.0





