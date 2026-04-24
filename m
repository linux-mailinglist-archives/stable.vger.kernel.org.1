Return-Path: <stable+bounces-240731-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UIGxDptx62nCMwAAu9opvQ
	(envelope-from <stable+bounces-240731-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 15:35:23 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 30E2C45F265
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 15:35:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 685653003725
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 13:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30C063D47B0;
	Fri, 24 Apr 2026 13:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WRaNcKBZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E87E919A288;
	Fri, 24 Apr 2026 13:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777037691; cv=none; b=Px5mIqaY4eiFkDmevvp/DK20a0KKfa3O1adZFRcV3N1HVISr+Q7sUZqKrBaNsdz2z4W9ed6nGZf69ZJ1JZVDWa9g10vhUFXOHTBIBpnls4YZsbKVXqAVroLHRjFbSV6IoY1sZAuQmEdtXHn/IDpKpqbL+kC4Y5Lj6NoLTV/ho6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777037691; c=relaxed/simple;
	bh=6lbtfMGSZJKRTg+n65QJ3GpmRjjCR5nq0GNmBVqE7eI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lAQY+XwMQ/hZR/xnbn4Y87WYUqsby388ou7mc0CfqMJohmaR7QRNR6XlnQ7zrUtx1biG0SDhcggeEq2Baaf4Bhr2AmuhPb5UvsyhUw4eLIk4MLZmqA9N+Ry8WslPW0kN0DelXpEt7qkFeasebm8DHAOhces9XOCaPwJ22l5bd3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WRaNcKBZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CEA2C19425;
	Fri, 24 Apr 2026 13:34:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777037690;
	bh=6lbtfMGSZJKRTg+n65QJ3GpmRjjCR5nq0GNmBVqE7eI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WRaNcKBZMbO4ADAtOsKd1cJt14LGM7pL1tQpBmh8B3rYGSYeXecUoCU3l7KEy2WKZ
	 irg+8PA9/MAHlxDGLEg85dryCcFZJigD3cwYtBG0qL7lbFCgDPjamZSEYL9iKFrZF1
	 NfPsCGrssRdPOUIhuHrDAHz3lL/9SLQo2zcvEyeE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Melissa Wen <mwen@igalia.com>,
	=?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 032/166] drm/vc4: Fix a memory leak in hang state error path
Date: Fri, 24 Apr 2026 15:29:06 +0200
Message-ID: <20260424132539.640552982@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260424132532.812258529@linuxfoundation.org>
References: <20260424132532.812258529@linuxfoundation.org>
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
X-Rspamd-Queue-Id: 30E2C45F265
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-240731-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,msgid.link:url,linuxfoundation.org:dkim,linuxfoundation.org:mid,igalia.com:email]

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Maíra Canal <mcanal@igalia.com>

[ Upstream commit 9525d169e5fd481538cf8c663cc5839e54f2e481 ]

When vc4_save_hang_state() encounters an early return condition, it
returns without freeing the previously allocated `kernel_state`,
leaking memory.

Add the missing kfree() calls by consolidating the early return paths
into a single place.

Fixes: 214613656b51 ("drm/vc4: Add an interface for capturing the GPU state after a hang.")
Reviewed-by: Melissa Wen <mwen@igalia.com>
Link: https://patch.msgid.link/20260330-vc4-misc-fixes-v1-3-92defc940a29@igalia.com
Signed-off-by: Maíra Canal <mcanal@igalia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/vc4/vc4_gem.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_gem.c b/drivers/gpu/drm/vc4/vc4_gem.c
index fe535c6fc95a8..cede3bf3d722a 100644
--- a/drivers/gpu/drm/vc4/vc4_gem.c
+++ b/drivers/gpu/drm/vc4/vc4_gem.c
@@ -169,10 +169,8 @@ vc4_save_hang_state(struct drm_device *dev)
 	spin_lock_irqsave(&vc4->job_lock, irqflags);
 	exec[0] = vc4_first_bin_job(vc4);
 	exec[1] = vc4_first_render_job(vc4);
-	if (!exec[0] && !exec[1]) {
-		spin_unlock_irqrestore(&vc4->job_lock, irqflags);
-		return;
-	}
+	if (!exec[0] && !exec[1])
+		goto err_free_state;
 
 	/* Get the bos from both binner and renderer into hang state. */
 	state->bo_count = 0;
@@ -189,10 +187,8 @@ vc4_save_hang_state(struct drm_device *dev)
 	kernel_state->bo = kcalloc(state->bo_count,
 				   sizeof(*kernel_state->bo), GFP_ATOMIC);
 
-	if (!kernel_state->bo) {
-		spin_unlock_irqrestore(&vc4->job_lock, irqflags);
-		return;
-	}
+	if (!kernel_state->bo)
+		goto err_free_state;
 
 	k = 0;
 	for (i = 0; i < 2; i++) {
@@ -284,6 +280,12 @@ vc4_save_hang_state(struct drm_device *dev)
 		vc4->hang_state = kernel_state;
 		spin_unlock_irqrestore(&vc4->job_lock, irqflags);
 	}
+
+	return;
+
+err_free_state:
+	spin_unlock_irqrestore(&vc4->job_lock, irqflags);
+	kfree(kernel_state);
 }
 
 static void
-- 
2.53.0




