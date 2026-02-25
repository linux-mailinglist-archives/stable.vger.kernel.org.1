Return-Path: <stable+bounces-218315-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cEwRFDdTnmm3UgQAu9opvQ
	(envelope-from <stable+bounces-218315-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:41:11 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 04CF218F72B
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:41:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6EB933195992
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 01:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C24324677D;
	Wed, 25 Feb 2026 01:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NIkFS5Dc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E406118DB2A;
	Wed, 25 Feb 2026 01:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771983118; cv=none; b=tAs+oeaY+hV65NUz27k7KVNS0RCOSh68VbsT3MJQzyil9pPPTJ3LJu/EQVZ3SnOmZgYk2+TiUKEpLszsY2DZKK50EXfOnoDbCY+KOhxGlXejVs8sFCHTP985OfcL/xvxUxzxd2COzBrIu2g9528owQVBb9f+t6JYtszuv2UWfPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771983118; c=relaxed/simple;
	bh=RiEiJ+9DEwbr6MbPAzW1LHlDvLJZ3WmOESu580ShAmU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NtbrQRtJdYtlw0mZt8UsJCBolNeb62jF5y129vFZCrCP5Z/i6v0bL7V+x/za0kK+OovNI/mUDIDNZSykdWoShVgjsb9m0v+wq2cdBgC9qcfMdE36br3F+roy/tSqhFGMsOZF9pC7SF6dSQw4O023HxPHFNi/6DsgtyTKLkKAF6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NIkFS5Dc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAC66C116D0;
	Wed, 25 Feb 2026 01:31:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771983117;
	bh=RiEiJ+9DEwbr6MbPAzW1LHlDvLJZ3WmOESu580ShAmU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NIkFS5DcMHoMvFzx3BQCtJqfHzrEl04MyVFmz0cVdm7HX0ZrBWdYdBaoZgLLKzeA8
	 GoliCskv91poVvRh1ZeYET7kRQ8N9IxP1j+OL4k4fppAOl2+BsVUJAajO4K2zzw5Q7
	 BhoLcbmIlSjtjZnuyp6tVP2rnTWdXvVOcVUOdc/o=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	kernel test robot <lkp@intel.com>,
	Lijo Lazar <lijo.lazar@amd.com>,
	Asad Kamal <asad.kamal@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 277/781] drm/amd/pm: Fix unneeded semicolon warning
Date: Tue, 24 Feb 2026 17:16:26 -0800
Message-ID: <20260225012406.490736511@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225012359.695468795@linuxfoundation.org>
References: <20260225012359.695468795@linuxfoundation.org>
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
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-218315-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:mid,linuxfoundation.org:dkim,intel.com:email]
X-Rspamd-Queue-Id: 04CF218F72B
X-Rspamd-Action: no action

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lijo Lazar <lijo.lazar@amd.com>

[ Upstream commit 05138e8ff287188be7b1bedf022c8b4fd1f09a25 ]

Fix the warning reported.
drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c:909:3-4: Unneeded semicolon

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202601182157.r1AfndME-lkp@intel.com/
Fixes: b480f573a8ab ("drm/amd/pm: Use gpu metrics 1.9 for SMUv13.0.12")
Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Asad Kamal <asad.kamal@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
index 9e635f733fbfd..370326ec65d94 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
@@ -922,7 +922,7 @@ void smu_v13_0_12_get_gpu_metrics(struct smu_context *smu, void **table,
 			gpu_metrics->gfx_below_host_limit_total_acc
 				[i] = SMUQ10_ROUND(
 				metrics->GfxclkBelowHostLimitTotalAcc[inst]);
-		};
+		}
 	}
 
 	gpu_metrics->xgmi_link_width = metrics->XgmiWidth;
-- 
2.51.0




