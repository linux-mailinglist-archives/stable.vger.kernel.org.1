Return-Path: <stable+bounces-231806-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eNgeLO76y2lsNAYAu9opvQ
	(envelope-from <stable+bounces-231806-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 18:48:46 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F72F36D2BA
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 18:48:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 16DE93116DC6
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 16:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A89DD426EBB;
	Tue, 31 Mar 2026 16:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="e8RLlLXB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68297425CFF;
	Tue, 31 Mar 2026 16:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774975117; cv=none; b=QoI0SAUrStWXS8vWHxlRloLiibduPhLCa+D+R5sFAEuQHEjd5gRAg4KHbASU3PqexeeJwPKBr2P9Y7XGFll1a3IP936Q0I3UV8IamKHX085vHVVQ/shLrC38PqzKCItB8qF/ijPfLoy89BNcZmtUIAGQXfuNZ8AIZV4a2akaALs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774975117; c=relaxed/simple;
	bh=QgJMqnqDMMMAIRCQS0i9sHl2OLlYjLLIf/Ul25YdMRI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jctZd4TmHxK4CM356u2ccNNEbHG5arrp8T29PFoBiir1a4P1B6IFi2sCxyKdywnVnrsgky/gxBip+BB/hCc22lNsKtTDiUl/wYUKnxZVWtkr5fWZSOlR22UuNRsClbsvq9GG2VYiEc/auxFwSB3/g2Ty+bgY9Uy83UUZmwsURzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=e8RLlLXB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2181C19423;
	Tue, 31 Mar 2026 16:38:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774975117;
	bh=QgJMqnqDMMMAIRCQS0i9sHl2OLlYjLLIf/Ul25YdMRI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=e8RLlLXBzzNjm2r+HwMYmVR+GVEYvf913LAW07NUGhjQZkmf+Vi9wINlU3t2Px87Y
	 CAqzmy2iBhs92o6nTvoE7N2mEH/hYWnFafHQKXIq+WUmk0zE4PIX727OzzZ6wkOfhR
	 qBycn0wZWCxNv1CE3zjDTH5uN1Sk6xOZ1raP1hiY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Youngjun Park <youngjun.park@lge.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 171/342] PM: sleep: Drop spurious WARN_ON() from pm_restore_gfp_mask()
Date: Tue, 31 Mar 2026 18:20:04 +0200
Message-ID: <20260331161805.302594232@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331161758.909578033@linuxfoundation.org>
References: <20260331161758.909578033@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-231806-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:email,linuxfoundation.org:dkim,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: 5F72F36D2BA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Youngjun Park <youngjun.park@lge.com>

[ Upstream commit a8d51efb5929ae308895455a3e496b5eca2cd143 ]

Commit 35e4a69b2003f ("PM: sleep: Allow pm_restrict_gfp_mask()
stacking") introduced refcount-based GFP mask management that warns
when pm_restore_gfp_mask() is called with saved_gfp_count == 0.

Some hibernation paths call pm_restore_gfp_mask() defensively where
the GFP mask may or may not be restricted depending on the execution
path. For example, the uswsusp interface invokes it in
SNAPSHOT_CREATE_IMAGE, SNAPSHOT_UNFREEZE, and snapshot_release().
Before the stacking change this was a silent no-op; it now triggers
a spurious WARNING.

Remove the WARN_ON() wrapper from the !saved_gfp_count check while
retaining the check itself, so that defensive calls remain harmless
without producing false warnings.

Fixes: 35e4a69b2003f ("PM: sleep: Allow pm_restrict_gfp_mask() stacking")
Signed-off-by: Youngjun Park <youngjun.park@lge.com>
[ rjw: Subject tweak ]
Link: https://patch.msgid.link/20260322120528.750178-1-youngjun.park@lge.com
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/power/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/power/main.c b/kernel/power/main.c
index 03b2c5495c77a..9ce75b1a23ed3 100644
--- a/kernel/power/main.c
+++ b/kernel/power/main.c
@@ -40,7 +40,7 @@ void pm_restore_gfp_mask(void)
 {
 	WARN_ON(!mutex_is_locked(&system_transition_mutex));
 
-	if (WARN_ON(!saved_gfp_count) || --saved_gfp_count)
+	if (!saved_gfp_count || --saved_gfp_count)
 		return;
 
 	gfp_allowed_mask = saved_gfp_mask;
-- 
2.53.0




