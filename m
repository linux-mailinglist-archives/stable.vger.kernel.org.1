Return-Path: <stable+bounces-251444-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gN7RM88aDmpT6AUAu9opvQ
	(envelope-from <stable+bounces-251444-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 22:34:23 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DC1B599C9B
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 22:34:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 756FB32D2FBA
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD2043F4124;
	Wed, 20 May 2026 17:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2XUziq6v"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794B430BF68;
	Wed, 20 May 2026 17:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779297997; cv=none; b=OKwEhJY4xH36ux9K5ukYl0vP94RknsQouHSq1cKoReiJHYoB5NAkYGlXUlHXSPNjCZ5Y45R4kjGhSnp2LQwnOdr5cboKAR8CdFEgKTHHcWOAlXuOGrErXazPeqQkX0fsH/uQglQDxyFAQD/cHOY2KPGzOk57emyoG6LTrpX6a1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779297997; c=relaxed/simple;
	bh=HvpujqBfulUjRidpgCbDzQbU6uIoee0Y/ANg3Q6KS/k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kxvRsLYPWEIgyqbqJvlr0siT/xQ0nFMfz6pNt1AxiT6HDhL53ZFtwsg6Toozj4yBtvbPau8NNaqchA8DQlJWpi5MJuFlmIKtfmNsKLh1JAJYiKsWySeOcTKvrY04EiiZJX//1hw40yHWnhNmXtvgYmi1ooQhehSXXsD5TOA/dhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2XUziq6v; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF41D1F000E9;
	Wed, 20 May 2026 17:26:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779297996;
	bh=CF1SMEErsPMbNb3PISXdw2fh1DF98BNKAZKNYkYvSZo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=2XUziq6vpRqnUI0jdAy9mIrWjVpwgWJ9rgUTM8G2UPw1nh37cnoOfFqmHH/6Esi5P
	 McnJP0y1bfrgHcp1It2436Swci8iPInncVIn3hdFKPeXY58GzmFVjkJ1CTp15o6gnw
	 5kx0ap7XMqHJvO1cLVFcQDkcfp62sqfDjojf0JVI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	kernel test robot <lkp@intel.com>,
	Pengyu Luo <mitltlatltl@gmail.com>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 243/957] drm/msm/dsi: add the missing parameter description
Date: Wed, 20 May 2026 18:12:06 +0200
Message-ID: <20260520162139.812949786@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162134.554764788@linuxfoundation.org>
References: <20260520162134.554764788@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-251444-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,intel.com,gmail.com,oss.qualcomm.com,kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linuxfoundation.org:mid,linuxfoundation.org:dkim,qualcomm.com:email]
X-Rspamd-Queue-Id: 3DC1B599C9B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pengyu Luo <mitltlatltl@gmail.com>

[ Upstream commit 958adefc4c0fddee3b12269da5dd7cb49bac953f ]

Add a description for is_bonded_dsi in dsi_adjust_pclk_for_compression
to match the existing kernel-doc comment.

Fixes: e4eb11b34d6c ("drm/msm/dsi: fix pclk rate calculation for bonded dsi")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202603080314.XeqyRZ7A-lkp@intel.com/
Signed-off-by: Pengyu Luo <mitltlatltl@gmail.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Patchwork: https://patchwork.freedesktop.org/patch/710112/
Link: https://lore.kernel.org/r/20260309100254.877801-1-mitltlatltl@gmail.com
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/msm/dsi/dsi_host.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c b/drivers/gpu/drm/msm/dsi/dsi_host.c
index db6da99375a18..6cb634590e7a7 100644
--- a/drivers/gpu/drm/msm/dsi/dsi_host.c
+++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
@@ -569,6 +569,7 @@ void dsi_link_clk_disable_v2(struct msm_dsi_host *msm_host)
  * dsi_adjust_pclk_for_compression() - Adjust the pclk rate for compression case
  * @mode: The selected mode for the DSI output
  * @dsc: DRM DSC configuration for this DSI output
+ * @is_bonded_dsi: True if two DSI controllers are bonded
  *
  * Adjust the pclk rate by calculating a new hdisplay proportional to
  * the compression ratio such that:
-- 
2.53.0




