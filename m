Return-Path: <stable+bounces-261739-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Y26GGtJPJWpMGwIAu9opvQ
	(envelope-from <stable+bounces-261739-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 13:02:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C671A65040C
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 13:02:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=ncuwHg3N;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-261739-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-261739-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 97E11306B7C4
	for <lists+stable@lfdr.de>; Sun,  7 Jun 2026 10:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DB8F2E3AF1;
	Sun,  7 Jun 2026 10:54:17 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70DAC4204E;
	Sun,  7 Jun 2026 10:54:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780829657; cv=none; b=cwE3b49ERTruN/CVdSoKHuDCNb3bCdeXQ0QJu0oMAbYmTbTjlrkLwjkCzHvM1kJBmc/nIeXmT+50k1VaFGD2qLfnxtPbvaLramibHGoRzOjCNo4fY3rqE+T08MMVn46Aw1436mvASF3r+9pPYCFyQb7maWdJtqMJVzXFpKNnudU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780829657; c=relaxed/simple;
	bh=lUOV5tVU3xztjOmLIKS9G7YtZPMFe+QWPEj+3K5XGmg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VQ0T1lPNNvvI9DqzBL7r646xsO7qQGCA1hOpE2t8MLEnm1CaUkaACRqelZLcW3hvMkbL9WHjZPPpnBViTI7KIJD7ZBxEc+UDqty2ZhB7ZyHCasAslrooD6FUu//gg4g3DFQEQly6X6cbIYjg8sPUGQscLE383vzZ77zvRvjRasI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ncuwHg3N; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAB7D1F00893;
	Sun,  7 Jun 2026 10:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780829656;
	bh=/hpBoBFUwtuvzJqfrvZt0e/5hwHwqSQmiJpNNgggRrM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ncuwHg3N7tNGyEpmBP4quOdrO2n/tqCNskxKDXw9jMoIbNmPqwaDGTOaOFTQ8yV/H
	 SowOsEgCUNJmT22/w79DGOTxF87sSs+pZil2Qj2XYl/gki16DxzwMKUkO/pMvugejq
	 w/qtG2G+fKEbPf1eUiPcTqgoNHHVZCaY/IEu/VlI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Eric Huang <jinhuieric.huang@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 7.0 303/332] drm/amdkfd: fix a vulnerability of integer overflow in kfd debugger
Date: Sun,  7 Jun 2026 12:01:12 +0200
Message-ID: <20260607095739.203933778@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260607095728.031258202@linuxfoundation.org>
References: <20260607095728.031258202@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-261739-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:jinhuieric.huang@amd.com,m:alexander.deucher@amd.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,linuxfoundation.org:mid,linuxfoundation.org:dkim,linuxfoundation.org:from_mime,linuxfoundation.org:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C671A65040C

7.0-stable review patch.  If anyone has any objections, please let me know.

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
@@ -3296,12 +3296,14 @@ static void copy_context_work_handler(st
 
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



