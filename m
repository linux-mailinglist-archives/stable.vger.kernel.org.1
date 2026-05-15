Return-Path: <stable+bounces-248605-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eGgUFXNYB2oozgIAu9opvQ
	(envelope-from <stable+bounces-248605-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 19:31:31 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B892A555287
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 19:31:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D1D5F32B3734
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 16:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A5D63F9285;
	Fri, 15 May 2026 16:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="T2ThZbBB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C0A73F9278;
	Fri, 15 May 2026 16:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778862160; cv=none; b=OZowV8skj75V24APVVng4pTHuDluFr+hyWri+FTQMFZIGmfYbzPFSP7VYXLjhtB3z94IuRLHY25e35F7MJC350HtM2cvXdsJKcPB4590gdPZBpChnrl8Ex4glHhJwB+Bq9hkQUDP/kInkEYXIEEsa88jW9xiq7Uh+cL29ZogY70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778862160; c=relaxed/simple;
	bh=SfxOnnkeiUo5po71JtvHfOdJr7ArPNjhe8rauc4EIWE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H78y7iGoopfBDmMMsXhAajceE3vT2jH2lJ1ZGqayWbYAxGBza1w3mzBPQjCsEkl3c5UeP49g1Ihy6ZTDtv1z+3MpmXhO2IrVXk50Y4oW2wb7736tAMt+j6g+QF6ZOMOtZcigZyzr6b5RXRpG8/Nm9xhPIKAlO27LQEODDV3WKdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=T2ThZbBB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 924DDC2BCB0;
	Fri, 15 May 2026 16:22:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778862159;
	bh=SfxOnnkeiUo5po71JtvHfOdJr7ArPNjhe8rauc4EIWE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=T2ThZbBBqjI9rQuhE5liUxrm3Dp6CR51wDA+1BW1N4RMObI7LwHlQk+WGF6WU8GAQ
	 N4+Y1xdLVLZ5E6yBPZlpfYQUpuf9/fvR/kf2F8k13fWT9oSkA+Y2DlfcbgvVWJ4Olm
	 Km04xP+j6l5RcsZEFJcGncnl1JPKpyzBXOymxW/I=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
	Kent Russell <kent.russell@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6.18 131/188] drm/amdgpu/pm: add missing revision check for CI
Date: Fri, 15 May 2026 17:49:08 +0200
Message-ID: <20260515154700.170960436@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260515154657.309489048@linuxfoundation.org>
References: <20260515154657.309489048@linuxfoundation.org>
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
X-Rspamd-Queue-Id: B892A555287
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-248605-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,amd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,gitlab.freedesktop.org:url,amd.com:email,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alex Deucher <alexander.deucher@amd.com>

commit 2a561b361b7681509710f3cfc3d95d54c87ac69f upstream.

The ci_populate_all_memory_levels() workaround only
applies to revision 0 SKUs.

Link: https://gitlab.freedesktop.org/drm/amd/-/work_items/1816
Fixes: 9f4b35411cfe ("drm/amd/powerplay: add CI asics support to smumgr (v3)")
Reviewed-by: Timur Kristóf <timur.kristof@gmail.com>
Reviewed-by: Kent Russell <kent.russell@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 1db15ba8f72f400bbad8ae0ce24fafc43429d4bd)
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/pm/powerplay/smumgr/ci_smumgr.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/drivers/gpu/drm/amd/pm/powerplay/smumgr/ci_smumgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/smumgr/ci_smumgr.c
@@ -1326,8 +1326,9 @@ static int ci_populate_all_memory_levels
 
 	dev_id = adev->pdev->device;
 
-	if ((dpm_table->mclk_table.count >= 2)
-		&& ((dev_id == 0x67B0) ||  (dev_id == 0x67B1))) {
+	if ((dpm_table->mclk_table.count >= 2) &&
+	    ((dev_id == 0x67B0) ||  (dev_id == 0x67B1)) &&
+	    (adev->pdev->revision == 0)) {
 		smu_data->smc_state_table.MemoryLevel[1].MinVddci =
 				smu_data->smc_state_table.MemoryLevel[0].MinVddci;
 		smu_data->smc_state_table.MemoryLevel[1].MinMvdd =



