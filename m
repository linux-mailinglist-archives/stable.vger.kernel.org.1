Return-Path: <stable+bounces-238142-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yJwMAnGn32nQXQAAu9opvQ
	(envelope-from <stable+bounces-238142-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 16:57:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C3A5405956
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 16:57:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E8F53300DF7D
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 14:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C875F3D7D78;
	Wed, 15 Apr 2026 14:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kOo/peUu"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 393673D75DD
	for <stable@vger.kernel.org>; Wed, 15 Apr 2026 14:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776265063; cv=none; b=Jko5JBpY4Q2eQCWYn1iF+CfJo50VeY8ok9ICZ3gd54LKIVLtRRKIxsquVcrUciUhaD91hhXt6owAhwLSFabWpLSupv90zbCVp/rFxeXKiWrxSQjHC+zVS/YQ+vZA+clGsYumubNbKUUzTpg+RTDr2Yos7DLv7kV7/YEvUmN8AtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776265063; c=relaxed/simple;
	bh=oRPVzB//4GPr8E0X8MsyD2ixptlJ7tiaxlRsENmd+80=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k3ojqAIBk+mMAGv4p9hKBBiyXevhjgZhLM/nOa4XjCLTpEwnwL+G5amNtNp1YueCjPKe3vYnoW/qkzLWe5HrGbNQNaVJY3B17GzZG3GddTPMX8f/FUBD+V9cXDjnzHOghd997jY5pUr9kZrus6fi9WPj0WxNnWrpVexpgjVDbaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kOo/peUu; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2ad21f437eeso40968855ad.0
        for <stable@vger.kernel.org>; Wed, 15 Apr 2026 07:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776265058; x=1776869858; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=s9z9SXjdbKZ8KdYoMVn9DyECDnpTcqUx5ESLC0ZLnEI=;
        b=kOo/peUu2Xf/w1s6n+FKrKJxtDH71Dk/JwWWrAPcUs9hxeI14ZAEK1Kd0oBkfTA3El
         1RDZrRimPW+9QVHU1H8n1RUMsuWHrD+AmTGQrZpPKcLkYMEGhpsDKFo8LyNAfXfse9m7
         XhsByjdXfwrf0GDR1LHZ2zraToMh19nEGk7gWvlhojfetEkNV1rnmj9PK/hGvxvStWy6
         3Ty9igVKzQkBi+sICugpvHp5d1EBOhe8+ZQT807ViNY8oPz/BAdKj60P+sTcij70IPfs
         WfFn95u0z4K5gs+pEgXisSraczBbe0ApgKiyUFZyqtKZlHE+khAXSki7tCQgzcSkcNGp
         kEoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776265058; x=1776869858;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s9z9SXjdbKZ8KdYoMVn9DyECDnpTcqUx5ESLC0ZLnEI=;
        b=S5bRra4uv3QybBc0Uj1wvfxOmviS8IwghFQHRzKCMZGOB0f7g8idBrpp7yyrEkfmd6
         wvdkvc7e3ciVZFYX5oS5ic2N3PQk4cz2KR/LyQvolTWbt3CKpi0WKhWrOSb3mwCYJ78R
         1+oNBtjDjr1eKCsDjVC5ZoADglfAoBMNkTj/SIvkcFjllY7ERD7gJGWdF+JA54u8kU7B
         ub6du5iCuGlAXUi0jf+pWRPjBUS4fnyvm7O5iLNf/1GpUVWNvqMBy9mJ2TtUO+XvcE8M
         70Zxb/P63kxh1LTAGRiWXrMmGE6/Ll0LXwVPP9UaF8ep1e3ARRkg8iGJ6YDTa+JE+yEC
         9qiQ==
X-Forwarded-Encrypted: i=1; AFNElJ9+iyYktvMl7JiqTS/ToznBelEHJbbVuXfC5cCEKbvEunKNDAT0OLVFH6FpgbRKl8M3iFXzobE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxeXkBSLekXsYhXcYIyP4+tyZZyLrHRm6ue3LByj+OiSYstW44
	srNCNu5krt/d4lZPhpCfF2bT9cjWJHpplBsJMNn9hkmxV5KbcigyRow0
X-Gm-Gg: AeBDievnKT6m6Q9P/YUWySpbz4blCWgPwi7HPzq2OydeP39wRdOHFz/t/+I/rnu7li+
	VicE7UqOSSAH2JdHHSGaDVBDDCqOMTSmoBqk4ZCwE1jgvZWL2nQPB7bljEzQYy5OH6NhaA3nQfF
	jS2+TlfLfAZvF2JRnAb8KTsiSap7gUNIR5mUqSIg/tN9e+KWEs2+ODpYXmNOjDO5OBNSXrmQyCp
	j5xQA8bGGIc7I6K6LkpPOoz5UW04i0Do42B5Fj7vbvInfu4D9l4eheyZgT8d5nDypLQ09I5vadV
	Cq6QsqEIKd9drz8vzXRqP9b9VAP2NByRKXieU1Po56Ygs3yT+Mkl4Jsq/vSncx7QmI53rcQcfW+
	uqWsaFwlRH2eiXVn9099X7/hnAUnV3XEQJKqPOaZdnwNmFiH641r+Nz9iP/GliFA6hI4S0l8FYj
	OskYtLsO84i5sLqHKRzVkga/EfxSsjYVt+
X-Received: by 2002:a17:902:f64c:b0:2b2:53f5:461f with SMTP id d9443c01a7336-2b2c7384aadmr230409305ad.25.1776265057864;
        Wed, 15 Apr 2026 07:57:37 -0700 (PDT)
Received: from lgs.. ([112.224.67.108])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b4782abd6csm23426605ad.63.2026.04.15.07.57.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 07:57:37 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Denis Efremov <efremov@linux.com>,
	Jens Axboe <axboe@kernel.dk>,
	Greg Kroah-Hartman <gregkh@suse.de>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] floppy: fix reference leak on platform_device_register() failure
