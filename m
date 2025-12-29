Return-Path: <stable+bounces-204118-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 16C61CE7CD3
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 19:11:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C560730062FA
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 18:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF83132E750;
	Mon, 29 Dec 2025 18:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nn5pMwah"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B5822FAC12
	for <stable@vger.kernel.org>; Mon, 29 Dec 2025 18:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767031905; cv=none; b=TX5xInDgrZ6B0iDbD2xNVpUBN2jLoWco0KlCTtc8/UTDqq8GTqiEBoSYNeLwuTvs5lBUuKsY6kNsEnPZnNYRjkFxDSfJRbAA6pWhr85HY9cr46sCDj/tEYT71FRf0m772a68906BNZMHCbQUMTNhCjl0a4IXLMWscrBYGt0tnzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767031905; c=relaxed/simple;
	bh=3mxvxrp4wY/3uGpZuzNNr+dKx2oGx7/JyRyOy5FqYfw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=YEBNNJ1s0GHRWCX4nUfG/szB4OszG25N+O58SC5Ud/XNEyHMYLgXazPltEt+fpToOZyW3nGvLBKHcWqCml9SS6vk/xhhKYTxVNQOMiKDGRqem5lesnlJnS1Z5YKLrClrzvNc0WBc0YboAX7I97jUD7r+632jpbMQbGiP/PpA3Po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nn5pMwah; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-34aa62f9e74so11770121a91.1
        for <stable@vger.kernel.org>; Mon, 29 Dec 2025 10:11:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767031903; x=1767636703; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ViypW+a/MB+nsvvfZGHfmVvZeQI/Iv9ibJjlMSavIV0=;
        b=Nn5pMwahATXKS1fGMEkrm8wsZxZBk+9Y3kEO6lImSetIrhsXg8n531oMydj2XcqC5n
         cJUup50LOhIz0vD5GxpVzuY+JCiTpIU8rVOIaMicQ3nGthvE3HLFy3DLUUOwS8wE3a9a
         zrEtsjt2fuquo2VZeBlCeTbFxDZzpi0sH3ukbayFBsX8aNRzlJ6W68F/djepvwfTRAYb
         chUyDygqlkZbp0GJMrmD5Re16n/35aVkNn1hIDw1Rpvt5BQrNqVjO3QCXjnzC//BTIUT
         XenGhm1VdjISeAjt+que6bOIUdEhK47acdXNMlv4Vzj8n7VoebrYDfxLnmmsSbKx1Hi8
         6wFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767031903; x=1767636703;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ViypW+a/MB+nsvvfZGHfmVvZeQI/Iv9ibJjlMSavIV0=;
        b=HO/V8QozfQfZ8+yDM8xpcPGvDxLjBYqb9N4+1cgFOfX5mYLEf5N+rBPG0ggkWjpNQQ
         E+gX5CpyztEEVfj4IrXalxfQDxhp+g/goa5RHyn7hcCyLex6qxy1uz1PUYvbeGrOMyzn
         hw5ZANVEYw2zlN4EbtdDt3fqUBHLmO4AhTpVWlsvPHZlzdmg+SUx0ldFoQhMMT4DcL3P
         jWrW5j1gfZxQaKPXV7I0fNr6rLM/z1NrLzDN6b865hOHdvFwNI6m5WrVcWJH5dfsKgFb
         vuZsJS58/+s2F7iOx6O7aNd+nhjnO6NVkP/9fr+B4Yv7A1qyY5YchIHHipctsERIUM8Q
         vUiA==
X-Forwarded-Encrypted: i=1; AJvYcCXdw/8rONSrOGurLFbv5CDsLS6FrsA7qhw7ysNYQGMSSR/GjCESYKeKJiMBG0r2IYg/Nq1pkkc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5wI0vRqZXAzYKICI5MQKX6+IIWFwX5bW36ZKDmw7ihVwVK3T8
	m7nbqtabYKHCjtsot9KQ376mMQrAh57H0b0XqHEMpsLy6zkESmwUCRlt
X-Gm-Gg: AY/fxX6b54b1dt2Z7usecUbOmOfPp4XZobZE1BI+iRpGNH0gN/pq3Dgwvgv/X5My8jj
	QvjOJbqaUpSPIWXsnazQQ49jYMbnwW/CfjQhTmodbR4vQtREBoz1Jf+IajoQnx4T3qk9Mq1ICwZ
	gvDdJUDoq5JgpcyjJkUEMO5UCp4pWMSBzRr9UJsJ6Zv0pqQgI6zZ0s90JYn7iJR4abifwD+T0qd
	sqY0YOu6zsalfEbBclLUCTfqynpq1Vm3K6kjF9RWqenTQo22w7T4txS8l4wVJ9tZWoJNosJ0aiU
	6hwkw6x6/cf19pclGuda5v9fitumVz3x93EmzZReWQ78qzbpY1rihQENeCGqkJaTU4VIoG9alkU
	b/e23PEjhVSTj8lHCQ0n8BN7LmW/mWbwEaLXNVGxAC2EWCKvQk7+SliIy3foGjOuuOqBpNFbdXk
	kYM3/CBJfTHaA4FBOVfeA=
