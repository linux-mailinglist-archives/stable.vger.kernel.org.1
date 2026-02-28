Return-Path: <stable+bounces-220269-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gLrwGsc1o2nP+QQAu9opvQ
	(envelope-from <stable+bounces-220269-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:36:55 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 754FD1C607A
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:36:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 39DBC31243F6
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:02:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB841381CA5;
	Sat, 28 Feb 2026 17:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IL58wnAO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF1847DD69;
	Sat, 28 Feb 2026 17:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300172; cv=none; b=q9EVWgSILVf0bDIN/frcRkfB87MnOCw1ei25DAxl47q10K1ZrOfwchewDdKNiFLOiZ2vf1+gip6i76guLdX7Y3U/yDN0aNk52sT6Qo4g+fOIT6liOXRJblQGEbqbNF5xpCkf1g84vecQ9B+/jwvaQUyfIKruszUxBeDrbRMw/DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300172; c=relaxed/simple;
	bh=BzE1gBPpCyLPPTAUrwMVtOT5vUOURwrYx36Nm0Pv+ho=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CCuVkMm4z4ORsSoR9+KnH3+TRwaNQlprz9N9eA3JuNbgRSwdXGYP5+jdksudcp7bwFILdiApK2G4aAupxOv/dDUa8W61xxgTnaRm9fGJRRYdXP8o4aScPapGAkYaMiABa8dccmaJ5cjFUT2Q3szH94zebddxMBMm2srwdeXf5Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IL58wnAO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B569C19423;
	Sat, 28 Feb 2026 17:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300172;
	bh=BzE1gBPpCyLPPTAUrwMVtOT5vUOURwrYx36Nm0Pv+ho=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IL58wnAOIEtiIuy92TK6stXEWxhRADJzFi6EInF8cbxiCP6Y6gWRIDWEGlsms94XL
	 97UZbDJiAtdnnhAyqi7o+c/B9wE4W09eOmfGKhrmSesDNmfHlFOjW8Tb1DBiCP3xND
	 wW8JdDTCwuyN78ZsRVOZYRa43TPv3DLfdpevhH5J5D9up03r2gQsKSjmbTJ2jOyPUS
	 xAQa+1chO3XNsG3huENefMydCNXVeYp+9HJ2vJ53omO8Cd1u2PXf4SDY50d/3iPW7x
	 hw02s9nSUD+DFrfKpijMrPCr/qRrGL3ujkzOlG+ZCAh6AT0/pBUr1VJiic4DBb7GLK
	 Mo31n1m5pmaBg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Donet Tom <donettom@linux.ibm.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Philip Yang <yangp@amd.com>,
	Felix Kuehling <felix.kuehling@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 191/844] drm/amdkfd: Relax size checking during queue buffer get
Date: Sat, 28 Feb 2026 12:21:44 -0500
Message-ID: <20260228173244.1509663-192-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-220269-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 754FD1C607A
X-Rspamd-Action: no action

From: Donet Tom <donettom@linux.ibm.com>

[ Upstream commit 42ea9cf2f16b7131cb7302acb3dac510968f8bdc ]

HW-supported EOP buffer sizes are 4K and 32K. On systems that do not
use 4K pages, the minimum buffer object (BO) allocation size is
PAGE_SIZE (for example, 64K). During queue buffer acquisition, the driver
currently checks the allocated BO size against the supported EOP buffer
size. Since the allocated BO is larger than the expected size, this check
fails, preventing queue creation.

Relax the strict size validation and allow PAGE_SIZE-sized BOs to be used.
Only the required 4K region of the buffer will be used as the EOP buffer
and avoids queue creation failures on non-4K page systems.

Acked-by: Christian König <christian.koenig@amd.com>
Suggested-by: Philip Yang <yangp@amd.com>
Signed-off-by: Donet Tom <donettom@linux.ibm.com>
Signed-off-by: Felix Kuehling <felix.kuehling@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdkfd/kfd_queue.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
index 80c4fa2b0975d..2822c90bd7be4 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
@@ -275,8 +275,8 @@ int kfd_queue_acquire_buffers(struct kfd_process_device *pdd, struct queue_prope
 
 	/* EOP buffer is not required for all ASICs */
 	if (properties->eop_ring_buffer_address) {
-		if (properties->eop_ring_buffer_size != topo_dev->node_props.eop_buffer_size) {
-			pr_debug("queue eop bo size 0x%x not equal to node eop buf size 0x%x\n",
+		if (properties->eop_ring_buffer_size < topo_dev->node_props.eop_buffer_size) {
+			pr_debug("queue eop bo size 0x%x is less than node eop buf size 0x%x\n",
 				properties->eop_ring_buffer_size,
 				topo_dev->node_props.eop_buffer_size);
 			err = -EINVAL;
@@ -284,7 +284,7 @@ int kfd_queue_acquire_buffers(struct kfd_process_device *pdd, struct queue_prope
 		}
 		err = kfd_queue_buffer_get(vm, (void *)properties->eop_ring_buffer_address,
 					   &properties->eop_buf_bo,
-					   properties->eop_ring_buffer_size);
+					   ALIGN(properties->eop_ring_buffer_size, PAGE_SIZE));
 		if (err)
 			goto out_err_unreserve;
 	}
-- 
2.51.0


