Return-Path: <stable+bounces-270147-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id tkgyO4L9RGqK4goAu9opvQ
	(envelope-from <stable+bounces-270147-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 01 Jul 2026 13:44:02 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 43BE46ECEE4
	for <lists+stable@lfdr.de>; Wed, 01 Jul 2026 13:44:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=Zeq1BMag;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-270147-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-270147-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A0D2C30C25D5
	for <lists+stable@lfdr.de>; Wed,  1 Jul 2026 11:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EF1B47DFB8;
	Wed,  1 Jul 2026 11:40:17 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC2C40681D
	for <stable@vger.kernel.org>; Wed,  1 Jul 2026 11:40:14 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782906016; cv=none; b=qUWJ/+UsdWN5mw0m4PX7QZCHeHQeP9lQ3XRziRFhqSn6DH69vc9bNgYI0EABpBwEuqUAQZ8zJpJ1nLquspVK0YOKZiDjXvsSOKPcxaStT1DQ3OyvEFA/vKKppbnfRof1ksTBVwcuwPNJwrUdHO6e85Wg+1dUqGT0BHJB5H6eGYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782906016; c=relaxed/simple;
	bh=Re5sa46Y0/VZaCjTaqs6KcFdiUfTXL1/i5WhJPbAY0g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=erxWSaS1ufGOVWXRMjKW+INgBQ1DUkoI0ZPzOMEGt0QomHdjsITbD3JHQvs6zcuG/iFvgUQ2xX2gxKMdUDNi9oIb/0nW2VVDtamQ7rHOQMAo7OjX18Xf8MCSxcUadnJrvx+qhjBui55WYXP8hYcr3BF0YIoEXsMQtBhAJdZYbuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zeq1BMag; arc=none smtp.client-ip=209.85.216.49
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-38060005f1cso877228a91.0
        for <stable@vger.kernel.org>; Wed, 01 Jul 2026 04:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782906013; x=1783510813; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tyFzszev+usYq40ARSSCzs6vScHOVyEQ8o7LSEdBPeA=;
        b=Zeq1BMagXyXrIpheTCUhmTFpi681odKjO7oUFvzPo8uDISU4mYvQ0ei2lxOST8SAse
         qspQvXVHRkddFdERTTzR2gcTYcGK5xAQKhT0cPeCTdgigj8vQ1CUaOepPdLs0krACZcU
         JyX19Xyy4G1QqWYzOsGPBADq7bf2VBOcETrg+Bsxt1iMFXA3Gq3mO/f20V7aHRL5bjP8
         i0N+Jct54lPBnn/lwBFLLjaJYs8NIconncmcJr2gsF92isAdArlEHhcU1eKLGo6p71b9
         MZ22SblD4HrCJ1U4AJrbTHn33DDPtRTIUIYhi1ipSpvvRdwwJpKueBemz3wqOWRnGG2g
         gaEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782906013; x=1783510813;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tyFzszev+usYq40ARSSCzs6vScHOVyEQ8o7LSEdBPeA=;
        b=rWZfMqGzs8cC2XL3R8iz3RyNOMnXAPcKlAThQjbev2Gc5kcf/bfFj7fsdhKtGFh7Mx
         rTcWRzoaRfheAHatAk1SkmxNX/h6/Ru57v3NVev3d2U65KGzrhFy93n9bBSjd9TFLdTr
         70JBEU8C/ij0usJ0HIgkzVYRdrQ+fmg5QV8qPFmWW8eaLbhxQDi8cJA1Gvl7YJq1qXze
         TuqLOW5OCxq4uLiIdGiQHpJMpqDq/uuZlZbDRdqCQ6oWtRT4XJH731nGVW1AYJGTeOLc
         ug0QRbG9qwCck+pDfY78rZOVKDjg/n0mq6t2dwupk/PQo2UsNPB9NzQ7ZoYq3dKJwfhV
         9w8Q==
X-Forwarded-Encrypted: i=1; AHgh+RpT8DSw2hT+oHPA7LPo20ebGKZq49Xwb707xe79qO8fA74NgtZlTrA5JIWhjJzUfq55EUYUm64=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxfzx37r2C6lJiExDo9x8p9UOlBbqIBskDzcJ+msw1Yzl9jSO7L
	wfbJ0JfNi35/OyJDnJvi5k1SHfRqUjKreOiHwLw7oV60e6qCQO8qO3c=
X-Gm-Gg: AfdE7cnwLZlD2c0Iizd4CtgwiUX3k2IHhJK0x18mxmvVpD57EtYopXIATKXVFo1rz2s
	o0O/8e0iFprYgz0ZncfN6ikUqMKA1kX3571aE3z/Q/7zTY/xIMHy9xeyv7b4zZQwdTCFrQ4TSdq
	64gU0g2lyD+uRFFAMnvxKxPxPEU/E/UXerqBefgRjC049wEcywXYyieqQzDMWPbIEwziDuFq51b
	gwmDu6zrXfmKSNHyRsYHgxNh75uqkgp5odFUw/01zPnKft3NQJTKMYvKGX1uZf8SyMH6nqXxS1N
	zAYvtkHfNfUPV6u9BNm2C31M5SbjhJC3vNW6fSyJtjSA8ZuT+b1dQfGDqF188y/RiBZ6Ng5MDEV
	e5uM/1HCtPnmwsvmLYjds+IBYads7jug0b/BqCh5ww7a2oORRBrRq/Ef8N+Ej2IUQ2LU5PxebAu
	AZ1sf/mORU/b/mcT9ZqUPqA3NE/7bUnEYmFpSDr/3LhbLzm0h45lloGvgZ0htc3Ndrx7iQJrEhA
	nppGITDEclfvNeuvcA6LbT49kyqm22PEKkhOrfdvfmBkz23taLPiDU5cKbb
X-Received: by 2002:a17:90b:3945:b0:36b:de66:92c3 with SMTP id 98e67ed59e1d1-380695868demr4370404a91.10.1782906013540;
        Wed, 01 Jul 2026 04:40:13 -0700 (PDT)
Received: from localhost.localdomain ([14.5.152.27])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38095e83b6csm1776277a91.8.2026.07.01.04.40.09
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 01 Jul 2026 04:40:11 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Myeonghun Pak <mhun512@gmail.com>,
	Ijae Kim <ae878000@gmail.com>
Subject: [PATCH] usb: typec: anx7411: use devm_pm_runtime_enable()
Date: Wed,  1 Jul 2026 20:40:06 +0900
Message-Id: <20260701114006.75738-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-270147-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:heikki.krogerus@linux.intel.com,m:gregkh@linuxfoundation.org,m:linux-usb@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:mhun512@gmail.com,m:ae878000@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[mhun512@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhun512@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 43BE46ECEE4

anx7411_i2c_probe() enables runtime PM before returning successfully, but
anx7411_i2c_remove() tears down the Type-C partner state, workqueue, dummy
I2C device, mux, switch and port without disabling runtime PM.

Use devm_pm_runtime_enable() so runtime PM is disabled automatically on
driver detach. Since devres action registration can fail, route that
failure through the existing probe unwind path.

This issue was identified during our ongoing static-analysis research while
reviewing kernel code.

Fixes: fe6d8a9c8e64 ("usb: typec: anx7411: Add Analogix PD ANX7411 support")
Cc: stable@vger.kernel.org
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
 drivers/usb/typec/anx7411.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/typec/anx7411.c b/drivers/usb/typec/anx7411.c
index 604868ebf422..41df115912b9 100644
--- a/drivers/usb/typec/anx7411.c
+++ b/drivers/usb/typec/anx7411.c
@@ -1537,7 +1537,9 @@ static int anx7411_i2c_probe(struct i2c_client *client)
 	if (anx7411_typec_check_connection(plat))
 		dev_err(dev, "check status\n");
 
-	pm_runtime_enable(dev);
+	ret = devm_pm_runtime_enable(dev);
+	if (ret)
+		goto free_wq;
 
 	return 0;
 
-- 
2.47.1


