Return-Path: <stable+bounces-219541-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uKHgFZeenmkZWgQAu9opvQ
	(envelope-from <stable+bounces-219541-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 08:02:47 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EBE2B192CF2
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 08:02:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2D4F2306CDE0
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 07:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85EA03254AF;
	Wed, 25 Feb 2026 06:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QjWdvJ+G"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4520530EF63;
	Wed, 25 Feb 2026 06:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772002784; cv=none; b=E2lIpR7vPxrKvpzfuc8uy4dhfrUJzrJ4vL8GdDav5HCvDwUJNnbSxuF9rZYZgWZD5yrEOJe6fI9CIM9mVoZekm/s2gwp5+Du77EuU2I+ZEzbSQPa/ajGd+bbXX8xC+JGn9IEQq3fLVYznm//UF2CJngC8buBtUDpOM7Uu1cVcQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772002784; c=relaxed/simple;
	bh=vJsAmlsmriuvm+avo0oZ6qOBOr4qz4c8+uWKtWIL9fk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U+SD7OqesmYByCAABfyrQXz1L2qTIUhF4BenyGNBlce7tD66I00vCKzO7F1HhrVeyKehRi9lsr30pC5lVdep7PqAOXXxP9L8xiibKXpsmJovtdkElfYulJcPFhq7m2TZMBmtEz/mH6WDH0YFalQJaDLwvKbH+eKdIBKKO6pVFFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QjWdvJ+G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EBB7C116D0;
	Wed, 25 Feb 2026 06:59:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1772002784;
	bh=vJsAmlsmriuvm+avo0oZ6qOBOr4qz4c8+uWKtWIL9fk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QjWdvJ+Gc0FTRtz6K+WZ7vDTxi1ERWpafNFUdNpItoMYiEtVL1lmlnF5J+zrPL3R1
	 eP8V6R4+kn6W34hoaYr2aXLl2w3tJRVc0haem9J6RWpQN4bkz6W/libOWGvVaj+qAm
	 BInxkLYSbmpE2AFrHhiv16a37YclkYn+mS0s2Vzk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Michal Wajdeczko <michal.wajdeczko@intel.com>,
	Shuicheng Lin <shuicheng.lin@intel.com>,
	Matt Roper <matthew.d.roper@intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 598/641] drm/xe: Make xe_modparam.force_vram_bar_size signed
Date: Tue, 24 Feb 2026 17:25:24 -0800
Message-ID: <20260225012403.006346451@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225012348.915798704@linuxfoundation.org>
References: <20260225012348.915798704@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-219541-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linuxfoundation.org:mid,linuxfoundation.org:dkim,intel.com:email,msgid.link:url]
X-Rspamd-Queue-Id: EBE2B192CF2
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shuicheng Lin <shuicheng.lin@intel.com>

[ Upstream commit 1acec6ef0511b92e7974cc5a8768bfd3a659feaf ]

vram_bar_size is registered as an int module parameter and is documented
to accept negative values to disable BAR resizing.
Store it as an int in xe_modparam as well, so negative values work as
intended and the module_param type matches.

Fixes: 80742a1aa26e ("drm/xe: Allow to drop vram resizing")
Reviewed-by: Michal Wajdeczko <michal.wajdeczko@intel.com>
Signed-off-by: Shuicheng Lin <shuicheng.lin@intel.com>
Link: https://patch.msgid.link/20260202181853.1095736-2-shuicheng.lin@intel.com
Signed-off-by: Matt Roper <matthew.d.roper@intel.com>
(cherry picked from commit 25c9aa4dcb5ef2ad9f354d19f8f1eeb690d1c161)
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/xe/xe_module.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/xe_module.h b/drivers/gpu/drm/xe/xe_module.h
index 5a3bfea8b7b4c..b668495392701 100644
--- a/drivers/gpu/drm/xe/xe_module.h
+++ b/drivers/gpu/drm/xe/xe_module.h
@@ -12,7 +12,7 @@
 struct xe_modparam {
 	bool force_execlist;
 	bool probe_display;
-	u32 force_vram_bar_size;
+	int force_vram_bar_size;
 	int guc_log_level;
 	char *guc_firmware_path;
 	char *huc_firmware_path;
-- 
2.51.0




