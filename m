Return-Path: <stable+bounces-232227-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +BC1KPkFzGljNQYAu9opvQ
	(envelope-from <stable+bounces-232227-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 19:35:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D59636EF61
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 19:35:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8304832A1418
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 16:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19C3D3F7867;
	Tue, 31 Mar 2026 16:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YspkhhuJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C5129DB8F;
	Tue, 31 Mar 2026 16:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774976204; cv=none; b=IDnZbBHKeHBFtMqP4guUXcV4te57qBavhszNwOYINsQphm4UGHO5KHEtEvmuW+cPr51bKNeKy9LmZB42OxcDVNZ/gzHVrXRXBKIJms3hcWWKdc1cjUQ7UkjhJa2F55e0GKoueQc+WF9FSDOsd/eQNiJTCH/1TdBxCELC0An1tBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774976204; c=relaxed/simple;
	bh=XaYACKJA/3m0KmXe1BD3LVJZM2BzT6VVrnRslHzkcXk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SlgCoSr4CKJOmmquxfMFrewfgpgkWkmCbsrCkclaY2rDVVurTqulKEK1+CeO3pL9l8NTcG9ciu/iYJovxPJ92chvo42Tc/BXq3H0t7DIhrPkHBV/+QrzKausbK9ocbNEN5f3Uk8eXSKxSHGaQG9eRfNG6QlW7C/nBVHayEcGihk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YspkhhuJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66721C19423;
	Tue, 31 Mar 2026 16:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774976204;
	bh=XaYACKJA/3m0KmXe1BD3LVJZM2BzT6VVrnRslHzkcXk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YspkhhuJ0PsvehTl9dEveQg3wOliz42t6L2E9hixnibSRNmPKPu/2gC869dahSCCl
	 lmMUY1NLAVAngZgj5j9RK61crxUcvFqqMjwEvLPL0DrsuH4fuNyiuiwgqJh+nsu/eW
	 cgqydkaRGXyFqrXfyW5ekPNJTf//NjaDayTOCLMc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: [PATCH 6.12 215/244] landlock: Optimize file path walks and prepare for audit support
Date: Tue, 31 Mar 2026 18:22:45 +0200
Message-ID: <20260331161749.703085348@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331161741.651718120@linuxfoundation.org>
References: <20260331161741.651718120@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-232227-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4D59636EF61
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mickaël Salaün <mic@digikod.net>

[ Upstream commit d617f0d72d8041c7099fd04a62db0f0fa5331c1a ]

Always synchronize access_masked_parent* with access_request_parent*
according to allowed_parent*.  This is required for audit support to be
able to get back to the reason of denial.

In a rename/link action, instead of always checking a rule two times for
the same parent directory of the source and the destination files, only
check it when an action on a child was not already allowed.  This also
enables us to keep consistent allowed_parent* status, which is required
to get back to the reason of denial.

For internal mount points, only upgrade allowed_parent* to true but do
not wrongfully set both of them to false otherwise.  This is also
required to get back to the reason of denial.

This does not impact the current behavior but slightly optimize code and
prepare for audit support that needs to know the exact reason why an
access was denied.

Cc: Günther Noack <gnoack@google.com>
Link: https://lore.kernel.org/r/20250108154338.1129069-14-mic@digikod.net
Signed-off-by: Mickaël Salaün <mic@digikod.net>
(cherry picked from commit d617f0d72d8041c7099fd04a62db0f0fa5331c1a)
Stable-dep-of: 49c9e09d9610 ("landlock: Fix handling of disconnected directories")
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 security/landlock/fs.c |   44 +++++++++++++++++++++++++++-----------------
 1 file changed, 27 insertions(+), 17 deletions(-)

--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -849,15 +849,6 @@ static bool is_access_to_paths_allowed(
 				     child1_is_directory, layer_masks_parent2,
 				     layer_masks_child2,
 				     child2_is_directory))) {
-			allowed_parent1 = scope_to_request(
-				access_request_parent1, layer_masks_parent1);
-			allowed_parent2 = scope_to_request(
-				access_request_parent2, layer_masks_parent2);
-
-			/* Stops when all accesses are granted. */
-			if (allowed_parent1 && allowed_parent2)
-				break;
-
 			/*
 			 * Now, downgrades the remaining checks from domain
 			 * handled accesses to requested accesses.
@@ -865,15 +856,32 @@ static bool is_access_to_paths_allowed(
 			is_dom_check = false;
 			access_masked_parent1 = access_request_parent1;
 			access_masked_parent2 = access_request_parent2;
+
+			allowed_parent1 =
+				allowed_parent1 ||
+				scope_to_request(access_masked_parent1,
+						 layer_masks_parent1);
+			allowed_parent2 =
+				allowed_parent2 ||
+				scope_to_request(access_masked_parent2,
+						 layer_masks_parent2);
+
+			/* Stops when all accesses are granted. */
+			if (allowed_parent1 && allowed_parent2)
+				break;
 		}
 
 		rule = find_rule(domain, walker_path.dentry);
-		allowed_parent1 = landlock_unmask_layers(
-			rule, access_masked_parent1, layer_masks_parent1,
-			ARRAY_SIZE(*layer_masks_parent1));
-		allowed_parent2 = landlock_unmask_layers(
-			rule, access_masked_parent2, layer_masks_parent2,
-			ARRAY_SIZE(*layer_masks_parent2));
+		allowed_parent1 = allowed_parent1 ||
+				  landlock_unmask_layers(
+					  rule, access_masked_parent1,
+					  layer_masks_parent1,
+					  ARRAY_SIZE(*layer_masks_parent1));
+		allowed_parent2 = allowed_parent2 ||
+				  landlock_unmask_layers(
+					  rule, access_masked_parent2,
+					  layer_masks_parent2,
+					  ARRAY_SIZE(*layer_masks_parent2));
 
 		/* Stops when a rule from each layer grants access. */
 		if (allowed_parent1 && allowed_parent2)
@@ -897,8 +905,10 @@ jump_up:
 			 * access to internal filesystems (e.g. nsfs, which is
 			 * reachable through /proc/<pid>/ns/<namespace>).
 			 */
-			allowed_parent1 = allowed_parent2 =
-				!!(walker_path.mnt->mnt_flags & MNT_INTERNAL);
+			if (walker_path.mnt->mnt_flags & MNT_INTERNAL) {
+				allowed_parent1 = true;
+				allowed_parent2 = true;
+			}
 			break;
 		}
 		parent_dentry = dget_parent(walker_path.dentry);



