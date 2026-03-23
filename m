Return-Path: <stable+bounces-229405-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KCVeEyVywWkQTQQAu9opvQ
	(envelope-from <stable+bounces-229405-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 18:02:29 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C0E782F9551
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 18:02:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0FCE633FF5D8
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E73D3B7747;
	Mon, 23 Mar 2026 15:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iyAaOPss"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0124F3B27ED;
	Mon, 23 Mar 2026 15:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774279107; cv=none; b=uRgrRfrenTnU1LGGG1dgr/p630p7p1bDX8xP7Z/P1tfocft57HQeCCMJFxw1pmhzjohdGtNT+fgYdHqQvHdPQ3cGaoQ8tcCNwDZfnu0L0EPS2ODvh1fKrng0uT8kMQqWzeOjLn8mwl1q0qnPblV3D+/hIxLqe0VNCFROp8R1D8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774279107; c=relaxed/simple;
	bh=xVaqKeaqHKxGoz86W9ccg7AaqcLB1eyRaLdQ8jNDokw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O2LWcxIe73Pk5R8eaidH4DY124s0ZxcyxSsViYEN8E83GzGYp0i2EuuwRRIU3pIukiSVAo1c//rbiYdtnyo5v+lxkopGVWRAaN+Otj7tdKUrVECQ48yIPQ8UuRp7bEGOO+1HmhqlDIVyk2Lj11nE4SugW3YR9W/mravzI/c+wa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iyAaOPss; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 300DAC2BC9E;
	Mon, 23 Mar 2026 15:18:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774279106;
	bh=xVaqKeaqHKxGoz86W9ccg7AaqcLB1eyRaLdQ8jNDokw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iyAaOPssQOuOXoFdkXZjCluKeMX4witkkS+12iY4MFCzopPmB4S77fz9aXosSAxx2
	 ON6Z/4lwXhpQ42zUU/jOZ+qKra5Pzrj0+tB6xhSsiY2sDaPnDsLb1htmWQPfr/YlUk
	 4knjqDI7zuVUlbQOItYZI1j3lJqDvCxDDH3YssOA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Benjamin Cheng <benjamin.cheng@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6.6 489/567] drm/amdgpu/mmhub2.3: add bounds checking for cid
Date: Mon, 23 Mar 2026 14:46:49 +0100
Message-ID: <20260323134546.081723324@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134533.749096647@linuxfoundation.org>
References: <20260323134533.749096647@linuxfoundation.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-229405-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: C0E782F9551
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alex Deucher <alexander.deucher@amd.com>

commit a54403a534972af5d9ba5aaa3bb6ead612500ec6 upstream.

The value should never exceed the array size as those
are the only values the hardware is expected to return,
but add checks anyway.

Reviewed-by: Benjamin Cheng <benjamin.cheng@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 89cd90375c19fb45138990b70e9f4ba4806f05c4)
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c
@@ -94,7 +94,8 @@ mmhub_v2_3_print_l2_protection_fault_sta
 	case IP_VERSION(2, 3, 0):
 	case IP_VERSION(2, 4, 0):
 	case IP_VERSION(2, 4, 1):
-		mmhub_cid = mmhub_client_ids_vangogh[cid][rw];
+		mmhub_cid = cid < ARRAY_SIZE(mmhub_client_ids_vangogh) ?
+			mmhub_client_ids_vangogh[cid][rw] : NULL;
 		break;
 	default:
 		mmhub_cid = NULL;



