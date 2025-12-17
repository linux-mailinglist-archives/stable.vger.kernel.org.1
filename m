Return-Path: <stable+bounces-202767-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CE972CC61F8
	for <lists+stable@lfdr.de>; Wed, 17 Dec 2025 07:01:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 681B8302A96B
	for <lists+stable@lfdr.de>; Wed, 17 Dec 2025 06:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D28FE2135B8;
	Wed, 17 Dec 2025 06:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="R+ipNg1Z"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 097EA3A1E79
	for <stable@vger.kernel.org>; Wed, 17 Dec 2025 06:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765951274; cv=none; b=MNXMVEIFO57Sd6mHoxtt6popr3M1xzEy9H4EOxqiqiLruaSuIjIuxzcDzbbvZxRcHfSOepEC0wAxBCV9rKYXI9oWOSdxMOIpY2k497LLyHaHaGVRSO8z2oy0l9ZAEt0bFQJxBewz3FArEU4hpHshXyk8va/MQ2K4uDloTVdHHTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765951274; c=relaxed/simple;
	bh=uJKEthvad56//QQXnTcJM+sA6uXIa/JWJsXjbxgsSkc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TO+IeLrF6gMIh1MWXGhpWH5SH7m0vaG+xanOisHyUjAwdYwQmHU4ab0RHtLZnYenqbOI10oNeRO0xNCMqZ9xbz6DPt9QdJ2dU8+A5oYs5+gLBl/jdXeOHM4E9ISB8jaJR3rEmimt2WfAT52awhEi352eSI6Iz8/u37esAZq23K8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=R+ipNg1Z; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2a0d06ffa2aso36524965ad.3
        for <stable@vger.kernel.org>; Tue, 16 Dec 2025 22:01:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1765951272; x=1766556072; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xgakhOh5sXI6AF8sz2NnJpekL42AonHY3n5DbiL1HAA=;
        b=R+ipNg1ZH0rk/DZFGWBVyJnPO1gLeGl6QJiztvzSiiign9mATPS46YUzbNlIec3Z8b
         DwiBFxUYA+ATALNs4dU7eS6WOU/jl27Lm2AtNvKTiXP3HfZ/zHerqpg94/5GkQT2DxNv
         2unAf8sPaN1WEddzxqU7rDSHCr93BAMmbJNI3bz+NEX6X5BwyliJwQkwXS/hgQUXmf8v
         ZGA8AaBHWuXPhd/BPb8glpnPoctUioazmnCrRGED0LW6gAiFinYygGsw+mfO0EcHolku
         LEGhaNQ7dCfUZVGUZN2rVhvGV72+d7YuLIql9hKsHKQ4cKeWZkwKyhCp4eMPQUPnOCS3
         NOzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765951272; x=1766556072;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xgakhOh5sXI6AF8sz2NnJpekL42AonHY3n5DbiL1HAA=;
        b=ZCJ4nnRZvfD4rppCTie0c5BbQcjV4eh05ZoDkDOmIxJjmLcIzgAtwTDqRjXLfBez1J
         hPqF5cBeOhgMM4XwNgwKeQFVapFH1F22otglMcpsXsR+RTW5U0OKBFiEqTccaQwPjxLZ
         NNBBDKzUAq40nIgnGSdhAzowvPJi4K5YMWRBEy/4pW3TU60PnT4NqBD9gaZM3WwirWfQ
         RThY70lX1IFOxAmWM145HiTU5i+sal3WlQcT7+UsRExmkG+8pPWma4h1CZdhTThGqvce
         UkrekUTq6LOyBYYoTyJ1edb9dyoIpzEag9v/9gKJjsHu154lZvuL3Cx2LVF0pqMdXlzQ
         9TKA==
X-Forwarded-Encrypted: i=1; AJvYcCVJend2RzjS3ZUblncLfTbSk7HpwkEbSEM3Q7tkY5hDFnGHezPJRvjFi7dGif3xLsyjSogUFHc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVFvxEQG3e0GhNcqFPV8cl8QNTcuBfu0uWzNaOY6vJhJEX2Ktb
	ByHTCtw5vUHDdzMvZWy+HoltWiyG/CUqtcPd/PnsUB6xju8w0FQYMeaQLtq+duqH8A==
