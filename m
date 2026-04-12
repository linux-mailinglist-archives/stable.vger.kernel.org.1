Return-Path: <stable+bounces-235801-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GPfkFQhI22mg/QgAu9opvQ
	(envelope-from <stable+bounces-235801-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 12 Apr 2026 09:21:44 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B8CD93E2FD8
	for <lists+stable@lfdr.de>; Sun, 12 Apr 2026 09:21:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 432F53014646
	for <lists+stable@lfdr.de>; Sun, 12 Apr 2026 07:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 853812DB7A3;
	Sun, 12 Apr 2026 07:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V/7+vswS"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4053727A107
	for <stable@vger.kernel.org>; Sun, 12 Apr 2026 07:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775978487; cv=none; b=cnO9LsFMM0rfIvYO/Jsh4tWbCjYoBk2cSphh51wUv1W5EBcK38DZUHI6iH03hgcEV7N60Gqy/QvofcAFI+/lXwMWyPq3wd5XA4kHc4JNgb75L9LlGiic71c0W0gLUpSYSlBGmaA7iH2azW4+Ek0vdDomfYQvXrKg3pcZdUWeT9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775978487; c=relaxed/simple;
	bh=nbHz2BmQ1oP1wZT0NjNprtGrX0V9J7CUG72G1oQFhsM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=niddkMgaYObSVtkWk00IQNqVB/kY+RGQilCHQMeX7Hi//9HVaBx0IqHOnnIOemqozImKTDo2gWoaJ+8M+jZvpR0BJiEwPJCP8wNws4ypY49B874a6L0QYRmnrMTybJ23RUVu8MiyZ1Mx69HkHsh2syPktf4r0RRdQ4qgfpoWXyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V/7+vswS; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-35d99031e4eso2046859a91.1
        for <stable@vger.kernel.org>; Sun, 12 Apr 2026 00:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775978485; x=1776583285; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GDIIM2YOn1/RAWDIAFXQVjX+5NzXl47IB6XB/yelA6s=;
        b=V/7+vswS2Vc5fzlkk88tQlbA0HXkn8bWynWdy9oTm8RU+JR/Nb58pDh2vJmaBfQHCn
         Ag+hvdyqU2G87UQVioDGqoq9g03GiAVx3EhjuZGrbW6IUnTHdDPy4UDn5l6JqU9VIdqP
         Pr4eRyfP8YgqkL5REsABdWMUDOb1DhEKYiyR9/DcrcN16bn6608O3SodN4IoCmtOvvqd
         c0EzcpzfRb6vobEkiILOW/GlRtmvF9y/6Y3u1TAjN14x2+oD2F0HlqGY6QsITK91IGYy
         2utFsdR7fRgIbm8FORZzdHmcp4KzWN7NFJKAi99GtQAF/2vehELOhgvhYDAYUzub3vwH
         9VwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775978485; x=1776583285;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GDIIM2YOn1/RAWDIAFXQVjX+5NzXl47IB6XB/yelA6s=;
        b=Zjc+/TE3M4H1ThKkDC6GXlsx8hOG+kH/OsaJTj68YWHR+Y33hp0fMZ2W+xveqTuPyH
         gCVQR4YVOrUGB0cENVLpscVuDUV7SKjYzPGhHOcb1KGL6YxBJ4iiSuVBeO7MIydm4u6O
         OP7jvK+YW+FIA3YLBwhGjRdiVQbigtq5pF0y4RXKygNdrLInxsCP6rf+Q1Gqy3pfWJXV
         v2I+kYcj533iB/nEG3VOMwyK19QBjkEkOheTvIKL9dzaFhwQXXZOSNSMgKN0wEC1Aw+f
         us/DQN1963xoyC7nAqcSnu+1985EYXHH6ISCiSmuiBVisQ6XNjG9rPcfjsRTMh/PjFgj
         OD4Q==
X-Forwarded-Encrypted: i=1; AFNElJ8kngDSmlSd1kuG4FwuNTHkWdqtiE/y9y/POwzfpAp5s2t1EO1L9JbuLxaIyX5uirkecKcqS40=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYlnBcamMGfGBx6U90MhskY514S8fMcV9Ogi9AZjKJ+mxG9jjU
	UExKyYDa99qic13mhiPG9/KFSbVFvxRhxADvi5RDltp6xjArxPTkLuuN
X-Gm-Gg: AeBDiet0Asnh8SvBvpx/eOPHyySzOkAii7LRRWWR4+SUnjn0tOB1Vyfny3ZpUwazpKD
	6QnomeXQWscdxK7EXy6+tNayYjBQ3/aK4Iyytf6cejgzzs6kdozBTN6UiHJA8Sg6yXwiTPdIuI+
	lN0Uac/W2/fur53Jo01+WcGKaUYbINa93X/o0libb16EzcULJ/c9Qy0BuyYzRE2whl59Lsbyi2c
	0SV1WoqYFUUWTwtzgqaRjMJq3To0Y7q/MUrIh+MBfrGMZGEGXTr1yq0D3Hruygfj/iAHcTnbvac
	iW1kPtOkqmPC+AyEBsEJFMcGrBzSqa26DANarmCLZTclyykuyLnAELerbn25tnQJV2Os2nHToLg
	8H1ceyr2zt6/V/xEFugiOhLZaR7NCSrO8Vk/F9jaOsJV0M6RspGGoL1uWZp1B5+H70IMSj+pDDy
	SH9mu+Hk3igUw81PpXhyqQMO1qRQ==
X-Received: by 2002:a17:90b:4d0e:b0:35b:90e7:c44f with SMTP id 98e67ed59e1d1-35e425381c6mr9521661a91.7.1775978485552;
        Sun, 12 Apr 2026 00:21:25 -0700 (PDT)
Received: from lgs.. ([199.182.234.55])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35fb37d6e36sm477425a91.16.2026.04.12.00.21.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Apr 2026 00:21:25 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Eddie James <eajames@linux.ibm.com>,
	Ninad Palsule <ninad@linux.ibm.com>,
	Joel Stanley <joel@jms.id.au>,
	Jeremy Kerr <jk@ozlabs.org>,
	linux-fsi@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] fsi/core: Fix device reference leak in fsi_slave_init() error path
