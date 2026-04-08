Return-Path: <stable+bounces-234580-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iLrbBDKg1mkzGwgAu9opvQ
	(envelope-from <stable+bounces-234580-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:36:34 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 173503C10E9
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:36:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CDFA0303AB00
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 18:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 615013D88F7;
	Wed,  8 Apr 2026 18:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VsjkXFdO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 254D035B653;
	Wed,  8 Apr 2026 18:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775673228; cv=none; b=AWzulAj083wEXmnRvgbn6PAo20qrsrKZf1Nc9nfsawR4oQjxWIHth8UhI9OYye+OBlnBcIPIQXqZIaCP/7VBxZ+DnKa1fPX0HdGqAJelOEphpYtkLDgfGLxzGEUYUa1vwGSYU/yLh7c7PBgLltNveS5BoGXeahDXUu97U51PO+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775673228; c=relaxed/simple;
	bh=pMqZ2IkYl7942E22QFWBwSsrNJlWBvnMY42e4W9gQto=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VGBTqsDI7D9FKNAlbt7aqPp5ahFMf3IETR+dr7YnIj4QeWJgHq+YY63VSYlS9YKTwEUqX2XTpU8Y2r5o9fgwfGRndH9xHAqikOqu9QtsfeNkWREhO9WzJ2NNMB0TuhYbSMfL1AuW8TV5ZqczTRseZEh2f36/QOQ6xY3jEG2Xn2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VsjkXFdO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B07DDC19421;
	Wed,  8 Apr 2026 18:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775673228;
	bh=pMqZ2IkYl7942E22QFWBwSsrNJlWBvnMY42e4W9gQto=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VsjkXFdOturL6sCM51+ZKwtkXhG9ksfgYwKKgoP2CYSSoOshcVo7MHJGmwfl/4yBn
	 GbEtUevsuVOZ16K+p+o+P5bhsa1uWwN+ygeUmuz0K7DXAL5hzy33CjzJqyFi38lOrl
	 SjKyDzztOMdRLekaRnLWfXrx0demWQD1bq6xNSnI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>,
	Julia Filipchuk <julia.filipchuk@intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 117/277] drm/xe/pxp: Clear restart flag in pxp_start after jumping back
Date: Wed,  8 Apr 2026 20:01:42 +0200
Message-ID: <20260408175938.240758774@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408175933.836769063@linuxfoundation.org>
References: <20260408175933.836769063@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-234580-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,msgid.link:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 173503C10E9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>

[ Upstream commit 76903b2057c8677c2c006e87fede15f496555dc0 ]

If we don't clear the flag we'll keep jumping back at the beginning of
the function once we reach the end.

Fixes: ccd3c6820a90 ("drm/xe/pxp: Decouple queue addition from PXP start")
Signed-off-by: Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>
Cc: Julia Filipchuk <julia.filipchuk@intel.com>
Reviewed-by: Julia Filipchuk <julia.filipchuk@intel.com>
Link: https://patch.msgid.link/20260324153718.3155504-9-daniele.ceraolospurio@intel.com
(cherry picked from commit 0850ec7bb2459602351639dccf7a68a03c9d1ee0)
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/xe/xe_pxp.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/xe_pxp.c b/drivers/gpu/drm/xe/xe_pxp.c
index fdcecc026e937..9261a8412b64f 100644
--- a/drivers/gpu/drm/xe/xe_pxp.c
+++ b/drivers/gpu/drm/xe/xe_pxp.c
@@ -532,7 +532,7 @@ static int __exec_queue_add(struct xe_pxp *pxp, struct xe_exec_queue *q)
 static int pxp_start(struct xe_pxp *pxp, u8 type)
 {
 	int ret = 0;
-	bool restart = false;
+	bool restart;
 
 	if (!xe_pxp_is_enabled(pxp))
 		return -ENODEV;
@@ -561,6 +561,8 @@ static int pxp_start(struct xe_pxp *pxp, u8 type)
 					 msecs_to_jiffies(PXP_ACTIVATION_TIMEOUT_MS)))
 		return -ETIMEDOUT;
 
+	restart = false;
+
 	mutex_lock(&pxp->mutex);
 
 	/* If PXP is not already active, turn it on */
-- 
2.53.0




