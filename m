Return-Path: <stable+bounces-258534-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6O8YLUIoG2ra/ggAu9opvQ
	(envelope-from <stable+bounces-258534-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 20:11:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B0EB611329
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 20:11:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9303E3007512
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 18:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 873A63B3896;
	Sat, 30 May 2026 18:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SdJUjMCc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B08439A7FE;
	Sat, 30 May 2026 18:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780164672; cv=none; b=E3YIxsKfGEkyKeVGsIMsJS7zQbKPrfiNcVimu5OTH3zlzA/hDOVs95znw+aiVoIngQ4V0nJg7bY0t7ikRq3/eZP0O8cYwmpowTj8z8UFO1EEr3l1kow8BgH7NP5q0PNiNiRfCGgyvuQMSyQA9qmS2waAUHtBj7ePsXYIiGgYYAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780164672; c=relaxed/simple;
	bh=W/DN/RPDp7ygsAwW+PjuXSjxWs4vb56fj5zVEK+JXiU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i1riVfzx9pVuh6gnS7Ocn9Y9j36BSoFRo8zxfQ0/G9JlErhdC+9CznY40jgcCGcjSNRVFBHRQsGc0zJrNmR9Z6LqrneRt1vWhzINNfKA3MWUV1Ju6G4vPnXOfOb1MDlfhci5HmVr9NSeInzrRKT+eHw22oH7K8BM66i/Prc0h6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SdJUjMCc; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F76C1F00893;
	Sat, 30 May 2026 18:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780164671;
	bh=9Ry0INinSW+WT7Ci4BZiFpD+12Lr/Vux4gX0YKy6Ep4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SdJUjMCcfhAR+qI+yCZIOyh1rbkVVcqbZc/8O73RuuiBiU+vCMt6+8QAMZp0d7pfs
	 caMhsIZe91jdqgAjBQ6oz0QWYjXQl40gdqk9qMildvBirCsfAQQIuWM1+wObRc4Lgg
	 4dqHMkbSjBWxeREElK15ADumIwHgGzqFSMQiJRZ0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Anthony Pighin <anthony.pighin@nokia.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 595/776] rtc: abx80x: Disable alarm feature if no interrupt attached
Date: Sat, 30 May 2026 18:05:09 +0200
Message-ID: <20260530160255.423604210@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530160240.228940103@linuxfoundation.org>
References: <20260530160240.228940103@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258534-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 5B0EB611329
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Anthony Pighin (Nokia) <anthony.pighin@nokia.com>

[ Upstream commit 0fedce7244e4b85c049ce579c87e298a1b0b811d ]

Commit 795cda8338ea ("rtc: interface: Fix long-standing race when setting
alarm") exposed an issue where the rtc-abx80x driver does not clear the
alarm feature bit, but instead relies on the set_alarm operation to return
invalid.

For example, when a RTC_UIE_ON ioctl is handled, it should abort at the
feature validation. Instead, it proceeds to the rtc_timer_enqueue(),
which used to return an error from the set_alarm call. However,
following the race condition handling, which likely should not be
discarding predecing errors, a success condition is returned to the
ioctl() caller. This results in (for example):
    hwclock: select() to /dev/rtc0 to wait for clock tick timed out

Notwithstanding the validity of the race condition handling, if an interrupt
wasn't specified, or could not be attached, the driver should clear the
alarm feature bit.

Fixes: 718a820a303c ("rtc: abx80x: add alarm support")
Signed-off-by: Anthony Pighin <anthony.pighin@nokia.com>
Link: https://patch.msgid.link/BN0PR08MB69510928028C933749F4139383D1A@BN0PR08MB6951.namprd08.prod.outlook.com
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/rtc/rtc-abx80x.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/rtc/rtc-abx80x.c b/drivers/rtc/rtc-abx80x.c
index 2ea6fdd2ae984..651270e5f1e66 100644
--- a/drivers/rtc/rtc-abx80x.c
+++ b/drivers/rtc/rtc-abx80x.c
@@ -836,6 +836,8 @@ static int abx80x_probe(struct i2c_client *client,
 			client->irq = 0;
 		}
 	}
+	if (client->irq <= 0)
+		clear_bit(RTC_FEATURE_ALARM, priv->rtc->features);
 
 	err = rtc_add_group(priv->rtc, &rtc_calib_attr_group);
 	if (err) {
-- 
2.53.0




