Return-Path: <stable+bounces-258614-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6EEfB1UpG2rg/ggAu9opvQ
	(envelope-from <stable+bounces-258614-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 20:15:49 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id DB9866115F5
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 20:15:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 312A9300CEA9
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 18:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A963E32F770;
	Sat, 30 May 2026 18:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sOCqNkEj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8799A241C8C;
	Sat, 30 May 2026 18:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780164944; cv=none; b=MPPnFhZklsPsT0Tia5E468fy6vqAJWNPyM4D6dJpFgJeLb7A9TE/N1vQl81pV3MyYNwXoe2nCjCQdcsIYzCuBcuv+sRubj9SGbL19RIoLErc6bmhHaJCPv75JbEfNKaxRi+vnvQ0T8ecpFvv9zj9dlGdSPPLKTVOiEcQDCTWe6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780164944; c=relaxed/simple;
	bh=pcA4oiPPfShkctxcMmOvpJqO8Paugq+Y/XCIYS3SAj4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P6LfSPX19s2yLQN6BVEtKzq537q2hVUZnKXJBc46HhAsUBomgXv/SyVkQGGfw/Ifw2aYxn6RzsvoxSKPuL3G/n+zWUNRXPR4F2dLvxPZHthX0WdmzEF4uzIl1FIglK8PrJXLqkTkPt7bGRbAddm82LNlECrpaUBPAZhbaHl+vY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sOCqNkEj; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DE651F00893;
	Sat, 30 May 2026 18:15:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780164943;
	bh=12Q7nTRWO/j79iEkrzm5OkOykMF6NLZsqlK26MIVYk4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=sOCqNkEjm1IEDj4RpSy4zsvqnrdfc/yrFKSX9tpck3pcYx9aNs7Hh0H6djiMASEcy
	 OdhVSyY37Lc8kHd3XGi3id9N8F+zJjFOnfbKlkkJmCllD4zwGeQ0FA5shzmE2Nkj9b
	 rkK0zcupl6PkPHnYQmtuiR/ErYWQ5MDfm43TxWUQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Alex Hung <alex.hung@amd.com>,
	Harry Wentland <harry.wentland@amd.com>,
	Ivan Lipski <ivan.lipski@amd.com>,
	Dan Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 5.15 704/776] drm/amd/display: Fix integer overflow in bios_get_image()
Date: Sat, 30 May 2026 18:06:58 +0200
Message-ID: <20260530160258.038540378@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530160240.228940103@linuxfoundation.org>
References: <20260530160240.228940103@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258614-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,amd.com:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: DB9866115F5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Harry Wentland <harry.wentland@amd.com>

commit cd86529ec61474a38c3837fb7823790a7c3f8cce upstream.

[Why&How]
The bounds check in bios_get_image() computes 'offset + size' using
unsigned 32-bit arithmetic before comparing against bios_size. If a
VBIOS image contains a near-UINT32_MAX offset the addition wraps to a
small value, the comparison passes, and the function returns a wild
pointer past the VBIOS mapping.

Additionally, the comparison uses '<' (strict), which incorrectly
rejects the valid exact-fit case where offset + size == bios_size.

Fix both issues by restructuring the check to avoid the addition
entirely: first reject if offset alone exceeds bios_size, then check
size against the remaining space (bios_size - offset). This eliminates
the overflow and correctly permits exact-fit accesses.

Assisted-by: GitHub Copilot:claude-opus-4.6
Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
Tested-by: Dan Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit d40fb392af659c4a02b560319f226842f6ec1a95)
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/display/dc/bios/bios_parser_helper.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

--- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser_helper.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser_helper.c
@@ -37,10 +37,13 @@ uint8_t *bios_get_image(struct dc_bios *
 	uint32_t offset,
 	uint32_t size)
 {
-	if (bp->bios && offset + size < bp->bios_size)
-		return bp->bios + offset;
-	else
+	if (!bp->bios)
 		return NULL;
+
+	if (offset > bp->bios_size || size > bp->bios_size - offset)
+		return NULL;
+
+	return bp->bios + offset;
 }
 
 #include "reg_helper.h"



