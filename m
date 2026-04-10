Return-Path: <stable+bounces-235554-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2J9wAtdU2Gn1bwgAu9opvQ
	(envelope-from <stable+bounces-235554-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 03:39:35 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id DF4F03D129E
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 03:39:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 395D63017267
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 01:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D674632BF51;
	Fri, 10 Apr 2026 01:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YX3Ro4w8"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D7F299929
	for <stable@vger.kernel.org>; Fri, 10 Apr 2026 01:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775785167; cv=none; b=nG5EiLzHTHJS8w36WcEnSMqdSjoHLuGbEiXbimdGY+K+xHFFa7kstBx/hXmuq98UruFvppN00miPI3rbIEMMixdOn2PT+79XG9fTk7TmP42VykAlcIr+cYgYLJr1aidES89P3eIQWXMaGMTthwHqOaqS0WIfBku7cYI3L5NHMw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775785167; c=relaxed/simple;
	bh=UmYbWjFmL0HUR06WzBtGfn94DTlfpaiNwHkys0bQ2mo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AC9Z6gdYfKXzwllRgynN73eA/T4tgYUyeep7Pq5pJwtqEweCsupFga9799nH9peFGTYA9OdqEgGswt9QinWJtD9EcDm49B+JOY4LHwB3ZCQd20eCQeSdrkjo3trL0dngrL1XKT47vQZTcn6pGLu4oWGP67NnON4P3JIfVP3/zGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YX3Ro4w8; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-8c70b5594f4so149835585a.1
        for <stable@vger.kernel.org>; Thu, 09 Apr 2026 18:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775785165; x=1776389965; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LbmLmSM6DVlP3rK+1kHNDWZ++XMdSOh/sxx/yDae12E=;
        b=YX3Ro4w8G3EOLYF1vwbcVwIHmgTEIwUXANJ2WSFC2juJOBy+ibV6plhAE8jvRdDzAJ
         1brNlhrF/5uhYNMnNPQutwD0JEACt1cytcp9IisuonqQ/q4ArPTNzHIXWZUhfYX0lTnh
         51sxuSWGJAbQ7QbVIFj5tbazaoUfoC+ZgA8uNjy8hncSmrWr+txCU/IrjdvGU76fjupT
         F4T4TKqND6j5IelHTVitrxh6pm5wBnAu0kN9OpWAsZtEVBOu5su78nDwq9NakIc6DX6N
         cUUNYgHVeyohIQ+gAXi3wFRgToq67DamkYMNPyVdTQ3ZP73Lmb17HByCoGDL0iIwf7tc
         02wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775785165; x=1776389965;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LbmLmSM6DVlP3rK+1kHNDWZ++XMdSOh/sxx/yDae12E=;
        b=IBE+YTO4yDZLLEXP5N1Ji1loW2D5VTXN4strcC6x/hBBHtOpQNXscf5do5QiB6jpu7
         NqyKhXG7FXZBVWzIY6IosF1H5t7wTq2JeSkFtalQgIIkrp+z7zqxlUczVnqVfb2V+VFb
         ytyQhPzR5BEptSiTl2ymXAoG/c/gSGoBJ5pY9Yk2CB3HnX3eUOQNM/di/tAN2pp4haR8
         1AizDHeszfFIsMZjWWJ/wVaFPcgcgy8rP12R9WZ9R4SHyeR9/9frsdtSpVvsBCXYB30S
         KKLrgwqh7OL+SCpJQwuB4wZneAtb/0rXHPIqZKiEsN0+RvdLfZqP3fP7JtKgr8bmHC0K
         qpNQ==
X-Forwarded-Encrypted: i=1; AJvYcCXmxv8Mri+YEPC0zog6xfO6ZorMqBFJMMVtdcRRndHz2rRsPZLZ4A8QQkCYbCikKznCHBmNk1c=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywe9NMH8VIioWSE7eABL40ZPBI+ZtYk6890G2WZ8M0wZ5myhFlW
	Rqrq3Kl5i7KbLHhHIo4pD+PjMD/DNczUEB3RSiyyxOBszKTC47MN8n5V
X-Gm-Gg: AeBDievavXfocA5B10yB5I8G9N9wjqWIU89miF3pckQOgUIHHWHPAmNXSI72bqUxX5I
	uFLNOry5Y8GQ/1aqkEOHZkHGB8OSiYhwQuIwn8rBjnxo8UQSwPjWUd5Prp5ZsEUiafYfNPjnIrN
	7PbwMHxHJkS248kmrzH6n780q4pUj5uTBtdaKPb5HwLVS7Hd79e8EVbs4C+JPmvUL4X1CDn7/l4
	huYirmZM7KSrzmU7/zra0pdcD2wAPCoBD85q0FHI3EosdNS9EySFbgcaXt8qiIw6wWW1gsWAN7b
	OsIihVhLw0d4Mm0nPjF+JEn3vTop3VSBJRtFVkYHK8pC9R2wT040YxbEplFZykXf/54269XbwjG
	4EmNV5K7FIiW+Pvpx41ABFTLZQqSa3txkBRR8RYzcdIbOC1mHdmAOpc9e+Qhs/A5voe86ryIHl+
	ddGistrPrYCc1clNxm4ShpaFoK16IY+T4SX2gkpVf9dcPzeT7BvFMDlz3OL/whCd2SyZVsuGfXE
	yQe1N7uuGhv5buyfOQ8oHMwTl4w0r8ZSgEYliw=
X-Received: by 2002:a05:620a:254f:b0:8cf:de26:91e2 with SMTP id af79cd13be357-8ddd03a2c5cmr148941085a.16.1775785165305;
        Thu, 09 Apr 2026 18:39:25 -0700 (PDT)
Received: from TDC4045031631.e0cglfehwr0e5gttmepj3hi3hf.ux.internal.cloudapp.net ([20.63.37.123])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8ddb6949954sm98525285a.21.2026.04.09.18.39.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 18:39:24 -0700 (PDT)
From: Ashutosh Desai <ashutoshdesai993@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: mcanal@igalia.com,
	itoral@igalia.com,
	stable@vger.kernel.org,
	Ashutosh Desai <ashutoshdesai993@gmail.com>
Subject: [PATCH] drm/v3d: Limit ioctl extension chain depth to prevent infinite loop
Date: Fri, 10 Apr 2026 01:39:07 +0000
Message-Id: <20260410013907.2404175-1-ashutoshdesai993@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[igalia.com,vger.kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-235554-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ashutoshdesai993@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: DF4F03D129E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

v3d_get_extensions() walks a userspace-provided singly-linked list of
ioctl extensions without any bound on the chain length.  A local user
can craft a self-referential extension (ext->next == &ext) with zero
in_sync_count and out_sync_count, which bypasses the existing duplicate-
extension guard:

    if (se->in_sync_count || se->out_sync_count)
            return -EINVAL;

The guard never fires because v3d_get_multisync_post_deps() returns
immediately when count is zero, leaving both fields at zero on every
iteration.  The result is an infinite loop in kernel context, blocking
the calling thread and pegging a CPU core indefinitely.

Both i915 (stackdepth = 512) and xe (MAX_USER_EXTENSIONS = 16) impose
an explicit depth limit on the same pattern.  Apply the same defence to
V3D by capping the walk at 16 extensions.

Cc: stable@vger.kernel.org
Signed-off-by: Ashutosh Desai <ashutoshdesai993@gmail.com>
---
 drivers/gpu/drm/v3d/v3d_submit.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/v3d/v3d_submit.c b/drivers/gpu/drm/v3d/v3d_submit.c
index 18f2bf1fe..491eeb6b3 100644
--- a/drivers/gpu/drm/v3d/v3d_submit.c
+++ b/drivers/gpu/drm/v3d/v3d_submit.c
@@ -802,12 +802,18 @@ v3d_get_extensions(struct drm_file *file_priv,
 	struct v3d_file_priv *v3d_priv = file_priv->driver_priv;
 	struct v3d_dev *v3d = v3d_priv->v3d;
 	struct drm_v3d_extension __user *user_ext;
+	unsigned int ext_count = 0;
 	int ret;
 
 	user_ext = u64_to_user_ptr(ext_handles);
 	while (user_ext) {
 		struct drm_v3d_extension ext;
 
+		if (ext_count++ >= 16) {
+			drm_dbg(&v3d->drm, "Too many V3D ioctl extensions\n");
+			return -E2BIG;
+		}
+
 		if (copy_from_user(&ext, user_ext, sizeof(ext))) {
 			drm_dbg(&v3d->drm, "Failed to copy submit extension\n");
 			return -EFAULT;
-- 
2.34.1


