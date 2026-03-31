Return-Path: <stable+bounces-232563-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YDgnNhsXzGkeOQYAu9opvQ
	(envelope-from <stable+bounces-232563-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 20:48:59 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 507D337031B
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 20:48:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2267A301C13F
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 18:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0F013A16A3;
	Tue, 31 Mar 2026 18:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LHlQ5yIC"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DEA8376BEF
	for <stable@vger.kernel.org>; Tue, 31 Mar 2026 18:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774982935; cv=none; b=sEtOp60gSaWxnRC3Gnzs10v0eq0ztC8hfc6mqznWSkqEWYmY9QK/Wo+Rk4xuM0PjIV/lYd2oNJTEowXdxdrSyC45lJsutEyC5q7XtRAKs5/wQw8gqqnQ/If0BXRU2qJ6xp0zE6XhGvGFFtifoLSy+SRHupJJNtOd4GbnFVkLiZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774982935; c=relaxed/simple;
	bh=5JbE6jefY687MMjL40pD4pcEGJW9XrtiRSZzHPD8v9c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BQ9ugrqTPhqU5Z9pIj/2Saj2BR0cD0UtEGKQRPxPQeyDGvyWfMu0H+TadcVoNEBCve4UU3TfjFO9V8bUU0ufttzGNFMk2iFnuHCZO/sRNhgfnszvcKt5k52t1Hd2hU4x1xd/1Os+CzgOG2MfJ3DzwNKo0wF+dVAzGAxyt7o7MFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LHlQ5yIC; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-48558d6ef83so61005975e9.3
        for <stable@vger.kernel.org>; Tue, 31 Mar 2026 11:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774982933; x=1775587733; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=k3jBPBKWUkAe3aZwB1cI7MtT5GZiZL2spoEeWYwX3yI=;
        b=LHlQ5yICzNykXmUSYY1XGRAjeAE1rf5qjEN80UDvvZ4Y1Ty6dqyLdcuI/7y2y+d39q
         lK0oV34oXS48rt3dP9OlzSIWL6hSZbQXQ3Z4JXVsWAZWRcmvzXw5fJpqsOAShMoKrc6z
         3l8PBYUsYEAMAqs+9CwVlJpCJxq4TeYL5fBvjOqEuAhkSTmhaZTYi53+wj6ePQrjt1XN
         DaY50KY5cA1B6jlLHlPTBVTwU1Sw/o9zaHt1P2OeAKNCJqXQHyFQtXPvzYUWeZXh3y7L
         ubkyXBFdDciQxZ5eRv/JukN+u95bHq6qg8+Qj/weeiCwTUD0pJ8ViOkN3Gx4pswT4fjB
         IXiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774982933; x=1775587733;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k3jBPBKWUkAe3aZwB1cI7MtT5GZiZL2spoEeWYwX3yI=;
        b=VLmJcai+cxOxuW0sH4nmCco8pLqGdKhwC45k4yM5qQE8w5HliT7iimECJetB1oM0Tb
         5/GL+anxIfMeELu6Y+VuUp7A22rzV9oa9UJdXLO9l5UebP3BfhB9ERydgOmURVuawwu3
         XdpTWUqCj7E/zEWBpdf6rvo1nHe2noGt8orHyj0HHs0QaGI8Vc/kxlE36o1QNiXNPmIW
         beO4BENvpt1JNHDfD0V2XI+uX3tf4y48i/VpQ5X7bO+ACFNbQrZltDopUuVoypTWwCvJ
         g4su8Mt5UyBqpAqoS+UVWPly1LbLLb5AfayMlnX7SrI0e1vfk7dN/RjyOWRHAOWu9B12
         np6Q==
X-Forwarded-Encrypted: i=1; AJvYcCVLUnSApZ5iHrwuF/CoGgzD6Is1arPh7WDToiVgh8qkgocrtvBJddK7kI0pBDOwtVqEL4jCgLc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIT/0iaHEdrmXfa/Q1YWMCSo5BKKzpYSyxF6Gh2ZaBNQOjO37X
	phyMjjvEYuEy+f5574mgA6rkkyeLAkR0ZCk2BhOkKP2QwBiwyeqp9Rwn
X-Gm-Gg: ATEYQzzo1V32X81khVRoD9ROobwczdyf4EgN3IJKdbtx2IJmP0yl0gg4tR26TnRGjmI
	3pOvruJAodcp9Mp+HW92siTfM1RsGQ/FMklN/xNd5oFNDmHErlUIjSfoB92u7BRbLhXjIc8507t
	vCfuuaTWroNvtEh6qzB7gr4Wml9L3ZDnZ+mMVxTn5gfg7qzqBWWBtDHSYegabvSD4hznXNvqVCa
	P0Wu00rhhBk2tY8t+761oUB4Ani/kk/Gm50FcwMRT/IkpgDpDfVfOD+by16Ap1kflllss3ZpBA5
	cbOhsT6kXiy5vSeZzl95vklTqg90AHIzvBnGyPdOChU+ID78LXI1rvPwJYivIGKNe212EipJRzE
	3VAzOucJyGkUXVLsCUtcGK/xMiNPave22NJJGOr9e6HHwrQv+Z2obYDyraxYmAqmILIy7Bfw5tU
	hC98BRf58Rk3FM88AXv/DX54uD27D0peQKqeUCLTJxcWmiso4D9dRt348uXFrmIkC9Q4EsP59/g
	HdjM14Q/vwiqJ+ZxECgYVCmvXmfWktLCAJasF/9NW8VfTp2cTzktTJytqgQ7RGPfDl5wJcbBX7L
	NzgooT0Mk2jniF0=
X-Received: by 2002:a05:600c:8819:b0:486:fa9c:185 with SMTP id 5b1f17b1804b1-488835e311bmr8274885e9.31.1774982932467;
        Tue, 31 Mar 2026 11:48:52 -0700 (PDT)
Received: from toolbox.fritz.box (p200300c717487f00c8918a114afa5d8c.dip0.t-ipconnect.de. [2003:c7:1748:7f00:c891:8a11:4afa:5d8c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887a633f23sm23935075e9.0.2026.03.31.11.48.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 11:48:51 -0700 (PDT)
From: Michael Zimmermann <sigmaepsilon92@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Michael Zimmermann <sigmaepsilon92@gmail.com>
Subject: [PATCH] usb: gadget: f_hid: move list and spinlock inits from bind to alloc
Date: Tue, 31 Mar 2026 20:48:44 +0200
Message-ID: <20260331184844.2388761-1-sigmaepsilon92@gmail.com>
X-Mailer: git-send-email 2.53.0
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
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-232563-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sigmaepsilon92@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 507D337031B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

There was an issue when you did the following:
- setup and bind an hid gadget
- open /dev/hidg0
- use the resulting fd in EPOLL_CTL_ADD
- unbind the UDC
- bind the UDC
- use the fd in EPOLL_CTL_DEL

When CONFIG_DEBUG_LIST was enabled, a list_del corruption was reported
within remove_wait_queue (via ep_remove_wait_queue). After some
debugging I found out that the queues, which f_hid registers via
poll_wait were the problem. These were initialized using
init_waitqueue_head inside hidg_bind. So effectively, the bind function
re-initialized the queues while there were still items in them.

The solution is to move the initialization from hidg_bind to hidg_alloc
to extend their lifetimes to the lifetime of the function instance.

Additionally, I found many other possibly problematic init calls in the
bind function, which I moved as well.

Signed-off-by: Michael Zimmermann <sigmaepsilon92@gmail.com>
---
 drivers/usb/gadget/function/f_hid.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/usb/gadget/function/f_hid.c b/drivers/usb/gadget/function/f_hid.c
index 8812ebf33d14b..e5ccaec7750cd 100644
--- a/drivers/usb/gadget/function/f_hid.c
+++ b/drivers/usb/gadget/function/f_hid.c
@@ -1262,17 +1262,8 @@ static int hidg_bind(struct usb_configuration *c, struct usb_function *f)
 	if (status)
 		goto fail;
 
-	spin_lock_init(&hidg->write_spinlock);
 	hidg->write_pending = 1;
 	hidg->req = NULL;
-	spin_lock_init(&hidg->read_spinlock);
-	spin_lock_init(&hidg->get_report_spinlock);
-	init_waitqueue_head(&hidg->write_queue);
-	init_waitqueue_head(&hidg->read_queue);
-	init_waitqueue_head(&hidg->get_queue);
-	init_waitqueue_head(&hidg->get_id_queue);
-	INIT_LIST_HEAD(&hidg->completed_out_req);
-	INIT_LIST_HEAD(&hidg->report_list);
 
 	INIT_WORK(&hidg->work, get_report_workqueue_handler);
 	hidg->workqueue = alloc_workqueue("report_work",
@@ -1608,6 +1599,16 @@ static struct usb_function *hidg_alloc(struct usb_function_instance *fi)
 
 	mutex_lock(&opts->lock);
 
+	spin_lock_init(&hidg->write_spinlock);
+	spin_lock_init(&hidg->read_spinlock);
+	spin_lock_init(&hidg->get_report_spinlock);
+	init_waitqueue_head(&hidg->write_queue);
+	init_waitqueue_head(&hidg->read_queue);
+	init_waitqueue_head(&hidg->get_queue);
+	init_waitqueue_head(&hidg->get_id_queue);
+	INIT_LIST_HEAD(&hidg->completed_out_req);
+	INIT_LIST_HEAD(&hidg->report_list);
+
 	device_initialize(&hidg->dev);
 	hidg->dev.release = hidg_release;
 	hidg->dev.class = &hidg_class;
-- 
2.53.0