X-Gm-Gg: AY/fxX73bFCXbS1PEQIn50sIGTliUF4vaRffvu4NMeDclP2kJ/tHo+GGW9JP3EmD8Lp
	Vn9BsmNa02JKTnCKCb1jNsxs12lkCc1eVAIu9bTPFUZdJCwQO1Dc2mGpTp/p7/aAYnSTz5bQ4rS
	MNVSnEy3+yXrIxJwNQ19edLghErIE7f6tYy1wde6kVCh9ff7sI9S82Ama83a6pmoqjt5A/qv6UX
	s0Kst/5cUMMQKJ90gYDIL0QYPldSJ56jHxrXC9HRyY4smJMvzBlm4u2IKJNHkQwW3OTP6+DMLQQ
	/PTGE4Ycv0JQhbUXOkUjTOZ3p4EWlQtNyWVT30BzwEvCh5sf/DeElhu2YOXbhaQ9JHle9WWlFEW
	pOrsFDxSWilpaOmS/jz2VEnGOt+z/jrK+L/wfncph7D5nwuWg1CSZs0+QGg5vCzlxJIInEf7MBi
	tP2Q459qrEGR1MHXzZCp8Ckk6+SDx2RzeJyP3HxbL5d8l38e/WhA==
X-Google-Smtp-Source: AGHT+IGOph63owqQR9doJjkKuJkjqGB/QfUJB5a74RlESyh56GONb7jxsZZOUzDKJaURI1MOTmjYYQ==
X-Received: by 2002:a05:7022:170d:b0:119:e56b:c758 with SMTP id a92af1059eb24-11f34c26239mr8249176c88.29.1765951272149;
        Tue, 16 Dec 2025 22:01:12 -0800 (PST)
Received: from will-mint.dhcp.asu.edu (ip72-200-102-19.tc.ph.cox.net. [72.200.102.19])
        by smtp.googlemail.com with ESMTPSA id a92af1059eb24-11f392500cdsm42405509c88.7.2025.12.16.22.01.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 22:01:11 -0800 (PST)
From: Will Rosenberg <whrosenb@asu.edu>
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	olrose55@gmail.com,
	paul@paul-moore.com,
	stable@vger.kernel.org,
	syzbot+6aaf7f48ae034ab0ea97@syzkaller.appspotmail.com,
	tj@kernel.org,
	whrosenb@asu.edu
Subject: [PATCH v4] fs/kernfs: null-ptr deref in simple_xattrs_free()
Date: Tue, 16 Dec 2025 23:01:07 -0700
Message-Id: <20251217060107.4171558-1-whrosenb@asu.edu>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <2025121745-chatty-jogging-ac2d@gregkh>
References: <2025121745-chatty-jogging-ac2d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There exists a null pointer dereference in simple_xattrs_free() as
part of the __kernfs_new_node() routine. Within __kernfs_new_node(),
err_out4 calls simple_xattr_free(), but kn->iattr may be NULL if
__kernfs_setattr() was never called. As a result, the first argument to
simple_xattrs_free() may be NULL + 0x38, and no NULL check is done
internally, causing an incorrect pointer dereference.

Add a check to ensure kn->iattr is not NULL, meaning __kernfs_setattr()
has been called and kn->iattr is allocated. Note that struct kernfs_node
kn is allocated with kmem_cache_zalloc, so we can assume kn->iattr will
be NULL if not allocated.

An alternative fix could be to not call simple_xattrs_free() at all. As
was previously discussed during the initial patch, simple_xattrs_free()
is not strictly needed and is included to be consistent with
kernfs_free_rcu(), which also helps the function maintain correctness if
changes are made in __kernfs_new_node().

Reported-by: syzbot+6aaf7f48ae034ab0ea97@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=6aaf7f48ae034ab0ea97
Fixes: 382b1e8f30f7 ("kernfs: fix memory leak of kernfs_iattrs in __kernfs_new_node")
Cc: stable@vger.kernel.org
Signed-off-by: Will Rosenberg <whrosenb@asu.edu>
---

Notes:
    v1 -> v2: fix patch formatting issues
    v2 -> v3: add cc stable branch
    v3 -> v4: re-add the notes section.
    
    This bug was introduced as part of a patch I made, fixing a memory
    leak in the error out case.
    
    I apologize for the oversight. Further fuzzing revealed the bug,
    and after checking, I found that syzbot detected the same issue.

 fs/kernfs/dir.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index 5c0efd6b239f..29baeeb97871 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -681,8 +681,10 @@ static struct kernfs_node *__kernfs_new_node(struct kernfs_root *root,
 	return kn;
 
  err_out4:
-	simple_xattrs_free(&kn->iattr->xattrs, NULL);
-	kmem_cache_free(kernfs_iattrs_cache, kn->iattr);
+	if (kn->iattr) {
+		simple_xattrs_free(&kn->iattr->xattrs, NULL);
+		kmem_cache_free(kernfs_iattrs_cache, kn->iattr);
+	}
  err_out3:
 	spin_lock(&root->kernfs_idr_lock);
 	idr_remove(&root->ino_idr, (u32)kernfs_ino(kn));

base-commit: d358e5254674b70f34c847715ca509e46eb81e6f
-- 
2.34.1


