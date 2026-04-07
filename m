Return-Path: <stable+bounces-233658-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gAncA4Yg1Wnr0wcAu9opvQ
	(envelope-from <stable+bounces-233658-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 17:19:34 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 348A23B0D2B
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 17:19:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 45FEE30432F8
	for <lists+stable@lfdr.de>; Tue,  7 Apr 2026 15:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B98A33624B3;
	Tue,  7 Apr 2026 15:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VHyvvm7O"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C93A361DAC
	for <stable@vger.kernel.org>; Tue,  7 Apr 2026 15:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775574930; cv=none; b=PRyJLqGj/ZEMM+YA2LfmmH0u1ESFJ1WjRkgccl67OunmFILjR2Nu2l33Al+RjTMGKZXUOb4uksclrZTYi3TlfkU0uB4nQ5zCXjFWUi6U5CL8h85VhcHyfLrpzxn0uI3xeRZ9HrHvaXICg/neXWKdCRDoTeqIapH9STwahEHhNdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775574930; c=relaxed/simple;
	bh=t9GDYJlcDfcpXZKrmjipqtlPcy/uyYTd36uXbQHOL5o=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=cG77suJ5itlzFR6lfhaeF0hkIoJMip9qgUMKBSiykGsiHFenOXi9DYf9yrHNTu4HAvpMBL/4Au4Y7M6rL0C0mA2vCkbJ26QD4slXgaAA8oZkP/HeSziHaMbmLn1OTeEOh6iVoRsXFdvmlEk80DbU1DLrVZN6lCE0MVjE08ZpztM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VHyvvm7O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0659C116C6;
	Tue,  7 Apr 2026 15:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775574930;
	bh=t9GDYJlcDfcpXZKrmjipqtlPcy/uyYTd36uXbQHOL5o=;
	h=Subject:To:Cc:From:Date:From;
	b=VHyvvm7O8KyD5KgDNmPbPjVNll4a5t9vKiaUD8bLboMWoOw1z98dNCREYcRyHrvz2
	 oI9WpxHdQcu2lvEkl8oDQKsXsoMGQBXWgGD5pm2V2woflgWkORfiQYBbsvCeSrX9ee
	 UA6QEwc8KonlyTuXRF6p7XfwjnMxXtRriewJtLW4=
Subject: FAILED: patch "[PATCH] drm/amdgpu/userq: fix memory leak in MQD creation error paths" failed to apply to 6.19-stable tree
To: moonafterrain@outlook.com,Prike.Liang@amd.com,alexander.deucher@amd.com,danisjiang@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 07 Apr 2026 17:15:27 +0200
Message-ID: <2026040727-prepaid-ascend-9c54@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233658-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[outlook.com,amd.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim,gregkh:email,amd.com:email,outlook.com:email]
X-Rspamd-Queue-Id: 348A23B0D2B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 6.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.19.y
git checkout FETCH_HEAD
git cherry-pick -x ced5c30e47d1cd52d6ae40f809223a6286854086
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026040727-prepaid-ascend-9c54@gregkh' --subject-prefix 'PATCH 6.19.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From ced5c30e47d1cd52d6ae40f809223a6286854086 Mon Sep 17 00:00:00 2001
From: Junrui Luo <moonafterrain@outlook.com>
Date: Sat, 14 Mar 2026 23:33:53 +0800
Subject: [PATCH] drm/amdgpu/userq: fix memory leak in MQD creation error paths

In mes_userq_mqd_create(), the memdup_user() allocations for
IP-specific MQD structs are not freed when subsequent VA validation
fails. The goto free_mqd label only cleans up the MQD BO object and
userq_props.

Fix by adding kfree() before each goto free_mqd on VA validation
failure in the COMPUTE, GFX, and SDMA branches.

Fixes: 9e46b8bb0539 ("drm/amdgpu: validate userq buffer virtual address and size")
Reported-by: Yuhao Jiang <danisjiang@gmail.com>
Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
Reviewed-by: Prike Liang <Prike.Liang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 27f5ff9e4a4150d7cf8b4085aedd3b77ddcc5d08)
Cc: stable@vger.kernel.org

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
index 8c74894254f7..faac21ee5739 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -324,8 +324,10 @@ static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
 
 		r = amdgpu_userq_input_va_validate(adev, queue, compute_mqd->eop_va,
 						   2048);
-		if (r)
+		if (r) {
+			kfree(compute_mqd);
 			goto free_mqd;
+		}
 
 		userq_props->eop_gpu_addr = compute_mqd->eop_va;
 		userq_props->hqd_pipe_priority = AMDGPU_GFX_PIPE_PRIO_NORMAL;
@@ -365,12 +367,16 @@ static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
 
 		r = amdgpu_userq_input_va_validate(adev, queue, mqd_gfx_v11->shadow_va,
 						   shadow_info.shadow_size);
-		if (r)
+		if (r) {
+			kfree(mqd_gfx_v11);
 			goto free_mqd;
+		}
 		r = amdgpu_userq_input_va_validate(adev, queue, mqd_gfx_v11->csa_va,
 						   shadow_info.csa_size);
-		if (r)
+		if (r) {
+			kfree(mqd_gfx_v11);
 			goto free_mqd;
+		}
 
 		kfree(mqd_gfx_v11);
 	} else if (queue->queue_type == AMDGPU_HW_IP_DMA) {
@@ -390,8 +396,10 @@ static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
 		}
 		r = amdgpu_userq_input_va_validate(adev, queue, mqd_sdma_v11->csa_va,
 						   32);
-		if (r)
+		if (r) {
+			kfree(mqd_sdma_v11);
 			goto free_mqd;
+		}
 
 		userq_props->csa_addr = mqd_sdma_v11->csa_va;
 		kfree(mqd_sdma_v11);


