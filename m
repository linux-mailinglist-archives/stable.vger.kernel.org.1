Return-Path: <stable+bounces-219797-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oEmLA7A1oGkqgwQAu9opvQ
	(envelope-from <stable+bounces-219797-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 12:59:44 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 59F9F1A57AC
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 12:59:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 64D84314BD51
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 11:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F5A437FF40;
	Thu, 26 Feb 2026 11:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="bLlY40Qq"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C3837BE68
	for <stable@vger.kernel.org>; Thu, 26 Feb 2026 11:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772106966; cv=none; b=uKqa/x0mppZobqKLtFdsNcaezjZ9uX0RW7vOcfJw6p/d5kckDMzGg3syc+g4sTHR065JEG+IY4WoGS0OPtbKbj7jQioSptCygyV5Ke368aUTp/fkuHbhMDcsxhTlm26b+SW4cUd5svTFKDkHxIlmpVsT73ODOsLyb+BGp7iREDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772106966; c=relaxed/simple;
	bh=DHLLkqkDnWvEZuqYb/4TzoA2PvbjZgAKakxtrxBFNoM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GtNNLnWk3fTAGlzEzLMHC2TH6id+lgPJRxRJ68bWYINTmayLM0XzPU52jn4Kxeiww92u8qNSeSL8cfHSJPvARuI6V2aBuSPPtiJosQk2m/SJUAWmWeE+mQNfzHzSi9GtVm1HtNrF60xHvKAXLlJTGL3z2vi5dGiR4O+N+FILkjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=bLlY40Qq; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c70ece855e2so680494a12.0
        for <stable@vger.kernel.org>; Thu, 26 Feb 2026 03:56:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1772106961; x=1772711761; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8hp9OyhudeTkze2mm5y1Lxwv/Mn5sOVBkvROnjUBeHw=;
        b=bLlY40Qqv6JBnq2Hu4L7iq/0dIwweJeia3VEf/Ui5i6rUB1nx7b6PC2ayXl2Srj4sm
         E5q1V5YiBKjvhJ80UrXRfuW6ESyiJKonYEiKOvgLszIRTOe9Ng1fbTJRqqpvuHNUA4VR
         qbuxuhAT647MEiCs9QZ3DVjbiszgZkTI9dnHcu8QUknqTKABPGPbxEtouyjvicH/zcDG
         yPlObjkbUqT2NwN99NWmrdBw6EP3qMmTffJtim8KiUlwvTFpvyczhHW038rQ0TN8uGtq
         u3SBfb9gunN98ct7zeQ/UoiKElFdy/q3ndnxyNbkNkI1vZ0X6991FZXWhibAzTL3D+Z6
         41Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772106961; x=1772711761;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8hp9OyhudeTkze2mm5y1Lxwv/Mn5sOVBkvROnjUBeHw=;
        b=VlEgb7QGOEjyu78oKsYQJTWIL0USxWel3t1nCqrSfSC8DREb4Flum2/dW3hKLhnaaR
         eb5RjboZ/Q7/zOdPbn9WhERhCgbKWiN0iiJMOLhrzRmEldJaBzWKRomX2XV5kWsRH4/q
         4EAOu/MUCrsfMHSAoANQRE87Rv0r+ppkqZk1rWfMqnM0XXFD4OpHAfC3YmzEJ+OJUHtz
         xu4TujD43Fcd+nFFU6UKiw32p0TTlsTvWc+P+JMJ3qb7rNaIAuW/0ubGsmQYzd/CoiJI
         FDwnyBYaQRDrzjmDrr55BcJHIdjA2PmbQ2lEWBoMrbwOZNCafzIw43Pv3tQFPrpG58m8
         tqwQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7mJejBEHtqVRZXyd4xMK54BuzzG03FG0B8c80CMIerFLeDQofqV3EzcgeA4kExdhVWhs2Dnk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzi2JV8wozsA7EvqcV3S1eEWQMfwf0T4twudzuOqHv9sIJm3lMP
	OxuSyMcxS0KktSmkMhU/JEgIYiMaYtnI8QLUBdg6rmpfOr3rf+dKxIh7ODmoukBnvWo=
X-Gm-Gg: ATEYQzx+5n1So5Qnq9WqgEXYvSX3UXmh9Lr0x/Uu+hzUGPrOtRLUKzowQ6Cc1xRpZFu
	QJazSld7fpt1gtPoxra7qFwqALBBSgI3vfkJKl/g5rNBrMaVL0Pz1qmZ6RX205sZRD5/ahLBuHR
	0h2Q2Gg7eNQ+uoQltTLmHQomI5GSuQ85TmZhrJi2GYNkODLfX4JyaLgHVpoMgpS/q0iJ9dJGJ77
	bxGNBa2ER46Hgk/18k460O2w9oeX5M9aBkSTWBKBDY2WmwMCEOcZw3eM5IM0TXqv3Oekh6QPGKI
	+3Py0fKGVT1zPdazWwDww4tEBeQKrLIeDTjRdKW02ghraozeQVrC8kdI4PmytwPIDmwslDT2uKH
	ktLA6Z4VawJYso89hFm2BFO4HyA3VDUzjGJ8Luckz/RXwvU+HJD5V5IcIbh3adpS5d1LJpnmtb/
	So3dAHzWhgyYpMJQ59a5DiimBuGJV19S5nU2n8EvBOK7fNWT4rF+49IYkh3A5+QwmqjFQ=
X-Received: by 2002:a17:90b:3f4e:b0:356:22ef:57a6 with SMTP id 98e67ed59e1d1-3593870f204mr2186856a91.15.1772106961486;
        Thu, 26 Feb 2026 03:56:01 -0800 (PST)
Received: from tianci-mac.bytedance.net ([61.213.176.5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-359130712bcsm2390815a91.7.2026.02.26.03.55.59
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 26 Feb 2026 03:56:01 -0800 (PST)
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
Subject: [PATCH v4 2/2] vduse: Fix race in vduse_dev_msg_sync and vduse_dev_read_iter
Date: Thu, 26 Feb 2026 19:55:50 +0800
Message-ID: <20260226115550.1814-3-zhangtianci.1997@bytedance.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260226115550.1814-1-zhangtianci.1997@bytedance.com>
References: <20260226115550.1814-1-zhangtianci.1997@bytedance.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[bytedance.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[bytedance.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-219797-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhangtianci.1997@bytedance.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bytedance.com:mid,bytedance.com:dkim,bytedance.com:email]
X-Rspamd-Queue-Id: 59F9F1A57AC
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
 drivers/vdpa/vdpa_user/vduse_dev.c | 37 ++++++++++++++++++++++--------
 1 file changed, 27 insertions(+), 10 deletions(-)

diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index b37f18a0ce6fd..1ca1811f7594a 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -331,6 +331,7 @@ static ssize_t vduse_dev_read_iter(struct kiocb *iocb, struct iov_iter *to)
 	struct file *file = iocb->ki_filp;
 	struct vduse_dev *dev = file->private_data;
 	struct vduse_dev_msg *msg;
+	struct vduse_dev_request req;
 	int size = sizeof(struct vduse_dev_request);
 	ssize_t ret;
 
@@ -342,12 +343,11 @@ static ssize_t vduse_dev_read_iter(struct kiocb *iocb, struct iov_iter *to)
 		msg = vduse_dequeue_msg(&dev->send_list);
 		if (msg)
 			break;
+		spin_unlock(&dev->msg_lock);
 
-		ret = -EAGAIN;
 		if (file->f_flags & O_NONBLOCK)
-			goto unlock;
+			return -EAGAIN;
 
-		spin_unlock(&dev->msg_lock);
 		ret = wait_event_interruptible_exclusive(dev->waitq,
 					!list_empty(&dev->send_list));
 		if (ret)
@@ -355,17 +355,34 @@ static ssize_t vduse_dev_read_iter(struct kiocb *iocb, struct iov_iter *to)
 
 		spin_lock(&dev->msg_lock);
 	}
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
+		/*
+		 * Roll back: move msg back to send_list if still pending.
+		 *
+		 * NOTE:
+		 * vduse_find_msg() must use req.request_id instead of `msg`.
+		 * A malicious userspace may reply to this request, and wake up
+		 * the caller, after which `msg` will have already been freed.
+		 * And here vduse_find_msg() will return NULL then do nothing.
+		 */
+		spin_lock(&dev->msg_lock);
+		msg = vduse_find_msg(&dev->recv_list, req.request_id);
+		if (msg)
+			vduse_enqueue_msg_head(&dev->send_list, msg);
+		spin_unlock(&dev->msg_lock);
 		ret = -EFAULT;
-		vduse_enqueue_msg_head(&dev->send_list, msg);
-		goto unlock;
 	}
-	vduse_enqueue_msg(&dev->recv_list, msg);
-unlock:
-	spin_unlock(&dev->msg_lock);
 
 	return ret;
 }
-- 
2.39.5


