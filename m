Return-Path: <stable+bounces-238354-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OJJZBM8z4Wm4qQAAu9opvQ
	(envelope-from <stable+bounces-238354-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 21:09:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EE7D0413FC0
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 21:09:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CDEAE301E652
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 19:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3C5634CFCB;
	Thu, 16 Apr 2026 19:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JjU7JcBh"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6443E1E1DF0
	for <stable@vger.kernel.org>; Thu, 16 Apr 2026 19:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776366537; cv=none; b=AvRTIGb0Hz56X/0GlKv2XBwqO6PjJoOaXB9HeGju4s9zUhZs3JLinb1fTBlSTa9/RPc6tde86wmOQV06tTEsQmxm9/Arjqk/yuNX/0D2ApYXwvJXCDNkX23mduSZMmxeZ+6bS7AdxtHhPzNKDF7+Hot2AvQ5TKJBaoilOTpZUIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776366537; c=relaxed/simple;
	bh=YWU4FbfDf7vMVTLH3P6trXk4SPp9pGvljjdWS7yKFlM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ut1yU9KKo9MagOHTOw+BQJVc8tEGTc0xUpQQuPxEPA3ytmZxQem5mNgIcfKntWZKearjLSNAxTBbvox6aYbYt40E4h9bh6N0QWnS3WMGjCIkpGHKQfnNsK2hDmAIWHUkC2SVpKu3DMfMMPpNUPuz/prYlCPV9Dw9mfyF1mLep1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JjU7JcBh; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c76b6abdb73so5825091a12.1
        for <stable@vger.kernel.org>; Thu, 16 Apr 2026 12:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776366535; x=1776971335; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tTMuhwzBxIhaiyIAasTcZNIFxBe8TdNJyeKGh3etW/M=;
        b=JjU7JcBhihQv4pgc2ENDt1rqNnbmj1aMClJb+xG6gui7HstVPkG1rPdbptYztfXbFt
         M4gGpygi3RF7siit//a9qxNp4nwZ4lJoU8+9EcXauhtp+wDopA3cxu719sm/Otc0HLYy
         UdHv2dR0s9UpDqnncKFEqB9ILR3Dv0c+B+y3fbGUcUaCLy9jouh9sjDI9q4pF15byINp
         0vwSqjAbUzweYTa7A7Y2mX9bLLEIeay8xjuXjKw2i6jKx8HRID6qy6AtQfsM67en+Tou
         FuV0lvNnBKSocQsRvOH8gStWJmyO4cyXR60KJya+PEKFaySDGVo6kRWELBa7Xs7V8lB8
         BKJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776366535; x=1776971335;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tTMuhwzBxIhaiyIAasTcZNIFxBe8TdNJyeKGh3etW/M=;
        b=B74yWOKnHNMVM0gO7oyfewbUOFufkMwMFRC2fL5hT/p26kxMdKppjLYl2Pxxz33ZHH
         5oVMtOs9ksJN35HYTBkA9QFo45sA99PSfX6JGbyknSrWAOpst4q2ftrYstQeV4QWfQQz
         DefgsD0Y889WiQ7sbp4WYyTgdBKS79touZg3xa5CHWOiNB26ZQ/1EeHf1miKaL9u04WZ
         LCifPDS4NOSlLNnqyefWwWizNhY8FAsdi6SzOgDKJyJOg1ubC8cIeO6i6gjasO/gH+6I
         IPkCwxESmm/+WKJ7FOhwjKX1hLFt3stMtEnwl71wJ/5qpqWHsr2T4dBlvrbdK7piAQCC
         ddvw==
X-Forwarded-Encrypted: i=1; AFNElJ+X4U5iJ5FqIg40r5urzoKTR6tuoWuCGV727fmpnRuDZp9tflVDaiHZPBUvbuYPI3jRRrYgfrQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YynJYq7lQewvMwB3Q7/s9T7ENM/sKvHcpEG6CLxvrBl194TMIOr
	C2CqRzMsNTMfy0bfT1vCX6uTGwESpeakQMEJVCB82pg9oz+Eb9D383DE
X-Gm-Gg: AeBDietUhr+iMY16RiituTjPUBqgLrn7Y94n1Td2cHuHNJFdBq0iQuAt3cna/jcgB3v
	skTQIucUSvXu3MbYgQArz1WUlIdzeXj9oZHwK2H3QyDoKhukBnIbmj9a+jXVQ8PhyoQ423QBQwp
	bmpssviyMW8Ob6UUWn1w7BdX/dM842fM7+fwwvrHb3VIAaU68T1PK7LaePAyHT+j4vHCu7Lvw1l
	AqzRIkIJUsrsds//RGqYYxRZZBJDa3rP2YG7/Al5Fjc5E02ETDe2I2vAaPFBOXqMU+1LhjmUXlD
	DiYGCIBRavpJpSfJCs9hLPijMVVRSoBzja1L/PIRwQ8HlsreY124f43AM4P0wO/H3kDwVCff8IS
	dVJ9gpX9vxXXSSSouusMCmcbJy/39Npd6MBD3HKFOUk1nt3H14H5McIsFVWiE/ZzrbppNduwCEA
	qHhW1gvLfMlw3aNOpEy0UqNeiI5RSmFomG607+LPr1m/QLzVQS80orQu8VgJXuKZtqImT5xKpaF
	Wo3ZfrT91FRxMKD8c/uSlcbwvpuMqeW9cvP8WmiMeex
X-Received: by 2002:a05:6a20:a12c:b0:398:8e5c:4a94 with SMTP id adf61e73a8af0-3a089303797mr213259637.54.1776366534579;
        Thu, 16 Apr 2026 12:08:54 -0700 (PDT)
Received: from visitorckw-work01.c.googlers.com.com (32.237.80.34.bc.googleusercontent.com. [34.80.237.32])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7957ece99asm4815137a12.4.2026.04.16.12.08.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 12:08:54 -0700 (PDT)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: djakov@kernel.org
Cc: gregkh@linuxfoundation.org,
	marscheng@google.com,
	wllee@google.com,
	aarontian@google.com,
	jserv@ccns.ncku.edu.tw,
	eleanor15x@gmail.com,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kuan-Wei Chiu <visitorckw@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] interconnect: Fix use after free in icc_get() and of_icc_get_by_index()
