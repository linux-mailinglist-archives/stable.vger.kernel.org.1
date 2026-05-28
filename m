Return-Path: <stable+bounces-255393-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id FmkaKJKiGGrJlggAu9opvQ
	(envelope-from <stable+bounces-255393-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:16:18 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B92E5F8387
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:16:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C57F13263C6A
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 20:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79E86304BB3;
	Thu, 28 May 2026 20:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BzOx6OsV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF4D2FD7C3;
	Thu, 28 May 2026 20:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779998784; cv=none; b=f67LTPqN1HVfY4jUoZqudApkqkbNfh1XJUYs4TM1Tfa0Wvl1QfCwLnDYEUUHJChRcu1TlmSAh/zktDvQajQAmNEruLKGm4OO/L/J4g9UFoTsQF31TtHKf/SLrmEm9ag6FppGWbWFPPz2i+zlhdcu8OoCYsyMWSgmkG0Q47U3y5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779998784; c=relaxed/simple;
	bh=AQqPyb8cxQY76SLW5es8wP1A4f03CkA6jz5pd+La2WE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lBy9dz2Ny00x+JmzEQoZsh/+1hmnRvHwUOo/sySaJ1pbtI/QmjkzXYRJdpexqhtfm2gavZa+Z9+ew7Xg4pyfE52+cH167BZcXhuuNPcC0GzsnP9znedN+dI391MigNWSB54YL0XtC0rEgkm4/BX1yzFTKf1ofTlW1W+qxqQLvT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BzOx6OsV; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B405C1F000E9;
	Thu, 28 May 2026 20:06:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779998783;
	bh=Ja8KNspkCtIuhOl1+NHUsW+vaAPu3TD25x/vaVEqFCw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BzOx6OsVF0p+EBLI6OCaE/cMaf16sZlh4uYVZAYJ9kQiFG7AXCKyIaY3N7LGVtDcG
	 LNE8GLoJUhyiSwJAsCG/lTDPOdr6rAYTIF94YwvcEibwnymwtfFhQ0XUjwtYDyOwkU
	 Z2RAqLi+w1Rf4QGJGB5ujtce5N1U2mQMmvRPdOqo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 296/461] drm/msm/dsi: dont dump registers past the mapped region
Date: Thu, 28 May 2026 21:47:05 +0200
Message-ID: <20260528194655.786308690@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528194646.819809818@linuxfoundation.org>
References: <20260528194646.819809818@linuxfoundation.org>
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
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-255393-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linuxfoundation.org:mid,linuxfoundation.org:dkim,patchwork.freedesktop.org:url,qualcomm.com:email]
X-Rspamd-Queue-Id: 9B92E5F8387
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

[ Upstream commit 5b49a46baa853b26dbefa65c6c75dd9ff69f63d4 ]

On DSI 6G platforms the IO address space is internally adjusted by
io_offset. Later this adjusted address might be used for memory dumping.
However the size that is used for memory dumping isn't adjusted to
account for the io_offset, leading to the potential access to the
unmapped region. Lower ctrl_size by the io_offset value to prevent
access past the mapped area.

 msm_disp_snapshot_add_block+0x1d4/0x3c8 [msm] (P)
 msm_dsi_host_snapshot+0x4c/0x78 [msm]
 msm_dsi_snapshot+0x28/0x50 [msm]
 msm_disp_snapshot_capture_state+0x74/0x140 [msm]
 msm_disp_snapshot_state_sync+0x60/0x90 [msm]
 _msm_disp_snapshot_work+0x30/0x90 [msm]
 kthread_worker_fn+0xdc/0x460
 kthread+0x120/0x140

Fixes: bac2c6a62ed9 ("drm/msm: get rid of msm_iomap_size")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Patchwork: https://patchwork.freedesktop.org/patch/721747/
Link: https://lore.kernel.org/r/20260428-msm-fix-dsi-dump-v1-1-5d4cb5ccfac7@oss.qualcomm.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/msm/dsi/dsi_host.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c b/drivers/gpu/drm/msm/dsi/dsi_host.c
index 1c0841a1c1013..50474c994d473 100644
--- a/drivers/gpu/drm/msm/dsi/dsi_host.c
+++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
@@ -2003,6 +2003,7 @@ int msm_dsi_host_init(struct msm_dsi *msm_dsi)
 
 	/* fixup base address by io offset */
 	msm_host->ctrl_base += cfg->io_offset;
+	msm_host->ctrl_size -= cfg->io_offset;
 
 	ret = devm_regulator_bulk_get_const(&pdev->dev, cfg->num_regulators,
 					    cfg->regulator_data,
-- 
2.53.0




