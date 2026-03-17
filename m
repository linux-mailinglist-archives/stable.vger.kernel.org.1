Return-Path: <stable+bounces-226351-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2BauEhKJuWmTJAIAu9opvQ
	(envelope-from <stable+bounces-226351-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:02:10 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 87DF32AED23
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:02:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 252BA31BE88F
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 16:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C0673F54B8;
	Tue, 17 Mar 2026 16:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XZmSzksV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F9B93EAC6F;
	Tue, 17 Mar 2026 16:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773766320; cv=none; b=ua8Y1j7pXISA7wO+OWDx6Gt1TQD8I77KSGbFJeEmTplcPhb2TCJPbr4vI8C7oqhiPx6mJm/4JvCWXagmhxZRliPaXrR0qLZut0R4sRLw7As57zw+prihBUJikqfs/4SulEvgxGlbk1o4Sb1i7/AdEKK0P2Kvvis1zDwNtjYmhQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773766320; c=relaxed/simple;
	bh=WT1MSkKr17WHZgbWTW/ew+TITKG7DltKEUHS9OESgys=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gyoZeXOWGMaPky9e5mjDqqwyyNtS44IkGozdtrDI5ROmow6uhSasHfYzLpN5ob5clYqCZ+bvb9tV4usPXDHkHVpSunmyWZJhne3fMB8TWNtiWnZyQ0qATLvqV/BCynIWXE2DMViFX+YGX3NVlxoEN36+OAi25+IWR/HmBRjIQTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XZmSzksV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4932C4CEF7;
	Tue, 17 Mar 2026 16:51:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773766320;
	bh=WT1MSkKr17WHZgbWTW/ew+TITKG7DltKEUHS9OESgys=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XZmSzksV9BN4Tvz61Q+0eEqdmuMqY9wkcglvq/UdKvLIZXjv8I8IfL+wIibPMpwVK
	 JSek5QERg62zL+EsU8pc5uhHUv7/9kpGBni083OvDOilbISUrmJoVBTOQrObt/yDKy
	 z4U16IpN4GBq5o09LaYBxOc1jTB5q1W+d0Kv1fwY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Alex Deucher <alexander.deucher@amd.com>,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
	Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH 6.19 218/378] drm/amdgpu/userq: Fix reference leak in amdgpu_userq_wait_ioctl
Date: Tue, 17 Mar 2026 17:32:55 +0100
Message-ID: <20260317163015.031516289@linuxfoundation.org>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-226351-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,amd.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 87DF32AED23
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

commit 49abfa812617a7f2d0132c70d23ac98b389c6ec1 upstream.

Drop reference to syncobj and timeline fence when aborting the ioctl due
output array being too small.

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Fixes: a292fdecd728 ("drm/amdgpu: Implement userqueue signal/wait IOCTL")
Cc: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 68951e9c3e6bb22396bc42ef2359751c8315dd27)
Cc: <stable@vger.kernel.org> # v6.16+
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
@@ -880,6 +880,7 @@ int amdgpu_userq_wait_ioctl(struct drm_d
 				dma_fence_unwrap_for_each(f, &iter, fence) {
 					if (num_fences >= wait_info->num_fences) {
 						r = -EINVAL;
+						dma_fence_put(fence);
 						goto free_fences;
 					}
 
@@ -904,6 +905,7 @@ int amdgpu_userq_wait_ioctl(struct drm_d
 
 			if (num_fences >= wait_info->num_fences) {
 				r = -EINVAL;
+				dma_fence_put(fence);
 				goto free_fences;
 			}
 



