Return-Path: <stable+bounces-237464-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IHz+BSsl3WlcaQkAu9opvQ
	(envelope-from <stable+bounces-237464-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 19:17:31 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 08D1C3F11C4
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 19:17:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DC41B3044D16
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 641C4330649;
	Mon, 13 Apr 2026 16:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sxc83Su5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 278873203B6;
	Mon, 13 Apr 2026 16:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776099525; cv=none; b=FHWyZi68IV40cLBsN290dYnoWwzeZ34a8wgfOGGdOtk7jEi20A2rzqb+jIJ49EzgkPekcSNLeuis3jZu/rQPOldQA1ItDhwn27b+XRvXLqfANEmKGaax9Mm0skGlu1XbyH/2YSfAPpy4Rptr5w2nPA+6czXCtjguMLOrnIdFlng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776099525; c=relaxed/simple;
	bh=7tKTTs05w0DGw8hKfaE9N2gMwJKBRh/osiIVTij5SNw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=anBbCMy9cmP6Lp3mNliRFUK8iFTXZNiMAmgqr+b9nhGMDHG3PermeLjn/grSmn8d1W2fRjQeten7XhR0s+JP+XxBjn1cWJAVCMKfS5mpbUHsTbCEzUi9trHyVuUQGQa9r90YnD2D0EtV06x2NRe0lwTSAj3KMAcdfFiAl6r3D+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sxc83Su5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D12CC2BCAF;
	Mon, 13 Apr 2026 16:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776099524;
	bh=7tKTTs05w0DGw8hKfaE9N2gMwJKBRh/osiIVTij5SNw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sxc83Su5qds2Wv6U2USjmMowBMBp/JFSi7D+6Lci23yBlxTRCp9rB3PXthz9/qY+O
	 L+2P/pYybSVkyXgUYUuZ/AiI0cA2XOWWuA901BkIDQxMenInAO3ugsUH9qU7M60dFR
	 PatYWkPPw7nJmYrd+qbJOD8pxjFDNLfTxFEX8DcU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Jocelyn Falempe <jfalempe@redhat.com>,
	Dave Airlie <airlied@redhat.com>,
	dri-devel@lists.freedesktop.org
Subject: [PATCH 5.10 373/491] drm/ast: dp501: Fix initialization of SCU2C
Date: Mon, 13 Apr 2026 18:00:18 +0200
Message-ID: <20260413155832.998865330@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413155819.042779211@linuxfoundation.org>
References: <20260413155819.042779211@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-237464-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,msgid.link:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,lists.freedesktop.org:email]
X-Rspamd-Queue-Id: 08D1C3F11C4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Zimmermann <tzimmermann@suse.de>

commit 2f42c1a6161646cbd29b443459fd635d29eda634 upstream.

Ast's DP501 initialization reads the register SCU2C at offset 0x1202c
and tries to set it to source data from VGA. But writes the update to
offset 0x0, with unknown results. Write the result to SCU instead.

The bug only happens in ast_init_analog(). There's similar code in
ast_init_dvo(), which works correctly.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Fixes: 83c6620bae3f ("drm/ast: initial DP501 support (v0.2)")
Reviewed-by: Jocelyn Falempe <jfalempe@redhat.com>
Cc: Dave Airlie <airlied@redhat.com>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Jocelyn Falempe <jfalempe@redhat.com>
Cc: dri-devel@lists.freedesktop.org
Cc: <stable@vger.kernel.org> # v3.16+
Link: https://patch.msgid.link/20260327133532.79696-2-tzimmermann@suse.de
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/ast/ast_dp501.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/gpu/drm/ast/ast_dp501.c
+++ b/drivers/gpu/drm/ast/ast_dp501.c
@@ -484,7 +484,7 @@ static void ast_init_analog(struct drm_d
 	/* Finally, clear bits [17:16] of SCU2c */
 	data = ast_read32(ast, 0x1202c);
 	data &= 0xfffcffff;
-	ast_write32(ast, 0, data);
+	ast_write32(ast, 0x1202c, data);
 
 	/* Disable DVO */
 	ast_set_index_reg_mask(ast, AST_IO_CRTC_PORT, 0xa3, 0xcf, 0x00);



