Return-Path: <stable+bounces-62613-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78D4D93FF6E
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 22:29:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 339AC2847AB
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 20:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3896518C346;
	Mon, 29 Jul 2024 20:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y1cjXrH1"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 392AE154C0D
	for <stable@vger.kernel.org>; Mon, 29 Jul 2024 20:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722284692; cv=none; b=XOyeET8ZJvRQuDrOnoP+wUYF4ivNeKwiSDxyaByCTF9usr1BEm0TA9c+ZSFbG+tq/n6pGQRdVcnfhH8FWpDAlK2/sW4BRhr7hAYB9e9u9DWOBdvV54uKdt6nGfOtzG3OleFDiJMtk1LGjw+Z0h+S3WSPZ1OF0EJSUlPN5s1Tu28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722284692; c=relaxed/simple;
	bh=zwhmVijnEPlCslT6aN/fxmaAO3Scy4ayHjHDmVStI5U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SuOKXjz5g9pMQardSZ0sj/nJfFDVwS6iNMVGXYRLQmvn+z1Ym8bhRSSWS57SnDgN1MMV73IaUVlx8ffyM6lAAzOpTA3KP53o/ZNOCrHMV6H46mUI5+D3HFuTipjAhjMI9aU1fngCtyCkdj0RqBSQJNJ35+NCqie2Gvg6HMkVmjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y1cjXrH1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722284689;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Jn7ILdNLGnUdQlJqD2nf1+eOZa5aVTj170e8PuSmz6A=;
	b=Y1cjXrH1U2qhARadCJpAfeDNKIZbd/qip/z3uzSqjk8DvUYu5iSeX7vZs4qAslCqoZGVXi
	UK9koQQjjD5mDcl8T2bPCdER2sgEhCkeEgcNWOVEuiDbBMMekRIP+Jq4hKAfkYUBwLWzbg
	6iVX3z5wQ1omFRlk4mXKqI+iYchoCwo=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-581-FbzgGiOONxeDpuoQIdD0tw-1; Mon, 29 Jul 2024 16:24:47 -0400
X-MC-Unique: FbzgGiOONxeDpuoQIdD0tw-1
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3983ed13f0bso63483205ab.2
        for <stable@vger.kernel.org>; Mon, 29 Jul 2024 13:24:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722284687; x=1722889487;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jn7ILdNLGnUdQlJqD2nf1+eOZa5aVTj170e8PuSmz6A=;
        b=VanESoqsf4dF17Eb422lpLmu5gbkulVxhJLBWZkqvWW8+wBc0I1orvNTfIOVcUA78y
         8NMZ8pKy87jmE84+T3zuO2mB7FhXqhT0HL2aNy7muvrJctV5jRmGAcfsrUr2hKqMxnyV
         Jqtuw2XACrcL1kNSqo7y/Ud6ulhkB6b8PyeiO8cH0kyMnvLEdU/S2V3Km+aEae1MwPUU
         ZO0j+FXlz29pT6yIkeqe2RWraqQegHySmTPC+u9hi5WfbIb8yNZd3I26k79vweHfbn/9
         xjdP2Smp8Mf9/Z43DWo6AGBQw+O9zu8mELMeuTdmrmbulCLsx48fYxaavbtQBoJwdoll
         J18g==
X-Gm-Message-State: AOJu0Yx5qDxqyajU05tMRMTeFwu2DcMJFF7yH4uDghaS9NfEaqtT2Cs4
	7VXzqexvMKDPTxUgiYDb3NuJQw+agEPjWEPhyQfOvn6I5O7ZcQ3n+uaeQm9kLkzdmEnfrAe6Bpj
	2ymegPImeU1i7/wFvSNjdVfdpOR6SG/2oAHtXsywvJXMJ4ik8gqkMpQ==
X-Received: by 2002:a05:6e02:b22:b0:375:a3d8:97be with SMTP id e9e14a558f8ab-39aec2dcd13mr108017975ab.9.1722284686834;
        Mon, 29 Jul 2024 13:24:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGvi7/Mbp3h0p9Tggo6QfdlX2FM6ATtmdu1UETibOUcMnPuPANfh1roVXGZyKusSj7H+MrtGw==
X-Received: by 2002:a05:6e02:b22:b0:375:a3d8:97be with SMTP id e9e14a558f8ab-39aec2dcd13mr108017795ab.9.1722284686470;
        Mon, 29 Jul 2024 13:24:46 -0700 (PDT)
Received: from [10.0.0.71] (sandeen.net. [63.231.237.45])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-39af6a3bab3sm16738875ab.69.2024.07.29.13.24.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jul 2024 13:24:46 -0700 (PDT)
Message-ID: <c669a201-2646-4247-ad58-b767d1b331a2@redhat.com>
Date: Mon, 29 Jul 2024 15:24:45 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v5.4.y] fuse: verify {g,u}id mount options correctly
To: gregkh@linuxfoundation.org, brauner@kernel.org, josef@toxicpanda.com
Cc: stable@vger.kernel.org
References: <2024072914-sierra-aflutter-e231@gregkh>
Content-Language: en-US
From: Eric Sandeen <sandeen@redhat.com>
In-Reply-To: <2024072914-sierra-aflutter-e231@gregkh>
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

This backport required working around several missing dependencies
(fsc vs fc, invalfc vs invalf, integers vs. booleans) so probably best to
just do the one-off backport here like this, vs a string of dependencies.

diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 287e850fbd64..e558612be606 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -490,6 +490,8 @@ static int fuse_parse_param(struct fs_context *fc, struct fs_parameter *param)
 	struct fs_parse_result result;
 	struct fuse_fs_context *ctx = fc->fs_private;
 	int opt;
+	kuid_t kuid;
+	kgid_t kgid;
 
 	/*
 	 * Ignore options coming from mount(MS_REMOUNT) for backward
@@ -530,16 +532,30 @@ static int fuse_parse_param(struct fs_context *fc, struct fs_parameter *param)
 		break;
 
 	case OPT_USER_ID:
-		ctx->user_id = make_kuid(fc->user_ns, result.uint_32);
-		if (!uid_valid(ctx->user_id))
+		kuid = make_kuid(fc->user_ns, result.uint_32);
+		if (!uid_valid(kuid))
 			return invalf(fc, "fuse: Invalid user_id");
+		/*
+		 * The requested uid must be representable in the
+		 * filesystem's idmapping.
+		 */
+		if (!kuid_has_mapping(fc->user_ns, kuid))
+			return invalf(fc, "fuse: Invalid user_id");
+		ctx->user_id = kuid;
 		ctx->user_id_present = 1;
 		break;
 
 	case OPT_GROUP_ID:
-		ctx->group_id = make_kgid(fc->user_ns, result.uint_32);
-		if (!gid_valid(ctx->group_id))
+		kgid = make_kgid(fc->user_ns, result.uint_32);
+		if (!gid_valid(kgid))
+			return invalf(fc, "fuse: Invalid group_id");
+		/*
+		 * The requested gid must be representable in the
+		 * filesystem's idmapping.
+		 */
+		if (!kgid_has_mapping(fc->user_ns, kgid))
 			return invalf(fc, "fuse: Invalid group_id");
+		ctx->group_id = kgid;
 		ctx->group_id_present = 1;
 		break;
 


