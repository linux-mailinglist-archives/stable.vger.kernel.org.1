Return-Path: <stable+bounces-236091-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EI2CJiD03GkvYgkAu9opvQ
	(envelope-from <stable+bounces-236091-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 15:48:16 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 97E053ECBF3
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 15:48:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9A6DC3019383
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 13:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A073B3CE4A5;
	Mon, 13 Apr 2026 13:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jlRp7Iad"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D3543CEB84
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 13:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776087977; cv=none; b=CrJHFGd/MXvJM6VU7T0bTYX3WWxGSwjMctoVJZPrL+Lb4342oU+/1bLv2bTbxtoPJFj7MjLZg2cRozR89EYcVc3KEM95yFgSVIv7EsLrgDNnK6eDdZ9n6yLJap0HZd/ZrR++WRxsDibCnXRG6ko/04QAyPqMbjv8Sdp0LXFt7lI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776087977; c=relaxed/simple;
	bh=ZdQbCoPJwZCB3uMPJtQnV69MkLE1kKA2QPk0Ij15LxM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K8wYBAh2+KY7AQtjx39sSilQuq/lhCdaufnbwOZf/5ZydLogcCro1lVR1Zsdf1/8Woga/euy23B7V7iClsCWGZWXKbx4g1XqyPSOwayVj9Xo067Ct5ftKYIjPNaHC0hRAldl9Emh9VNdxKViFEFDj/xqhngwyD7XB5aNi7ng4vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jlRp7Iad; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-35e576110adso884853a91.0
        for <stable@vger.kernel.org>; Mon, 13 Apr 2026 06:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776087976; x=1776692776; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ITeUfxAmccwJWBoBKTfUrPUP9cp6D5ar5cCPRAU5JZg=;
        b=jlRp7IadOuiByJXyze8DdZwPC1SshDd0cWkjO4Lik0qOaNJ6uHqdQDWQHvdX2VbR/y
         s3NVLDdPu6m8jQqo/3tJpfow/ZaBmX4cH9AKlaE/Ljo1NF2kOr1rc47tZLN5fIitlj4U
         sbWBThkB92qMu4X9mNaNYLAxmeVTE9W7hQcfeYOAnzx4fuAqBYUnTcKu1H7sqwNI3mg9
         xOvHuiKS9i1Za01YsmEhkDSJEv5Hnsc/tbolf9QXla5biB7BJaZLhwvniSa77sMSyWq7
         C8CpDCsZ2Hh0QuEaMDI9qIG0NdnYHp7Cmx/bBoxgKw0ZYMls+3ZX3dtLHXDU4X23LfSy
         lmaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776087976; x=1776692776;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ITeUfxAmccwJWBoBKTfUrPUP9cp6D5ar5cCPRAU5JZg=;
        b=Ud7b04JlBK/UR+WpEmqnTEYM03QpiXfCvhJYiqkgCxMdEAoEewPJall5TuGhiXgyXb
         hne5ggMYr7uJPyAVOJBf13s1twbGQZBDDN+z2NQV+VT3uD70sGxHd3uohVJ4PLH43L3y
         ixXWqL+aSu4FYepgfSErexZRsBhibHeik32RHLFVHolaFDqDVqLJYVnU3oqHjaG4gk7s
         yEeFrSQ8cpK7NVkNY4olmF87c+lTo9nfjIVJO/wEEM4vnVL9mndOq4Az5RJPzWNhi5mc
         qzBlV84sFIR+DR14SKoJ33ugJFE6KqrdYJ3xnHVnpQitC4v9ecyMC0YGqlbGaR4VFJ64
         APWw==
X-Forwarded-Encrypted: i=1; AFNElJ98B1RirzzH2VMQOWwYvF6w0iE4e496kIHtWhITvhn2YtX6h2Zk+/M+sNwbU1IuntOSdOf8pT0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz08Kz6UceQlggvd5q4YQO0t1JuXfhvJCcwxE7R4P6tYx1RQAjw
	w1dX9jLjRe2//o7ZInm01fUSds3PfTuHV+mBEBXKVMw7yS57vyoKMh//
X-Gm-Gg: AeBDiev58Lti9Kifxw5j74f2rHh+RWINNJGDfBgyzKMd6vFqYiLQFYrjCQCwI4cwOD+
	dwh7DKEfZzNWqF7xqywLwGEGBse4VpiMsszgjUCMnwdCmo1ly5NywdMkU8U7cdTZOlGUczo0Jqr
	pqiHAEQlir/I9rbpTh1WQj5JJdDUiAmlZfT0ch0idnyIywOlTLz9Rso6jruOApSSGn199kUvmeP
	F7Vyw83QTIIRGTK/Vz1gOaILRC23WqmEMxjDIAyzmRqCEbKtFbMLFgySzrkUJHdjw2kDE4ZUSqk
	ffy3IBOWEXqEARbdSnPCL9/I57OuWb3aMA8Q18dfi+94Z7o+oD5rhYo2AQn1/s8YXIsBavXiFNB
	thki1EXvGkj5IltMV76nGE5OxBbakuZSHOdkKDfRhtgRbMIscto+h6AjlmFwG9GlOyCAbrdMOYQ
	YqsG6h6GW9FkqjoCn+Zfbm6DEA8KN782ZRJaB+WFLmgw==
X-Received: by 2002:a17:90b:1d91:b0:35f:b57e:7f33 with SMTP id 98e67ed59e1d1-35fb57e8053mr3108234a91.14.1776087975591;
        Mon, 13 Apr 2026 06:46:15 -0700 (PDT)
Received: from lgs.. ([2409:893d:1188:142d:6c67:74e8:5200:1f39])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35e34e959bcsm15974386a91.0.2026.04.13.06.46.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 06:46:15 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: William Breathitt Gray <wbg@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] counter: Fix refcount leak in counter_alloc() error path
Date: Mon, 13 Apr 2026 21:46:04 +0800
Message-ID: <20260413134604.2861772-1-lgs201920130244@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-236091-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 97E053ECBF3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

After device_initialize(), the lifetime of the embedded struct device
is expected to be managed through the device core reference counting.

In counter_alloc(), if dev_set_name() fails after device_initialize(),
the error path removes the chrdev, frees the ID, and frees the backing
allocation directly instead of releasing the device reference with
put_device(). This bypasses the normal device lifetime rules and may
leave the reference count of the embedded struct device unbalanced,
resulting in a refcount leak.

The issue was identified by a static analysis tool I developed and
confirmed by manual review.

Fix this by using put_device() in the dev_set_name() failure path and
let counter_device_release() handle the final cleanup.

Fixes: 4da08477ea1f ("counter: Set counter device name")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/counter/counter-core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/counter/counter-core.c b/drivers/counter/counter-core.c
index 50bd30ba3d03..0b1dac61b7b5 100644
--- a/drivers/counter/counter-core.c
+++ b/drivers/counter/counter-core.c
@@ -124,7 +124,8 @@ struct counter_device *counter_alloc(size_t sizeof_priv)
 
 err_dev_set_name:
 
-	counter_chrdev_remove(counter);
+	put_device(dev);
+	return NULL;
 err_chrdev_add:
 
 	ida_free(&counter_ida, dev->id);
-- 
2.43.0


