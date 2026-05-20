Return-Path: <stable+bounces-252321-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UL8cMyH8DWru5AUAu9opvQ
	(envelope-from <stable+bounces-252321-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:23:29 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 65956595FCD
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:23:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 676903143CF3
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 076723FB069;
	Wed, 20 May 2026 18:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xY3ORxPw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C81A73A6B6D;
	Wed, 20 May 2026 18:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779300370; cv=none; b=oH2TL299GyDZu6ektD6jIomZ3GX/g1f44BY2r8gQfyPIRSXfEOVP+6xHKHOxUuKwMCmHw5Exdhd+Gar3cXrBDr5Kg4xNg+rzKInoHreRyuayq0a6sP48piC0M8BqcqRdu3MXoqY1H4e68WViBUs068icZxo+b91t0hqYPRMv/50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779300370; c=relaxed/simple;
	bh=g4yBgNbakceQEpSegLmwK8jkxr1MUmvhE7j70wwmdr4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dAFQ/XrRg5MyNcMtk1ViHz1AVif/m/ozOD2/phMGpvGzMVH+n/b5q28ocvaLv+oYTpSAMvZBWA33FK+c38H0VuF3OaT6MSZ0n6U64snfW5nKzCAzmD+RW8/d4YhFK/5EpqS1zSTOtbzYYlR8YglmyLa5WQ0XZaTOO7LU1bORGOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xY3ORxPw; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2564A1F000E9;
	Wed, 20 May 2026 18:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779300369;
	bh=uJn1KePT1vx3VOV/+fWqbvtQ1twjbpWQ+kguB9gt2Ow=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=xY3ORxPwXLhk8GddZBGzqy2BsKzVl3BcQu2kQ0NLJDIJaEU1GnrRrkgFFcUTIiw/j
	 Vsjs9/YY3MUcn/d/3Csg9S+Hk5aAN1JHm4l/X3BHJ4pzbDnBVTg67uCcSFdQSrAWGZ
	 rLbDEfw0BYViYq+TgD7lRcvApYPO9F9vPjQHYCUs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ethan Tidmore <ethantidmore06@gmail.com>,
	Chen-Yu Tsai <wens@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 122/666] drm/sun4i: backend: fix error pointer dereference
Date: Wed, 20 May 2026 18:15:33 +0200
Message-ID: <20260520162113.861868090@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162111.222830634@linuxfoundation.org>
References: <20260520162111.222830634@linuxfoundation.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-252321-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 65956595FCD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ethan Tidmore <ethantidmore06@gmail.com>

[ Upstream commit 06277983eca4a31d3c2114fa33d99a6e82484b11 ]

The function drm_atomic_get_plane_state() can return an error pointer
and is not checked for it. Add error pointer check.

Detected by Smatch:
drivers/gpu/drm/sun4i/sun4i_backend.c:496 sun4i_backend_atomic_check() error:
'plane_state' dereferencing possible ERR_PTR()

Fixes: 96180dde23b79 ("drm/sun4i: backend: Add a custom atomic_check for the frontend")
Signed-off-by: Ethan Tidmore <ethantidmore06@gmail.com>
Reviewed-by: Chen-Yu Tsai <wens@kernel.org>
Link: https://patch.msgid.link/20260217014801.60760-1-ethantidmore06@gmail.com
Signed-off-by: Chen-Yu Tsai <wens@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/sun4i/sun4i_backend.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/sun4i/sun4i_backend.c b/drivers/gpu/drm/sun4i/sun4i_backend.c
index e89eb96d31317..a7c256e2c632b 100644
--- a/drivers/gpu/drm/sun4i/sun4i_backend.c
+++ b/drivers/gpu/drm/sun4i/sun4i_backend.c
@@ -490,6 +490,9 @@ static int sun4i_backend_atomic_check(struct sunxi_engine *engine,
 	drm_for_each_plane_mask(plane, drm, crtc_state->plane_mask) {
 		struct drm_plane_state *plane_state =
 			drm_atomic_get_plane_state(state, plane);
+		if (IS_ERR(plane_state))
+			return PTR_ERR(plane_state);
+
 		struct sun4i_layer_state *layer_state =
 			state_to_sun4i_layer_state(plane_state);
 		struct drm_framebuffer *fb = plane_state->fb;
-- 
2.53.0




