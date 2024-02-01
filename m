Return-Path: <stable+bounces-17578-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BA0E845818
	for <lists+stable@lfdr.de>; Thu,  1 Feb 2024 13:50:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B1981F28309
	for <lists+stable@lfdr.de>; Thu,  1 Feb 2024 12:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C34686645;
	Thu,  1 Feb 2024 12:50:16 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from linuxtv.org (140-211-166-241-openstack.osuosl.org [140.211.166.241])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A85A86649
	for <stable@vger.kernel.org>; Thu,  1 Feb 2024 12:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.241
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706791816; cv=none; b=M5VXk6J7CXAAwkpUFCKOlAQErGi72jMM9RsgtOnn4584xIyyHmKhLUXySLXpl3KmCaBZOItw2ZKOprvvz5/WkMhEhCFW18uDWo7bbqOBwg3WQxtV1wZ8uKi8kehheZj2sVuHJQ9c47NKFIBmUAbm9JUzmo6lKDw11kGnaqrnRn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706791816; c=relaxed/simple;
	bh=cU7MWCa30CwJuctZEOpq3UD73AIwiM2LPEj+ohjRW8w=;
	h=From:Date:Subject:To:Cc:Message-Id; b=aSkb9tmI+eVQTzZJSX3yP2pRw7RQhXBEc0Zxfa2qrA/qVIHNAhHFtEY/4wBm1iFCpYhDtAiOxcHL+yEPhxlDB+hqnTUxRdiAFpZ19fZNvkYgqguARm1bs7J0RXMKRQNihBGYAkFFzcGY+OyIxcWxFNnGuTzsJY/V+hqfnyz0G4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=linuxtv.org; arc=none smtp.client-ip=140.211.166.241
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtv.org
Received: from mchehab by linuxtv.org with local (Exim 4.96)
	(envelope-from <mchehab@linuxtv.org>)
	id 1rVWWE-00078O-1i;
	Thu, 01 Feb 2024 12:50:14 +0000
From: Mauro Carvalho Chehab <mchehab@kernel.org>
Date: Thu, 01 Feb 2024 12:48:57 +0000
Subject: [git:media_stage/fixes] media: rc: bpf attach/detach requires write permission
To: linuxtv-commits@linuxtv.org
Cc: stable@vger.kernel.org, Sean Young <sean@mess.org>
Mail-followup-to: linux-media@vger.kernel.org
Forward-to: linux-media@vger.kernel.org
Reply-to: linux-media@vger.kernel.org
Message-Id: <E1rVWWE-00078O-1i@linuxtv.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

This is an automatic generated email to let you know that the following patch were queued:

Subject: media: rc: bpf attach/detach requires write permission
Author:  Sean Young <sean@mess.org>
Date:    Thu Apr 13 10:50:32 2023 +0200

Note that bpf attach/detach also requires CAP_NET_ADMIN.

Cc: stable@vger.kernel.org
Signed-off-by: Sean Young <sean@mess.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>

 drivers/media/rc/bpf-lirc.c     | 6 +++---
 drivers/media/rc/lirc_dev.c     | 5 ++++-
 drivers/media/rc/rc-core-priv.h | 2 +-
 3 files changed, 8 insertions(+), 5 deletions(-)

---

diff --git a/drivers/media/rc/bpf-lirc.c b/drivers/media/rc/bpf-lirc.c
index fe17c7f98e81..52d82cbe7685 100644
--- a/drivers/media/rc/bpf-lirc.c
+++ b/drivers/media/rc/bpf-lirc.c
@@ -253,7 +253,7 @@ int lirc_prog_attach(const union bpf_attr *attr, struct bpf_prog *prog)
 	if (attr->attach_flags)
 		return -EINVAL;
 
-	rcdev = rc_dev_get_from_fd(attr->target_fd);
+	rcdev = rc_dev_get_from_fd(attr->target_fd, true);
 	if (IS_ERR(rcdev))
 		return PTR_ERR(rcdev);
 
@@ -278,7 +278,7 @@ int lirc_prog_detach(const union bpf_attr *attr)
 	if (IS_ERR(prog))
 		return PTR_ERR(prog);
 
-	rcdev = rc_dev_get_from_fd(attr->target_fd);
+	rcdev = rc_dev_get_from_fd(attr->target_fd, true);
 	if (IS_ERR(rcdev)) {
 		bpf_prog_put(prog);
 		return PTR_ERR(rcdev);
@@ -303,7 +303,7 @@ int lirc_prog_query(const union bpf_attr *attr, union bpf_attr __user *uattr)
 	if (attr->query.query_flags)
 		return -EINVAL;
 
-	rcdev = rc_dev_get_from_fd(attr->query.target_fd);
+	rcdev = rc_dev_get_from_fd(attr->query.target_fd, false);
 	if (IS_ERR(rcdev))
 		return PTR_ERR(rcdev);
 
diff --git a/drivers/media/rc/lirc_dev.c b/drivers/media/rc/lirc_dev.c
index a537734832c5..caad59f76793 100644
--- a/drivers/media/rc/lirc_dev.c
+++ b/drivers/media/rc/lirc_dev.c
@@ -814,7 +814,7 @@ void __exit lirc_dev_exit(void)
 	unregister_chrdev_region(lirc_base_dev, RC_DEV_MAX);
 }
 
-struct rc_dev *rc_dev_get_from_fd(int fd)
+struct rc_dev *rc_dev_get_from_fd(int fd, bool write)
 {
 	struct fd f = fdget(fd);
 	struct lirc_fh *fh;
@@ -828,6 +828,9 @@ struct rc_dev *rc_dev_get_from_fd(int fd)
 		return ERR_PTR(-EINVAL);
 	}
 
+	if (write && !(f.file->f_mode & FMODE_WRITE))
+		return ERR_PTR(-EPERM);
+
 	fh = f.file->private_data;
 	dev = fh->rc;
 
diff --git a/drivers/media/rc/rc-core-priv.h b/drivers/media/rc/rc-core-priv.h
index ef1e95e1af7f..7df949fc65e2 100644
--- a/drivers/media/rc/rc-core-priv.h
+++ b/drivers/media/rc/rc-core-priv.h
@@ -325,7 +325,7 @@ void lirc_raw_event(struct rc_dev *dev, struct ir_raw_event ev);
 void lirc_scancode_event(struct rc_dev *dev, struct lirc_scancode *lsc);
 int lirc_register(struct rc_dev *dev);
 void lirc_unregister(struct rc_dev *dev);
-struct rc_dev *rc_dev_get_from_fd(int fd);
+struct rc_dev *rc_dev_get_from_fd(int fd, bool write);
 #else
 static inline int lirc_dev_init(void) { return 0; }
 static inline void lirc_dev_exit(void) {}

