Return-Path: <stable+bounces-23243-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B58585E96A
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 22:04:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCFEE1F22B8D
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 21:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1810886AFC;
	Wed, 21 Feb 2024 21:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XkYVzpiq"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D7D7CF03
	for <stable@vger.kernel.org>; Wed, 21 Feb 2024 21:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708549437; cv=none; b=V7mp7YkMeg9s/HtrXc2LQh2oSjOzsaDnZxF/HAWRA3oAskSfygVgPqYTCURdWqxzyySwNDGmmnJEcQ5dWYG9Lut/bf4uXgwOY0bKy//neCZrlnQjlGV7TFxC5UW4odlMIqM4tGgGwysL1ZlmOpQXLLclG0d8zVv6i/U+gUbqfNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708549437; c=relaxed/simple;
	bh=ohb243JcxVMv87lHKJOrwlHRXzxPcwkUVNHaZxmOKQc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=UV0hjbFk17q7aD3Rvawa3QcZVibGi5k577XO7Mmtlq1SYGDNXhPeSeGEyMYgSb8ZewMnjp48jgejoIgeWElwok1+8sDc5br6+lgIST26DdS8mouHQckiiEyXpKdhtLKySqPHTC/qnyi66EH0Ix/RqWmgtU1WUgMgYy1iHOApJfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dhavale.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XkYVzpiq; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dhavale.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc6b26783b4so6904879276.0
        for <stable@vger.kernel.org>; Wed, 21 Feb 2024 13:03:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708549434; x=1709154234; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7SrJM1oyxiJBee5rhTbp+mwhYJ/a30jfajx9Ht8Agks=;
        b=XkYVzpiqe9fl7KoD+u8Q5nDChNIcsunBNiRAFuXr6iUOprEDFc3Ds5mxPGuJI+ap6n
         0t4u+LCIQJ7R19UHG4QhqUIeSMQgB/zMsJZlUcJF0qhBb4Dr93McDs211lzb//3/AMZp
         3/bV+LbmaZKiZ7g3EkS1hgvfpaf6jbdPHNcyscVSUqaIFVxNhItvoni3ZPOzguxVDCQ/
         t8oVMpIDtjxxNOw++Ngs7KuMhwlv/zFiRrE4rqOaRnV15hayHSPCCMlVAOjuRviiNpLa
         dCLuO996tSsfrqevRTu/ucyGW7sEf8MjaWxvMk06w37R6py9PghQgqxZvWh1482eH27a
         bFiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708549434; x=1709154234;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7SrJM1oyxiJBee5rhTbp+mwhYJ/a30jfajx9Ht8Agks=;
        b=OFeczw1RqheC9kpUU/+2qiTK9RWeTholGVGCOs7yWpF3usxlz34eUfOYSy7mt67TOK
         tN5/gsYKJleVn/mceJhf9wbfEr5FGqiOagbAzm8UtTiRJrITDmrd+AIf+GgkFr3aLsj9
         SBMVV+dVNuroZKSNC00QSbwSNXxEl48kZuLgSdb708a2UNulTOh/Tysg0aKrzp6Fz60i
         /PWRZ0gsYC3YOh4K6sRqVaBdGkXTAYgb4xwL9Dia4f8DrDS3pKATz2jtexClLIiUHT58
         6ITW/UF3px+iVbBK3/kMBGB5NobO1qxXoR7UcpOIQFKWUF9RqcCrSDHCETCfRZgPs3qG
         RDlA==
X-Forwarded-Encrypted: i=1; AJvYcCX18GNUr8GxKVDkDdO+kZEi6nLrqB56C/cDccBm0K046ZSDnfG3hmrgQqMCEShbZIxEhRYAQo4hei+cdAvgmdTekEDjhgW0
X-Gm-Message-State: AOJu0Yw1vNXpZKC2YgO6RwMEkOYOCcOad+0CLrlKXknaR9NZwT7ntHls
	R8lsIS6cps3zr04Bk3xqiQ8jVQiydQWlWUTrrL8k3hR2VaPQp7a3uRugUXbmpW4SKCxneICh6gs
	R4HLT3A==
X-Google-Smtp-Source: AGHT+IGfQ7tP0IsEPfMeTEUa+hP//eArvfxvolLuo29MkXjSjnUdg2wVPoB/uWCNVbaUgyFPLcxJaw3bv2eA
X-Received: from dhavale-desktop.mtv.corp.google.com ([2620:15c:211:201:e195:1d33:bc5c:369a])
 (user=dhavale job=sendgmr) by 2002:a05:6902:1505:b0:dc6:c94e:fb85 with SMTP
 id q5-20020a056902150500b00dc6c94efb85mr19718ybu.2.1708549434314; Wed, 21 Feb
 2024 13:03:54 -0800 (PST)
Date: Wed, 21 Feb 2024 13:03:47 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <20240221210348.3667795-1-dhavale@google.com>
Subject: [PATCH v2] erofs: fix refcount on the metabuf used for inode lookup
From: Sandeep Dhavale <dhavale@google.com>
To: Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>, Yue Hu <huyue2@coolpad.com>, 
	Jeffle Xu <jefflexu@linux.alibaba.com>
Cc: quic_wenjieli@quicinc.com, Sandeep Dhavale <dhavale@google.com>, stable@vger.kernel.org, 
	kernel-team@android.com, linux-erofs@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

In erofs_find_target_block() when erofs_dirnamecmp() returns 0,
we do not assign the target metabuf. This causes the caller
erofs_namei()'s erofs_put_metabuf() at the end to be not effective
leaving the refcount on the page.
As the page from metabuf (buf->page) is never put, such page cannot be
migrated or reclaimed. Fix it now by putting the metabuf from
previous loop and assigning the current metabuf to target before
returning so caller erofs_namei() can do the final put as it was
intended.

Fixes: 500edd095648 ("erofs: use meta buffers for inode lookup")
Cc: stable@vger.kernel.org
Signed-off-by: Sandeep Dhavale <dhavale@google.com>
---
Changes since v1
- Rearrange the cases as suggested by Gao so there is less duplication
    of the code and it is more readable

 fs/erofs/namei.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/fs/erofs/namei.c b/fs/erofs/namei.c
index d4f631d39f0f..f0110a78acb2 100644
--- a/fs/erofs/namei.c
+++ b/fs/erofs/namei.c
@@ -130,24 +130,24 @@ static void *erofs_find_target_block(struct erofs_buf *target,
 			/* string comparison without already matched prefix */
 			diff = erofs_dirnamecmp(name, &dname, &matched);
 
-			if (!diff) {
-				*_ndirents = 0;
-				goto out;
-			} else if (diff > 0) {
-				head = mid + 1;
-				startprfx = matched;
-
-				if (!IS_ERR(candidate))
-					erofs_put_metabuf(target);
-				*target = buf;
-				candidate = de;
-				*_ndirents = ndirents;
-			} else {
+			if (diff < 0) {
 				erofs_put_metabuf(&buf);
-
 				back = mid - 1;
 				endprfx = matched;
+				continue;
+			}
+
+			if (!IS_ERR(candidate))
+				erofs_put_metabuf(target);
+			*target = buf;
+			if (!diff) {
+				*_ndirents = 0;
+				return de;
 			}
+			head = mid + 1;
+			startprfx = matched;
+			candidate = de;
+			*_ndirents = ndirents;
 			continue;
 		}
 out:		/* free if the candidate is valid */
-- 
2.44.0.rc0.258.g7320e95886-goog


