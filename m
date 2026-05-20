Return-Path: <stable+bounces-251205-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QP42F2zwDWp+4wUAu9opvQ
	(envelope-from <stable+bounces-251205-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:33:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DEA70593F1C
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:33:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 890CB31FE2D4
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 585F83F39E2;
	Wed, 20 May 2026 17:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XVVMpajV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 090D53F1ACA;
	Wed, 20 May 2026 17:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779297374; cv=none; b=Cjt5Klm04RZAjj24YdKXyQcsqkkN3H/OXukt7CDdmShEGlCpW1cQZNFbCdFgOKAzudlHjAKOUBVzswLAq4ieIP4fBFRbGopAG8oAnX3e2X/64cVTboKggNXCc9s9azrdyZGxX0mUzj3K3eXBOeMZZSqW+roBbhtoW7eVj7w+rU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779297374; c=relaxed/simple;
	bh=hs7GMuFr4b9GPYLMeoFE1MVcGyqxknMyfLaSWez8Smo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sig3dtIrjeD5HeoF8kzW3rJDTS7ghqT+UeIxWHXrui0zjZs+H2DC7Iilms10uV+YltVcGsxVs/jq08TD0AflMDlpuoW3PYPoAIS5p5KN1AYhFYlPQG3gSSxh2qP36LG+xQ6OeB15j2vWiYuc1ooCGamedIETZhmH7PJ6ve1m2MQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XVVMpajV; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 776A71F000E9;
	Wed, 20 May 2026 17:16:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779297372;
	bh=bgGVpeLlJ+jliefKfgZQg2Oex7JOn0MccuDksjXuGm0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XVVMpajVBFGyYjAkdVtQUB56kloCFhyAuHwAnxsWDTRVy32SqTdcQ0w4I+arHnSpJ
	 YDnlPvvnLOZRhhfYndfUAX0DLdCeZ09KeMxpYC7mFeNR6efCpd5hSpN0D1UN3Cy4NR
	 O5hXoxnljpoKq2Ds82kWJevkK9W8NT0zFKBOsE6g=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Huang Rui <ray.huang@amd.com>,
	Matthew Auld <matthew.auld@intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Dave Airlie <airlied@redhat.com>,
	dri-devel@lists.freedesktop.org,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
Subject: [PATCH 7.0 1132/1146] drm/ttm: Fix ttm_bo_shrink() infinite LRU walk on backup failure
Date: Wed, 20 May 2026 18:23:02 +0200
Message-ID: <20260520162213.869468449@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162148.390695140@linuxfoundation.org>
References: <20260520162148.390695140@linuxfoundation.org>
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
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-251205-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,msgid.link:url,lists.freedesktop.org:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,amd.com:email,intel.com:email]
X-Rspamd-Queue-Id: DEA70593F1C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Hellström <thomas.hellstrom@linux.intel.com>

commit 1d59f36e95f7f7134db0e313c9d787cb0adb2153 upstream.

Apply the same fix as b2ed01e7ad ("drm/ttm: Fix ttm_bo_swapout()
infinite LRU walk on swapout failure") to the ttm_bo_shrink() path.

Move del_bulk_move from before the backup to after success only,
using ttm_resource_del_bulk_move_unevictable() since the resource
is now unevictable once fully backed up.

Fixes: 70d645deac98 ("drm/ttm: Add helpers for shrinking")
Cc: Christian König <christian.koenig@amd.com>
Cc: Huang Rui <ray.huang@amd.com>
Cc: Matthew Auld <matthew.auld@intel.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Dave Airlie <airlied@redhat.com>
Cc: dri-devel@lists.freedesktop.org
Cc: stable@vger.kernel.org # v6.15+
Assisted-by: GitHub_Copilot:claude-opus-4.6
Reviewed-by: Matthew Auld <matthew.auld@intel.com>
Link: https://patch.msgid.link/20260511162443.24352-1-thomas.hellstrom@linux.intel.com
Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/ttm/ttm_bo_util.c |   11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

--- a/drivers/gpu/drm/ttm/ttm_bo_util.c
+++ b/drivers/gpu/drm/ttm/ttm_bo_util.c
@@ -1112,19 +1112,14 @@ long ttm_bo_shrink(struct ttm_operation_
 	if (lret < 0)
 		return lret;
 
-	if (bo->bulk_move) {
-		spin_lock(&bdev->lru_lock);
-		ttm_resource_del_bulk_move(bo->resource, bo);
-		spin_unlock(&bdev->lru_lock);
-	}
-
 	lret = ttm_tt_backup(bdev, bo->ttm, (struct ttm_backup_flags)
 			     {.purge = flags.purge,
 			      .writeback = flags.writeback});
 
-	if (lret <= 0 && bo->bulk_move) {
+	if (lret > 0) {
 		spin_lock(&bdev->lru_lock);
-		ttm_resource_add_bulk_move(bo->resource, bo);
+		ttm_resource_del_bulk_move_unevictable(bo->resource, bo);
+		ttm_resource_move_to_lru_tail(bo->resource);
 		spin_unlock(&bdev->lru_lock);
 	}
 



