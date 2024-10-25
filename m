Return-Path: <stable+bounces-88166-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A962C9B05A0
	for <lists+stable@lfdr.de>; Fri, 25 Oct 2024 16:22:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B36A2848C6
	for <lists+stable@lfdr.de>; Fri, 25 Oct 2024 14:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F2A21FB891;
	Fri, 25 Oct 2024 14:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="ALdq7KuH"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56BEF7083B
	for <stable@vger.kernel.org>; Fri, 25 Oct 2024 14:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729866099; cv=none; b=L6I7kAjT+gh8ZZqCA+79eg1m+UmTMAg4W6mAyhrprIv01+ncYk77z8wih+oABORWJ+0KPvDBBGB8xUVhqzEyupqVwlhrj39yMefxwhWjIstwALH1DpYouc3calJgWGOg+2r1uRI8Ywz8OnVInQpeDxTx0tzbDCR+DJjVmPAHFKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729866099; c=relaxed/simple;
	bh=CxvjK4KaXH96Q6pqFkXDJJDgzD9FM8HtChvRYoXswG8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=slMPsi/taIbEU0nXQZmDOcc6fPH9WPhILN/37vwUskpMoqYkYRNDHZxs5Y1d7De/Q3w6bi4d0JvMpTJO4F9QYuzatKMhMWzDGu8thUPhr98GHCohIIV7VG9NOVEd2EyxNsGPtrGQFTL5O8iiH4Rg1l+cXk2LQiOku197bAY9Ld0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=ALdq7KuH; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=DbuYHFZ9RD1Q51bvgRH0Z5CkXaHVaPSIYUlU12rVbME=; b=ALdq7KuHkxiRTJfkBurGEFnNjN
	60K7OE2aGT5LlqOXHMI4KtfrDbqrryikcSXiMkmkFKBYWRClSlonbtWA0PEPy+tz+xy7IEar34Ah6
	F4i0prcgQZj37Il2w/gJXqFsoJH3V+zIbRxtdJ15tM8ZrF02gspambCvE+qW2iDcIi+Cz7OX7X8EJ
	Uh9RXlqQBuPPR/uTIcRdeSazuDbhKCtL5gjMXnzMjBMxnkMiqZi0EyM5JFGNZorC6JAbURNLbxwm9
	1wovzKbI1P5N2LVhX3uZGE8p/jqCEWJGokToNkBpgxiC1bfy1u3MbcPrq/SbwoMVDWexJKIMhbsSR
	OF9OfaGw==;
Received: from 179-125-75-201-dinamico.pombonet.net.br ([179.125.75.201] helo=quatroqueijos.lan)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1t4LC3-00F3jz-4h; Fri, 25 Oct 2024 16:21:35 +0200
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
To: stable@vger.kernel.org
Cc: Paul Moore <paul@paul-moore.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	Sam Sun <samsun1006219@gmail.com>,
	Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Subject: [PATCH 4.19] selinux: improve error checking in sel_write_load()
Date: Fri, 25 Oct 2024 11:21:29 -0300
Message-Id: <20241025142129.862916-1-cascardo@igalia.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Paul Moore <paul@paul-moore.com>

[ Upstream commit 42c773238037c90b3302bf37a57ae3b5c3f6004a ]

Move our existing input sanity checking to the top of sel_write_load()
and add a check to ensure the buffer size is non-zero.

Move a local variable initialization from the declaration to before it
is used.

Minor style adjustments.

Reported-by: Sam Sun <samsun1006219@gmail.com>
Signed-off-by: Paul Moore <paul@paul-moore.com>
[cascardo: keep fsi initialization at its declaration point as it is used earlier]
[cascardo: keep check for 64MiB size limit]
Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
---
 security/selinux/selinuxfs.c | 31 +++++++++++++++++--------------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index 60b3f16bb5c7..c35aab9f2447 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -536,6 +536,16 @@ static ssize_t sel_write_load(struct file *file, const char __user *buf,
 	ssize_t length;
 	void *data = NULL;
 
+	/* no partial writes */
+	if (*ppos)
+		return -EINVAL;
+	/* no empty policies */
+	if (!count)
+		return -EINVAL;
+
+	if (count > 64 * 1024 * 1024)
+		return -EFBIG;
+
 	mutex_lock(&fsi->mutex);
 
 	length = avc_has_perm(&selinux_state,
@@ -544,23 +554,15 @@ static ssize_t sel_write_load(struct file *file, const char __user *buf,
 	if (length)
 		goto out;
 
-	/* No partial writes. */
-	length = -EINVAL;
-	if (*ppos != 0)
-		goto out;
-
-	length = -EFBIG;
-	if (count > 64 * 1024 * 1024)
-		goto out;
-
-	length = -ENOMEM;
 	data = vmalloc(count);
-	if (!data)
+	if (!data) {
+		length = -ENOMEM;
 		goto out;
-
-	length = -EFAULT;
-	if (copy_from_user(data, buf, count) != 0)
+	}
+	if (copy_from_user(data, buf, count) != 0) {
+		length = -EFAULT;
 		goto out;
+	}
 
 	length = security_load_policy(fsi->state, data, count);
 	if (length) {
@@ -579,6 +581,7 @@ static ssize_t sel_write_load(struct file *file, const char __user *buf,
 		"auid=%u ses=%u lsm=selinux res=1",
 		from_kuid(&init_user_ns, audit_get_loginuid(current)),
 		audit_get_sessionid(current));
+
 out:
 	mutex_unlock(&fsi->mutex);
 	vfree(data);
-- 
2.34.1


