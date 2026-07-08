Return-Path: <stable+bounces-272648-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id GXuBNjtKTmoYKQIAu9opvQ
	(envelope-from <stable+bounces-272648-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Jul 2026 15:01:47 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A8FB7268F3
	for <lists+stable@lfdr.de>; Wed, 08 Jul 2026 15:01:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=F2Rt2U9X;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-272648-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-272648-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A745C3037E48
	for <lists+stable@lfdr.de>; Wed,  8 Jul 2026 12:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72B034657C4;
	Wed,  8 Jul 2026 12:57:39 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0175745104C
	for <stable@vger.kernel.org>; Wed,  8 Jul 2026 12:57:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783515459; cv=none; b=QXhYQUYCJOHEPKULGiCZXZwqXd/P82+9iVJkTZnFUrHBiX6w/m/dJm4s35d6qHLDer1dF0YYaYdC3+AZREAhUqTTiiswU72z+WmRf8GaEbCjw3Fwr8Fhpn4CA/um+7qhdQuaPoKFwWqiprtEWCjjF8qPZbn6vMR73vBuI3Yd3F8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783515459; c=relaxed/simple;
	bh=UrE93zXjZyxA/Ev+jUp9i7tYXbt2bq4qQ3/zk7AAZ7I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VghC6VOv/MPMxdpDEftiA9lyx+4Jr/yEUmfP8trd4tn5+R79whX+eObG+qMdLsyr6QdEl/J8s2mKoEASQbwg/w9JHwBuxbfj2/3A27wYVKDHyhn2tWa08C6P9JAI5jtl3v7+tuMrdR/uBroT7Vq4qr+czjA3P5jDyVznv7TNa1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F2Rt2U9X; arc=none smtp.client-ip=209.85.214.182
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2caea3f742bso11113025ad.0
        for <stable@vger.kernel.org>; Wed, 08 Jul 2026 05:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783515457; x=1784120257; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PTfotfcn9VWnxLom7GLVbOHjhNjkRdM3f9UH7tzHbYQ=;
        b=F2Rt2U9XKAM3hMRLQF1GisrFP/4fiMdN+hbpU5NLCFLKPoFuZzggqgzoKuTS601P0u
         uU8EdD4s6328oWb7byNj+Jmh5dKxZrtGPG0/5XSt1unRkTILF9jvumzLJdWzTCC7hYY8
         VsT0y+fK1jsVUcIgMYCZGVSQGrQ9TB0Bl9gd4x28K7pz7aZ7SsJDEbOVNcjfYhTeKDp4
         5FikvAYQNslmcrGFKHHynUxhlHyZKFo/OGGD+wZ7EgDKox5IpfnaKlBmFppFoUhHS69f
         q6WQhrbcvMD2VxC7B666Eqr1ONp8UaDvto+y1BoGbwhnkpcBNjDLVVcXbjorKe948xXc
         3AgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783515457; x=1784120257;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PTfotfcn9VWnxLom7GLVbOHjhNjkRdM3f9UH7tzHbYQ=;
        b=DS/eTIaajOrANSuyEXzAXBOwaFCIKtPPKVxYsbmNGy4XlXlA4rYGOSpWzdyuedSkjd
         MSzVguTkq2le4XmCT2yVGZyT+rP/CNd9RplrM2SBajqa6W4YdnM0CqJCw4G9wWUe/+BG
         XjrT+on7hUFFpcYv5ullOOePOmZxNH6tkrHm6w7aIBPDbOqMYNtzmkk34vNQnNqRAIB1
         Jw/5dy0RHesUXUBGlEg6DwYiQRZkCi/FyFru5o0xVm5vsvGv+RIK1vgYyZk7eBFsqaXU
         iSYZuKcJ4rujHWmPbpX7zchx83S2a5WmogfF7p11NaeJU/4EQF5wgu984POfY4gwlsAv
         1UFw==
X-Forwarded-Encrypted: i=1; AHgh+RqPIayYFWPXwxepUF2lCnvg/afNMhbmrdnHD8lh/o3vAbxqNKn5mIhv6ys37BgmtnEgM2uWm6k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfRkAmQadcP3qIQSwIE1DclIH9PhB09RMBrY8hNhLgwkhbYFVT
	6KK84BtXUXwuvQXP74pVyU+KouLzQ+IdOlgpnHGbdx/B5lhN/vGX5G1p7R9+XYY1
X-Gm-Gg: AfdE7cnM2wBjLvWtMKmXELkWtQ56ZKzzHVkQhckxpTEYSm8HecaDCNGm+snKolD/F3M
	tekCpnMxFZ4vk16YwIX7Troy3mGXu86+oFa+X7T5xVJQowfMt5WB/u+6g4GRnjF5zpMoL2vVzoO
	O6e4uJ9wZhmQcV+K07IebKLBEZFfOfWDBfY/L8YOh4Ipsfv2+FjbeGy51B5Sdr7QfqSb4vpHkhl
	CCjTn1jIzUEZxYdBdqVJyrPaymWSxgqx+Cs7rZZ5Lt1TIfl1PbF1kpsPaUAZBG9DPCY8uZfnAtR
	NGCcBRTTH5O6KVctJcobyyJm1ToQZS7P0TlC41WWHQYlcVI/tUQ4kPViPYMHkij52L9Ak5nJjaa
	IAHkVddQ+U8Hzi2E2cCtdG84svy+dp0F1UMAby6HZGTZ8A09o/dLxHuXRkp7/vw8GxspuVKmn0i
	em/+8k6PJeRq2xmh0bQJH/87cTMnxhqYh82Y4rOXVGnkI=
X-Received: by 2002:a05:6a21:3383:b0:3bf:b960:6fc4 with SMTP id adf61e73a8af0-3c0bccd3a30mr3293274637.30.1783515457214;
        Wed, 08 Jul 2026 05:57:37 -0700 (PDT)
Received: from localhost.localdomain ([49.207.223.101])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31174accae5sm30299087eec.29.2026.07.08.05.57.33
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 08 Jul 2026 05:57:36 -0700 (PDT)
From: Biren Pandya <birenpandya@gmail.com>
To: sakari.ailus@linux.intel.com,
	mchehab@kernel.org,
	songjun.wu@microchip.com,
	wenyou.yang@microchip.com,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Biren Pandya <birenpandya@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 2/2] media: i2c: ov7740: fix use-after-destroy in remove
