Return-Path: <stable+bounces-227720-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8PSDBVk/vmk8KgMAu9opvQ
	(envelope-from <stable+bounces-227720-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 21 Mar 2026 07:48:57 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AE6D32E3C77
	for <lists+stable@lfdr.de>; Sat, 21 Mar 2026 07:48:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DCF4F301F140
	for <lists+stable@lfdr.de>; Sat, 21 Mar 2026 06:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D103329E6F;
	Sat, 21 Mar 2026 06:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gjy5ekx/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E7763195F5
	for <stable@vger.kernel.org>; Sat, 21 Mar 2026 06:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774075230; cv=none; b=OYmIlI24wMhMhKua1+i5g2xM9Xj7Wt0oyuQPfgG7JRpXtMWBZ4Ha0VUhQtTqXIe2waS5MTnSezusuB4mIiumLs09z37/ckc2Gw/FqULprPIFKq4nzjUbHBemavA52WJZOSYXObOgoZsb+ZMYVKTv5WudKqG0DaAhlvEVknASYF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774075230; c=relaxed/simple;
	bh=orjStmDjBfDLqbMWIG6WeCZQzuuB4LedtGD3nilVCPM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=gFV6Q9z+Dy0hK7NHw6ZFDWy5mYftNydGL/M/J6QYrlFdazcEDKaNbgngfuTKJiHFe6JTakX1o4jQVu6vScNMSdrl16g/q1Q18gFiHIaZFI+fW8bsQza3Dj6ijHOtFgHzu6uAiYkfKZlSUvDwjPmptdOGVpVk74jhyAbPoHbXVUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gjy5ekx/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6A5FC19421;
	Sat, 21 Mar 2026 06:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774075230;
	bh=orjStmDjBfDLqbMWIG6WeCZQzuuB4LedtGD3nilVCPM=;
	h=Subject:To:Cc:From:Date:From;
	b=gjy5ekx/T4wlaP0Z7ROdtAPrMltFsEvZ3XXk/cVGkcvvs2YBf8UWbilw/8kjh4jLd
	 Tk4gqoxfsAX/vJ012FQtkKCriXKvpUpnGxbpXeSckM5y0S/6IooPzLAA9XQN5Anm4s
	 ER87XlwskkbAaaIuMxS5uigfy2X8o2CvFWU4n2k4=
Subject: FAILED: patch "[PATCH] drm/amdgpu/mmhub4.2.0: add bounds checking for cid" failed to apply to 6.12-stable tree
To: alexander.deucher@amd.com,benjamin.cheng@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 21 Mar 2026 07:40:01 +0100
Message-ID: <2026032101-equal-resurface-7f76@gregkh>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-227720-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,amd.com:email,linuxfoundation.org:dkim,gregkh:email]
X-Rspamd-Queue-Id: AE6D32E3C77
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 9c52f49545478aa47769378cd0b53c5005d6a846
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026032101-equal-resurface-7f76@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

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