Date: Sun, 12 Apr 2026 15:21:14 +0800
Message-ID: <20260412072114.2418511-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-235801-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: B8CD93E2FD8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

After device_initialize(), the embedded struct device in struct
fsi_slave is expected to be released through the device core with
put_device().

In fsi_slave_init(), the cdev_device_add() failure path frees the slave
object directly instead of dropping the device reference, which bypasses
the normal device lifetime handling for the embedded struct device.

Since this path has already allocated the minor and taken a reference to
the OF node, switch it to put_device() so the cleanup is handled through
fsi_slave_release().

Fixes: 371975b0b0752 ("fsi/core: Fix error paths on CFAM init")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/fsi/fsi-core.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/fsi/fsi-core.c b/drivers/fsi/fsi-core.c
index c6c115993ebc..444878ab9fb1 100644
--- a/drivers/fsi/fsi-core.c
+++ b/drivers/fsi/fsi-core.c
@@ -1084,7 +1084,8 @@ static int fsi_slave_init(struct fsi_master *master, int link, uint8_t id)
 	rc = cdev_device_add(&slave->cdev, &slave->dev);
 	if (rc) {
 		dev_err(&slave->dev, "Error %d creating slave device\n", rc);
-		goto err_free_ida;
+		put_device(&slave->dev);
+		return rc;
 	}
 
 	/* Now that we have the cdev registered with the core, any fatal
@@ -1110,8 +1111,6 @@ static int fsi_slave_init(struct fsi_master *master, int link, uint8_t id)
 
 	return 0;
 
-err_free_ida:
-	fsi_free_minor(slave->dev.devt);
 err_free:
 	of_node_put(slave->dev.of_node);
 	kfree(slave);
-- 
2.43.0


