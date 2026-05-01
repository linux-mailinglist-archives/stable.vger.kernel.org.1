Return-Path: <stable+bounces-242556-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uPp7Eg839WkeJgIAu9opvQ
	(envelope-from <stable+bounces-242556-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 02 May 2026 01:28:15 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D0B8E4B04A8
	for <lists+stable@lfdr.de>; Sat, 02 May 2026 01:28:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5567A301B4F8
	for <lists+stable@lfdr.de>; Fri,  1 May 2026 23:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1505B37F74B;
	Fri,  1 May 2026 23:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dDyZdZPp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA5092F12AD
	for <stable@vger.kernel.org>; Fri,  1 May 2026 23:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777678067; cv=none; b=TC8wqAnWhmiiUxm8IPGxqS+DdX5t29aB/jQePAF3Le8mmi2kt2fucB/NcSgz/NFy0NHdmE1Jv2qsrvGYIXB3xI3rt8mLdcZYTnbF08tKYa43nvdQacUk3s2tNQ1keic5XgU1h9PExHQ2rxfMiwZuJd5/ZzJMfPCwHfL42OEq/7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777678067; c=relaxed/simple;
	bh=ddut6ESxLW4BoIZEJJoMl9OrOT/bwlLXIyH6CKRPLcg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k2zC/G6+hc/Lvvf/l1v3zI4k/SlJFellfy7upfhSt8LJheKj/y0d5/sYpsnwJQT63tyE5bWhraQtrnEWLTlrnHvm3KysmzTj8tBxvMMBiEAEQRLXja5vD8t3DlNUo86GzjhwOChuhG1Uxq5cIt0IoVuZ84N4V7BsBdtlQK48S7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dDyZdZPp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BCAAC2BCC6;
	Fri,  1 May 2026 23:27:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777678067;
	bh=ddut6ESxLW4BoIZEJJoMl9OrOT/bwlLXIyH6CKRPLcg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dDyZdZPpwc380tIUaDYsVoi8BRwSEg3sp8+08wQ7f6pY9ukU8ikZ/sOQO3wIC3Kdn
	 yXzn3yddX/y/u40yG/IaVopbvRf5AXr24AYxDlVzR4V0mQ3xCwevXhiWj/H7hE6kFO
	 /DTEzQr+KOemhqUPnWiV79UB3zjFnML/y4JWXbUi1gwLXUz3MvSrfOca+JFEpYxdHV
	 6vKaouAIjgdbrrz2+TRymr+2K7ZbhMemukBJALjaP0yWKmpvwgDkevxIIghBBkButj
	 MCfzfQboRygPpYim3LH2pLki7LlPsraIqK/RHauefCECgUcDvePf/LwVF9ueMNcWid
	 LmXtsWH6KVeDQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Robert Beckett <bob.beckett@collabora.com>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/2] nvme: respect NVME_QUIRK_DISABLE_WRITE_ZEROES when wzsl is set
Date: Fri,  1 May 2026 19:27:44 -0400
Message-ID: <20260501232744.4102493-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260501232744.4102493-1-sashal@kernel.org>
References: <2026050133-dipped-hedge-8292@gregkh>
 <20260501232744.4102493-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D0B8E4B04A8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-242556-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_HAS_DN(0.00)[]

From: Robert Beckett <bob.beckett@collabora.com>

[ Upstream commit 40f0496b617b431f8d2dd94d7f785c1121f8a68a ]

The NVM Command Set Identify Controller data may report a non-zero
Write Zeroes Size Limit (wzsl). When present, nvme_init_non_mdts_limits()
unconditionally overrides max_zeroes_sectors from wzsl, even if
NVME_QUIRK_DISABLE_WRITE_ZEROES previously set it to zero.

This effectively re-enables write zeroes for devices that need it
disabled, defeating the quirk. Several Kingston OM* drives rely on
this quirk to avoid firmware issues with write zeroes commands.

Check for the quirk before applying the wzsl override.

Fixes: 5befc7c26e5a ("nvme: implement non-mdts command limits")
Cc: stable@vger.kernel.org
Signed-off-by: Robert Beckett <bob.beckett@collabora.com>
Assisted-by: claude-opus-4-6-v1
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 1e0a7baa77f56..f9aeacec7e10d 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2952,7 +2952,7 @@ static int nvme_init_non_mdts_limits(struct nvme_ctrl *ctrl)
 	if (id->dmrl)
 		ctrl->max_discard_segments = id->dmrl;
 	ctrl->dmrsl = le32_to_cpu(id->dmrsl);
-	if (id->wzsl)
+	if (id->wzsl && !(ctrl->quirks & NVME_QUIRK_DISABLE_WRITE_ZEROES))
 		ctrl->max_zeroes_sectors = nvme_mps_to_sectors(ctrl, id->wzsl);
 
 free_data:
-- 
2.53.0


