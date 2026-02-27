Return-Path: <stable+bounces-219997-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mFTKKizroWkjxQQAu9opvQ
	(envelope-from <stable+bounces-219997-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 20:06:20 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3112E1BC69A
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 20:06:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 853BF30D4609
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 19:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2401A3603D2;
	Fri, 27 Feb 2026 19:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L9cKGb2i"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B497727FB1E
	for <stable@vger.kernel.org>; Fri, 27 Feb 2026 19:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772219085; cv=none; b=UHsX2IC3ZgYmQoBbL7Jr0Mef5+lVE7cMaf0AiXb7GEobqE9QDQlWXea/KNo+Rj/kmxbxa9xPZHs7dncfw1NAth1TZtdl0jcrqNCdcLLWrBCWWskeRpqEb3VmvT1ZurQX5r5jpOogwZMjmJopmSF1QGVBOYfjbKsqh7HfQ9pLOkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772219085; c=relaxed/simple;
	bh=jCyXajtX9ghhjKyXCXL6my2UfNnbOKCA8PbenbqJC6s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p4jFGZINQDlvQNM9ZXojsZ2d1/BvsLIqTmayJKuUH0/ozCD9fHcOUKEFbN5xKES7/0shM+3yIHaJpecnulVrV6GtDvvHS71hO+mwIjViyfV7NtI+N0jq8Wqa5KoxgWBlR+GpJAN9RvAyDHby/03cG9BcrzR9SldytxVUAwJhLoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L9cKGb2i; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-8cb7edbcde6so313099885a.3
        for <stable@vger.kernel.org>; Fri, 27 Feb 2026 11:04:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772219083; x=1772823883; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=f9B+wvxt/iP99Bc6MjcM2iv5vWUnNflxvIlDxaXw7zY=;
        b=L9cKGb2iax6effimjktQp9CmjbQuYGOftHA+X2NZrQLwkHvL9nAaXi3Q8Dipgoup8X
         hQ4RAutH1ISS3UXaI1rapukVafcrAQcycSeY5OIW29N8MyngWprL76Yv1dTDGlKz59m8
         iq2pfAFH+IRJ2sbRz8Bl8HaV4649/E+EBejuu+XBVJvpCle+28qKShKW9BxczVAMvGoN
         a3pPxZCQTy8h8PM9DI05UNJ0wZ2m/NC+e38lwGRG/Tjp9vyg/bA6raK5TWWVDQ2NpMux
         bd8TVaGN7hmRUgLWwqSFbg6PVIcBXe5whwbV0xt3P3d1SlYPqn4bWKZt3+0TKNRY4KPv
         Jy6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772219083; x=1772823883;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f9B+wvxt/iP99Bc6MjcM2iv5vWUnNflxvIlDxaXw7zY=;
        b=xRrczUYZjjlgZSuEOghSqagjCuJWt5QcHTDSSnKbB8MVe3bCgrM1UKkMRPJV4zcXE3
         i+Ri78ugjNIV8ehCs2Mnmfq0OhDX+NvKP3hrh6r4FSNtBFmT2vl/sqrbwrf/lDHWfJ0N
         wwwllMynrlx4g59dEsSrpSINOHBaR0C0yAslNucfkT9gpDrLeY1zlNmMsPkjlKq+uasw
         2ceIhoowylyD8t5TQIPG5pBCP3dfoHceHFsNSsET64MAWMtxCWJSwqai+ZLNtEJ79qi3
         72mnoW7BCsP7d1Y1iwKi3cl7qOcWJIKkv2B3kgfiEmH0rn6ERt9xCRGzZAWUqPg/egXQ
         OTJA==
X-Forwarded-Encrypted: i=1; AJvYcCVtKMmUw8jcb0lGfQ+lZvPhqXN+0hXg2QQEgzazl0u5aX+WRJowa1DFIpgjuG0uFL7qcqjlGHU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5fgiqOvYpYyhRTypp88cmVJgSKRn2VNqY8lP0GZ8nE1xSKEvA
	dZCeRw19u5AQScigRrTP2Ylr/552nizXetUrg+8Gko55FB+x8V2JgE2r
X-Gm-Gg: ATEYQzw5HuMJjwNCf4E/gWgcQW2zxgP856AWES8rCMAYj/NUoBnKdqduWmnj8ZfVIB8
	g1SA8f5GeYh9EMFLeSmjPf/8WJicB5ZErwUzZl2eRyr39YxqxDm9jtISLYVV7m/xvzKOJTDfs4M
	K1GzrpZLNUAvZWm1GbMnZ0VOGK7pzwMXL9n8PJDUsYnAmAm6iySOVndhVpiRxZwvyDku8fn9KS3
	TY2hisJVgQPLYPqRIldb6wUcbzbu+5Z2Ctea2/C/jbn92/t31RdeMDEDFooz2fNsjcDuPjMnuRg
	V1mQQ5TrGhqqjxGlGAmMBOt54k5nhlMn1vutp7HsApqeWXcuVzw4jjYBKPOdwbgb1A3GkLDhbb/
	CSC2UFoczePYUcjZL9+AaxJRXoJtH6YwWyDYmcGI7TpeUg3Nad3OhElggVd+8ZxnD5ZRc+IhF4C
	0vYnp3+XbUu0UMWv5bB7wTBeCTN8aiZRY/vglZVWukGraGDgpLIT9WN9YQD6lyVFH99PeCWMuXA
	0BcrpAu0ngA2S8qGBj07bqJwuTZbw==
X-Received: by 2002:a05:620a:290c:b0:8c6:a72f:fd56 with SMTP id af79cd13be357-8cbc8e808demr483504985a.29.1772219083437;
        Fri, 27 Feb 2026 11:04:43 -0800 (PST)
Received: from localhost.localdomain ([129.170.197.95])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cbbf673060sm535932785a.14.2026.02.27.11.04.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 11:04:43 -0800 (PST)
From: Nathan Rebello <nathan.c.rebello@gmail.com>
To: linux-usb@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	heikki.krogerus@linux.intel.com,
	neil.armstrong@linaro.org,
	andersson@kernel.org,
	kyungtae.kim@dartmouth.edu,
	stable@vger.kernel.org,
	Nathan Rebello <nathan.c.rebello@gmail.com>
Subject: [PATCH] usb: typec: ucsi: glink: cancel pending work items on removal
Date: Fri, 27 Feb 2026 14:04:30 -0500
Message-ID: <20260227190430.889-1-nathan.c.rebello@gmail.com>
X-Mailer: git-send-email 2.43.0.windows.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-219997-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linuxfoundation.org,linux.intel.com,linaro.org,kernel.org,dartmouth.edu,vger.kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nathancrebello@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3112E1BC69A
X-Rspamd-Action: no action

pmic_glink_ucsi_remove() does not cancel notify_work and register_work
before calling ucsi_unregister(). This can lead to a use-after-free if
either work item executes after the backing data structures have been
freed during teardown.

notify_work dereferences ucsi->ucsi in pmic_glink_ucsi_notify(), and
register_work may call ucsi_unregister() a second time in
pmic_glink_ucsi_register(), causing a double-free since
ucsi_unregister() does not NULL the connector pointer after freeing.

All other UCSI backend drivers properly cancel their work items during
teardown:
  - cros_ec_ucsi.c cancels in both remove and destroy paths
  - ucsi_ccg.c cancels pm_work and work in remove
  - displayport.c cancels in remove_partner

ucsi_glink.c is the only backend that does not, despite initializing
two work items in probe.

Add cancel_work_sync() calls for both work items before
ucsi_unregister() to ensure no pending work executes during or after
removal.

Fixes: 62b5412b1f4a ("usb: typec: ucsi: add PMIC Glink UCSI driver")
Cc: stable@vger.kernel.org
Signed-off-by: Nathan Rebello <nathan.c.rebello@gmail.com>
---
 drivers/usb/typec/ucsi/ucsi_glink.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/typec/ucsi/ucsi_glink.c b/drivers/usb/typec/ucsi/ucsi_glink.c
index 11b3e24e34e2..99e5ad54c6df 100644
--- a/drivers/usb/typec/ucsi/ucsi_glink.c
+++ b/drivers/usb/typec/ucsi/ucsi_glink.c
@@ -463,6 +463,9 @@ static void pmic_glink_ucsi_remove(struct auxiliary_device *adev)
 {
 	struct pmic_glink_ucsi *ucsi = dev_get_drvdata(&adev->dev);
 
+	cancel_work_sync(&ucsi->notify_work);
+	cancel_work_sync(&ucsi->register_work);
+
 	/* Unregister first to stop having read & writes */
 	ucsi_unregister(ucsi->ucsi);
 }
-- 
2.43.0.windows.1


