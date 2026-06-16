Return-Path: <stable+bounces-265022-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id BuZCESaBMWp5lAUAu9opvQ
	(envelope-from <stable+bounces-265022-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 19:00:22 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id CB7D1692A5F
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 19:00:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=lRqS+1fm;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-265022-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-265022-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9CAE1303EE18
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 16:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EAD944CF44;
	Tue, 16 Jun 2026 16:58:05 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0910847884C;
	Tue, 16 Jun 2026 16:58:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781629085; cv=none; b=XeJnWS2QcyAHtZqCpkqIaEbx8mB1tCgvdyUx1lHin+09Uel2cptO/7/VD3doUQ+EqM0ygvcgLpw52j62I1Uz/NkMt8rkYUtAN95/xBG1kuKTUMI+Pj3Jkz4Kjmc+SfJpsb4i9G71opz/dbVnG6cY0nLkbX6+Pj1qiIuLSJ1tiqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781629085; c=relaxed/simple;
	bh=FDRPL9hda+aBVT2SyhWDuRUplVKLSXdPeSv6uH94JMo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L7FbTpPfR/tZtzg/WLHKEQWcRMxo8PjkMDDBhIo7fGGoLjYjrTLJr0NMkLGGb5e0SU7xDOj1cxEBE9JdrRc2r/j8h+L7H7QMjZnS6CO9qcQrjZEJkGFNGQgRf4YVZkhyfquVThqIvOxs4Hc3ipYg3PWr6v7QO46NjI52pv2lD28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lRqS+1fm; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E5691F000E9;
	Tue, 16 Jun 2026 16:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781629083;
	bh=5q7/UPaRIvCB7rcstWwGkCccPgPjkLQYbWCNS6BR1EY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lRqS+1fmVPvpVU6v27NMW1DfLeJLCFhqM+LN90/gndROQLJaa24LEl1O0HHREI3rn
	 QhZOeIEyJFKJFSmnc73TXXYhHtqPe10hMGoRSUn69hH8rnRtMAukwVPGMrKUHuq/x0
	 ZD47XCsDgOqrER8FcoTYtJhqztgjMPhIrvKD4j7o=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Eric Huang <jinhuieric.huang@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6.6 186/452] drm/amdkfd: fix a vulnerability of integer overflow in kfd debugger
Date: Tue, 16 Jun 2026 20:26:53 +0530
Message-ID: <20260616145127.608240906@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145117.796205997@linuxfoundation.org>
References: <20260616145117.796205997@linuxfoundation.org>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-265022-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:jinhuieric.huang@amd.com,m:alexander.deucher@amd.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,amd.com:email,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CB7D1692A5F

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Huang <jinhuieric.huang@amd.com>

commit 93f5534b35a05ef8a0109c1eefa800062fee810a upstream.

get_queue_ids() computes array_size = num_queues * sizeof(uint32_t),
which could overflow on 32-bit size_t build. using array_size()
instead, it saturates to SIZE_MAX on overflow.

Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 2d57a0475f085c08b49312dfd8edcb461845f285)
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -2786,12 +2786,14 @@ static void copy_context_work_handler (s
 
 static uint32_t *get_queue_ids(uint32_t num_queues, uint32_t *usr_queue_id_array)
 {
-	size_t array_size = num_queues * sizeof(uint32_t);
-
 	if (!usr_queue_id_array)
 		return NULL;
 
-	return memdup_user(usr_queue_id_array, array_size);
+	if (num_queues > KFD_MAX_NUM_OF_QUEUES_PER_PROCESS)
+		return ERR_PTR(-EINVAL);
+
+	return memdup_user(usr_queue_id_array,
+			   array_size(num_queues, sizeof(uint32_t)));
 }
 
 int resume_queues(struct kfd_process *p,



