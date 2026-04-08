Return-Path: <stable+bounces-234579-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QM+3KZuf1mkLGwgAu9opvQ
	(envelope-from <stable+bounces-234579-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:34:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D2133C0FAD
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:34:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 17E01302708F
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 18:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4E9C3D8125;
	Wed,  8 Apr 2026 18:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ssXqaoUU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87AA23D6CA2;
	Wed,  8 Apr 2026 18:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775673225; cv=none; b=EQHrAbh19CGRbMkyDz6yK2/hvYbXHga7TyamKU7D4m0002j/Uc5LjVSqm30OZhzOU1JAp12nnvVtMys+Pjnz80au/ktB1oO4JadJqdwleeJflV8+GvYpbVvEGUuIxQCYh/wKd2pAxWhCgiTNi3hunqCmv6Ld3UL0WIBq1KrSiXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775673225; c=relaxed/simple;
	bh=XZjZp9/Eyb0fWSX4GfsYbqCFIN8KYeHLS0HHmuJaTZc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XEJkMYEV78XJsLHtQOZYu6QWkEdAjTrWwRVfUC15/XZrPQ6QmRsjrM1We0Ix3OUTCAJo4QTmbF3SyKbMHrUrImaeJJaYZ3/6kQH80UfkHVcAKufem8LG16DMT+95AiYCcrZhp6GP2V85oM7TiGMXeBg8QioCSImlWc2VTGsCJ38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ssXqaoUU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA361C19421;
	Wed,  8 Apr 2026 18:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775673225;
	bh=XZjZp9/Eyb0fWSX4GfsYbqCFIN8KYeHLS0HHmuJaTZc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ssXqaoUU/3IP0qulzkC7SNup6j2/A9Du6KFj3xbZ5JWJdgbwqfCuE3JoA1+GieEMe
	 ANimPfXG2V+Zsw7/qqsQrP5KDxSBBbRj9XPtcpEh+8sxE9+VzTsStB+599rTIfBjfm
	 FUkzw4F7oQYi0Uedp1bepAUEvTX2BVxcG7AfiaXk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>,
	Alan Previn Teres Alexis <alan.previn.teres.alexis@intel.com>,
	Julia Filipchuk <julia.filipchuk@intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 116/277] drm/xe/pxp: Remove incorrect handling of impossible state during suspend
Date: Wed,  8 Apr 2026 20:01:41 +0200
Message-ID: <20260408175938.204064740@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-234579-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,msgid.link:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4D2133C0FAD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>

[ Upstream commit 4fed244954c2dc9aafa333d08f66b14345225e03 ]

The default case of the PXP suspend switch is incorrectly exiting
without releasing the lock. However, this case is impossible to hit
because we're switching on an enum and all the valid enum values have
their own cases. Therefore, we can just get rid of the default case
and rely on the compiler to warn us if a new enum value is added and
we forget to add it to the switch.

Fixes: 51462211f4a9 ("drm/xe/pxp: add PXP PM support")
Signed-off-by: Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>
Cc: Alan Previn Teres Alexis <alan.previn.teres.alexis@intel.com>
Cc: Julia Filipchuk <julia.filipchuk@intel.com>
Reviewed-by: Julia Filipchuk <julia.filipchuk@intel.com>
Link: https://patch.msgid.link/20260324153718.3155504-8-daniele.ceraolospurio@intel.com
(cherry picked from commit f1b5a77fc9b6a90cd9a5e3db9d4c73ae1edfcfac)
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/xe/xe_pxp.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_pxp.c b/drivers/gpu/drm/xe/xe_pxp.c
index ba4d52001b853..fdcecc026e937 100644
--- a/drivers/gpu/drm/xe/xe_pxp.c
+++ b/drivers/gpu/drm/xe/xe_pxp.c
@@ -891,11 +891,6 @@ int xe_pxp_pm_suspend(struct xe_pxp *pxp)
 		pxp->key_instance++;
 		needs_queue_inval = true;
 		break;
-	default:
-		drm_err(&pxp->xe->drm, "unexpected state during PXP suspend: %u",
-			pxp->status);
-		ret = -EIO;
-		goto out;
 	}
 
 	/*
@@ -920,7 +915,6 @@ int xe_pxp_pm_suspend(struct xe_pxp *pxp)
 
 	pxp->last_suspend_key_instance = pxp->key_instance;
 
-out:
 	return ret;
 }
 
-- 
2.53.0




