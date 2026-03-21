Return-Path: <stable+bounces-227719-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ELo9EVo9vmm7KQMAu9opvQ
	(envelope-from <stable+bounces-227719-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 21 Mar 2026 07:40:26 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id CD7922E3B0A
	for <lists+stable@lfdr.de>; Sat, 21 Mar 2026 07:40:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E2BAB301946F
	for <lists+stable@lfdr.de>; Sat, 21 Mar 2026 06:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 177F031354D;
	Sat, 21 Mar 2026 06:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="N86E3LLb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE032D97BA
	for <stable@vger.kernel.org>; Sat, 21 Mar 2026 06:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774075221; cv=none; b=jjSvUu4eRfmb2pqERtaYerzHn28JPNBkXRDsu7SMOI9i5+EsqDU4iH8tOmIJVdk9PvK30k8DrbotEalTda6oSOVv+ZjeHgDNFanDPlQcaXbiwIuqIg7FzeQwJzqYKBM1Mv8NtjGI9jadovL+xUaibsPBcNciAki6CGoLj/49TJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774075221; c=relaxed/simple;
	bh=QTnElKZjNvUy8lPPKe+NBxgOQk4Pdi8jfvWn15hZaKo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=BFqTyQVR1g5ACLPaC+MTAYbv3X6GP4rvmQdbrKar4VwxrOme1Z4wTS6ri9F21JuyASHNXDdZXfvuipZo/btMPl4+ji3b1p8TNxwimcQ9cZI+ln2PRqPtuRXRmo5gYe6ZQu6LMWNmusVcap1r4r8e42/4xApfdpAgWyVNMDLKpg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=N86E3LLb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55636C19421;
	Sat, 21 Mar 2026 06:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774075221;
	bh=QTnElKZjNvUy8lPPKe+NBxgOQk4Pdi8jfvWn15hZaKo=;
	h=Subject:To:Cc:From:Date:From;
	b=N86E3LLb2a1dueOK9tbZRP2oqO8DcXwsUNjpU16GF6ctmeUH1elxS37dpRMQ1+VrB
	 4ik9OleAi7S9NRW+ewiKQVCsCoAb6iPfHZK5EcU9WkTexGvALAv9To6M+9hcHA77wp
	 CbkLZDjON6vASIZx+4sLLKqcA+jSQ5ZjHWXvFYZc=
Subject: FAILED: patch "[PATCH] drm/amdgpu/mmhub4.2.0: add bounds checking for cid" failed to apply to 6.19-stable tree
To: alexander.deucher@amd.com,benjamin.cheng@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 21 Mar 2026 07:40:00 +0100
Message-ID: <2026032100-fancy-gander-07e0@gregkh>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-227719-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: CD7922E3B0A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 6.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.19.y
git checkout FETCH_HEAD
git cherry-pick -x 9c52f49545478aa47769378cd0b53c5005d6a846
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026032100-fancy-gander-07e0@gregkh' --subject-prefix 'PATCH 6.19.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 9c52f49545478aa47769378cd0b53c5005d6a846 Mon Sep 17 00:00:00 2001
From: Alex Deucher <alexander.deucher@amd.com>
Date: Wed, 4 Mar 2026 17:26:17 -0500
Subject: [PATCH] drm/amdgpu/mmhub4.2.0: add bounds checking for cid

The value should never exceed the array size as those
are the only values the hardware is expected to return,
but add checks anyway.

Reviewed-by: Benjamin Cheng <benjamin.cheng@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit dea5f235baf3786bfd4fd920b03c19285fdc3d9f)
Cc: stable@vger.kernel.org

diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v4_2_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v4_2_0.c
index a72770e3d0e9..2532ca80f735 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v4_2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v4_2_0.c
@@ -688,7 +688,8 @@ mmhub_v4_2_0_print_l2_protection_fault_status(struct amdgpu_device *adev,
 		status);
 	switch (amdgpu_ip_version(adev, MMHUB_HWIP, 0)) {
 	case IP_VERSION(4, 2, 0):
-		mmhub_cid = mmhub_client_ids_v4_2_0[cid][rw];
+		mmhub_cid = cid < ARRAY_SIZE(mmhub_client_ids_v4_2_0) ?
+			mmhub_client_ids_v4_2_0[cid][rw] : NULL;
 		break;
 	default:
 		mmhub_cid = NULL;


