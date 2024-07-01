Return-Path: <stable+bounces-56280-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DED2891EA22
	for <lists+stable@lfdr.de>; Mon,  1 Jul 2024 23:16:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 941A51F210AD
	for <lists+stable@lfdr.de>; Mon,  1 Jul 2024 21:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E69E84A32;
	Mon,  1 Jul 2024 21:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D8iGotT2"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D888276EEA
	for <stable@vger.kernel.org>; Mon,  1 Jul 2024 21:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719868595; cv=none; b=rUCkNvzJiaPCW4OLTqwQ4ie2//+4bAH5OSVPdDh9o10LvZi0YGcU+ZMmem3voPcRZy+nB6Lp5c7Bu3XDpZx/Lo3lToqdPDkPFTpC77gHvfIAXKRhgwL2jP7emz3AywjnNlIwbN4FLbj6j4XoEAKgNwqmcuFb3nQgEcS8aoihduQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719868595; c=relaxed/simple;
	bh=7nMZ2tCrAtpBSjMrAZ7ZJ8ydZg3/kINamfdDl2KGcPM=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=I01qK7tKVAS/P6kx/9IHnawixeNlMUuDdofJgCWG9/z6ACTKBhocGwV2Dm9mVWZb4S8xuiW3gxJd6BdD3ZeTcHsrg8oGKgF6jd8cv3Qzi4ldq7L7OHXzsJk3FtdR/UnwK4y6lXn02dtqs8QnWS6oVLwMcMSectau2Mf/ZcyK7z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D8iGotT2; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-36dd6110186so15203535ab.0
        for <stable@vger.kernel.org>; Mon, 01 Jul 2024 14:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719868593; x=1720473393; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mFX7hMxMhb8ZW+qkz5U4LMK6KRkXqQ2yOHaete5Gdn8=;
        b=D8iGotT2spFGs9qc/32+SfK+fjDgciyDKWmnWAJPxse5lTzEWVtifBVxtYWD0R754a
         9kSingKAsQSkYjDb8AXVAgo+l0hD2bAk2VTaaWpsUrMblJIKnZyxLvATa2OEOGKwsdGH
         zkWOOe31hBm7zEuwKNte/6ELZhQVPVEGCnyVpR9lB8zRqkU8nJKLwUfZ0/9z9R7cb+VC
         WZWR+vx0x/TePmD5tAvw2RcS0aBosxOXUcO1jCLKFwzqqr+/QVc78XKgTgMo2Y77lPp4
         oQNxl4oOrdaEPa2SLjw9yMM3qpyWHD2S+bfhK9vyDYt8vTFfbjgh906ld9H9iF1QYJtH
         vFhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719868593; x=1720473393;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mFX7hMxMhb8ZW+qkz5U4LMK6KRkXqQ2yOHaete5Gdn8=;
        b=Q6P/YxEiCKpIh7E1y1Z1epFnyt7NNqA3n/Bkrd3vnRgka8/sEOWfAGWRqI8YsGhFdC
         HrQcFf9QZMZzf+ou+cgSsh86sZTsjVolKzY2y3F0+jXyr3CP/SI1NbDZEgOe6gNS/ypr
         y2ALfnm/WAtHeIWb5Sp2WgDryRhb5l5zf6kwUuVD3AgKwfI0AZmwnl7d+fZ6u0D8edKG
         XMYI1rAhaRjfYdp9BFYzY/R8g5vC49dyPT6f457SlyJbSOUSd/eD+pwBhtBXjLHw0DaW
         3m1nYPvG4ud9y+eYt/sGrm4e5zCX5aUm92Gu4KdHNsyn0e8aLAFf4LN5YJGyGTHrP2Yw
         p7wQ==
X-Gm-Message-State: AOJu0YxB7NRTTRyFGAjSODl1Fyzz4G3amFfe4ic386th3S+P1K6/HP3B
	jdlb3708ViseQhTI+pUt9xmxpWW22GbVWX/nJQW159ozBPqRovwR
X-Google-Smtp-Source: AGHT+IGIoxEdYNhr7j7xixxldN0KNtT+OAeuPX7bGKBYu5RX66KVvINc1UE60DOZnUsYKXcNfNswZw==
X-Received: by 2002:a05:6e02:1d8d:b0:375:c443:9883 with SMTP id e9e14a558f8ab-37cd2bedf81mr81683095ab.21.1719868592894;
        Mon, 01 Jul 2024 14:16:32 -0700 (PDT)
Received: from [172.26.252.3] (c-75-71-174-102.hsd1.co.comcast.net. [75.71.174.102])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-37ae2586a3csm20319535ab.70.2024.07.01.14.16.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jul 2024 14:16:32 -0700 (PDT)
Message-ID: <58396eb8-145c-4f40-8387-efdf45c8b9db@gmail.com>
Date: Mon, 1 Jul 2024 15:16:31 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: rpeterso@redhat.com, agruenba@redhat.com
Cc: stable@vger.kernel.org, gfs2@lists.linux.dev
From: Clayton Casciato <majortomtosourcecontrol@gmail.com>
Subject: [PATCH v2 6.1.y] gfs2: Fix slab-use-after-free in gfs2_qd_dealloc
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

[ Upstream commit bdcb8aa434c6d36b5c215d02a9ef07551be25a37 ]

In gfs2_put_super(), whether withdrawn or not, the quota should
be cleaned up by gfs2_quota_cleanup().

Otherwise, struct gfs2_sbd will be freed before gfs2_qd_dealloc (rcu
callback) has run for all gfs2_quota_data objects, resulting in
use-after-free.

Also, gfs2_destroy_threads() and gfs2_quota_cleanup() is already called
by gfs2_make_fs_ro(), so in gfs2_put_super(), after calling
gfs2_make_fs_ro(), there is no need to call them again.

Backport notes:
The origin of a cherry-pick conflict is the (relevant) code block added in
commit f66af88e3321 ("gfs2: Stop using gfs2_make_fs_ro for withdraw")

There are no references to gfs2_withdrawn() nor gfs2_destroy_threads() in
gfs2_put_super(), so simply call gfs2_quota_cleanup() in a new else block
as bdcb8aa434c6 achieves.

Use else braces for consistency with the if block.

Reported-by: syzbot+29c47e9e51895928698c@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=29c47e9e51895928698c
Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
Signed-off-by: Clayton Casciato <majortomtosourcecontrol@gmail.com>
---
v1 -> v2:
Remove invalid tag
Add upstream commit's tags
Use current mailing list for GFS2
Use branch fragment instead of Git tag in subject
Differentiate upstream commit body and backport notes
Make body more imperative

Sponsor: 21SoftWare LLC
diff --git a/fs/gfs2/super.c b/fs/gfs2/super.c
index 302d1e43d701..6107cd680176 100644
--- a/fs/gfs2/super.c
+++ b/fs/gfs2/super.c
@@ -591,6 +591,8 @@ static void gfs2_put_super(struct super_block *sb)
 
 	if (!sb_rdonly(sb)) {
 		gfs2_make_fs_ro(sdp);
+	} else {
+		gfs2_quota_cleanup(sdp);
 	}
 	WARN_ON(gfs2_withdrawing(sdp));
 

