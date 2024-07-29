Return-Path: <stable+bounces-62604-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 291B993FE44
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 21:31:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C55F1F2246C
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 19:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D8F77FBD1;
	Mon, 29 Jul 2024 19:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fKBrXeN0"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F636374CC
	for <stable@vger.kernel.org>; Mon, 29 Jul 2024 19:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722281460; cv=none; b=csSmH96/AL00AxybwqzLBSROjDsN90yY+/M9KQssAn0qOU28t8nBzNcaK0tLf3EIIxhUYIwDYyY447ekN98qXj1W5/UvYITx5a+0SnDZwJnhWEomVlcwsUqMCTjxGRNuMnjtuKTnDAVBCG3bmyTH/LFZU2bI6qS4a1QjmAUb6KY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722281460; c=relaxed/simple;
	bh=rDRMA9PLY2iC3CII/7HP4V6nXocXkWvEsTBBwOQq0FQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rFPx5BTx6RUi6rhOmYjVfwlR5n40IKVrj7CJ0dnEJvGXouBGFo5EcygsvK84hIdbROv0dJUma+6SqNU50rxO0BlMvd7MHpaLqdVymcUSI/Re4mTJozS4OR6TKR/R/RMfePXQPnOjq22OHRUX2WG1os4wmk7YNDUE0RH4lKdYgEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fKBrXeN0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722281457;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xgR+9riiiuD//ITu7XslJZTIrwNjYw7D153cIzYpvj0=;
	b=fKBrXeN0LRPxGSny05/pAc2x8emJIOeVkEceBVxCX3Wc5VMSG6lwizZZeYRn7AmPzQbc4A
	S6cWDbQ3HJh1SHs9lq+iE4MFWwNnuEdAWlTc1XVJH3JLt15FKQCc8xwsF0wRlKOuvI97PJ
	dFFcf5TAL5szwPxTRxTpXmbrwC9UlYE=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-519-ybRAmbBkNIGuSHMZFyuftQ-1; Mon, 29 Jul 2024 15:30:56 -0400
X-MC-Unique: ybRAmbBkNIGuSHMZFyuftQ-1
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-81f7fb0103fso480541339f.0
        for <stable@vger.kernel.org>; Mon, 29 Jul 2024 12:30:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722281455; x=1722886255;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xgR+9riiiuD//ITu7XslJZTIrwNjYw7D153cIzYpvj0=;
        b=DJcY1U0IZiBIsAP5YujxNF+X7qkLUQtw0tAFa1U1R+MYROFwE14I4scvIzILO4311v
         xOcOdZKzxd+dg2b/BWEebOxkHX4PLEiUMAGWaDFqIIMsk+7/kq35tJfUGlldwOdlVXw2
         J+M74nW4GL4mQUWyFJMOLoi9tLr9EyLU3cA31V232QBFonx+wwNFekugF23TpIVdD96n
         +QLk/++CxXm4t/DpAstB3RXZkPpltq5elxSiznvz/xih/uDMvZ2nb436YsKbtN50MI7L
         vIFcAFX0NQmGFHCpEPBwh5wmhMem7tzI7vUilM5M/cnq8lk254u65k7l+I4Dx5uUesCn
         sfag==
X-Gm-Message-State: AOJu0YziMy5iuUd3MRBM4oyhgMgou5nLeykCiy5zD4FmAHXDfdDXCG28
	E9KOjl1c/LdRYbxKa+qQI2K3u7Govo9Sqa57s5/2pEl1azJXifTF4TuISZgZ8DZrU31AkAd78rN
	xDwcLU+5FGH8B0ohb1Jzpd6QJDMQH+9cw4DGMNxZPC5g4Xcbc/sqNEw==
X-Received: by 2002:a05:6e02:1448:b0:376:3ece:dc5 with SMTP id e9e14a558f8ab-39aebcfd6d7mr59128475ab.4.1722281455225;
        Mon, 29 Jul 2024 12:30:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHIXq0uVEdb/45wi+m//H5/fLvYZgszzTfCQAl9Ja8mMc5VkluzU/MRamxZsoRqoIL8k7qhWA==
X-Received: by 2002:a05:6e02:1448:b0:376:3ece:dc5 with SMTP id e9e14a558f8ab-39aebcfd6d7mr59128255ab.4.1722281454836;
        Mon, 29 Jul 2024 12:30:54 -0700 (PDT)
Received: from [10.0.0.71] (sandeen.net. [63.231.237.45])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-39a22e974efsm41734245ab.19.2024.07.29.12.30.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jul 2024 12:30:54 -0700 (PDT)
Message-ID: <2468c31e-f861-4e72-ba5a-66768d468e44@redhat.com>
Date: Mon, 29 Jul 2024 14:30:53 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v5.14.y] fuse: verify {g,u}id mount options correctly
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

(compile-tested only)

NOTE: This can also be trivially fixed by including the dependency noted in the
original failure (84c215075b57) which renamed "fc" to "fsc"

diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 4a7ebccd359e..23a98b7d1f28 100644
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
+		kuid =  make_kuid(fsc->user_ns, result.uint_32);
+		if (!uid_valid(kuid))
 			return invalfc(fc, "Invalid user_id");
+		/*
+		 * The requested uid must be representable in the
+		 * filesystem's idmapping.
+		 */
+		if (!kuid_has_mapping(fsc->user_ns, kuid))
+			return invalfc(fsc, "Invalid user_id");
+		ctx->user_id = kuid;
 		ctx->user_id_present = true;
 		break;
 
 	case OPT_GROUP_ID:
-		ctx->group_id = make_kgid(fc->user_ns, result.uint_32);
-		if (!gid_valid(ctx->group_id))
+		kgid = make_kgid(fsc->user_ns, result.uint_32);;
+		if (!gid_valid(kgid))
+			return invalfc(fsc, "Invalid group_id");
+		/*
+		 * The requested gid must be representable in the
+		 * filesystem's idmapping.
+		 */
+		if (!kgid_has_mapping(fsc->user_ns, kgid))
 			return invalfc(fc, "Invalid group_id");
+		ctx->group_id = kgid;
 		ctx->group_id_present = true;
 		break;
 



