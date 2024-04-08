Return-Path: <stable+bounces-37516-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF6D789C534
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 15:54:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB15328415D
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 13:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BF997C090;
	Mon,  8 Apr 2024 13:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PE8eVyFe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD396FE35;
	Mon,  8 Apr 2024 13:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712584463; cv=none; b=HBXrNDIXM3Jj37sMugyXkIwb7zcjxjEqN49NoFvSgtNMjAAwrplXmah0gZoTGW3lY9g0tpzdnwO0EXOB2RSPnRxlOvtRAnS0160HKR1lOJ1l3JJ7dAGmFD6lcIyL/zStO86XmR/1cxO+H6LZauIEEp0BIZsgJzf62MZXTE4Q+c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712584463; c=relaxed/simple;
	bh=PH4sPjpKnvNHb5NTMEG2wz8IWCMlgDRThXT4SAIV/18=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r8gFwtPZCf94OE2amfIp3D87CxesRcG0I7+z7UXNKYjAolT6zqo4N7SK7MCjthhAbwxfecLKCN8EJG3nXNCmA3tU1/pkjkPjfoAy3pp3jl+zx2GL+27XTD0FnH19hjOMvcH9FakyV+q7TD6cBRCdu1ZYMrVVi/c+Nr1ClgjlU0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PE8eVyFe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64D1AC433F1;
	Mon,  8 Apr 2024 13:54:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712584462;
	bh=PH4sPjpKnvNHb5NTMEG2wz8IWCMlgDRThXT4SAIV/18=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PE8eVyFenEaQm9uhoN9kuhuDpFXy4MFl37Fb/GR8/Hqdhzmc2Z0B0JJ/JqACC2KCh
	 SQS+8yxZrtTNc8AiDKU9gHPVvB9/tRDzi15sTkVkQAfIErZK2xwl1Jse66TTWh2qWl
	 P3Pew3dV4UgZ/TqNdWtN7EzCiMSTQbi1mAGYEIno=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	ChenXiaoSong <chenxiaosong2@huawei.com>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH 5.15 445/690] nfsd: use DEFINE_PROC_SHOW_ATTRIBUTE to define nfsd_proc_ops
Date: Mon,  8 Apr 2024 14:55:11 +0200
Message-ID: <20240408125415.770531070@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240408125359.506372836@linuxfoundation.org>
References: <20240408125359.506372836@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: ChenXiaoSong <chenxiaosong2@huawei.com>

[ Upstream commit 0cfb0c4228a5c8e2ed2b58f8309b660b187cef02 ]

Use DEFINE_PROC_SHOW_ATTRIBUTE helper macro to simplify the code.

Signed-off-by: ChenXiaoSong <chenxiaosong2@huawei.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/stats.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/fs/nfsd/stats.c b/fs/nfsd/stats.c
index a8c5a02a84f04..777e24e5da33b 100644
--- a/fs/nfsd/stats.c
+++ b/fs/nfsd/stats.c
@@ -32,7 +32,7 @@ struct svc_stat		nfsd_svcstats = {
 	.program	= &nfsd_program,
 };
 
-static int nfsd_proc_show(struct seq_file *seq, void *v)
+static int nfsd_show(struct seq_file *seq, void *v)
 {
 	int i;
 
@@ -72,17 +72,7 @@ static int nfsd_proc_show(struct seq_file *seq, void *v)
 	return 0;
 }
 
-static int nfsd_proc_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, nfsd_proc_show, NULL);
-}
-
-static const struct proc_ops nfsd_proc_ops = {
-	.proc_open	= nfsd_proc_open,
-	.proc_read	= seq_read,
-	.proc_lseek	= seq_lseek,
-	.proc_release	= single_release,
-};
+DEFINE_PROC_SHOW_ATTRIBUTE(nfsd);
 
 int nfsd_percpu_counters_init(struct percpu_counter counters[], int num)
 {
-- 
2.43.0




