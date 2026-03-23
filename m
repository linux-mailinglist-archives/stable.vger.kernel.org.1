Return-Path: <stable+bounces-228437-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eL0tC2VOwWm7SAQAu9opvQ
	(envelope-from <stable+bounces-228437-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:29:57 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 890402F49BA
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:29:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CD9643155FA0
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 14:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CDC83B38B1;
	Mon, 23 Mar 2026 14:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fA8YyF7Y"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E26A3B38AB;
	Mon, 23 Mar 2026 14:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774275124; cv=none; b=s6c0hHaMT3WYe20302LQOrpoR0eU3jfWi2gxRSQt2vpFp8qbK+DHuhb8fzj5Y+KC+GSo88nhZjs5uPY4AOlWaq9eFr2NbmpqucRF7cm3e8qNV629mkGM+y8A6gxDxrSh5aPjxFVlpA764ffMLtDGJ2MQTPv83zNWL05/gP0QoOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774275124; c=relaxed/simple;
	bh=TxJ2kHfdLrp9rzZ4NnjXtlqtCYRuraOsrrmHgKpaMs8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h1AHF1ArjMJpx76oXJJLaVcU1WrOfv8A01d0xsOMyVa2PXvzj040KiuNg0ai5PE0p5ANpQa+fd7ur7wdWXDpxzUM/+vXB/E2boHaV3HKg9bTHpccYps/lskAY2yZa2jO4Hq7wFWhDwf6UXVg8UhuoeTzvPVU78NBVwMmp1yz5jE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fA8YyF7Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE358C2BCB1;
	Mon, 23 Mar 2026 14:12:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774275124;
	bh=TxJ2kHfdLrp9rzZ4NnjXtlqtCYRuraOsrrmHgKpaMs8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fA8YyF7Yns1J647uYICfgtCwiZE4M6ptrJ/Y2txZIsxcUdulhl0uQXgSaJHiiYuyj
	 5ZGTEEeu6fFCj7kaPl0Fkqp4UkYeZGqieoUrNzUtHJR6NPzUoR8Ht+F7x0ajz1741R
	 2TIscvE9pq0kox7DjRzq5eEPwjjByDOv8SBRDeVg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kuzey Arda Bulut <kuzeyardabulut@gmail.com>,
	Ian Forbes <ian.forbes@broadcom.com>,
	Zack Rusin <zack.rusin@broadcom.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 002/481] drm/vmwgfx: Return the correct value in vmw_translate_ptr functions
Date: Mon, 23 Mar 2026 14:39:44 +0100
Message-ID: <20260323134525.318682372@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134525.256603107@linuxfoundation.org>
References: <20260323134525.256603107@linuxfoundation.org>
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
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-228437-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,broadcom.com,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 890402F49BA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ian Forbes <ian.forbes@broadcom.com>

[ Upstream commit 5023ca80f9589295cb60735016e39fc5cc714243 ]

Before the referenced fixes these functions used a lookup function that
returned a pointer. This was changed to another lookup function that
returned an error code with the pointer becoming an out parameter.

The error path when the lookup failed was not changed to reflect this
change and the code continued to return the PTR_ERR of the now
uninitialized pointer. This could cause the vmw_translate_ptr functions
to return success when they actually failed causing further uninitialized
and OOB accesses.

Reported-by: Kuzey Arda Bulut <kuzeyardabulut@gmail.com>
Fixes: a309c7194e8a ("drm/vmwgfx: Remove rcu locks from user resources")
Signed-off-by: Ian Forbes <ian.forbes@broadcom.com>
Reviewed-by: Zack Rusin <zack.rusin@broadcom.com>
Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
Link: https://patch.msgid.link/20260113175357.129285-1-ian.forbes@broadcom.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c b/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
index d8cc99ef7e2a0..34b9161ec7e81 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
@@ -1156,7 +1156,7 @@ static int vmw_translate_mob_ptr(struct vmw_private *dev_priv,
 	ret = vmw_user_bo_lookup(sw_context->filp, handle, &vmw_bo);
 	if (ret != 0) {
 		drm_dbg(&dev_priv->drm, "Could not find or use MOB buffer.\n");
-		return PTR_ERR(vmw_bo);
+		return ret;
 	}
 	ret = vmw_validation_add_bo(sw_context->ctx, vmw_bo, true, false);
 	tmp_bo = vmw_bo;
@@ -1211,7 +1211,7 @@ static int vmw_translate_guest_ptr(struct vmw_private *dev_priv,
 	ret = vmw_user_bo_lookup(sw_context->filp, handle, &vmw_bo);
 	if (ret != 0) {
 		drm_dbg(&dev_priv->drm, "Could not find or use GMR region.\n");
-		return PTR_ERR(vmw_bo);
+		return ret;
 	}
 	ret = vmw_validation_add_bo(sw_context->ctx, vmw_bo, false, false);
 	tmp_bo = vmw_bo;
-- 
2.51.0




