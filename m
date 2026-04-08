Return-Path: <stable+bounces-235130-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eOG2CGyl1ml9GwgAu9opvQ
	(envelope-from <stable+bounces-235130-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:58:52 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 46DAC3C2192
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:58:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 19DFF300AD6B
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 18:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13325348453;
	Wed,  8 Apr 2026 18:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cZ6AATxB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB7E83176E4;
	Wed,  8 Apr 2026 18:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775674646; cv=none; b=gbHiipeeiP1Kl5IKDaCoUgggS/Yp5fWWtsOJamTOZL7ld4f6ZmdKm8+Evnh61ro4N1kPoGmtwbjOAzNdL7vHeCLWTvjoh70egypDGx8F1MxeKdHoFHyzdmxQ/1//pWTx0nR9fejmP9kAaareduqViV+Yhnw+PckDQ6mH4E38F3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775674646; c=relaxed/simple;
	bh=9/wzK7qht0NaO7ZAv7LAxI7os9v5lSfdrYQDL2x4yb8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mE5airuAKEx6yts+26MjzbnKSTt35eVzqJe111YgrSTkBQYyokudWnSbz/JwnLHQnFbyGBkbt17lyp8589WbfS4p6Z6J381vnQ62ODstsT4/2CUaL9v1cOxRF+PZYqbhTiewoTk/6/b9AZkQ9kpzNygkClic/NVHgakHoRpZH4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cZ6AATxB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E98BC19421;
	Wed,  8 Apr 2026 18:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775674646;
	bh=9/wzK7qht0NaO7ZAv7LAxI7os9v5lSfdrYQDL2x4yb8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cZ6AATxBCMmh3pQCRFOPpJpz1RUgwZHE2TPxEZg9Qqe+f+PHu6dhHyz0OAqcuoUpS
	 mOzLQdnCpVA3OBkH6n8q1pyLVyjXoHrENEOt5NOZomI0qYQPytw9UCFe8xGpfqIUEi
	 JBwVYqW3izTAskdyBxHHhdP8NRt58c91daztYo1E=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>,
	Alan Previn Teres Alexis <alan.previn.teres.alexis@intel.com>,
	Julia Filipchuk <julia.filipchuk@intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 145/311] drm/xe/pxp: Clean up termination status on failure
Date: Wed,  8 Apr 2026 20:02:25 +0200
Message-ID: <20260408175944.825305928@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408175939.393281918@linuxfoundation.org>
References: <20260408175939.393281918@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-235130-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:mid,msgid.link:url,intel.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 46DAC3C2192
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>

[ Upstream commit e2628e670bb0923fcdc00828bfcd67b26a7df020 ]

If the PXP HW termination fails during PXP start, the normal completion
code won't be called, so the termination will remain uncomplete. To avoid
unnecessary waits, mark the termination as completed from the error path.
Note that we already do this if the termination fails when handling a
termination irq from the HW.

Fixes: f8caa80154c4 ("drm/xe/pxp: Add PXP queue tracking and session start")
Signed-off-by: Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>
Cc: Alan Previn Teres Alexis <alan.previn.teres.alexis@intel.com>
Cc: Julia Filipchuk <julia.filipchuk@intel.com>
Reviewed-by: Julia Filipchuk <julia.filipchuk@intel.com>
Link: https://patch.msgid.link/20260324153718.3155504-7-daniele.ceraolospurio@intel.com
(cherry picked from commit 5d9e708d2a69ab1f64a17aec810cd7c70c5b9fab)
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/xe/xe_pxp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/xe/xe_pxp.c b/drivers/gpu/drm/xe/xe_pxp.c
index bdbdbbf6a6781..ba4d52001b853 100644
--- a/drivers/gpu/drm/xe/xe_pxp.c
+++ b/drivers/gpu/drm/xe/xe_pxp.c
@@ -603,6 +603,7 @@ static int pxp_start(struct xe_pxp *pxp, u8 type)
 			drm_err(&pxp->xe->drm, "PXP termination failed before start\n");
 			mutex_lock(&pxp->mutex);
 			pxp->status = XE_PXP_ERROR;
+			complete_all(&pxp->termination);
 
 			goto out_unlock;
 		}
-- 
2.53.0




