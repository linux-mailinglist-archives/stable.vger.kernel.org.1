Return-Path: <stable+bounces-219564-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MAWtCbOhnmlPWgQAu9opvQ
	(envelope-from <stable+bounces-219564-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 08:16:03 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E3C419327B
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 08:16:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 146BB323DB82
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 07:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2D23313E10;
	Wed, 25 Feb 2026 06:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vb2GHDLO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B9C3081C2;
	Wed, 25 Feb 2026 06:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772002799; cv=none; b=qNzKnyUz/AiRiaLpszTWWTUvHDlRjlmEZUu0jpwhBqacP2ki2c/uyz18pG+I5iTqSBiPsWISiQUiIHY8ZGj+D6DA6FnRd/k34DH+t2eqizP16f5cwYdd0AR/3fcBkpkwBJncVEMLHGjYR6RzNxIOQQHWYsXED6/Mon/Ba0VSAxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772002799; c=relaxed/simple;
	bh=QwFOFaceIQU9Bbw+c3IEKYrHx/490C0httbAe+SI+yQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ESXsCuzhxzUxpJB7jX5bfJtLlAEpE3C33Y1c1JzKBxfiJsRLZSlum0mdKNdDZZhcRm7xmjefEk8aRYpGIif5AfrvdNJIcdyxVCyuTCmmOn3fV9GSBeppbR/cnQJgfL8IhSZO3V0kyW3D9cHMpMgHhepW1vrSrSKVwEFPYiWP+5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vb2GHDLO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50B4CC19422;
	Wed, 25 Feb 2026 06:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1772002799;
	bh=QwFOFaceIQU9Bbw+c3IEKYrHx/490C0httbAe+SI+yQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vb2GHDLO6SF9B9r/x7o5JE3G8n+vp/rLq6l40mJbMBoGYa51rb5JR2XYZuuDQYq/r
	 A4DEIWzpMobh8OcXyE7sKtGGSQPXCwOwCLsnyOJ6xXGrqUz/tb2TaE9C4FsAqYpDQS
	 X52c6wQjENDWlh6i5sIw1dCLPjujwqB68bPiW2d4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Michal Wajdeczko <michal.wajdeczko@intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Shuicheng Lin <shuicheng.lin@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 595/641] drm/xe/configfs: Fix parameter name omitted errors
Date: Tue, 24 Feb 2026 17:25:21 -0800
Message-ID: <20260225012402.931674614@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-219564-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:mid,linuxfoundation.org:dkim,msgid.link:url,intel.com:email]
X-Rspamd-Queue-Id: 1E3C419327B
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michal Wajdeczko <michal.wajdeczko@intel.com>

[ Upstream commit 2a673fb4d787ce6672862cb693112378bff86abb ]

On some configs and old compilers we can get following build errors:

  ../drivers/gpu/drm/xe/xe_configfs.h: In function 'xe_configfs_get_ctx_restore_mid_bb':
  ../drivers/gpu/drm/xe/xe_configfs.h:40:76: error: parameter name omitted
   static inline u32 xe_configfs_get_ctx_restore_mid_bb(struct pci_dev *pdev, enum xe_engine_class,
                                                                            ^~~~~~~~~~~~~~~~~~~~
  ../drivers/gpu/drm/xe/xe_configfs.h: In function 'xe_configfs_get_ctx_restore_post_bb':
  ../drivers/gpu/drm/xe/xe_configfs.h:42:77: error: parameter name omitted
   static inline u32 xe_configfs_get_ctx_restore_post_bb(struct pci_dev *pdev, enum xe_engine_class,
                                                                             ^~~~~~~~~~~~~~~~~~~~
when trying to define our configfs stub functions. Fix that.

Fixes: 7a4756b2fd04 ("drm/xe/lrc: Allow to add user commands mid context switch")
Signed-off-by: Michal Wajdeczko <michal.wajdeczko@intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Reviewed-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Reviewed-by: Shuicheng Lin <shuicheng.lin@intel.com>
Link: https://patch.msgid.link/20260203193745.576-1-michal.wajdeczko@intel.com
(cherry picked from commit f59cde8a2452b392115d2af8f1143a94725f4827)
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/xe/xe_configfs.h | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_configfs.h b/drivers/gpu/drm/xe/xe_configfs.h
index c61e0e47ed94c..08cce375ae0f3 100644
--- a/drivers/gpu/drm/xe/xe_configfs.h
+++ b/drivers/gpu/drm/xe/xe_configfs.h
@@ -19,9 +19,11 @@ void xe_configfs_check_device(struct pci_dev *pdev);
 bool xe_configfs_get_survivability_mode(struct pci_dev *pdev);
 u64 xe_configfs_get_engines_allowed(struct pci_dev *pdev);
 bool xe_configfs_get_psmi_enabled(struct pci_dev *pdev);
-u32 xe_configfs_get_ctx_restore_mid_bb(struct pci_dev *pdev, enum xe_engine_class,
+u32 xe_configfs_get_ctx_restore_mid_bb(struct pci_dev *pdev,
+				       enum xe_engine_class class,
 				       const u32 **cs);
-u32 xe_configfs_get_ctx_restore_post_bb(struct pci_dev *pdev, enum xe_engine_class,
+u32 xe_configfs_get_ctx_restore_post_bb(struct pci_dev *pdev,
+					enum xe_engine_class class,
 					const u32 **cs);
 #else
 static inline int xe_configfs_init(void) { return 0; }
@@ -30,9 +32,11 @@ static inline void xe_configfs_check_device(struct pci_dev *pdev) { }
 static inline bool xe_configfs_get_survivability_mode(struct pci_dev *pdev) { return false; }
 static inline u64 xe_configfs_get_engines_allowed(struct pci_dev *pdev) { return U64_MAX; }
 static inline bool xe_configfs_get_psmi_enabled(struct pci_dev *pdev) { return false; }
-static inline u32 xe_configfs_get_ctx_restore_mid_bb(struct pci_dev *pdev, enum xe_engine_class,
+static inline u32 xe_configfs_get_ctx_restore_mid_bb(struct pci_dev *pdev,
+						     enum xe_engine_class class,
 						     const u32 **cs) { return 0; }
-static inline u32 xe_configfs_get_ctx_restore_post_bb(struct pci_dev *pdev, enum xe_engine_class,
+static inline u32 xe_configfs_get_ctx_restore_post_bb(struct pci_dev *pdev,
+						      enum xe_engine_class class,
 						      const u32 **cs) { return 0; }
 #endif
 
-- 
2.51.0




