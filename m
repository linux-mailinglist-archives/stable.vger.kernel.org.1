Return-Path: <stable+bounces-189205-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B7412C04DC9
	for <lists+stable@lfdr.de>; Fri, 24 Oct 2025 09:53:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A7D574E497C
	for <lists+stable@lfdr.de>; Fri, 24 Oct 2025 07:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52A922EF64F;
	Fri, 24 Oct 2025 07:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="UD9pj4AV"
X-Original-To: stable@vger.kernel.org
Received: from out203-205-221-236.mail.qq.com (out203-205-221-236.mail.qq.com [203.205.221.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A622EC0A8
	for <stable@vger.kernel.org>; Fri, 24 Oct 2025 07:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761292424; cv=none; b=OaTcZLExcCObMSuVwh7oSd9BZbEoWf5jVTzYuPGt2SCV2GAPdpuYA0aRKxKCsPsql898QEdyEkmDh7slzy+KCqkcBT8TH05XIObjGd49tKCxwTqdrCSTFYaccIoPEkiEhiOnOSguyuduekHWxYv1hj5GOior+zyWZUYr6WWp/co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761292424; c=relaxed/simple;
	bh=dPXkEIITRhomINqmTyQA+eVrHnGlWDuUZ+OrABZ9qo0=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version:Content-Type; b=Ja06t6yq8eZVIu46IMXU051cLCQC8lBvwlZTeX5rP69AfUsugL2o/+vpUw1qereaM8jrDo76fGuj6g8OvtrDaQcxn8FegoHHXA212w6XO0/MkVyxEFrvXG6wyiFuYdi7Xzy/gDaDALz4zWw6aExWqEIK/602Jrwr9WFVweVVkr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=UD9pj4AV; arc=none smtp.client-ip=203.205.221.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1761292111;
	bh=pywK2lTvUZrvoHr448x6NRnbVj3r3ht5Va+dSCz38Fk=;
	h=From:To:Cc:Subject:Date;
	b=UD9pj4AVCh6dZn+YN6Dvfp7DmBmtXXVgu73gvBydA/RX9DE7PF9y+pjaN4DAgdKTU
	 tFKgjNfBKd5UWIHLG+nSeOytwLXDLGVoZHNq1fSTxkwDa9ArLNJRXHXdBZT9+mMb+S
	 urHdCecA/SCgE59fKU5eiW3ACL+0CHalKq3VuhWQ=
Received: from LAPTOP-HOSUGD0G.wrs.com ([183.241.55.170])
	by newxmesmtplogicsvrszb20-0.qq.com (NewEsmtp) with SMTP
	id C0B8700E; Fri, 24 Oct 2025 15:48:11 +0800
X-QQ-mid: xmsmtpt1761292091taz7iaupe
Message-ID: <tencent_090D49B411357A1F369220D6F238A4301408@qq.com>
X-QQ-XMAILINFO: NMHonNIP0l2dKkmRyBkPDQVKpvRa8u7blgV4ZQ+V6NQ8a++LqCnfwZFjgTWQWu
	 wG1V1vorGfvcnSOCtY14oGLu0b/yEkV4jOaYTbOIE3LMt1DFWS3tWq/RY7mV7iCZGerNxdddTnSJ
	 WZMDUCG8pFGP+/JqsyZdyD0uodxsfWHaULdgEf8zcM93QHno8mJlO0pBlTnHwbrrJobCq/NePBJS
	 o7t01eGcZ93h/iHMTkqsymm5XtxgLefqYWtzBZIGoXhxeWJ5qt/eFsrwMa9W1UvhvXjgUX3ZeC5h
	 EKKuHSq9FVkz4irCKmyp1uke/TKJa7M2APokSaVmIM+orY63kDxSOyvcOZuIg0uZ7z8naLR9fyxh
	 EW2ZBLffuudREK/ISYhzopJe4ROJQFDOOD27X9Jyb0swSO95Ou2iAT5dMMLHGiK7rGL+I1Pcvu66
	 Httl0AMnzPzbaTl6xbcuoyIRDY+KkoNOba6Q1SU2SDpb+T2frjUt1tUzBuNcMeG8dilczdgiMKWk
	 cmZy5SZ174D7l87Vnx6cjJizFsvi9IUMW/EGEMKKg7V+Ymwqs3LZwxSA7RngDGgyQX53gOuVBegb
	 QxOjEwLSRQ1sQ1Hes0jXT2rW78a6TPn5L1Dp2lI2jD1wesS08LE8aQOSct7h1mcerNBVzkQlfOd2
	 2G4eb13SqR6FLn7bRt/29Z5HLD0uqzyxH/WN/OI81Uo2GEqqHjq+6zmkdgIhltlnbwGVgsJz94VR
	 TBHJEJ1xrwOGUtWMh+yiAFYj7tqmkVPWoPOolM3QTJzFpIXYyOL7+Nig5XJ4ZTly+o0y+PfEe1e0
	 jjhiSo6iIyrnxGsdK0pXZsYgmkveM+7TqXzZ/qjOL/G4F0wS7dTd432dq4bOQBlFcjONuT5aTgUs
	 rf9UWFA+dghwe0jQ+9t2GIXIGIcUL+vp7ixkZjvlx4VGwZ8NZWp0F7DhBRicVWSnEsXD5L3qn5ku
	 7O6RKZHblZhMaTucVsVkbapVYOpC/AvTKCRRkL/Dmm2ylGO1bRHwURd8puoUJ6A6A8Ra09q2w30l
	 74dRJkQqdjsgDRUZ5vWa/8k/e2HluRHW5N6bAbIQbo59I0DB/X
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
From: alvalan9@foxmail.com
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: Suma Hegde <suma.hegde@amd.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Alva Lan <alvalan9@foxmail.com>
Subject: [PATCH 6.12.y] platform/x86/amd/hsmp: Ensure sock->metric_tbl_addr is non-NULL
Date: Fri, 24 Oct 2025 15:48:08 +0800
X-OQ-MSGID: <20251024074808.1411-1-alvalan9@foxmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Suma Hegde <suma.hegde@amd.com>

[ Upstream commit 2c78fb287e1f430b929f2e49786518350d15605c ]

If metric table address is not allocated, accessing metrics_bin will
result in a NULL pointer dereference, so add a check.

Fixes: 5150542b8ec5 ("platform/x86/amd/hsmp: add support for metrics tbl")
Signed-off-by: Suma Hegde <suma.hegde@amd.com>
Link: https://lore.kernel.org/r/20250807100637.952729-1-suma.hegde@amd.com
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
[ Minor context change fixed. ]
Signed-off-by: Alva Lan <alvalan9@foxmail.com>
---
 drivers/platform/x86/amd/hsmp.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/platform/x86/amd/hsmp.c b/drivers/platform/x86/amd/hsmp.c
index 8fcf38eed7f0..66deb475f807 100644
--- a/drivers/platform/x86/amd/hsmp.c
+++ b/drivers/platform/x86/amd/hsmp.c
@@ -569,6 +569,11 @@ static ssize_t hsmp_metric_tbl_read(struct file *filp, struct kobject *kobj,
 	if (!sock)
 		return -EINVAL;
 
+	if (!sock->metric_tbl_addr) {
+		dev_err(sock->dev, "Metrics table address not available\n");
+		return -ENOMEM;
+	}
+
 	/* Do not support lseek(), reads entire metric table */
 	if (count < bin_attr->size) {
 		dev_err(sock->dev, "Wrong buffer size\n");
-- 
2.43.0


