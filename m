Return-Path: <stable+bounces-226263-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KCQ4CDKHuWmTJAIAu9opvQ
	(envelope-from <stable+bounces-226263-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 17:54:10 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EBA42AE9D7
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 17:54:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CC9C730AAAAB
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 16:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 228E131F9B3;
	Tue, 17 Mar 2026 16:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="e58OS0cl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB5B3590B8;
	Tue, 17 Mar 2026 16:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773765943; cv=none; b=fpx2f0vkMHoKe1QFRO8KgHl3fhTK3uVcSt9RB0Qonlv2nZE8utJ3R/dDeq7H0qJT2/YuWhzQqxdGGcpyrfQMNtnmeGYAFUjN3fbVQ5iv98rFP+9NLCTmXIb//VJ5/fSIZS9D7GS27HCRwCg5TUeJ9JjYavxljtUy400nThbj/GI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773765943; c=relaxed/simple;
	bh=sWsowVJjP+D85uX/59UWHtkQDhpp+SXF8++6rgBly1E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M7CggSFVuDr/1D+WbBWKAYu8GA2y5FJUTLwGORHbP3vr87hoXCwaHqqVDhiOoIELXdKKakA8F6CawvyGppFbJclm5IPI6C0gcHM9Nv+LMjZ1+493uc3BRcLJX2BsAz6ScA92d7gZWx9MPLsWu9wwRqSAE/E8RUlbJq2WMLQzE/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=e58OS0cl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C03DC4CEF7;
	Tue, 17 Mar 2026 16:45:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773765943;
	bh=sWsowVJjP+D85uX/59UWHtkQDhpp+SXF8++6rgBly1E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=e58OS0clOMARpaypFwgeCVz1V1b5CHJ5q6bNOsjkJz7qAaGRSR6UoyKSjdB4+IiLe
	 17dP0n50/dW6uAdlbxsRHemueffFyVqPiqY2fSjU8lDwmn3wXB5A0W7JiOknIcVSho
	 xi/cIQe/7zwpLj7t9KP81Gd9WoOJ2ao9c6hyHK1M=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Philip Yang <Philip.Yang@amd.com>,
	Alex Sierra <alex.sierra@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 100/378] drm/amdkfd: Unreserve bo if queue update failed
Date: Tue, 17 Mar 2026 17:30:57 +0100
Message-ID: <20260317163010.696818772@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260317163006.959177102@linuxfoundation.org>
References: <20260317163006.959177102@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-226263-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:mid,amd.com:email]
X-Rspamd-Queue-Id: 8EBA42AE9D7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

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




