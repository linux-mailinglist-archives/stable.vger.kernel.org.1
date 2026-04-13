Return-Path: <stable+bounces-236088-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iMYmDf7x3GnZYQkAu9opvQ
	(envelope-from <stable+bounces-236088-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 15:39:10 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 365563ECA1E
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 15:39:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D70D2300B455
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 13:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BF0A3CAE9C;
	Mon, 13 Apr 2026 13:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NyH9Fbul"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3CFD3A9616
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 13:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776087541; cv=none; b=aLSgFLAkQA5fF5mCWyOFkUq5r/wy/72JkwUlEPQBv+MMF9iU+9ec2eohTRenSLIju6qJUg0IfeklpyE7MA5rAF+p+Vs10Tsim1GL68jcmFQa9G1rVF/rqJVhCDRUTOrmYAfEQefCGAJHJxrTEJDeS+jpxu1UoZ1O0w1wojj2B2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776087541; c=relaxed/simple;
	bh=WtPMwZ26K63g/t20378ABYaP1ODXlf8DcUy79QB6GO8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cUAKfasrX9rtSJrreS1/gXBRk9KUDvNU1u4myX1dXN5DPq+Jjpv1zbJlCjA8U7qovT+iI6qm1StmqXEBerYDRm7ugMP+JJbt3u8XfXwcP+P9u7Kc9MTPP6TFL2kIdrreVIEkjseJ8aUbHM30o3olMjL4VEBxlSjT9oiZkbOoRmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NyH9Fbul; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-35d9923eec5so2568948a91.2
        for <stable@vger.kernel.org>; Mon, 13 Apr 2026 06:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776087540; x=1776692340; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UggCRQ3k+2UlRxrfgaRoIdFJUAAFZneZshl+NRND13M=;
        b=NyH9Fbul19gKRmqItER9DuzcXrvmNiGqvnMNN/59QkE0wfBzTGPBC4BYFYF/namXQO
         yx924DNIKpFWgfRH0WQlBCRXzTC0GouRzfo1p+fly8SjTtTzLi5lhVdAiXGpv6R9Qza7
         lMHQ2uDRo+wQvQZKh6Ib+s7CC0BCN2BqVlY4K2hsStL6FKkE113kJF+UhIpqpZo29YVr
         Q5pqWb1fEh5wKvKG+hmY3l4T1IGlFTchxgNYjIDQYT7ga2o9cC9ZnZ6jM6PAf5DgKaCl
         FptrnoUssWgVvlRuDFtV7abLVarQXtTod/8okBMyn8EPVR5pdOAElEjFyFVsNt3Q7a6e
         h1XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776087540; x=1776692340;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UggCRQ3k+2UlRxrfgaRoIdFJUAAFZneZshl+NRND13M=;
        b=Ad+VrjiZuq4g1j9JOk4GHqumsNU3fCyobiiMPVJeINpYHJJpRMEASHH3OwcBEaNZ1g
         r/Nwwkns0MLdc8SukVkbYDFkzwZ9LYfPcm8mg7FSmOJOLYyuRMPIyWE4Wshakd2K32zH
         QbuJotir9fj4FvsQFHAOrcqXgmVvkuSiutQeB5h/2JENtJPEqScR3oOYBOOjLSjVVA+q
         5cfLDn85I1KsRvMpV6kOjQz2Wx9Ouv5i8ysgUInbJIBRpM4g6odELc82tXJ0ftvyL0R0
         4q6FCumwIYZq5u9pebvNDyGm+UPVN5f4kra1TdomxjJLZVk2zvQphiGn+xQVBMPqN302
         k9uw==
X-Forwarded-Encrypted: i=1; AFNElJ/EEhYSl/oSeiEhgYM1zKcDbuDSuFVAMTcKPPkr1QhGskPXh40dw1YjkU+k/eDMfMKcb0NI7uY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKMTFryi5eLt/ivPXdmbTlNUo0zP/HhRPaKBD4OVKm7iKV449m
	2bf+w+Wv+dcJRbbUzSn75H9DJcB1/ZkpAQ5rCEAbLzTAuFICir5SgV2u
X-Gm-Gg: AeBDietIyK77eYu3uKX9Ve+qLC7h0///M9rMK2FaIb5+3KJ20M120GCC1liaSkafksE
	34SYOeY9zLJo2rEjGZr774znAsFnwvsvbd++0cErPkrldu1kz4su6EqNQ+eqSRt8N3qr8vnrZrC
	yu8NOVzg9g6XBzElHckPJUPVOBwqhgI4aGXkUj6wEK4OdGpCrIddLcApPmwKkVPdQCr7NYO2pFb
	HMqMWskA5uRta+fRvsf6SOEMQU5cgBE7bNftpmMQWQZlMrZxSMAJ0D4rSu05WmJ3W6GbsErBT3y
	5ZmmOI6vmyWms3MYxb1pjzJIkz4ilTDu6jEdHFked2eaX1HR2J75YyK2Th8T8ZPi4k6GpKd4WrS
	X1y7VeWBv/4V+vqtN3DiRBXZGaiOWp8tsGrJfQmEmdslb+HIHaraFwmrvX1dsYNyvsUt1LXUero
	2Rao0mo2f128TtrXcqHnyTSer04KfMOck=
X-Received: by 2002:a17:90b:3fc5:b0:356:22ef:57ba with SMTP id 98e67ed59e1d1-35e42759e2amr12027568a91.7.1776087539999;
        Mon, 13 Apr 2026 06:38:59 -0700 (PDT)
Received: from lgs.. ([2409:893d:1188:142d:6c67:74e8:5200:1f39])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35e41bc6541sm4419830a91.0.2026.04.13.06.38.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 06:38:59 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Tony Jones <tonyj@suse.de>,
	Kay Sievers <kay.sievers@vrfy.org>,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] enclosure: Fix refcount leak in enclosure_register() error path
Date: Mon, 13 Apr 2026 21:38:50 +0800
Message-ID: <20260413133850.2841274-1-lgs201920130244@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-236088-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 365563ECA1E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

After device_register(), the lifetime of the embedded struct device is
expected to be managed through the device core reference counting.

In enclosure_register(), if device_register() fails, the error path
drops the parent device reference and frees edev directly instead of
releasing the device reference with put_device(&edev->edev). This
bypasses the normal device lifetime rules and may leave the reference
count of the embedded struct device unbalanced, resulting in a refcount
leak and potentially leading to a use-after-free.

The issue was identified by a static analysis tool I developed and
confirmed by manual review.

Fix this by using put_device(&edev->edev) in the failure path and let
enclosure_release() handle the final cleanup.

Fixes: ee959b00c335 ("SCSI: convert struct class_device to struct device")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
v2:
  - note that the issue was identified by my static analysis tool
  - and confirmed by manual review

 drivers/misc/enclosure.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/misc/enclosure.c b/drivers/misc/enclosure.c
index ca4c420e4a2f..9532ad8f8b4e 100644
--- a/drivers/misc/enclosure.c
+++ b/drivers/misc/enclosure.c
@@ -148,8 +148,7 @@ enclosure_register(struct device *dev, const char *name, int components,
 	return edev;
 
  err:
-	put_device(edev->edev.parent);
-	kfree(edev);
+	put_device(&edev->edev);
 	return ERR_PTR(err);
 }
 EXPORT_SYMBOL_GPL(enclosure_register);
-- 
2.43.0


