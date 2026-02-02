Return-Path: <stable+bounces-213027-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ODmgDOJRgGla6QIAu9opvQ
	(envelope-from <stable+bounces-213027-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 02 Feb 2026 08:27:30 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D6E1C9257
	for <lists+stable@lfdr.de>; Mon, 02 Feb 2026 08:27:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8A636300AC03
	for <lists+stable@lfdr.de>; Mon,  2 Feb 2026 07:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20AE928B4FD;
	Mon,  2 Feb 2026 07:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="AvNoSQf+"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D75928F948
	for <stable@vger.kernel.org>; Mon,  2 Feb 2026 07:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770017241; cv=none; b=sZIthJKjLhneOG0UOJoR1X1D50j2lqPzeAiiEOjSucOAaM4kkjOjatgKiuxyiBthlFZZYFnEzOhfuWRqvO8HINBo1TlMUGAf+A/NxOJyAM1ozS3EnLoU1+RUd0UTNWfZGFzspOQhCDmDN7+hA2vQqKk8CaGOd4bKmNcknigWDW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770017241; c=relaxed/simple;
	bh=pl6VwA/VUV/Zau9QfAtae90e95h4JJbv1lONMJ4/9Qc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qUqW7MhC3lukB0NnBlTgnuQ+GEoewOcMRyuv1xYz2Mu7mrkHfVCIzEwQDUH+HB/32azzUN41xZ/I3dKfQHv+O6vVVjVwSDP3HZmblyptdfAfZN4qSMl9DwG40I+DP06roEW9N9vXGAIk/VHLUro36sujYZq8V325TdG8uWJfV9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=AvNoSQf+; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2a0c09bb78cso34118245ad.0
        for <stable@vger.kernel.org>; Sun, 01 Feb 2026 23:27:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1770017240; x=1770622040; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kmq6UkeFlJ38GZ9Njho8FK6yJ51WYaa7aCjJvi0pQSw=;
        b=AvNoSQf+fPJZz07wGOD7dPOF75ammDi1R3cyBe5LFFOYkzihUWL/KyNTZ0ZjhKmo00
         xGDIOZyXiAdKRE+l4nJWQBYuTNHeKRwkGDFffGe9bek5uJb8/LwXw06DOruUHs4kud/I
         TprtgVp/i0HumK+VG4RkplVlTQhnz+9c6LWXFRnL3Z9KrjrNSHkYJapjzLMHFDeYuaUb
         5fjMCjIL+ze+mo5eGFtFuZy/Le9m/Z9XiiDDd0Y0sYAvVDFtnjWiGtbLcksY+/japdyG
         McluTqOzFeYlxlN3JssHkltrgFprqX7jW3H3j7P0Tmx5VVPyc6Aw9d+IX4aUUnLDxyUF
         3nuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770017240; x=1770622040;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Kmq6UkeFlJ38GZ9Njho8FK6yJ51WYaa7aCjJvi0pQSw=;
        b=eK7T4Mpphn1l/0dO/a1e+aj5d8VFmd8pEw9iw3uBwY6jD61V1fZj+dFaiKMKPvVpy0
         crdBbTXAcCt12yZA9A0VFCM7YBfgV7VvyFLlA8ttbeupYB/Av3E6hpSkOWslvNAAtikJ
         dn47M45E+EU0Bi/rEC26Vz+fe7cJ17iwG7d0UzxxzvGfui2dzm/OTznqKc7uAQ0AxTJN
         TLFSH2DLbgmkOptijk3MWR++aFPYVnNhdlb0/AxvSqQjxic2OMbgIwUc8XSsthpllN+u
         nB9edWeEzIuMcJCORTCvkAXOzRnqsUiyxj8rT2ZCSoILTJBuSbkrJOEXj1koiJ+laIDG
         ySJA==
X-Forwarded-Encrypted: i=1; AJvYcCV+yWXRjMzcVBd1yAWd6CK4fUTq7hSoo8SY3vIYPCvX1M0JlA8U4BxQFSmpX/ry2TKJw8aZJ48=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxkBnJ45M+vWHdmMR3BmSKMqkYX54XZd/zqKyKmCNJ8jt5OYIu
	7cV8hcnti+/h26LJkRvuM+Y3tpDk+BHd6ux8F9U6hD1tW5prmotmtJ2mbNy0QRdnptU=
X-Gm-Gg: AZuq6aL4eoC3HHFAXIYAhf9z8anymneufZBd5W5S15Sbk12Zc/uk/Xa8el8PspSrZN2
	p7E+691fAO/sSXosYJBlDRSgDXb4+U/6bUbJyJ9fDlO+pRIZ/XnIzC+OUcncbVPmEpxRy7URb3/
	Lr/5RQBtzcQjMOx9l4omZh5Fp+WLO66wIe1i6EdX/IaQjYfufpKjsyhwaVChJNnfpSElR/B3jrO
	suntzW/uW9OB6xk4u+sIdItO/lu8C4tbBbn1UFC5hVG/eV3fS3ERXpd/OvfsrSVLRXN5qT1t9yQ
	fdelm9v2lkpIBy7FvmeKRC1ZAiKBs+XJo7pX7cy2Q6bfHwXFSVys31sGRjzeLoTtqJkveXtNqJG
	lHvfvM2aV0dBoQWgC/Ve0xgJzVJetk8ICn0NiIfayswYj3BmQzR/EGANeeIMOoqprQAKdXU2mCi
	5lFLnxm07h6+oGeg3a2hJ+zJqjKYoTjayITY40LwY05xlDtM8CbjRGdBVgL5/ueJurrb0=
X-Received: by 2002:a17:903:380b:b0:29f:1b1f:784 with SMTP id d9443c01a7336-2a8bd3ebfeemr152850155ad.4.1770017239838;
        Sun, 01 Feb 2026 23:27:19 -0800 (PST)
Received: from tianci-mac.bytedance.net ([61.213.176.14])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a88b5d88f0sm145352365ad.67.2026.02.01.23.27.17
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 01 Feb 2026 23:27:19 -0800 (PST)
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
Subject: [PATCH v3 2/2] vduse: Fix race in vduse_dev_msg_sync and vduse_dev_read_iter
Date: Mon,  2 Feb 2026 15:26:55 +0800
Message-ID: <20260202072655.95143-3-zhangtianci.1997@bytedance.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260202072655.95143-1-zhangtianci.1997@bytedance.com>
References: <20260202072655.95143-1-zhangtianci.1997@bytedance.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[bytedance.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[bytedance.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-213027-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhangtianci.1997@bytedance.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bytedance.com:email,bytedance.com:dkim,bytedance.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9D6E1C9257
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
 drivers/vdpa/vdpa_user/vduse_dev.c | 30 ++++++++++++++++++++++--------
 1 file changed, 22 insertions(+), 8 deletions(-)

diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index b37f18a0ce6fd..1e274688bba32 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -331,6 +331,7 @@ static ssize_t vduse_dev_read_iter(struct kiocb *iocb, struct iov_iter *to)
 	struct file *file = iocb->ki_filp;
 	struct vduse_dev *dev = file->private_data;
 	struct vduse_dev_msg *msg;
+	struct vduse_dev_request req;
 	int size = sizeof(struct vduse_dev_request);
 	ssize_t ret;
 
@@ -345,7 +346,7 @@ static ssize_t vduse_dev_read_iter(struct kiocb *iocb, struct iov_iter *to)
 
 		ret = -EAGAIN;
 		if (file->f_flags & O_NONBLOCK)
-			goto unlock;
+			break;
 
 		spin_unlock(&dev->msg_lock);
 		ret = wait_event_interruptible_exclusive(dev->waitq,
@@ -355,17 +356,30 @@ static ssize_t vduse_dev_read_iter(struct kiocb *iocb, struct iov_iter *to)
 
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


