Return-Path: <stable+bounces-212510-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +KSYBlIyeml+4gEAu9opvQ
	(envelope-from <stable+bounces-212510-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 16:59:14 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F5AFA4E06
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 16:59:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 93E7830302D5
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 15:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04DD83054D8;
	Wed, 28 Jan 2026 15:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tPQ0Jhvj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE5618027;
	Wed, 28 Jan 2026 15:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769615759; cv=none; b=RE5aRQ/5jwYwhGNo+iBN4/c85OIDHA2Xh20SPqVQ7rsf4VrkNlTg8ri8CMOYnpIG3aFfYI5yC9mXECZKPq1uedP0ojX9K6A6IhOENGI9/2AMqcPkmFxdZw3tQCVDv9I1h3YcCb8kRZ2V6B1mR5SlhsGRDEjzvzawrtXVFeNkWdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769615759; c=relaxed/simple;
	bh=E1ytv3ewkcJ/7wwc9i5XRzraoMOoAwIRgbKlbRYKjbU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=njzLgsKrUC5TYOCqWihfK+R03sXQbfqhkf1Re76pdzBdAs3xP7o1tnJwcWfielQcS9JOsrfioLAbDiIdUKxdGQYn2tAj51a+90uHRUvsxG6GvHpd0MMouUfPCLisZaWH1rhdOss+53uBIlV6M2V0seCKeiJYdGwwU04DChYEjnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tPQ0Jhvj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6C1AC4CEF1;
	Wed, 28 Jan 2026 15:55:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769615759;
	bh=E1ytv3ewkcJ/7wwc9i5XRzraoMOoAwIRgbKlbRYKjbU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tPQ0JhvjIyH/J5k6d9A6CYRiWVacshhID7QwYQiHtNKUXiLhZFsAwfDOavvCH+q/B
	 4J/0Td4MW5bXQVK9FrTjWJgsvVaXp/BQSPqqpEMMR49VRSBfs0OvPqWt/CFjxl8i0R
	 98gXS51EdLmdveVhwTb0JC+ERxYdVrDp2S2lNmkA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Matt Roper <matthew.d.roper@intel.com>,
	Jani Nikula <jani.nikula@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 098/227] drm/xe/vm: fix xe_vm_validation_exec() kernel-doc
Date: Wed, 28 Jan 2026 16:22:23 +0100
Message-ID: <20260128145347.992422379@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260128145344.331957407@linuxfoundation.org>
References: <20260128145344.331957407@linuxfoundation.org>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_FROM(0.00)[bounces-212510-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 8F5AFA4E06
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jani Nikula <jani.nikula@intel.com>

[ Upstream commit 47bf28e22a121b807a9a9680c4209846a78a98a6 ]

Fix kernel-doc warnings on xe_vm_validation_exec():

Warning: ../drivers/gpu/drm/xe/xe_vm.h:392 expecting prototype for
  xe_vm_set_validation_exec(). Prototype was for xe_vm_validation_exec()
  instead

Fixes: 0131514f9789 ("drm/xe: Pass down drm_exec context to validation")
Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Reviewed-by: Matt Roper <matthew.d.roper@intel.com>
Link: https://patch.msgid.link/20260107155401.2379127-4-jani.nikula@intel.com
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
(cherry picked from commit b3a7767989e6519127ac5e0cde682c50ad587f3b)
Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/xe/xe_vm.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/xe_vm.h b/drivers/gpu/drm/xe/xe_vm.h
index ef8a5019574e6..016f6786134cb 100644
--- a/drivers/gpu/drm/xe/xe_vm.h
+++ b/drivers/gpu/drm/xe/xe_vm.h
@@ -379,7 +379,7 @@ static inline void xe_vm_set_validation_exec(struct xe_vm *vm, struct drm_exec *
 }
 
 /**
- * xe_vm_set_validation_exec() - Accessor to read the drm_exec object
+ * xe_vm_validation_exec() - Accessor to read the drm_exec object
  * @vm: The vm we want to register a drm_exec object with.
  *
  * Return: The drm_exec object used to lock the vm's resv. The value
-- 
2.51.0




