Return-Path: <stable+bounces-261745-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id oniTOvdNJWp3GgIAu9opvQ
	(envelope-from <stable+bounces-261745-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:54:47 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 20C3A6501DF
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:54:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=G7oNc6j6;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-261745-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-261745-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 579D53005158
	for <lists+stable@lfdr.de>; Sun,  7 Jun 2026 10:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A666F2EBB9E;
	Sun,  7 Jun 2026 10:54:41 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71FFC4204E;
	Sun,  7 Jun 2026 10:54:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780829681; cv=none; b=B1vQJdjPb1hlsMLfzPw6S1Z0Xeyx2xq+XxIIGECKZSBRq1K3yUjhIfkTCxmZQJSfxDMjbEn35prgIZ+C3wLkkdiuytaqhX0ozKj/p7E7gFrYWjvqdyK4CklA3H0FBEugf1Fq4cqlVoyWjKkIS1N5HoFxn3FTt8U1peJQCZv8Zlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780829681; c=relaxed/simple;
	bh=9a16s8HBYrstJFSCsmedexhL6YLvEQY3GHAzc0V46W0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jjj1dJECa8n8aDbKj7Sm8BOIfExodlHIqVoSgnHpmQ90l4sUBvMBQMLcZu7zaShpTFw92lTbOmAiKcTKA2KMyBI/TxejckZbrd5Krj2Ngj3vaIYDV4SE6etV+knLC8qJ7NTLL7OsD3QnTwonTGFdS2FROz7Q+ReUglp7ozZtZyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=G7oNc6j6; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA7C91F00893;
	Sun,  7 Jun 2026 10:54:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780829680;
	bh=C2aVNaRI+sKyQEEWAlV5ns+fn0d+CczpO7/HYKHEfAw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=G7oNc6j6SjeTHD3EhRokhG5a3yW6WWMseMLuegpFYEO2aSHzlVp5KbobeaOQMUSus
	 iLyf+f6Q/XT5geFe8CNIyLN+/UCphFxVDtYpVEA8JSCA5PNNTZoF1c+ybKUneTpRwN
	 AtjG5NATyvhbKeghwv5shBRFb1LtaR7FQz20fae8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Michael Bommarito <michael.bommarito@gmail.com>,
	Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6.18 270/315] drm/amdgpu: fix lock leak on ENOMEM in AMDGPU_GEM_OP_GET_MAPPING_INFO
Date: Sun,  7 Jun 2026 12:00:57 +0200
Message-ID: <20260607095737.482804556@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260607095727.528828913@linuxfoundation.org>
References: <20260607095727.528828913@linuxfoundation.org>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-261745-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:michael.bommarito@gmail.com,m:alexander.deucher@amd.com,m:michaelbommarito@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,amd.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,linuxfoundation.org:from_mime,linuxfoundation.org:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp,amd.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 20C3A6501DF

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michael Bommarito <michael.bommarito@gmail.com>

commit 2e7f55eb408c3f72ee1957a0d0ad11d8648a6379 upstream.

The AMDGPU_GEM_OP_GET_MAPPING_INFO branch of amdgpu_gem_op_ioctl()
holds three cleanup-tracked resources before calling kvcalloc():
the drm_gem_object reference from drm_gem_object_lookup(), the
drm_exec lock on the looked-up GEM via drm_exec_lock_obj(), and
the drm_exec lock on the per-process VM root page directory via
amdgpu_vm_lock_pd().  All three are released by the out_exec
label that every other error path in this function jumps to.
The kvcalloc() failure path returns -ENOMEM directly, skipping
out_exec and leaking all three.

The leaked per-process VM root PD dma_resv lock is the
load-bearing leak: any subsequent operation on the same VM
(further GEM ops, command-submission, eviction, TTM shrinker
callbacks) blocks on the held lock.  DRM_IOCTL_AMDGPU_GEM_OP is
DRM_AUTH | DRM_RENDER_ALLOW, so this is an unprivileged-local
denial of service against the caller's GPU context, reachable
by any process with /dev/dri/renderD* access.

Route the failure through out_exec so drm_exec_fini() and
drm_gem_object_put() run.

Reproduced on stock 7.0.0-10, Ryzen 7 5700U / Radeon Vega
(Lucienne): the failing ioctl returns -ENOMEM and a second
GET_MAPPING_INFO on the same fd then blocks in
drm_exec_lock_obj() on the leaked dma_resv.  SIGKILL on the
caller does not reap the task; the fd-release path during
process exit goes through amdgpu_gem_object_close() ->
drm_exec_prepare_obj() on the same lock, leaving the task in D
state until the box is rebooted.  The patched kernel was not
rebuilt and re-tested on this hardware; the fix is mechanical.
Tested on a single Lucienne / Vega box only.

Ziyi Guo posted an independent INT_MAX-bound check for
args->num_entries in the same branch [1]; the two patches are
complementary and can land in either order.

Fixes: 4d82724f7f2b ("drm/amdgpu: Add mapping info option for GEM_OP ioctl")
Link: https://lore.kernel.org/all/20260208000255.4073363-1-n7l8m4@u.northwestern.edu/ # [1]
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit b69d3256d79de15f54c322986ff4da68f1d65b0a)
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -1075,8 +1075,10 @@ int amdgpu_gem_op_ioctl(struct drm_devic
 		 * be retried.
 		 */
 		vm_entries = kvcalloc(args->num_entries, sizeof(*vm_entries), GFP_KERNEL);
-		if (!vm_entries)
-			return -ENOMEM;
+		if (!vm_entries) {
+			r = -ENOMEM;
+			goto out_exec;
+		}
 
 		amdgpu_vm_bo_va_for_each_valid_mapping(bo_va, mapping) {
 			if (num_mappings < args->num_entries) {



