Return-Path: <stable+bounces-234886-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QMrwMZOj1mlUGwgAu9opvQ
	(envelope-from <stable+bounces-234886-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:50:59 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 68AF93C1C12
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:50:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F22F130B5A8D
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 18:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C58E82727F3;
	Wed,  8 Apr 2026 18:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UFjVQ7aC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861FF3D9050;
	Wed,  8 Apr 2026 18:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775674017; cv=none; b=tyyhcQFKbgGoCV32ZE5/VLkVGIUIcdfOKfSmXGTDGYXu1F5/uwyGKVIj840pD46Qg2p9/yZb3ucJYQItD4aVfVP1hFv4/D7rTZkhhQliyIwIWAsA9y9MXbEFW+Dgtz+lXogelRsvGEtvWyUKKuLVoNpIgqtlEIs1x754BhqOEXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775674017; c=relaxed/simple;
	bh=WW/ruh3r+WCkc2bsZ6hzmsV5iQ9CyCFVJVEVb6CH2jQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ttvktm7db8zT3D/uJE3h2amzxG7GK3fQ3qRRDvcOEspzi0qEzh/fI50FvIecBjWk4V+qm6MFGywR99AHLbCQt3d8BgDRLco+ksuTOFnuZDa17doTh6AMJeVsgn+9de7d6xxgr4R6F6+/iSft1w83bzzyclrF4G3G/vF1997eoQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UFjVQ7aC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19AC1C19421;
	Wed,  8 Apr 2026 18:46:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775674017;
	bh=WW/ruh3r+WCkc2bsZ6hzmsV5iQ9CyCFVJVEVb6CH2jQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UFjVQ7aCARgpKWfK7bUIRA+5/ENO1TYf50IQ8iQ4jbDY1TMHrHpHx5uIyUZWhTanm
	 jcjIlJWnUG0BashBk2fqg+Hga2oczhYfjifEO3L+VdOsx9CmYsklwFb8FXajZKVcQO
	 NqBW3adyYe9pmNwBjBuAr+IXlwSNvyr6eDytjjas=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yang Wang <kevinyang.wang@amd.com>,
	Lijo Lazar <lijo.lazar@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6.12 139/242] drm/amdgpu/pm: drop SMU driver if version not matched messages
Date: Wed,  8 Apr 2026 20:02:59 +0200
Message-ID: <20260408175932.290911556@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408175927.064985309@linuxfoundation.org>
References: <20260408175927.064985309@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-234886-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,amd.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 68AF93C1C12
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alex Deucher <alexander.deucher@amd.com>

commit a3ffaa5b397f4df9d6ac16b10583e9df8e6fa471 upstream.

It just leads to user confusion.

Cc: Yang Wang <kevinyang.wang@amd.com>
Cc: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Yang Wang <kevinyang.wang@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit e471627d56272a791972f25e467348b611c31713)
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c |    1 -
 drivers/gpu/drm/amd/pm/swsmu/smu12/smu_v12_0.c |    1 -
 drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c |    1 -
 3 files changed, 3 deletions(-)

--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -260,7 +260,6 @@ int smu_v11_0_check_fw_version(struct sm
 			"smu fw program = %d, version = 0x%08x (%d.%d.%d)\n",
 			smu->smc_driver_if_version, if_version,
 			smu_program, smu_version, smu_major, smu_minor, smu_debug);
-		dev_info(smu->adev->dev, "SMU driver if version not matched\n");
 	}
 
 	return ret;
--- a/drivers/gpu/drm/amd/pm/swsmu/smu12/smu_v12_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/smu_v12_0.c
@@ -101,7 +101,6 @@ int smu_v12_0_check_fw_version(struct sm
 			"smu fw program = %d, smu fw version = 0x%08x (%d.%d.%d)\n",
 			smu->smc_driver_if_version, if_version,
 			smu_program, smu_version, smu_major, smu_minor, smu_debug);
-		dev_info(smu->adev->dev, "SMU driver if version not matched\n");
 	}
 
 	return ret;
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
@@ -277,7 +277,6 @@ int smu_v14_0_check_fw_version(struct sm
 			 "smu fw program = %d, smu fw version = 0x%08x (%d.%d.%d)\n",
 			 smu->smc_driver_if_version, if_version,
 			 smu_program, smu_version, smu_major, smu_minor, smu_debug);
-		dev_info(adev->dev, "SMU driver if version not matched\n");
 	}
 
 	return ret;



