Return-Path: <stable+bounces-213815-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YIdlJvNkg2nAmAMAu9opvQ
	(envelope-from <stable+bounces-213815-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 16:25:39 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EF94FE883C
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 16:25:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 258C131D3C61
	for <lists+stable@lfdr.de>; Wed,  4 Feb 2026 15:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52FE7426D02;
	Wed,  4 Feb 2026 15:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LmGCPgSb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1645D4218BB;
	Wed,  4 Feb 2026 15:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770217603; cv=none; b=GxBsnF9OmFaRZLPR8+okzjq7sQQDnZ2ni51QDI1goflzpRAWS0qGvbwiqtGwU9ojeyhHefy76YPV/jtGU0jsYSl3asWUe1/bgcnLewIoEBYeB3n78tjNqyDrg9GSJs+PJI5Q+KlPkgxKExOgb+M68mv51AeUS2zSgW+Mho8XdhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770217603; c=relaxed/simple;
	bh=+6d1Fat8iHbsXvSuycUno+HXI3FKqWlujUBMKc6K/3A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eDVPJvtoCZ+b9AHl0KUXJqJ84L5EFQ80SMD4eGEI/edo4HokVArdXoBduKaTkj+4ZRisCXSq2uglnW40dbufNwC+WHURHYgeqPW5ZB/4btxYt7ZByKxgsgc7y/54pPVR74+1XQDo1Fd/KJu3pkbrTPyJqw/KG2ayhGlAUguPH3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LmGCPgSb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3453BC4CEF7;
	Wed,  4 Feb 2026 15:06:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770217603;
	bh=+6d1Fat8iHbsXvSuycUno+HXI3FKqWlujUBMKc6K/3A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LmGCPgSb1aPP1aO0WR7rX1gxvrasDEaqzTSJi39EH6vZZX2Rj64tL2X23LjeYzji6
	 VMjBwsy8hzdgMShhiEn3Dj1ruS+bhdNwpAbsXPjAltGvdE28zbeZ0OlecifouW47HQ
	 fOMIJpgteZhj5Gaiv0AIhf+ovjBeqpCM7zYWLMfs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>,
	Zack Rusin <zack.rusin@broadcom.com>
Subject: [PATCH 6.1 065/280] drm/vmwgfx: Fix an error return check in vmw_compat_shader_add()
Date: Wed,  4 Feb 2026 15:37:19 +0100
Message-ID: <20260204143911.995055969@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260204143909.614719725@linuxfoundation.org>
References: <20260204143909.614719725@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-213815-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,msgid.link:url,iscas.ac.cn:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,broadcom.com:email]
X-Rspamd-Queue-Id: EF94FE883C
X-Rspamd-Action: no action

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>

commit bf72b4b7bb7dbb643d204fa41e7463894a95999f upstream.

In vmw_compat_shader_add(), the return value check of vmw_shader_alloc()
is not proper. Modify the check for the return pointer 'res'.

Found by code review and compiled on ubuntu 20.04.

Fixes: 18e4a4669c50 ("drm/vmwgfx: Fix compat shader namespace")
Cc: stable@vger.kernel.org
Signed-off-by: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
Link: https://patch.msgid.link/20251224091105.1569464-1-lihaoxiang@isrc.iscas.ac.cn
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_shader.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/gpu/drm/vmwgfx/vmwgfx_shader.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_shader.c
@@ -917,8 +917,10 @@ int vmw_compat_shader_add(struct vmw_pri
 	ttm_bo_unreserve(&buf->base);
 
 	res = vmw_shader_alloc(dev_priv, buf, size, 0, shader_type);
-	if (unlikely(ret != 0))
+	if (IS_ERR(res)) {
+		ret = PTR_ERR(res);
 		goto no_reserve;
+	}
 
 	ret = vmw_cmdbuf_res_add(man, vmw_cmdbuf_res_shader,
 				 vmw_shader_key(user_key, shader_type),



