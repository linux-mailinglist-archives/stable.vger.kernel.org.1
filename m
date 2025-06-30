Return-Path: <stable+bounces-158878-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE700AED772
	for <lists+stable@lfdr.de>; Mon, 30 Jun 2025 10:36:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82D187A53B9
	for <lists+stable@lfdr.de>; Mon, 30 Jun 2025 08:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 510A7241CA8;
	Mon, 30 Jun 2025 08:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JKHQ5+0m"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A426D2397B0;
	Mon, 30 Jun 2025 08:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751272556; cv=none; b=MkyJy+X5binDkq8S3I1K7K97YCvtcVdawAPXQWiUJlHk0HmQ4xe2OEPXhOeH1QAV5gFNTmefaqUHjzSxc2J4BYp8IKheigLuianix2DvUqFKZTj1pT3CL5wbL6e3IGyBthFid/mfVsZMg0ApFnRTJYnuC+ldVWRqR2uhH33rr5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751272556; c=relaxed/simple;
	bh=hbl6aKOFyrCpAMd3O9ukAhgw6X3wjq6glq0MIKEE2gk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ErGUBPFysG91mUBF9ojvcghNbT9geuCUuAs0dB0i9q79NKEWFdFUd1uxKIo2fblix5T+4aeTf20lC0Ts49QvxcvPa4YvSyBohEUZ1ZePGIQntgS/XvX/oY4c4oimDnsCDhtRxCYhba1rA9ylyn80pduVvw23Pms8igTamTkn/RY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JKHQ5+0m; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-74801bc6dc5so4034473b3a.1;
        Mon, 30 Jun 2025 01:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751272554; x=1751877354; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=c4plGK5bq5RnwaM8ctVOu6ZgjjUnMHD+gm6XjSI880o=;
        b=JKHQ5+0mIWsvzEMBMcDUAmcgBy55rmQ3rcn1DGIbNTcTC3GLWshpC85OVWQwJvehlC
         NyDJrx8wdAACQYqlngeAK7X6bPQSsaVFawCNzIbb0bcHs0p+oOtrV6qb63kdPhjN7DYK
         dbgxVdOo0xffpjb6QgPPnEmyDriPVWVn50OFgjnaAH9v4ozUIgPniQVvFV6daYXfsqd3
         N1YZw1J8wKIDOSJHr38tdpB7hsOh7w8S0f9GMvd+ASqToYeYolnf3GAPhl5R7B/+sc39
         LTTnzJoqfhxOozti/ufmjAJGkG0EUiiC6h/MwEwKcTOs9Y3Kq1k1apdJvfHibUsexSyr
         FQDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751272554; x=1751877354;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c4plGK5bq5RnwaM8ctVOu6ZgjjUnMHD+gm6XjSI880o=;
        b=Grn2rb/O4/qZj+u5KQSaBNW/jWtfzbY2uBLFr8GB6rAGh/HB+Y0MNRNKHkWNbgJbJX
         3FLjFUylGXLK594tXXoV/P8iWlxCgvI6SH2GDV89h48B3CtEnxQTgASoNQ50ffgl6n71
         NBne4vHT4Qxi6Ex6vJYuAsuQexB+8yrqIcrp5A32LlryOO4vSMIdeSnjqV7pwIm6V4L9
         VrNDkqdwlsnaKlfB50NjwoQq7uSvy/3+Csc5eZOXfnW4N0NWobhL2jrIfXxvCpuSrsXm
         P/tXDAUxcPqEulk4Ohd8IwaXbfNPRhFMHx577WxMnj3IYzc12lnn8OdRuzQzT/UaWdOg
         ko3w==
X-Forwarded-Encrypted: i=1; AJvYcCWq5eLLt0bFdCGSWJsMi5sKVa2dFPljj8Ta0ZPslresfNXuYMFY+YbSPHedI+lkzRxKEIPTiZs1@vger.kernel.org, AJvYcCWtoGwAl3e37GNZJW+VFSdMOr4RDs8KzXW6wx7Vwb/mBGsgI5anL2wPn0bkQT54aGpaXb2QF834grGeuAY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywf2stLFz+Yuu2o/UbJBOiHQCXsJX9X/+0kVrIOz0KJGKd1jak8
	FoCpvRrnX3eB2IU8RT24oxTgLsoeK/x28Rr6di/eSpT+4VKOV174RqKm
X-Gm-Gg: ASbGncuRl58ZQxnpZt5OCT9BZvtcxOb9qLc5aTigArtkOMLsfbMdBetltwqiiySzeRK
	r/OXZz11SGywNDKqPVZcKeII2BsRA5HGLtYZO3Y+kMDlgUqloVHMAhWdcmfZWMCLhclLS+VFb3V
	2WBRoi0NI6Q9ffDANxDSnmq58kwEcdvqmNzdZ+JZv2bVf0mgGBYux4PpdoOonXTf3GUMLp3aBw1
	NthaUKmj8SoYdVDK1UfteFCiEYt6N700mjEy4bbm9STq/7nu25XZacH5CLueVJlkn+Iofl5qPfE
	mtVCOQDyK+6YgFwNPRd5HEhgRJe5J9CuQ1GIIRi5GjkX5dtRuet7AljOLmlCD2N/RK61UN00iYw
	XlVFPow==
