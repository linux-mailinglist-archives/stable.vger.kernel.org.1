Return-Path: <stable+bounces-202736-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B989ACC50FD
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 21:06:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B7F24303DD27
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 20:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D93E2ECE8F;
	Tue, 16 Dec 2025 20:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nTYyEzGe"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC99258ED7
	for <stable@vger.kernel.org>; Tue, 16 Dec 2025 20:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765915556; cv=none; b=H7QJY7vndnjpDvvXAzKConKjj0Mc7r3K2Nj9wAWQw+Doc2EN9rjGwDfff8DaqjnlmiDSpzP8dRM5fv6hWw+Q6lhjyblV3mkEeqxG3rH4aN5gxui0Y+AHOysa5tM5nYfXKZRyU+fq0jwf834o8F247QIYQ4sTRzIhAyEI4QYtrUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765915556; c=relaxed/simple;
	bh=2gtWttGGpvweLIEYAm1LIdNsm1ecj87EixohqJgLCSU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=id1h+eK9BMc7i7mxDYlizUvW7sgwRHfJXHEKJadCO9gueu9WcUSqlqLoI9EjzyqmM2a7NB9OitJTYvK1ZjqJOVCMAQu1LMHBv0oVL6y7cj/bMMWC1aRFW0LvEd0fVcnXrZeOlQeXl4O8xqVZX9QmEOrx2lJ/Bd1RuQP48HXvhkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nTYyEzGe; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2a0d0788adaso27304765ad.3
        for <stable@vger.kernel.org>; Tue, 16 Dec 2025 12:05:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765915554; x=1766520354; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nk5VEo3f/bbA5JsoMBtqnTR2AhljYyWjNqK2HiCPcog=;
        b=nTYyEzGeHbkSOiH1YmQhyL0ks8Mxv1oYx++nnDDjHKlpUZDNirWxV9M6cAZcQSc+9i
         DglkE1PeMeabBJx6YuGy03J96NAXMU3Qs8CpvnokgcsWamEX6ZhjufBCPnZnF938jjZc
         Dqag8tN/kbtYuwSLBNFPtdM9UgE531rNhcse/ggr62YHXlEXEHeEwF2vesP4APs3TyNM
         9L5kVq3/An1bx19ev/XhGTbiAIP39ZTSzAbbi1xt1hIAJHNRad7OL5pbTzCaLiCBYovB
         yFwQkBRX1LCi6E/7jCqctb32EDUM9hXALj8IVvyfJkiBZ6Rra6KrnahgMtrFM1MQ7GCv
         bYQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765915554; x=1766520354;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nk5VEo3f/bbA5JsoMBtqnTR2AhljYyWjNqK2HiCPcog=;
        b=IQTdz6Pf1cwwJ1kTn1itzl3CAHjn2RGeyk3CKYbR9zMbgeXi8dcczM+J362lV6lhiy
         TfxC4MGwCEc+kB78B1r6lb5sHvHG8jZ+QNKCh1+vTwDOs8Xjr4B6sT4GMIYxjnsH2wte
         UJhItHRe2MuFqBSMAVsU+0WeRUnKXzJWR59EIdwLzoTreNvnwdHNYGrUMIBhbclQ4fSZ
         K9XwFI++cHMrxl0b9JbcGMwMTaQkt/EyoyggAMVbdEgdJdBCoo67Gu7mD+DAN4yL4OaT
         crNYiA03kkZvpED9q7t778s+Fg9nLsXR2B1ckp4O6mYisyWT8qjtJv2AliQMljcTc7sg
         B/nQ==
X-Forwarded-Encrypted: i=1; AJvYcCW1Lu7sVHFki8Horxprj+SnJbbfuBHQN4e7DmGHKPV2JdUXdiZxZT1Z9E50IGp0AiDNR9S6W+g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8CWfkD5S/sTbHEEMwi02jnwaHwhIa6smLR/sBBz4WjwLSkq87
	DEUeQUC4Y3JGK77zjnVimLQjXFO/5kmzuA+1mqY2drBMfmY6PpWdYDCr
