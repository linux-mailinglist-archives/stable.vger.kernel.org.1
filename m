Return-Path: <stable+bounces-223477-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4DnbMpQvrmlrAQIAu9opvQ
	(envelope-from <stable+bounces-223477-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 03:25:24 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CF04B2333D0
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 03:25:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 25E24301FE76
	for <lists+stable@lfdr.de>; Mon,  9 Mar 2026 02:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B55AA27587D;
	Mon,  9 Mar 2026 02:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="JJEv5nsB"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE1E23536B;
	Mon,  9 Mar 2026 02:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773022974; cv=none; b=Ej2Fo6vQycmGQkAT//De+UHCi7kXj8T2ckueBU+NP2nucx9gn9lzi06lXV5b9kyxHAiv2kfwC/iQY+5d33pRTzISF1ixoT6rghC86+kvmik3DrYby5WUVE248y7+g9bBpjU2EpTsMrnJ5eI7A5ZpMez5LF27JPHFZbmo4Z5T9aY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773022974; c=relaxed/simple;
	bh=nuVeqd0X4gQSOXqquM0fYnDUudF8p8CeGHmP1TrOe1I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BtO5ByNXB/I9enYcYvRWB82D01lP9cLA8MdfgfVPCmVRSDpTRXvAP7+CdwJbRmLtNatMhQoFwhdJn/q5RqfL9Io06fIdlYpd1A+IoJnkjkC/Au9QG9h6/0xdbqpowpPJLzK8zhVyOM2LAoJlmQn3mGdBkBrVdjKSQcttScH6KII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=JJEv5nsB; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Ti
	SMxkVGdwISC2XAVkS89dpe+kuedJ/12+uHTMAKZHI=; b=JJEv5nsBjIeg9aIDXP
	SqLOeMQoiFVvGsO+2GliiLj8t13zWQdIkaeuagI0zvaE6HfrrRhiy6CYZVeSRcha
	6x6VkCxHnNTTsNXPiuXLtqdw5mXSDeNag+lbH2hY+Zx37wzmK+z3DsRPu4nPw5BX
	ncHK/z1VCBlMPJCi0AQV5zqFQ=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wDXV5TmLq5pRMZoPg--.11725S4;
	Mon, 09 Mar 2026 10:22:37 +0800 (CST)
From: Chenyuan Mi <chenyuan_mi@163.com>
To: alexander.deucher@amd.com,
	christian.koenig@amd.com
Cc: Arunpravin.PaneerSelvam@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 2/2] drm/amdgpu: protect queue access in signal IOCTL
Date: Mon,  9 Mar 2026 10:22:29 +0800
Message-ID: <20260309022229.63071-3-chenyuan_mi@163.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260309022229.63071-1-chenyuan_mi@163.com>
References: <20260309022229.63071-1-chenyuan_mi@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDXV5TmLq5pRMZoPg--.11725S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7AFWrWFW5Jw1UWF1kXr1kZrb_yoW5JFW3pr
	4rGry3Kr18ur4I9a47J3W7WFs7Ka1xXFWrKr4xA34aqw45A3s0vry7KrWDXF4xCrsFkFZF
	qry8ZrWFyFn0qw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jg-B_UUUUU=
X-CM-SenderInfo: xfkh055xdqszrl6rljoofrz/xtbC9Q3M32muLu0hAQAA3P
X-Rspamd-Queue-Id: CF04B2333D0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[amd.com,gmail.com,ffwll.ch,lists.freedesktop.org,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-223477-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chenyuan_mi@163.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[163.com:+];
	NEURAL_HAM(-0.00)[-0.982];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_FROM(0.00)[163.com];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

amdgpu_userq_signal_ioctl() retrieves the user queue via xa_load()
and then dereferences it in amdgpu_userq_fence_read_wptr(),
amdgpu_userq_fence_create(), and direct queue->last_fence accesses,
all before userq_mutex is acquired by amdgpu_userq_ensure_ev_fence().

A concurrent AMDGPU_USERQ_OP_FREE can destroy and free the queue
in this window, leading to a use-after-free.

This bug predates the queue-id wait ioctl changes and has been
present since the original signal/wait ioctl implementation.

Fix this by moving amdgpu_userq_ensure_ev_fence() before xa_load()
so that the queue lookup and all subsequent accesses are performed
under the userq_mutex that ensure_ev_fence acquires. Add the
necessary mutex_unlock() calls to the error paths between the moved
ensure_ev_fence and the existing unlock.

Fixes: a292fdecd728 ("drm/amdgpu: Implement userqueue signal/wait IOCTL")
Cc: stable@vger.kernel.org
Signed-off-by: Chenyuan Mi <chenyuan_mi@163.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
index 1785ea7c18fe..7866f583eea4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
@@ -545,23 +545,28 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
 		}
 	}
 
-	/* Retrieve the user queue */
+	/* We are here means UQ is active, make sure the eviction fence is valid */
+	amdgpu_userq_ensure_ev_fence(&fpriv->userq_mgr, &fpriv->evf_mgr);
+
+	/* Retrieve the user queue under userq_mutex (held by ensure_ev_fence) */
 	queue = xa_load(&userq_mgr->userq_xa, args->queue_id);
 	if (!queue) {
+		mutex_unlock(&userq_mgr->userq_mutex);
 		r = -ENOENT;
 		goto put_gobj_write;
 	}
 
 	r = amdgpu_userq_fence_read_wptr(adev, queue, &wptr);
-	if (r)
+	if (r) {
+		mutex_unlock(&userq_mgr->userq_mutex);
 		goto put_gobj_write;
+	}
 
 	r = amdgpu_userq_fence_alloc(&userq_fence);
-	if (r)
+	if (r) {
+		mutex_unlock(&userq_mgr->userq_mutex);
 		goto put_gobj_write;
-
-	/* We are here means UQ is active, make sure the eviction fence is valid */
-	amdgpu_userq_ensure_ev_fence(&fpriv->userq_mgr, &fpriv->evf_mgr);
+	}
 
 	/* Create a new fence */
 	r = amdgpu_userq_fence_create(queue, userq_fence, wptr, &fence);
-- 
2.53.0


