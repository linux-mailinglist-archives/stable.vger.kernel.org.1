Return-Path: <stable+bounces-174800-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C568B364FA
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 15:43:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D707464FFC
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 13:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39F9D230BDF;
	Tue, 26 Aug 2025 13:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fZ6o9MXV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34432797A1;
	Tue, 26 Aug 2025 13:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756215352; cv=none; b=oKznl926N4WcKVCXuMTdnt8pxjQmsqwMUq6ABEYfjvyEh5JsbTrjwbO9Zsff3ayLQzecuuGMdryHhC5lo1sFL034IfrIZoNRoZ2/KFdEibvs8i6HQc9cwkv0L7Bvbj08284aul09aFh9YDlyPjlBm7jDlA3HQmWedFzHpjvND8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756215352; c=relaxed/simple;
	bh=LCtHvhaZ7K9d3Fhu8YHwhcevIY6yMoI8FXjrQZtl/3s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RpUqYwbkIY56HKpFsdtZBG5QNCEMGxV7hE8l1upoXOQuOT8etYEDoLRuFsbCLQTzeiUnDuSk0EwhePIPbrIG3yqpkyXWL/fbhPSswgQrEsbKnHtNOqPoxDVuJEiyHLFIsG39z4E88mSMU5V3BF/tlleeM3zIzGiIjwTulQFL5GE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fZ6o9MXV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12425C4CEF1;
	Tue, 26 Aug 2025 13:35:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756215351;
	bh=LCtHvhaZ7K9d3Fhu8YHwhcevIY6yMoI8FXjrQZtl/3s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fZ6o9MXVX0K6WMiUs99wjHEmWpYFxSxlDu31Dtfk5xOC/0pu6oKmR3kvZG+W5AI8P
	 RPr71d3KQb2cg/BcLnGYFpkctKDuiLNyqR/2JKPUPYzWjRej1VXSPvbgEJ0LutwSny
	 +wOGzhsGKMDO5RUUc8JjGb0YSNH5qp7Rt/Otg0Mk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mete Durlu <meted@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Peter Oberparleiter <oberpar@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 480/482] s390/hypfs: Avoid unnecessary ioctl registration in debugfs
Date: Tue, 26 Aug 2025 13:12:13 +0200
Message-ID: <20250826110942.673385301@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250826110930.769259449@linuxfoundation.org>
References: <20250826110930.769259449@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Peter Oberparleiter <oberpar@linux.ibm.com>

[ Upstream commit fec7bdfe7f8694a0c39e6c3ec026ff61ca1058b9 ]

Currently, hypfs registers ioctl callbacks for all debugfs files,
despite only one file requiring them. This leads to unintended exposure
of unused interfaces to user space and can trigger side effects such as
restricted access when kernel lockdown is enabled.

Restrict ioctl registration to only those files that implement ioctl
functionality to avoid interface clutter and unnecessary access
restrictions.

Tested-by: Mete Durlu <meted@linux.ibm.com>
Reviewed-by: Vasily Gorbik <gor@linux.ibm.com>
Fixes: 5496197f9b08 ("debugfs: Restrict debugfs when the kernel is locked down")
Signed-off-by: Peter Oberparleiter <oberpar@linux.ibm.com>
Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/s390/hypfs/hypfs_dbfs.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/arch/s390/hypfs/hypfs_dbfs.c b/arch/s390/hypfs/hypfs_dbfs.c
index f4c7dbfaf8ee..c5f53dc3dbbc 100644
--- a/arch/s390/hypfs/hypfs_dbfs.c
+++ b/arch/s390/hypfs/hypfs_dbfs.c
@@ -64,24 +64,28 @@ static long dbfs_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	long rc;
 
 	mutex_lock(&df->lock);
-	if (df->unlocked_ioctl)
-		rc = df->unlocked_ioctl(file, cmd, arg);
-	else
-		rc = -ENOTTY;
+	rc = df->unlocked_ioctl(file, cmd, arg);
 	mutex_unlock(&df->lock);
 	return rc;
 }
 
-static const struct file_operations dbfs_ops = {
+static const struct file_operations dbfs_ops_ioctl = {
 	.read		= dbfs_read,
 	.llseek		= no_llseek,
 	.unlocked_ioctl = dbfs_ioctl,
 };
 
+static const struct file_operations dbfs_ops = {
+	.read		= dbfs_read,
+};
+
 void hypfs_dbfs_create_file(struct hypfs_dbfs_file *df)
 {
-	df->dentry = debugfs_create_file(df->name, 0400, dbfs_dir, df,
-					 &dbfs_ops);
+	const struct file_operations *fops = &dbfs_ops;
+
+	if (df->unlocked_ioctl)
+		fops = &dbfs_ops_ioctl;
+	df->dentry = debugfs_create_file(df->name, 0400, dbfs_dir, df, fops);
 	mutex_init(&df->lock);
 }
 
-- 
2.50.1




