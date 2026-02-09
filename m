Return-Path: <stable+bounces-214983-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GHS7HOXviWn4EQAAu9opvQ
	(envelope-from <stable+bounces-214983-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 15:32:05 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C381511063C
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 15:32:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6DC433046033
	for <lists+stable@lfdr.de>; Mon,  9 Feb 2026 14:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BDA037B3FE;
	Mon,  9 Feb 2026 14:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HaEBAQxL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BDD037B3F1;
	Mon,  9 Feb 2026 14:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770647287; cv=none; b=M1Wey0zau3O7bBXqZThoOLWiwcdqoRn0AZtnDarGWZBfgE3KllT4bI7ihG5mOi0k/Yx4pTTkvY0bdHFNWCcCQwX838GZ2oM7P5IoaaF7E/4QzdD5++lqTjS9PmOheJE7g0k7eBPEHcXLq+aX9d9ymWUwewBBy0vSxewGy4W+FiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770647287; c=relaxed/simple;
	bh=u79mawx8CXjoR36+K84LvrCyOP8k8BUaymXZZS0cod0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pooIuoXDi8M+zsnq/PKfRTSekEBFWDI5cDXr97kKE/DWmoTj6Opb3GWLrP11ew4zBEXdK0iWZyH2VDXufXB9cHBINZMxWhlF51ZCK/qpAgD4Y4XwM6cgcxO8yXFhcqycuccH8j1URqxEJl0kQnlaDSxlt2r0KMHDJtEHQp5HwUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HaEBAQxL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C36CDC116C6;
	Mon,  9 Feb 2026 14:28:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770647287;
	bh=u79mawx8CXjoR36+K84LvrCyOP8k8BUaymXZZS0cod0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HaEBAQxLs5YmaIQdFnZ2OgSX6mWXGEA+zhHrBGbALhV/292cqlj7UGKYHHuTyjCDm
	 UZynWLpUQLs0+oNt/WL3//4GqyBLgzKQzM4swOIGDktCgm58SLDx9jNAWm64eCHf5a
	 slHZCrERM4+31AWhWu7BF0V+oW5vzcqymtfHtzTs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	danijel@nausys.com,
	Alex Deucher <alexander.deucher@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 6.18 021/175] drm/amd: Set minimum version for set_hw_resource_1 on gfx11 to 0x52
Date: Mon,  9 Feb 2026 15:21:34 +0100
Message-ID: <20260209142321.242346744@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260209142320.474120190@linuxfoundation.org>
References: <20260209142320.474120190@linuxfoundation.org>
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
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-214983-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,linuxfoundation.org:email,gitlab.freedesktop.org:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amd.com:email,nausys.com:email]
X-Rspamd-Queue-Id: C381511063C
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mario Limonciello <mario.limonciello@amd.com>

commit 1478a34470bf4755465d29b348b24a610bccc180 upstream.

commit f81cd793119e ("drm/amd/amdgpu: Fix MES init sequence") caused
a dependency on new enough MES firmware to use amdgpu.  This was fixed
on most gfx11 and gfx12 hardware with commit 0180e0a5dd5c
("drm/amdgpu/mes: add compatibility checks for set_hw_resource_1"), but
this left out that GC 11.0.4 had breakage at MES 0x51.

Bump the requirement to 0x52 instead.

Reported-by: danijel@nausys.com
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4576
Fixes: f81cd793119e ("drm/amd/amdgpu: Fix MES init sequence")
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit c2d2ccc85faf8cc6934d50c18e43097eb453ade2)
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -1667,7 +1667,7 @@ static int mes_v11_0_hw_init(struct amdg
 	if (r)
 		goto failure;
 
-	if ((adev->mes.sched_version & AMDGPU_MES_VERSION_MASK) >= 0x50) {
+	if ((adev->mes.sched_version & AMDGPU_MES_VERSION_MASK) >= 0x52) {
 		r = mes_v11_0_set_hw_resources_1(&adev->mes);
 		if (r) {
 			DRM_ERROR("failed mes_v11_0_set_hw_resources_1, r=%d\n", r);



