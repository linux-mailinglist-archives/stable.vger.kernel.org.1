Return-Path: <stable+bounces-249098-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yOdJFYLNCWq2qAQAu9opvQ
	(envelope-from <stable+bounces-249098-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 17 May 2026 16:15:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C737C5618D2
	for <lists+stable@lfdr.de>; Sun, 17 May 2026 16:15:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CC6DA3006530
	for <lists+stable@lfdr.de>; Sun, 17 May 2026 14:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61D7A2594B9;
	Sun, 17 May 2026 14:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=berkoc.com header.i=@berkoc.com header.b="XAwLGIrs"
X-Original-To: stable@vger.kernel.org
Received: from mail-03.1984.is (mail-03.1984.is [93.95.224.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8265B2550D5
	for <stable@vger.kernel.org>; Sun, 17 May 2026 14:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.95.224.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779026883; cv=none; b=BCIwQIgHXMfN+47EztAxH27AIhrvSzBsYTNtgTT2p46yv0E9NfRFcg9UvutMKUHLmcyI34AaAkN4SxFxEVWOyXXww+/Upsfle4M9XX05ozPnnEA3JKzt4G8dTDyd5zmLkr/bDWo2iOMzLs4Vw7MO+3qXwZtmzuLU5FJpEy2MXME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779026883; c=relaxed/simple;
	bh=Oh7q8nC9wITOr2UummyBIMmvVJTwjiXvDl9btxtWfGs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type; b=nZC03PfHIWCIQqgiB5ck+M6n9I2a3o3NOPUS2tlwjcuDEPH3QjWrX+zXfnY7XBnDctRAkPQDHk8OeG/jSXGfe9Uu5PaNVa8xKI4qwVFZ6kNs/7p2pSEepXVlzkkqxOz0NoMTGrt/rh0kWRJaPsHfS93KK8NCKLoQv6kes2f3Pdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=berkoc.com; spf=pass smtp.mailfrom=berkoc.com; dkim=pass (2048-bit key) header.d=berkoc.com header.i=@berkoc.com header.b=XAwLGIrs; arc=none smtp.client-ip=93.95.224.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=berkoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=berkoc.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=berkoc.com;
	s=1984; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:Message-ID
	:References:In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=07i/g/3Qja7ieAQrUk+sKmkgbN29B4mnFsuWaZjIhwI=; b=XAwLGIrs1dxOKw/8B1dA5vxomj
	+QhRG2aC2nMu/RJw6v4VzE1Ftifr6+rjwtTC6KO1dDoEpTEcBagfPXHU9cPD8ozKlpsZloyHPgbCC
	hevERJRT+x3QOed5sxD1X4//BL7hfQOnnaPqLTT6fSzTA29g1Upv0hsY5OHz84+06u9g1v4f6lXnl
	y8NoZ1RhUQP9eNCwv57IC+GDMi3uesOFn6DzC+lPjnKXxR2ZcVvjdpUZwMNDw/ERqd3HLxF4M7UQn
	A3RsER1I24cLrUn5QDpMGnZ1/1CjYBMvEv6tqBN2ICecZWV3SxPjtwWrIGYLwPgKRF/Bw5H79QTTk
	X9IGbJLA==;
Received: from localhost
	by mail-03.1984.is with utf8esmtp (Exim 4.96)
	(envelope-from <me@berkoc.com>)
	id 1wOc9o-00HEJm-2p;
	Sun, 17 May 2026 14:07:53 +0000
From: Berkant Koc <me@berkoc.com>
To: Zack Rusin <zack.rusin@broadcom.com>, bcm-kernel-feedback-list@broadcom.com, dri-devel@lists.freedesktop.org
Cc: security@kernel.org, Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>, Thomas Zimmermann <tzimmermann@suse.de>, stable@vger.kernel.org
Subject: [PATCH] drm/vmwgfx: validate execbuf header.size lower bound
In-Reply-To: <2026051743-genre-cacti-bdf3@gregkh>
References: <20260517-vmwgfx-uaf-report@berkoc.com> <2026051743-genre-cacti-bdf3@gregkh>
Message-ID: <20260517-vmwgfx-uaf-patch@berkoc.com>
Date: Sun, 17 May 2026 15:05:00 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Score: -0.0 (/)
X-Authenticated-User: me@berkoc.com
X-Sender-Address: me@berkoc.com
X-Rspamd-Queue-Id: C737C5618D2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [5.84 / 15.00];
	SEM_URIBL_FRESH15(3.00)[berkoc.com:email];
	DMARC_POLICY_REJECT(2.00)[berkoc.com : SPF not aligned (strict),reject];
	R_DKIM_REJECT(1.00)[berkoc.com:s=1984];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	BAD_REP_POLICIES(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-249098-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,ffwll.ch,gmail.com,suse.de,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[berkoc.com:-];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	GREYLIST(0.00)[pass,body];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[me@berkoc.com,stable@vger.kernel.org];
	NEURAL_HAM(-0.00)[-0.987];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c04:e001:36c::/64];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,berkoc.com:email,berkoc.com:mid]
X-Rspamd-Action: no action

Commit 32b415a9dc2c ("drm/vmwgfx: Validate command header size against
SVGA_CMD_MAX_DATASIZE") added an upper bound on the user-supplied
SVGA3dCmdHeader.size field but no matching lower bound. When
header->size is smaller than sizeof(cmd->body), the size_t subtraction
in expressions like

  maxnum = (header->size - sizeof(cmd->body)) / sizeof(*decl);

underflows. The subsequent bound check

  if (cmd->body.numVertexDecls > maxnum) return -EINVAL;

is bypassed because maxnum is ~SIZE_MAX, and the loop walks
attacker-chosen entries past the command buffer.

In vmw_cmd_draw this leads to a 4-byte OOB-read per iteration via
vmw_cmd_res_check(&decl[i].array.surfaceId, ...); on a surface-handle
collision, vmw_resource_relocation_add records the OOB address as
rel->offset (29-bit bitfield), and vmw_resource_relocations_apply
later performs a 32-bit kernel write at cb + rel->offset.

The same root cause is present in vmw_cmd_dma (suffix pointer-arith
underflow leading to OOB-read of suffix->suffixSize) and
vmw_cmd_shader_define (size_t wraparound passed to
vmw_compat_shader_add).

Reachable via DRM_VMW_EXECBUF (DRM_RENDER_ALLOW). Reject undersized
headers at all three sites before the subtraction.

Cc: stable@vger.kernel.org # v6.18+
Fixes: 32b415a9dc2c ("drm/vmwgfx: Validate command header size against SVGA_CMD_MAX_DATASIZE")
Signed-off-by: Berkant Koc <me@berkoc.com>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c b/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
index e1f18020170a..6f9c7d61cc66 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
@@ -1506,6 +1506,12 @@ static int vmw_cmd_dma(struct vmw_private *dev_priv,
 	bool dirty;
 
 	cmd = container_of(header, typeof(*cmd), header);
+
+	if (unlikely(header->size < sizeof(cmd->body) + sizeof(*suffix))) {
+		VMW_DEBUG_USER("DMA cmd header.size too small.\n");
+		return -EINVAL;
+	}
+
 	suffix = (SVGA3dCmdSurfaceDMASuffix *)((unsigned long) &cmd->body +
 					       header->size - sizeof(*suffix));
 
@@ -1572,6 +1578,12 @@ static int vmw_cmd_draw(struct vmw_private *dev_priv,
 		return ret;
 
 	cmd = container_of(header, typeof(*cmd), header);
+
+	if (unlikely(header->size < sizeof(cmd->body))) {
+		VMW_DEBUG_USER("Draw cmd header.size smaller than body.\n");
+		return -EINVAL;
+	}
+
 	maxnum = (header->size - sizeof(cmd->body)) / sizeof(*decl);
 
 	if (unlikely(cmd->body.numVertexDecls > maxnum)) {
@@ -1915,6 +1927,11 @@ static int vmw_cmd_shader_define(struct vmw_private *dev_priv,
 	if (unlikely(!dev_priv->has_mob))
 		return 0;
 
+	if (unlikely(cmd->header.size < sizeof(cmd->body))) {
+		VMW_DEBUG_USER("Shader define cmd header.size smaller than body.\n");
+		return -EINVAL;
+	}
+
 	size = cmd->header.size - sizeof(cmd->body);
 	ret = vmw_compat_shader_add(dev_priv, vmw_context_res_man(ctx),
 				    cmd->body.shid, cmd + 1, cmd->body.type,
-- 
2.47.3


