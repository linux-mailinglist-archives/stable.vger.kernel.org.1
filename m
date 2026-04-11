Return-Path: <stable+bounces-235709-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GK1zHP4h2mnEyggAu9opvQ
	(envelope-from <stable+bounces-235709-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 11 Apr 2026 12:27:10 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C87033DF575
	for <lists+stable@lfdr.de>; Sat, 11 Apr 2026 12:27:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5D1B330347B9
	for <lists+stable@lfdr.de>; Sat, 11 Apr 2026 10:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CAE033E35C;
	Sat, 11 Apr 2026 10:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NJaOXIUL"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C612B33E37A
	for <stable@vger.kernel.org>; Sat, 11 Apr 2026 10:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775903200; cv=none; b=WpWqVdgNlXKDHxncB7rEM5GTdD/vw1vvhviS1M7yuWvfB6Q4ZWlnHR2/lzs75Vdd21jOo+yptCKkwOa5vgjnaJgwUUVAD9YQ9KELbOCfn9n+JnGIF9vbAVtmpW7Xt0Q8NBzbotzj2VMLnXrqvQ5dUi02/pDmleai0BQmN5RVmSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775903200; c=relaxed/simple;
	bh=FZDR3+Rc9FvZ/sgfMRVwO8frIbcuzsj+Ut3/dkRIjxI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hzDPRjWnIOOkVCsHLca8h5XEzZFXRhn5uXmorBckCdnhn34oTSB7VvOpmwLZQ5MustP2/vD3PU5Ox6M4HHyAQk/5gLKKilhKAJZISXkzJKh7pUjimeOWGh+clPj9nMK3HDFuW7eDWEIxqaa8bpFvSpAqYgsBbgekSJDDu6EAgS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NJaOXIUL; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-827270d50d4so2675591b3a.3
        for <stable@vger.kernel.org>; Sat, 11 Apr 2026 03:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775903198; x=1776507998; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qeNd481C1ZbDhTU10FEq/8MhbzfHtLZH1eKNdN6F17s=;
        b=NJaOXIULBUM4S2H7Z4B3eWAD+HBnxWekqIij1eotsw/OncUWdRLSXTM3rA68UEKQiM
         Pr5+IyoUgYkdG3Cug8KAylW4B+/yxVP5U7v7QWYB6ZAyJldW8gST3KFAKjmRJwmagdTe
         ZxLBzwvoHs6Dl7OALCS3HfufmubUWAJ2U+Fr80Aof5R3OGYz9Z2oRg6KhIi8EVuB7f3T
         pTHiLoO5Biw6/pZVErjiD6dUmKBbKh++FRw1lF2s0DuVPNB40WABimPmMrH+PXgEcDsw
         3vcNR7r8xLmgmuIDXfpx7JJ8bkMfT4XK/Jo03MUPV02VBv1mVdqm4pWp3+i9lNM2Lk+j
         UMyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775903198; x=1776507998;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qeNd481C1ZbDhTU10FEq/8MhbzfHtLZH1eKNdN6F17s=;
        b=Go8YufImk7cKmRc3AaCI9Y74hvPnpx1cNn1JNzHbYNBfTUl5Z/doVL/5vIrIZ+PgG3
         7fHPgv/axxp8wMpYlp31DiZWUMP9AQ6myGAGKj2PntOrM0tRxbjMoKcOCAhAWZRcpPhz
         vONiKTqaEHsjmfyFz46UDiW+0SHIte0o38pAgqAq4+XNIGWfK7ox8Y9zNn9KwEJACPru
         OtirWba9nlAerDLtutzO539NKQWfy5QWw8B9Wvs1mj9JDfun7GgWm8WWIUxNrJPiTyPR
         s6+YkIDTL3x6VsrLxp7TvPjMNSmOHQDRHBlHIk62uTezzDpcZR94v0YO6SZsg+maj2n9
         EOhg==
X-Forwarded-Encrypted: i=1; AJvYcCXteOBoyRWdv8tg41tOHrBArGV3t1cmXsP06o565B+c+bZKnCo/7o7vLb/aIZQ5kcnVbALnbtc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxxin5p8xNMxXB+XucNKe7PhrCrhU6RQaif31AOalbiOsR6WstW
	jLgKBqFMtctFwG9Rwq2e34oI0sStJQDjo4aSaTVUSa6427TGIcYgiauAaVTh5Xx4HyM=
X-Gm-Gg: AeBDietLchToZPfvlDVyS4q/QY7U+SlQUqTOtp+5Yfobz2J7oxmj/x/QjrOlRhJCMLZ
	gZtKIfMt/XpYQ5gSl46bYFP1GlwrIhPdxbX5a0Jt1ZhNIMcpbPRODV85ji4p4jkkuVsr/wQbqEB
	YXSGDfc3bXyZjrGqRq3/G6wHcISCYUqLMJ16qZGZs+/SSACVFJwcI31FqsDWmqq/5j2UCfzFdTk
	aRTiMhEFQ6VaX/K60mCGEHqImWm0RFF0Y6+qLvLFKVnbsPtC0PFb9SBWVQYvBFfug0NdU2SY00A
	FwRqz+ms5ffyzKYH2NV2X/XdC4NSkVXR9bDESrWYWZgZeic+pBH2QYpR8+THyC9t5Dl0sR3Imkw
	I+Cg9X4XOmx0IQaXOD2TU2GA4GIUArdF6ykS/kvkiPtJ4SL/tYhChODthog/Npq2mxpTxChg30z
	U6trRUqQl3MAWG4En/rSVHBQ==
X-Received: by 2002:a05:6a20:6a03:b0:398:98ab:71a8 with SMTP id adf61e73a8af0-39fe4041550mr8030808637.47.1775903198127;
        Sat, 11 Apr 2026 03:26:38 -0700 (PDT)
Received: from lgs.. ([112.224.67.108])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c79219fe2d5sm4929266a12.24.2026.04.11.03.26.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Apr 2026 03:26:37 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Keith Busch <kbusch@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] driver core: Fix refcount leak in node_init_node_access() error path
Date: Sat, 11 Apr 2026 18:26:23 +0800
Message-ID: <20260411102623.2174422-1-lgs201920130244@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-235709-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C87033DF575
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

After device_register(), the lifetime of the embedded struct device is
expected to be managed through the device core reference counting.

In node_init_node_access(), if device_register() fails, the error path
frees access_node directly instead of releasing the device reference
with put_device(). This bypasses the normal device lifetime rules and
may leave the reference count of the embedded struct device unbalanced,
resulting in a refcount leak and potentially leading to a use-after-free.

Fix this by using put_device(dev) in the device_register() failure path
and let node_access_release() handle the final cleanup.

Fixes: 08d9dbe72b1f ("node: Link memory nodes to their compute nodes")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/base/node.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/base/node.c b/drivers/base/node.c
index 00cf4532f121..2b19959a374c 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -171,13 +171,13 @@ static struct node_access_nodes *node_init_node_access(struct node *node,
 		goto free;
 
 	if (device_register(dev))
-		goto free_name;
+		goto put_device;
 
 	pm_runtime_no_callbacks(dev);
 	list_add_tail(&access_node->list_node, &node->access_list);
 	return access_node;
-free_name:
-	kfree_const(dev->kobj.name);
+put_device:
+	put_device(dev);
 free:
 	kfree(access_node);
 	return NULL;
-- 
2.43.0


