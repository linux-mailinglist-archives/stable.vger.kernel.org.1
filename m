Return-Path: <stable+bounces-211904-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UOTSJaJQeWnYwQEAu9opvQ
	(envelope-from <stable+bounces-211904-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 00:56:18 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3941F9B89A
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 00:56:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BA3C030160D4
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 23:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E6B02F90D8;
	Tue, 27 Jan 2026 23:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OhvuNjPR"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC0D22F690D
	for <stable@vger.kernel.org>; Tue, 27 Jan 2026 23:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769558161; cv=none; b=HUI4C2C7w7nLf5RRz6+1YIk+FEKCmp/bnYx8PPsGDp948uLDs5IuvCIj2HNSbtD+LpNcjaJ7EPOW6a+hUaPVSsDsd9XQae/hfr1XaxrviBFZlgGLp0qZYsh8b8e3D4Mgabh8AmEqa4v+fpDI3uKLVU8ED7eoLiyrjX0Qx/7Qo+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769558161; c=relaxed/simple;
	bh=/wdPWngeWyqtaO3ZuYpGrqfLIHmKv4UBTmrmnHj8DMg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JYFmUpW/KQLwRezetxgF1hYhiJKbWT1TqeTumdGCn1FWvO+G0d7gXyeBYzeCaKnMgmVnCBfgwBCI/3ktlDwpmXlOrb2gB2woQ6Mhp0+Zt7LlEQaV4BdYrUPj3kmTW/g1PNJIUcXA+D7Vl4R2cGxg+cIBFHYl5Hfl2L3RdjKEbtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OhvuNjPR; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-123349958b2so20227269c88.0
        for <stable@vger.kernel.org>; Tue, 27 Jan 2026 15:55:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769558159; x=1770162959; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ec41m/3W2IRBvp4aICfoAibwYrvXDMhUzyetw+v5spU=;
        b=OhvuNjPRSehNnhfp1dL5KA/vXoPNyaCD3LBzbIcLg6DYybSZdnqm0Qsyj0WJ0QTxp8
         zDJNkQXXp7isxl38xUkvsYYkm3eTsxfcaMl9zcT7hsd574SlaWzod/NEq7DQR8UCPOBa
         CIGxUJRV3jxGW/fqSCRPmr+yR6BfWRVICBy0SsQ5wHYAFdaBzApFCYIcYCa7pJZLqpgC
         D76b5i4hsg5BTvuxz9riA4OBXYCgJf+9wiu8eTwcJl4GU4ykeVNK9lKG41M02ZfxwtRI
         urSdCHjCQ+7doCpoZCwMJj7NTJ2UCEcdlm9cu29POJDKYjtia5z9x4KPn0SrLFN97F39
         yCHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769558159; x=1770162959;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ec41m/3W2IRBvp4aICfoAibwYrvXDMhUzyetw+v5spU=;
        b=xHpYNx4iK3102hDh9Lv7gB11/04hj76QIKnISjSRUPdpRmA0Vz9MAsTtUAd4Du2SLj
         YB5Tu0AWNyFgNeRwA/gGgtNNMsBLXE2c31HCHQNOTAx/S79cRAuLnsxYlPfGyE2tZUU1
         WTrxSgd/5BaGWhGRXAwF6k5Fep/wXxqsgsz34FCM9ARurk7pef3gUzQZw3qmKHrqCu92
         gBtfRV/o2cSi+qfs3zJDYojK0WutZkmIzBIZFgsR9H9Jx7Coc13RrOATfn0YAkT7x7Db
         OPr7xoaTXOeX6x9NcAsFZYb5yur9xVWioI19BXGr6kqKk8xotQIlfcSYaY7KUXFZ2G1x
         jB3w==
X-Forwarded-Encrypted: i=1; AJvYcCVi6IcEgBBLxokMi3eK+sEGy1sRNhEjQ8gMyjDB+fwWprlfn5oNu5QKrtQzabDALkIiIiMSWak=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/JNtNnn339dsSO4ogQddMqy4j+Jf1hVUS5GdGe8Uc1XZ+Fqvk
	ItT7ZzFGsUfm9P9fyXL5gTrmfx4IXQ86LsJqQnTzNoxA+GRtT6tLE3E/FWz7WZdQR9dyS8BiBUQ
	C+UW/qdTKw2sohQ==
X-Received: from dlbdt16.prod.google.com ([2002:a05:7022:2590:b0:123:2738:ba99])
 (user=cmllamas job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7022:218:b0:119:e56b:958c with SMTP id a92af1059eb24-124a006a51bmr1779660c88.17.1769558158889;
 Tue, 27 Jan 2026 15:55:58 -0800 (PST)
Date: Tue, 27 Jan 2026 23:55:11 +0000
In-Reply-To: <20260127235545.2307876-1-cmllamas@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260127235545.2307876-1-cmllamas@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260127235545.2307876-2-cmllamas@google.com>
Subject: [PATCH 2/2] binderfs: fix ida_alloc_max() upper bound
From: Carlos Llamas <cmllamas@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, 
	Christian Brauner <brauner@kernel.org>, Carlos Llamas <cmllamas@google.com>, 
	Alice Ryhl <aliceryhl@google.com>
Cc: kernel-team@android.com, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Todd Kjos <tkjos@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-211904-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cmllamas@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3941F9B89A
X-Rspamd-Action: no action

The 'max' argument of ida_alloc_max() takes the maximum valid ID and not
the "count". Using an ID of BINDERFS_MAX_MINOR (1 << 20) for dev->minor
would exceed the limits of minor numbers (20-bits). Fix this off-by-one
error by subtracting 1 from the 'max'.

Cc: stable@vger.kernel.org
Fixes: 3ad20fe393b3 ("binder: implement binderfs")
Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 drivers/android/binderfs.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/android/binderfs.c b/drivers/android/binderfs.c
index b46bcb91072d..9f8a18c88d66 100644
--- a/drivers/android/binderfs.c
+++ b/drivers/android/binderfs.c
@@ -132,8 +132,8 @@ static int binderfs_binder_device_create(struct inode *ref_inode,
 	mutex_lock(&binderfs_minors_mutex);
 	if (++info->device_count <= info->mount_opts.max)
 		minor = ida_alloc_max(&binderfs_minors,
-				      use_reserve ? BINDERFS_MAX_MINOR :
-						    BINDERFS_MAX_MINOR_CAPPED,
+				      use_reserve ? BINDERFS_MAX_MINOR - 1 :
+						    BINDERFS_MAX_MINOR_CAPPED - 1,
 				      GFP_KERNEL);
 	else
 		minor = -ENOSPC;
@@ -408,8 +408,8 @@ static int binderfs_binder_ctl_create(struct super_block *sb)
 	/* Reserve a new minor number for the new device. */
 	mutex_lock(&binderfs_minors_mutex);
 	minor = ida_alloc_max(&binderfs_minors,
-			      use_reserve ? BINDERFS_MAX_MINOR :
-					    BINDERFS_MAX_MINOR_CAPPED,
+			      use_reserve ? BINDERFS_MAX_MINOR - 1 :
+					    BINDERFS_MAX_MINOR_CAPPED - 1,
 			      GFP_KERNEL);
 	mutex_unlock(&binderfs_minors_mutex);
 	if (minor < 0) {
-- 
2.52.0.457.g6b5491de43-goog


