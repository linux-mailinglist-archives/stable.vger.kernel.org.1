Return-Path: <stable+bounces-248804-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CMu/A8FUB2pIygIAu9opvQ
	(envelope-from <stable+bounces-248804-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 19:15:45 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 85768554B20
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 19:15:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B4390314C076
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 16:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59BFE3D3D19;
	Fri, 15 May 2026 16:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DoAse76Q"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D52D3D330B;
	Fri, 15 May 2026 16:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778862674; cv=none; b=IXrKkivX8/mYzRnur3ux6xkFKABDNi9GoptozjfIbgrNZmS3T9AV2vfVXInvTxFKjt7NUEmjot5gN3b7kgGr1Mn9YaPyn9xh9pnGrpUg9mUAk4psEJ9zCF0Co1JpHwctlNpFJKph01Saamh8O69ywdwFkDbOj2/8H4OjW6qGTlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778862674; c=relaxed/simple;
	bh=hDnEKVKDySC3YbKQsRm18Txf5otohbr2fCH+PsmUeRc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NpAgkHSr/rptFKRFKNWL7pmLabDLVodUZgJskZPwrnIJAdtrVrltAgK5LGG/VQV48hP4veAV/FJGzzIgFeP9pTxcyx29oCPdO7C/LdJNBZPSGPp4NZWj2iRF+ZfxR3jTcnH2x5S0kVZXdka9EIdvqh+PRQS/PChWywTBFm4R8NI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DoAse76Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A90EFC2BCB0;
	Fri, 15 May 2026 16:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778862674;
	bh=hDnEKVKDySC3YbKQsRm18Txf5otohbr2fCH+PsmUeRc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DoAse76QTmBwXaLZvoKu5jJZQv79nQqDXbTC9Cc6QruH1wb7/SJpMZSE2NAr2UiAE
	 LWZq4E2mxApL1FTwgxdd0MhqId2Ejy3JzwunuYPnkRULOFI/Ya8TFbDwYYxg1rLn5l
	 bnx04N6tXi8oob44fpZqWThUN3zg59ZoGj781KVk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Benjamin Cheng <benjamin.cheng@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 7.0 140/201] drm/amdgpu/vce: Prevent partial address patches
Date: Fri, 15 May 2026 17:49:18 +0200
Message-ID: <20260515154701.601159976@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260515154658.538039039@linuxfoundation.org>
References: <20260515154658.538039039@linuxfoundation.org>
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
X-Rspamd-Queue-Id: 85768554B20
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-248804-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amd.com:email]
X-Rspamd-Action: no action

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Benjamin Cheng <benjamin.cheng@amd.com>

commit de2a02cc28d6d5d37db07d00a9a684c754a5fd74 upstream.

In the case that only one of lo/hi is valid, the patching could result
in a bad address written to in FW.

Signed-off-by: Benjamin Cheng <benjamin.cheng@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
@@ -698,6 +698,9 @@ static int amdgpu_vce_cs_reloc(struct am
 	uint64_t addr;
 	int r;
 
+	if (lo >= ib->length_dw || hi >= ib->length_dw)
+		return -EINVAL;
+
 	if (index == 0xffffffff)
 		index = 0;
 



