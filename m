Return-Path: <stable+bounces-217798-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KAF7JHuOnGmdJQQAu9opvQ
	(envelope-from <stable+bounces-217798-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Feb 2026 18:29:31 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 12AA917AD54
	for <lists+stable@lfdr.de>; Mon, 23 Feb 2026 18:29:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3532B311FD35
	for <lists+stable@lfdr.de>; Mon, 23 Feb 2026 17:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A5CC330D26;
	Mon, 23 Feb 2026 17:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudlinux.com header.i=@cloudlinux.com header.b="N8qT1TaI"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE646330D38
	for <stable@vger.kernel.org>; Mon, 23 Feb 2026 17:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771867380; cv=none; b=I8UApwRcpQVaH8PPTrMmkU1yUxlQ0OoTOXL3AQ1qH1ip+szm+mCTVOvfLEZehcSVRA3zyizBLlygx2PnkeQzeNSZcavNgy09nSgRXEL5PeWudR7ZnQMjv1jc37iGeyebCTFVIXhOMHz/IAvFmdtvuP/72szeu+aUJgVafMTXf1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771867380; c=relaxed/simple;
	bh=U70+ueZQcya+AMyyGEdTupohSZkBEKgjmtTXFJMPNao=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pDQzOMnMeHFJ2RVxBizDzbvUu8tOSYhatkLP85oYz7N49hr9vwzuaSgzAUC7ESwsCFKCrnv5LI8trrRlwVQ/VUducJEdE5KWcUB462ltNJt1k2r7z7clGlUn2qxT2K40KTgpNT9pOtu2+OpY6/rKKYOBf0deMV0IEUpQ/DpDSrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cloudlinux.com; spf=pass smtp.mailfrom=cloudlinux.com; dkim=pass (2048-bit key) header.d=cloudlinux.com header.i=@cloudlinux.com header.b=N8qT1TaI; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cloudlinux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudlinux.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-c70942441ebso3013244a12.1
        for <stable@vger.kernel.org>; Mon, 23 Feb 2026 09:22:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudlinux.com; s=google; t=1771867378; x=1772472178; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P90vw/KWtem1WCNNgNpg1BwJkR7vXWZPVCTvb7IRCEA=;
        b=N8qT1TaI0ZdYlAiPqbnj3m11Wd1+ny71R5ijsoKD+xcUFABc3cm9/beDOG90kpe8iA
         jobVW5dH0kWzTYUstJUdQISgbt+vYKjvWEFwtfpjRLjszHroY1FtddUlfXpUfR0uLbFt
         QNqQ307QxOy32yxeczNTCWTj09ROYg9QCXPTn28wSPoJZ6aZLLUCemhvDgq2Ol0DnN4N
         dCqCWBtwtOHYsywxGt5quHLg8rEgYee3iXQTdecFZaEgDaiDQNLLc7J5Gvh3dRxqDWul
         5Vry9+fht297QH+BFCtQGmzCYYX5797/ejAWqMxAxDoYDvJEtCqiiY2HBVTwBtWBnuKD
         BJSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771867378; x=1772472178;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=P90vw/KWtem1WCNNgNpg1BwJkR7vXWZPVCTvb7IRCEA=;
        b=ox8/Q46/QmZrElGd7FlM2gJs247CnfodGIAYZm4llO9jxK2Gav23I+4p4x/sUe3IqS
         rcixBofuoWyV7e+egfi5L8WdslYWLQSw55EZMTcmHZyTV6bxVBND+34DVWDYwjN/ZvQA
         eCcAaLQ17zmC7pueUc0/EvY+AhAIFcinblI14J9tzXqHL47H6dlQbFMfkeRpRUMn2myx
         +PVzEOfxCFHYzZbWbAOQ4eUQ1FsbQqSB4Kx2KylZsspkI5w4wfEat+T1ZnLRTjUNsZo5
         Ymb9brrZidL/OvqWqgFuPsCBe+nHBweDQpgUzzDzCJ/31YaMRfm1dTE3ptzAimsnDlAK
         zA6Q==
X-Gm-Message-State: AOJu0YxIVb2b99h53abJpHE6PqSXOsTED8+q8P5y4KenY6ccxvHNDnM4
	m8Rx4XFwohpoxDx6yHL83rjVdONVVH/wbbL+fJRl51kYEEDheaRDGur5kxJ84wSDBRNJWfwaZYk
	XID4W
X-Gm-Gg: AZuq6aK+0D0YNDDe0kIZx6kbGM1ceMwu6f95avYvxTowmOj6qkzYCjJc32TyZx1ug6Y
	2+/RvJ4r3IHxigjv+urP5m7wtCU6FTcczh/StwVYWrBTF5ewD1sPHqyS7QO0EiAVxm6LCZka3vp
	l1YLK6w+pZZW4K2ZjtSMB964Cprac7ataeEymEi7XjE14e3Akjvs9u4PnFGmwncQUJn4hGIDf6W
	0i+FVGKhg81EV0tpMn+ql323aI1QGAysJS7T8yK+DPpUObi5Yu5CvgTdv8JjLPjFQdjN641S2zn
	Dan3v1ejyscIkFmk08p7jeZ+WP1ZHEUKs9/5cbTuC+t/J0pELCTTzv6bFuGQpMDxA0FSk5xHSs0
	W1PpFw5CeZ3lozR1lv20qVi6/AwUhr1USy8qYBNmTsfolh7GZe6+nrQU+PvyjUGTumQHJ7PKZY1
	9etp/ZhqWIhuDI4NOtcfXSPRnMrXjZKos=
X-Received: by 2002:a05:6a20:1595:b0:393:73e5:7404 with SMTP id adf61e73a8af0-39545f88f2bmr8621279637.52.1771867377615;
        Mon, 23 Feb 2026 09:22:57 -0800 (PST)
Received: from outpost.localdomain ([110.44.9.85])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c70b7269771sm7942918a12.30.2026.02.23.09.22.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 09:22:57 -0800 (PST)
From: Jaskaran Singh <jsingh@cloudlinux.com>
To: stable@vger.kernel.org,
	james.smart@broadcom.com,
	kbusch@kernel.org,
	axboe@fb.com,
	hch@lst.de,
	sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	gregkh@linuxfoundation.org,
	Jaskaran Singh <jsingh@cloudlinux.com>
Subject: [PATCH 5.10.y 1/2] Revert "nvme: nvme-fc: Ensure ->ioerr_work is cancelled in nvme_fc_delete_ctrl()"
Date: Mon, 23 Feb 2026 22:52:40 +0530
Message-Id: <20260223172241.291649-2-jsingh@cloudlinux.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260223172241.291649-1-jsingh@cloudlinux.com>
References: <20260223172241.291649-1-jsingh@cloudlinux.com>
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
	DMARC_POLICY_ALLOW(-0.50)[cloudlinux.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[cloudlinux.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[cloudlinux.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-217798-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jsingh@cloudlinux.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,cloudlinux.com:mid,cloudlinux.com:dkim,cloudlinux.com:email]
X-Rspamd-Queue-Id: 12AA917AD54
X-Rspamd-Action: no action

This reverts commit 3d78e8e01251da032a5f7cbc9728e4ab1a5a5464.

The backport of upstream commit 0a2c5495b6d1 was incorrectly applied.
The cancel_work_sync() call for ->ioerr_work was added to
nvme_fc_reset_ctrl_work() instead of nvme_fc_delete_ctrl().

Revert this commit so the correct fix can be applied.

Signed-off-by: Jaskaran Singh <jsingh@cloudlinux.com>
---
 drivers/nvme/host/fc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index db905c30fbc6..31a9ae0eb2a7 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -3259,6 +3259,7 @@ nvme_fc_delete_ctrl(struct nvme_ctrl *nctrl)
 {
 	struct nvme_fc_ctrl *ctrl = to_fc_ctrl(nctrl);
 
+	cancel_work_sync(&ctrl->ioerr_work);
 	cancel_delayed_work_sync(&ctrl->connect_work);
 	/*
 	 * kill the association on the link side.  this will block
@@ -3322,7 +3323,6 @@ nvme_fc_reset_ctrl_work(struct work_struct *work)
 
 	/* will block will waiting for io to terminate */
 	nvme_fc_delete_association(ctrl);
-	cancel_work_sync(&ctrl->ioerr_work);
 
 	if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_CONNECTING))
 		dev_err(ctrl->ctrl.device,
-- 
2.43.7


