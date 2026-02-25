Return-Path: <stable+bounces-219552-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uBkTNIOhnmlPWgQAu9opvQ
	(envelope-from <stable+bounces-219552-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 08:15:15 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 25B5B19323D
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 08:15:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AAEF4307AA3B
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 07:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4609331234;
	Wed, 25 Feb 2026 06:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iLMUtJ09"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8830433121D;
	Wed, 25 Feb 2026 06:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772002791; cv=none; b=i6zP8iUKMxbsXKBzsiR4fLlC4k17ok/tl6IogE7jRmTUhpK+aw3mTXR8aaNAhkGJa22P+vlNMv2FgaA3lcbLpioHy1J4F/o656otloQstc8UOF9Mxd53oEoqUEHbxXosCh7XdP/uiT5zTUVQvZE5BBbj4ZrNKvxFySLpa+YIDUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772002791; c=relaxed/simple;
	bh=vEsuXKLqV851mivOVCGioJbITGRoa2dgNpvIa5akwAE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yn6DuKERsI9gCzMvJnJ6sSK8sHsdfz3MFah/5qEWsIAVfMIYUIrrfuaWqlwrH+JhGg2M4blijE4FSbu0b4SNkTwsk4qQA32NhaPomwlBWAgVe8Lx/uO6OEHSMSm+Jf67+gpnNiXwnJFSxMnaOcsOhzljsNXR6IoV14MTWAPAAVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iLMUtJ09; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60803C116D0;
	Wed, 25 Feb 2026 06:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1772002791;
	bh=vEsuXKLqV851mivOVCGioJbITGRoa2dgNpvIa5akwAE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iLMUtJ090d+/JFYNbfi/G4oaio/Dcz7dfuu7NLE5seU3lYNgHSa0qb+k7fZqqHVhE
	 tjn23C4EMLRXFu0whAywXGUnA42CAJoEH8pAyTKU/S7dj85oX0ujLiMKQQqwbYUxBO
	 GT/7TkU2+8pt+pwZdQd83fU6iQgP2e+oVcXFqtPI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Raag Jadav <raag.jadav@intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Matt Roper <matthew.d.roper@intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 599/641] drm/xe/bo: Redirect faults to dummy page for wedged device
Date: Tue, 24 Feb 2026 17:25:25 -0800
Message-ID: <20260225012403.030984168@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225012348.915798704@linuxfoundation.org>
References: <20260225012348.915798704@linuxfoundation.org>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-219552-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:mid,linuxfoundation.org:dkim,msgid.link:url,intel.com:email]
X-Rspamd-Queue-Id: 25B5B19323D
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Raag Jadav <raag.jadav@intel.com>

[ Upstream commit 4e83a8d58e1c721a89b3ffe15f549007080272e2 ]

As per uapi documentation[1], the prerequisite for wedged device is to
redirected page faults to a dummy page. Follow it.

[1] Documentation/gpu/drm-uapi.rst

v2: Add uapi reference and fixes tag (Matthew Brost)

Fixes: 7bc00751f877 ("drm/xe: Use device wedged event")
Signed-off-by: Raag Jadav <raag.jadav@intel.com>
Reviewed-by: Matthew Brost <matthew.brost@intel.com>
Link: https://patch.msgid.link/20260212055622.2054991-1-raag.jadav@intel.com
Signed-off-by: Matt Roper <matthew.d.roper@intel.com>
(cherry picked from commit c020fff70d757612933711dd3cc3751d7d782d3c)
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/xe/xe_bo.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
index e2e28ff73925b..a270aef7c4980 100644
--- a/drivers/gpu/drm/xe/xe_bo.c
+++ b/drivers/gpu/drm/xe/xe_bo.c
@@ -1895,7 +1895,7 @@ static vm_fault_t xe_bo_cpu_fault(struct vm_fault *vmf)
 	int err = 0;
 	int idx;
 
-	if (!drm_dev_enter(&xe->drm, &idx))
+	if (xe_device_wedged(xe) || !drm_dev_enter(&xe->drm, &idx))
 		return ttm_bo_vm_dummy_page(vmf, vmf->vma->vm_page_prot);
 
 	ret = xe_bo_cpu_fault_fastpath(vmf, xe, bo, needs_rpm);
-- 
2.51.0




