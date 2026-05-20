Return-Path: <stable+bounces-251387-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gPQzKvf7DWoK5QUAu9opvQ
	(envelope-from <stable+bounces-251387-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:22:47 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B0231595EED
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:22:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 670B431AEC93
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0C9B3F23A4;
	Wed, 20 May 2026 17:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fw9bKHnr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69CF63F2115;
	Wed, 20 May 2026 17:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779297847; cv=none; b=HHRJMBPQfl2S80HehY5S6iXACEeNdwHv8PlYakmaNP0bm9H7FaRPdbbybRVKLPQ8/1jt2M0m5bZYG7xU2yU5b2JJt8RlCBrYsyahj4GqlWzx3wxhX0zXvNkSavDXFKR9/2t562o0TZfFkgWLgiCZs50s8dhxN/USr3fhbIDO3w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779297847; c=relaxed/simple;
	bh=Jqs6j9PQobd+8z8RtsE1LxBSLvRZkKuOxGJpnWTbiiE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=el5my1XRIvMojQzLmEB/WP7G74OTI3nxMoCC1bL9pYDU+eSnehV4RrLvXOWLhjku4paWmFBMhfZauLD0hVI06qwhy3/czUCUMwuxVhcMQbCZGMnzqVElGlz9AnJbxau3JdWhTgucec7Vu1NBFKDutUMuSzFxDi5ejfAaHga9rFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fw9bKHnr; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF4281F000E9;
	Wed, 20 May 2026 17:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779297846;
	bh=oyFLgoZiQdUXyH9xWnPNfJ12fvXQosmPGOUpUinCQpI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fw9bKHnr7BZuXoTuG2fk+rUN/Sq3Zy1wZ5y5STK/quZKvcZjePy0xzCmga6u5yKkX
	 XVlxYxJgLZZCTiWxeNB47d6UuSlZTVLcA3SXvG3czL3XWv43Iyk2N5qJ7AgGxW0v1l
	 TkeLYUQRJ+pG1412c7jA49OPAo4FDzeTwPGnmuB8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Val Packett <val@invisiblethingslab.com>,
	Dmitry Osipenko <dmitry.osipenko@collabora.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 187/957] drm/virtio: Allow importing prime buffers when 3D is enabled
Date: Wed, 20 May 2026 18:11:10 +0200
Message-ID: <20260520162138.607952386@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162134.554764788@linuxfoundation.org>
References: <20260520162134.554764788@linuxfoundation.org>
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
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-251387-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,collabora.com:email,invisiblethingslab.com:email,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: B0231595EED
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Val Packett <val@invisiblethingslab.com>

[ Upstream commit df4dc947c46bb9f80038f52c6e38cb2d40c10e50 ]

This functionality was added for using a KMS-only virtgpu with a physical
(or SR-IOV) headless GPU in passthrough, but it should not be restricted
to KMS-only mode. It can be used with cross-domain to pass guest memfds
to the host compositor with zero copies (using udmabuf on both sides).

Drop the check for the absence of virgl_3d to allow for more use cases.

Fixes: ca77f27a2665 ("drm/virtio: Import prime buffers from other devices as guest blobs")
Signed-off-by: Val Packett <val@invisiblethingslab.com>
Reviewed-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Link: https://patch.msgid.link/20251210154755.1119861-2-val@invisiblethingslab.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/virtio/virtgpu_prime.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_prime.c b/drivers/gpu/drm/virtio/virtgpu_prime.c
index ce49282198cbf..2fedd5d3bd62c 100644
--- a/drivers/gpu/drm/virtio/virtgpu_prime.c
+++ b/drivers/gpu/drm/virtio/virtgpu_prime.c
@@ -312,7 +312,7 @@ struct drm_gem_object *virtgpu_gem_prime_import(struct drm_device *dev,
 		}
 	}
 
-	if (!vgdev->has_resource_blob || vgdev->has_virgl_3d)
+	if (!vgdev->has_resource_blob)
 		return drm_gem_prime_import(dev, buf);
 
 	bo = kzalloc(sizeof(*bo), GFP_KERNEL);
-- 
2.53.0




