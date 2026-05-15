Return-Path: <stable+bounces-248914-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GItbGpiHB2r57AIAu9opvQ
	(envelope-from <stable+bounces-248914-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 22:52:40 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C854A55790A
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 22:52:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F30D7301F9C5
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 20:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF88C3806BE;
	Fri, 15 May 2026 20:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="oUAnb6tB"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E282830C174
	for <stable@vger.kernel.org>; Fri, 15 May 2026 20:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778878340; cv=none; b=c0l3m8hAlO43HfT1Non/3JrgZtWDOUeqGT2N6CdU07q9QWF55tUUu82NrvkTR3/NzLjLZT196KMJJeWkQIra4ahLsbcFnU9ZOtiD1/QIUlJyUUzj1KLTirSt8QNIU9uKFvKU64WTT2JVJXEtDxa7ZmZGNyjRebKCnjBlE6McMKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778878340; c=relaxed/simple;
	bh=aU/xMV9aWpKDWBZEhdVcCSMmoyoJq6aZqA6ER8YjfBA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BFER9rGXnkQxmkNVW/ZvDHtss1zhYNFqnWKwK5zrtcTditgVJsDCjhKPAL7BEJkS7BCdLbckkEZuburwdBMs2IQ+wK9eKNyBpl5PofiIh4Oopi4DnQcqh2Mij+vrHh1gDfZA2P4H0Lq2aL34Bzp9mliBvZW9ApdkEYcs9W1ggPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=oUAnb6tB; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=DS8crGkR+tGxMETel+kJ1n9ByseNGPjlGdYOSm5+Ck0=; b=oUAnb6tB4/0IvHUo8eqowBMr3O
	NK9zAwB9XMy+bnHQhhStUYeGHV1XDGDyVcsGYXBFXT2Wxb12gDELrUx3Sq7RhnRAnU17z8752u2JE
	R6Wap02ygy/+ptqegmnJw8dIKDrbgyZkzko/7Utc6IB76vhbdj6JBBq/P8rd/7CFLfSiyUzpVg/J1
	9R0GUnh1evDL9iArSYQay1W2/HLlhJah0Q/1Ko0xJ+aW99d1iPl3Ix/9R72QuoRMObEV/NSl+fAhw
	TFfmpkWKA3HxFhaE3VI4AdIW9FI37151qbWESqPQ0m0KF7y4BdJd3aNbM9MMnnZVHL7X2FbyT9ksn
	WBHdHHQA==;
Received: from [189.7.87.67] (helo=prince)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1wNzW4-000gmO-82; Fri, 15 May 2026 22:52:16 +0200
From: =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
To: stable@vger.kernel.org
Cc: kernel-dev@igalia.com,
	Ashutosh Desai <ashutoshdesai993@gmail.com>,
	=?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
Subject: [PATCH 6.6.y] drm/v3d: Reject empty multisync extension to prevent infinite loop
Date: Fri, 15 May 2026 17:51:58 -0300
Message-ID: <20260515205157.2325306-2-mcanal@igalia.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <2026051531-plexiglas-mumbling-3aa6@gregkh>
References: <2026051531-plexiglas-mumbling-3aa6@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C854A55790A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.64 / 15.00];
	R_DKIM_REJECT(1.00)[igalia.com:s=20170329];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[igalia.com : SPF not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-248914-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[igalia.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mcanal@igalia.com,stable@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[igalia.com:-];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	NEURAL_SPAM(0.00)[0.193];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Action: no action

From: Ashutosh Desai <ashutoshdesai993@gmail.com>

v3d_get_extensions() walks a userspace-provided singly-linked list of
ioctl extensions without any bound on the chain length. A local user
can craft a self-referential extension (ext->next == &ext) with zero
in_sync_count and out_sync_count, which bypasses the existing duplicate-
extension guard:

    if (se->in_sync_count || se->out_sync_count)
            return -EINVAL;

The guard never fires because v3d_get_multisync_post_deps() returns
immediately when count is zero, leaving both fields at zero on every
iteration. The result is an infinite loop in kernel context, blocking
the calling thread and pegging a CPU core indefinitely.

Fix this by rejecting a multisync extension where both in_sync_count
and out_sync_count are zero in v3d_get_multisync_submit_deps(). An
empty multisync carries no synchronization information and serves no
useful purpose, so returning -EINVAL for such an extension is the
correct defense against this attack vector.

Fixes: e4165ae8304e ("drm/v3d: add multiple syncobjs support")
Cc: stable@vger.kernel.org
Signed-off-by: Ashutosh Desai <ashutoshdesai993@gmail.com>
Link: https://patch.msgid.link/20260415050000.3816128-1-ashutoshdesai993@gmail.com
Signed-off-by: Maíra Canal <mcanal@igalia.com>
(cherry picked from commit fb44d589bf3148e13452185a6e772a7efbf2d684)
Signed-off-by: Maíra Canal <mcanal@igalia.com>
---
 drivers/gpu/drm/v3d/v3d_gem.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/v3d/v3d_gem.c b/drivers/gpu/drm/v3d/v3d_gem.c
index ef991a9b1c6c..057f9525a8a4 100644
--- a/drivers/gpu/drm/v3d/v3d_gem.c
+++ b/drivers/gpu/drm/v3d/v3d_gem.c
@@ -597,6 +597,11 @@ v3d_get_multisync_submit_deps(struct drm_file *file_priv,
 	if (multisync.pad)
 		return -EINVAL;
 
+	if (!multisync.in_sync_count && !multisync.out_sync_count) {
+		DRM_DEBUG("Empty multisync extension\n");
+		return -EINVAL;
+	}
+
 	ret = v3d_get_multisync_post_deps(file_priv, data, multisync.out_sync_count,
 					  multisync.out_syncs);
 	if (ret)
-- 
2.54.0