Date: Thu, 16 Apr 2026 19:08:40 +0000
Message-ID: <20260416190840.1753468-1-visitorckw@gmail.com>
X-Mailer: git-send-email 2.54.0.rc1.555.g9c883467ad-goog
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,google.com,ccns.ncku.edu.tw,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-238354-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[visitorckw@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EE7D0413FC0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In of_icc_get_by_index() and icc_get(), if the dynamic allocation for
path->name fails via kasprintf(), the error handling path directly
calls kfree(path) to free the path object and returns an error.

However, prior to this point, path_find() calls path_init(), which
already links the path's requests into the req_list of the respective
interconnect nodes via hlist_add_head(). Directly invoking kfree(path)
leaves dangling pointers in the hlist. A subsequent call to icc_get()
or icc_set_bw() will traverse or modify these corrupted lists, triggering
a slab use afterfree.

KASAN report showing the vulnerability when reproducing via debugfs:

  BUG: KASAN: slab-use-after-free in path_find+0x6f8/0xcfc
  Write of size 8 at addr fff000000d43f748 by task sh/1
  ...
  Call trace:
   kasan_report+0xac/0xfc
   path_find+0x6f8/0xcfc
   icc_get+0x148/0x380
   icc_get_set+0xf8/0x2d0
  ...
  Freed by task 1:
   kfree+0x1a0/0x4a4
   icc_get+0x2cc/0x380
   icc_get_set+0xf8/0x2d0

Fix this by replacing kfree(path) with the proper teardown function,
icc_put(path), which safely removes the requests from the req_list using
hlist_del() and drops the provider usage references before freeing the
memory.

Additionally, in icc_get(), ensure that the icc_lock mutex is released
prior to calling icc_put(path) to avoid a deadlock, as icc_put()
internally acquires the same lock.

Fixes: 3791163602f7 ("interconnect: Handle memory allocation errors")
Cc: stable@vger.kernel.org
Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
I discovered this bug while reviewing Krzysztof's patch [1]. 
To verify my hypothesis, I injected an artificial kasprintf() failure
into  the source code and wrote a minimal dummy icc provider module.
This allowed  me to successfully trigger the use after free via the
debugfs client and catch it with KASAN, confirming the issue.

[1]: https://lore.kernel.org/lkml/20260416130912.375013-2-krzysztof.kozlowski@oss.qualcomm.com/

 drivers/interconnect/core.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
index 8569b78a1851..e14280ced381 100644
--- a/drivers/interconnect/core.c
+++ b/drivers/interconnect/core.c
@@ -528,7 +528,7 @@ struct icc_path *of_icc_get_by_index(struct device *dev, int idx)
 	path->name = kasprintf(GFP_KERNEL, "%s-%s",
 			       src_data->node->name, dst_data->node->name);
 	if (!path->name) {
-		kfree(path);
+		icc_put(path);
 		path = ERR_PTR(-ENOMEM);
 	}
 
@@ -626,8 +626,9 @@ struct icc_path *icc_get(struct device *dev, const char *src, const char *dst)
 
 	path->name = kasprintf(GFP_KERNEL, "%s-%s", src_node->name, dst_node->name);
 	if (!path->name) {
-		kfree(path);
-		path = ERR_PTR(-ENOMEM);
+		mutex_unlock(&icc_lock);
+		icc_put(path);
+		return ERR_PTR(-ENOMEM);
 	}
 out:
 	mutex_unlock(&icc_lock);
-- 
2.54.0.rc1.555.g9c883467ad-goog


