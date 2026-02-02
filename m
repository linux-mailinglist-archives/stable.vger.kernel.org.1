Return-Path: <stable+bounces-213017-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SG/nH6IWgGlp2gIAu9opvQ
	(envelope-from <stable+bounces-213017-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 02 Feb 2026 04:14:42 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 17797C7FE2
	for <lists+stable@lfdr.de>; Mon, 02 Feb 2026 04:14:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E703D300FEF5
	for <lists+stable@lfdr.de>; Mon,  2 Feb 2026 03:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B248F226CF7;
	Mon,  2 Feb 2026 03:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="gu90QR33"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E18B421773F
	for <stable@vger.kernel.org>; Mon,  2 Feb 2026 03:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770001981; cv=none; b=OsG3QlrUOeIn8rvoQyssrYvjn4ZpcR9+CDGrPIACguFTsbVsJxMllm+SMQLZesaDA72fPk1quZ+kwgwRybCXnrbjYk8rfmnjtUyw9vN/5tlI+s0TkiPj6+6u26vhxdWsmIh5dh2BIfFWSzhGrPpzytRHLIXIkCaH4Hwt4g3glss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770001981; c=relaxed/simple;
	bh=7yhISprganOOYxh69Ev9h0O7lWNMFwfj4PHkG6GLE90=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LA/e1mjz3Lh3mqwnjS1F39jQa3ndH/ukmZZlcX8LeIyL8ofM2ZZ5iQDrx+5gLY7QVEfRQOtepZft+NijGELsdEWC+SUAsbnOgshZZZXldiy/HK/qYaw54AMrAmvPIdvCUCfutnC5F9+fHVDu4xoToXE3ZVTV09JKfzW7QeI+DrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=gu90QR33; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2a91215c158so2712395ad.0
        for <stable@vger.kernel.org>; Sun, 01 Feb 2026 19:12:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1770001978; x=1770606778; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WmjllnZw+5iXRdcSzwZdOKzRNkr16JL8ICqTiH9EaYg=;
        b=gu90QR33m99cVjtP00mOl9I97DGmLN7kJ4ZgSdTavgiPv0fbD7rOz5qOsYzMxQXBWS
         uNnEICUAGnJ/GZ3HyTtWgoVlZ+FcGikc0xgjO4nC5jeFpny52OvR9pML5X/EgWSW0Z3w
         2womIXO+jB8jSdw+BcvBX/7fZlyYshZHeFUfgnZQQHUkT+x4hfnq0hPosAUAbtaNa95n
         w99SwYzHBrEa61boQu3M7n6dDZbPXpDZkdtmuLOTb6gaQa9xfjTFC7qHkc7dYl6gT+fN
         WBysgIHvH/n/nadOtwOhidLuLunyVHDCABok247gxv0GMSgbkX+JIXveclKMFJ6Yls9K
         kt0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770001978; x=1770606778;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WmjllnZw+5iXRdcSzwZdOKzRNkr16JL8ICqTiH9EaYg=;
        b=GqwR75SpCSCGjLE/nLI8RVgEZYlEwf+uhHKmMua+p96kz6CJYNBSN+s+qA9Dr1ZIWZ
         LdYNOj1XquG3y7r1jP3M2UTiLiW6ewJAHxCdrS/9J+QAs+FGc+cWsd0xWlZHVkAnKtdW
         nZ2vi1A8F2DXXoOJ90emISsUXcb5cF28wenBMdTGzBCamAnK8Z11kIhYEUoeTo7+12tU
         n6vD0VYQIsoepO042vpR15lPfoC1KXALUHYSy3ep4u8pdqqYvtFh5oPR53BR3juODyHj
         tyDJpvjq7nnyu7cx0UYKnPTmDEyT7Jlx7vBm2TiL0Jo968xuwLjWFwLoVdz8SDDKB/tA
         067g==
X-Forwarded-Encrypted: i=1; AJvYcCXiAPczDfRgbIu4r/eY9Pgcll+OX0In6uM/2TDehFwQURIrbMXlwzU5Jci6fHKYN2xWsmhVLas=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvwKPTr7wM4aiJSL65heMKfTWayhlYLmLA3akPavAMnbB2XaFt
	WfhrhZ42rPXxSZXIiCwi/GF63GHzviEF+bTGpIiCYLie0sasBZQwx8vmGBFAMuq5Ydw=
X-Gm-Gg: AZuq6aLAv2qKtn3TNFGglF55j1Jc8wUO70h2/2XS8qQHdYDkfhjTSQmxqGMbudMEK6a
	r1650TEKOGCDvOgXXNgO7gkGERBiDpfmqyEyypGPZi/bUltm1aQaH8eT2gbuWp2dq5ar6pBuLN1
	ngVaKcd+vQmQ13pvOXkLSkhJoGKlELr349u4HfLFViUrYmwz7CpzrZRrQEXcZ6u6tGHuE6jzywh
	z1Pj8yreon3iNwieCd61/4JJhvWoS6NqcB3at2zaCAcHqdxNxbwEigP9dtjGAdIoxrDpRuPNOhW
	Fas6xHG8zSGEC2GWkD2OJZsiMVyOjkA05A8TR37ylKN4h1WwloxPTKwSNo8IeEveYbYdGDv+ssy
	s5gZD7Vu6OJq4cg2s33iesalPnxTaKcoMgfx7UyWc/KZ9zgRFMs8JN/zoz8le92A6hOuBkaz9fX
	UMs3BRKV/zNgwn/uJ2JBXr39JZlaKlNZAjc/i6rlw4NvZ2S7WaYByx3572hQ==
X-Received: by 2002:a17:903:190:b0:2a0:34ee:3725 with SMTP id d9443c01a7336-2a8d7ed32ecmr103955495ad.14.1770001978153;
        Sun, 01 Feb 2026 19:12:58 -0800 (PST)
Received: from tianci-mac.bytedance.net ([63.216.146.167])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a88b5d93cdsm127466295ad.70.2026.02.01.19.12.54
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 01 Feb 2026 19:12:57 -0800 (PST)
From: Zhang Tianci <zhangtianci.1997@bytedance.com>
To: mst@redhat.com,
	jasowang@redhat.com
Cc: xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	marco.crivellari@suse.com,
	anders.roxell@linaro.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Zhang Tianci <zhangtianci.1997@bytedance.com>,
	stable@vger.kernel.org,
	Xie Yongji <xieyongji@bytedance.com>
Subject: [PATCH v2] vduse: Fix race in vduse_dev_msg_sync and vduse_dev_read_iter
Date: Mon,  2 Feb 2026 11:12:12 +0800
Message-ID: <20260202031212.26871-1-zhangtianci.1997@bytedance.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[bytedance.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[bytedance.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[bytedance.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-213017-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhangtianci.1997@bytedance.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lkml.org:url,bytedance.com:email,bytedance.com:dkim,bytedance.com:mid]
X-Rspamd-Queue-Id: 17797C7FE2
X-Rspamd-Action: no action

There is one race case in vduse_dev_msg_sync and vduse_dev_read_iter:

vduse_dev_read_iter():
    lock(msg_lock);
    dequeue_msg(send_list);
    unlock(msg_lock);
vduse_dev_msg_sync():
    wait_timeout() finish
    lock(msg_lock);
    check msg->complete is false
        list_del(msg);   <- double list_del() crash!

To fix this case, we shall ensure vduse_msg is on send_list or recv_list
outside the msg_lock critical section.

Fixes: c8a6153b6c59 ("vduse: Introduce VDUSE - vDPA Device in Userspace")
Cc: stable@vger.kernel.org
Signed-off-by: Zhang Tianci <zhangtianci.1997@bytedance.com>
Reviewed-by: Xie Yongji <xieyongji@bytedance.com>
---
v2:
 - Rewrite commit message.                        [Michael]
 - Add Fixes tag and cc stable email list.        [Eugenio]
 - Rewrite one comment.                           [Michael]

v1: https://lkml.org/lkml/2026/1/30/323

 drivers/vdpa/vdpa_user/vduse_dev.c | 30 ++++++++++++++++++++++--------
 1 file changed, 22 insertions(+), 8 deletions(-)

diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index ae357d014564c..a70d0580d54e8 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -325,6 +325,7 @@ static ssize_t vduse_dev_read_iter(struct kiocb *iocb, struct iov_iter *to)
 	struct file *file = iocb->ki_filp;
 	struct vduse_dev *dev = file->private_data;
 	struct vduse_dev_msg *msg;
+	struct vduse_dev_request req;
 	int size = sizeof(struct vduse_dev_request);
 	ssize_t ret;
 
@@ -339,7 +340,7 @@ static ssize_t vduse_dev_read_iter(struct kiocb *iocb, struct iov_iter *to)
 
 		ret = -EAGAIN;
 		if (file->f_flags & O_NONBLOCK)
-			goto unlock;
+			break;
 
 		spin_unlock(&dev->msg_lock);
 		ret = wait_event_interruptible_exclusive(dev->waitq,
@@ -349,17 +350,30 @@ static ssize_t vduse_dev_read_iter(struct kiocb *iocb, struct iov_iter *to)
 
 		spin_lock(&dev->msg_lock);
 	}
+	if (!msg) {
+		spin_unlock(&dev->msg_lock);
+		return ret;
+	}
+
+	memcpy(&req, &msg->req, sizeof(req));
+	/*
+	 * We must ensure vduse_msg is on send_list or recv_list before unlock
+	 * dev->msg_lock. Because vduse_dev_msg_sync() may be timeout when we
+	 * copy data to userspace, and will call list_del() for this msg.
+	 */
+	vduse_enqueue_msg(&dev->recv_list, msg);
 	spin_unlock(&dev->msg_lock);
-	ret = copy_to_iter(&msg->req, size, to);
-	spin_lock(&dev->msg_lock);
+
+	ret = copy_to_iter(&req, size, to);
 	if (ret != size) {
+		spin_lock(&dev->msg_lock);
+		/* Roll back: move msg back to send_list if still pending. */
+		msg = vduse_find_msg(&dev->recv_list, req.request_id);
+		if (msg)
+			vduse_enqueue_msg(&dev->send_list, msg);
+		spin_unlock(&dev->msg_lock);
 		ret = -EFAULT;
-		vduse_enqueue_msg(&dev->send_list, msg);
-		goto unlock;
 	}
-	vduse_enqueue_msg(&dev->recv_list, msg);
-unlock:
-	spin_unlock(&dev->msg_lock);
 
 	return ret;
 }
-- 
2.39.5