X-Gm-Gg: AY/fxX60wB+nksKxiv1H30EEMUyxXrNjxNKBOwGDw5UYNSl7r5mPBr7FMs1XfWY98vS
	e/Hznr0CwqWczRmQR0Wpi512hagSDNweu8qqVucQLNHZOZgYoUTIQ1rlERe8J/NxywNVKtAe4tr
	LD4PD1YcEPAo7CsgsUGIfAWO4S/RbW8l5QCVu+UuIAmlzwMr7zAUDtVPxXSqXdB35NG8dezEWg2
	9s4PrEH/Wkz67pIe8T3iNnyJ4E+JBR7DWUsI/dZdDxQjltWtB0kFnsjYlWI2bBz0GexoiCsOXTK
	HE+/tPrSab3oo/+AFjppPdvXTVUoiVrWsYd5/RPRQTTMj7vlWyO07+Wbbdui0Nsw9cvocZzgnoh
	WcoKtdMvl3jVALLDaEga4Cz+j3u47YQ1n1Y0867g7pLcz/yWmmEKfAo5IaqGl42E2/huoQSuP2X
	XfsjDrNH19vIPMWbx//f7AppfC1Nw=
X-Google-Smtp-Source: AGHT+IFBB9lpgo0EscsFPmTDrekwuTdVKsOIVSCKfGeWbaP7aOmozgyPAliYKh+tJ6xigpQG1/qjWQ==
X-Received: by 2002:a17:903:234a:b0:2a0:9eed:5182 with SMTP id d9443c01a7336-2a09eed5585mr124313435ad.20.1765915553651;
        Tue, 16 Dec 2025 12:05:53 -0800 (PST)
Received: from localhost.localdomain ([111.125.240.40])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29ee9d38ae7sm175407925ad.35.2025.12.16.12.05.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 12:05:53 -0800 (PST)
From: Prithvi Tambewagh <activprithvi@gmail.com>
To: mark@fasheh.com,
	jlbec@evilplan.org,
	joseph.qi@linux.alibaba.com
Cc: ocfs2-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com,
	khalid@kernel.org,
	Prithvi Tambewagh <activprithvi@gmail.com>,
	syzbot+779d072a1067a8b1a917@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: [PATCH] ocfs2: handle OCFS2_SUPER_BLOCK_FL flag in system dinode
Date: Wed, 17 Dec 2025 01:35:44 +0530
Message-ID: <20251216200544.4114-1-activprithvi@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When ocfs2_populate_inode() is called during mount process, if the flag
OCFS2_SUPER_BLOCK_FL is set in on-disk system dinode, then BUG() is
triggered, causing kernel to panic. This is indicative of metadata
corruption.

This is fixed by calling ocfs2_error() to print the error log and the
corresponding inode is marked as 'bad', so that it is not used further
during the mount process. It is ensured that the fact of that inode being
bad is propagated to caller ocfs2_populate_inode() i.e.
ocfs2_read_locked_inode() using is_bad_inode() and further behind along
the call trace as well.

Reported-by: syzbot+779d072a1067a8b1a917@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=779d072a1067a8b1a917
Tested-by: syzbot+779d072a1067a8b1a917@syzkaller.appspotmail.com
Cc: stable@vger.kernel.org
Signed-off-by: Prithvi Tambewagh <activprithvi@gmail.com>
---
 fs/ocfs2/inode.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/fs/ocfs2/inode.c b/fs/ocfs2/inode.c
index 12e5d1f73325..f439dc801845 100644
--- a/fs/ocfs2/inode.c
+++ b/fs/ocfs2/inode.c
@@ -347,7 +347,12 @@ void ocfs2_populate_inode(struct inode *inode, struct ocfs2_dinode *fe,
 	} else if (fe->i_flags & cpu_to_le32(OCFS2_SUPER_BLOCK_FL)) {
 		/* we can't actually hit this as read_inode can't
 		 * handle superblocks today ;-) */
-		BUG();
+		ocfs2_error(sb,
+			    "System Inode %llu has "
+			    "OCFS2_SUPER_BLOCK_FL set",
+			    (unsigned long long)le64_to_cpu(fe->i_blkno));
+		make_bad_inode(inode);
+		return;
 	}
 
 	switch (inode->i_mode & S_IFMT) {
@@ -555,6 +560,11 @@ static int ocfs2_read_locked_inode(struct inode *inode,
 
 	ocfs2_populate_inode(inode, fe, 0);
 
+	if (is_bad_inode(inode)) {
+		status = -EIO;
+		goto bail;
+	}
+
 	BUG_ON(args->fi_blkno != le64_to_cpu(fe->i_blkno));
 
 	if (buffer_dirty(bh) && !buffer_jbd(bh)) {
@@ -576,7 +586,7 @@ static int ocfs2_read_locked_inode(struct inode *inode,
 	if (can_lock)
 		ocfs2_inode_unlock(inode, lock_level);
 
-	if (status < 0)
+	if (status < 0 && !is_bad_inode(inode))
 		make_bad_inode(inode);
 
 	brelse(bh);

base-commit: d76bb1ebb5587f66b0f8b8099bfbb44722bc08b3
-- 
2.43.0


