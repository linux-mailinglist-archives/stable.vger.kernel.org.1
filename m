Return-Path: <stable+bounces-224181-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cJDsOgUBsGm0eQIAu9opvQ
	(envelope-from <stable+bounces-224181-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:31:17 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7545F24AE3E
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:31:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 20E8E316A246
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 11:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D5FA38734E;
	Tue, 10 Mar 2026 11:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GKjNVEb/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F60737F007;
	Tue, 10 Mar 2026 11:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773141637; cv=none; b=F6adUxNQevCV80o1ue/tPa2kDDBVtCnQI/PC9V4h7BY4XKr5frmCiVuM0XlRIuJwoYmCcgDDg8jkNaSsPqSgMOy11B8dqzhaODSwOUMz8pzrB1uhfIT4UdiVOFki6nVyTPFdIMnYFWbVZG9ehiK3fgOKW6EoRqdynXN3x3Rq0+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773141637; c=relaxed/simple;
	bh=36VkCf1QQuJZWzdgeoq6GL+tcgS0EPmoXav0euEbhtA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hFhCJGBxAJpjRd4hcPSevgNLcvvgoL+Yo5bR0HjcNCRyam3mAQY/AiIBtRs47kI3rZ65wJo2K8eIJGDJ9dOuvsAaSDEAmq5an5YRpXH8gSq5UCp45ukDC0rVI+BNtNMtfaZ+eNehxZBtNN5iB6YECVEM/uUvJRpJZHGHL83+oJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GKjNVEb/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D0D3C2BC9E;
	Tue, 10 Mar 2026 11:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773141637;
	bh=36VkCf1QQuJZWzdgeoq6GL+tcgS0EPmoXav0euEbhtA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GKjNVEb/gEWKraQJ6hY4xuN4ZS5TIHSyxnPlCj6egYkI7P60khr8/4rH5dXmEghWw
	 /+AfCIOSqXm67/H7cySjWOyfU8hL5Q2fI6V2e8eKHLYqhW+Uxs84Ph0fYWktT8ctQA
	 PYUuIvK6PKK/wCGbVr43p5AX/hT57vvkE/tgsKCoiGOEqyZ8Mt3Mz+KxdiXDcJJI8U
	 OX23HmF9ufip9fYzZM7tkpswo8N5lFSGYmaak86n9o9Twt7eZObZcA0O2WxTu2Bhg5
	 L2R8B+DXGj5ySgJbGm44OJ3RVwjGA880QJmETK9D3hsVfW0ITSjrs7q/z2q9QlHcBq
	 OHg8FoHvU2E2w==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Brad Spengler <brad.spengler@opensrcsec.com>,
	Zack Rusin <zack.rusin@broadcom.com>,
	Ian Forbes <ian.forbes@broadcom.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 002/314] drm/vmwgfx: Fix invalid kref_put callback in vmw_bo_dirty_release
Date: Tue, 10 Mar 2026 07:14:21 -0400
Message-ID: <066afb100e3c46b7a04fe72f03ec4b741f5cb820.1773141555.git.sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1773141554.git.sashal@kernel.org>
References: <cover.1773141554.git.sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 7545F24AE3E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-224181-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

From: Brad Spengler <brad.spengler@opensrcsec.com>

[ Upstream commit 211ecfaaef186ee5230a77d054cdec7fbfc6724a ]

The kref_put() call uses (void *)kvfree as the release callback, which
is incorrect. kref_put() expects a function with signature
void (*release)(struct kref *), but kvfree has signature
void (*)(const void *). Calling through an incompatible function pointer
is undefined behavior.

The code only worked by accident because ref_count is the first member
of vmw_bo_dirty, making the kref pointer equal to the struct pointer.

Fix this by adding a proper release callback that uses container_of()
to retrieve the containing structure before freeing.

Fixes: c1962742ffff ("drm/vmwgfx: Use kref in vmw_bo_dirty")
Signed-off-by: Brad Spengler <brad.spengler@opensrcsec.com>
Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
Cc: Ian Forbes <ian.forbes@broadcom.com>
Link: https://patch.msgid.link/20260107171236.3573118-1-zack.rusin@broadcom.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_page_dirty.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_page_dirty.c b/drivers/gpu/drm/vmwgfx/vmwgfx_page_dirty.c
index fd4e76486f2d1..45561bc1c9eff 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_page_dirty.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_page_dirty.c
@@ -260,6 +260,13 @@ int vmw_bo_dirty_add(struct vmw_bo *vbo)
 	return ret;
 }
 
+static void vmw_bo_dirty_free(struct kref *kref)
+{
+	struct vmw_bo_dirty *dirty = container_of(kref, struct vmw_bo_dirty, ref_count);
+
+	kvfree(dirty);
+}
+
 /**
  * vmw_bo_dirty_release - Release a dirty-tracking user from a buffer object
  * @vbo: The buffer object
@@ -274,7 +281,7 @@ void vmw_bo_dirty_release(struct vmw_bo *vbo)
 {
 	struct vmw_bo_dirty *dirty = vbo->dirty;
 
-	if (dirty && kref_put(&dirty->ref_count, (void *)kvfree))
+	if (dirty && kref_put(&dirty->ref_count, vmw_bo_dirty_free))
 		vbo->dirty = NULL;
 }
 
-- 
2.51.0