Date: Wed,  8 Jul 2026 18:27:23 +0530
Message-ID: <20260708125720.27156-6-birenpandya@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260708125720.27156-4-birenpandya@gmail.com>
References: <20260615210412.34567-1-birenpandya@gmail.com>
 <20260708125720.27156-4-birenpandya@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-272648-lists,stable=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:sakari.ailus@linux.intel.com,m:mchehab@kernel.org,m:songjun.wu@microchip.com,m:wenyou.yang@microchip.com,m:linux-media@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:birenpandya@gmail.com,m:stable@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN_FAIL(0.00)[1.2.3.5.c.f.2.1.0.0.0.0.0.0.0.0.b.d.0.0.1.0.0.e.a.0.c.3.0.0.6.2.asn6.rspamd.com:query timed out];
	FORGED_SENDER(0.00)[birenpandya@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[birenpandya@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RSPAMD_EMAILBL_FAIL(0.00)[stable@vger.kernel.org:query timed out,stable.vger.kernel.org:query timed out];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8A8FB7268F3

The ov7740_remove() function had a severe teardown order bug where it
destroyed the driver's mutex before freeing the V4L2 control handler
which relies on that mutex, leading to a use-after-destroy kernel panic.
Furthermore, the driver explicitly called v4l2_ctrl_handler_free() and
mutex_destroy() sequentially, but then called ov7740_free_controls()
which invokes both of them a second time, resulting in a double-free.

This patch fixes the issue by unregistering the subdevice first, and
relying exclusively on ov7740_free_controls() to safely tear down the
mutex and control handler in the correct order.

Fixes: 39c5c4471b8d ("media: i2c: Add the ov7740 image sensor driver")
Cc: stable@vger.kernel.org
Signed-off-by: Biren Pandya <birenpandya@gmail.com>
---
 v2: added Fixes and Cc stable tags.
---
 drivers/media/i2c/ov7740.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/media/i2c/ov7740.c b/drivers/media/i2c/ov7740.c
index 2d29147c0f647..b4e14171556f9 100644
--- a/drivers/media/i2c/ov7740.c
+++ b/drivers/media/i2c/ov7740.c
@@ -1116,10 +1116,8 @@ static void ov7740_remove(struct i2c_client *client)
 	struct v4l2_subdev *sd = i2c_get_clientdata(client);
 	struct ov7740 *ov7740 = container_of(sd, struct ov7740, subdev);
 
-	mutex_destroy(&ov7740->mutex);
-	v4l2_ctrl_handler_free(ov7740->subdev.ctrl_handler);
-	media_entity_cleanup(&ov7740->subdev.entity);
 	v4l2_async_unregister_subdev(sd);
+	media_entity_cleanup(&ov7740->subdev.entity);
 	ov7740_free_controls(ov7740);
 
 	pm_runtime_disable(&client->dev);
-- 
2.50.1 (Apple Git-155)


