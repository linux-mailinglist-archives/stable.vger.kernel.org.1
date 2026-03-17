Return-Path: <stable+bounces-226611-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ICGRMkWMuWnkJwIAu9opvQ
	(envelope-from <stable+bounces-226611-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:15:49 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 88C772AF350
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:15:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0A8D330B9312
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 17:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8666C3F6605;
	Tue, 17 Mar 2026 17:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nJScaWCY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DCC13F660C;
	Tue, 17 Mar 2026 17:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773767462; cv=none; b=Rta2ax5g6jSIOMTjuNCUiukrMhWL8Zz7GJP+Y4v23GmQQYnZoPsfqSVVugR6ftibM+AplRq9o76Leu8ZJVuuOPmojixxA2Tb3qlpVIiNJYSHZ0z5JGO0301ZqTCQXj3fvcBmoQCITpZLPSzHJFNoGmEovK4xAiTn/3nu1tfIS9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773767462; c=relaxed/simple;
	bh=211szymnCx4GBFeYVxbgPN4Dm7Cbo3OQMx9NYG7ildo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ozPd5iQBmw/uJRGIyE14tugiDC34ZHyeov9zVKzjrGe93NJj/d3HD9sO1etud+s9PNZmpEVMdna1/jKswC4qMCN43J+XlRWvwPoqKofg8AWQ+tJLkkVuJNxJZ2PUIOCCiA7XyUNPJd1dCwyFUQSdBMEspPQ+OD2z/zvOEplwdOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nJScaWCY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1BB5C4CEF7;
	Tue, 17 Mar 2026 17:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773767462;
	bh=211szymnCx4GBFeYVxbgPN4Dm7Cbo3OQMx9NYG7ildo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nJScaWCYB+PZexGE+UKD2fV+r7K0YPDkjn1Hhq0Tbh0kiEK+kttzFBmobiUXsuR2F
	 OiC2Fim+RfZb8kavkv2qKnwbta6Ldz/dDoUBuXKa4F3Ycy/ba07JHIMpsMEs/QnFz1
	 9LOKGVBJRRcGdcB0OsXbXs6IQe7ka9c6H03ttqng=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Philip Yang <Philip.Yang@amd.com>,
	Alex Sierra <alex.sierra@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 091/333] drm/amdkfd: Unreserve bo if queue update failed
Date: Tue, 17 Mar 2026 17:32:00 +0100
Message-ID: <20260317163002.745655919@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260317162959.345812316@linuxfoundation.org>
References: <20260317162959.345812316@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-226611-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:mid,amd.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 88C772AF350
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Philip Yang <Philip.Yang@amd.com>

[ Upstream commit 2ce75a0b7e1bfddbcb9bc8aeb2e5e7fa99971acf ]

Error handling path should unreserve bo then return failed.

Fixes: 305cd109b761 ("drm/amdkfd: Validate user queue update")
Signed-off-by: Philip Yang <Philip.Yang@amd.com>
Reviewed-by: Alex Sierra <alex.sierra@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit c24afed7de9ecce341825d8ab55a43a254348b33)
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
index 7fbb5c274ccc4..7bf712032c52c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
@@ -606,6 +606,7 @@ int pqm_update_queue_properties(struct process_queue_manager *pqm,
 					 p->queue_size)) {
 			pr_debug("ring buf 0x%llx size 0x%llx not mapped on GPU\n",
 				 p->queue_address, p->queue_size);
+			amdgpu_bo_unreserve(vm->root.bo);
 			return -EFAULT;
 		}
 
-- 
2.51.0




