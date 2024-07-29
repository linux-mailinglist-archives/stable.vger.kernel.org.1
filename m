Return-Path: <stable+bounces-62607-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B73693FE6A
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 21:39:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4FB21F23D63
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 19:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B30518787D;
	Mon, 29 Jul 2024 19:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RU0BaTEo"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C90F187863
	for <stable@vger.kernel.org>; Mon, 29 Jul 2024 19:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722281929; cv=none; b=SSWQRgpRyGQIhF24ii2sOEmMjdqTfL28usTva3XJQ2BHW/fD1IvOUkqm5l+gQic2i9V36Pat2F9uM+BePzU7AVuxuGSnx0riLTKptznvbqMuPS8KlVfVmX9GnRFEOV3/HKbcVfAk2oG+HnWeXsbZP7/rrl10PcfuiBUdiOd7ViA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722281929; c=relaxed/simple;
	bh=2A0QGV/9jwiPH/aDRHJg4GcqN5e4HsuOtzu28y9tLzw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T8alKQHAMGblRQ5Z3Ux6Cc58faynAmAqvleakKi9Zm3k8a+dxaVFhOCMVVrBduKV/YmrUT7hZ/v4SdEhtiv2bHwt1T2GU5r09vz24cNqjmkFH5X7bSlvqgFl4pO/MKFCUsIrmiHKrRyWH5gF3uJ7r+5m6BmKhgEMvUfrCR7DZSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RU0BaTEo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722281926;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zk+VGgxkZ1MfQlbi3xl60oWmcFIF6r3vDuJhfUy1Rzw=;
	b=RU0BaTEo9zZ4Lt8biQjfdcHsh1XdR2+Ei+ucNU8nNrJA6fNruGqy3ROyVFWhtxNP6IxS+o
	GaRMT6HmMD+0jc5RofkUVTeYtNkqdGIUbTQYwyNsYUA0O21+Gjw6sST0Y2Fd9jp4AQ8AI3
	iT9yEUApFWh3suG9mMZYLkmB556km2o=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-466-YZ4sz3dfM--e2-iurEeaCw-1; Mon, 29 Jul 2024 15:38:45 -0400
X-MC-Unique: YZ4sz3dfM--e2-iurEeaCw-1
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-39642f5482eso52508615ab.0
        for <stable@vger.kernel.org>; Mon, 29 Jul 2024 12:38:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722281924; x=1722886724;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zk+VGgxkZ1MfQlbi3xl60oWmcFIF6r3vDuJhfUy1Rzw=;
        b=t3LyhjB9pPIVimmxj6OhMmKINzmjKLKkRJ340GqTNG8/LmxAnYwPucgUZchAI7/CvC
         B/ZSAx+d2i8ye2zRp5DXU2qPb8lwAsag2Lq3Z3d7zXWXd8Fc26cyA3zSmsWI3zk8jKsX
         8tH0zwt7ZYPh5GIA1FUFY0nfvcBVr7CGlVRnoMDmuiP1m/XX2nLe/DPDMyBM/3yrgkIH
         SUciftmbT+nZqDvN+vPMaTBOx/9/u+xxsKFXgUHL3Bhi1mAS0U36DTncY4g4+whOugHM
         2s3UyjaxfNFfPHp7Zh3KKTxHjei4QMJ9AyUPyUHa8CWY8EDUtsoJz93D49QHt6PbxxxF
         7NNg==
X-Gm-Message-State: AOJu0YzihCVUwCyFyim1BC8hb6Oekvdj/VokInDx9V43J5dAL84iv64x
	O0S23C2m0D0Ddi1zv5AUXZ2Us6HbPDfu3VGKMHc3bYiCWs9g7VLfr+7yoYlT5mfklHIMSyXa5NY
	49KFtV/xQzTKp1709P2hiZCMAZk1qdGMQhh4xw/n89sav6xjsFMNbkA==
X-Received: by 2002:a05:6e02:1448:b0:376:3ece:dc5 with SMTP id e9e14a558f8ab-39aebcfd6d7mr59344715ab.4.1722281924434;
        Mon, 29 Jul 2024 12:38:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFr0EX8Rn3mSqEEt3GUw+abMqFEUf+tKt0mB4Uq6uStdbdYSR4el8r3sMMLSdCqrlalI8+Cww==
