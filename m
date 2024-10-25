Return-Path: <stable+bounces-88165-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 046369B059E
	for <lists+stable@lfdr.de>; Fri, 25 Oct 2024 16:22:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE1912847DF
	for <lists+stable@lfdr.de>; Fri, 25 Oct 2024 14:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A47F54673;
	Fri, 25 Oct 2024 14:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="TIf3i1Y0"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 939481FB8B0
	for <stable@vger.kernel.org>; Fri, 25 Oct 2024 14:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729866091; cv=none; b=CagB8aeehK6OF7rQhIqkZDr5+wHWNIggrmfa4Ju6rrbk6/bepbgMhXWq8AihXnrN6ON9lPL6hfRPo7XPp2fCbvee1GazGPQ73nqfkb1oxO0K0NLRT72D0IgfRFvWUeNuGlIS8XhaQzbT0k42ui9/Un895N/wzQJlZYyrFoC7tMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729866091; c=relaxed/simple;
	bh=fUxYCt4WudIVIASFuMgOLkq1Ik6At3UsRLf6ZnH9DIQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=R9pVdaCfllYbLfU++KzmddP+IkCQ6VqjRmBLAfiuPSai7kPnXWRESmVPadZsTj2MZOiFl1eWyIGuDGWZbfIvs7o0PdHcP02dDzH5lbSg39UymyTxdIBAeGjkkwgE043kYhWAR0IWPL/oV7XzR2dXz3Lp/BxxElwWU+ypXkE3H2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=TIf3i1Y0; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=8MISc/6r+zzLElAJ9boHfHuicDoSP8Po9PgwuhaVs/4=; b=TIf3i1Y0LUDOg/gIv6InH8fPBc
	mmD54zNgKjZGkFxzAN2pHJsjGZq96z1xuLwYzbsPxXZ/UVPkO0Us94Dabd/6zJyV160kSvTqYTqWp
	KrppV4K1NI+/okJXC2v9FM0kYD1NRRXRYeJP9s6qME7INd3jnzC4hFUOo95Yf2688kJRIFY8bWilf
	SB9a+22dyVYA25hVPvLsnp6381PExdxBg2WIHK3pCmprVLXJK82hh2cPdOgapr0uV1H8V8YN/oELW
	VuC7Dw7YIQPdjb8py95YeLLhgcRBxgHxgWroM3BYYM/vqSI7cIds+GfnxN3TMjOvpbiwaaaCpHj/Q
	+mwlIPWQ==;
Received: from 179-125-75-201-dinamico.pombonet.net.br ([179.125.75.201] helo=quatroqueijos.lan)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1t4LBr-00F3jb-SJ; Fri, 25 Oct 2024 16:21:24 +0200
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
To: stable@vger.kernel.org
Cc: Paul Moore <paul@paul-moore.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	Sam Sun <samsun1006219@gmail.com>,
	Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Subject: [PATCH 5.4] selinux: improve error checking in sel_write_load()
Date: Fri, 25 Oct 2024 11:21:18 -0300
Message-Id: <20241025142118.862881-1-cascardo@igalia.com>
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
index e9eaff90cbcc..fd6282fa9c39 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -535,6 +535,16 @@ static ssize_t sel_write_load(struct file *file, const char __user *buf,
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
@@ -543,23 +553,15 @@ static ssize_t sel_write_load(struct file *file, const char __user *buf,
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
@@ -578,6 +580,7 @@ static ssize_t sel_write_load(struct file *file, const char __user *buf,
 		"auid=%u ses=%u lsm=selinux res=1",
 		from_kuid(&init_user_ns, audit_get_loginuid(current)),
 		audit_get_sessionid(current));
+
 out:
 	mutex_unlock(&fsi->mutex);
 	vfree(data);
-- 
2.34.1