X-Google-Smtp-Source: AGHT+IFp7RHj+un7puWHRl+h8lj4aFf3vhZWRP1VkW5p0M/OCRPHRXaSCSd7ytGI3VvKtAwTrRlq2w==
X-Received: by 2002:a17:90b:49:b0:343:5f43:933e with SMTP id 98e67ed59e1d1-34e921afaf8mr23802102a91.19.1767031903383;
        Mon, 29 Dec 2025 10:11:43 -0800 (PST)
Received: from [172.16.80.107] ([210.228.119.9])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34e769c347asm16353246a91.0.2025.12.29.10.11.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Dec 2025 10:11:42 -0800 (PST)
From: Ryota Sakamoto <sakamo.ryota@gmail.com>
Date: Tue, 30 Dec 2025 03:08:46 +0900
Subject: [PATCH v2] gfs2: Fix use-after-free in gfs2_fill_super()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251230-fix-use-after-free-gfs2-v2-1-7b2760be547c@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4WNTQ6CMBSEr0Le2mdo0UZdeQ/DopQpvER+0iLRk
 N7dygVcfpOZbzaKCIJIt2KjgFWiTGMGfSjI9XbswNJmJl3qs9JVyV7e/Ipg6xcE9gHgzkfNxjj
 fQFeNtRfK6zkgV3fzo87cS1ym8NmPVvVL/ztXxYrhS5xM2xi4670brDyPbhqoTil9AeWwjhq+A
 AAA
X-Change-ID: 20251230-fix-use-after-free-gfs2-66cfbe23baa8
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: Markus Elfring <Markus.Elfring@web.de>, gfs2@lists.linux.dev, 
 linux-kernel@vger.kernel.org, 
 syzbot+4cb0d0336db6bc6930e9@syzkaller.appspotmail.com, 
 stable@vger.kernel.org, Ryota Sakamoto <sakamo.ryota@gmail.com>
X-Mailer: b4 0.14.2

The issue occurs when gfs2_freeze_lock_shared() fails in
gfs2_fill_super(). If !sb_rdonly(sb), threads for the quotad and logd
were started, however, in the error path for gfs2_freeze_lock_shared(),
the threads are not stopped by gfs2_destroy_threads() before jumping to
fail_per_node.

Introduce fail_threads to handle stopping the threads if the threads were
started.

Reported-by: syzbot+4cb0d0336db6bc6930e9@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=4cb0d0336db6bc6930e9
Fixes: a28dc123fa66 ("gfs2: init system threads before freeze lock")
Cc: stable@vger.kernel.org
Signed-off-by: Ryota Sakamoto <sakamo.ryota@gmail.com>
---
Changes in v2:
- Fix commit message style (imperative mood) as suggested by Markus Elfring.
- Add parentheses to function name in subject as suggested by Markus Elfring.
- Link to v1: https://lore.kernel.org/r/20251230-fix-use-after-free-gfs2-v1-1-ef0e46db6ec9@gmail.com
---
 fs/gfs2/ops_fstype.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/gfs2/ops_fstype.c b/fs/gfs2/ops_fstype.c
index e7a88b717991ae3647c1da039636daef7005a7f0..4b5ac1a7050f1fd34e10be4100a2bc381f49c83d 100644
--- a/fs/gfs2/ops_fstype.c
+++ b/fs/gfs2/ops_fstype.c
@@ -1269,21 +1269,23 @@ static int gfs2_fill_super(struct super_block *sb, struct fs_context *fc)
 
 	error = gfs2_freeze_lock_shared(sdp);
 	if (error)
-		goto fail_per_node;
+		goto fail_threads;
 
 	if (!sb_rdonly(sb))
 		error = gfs2_make_fs_rw(sdp);
 
 	if (error) {
 		gfs2_freeze_unlock(sdp);
-		gfs2_destroy_threads(sdp);
 		fs_err(sdp, "can't make FS RW: %d\n", error);
-		goto fail_per_node;
+		goto fail_threads;
 	}
 	gfs2_glock_dq_uninit(&mount_gh);
 	gfs2_online_uevent(sdp);
 	return 0;
 
+fail_threads:
+	if (!sb_rdonly(sb))
+		gfs2_destroy_threads(sdp);
 fail_per_node:
 	init_per_node(sdp, UNDO);
 fail_inodes:

---
base-commit: 7839932417dd53bb09eb5a585a7a92781dfd7cb2
change-id: 20251230-fix-use-after-free-gfs2-66cfbe23baa8

Best regards,
-- 
Ryota Sakamoto <sakamo.ryota@gmail.com>


