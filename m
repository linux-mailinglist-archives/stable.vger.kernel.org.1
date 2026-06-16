Return-Path: <stable+bounces-264195-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 1Z8pK5RxMWrXjQUAu9opvQ
	(envelope-from <stable+bounces-264195-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:53:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 156206917C2
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:53:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=PlEQhi9E;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-264195-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-264195-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 076C93111221
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 15:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5D503BCD3A;
	Tue, 16 Jun 2026 15:43:51 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D34944E040;
	Tue, 16 Jun 2026 15:43:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781624631; cv=none; b=C2jlmVHM1u6FuNJBzhV9oC22Tzn9kwU5h9fJhg9S4VorB8bwiYwRFA75yAkWGKNACszBfp6cJUo6/HQ1Udm38uwrUpo3lwZ+aYMESHlTe+B5GRnUJnDytThOJ9YcCkZQyQcx6J6T8PQU3E4dbhpHSb1Ee27mPnRdM8PCysMM5Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781624631; c=relaxed/simple;
	bh=IXIweYvUHnPXCtPYM3Yk36aV+czlNHuSU8Lf0HzL1ic=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XVXaVSE6z31MaeRn8Arg4091RHOeRpuw9TXM1uZCYZVt1Xh+TOTrEmV9BKixfCqtj4Gd33H1NLqaKV0sOrVhjtDMY+OXvxfjUE2RYo/Zh9l4t8oMXBbH8TivgHg8mU4uxvYVovNJaU1g2ZP1ljr6jEFPEtZdREAaZGh9rUJcy+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PlEQhi9E; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 913BE1F000E9;
	Tue, 16 Jun 2026 15:43:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781624630;
	bh=tDH4HJHg5wFw/Di1lDkYw977IfY5JftloCO10Ilz6DQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PlEQhi9EWCW5Tn2cL/hGwKUOoF7dz04jiVSShlVLm1u5qHLX8kx8b5SiTjiIMlg5R
	 Cs4XqMBOoScMEe3g3b+w3NHPnPdaxOjuTyb+xyhd4Z+mnhPMROiGp3LZIKJicYO/IV
	 9oCdJarK0bxdTBT3b6JNkoCI8vY9P5k5jtBwF6fs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>,
	Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>
Subject: [PATCH 7.0 338/378] drm/xe/multi_queue: skip submit when primary queue is suspended
Date: Tue, 16 Jun 2026 20:29:29 +0530
Message-ID: <20260616145127.994062917@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145109.744539446@linuxfoundation.org>
References: <20260616145109.744539446@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-264195-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:daniele.ceraolospurio@intel.com,m:niranjana.vishwanathapura@intel.com,m:rodrigo.vivi@intel.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,intel.com:email,vger.kernel.org:from_smtp,msgid.link:url,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,patchwork.freedesktop.org:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 156206917C2

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>

commit ec4cbdd163f9bb2a2bd44eb93ecf4a2fa0e912a9 upstream.

Return early in submit path when the multi-queue primary exec
queue is suspended to avoid submitting while suspended.

v2: Remove idle_skip_suspend fix as that feature is being
reverted here https://patchwork.freedesktop.org/series/167262/

Fixes: bc5775c59258 ("drm/xe/multi_queue: Add GuC interface for multi queue support")
Cc: stable@vger.kernel.org # v7.0+
Assisted-by: GitHub-Copilot:claude-sonnet-4.6
Reviewed-by: Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>
Signed-off-by: Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>
Link: https://patch.msgid.link/20260603233946.863663-2-niranjana.vishwanathapura@intel.com
(cherry picked from commit b7fb55cc3364ca128cfff9d50649ffd4327cd01e)
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/xe/xe_guc_submit.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/drivers/gpu/drm/xe/xe_guc_submit.c
+++ b/drivers/gpu/drm/xe/xe_guc_submit.c
@@ -1104,9 +1104,12 @@ static void submit_exec_queue(struct xe_
 
 	/*
 	 * All queues in a multi-queue group will use the primary queue
-	 * of the group to interface with GuC.
+	 * of the group to interface with GuC. If primay is suspended,
+	 * just return. Jobs will get scheduled once primary is resumed.
 	 */
 	q = xe_exec_queue_multi_queue_primary(q);
+	if (exec_queue_suspended(q))
+		return;
 
 	if (!exec_queue_enabled(q) && !exec_queue_suspended(q)) {
 		action[len++] = XE_GUC_ACTION_SCHED_CONTEXT_MODE_SET;