Date: Wed, 15 Apr 2026 22:57:08 +0800
Message-ID: <20260415145708.3331818-1-lgs201920130244@gmail.com>
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
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-238142-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.996];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8C3A5405956
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When platform_device_register() fails in do_floppy_init(), the embedded
struct device in floppy_device[drive] has already been initialized by
device_initialize(), but the failure path jumps to out_remove_drives
without dropping the device reference for the current drive.

Previously registered floppy devices are cleaned up in out_remove_drives,
but the device for the drive that fails registration is not, leading to
a reference leak.

The issue was identified by a static analysis tool I developed and
confirmed by manual review. Fix this by calling put_device() for the
current floppy device before jumping to the common cleanup path.

Fixes: 94fd0db7bfb4a ("[PATCH] Floppy: Add cmos attribute to floppy driver")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
v2:
  - Replace put_device() with platform_device_put() in the
    platform_device_register() failure path
  - Fix the device_add_disk() failure path by unregistering the current
    platform device before jumping to out_remove_drives


 drivers/block/floppy.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
index 92e446a64371..461e14d19422 100644
--- a/drivers/block/floppy.c
+++ b/drivers/block/floppy.c
@@ -4724,15 +4724,19 @@ static int __init do_floppy_init(void)
 		floppy_device[drive].dev.groups = floppy_dev_groups;
 
 		err = platform_device_register(&floppy_device[drive]);
-		if (err)
+		if (err) {
+			platform_device_put(&floppy_device[drive]);
 			goto out_remove_drives;
-
+		}
 		registered[drive] = true;
 
 		err = device_add_disk(&floppy_device[drive].dev,
 				      disks[drive][0], NULL);
-		if (err)
+		if (err) {
+			platform_device_unregister(&floppy_device[drive]);
+			registered[drive] = false;
 			goto out_remove_drives;
+		}
 	}
 
 	return 0;
-- 
2.43.0