X-Google-Smtp-Source: AGHT+IGM9wfHSeMMXfeBZheGggepk2ZqiWnb9R0ko13yd/AL0hGgh5N+CjMk8e3oprn88leMOC/mQA==
X-Received: by 2002:a05:6a00:b52:b0:748:6a12:1b47 with SMTP id d2e1a72fcca58-74af7aef473mr17756726b3a.10.1751272553630;
        Mon, 30 Jun 2025 01:35:53 -0700 (PDT)
Received: from manjaro.domain.name ([2401:4900:1c31:3031:bed6:689:68b3:ea6e])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74af57ebcb5sm8320722b3a.151.2025.06.30.01.35.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 01:35:53 -0700 (PDT)
From: Pranav Tyagi <pranav.tyagi03@gmail.com>
To: ocfs2-devel@oss.oracle.com,
	linux-kernel@vger.kernel.org
Cc: mark@fasheh.com,
	jlbec@evilplan.org,
	joseph.qi@linux.alibaba.com,
	pvmohammedanees2003@gmail.com,
	akpm@linux-foundation.org,
	gregkh@linuxfoundation.org,
	sashal@kernel.org,
	skhan@linuxfoundation.org,
	stable@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	syzbot+e0055ea09f1f5e6fabdd@syzkaller.appspotmail.com,
	Junxiao Bi <junxiao.bi@oracle.com>,
	Changwei Ge <gechangwei@live.cn>,
	Gang He <ghe@suse.com>,
	Jun Piao <piaojun@huawei.com>,
	Pranav Tyagi <pranav.tyagi03@gmail.com>
Subject: [PATCH 5.15.y] ocfs2: fix deadlock in ocfs2_get_system_file_inode
Date: Mon, 30 Jun 2025 14:05:42 +0530
Message-ID: <20250630083542.10121-1-pranav.tyagi03@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mohammed Anees <pvmohammedanees2003@gmail.com>

[ Upstream commit 7bf1823e010e8db2fb649c790bd1b449a75f52d8 ]

syzbot has found a possible deadlock in ocfs2_get_system_file_inode [1].

The scenario is depicted here,

	CPU0					CPU1
lock(&ocfs2_file_ip_alloc_sem_key);
                               lock(&osb->system_file_mutex);
                               lock(&ocfs2_file_ip_alloc_sem_key);
lock(&osb->system_file_mutex);

The function calls which could lead to this are:

CPU0
ocfs2_mknod - lock(&ocfs2_file_ip_alloc_sem_key);
.
.
.
ocfs2_get_system_file_inode - lock(&osb->system_file_mutex);

CPU1 -
ocfs2_fill_super - lock(&osb->system_file_mutex);
.
.
.
ocfs2_read_virt_blocks - lock(&ocfs2_file_ip_alloc_sem_key);

This issue can be resolved by making the down_read -> down_read_try
in the ocfs2_read_virt_blocks.

[1] https://syzkaller.appspot.com/bug?extid=e0055ea09f1f5e6fabdd

[ Backport to 5.15: context cleanly applied with no semantic changes.
Build-tested. ]

Link: https://lkml.kernel.org/r/20240924093257.7181-1-pvmohammedanees2003@gmail.com
Signed-off-by: Mohammed Anees <pvmohammedanees2003@gmail.com>
Reviewed-by: Joseph Qi <joseph.qi@linux.alibaba.com>
Reported-by: <syzbot+e0055ea09f1f5e6fabdd@syzkaller.appspotmail.com>
Closes: https://syzkaller.appspot.com/bug?extid=e0055ea09f1f5e6fabdd
Tested-by: syzbot+e0055ea09f1f5e6fabdd@syzkaller.appspotmail.com
Cc: Mark Fasheh <mark@fasheh.com>
Cc: Joel Becker <jlbec@evilplan.org>
Cc: Junxiao Bi <junxiao.bi@oracle.com>
Cc: Changwei Ge <gechangwei@live.cn>
Cc: Gang He <ghe@suse.com>
Cc: Jun Piao <piaojun@huawei.com>
Cc:  <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Pranav Tyagi <pranav.tyagi03@gmail.com>
---
 fs/ocfs2/extent_map.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/ocfs2/extent_map.c b/fs/ocfs2/extent_map.c
index 70a768b623cf..f7672472fa82 100644
--- a/fs/ocfs2/extent_map.c
+++ b/fs/ocfs2/extent_map.c
@@ -973,7 +973,13 @@ int ocfs2_read_virt_blocks(struct inode *inode, u64 v_block, int nr,
 	}
 
 	while (done < nr) {
-		down_read(&OCFS2_I(inode)->ip_alloc_sem);
+		if (!down_read_trylock(&OCFS2_I(inode)->ip_alloc_sem)) {
+			rc = -EAGAIN;
+			mlog(ML_ERROR,
+				 "Inode #%llu ip_alloc_sem is temporarily unavailable\n",
+				 (unsigned long long)OCFS2_I(inode)->ip_blkno);
+			break;
+		}
 		rc = ocfs2_extent_map_get_blocks(inode, v_block + done,
 						 &p_block, &p_count, NULL);
 		up_read(&OCFS2_I(inode)->ip_alloc_sem);
-- 
2.49.0