X-Received: by 2002:a05:6e02:1448:b0:376:3ece:dc5 with SMTP id e9e14a558f8ab-39aebcfd6d7mr59344555ab.4.1722281924053;
        Mon, 29 Jul 2024 12:38:44 -0700 (PDT)
Received: from [10.0.0.71] (sandeen.net. [63.231.237.45])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-39ae9aa98bfsm29973975ab.81.2024.07.29.12.38.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jul 2024 12:38:43 -0700 (PDT)
Message-ID: <3b892a11-c5d6-4dac-bd83-6ee644f655f6@redhat.com>
Date: Mon, 29 Jul 2024 14:38:43 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH V2 v5.14.y] fuse: verify {g,u}id mount options correctly
To: gregkh@linuxfoundation.org, brauner@kernel.org, josef@toxicpanda.com
Cc: stable@vger.kernel.org
References: <2024072908-everglade-starved-66da@gregkh>
Content-Language: en-US
From: Eric Sandeen <sandeen@redhat.com>
In-Reply-To: <2024072908-everglade-starved-66da@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

commit 049584807f1d797fc3078b68035450a9769eb5c3 upstream.

As was done in
0200679fc795 ("tmpfs: verify {g,u}id mount options correctly")
we need to validate that the requested uid and/or gid is representable in
the filesystem's idmapping.

Cribbing from the above commit log,

The contract for {g,u}id mount options and {g,u}id values in general set
from userspace has always been that they are translated according to the
caller's idmapping. In so far, fuse has been doing the correct thing.
But since fuse is mountable in unprivileged contexts it is also
necessary to verify that the resulting {k,g}uid is representable in the
namespace of the superblock.

Fixes: c30da2e981a7 ("fuse: convert to use the new mount API")
Cc: stable@vger.kernel.org # 5.4+
Signed-off-by: Eric Sandeen <sandeen@redhat.com>

---

V2: send the right patch :(

(compile-tested only)

NOTE: This can also be trivially fixed by including the dependency noted in the
original failure (84c215075b57) which renamed "fc" to "fsc", then using the original
upstream patch.

diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 4a7ebccd359e..1951fcf0d910 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -540,6 +540,8 @@ static int fuse_parse_param(struct fs_context *fc, struct fs_parameter *param)
 	struct fs_parse_result result;
 	struct fuse_fs_context *ctx = fc->fs_private;
 	int opt;
+	kuid_t kuid;
+	kgid_t kgid;
 
 	if (fc->purpose == FS_CONTEXT_FOR_RECONFIGURE) {
 		/*
@@ -584,16 +586,30 @@ static int fuse_parse_param(struct fs_context *fc, struct fs_parameter *param)
 		break;
 
 	case OPT_USER_ID:
-		ctx->user_id = make_kuid(fc->user_ns, result.uint_32);
-		if (!uid_valid(ctx->user_id))
+		kuid =  make_kuid(fc->user_ns, result.uint_32);
+		if (!uid_valid(kuid))
 			return invalfc(fc, "Invalid user_id");
+		/*
+		 * The requested uid must be representable in the
+		 * filesystem's idmapping.
+		 */
+		if (!kuid_has_mapping(fc->user_ns, kuid))
+			return invalfc(fc, "Invalid user_id");
+		ctx->user_id = kuid;
 		ctx->user_id_present = true;
 		break;
 
 	case OPT_GROUP_ID:
-		ctx->group_id = make_kgid(fc->user_ns, result.uint_32);
-		if (!gid_valid(ctx->group_id))
+		kgid = make_kgid(fc->user_ns, result.uint_32);;
+		if (!gid_valid(kgid))
+			return invalfc(fc, "Invalid group_id");
+		/*
+		 * The requested gid must be representable in the
+		 * filesystem's idmapping.
+		 */
+		if (!kgid_has_mapping(fc->user_ns, kgid))
 			return invalfc(fc, "Invalid group_id");
+		ctx->group_id = kgid;
 		ctx->group_id_present = true;
 		break;
 



