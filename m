Return-Path: <stable+bounces-228231-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YHVpEXFRwWnqSAQAu9opvQ
	(envelope-from <stable+bounces-228231-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:42:57 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DFC372F50B2
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:42:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 801FA31C6D9D
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 14:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C31A33B0AF7;
	Mon, 23 Mar 2026 14:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IUxUDVi+"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B313B636B
	for <stable@vger.kernel.org>; Mon, 23 Mar 2026 14:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774274523; cv=none; b=BunejI/KGMiB443zqRfzk7+iIHYis/cr291PkjypzYkn79NN0zIKWj8++3Dv2B1Pn9rm82b+6h5P2ldgoHkkw+fACceBF/06ssjREYikNxyAzfDo4MovtpiKz9jgdQsama3Ptt2aQNkKAxFb39B00nGr3LHNiOFrpy3vimZOl+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774274523; c=relaxed/simple;
	bh=v5RkR4GWFbiro/iChqZK9upkZLemhscU1rQeqe+R85Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SXiU+yCTrfG1MaX7UNeXQFp8trfroEmhHk962rzL59i9Ro/JaxAsvZiHQfkaIa+bRVHVmkj/XL00o/lwYZP3Da2vvRJJ0/o/ANUiX0Rqde/kBE8p0gKaeU9qHTi+W3mwrXIzGmkUiP22mbQ+o2oOrnewcytal4t0sML73jCYxR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IUxUDVi+; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-829781b2b01so144578b3a.2
        for <stable@vger.kernel.org>; Mon, 23 Mar 2026 07:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774274521; x=1774879321; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=x9LErbosuoksV5lU780U3bAHDdZ81QQelsqNoxIkru8=;
        b=IUxUDVi+mscfx4KdLWQjbDYnJkMSXgk9mcPTX9TuC6V434ce6C8aUKEKi5EW+qxkwe
         n0+F8SXEpOQeXdPookeTOvb1FbY7IJGHuxhiK+piYLZKXye1swP/0W5JmjsKlvzYxMC9
         dTE4EH3FeHKOmo7AKjzcFtbFZIjJFw2rt5xmWEnhARV69iEbePF64kjk8e9sh1m5/qLd
         eb+l9iiv6GLzb+h0CJ95forUw8qaIUg/KcuYM3vqGaF0HJEdGkUC/6lwSFr52pVSOvKc
         ctfMiRU+Ijr0MpqBTfgDyeybMxlD9Z6AnyjzdqVU+mJefs3IAGYEKV2vWRS/WFN8GCdg
         uZPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774274521; x=1774879321;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x9LErbosuoksV5lU780U3bAHDdZ81QQelsqNoxIkru8=;
        b=A56UIyY3SYjqM0KNPedKXCOPodwnEZTFSIuOuztbxGEMzsVneZlLBwnk5qmqWj0V2D
         qpKMJ+ZDgHTbXsg0lOn121JErl87anVSYRivZxyuKremLC1/X6TC554tN/brmtVK8X+N
         4S+eFYcEK7uCYIA6eqqcsy0I7GvDO+iU7nlNcfozINPitzDsLinCN+Lk3rzikL+z5gKV
         m4yi625oK7qUr0u/RIBTEouUvjSODoP8gdXGR2uYzD197ydAxGSXOmXV7uQ9XR5rjKYg
         vsT0iPKNQ+Ou8iqDGELY/Q2KzgMZa8bTTA8L5JuyW3gJQ355hURw2wgg4I0mG76HgMJB
         1UGw==
X-Forwarded-Encrypted: i=1; AJvYcCUieH1AyiqmWSv2sV+ODfEqMccZ6jca9aaNtBGpuzfiVxyCZJMvH2SKs0dbsfaORBImA6qt++g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2hhOlGDKwo0EU7bYRK4NOZRQ4NotPEtPNldXAu624DjcpTpfV
	ibIB9dbY4xeDmMxD7ykM7M353o5LMOPD/TT78Hc2vfvRQ46+Resfg6aD
X-Gm-Gg: ATEYQzygwl0fe8je0m00xGkB1LUi0iZ1C99f+aoic2yV6eN6ekCOecakXq3tVRKWC1o
	tMcP5RA2u2QehBcC50+EgWLFQ6vKqA2uoVE62T6M2ST8yWAsUqGW/kXB3iRsqii0+AiSCKnYRuU
	eQYjQGOIZMAmYtKFBdQcdIIzpE14Qv0ZMNwW+UyoBJROiB98NumdbFcgvDYys58UsnxQAskd7h/
	E7HTZBHxJlxZ4bDxi48aYNDWb8VyB4KmmtmbJfTiLKyCpbSb50Z5h0KQr6m2u04H/O+jtVA7GAY
	DB4CViztNX8olmPz15nmaBEAOn8kzHr/E6ZZpBoMMFRs9Auvgkfdg0KNovH0ZT6vjZUg1oVaFPM
	7yUDZJE+QwvPbbIXZaRtpl38m9pL1THtXrrvGxf7K+ad4wdZX3oiGWdkST8XMS7maLWeBtyDlD0
	86oWhO+ssm6K53Jg==
X-Received: by 2002:a05:6a00:23d4:b0:824:9451:c1f5 with SMTP id d2e1a72fcca58-82a8c3c091bmr9909481b3a.58.1774274520721;
        Mon, 23 Mar 2026 07:02:00 -0700 (PDT)
Received: from lgs.. ([101.32.189.54])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82b040da3dfsm9467282b3a.45.2026.03.23.07.01.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 07:02:00 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Eddie James <eajames@linux.ibm.com>,
	Ninad Palsule <ninad@linux.ibm.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linux-fsi@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] fsi: Fix refcount leak in slave init error path
Date: Mon, 23 Mar 2026 22:01:51 +0800
Message-ID: <20260323140151.926607-1-lgs201920130244@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-228231-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: DFC372F50B2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

After device_initialize(), the lifetime of slave is expected to be
managed through the device core reference counting. In the
cdev_device_add() failure path, slave and its associated resources are
freed directly, rather than releasing the device reference with
put_device(). This may leave the reference count of the embedded struct
device unbalanced, resulting in a refcount leak and potentially leading
to a use-after-free.

A possible fix would be to use put_device() in the failure path and let
fsi_slave_release() handle the final cleanup.

Fixes: d1dcd6782576 ("fsi: Add cfam char devices")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/fsi/fsi-core.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/fsi/fsi-core.c b/drivers/fsi/fsi-core.c
index c6c115993ebc..f447dd53db62 100644
--- a/drivers/fsi/fsi-core.c
+++ b/drivers/fsi/fsi-core.c
@@ -1084,7 +1084,7 @@ static int fsi_slave_init(struct fsi_master *master, int link, uint8_t id)
 	rc = cdev_device_add(&slave->cdev, &slave->dev);
 	if (rc) {
 		dev_err(&slave->dev, "Error %d creating slave device\n", rc);
-		goto err_free_ida;
+		goto err_put_dev;
 	}
 
 	/* Now that we have the cdev registered with the core, any fatal
@@ -1110,8 +1110,9 @@ static int fsi_slave_init(struct fsi_master *master, int link, uint8_t id)
 
 	return 0;
 
-err_free_ida:
-	fsi_free_minor(slave->dev.devt);
+err_put_dev:
+	put_device(&slave->dev);
+	return rc;
 err_free:
 	of_node_put(slave->dev.of_node);
 	kfree(slave);
-- 
2.43.0


