Return-Path: <stable+bounces-214233-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6r8BNjhvg2lqmwMAu9opvQ
	(envelope-from <stable+bounces-214233-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 17:09:28 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B8D7E9EF7
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 17:09:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 63259314EED4
	for <lists+stable@lfdr.de>; Wed,  4 Feb 2026 15:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 864F0407570;
	Wed,  4 Feb 2026 15:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="B8hZ4iwf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49AF0413254;
	Wed,  4 Feb 2026 15:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770219007; cv=none; b=BSa2MN6ytdvYC2Lnf+ANijmrAM1Z1ssEkVBKpdiaRkbVUpe03lD12jAF8cTudd9hfV9nTx0H0sfOi5ouDDKYHIXi54LqBEoznTFwcJ2iuiOQW1Br2lN3cyqR49XqqJdRXzFYXmOTAjzD98YdxkQ7z8z+8uV9KubG2uA0OfW5JUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770219007; c=relaxed/simple;
	bh=PVDfDHW1t8VA/Tolfuyq8Eaeca2W039/dzBrkob9/gM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V9LW5uD0ARq9sPZBCSHh4l23BpRmTW8c6xG/Kiii3LiIlaH2nEE5AJKJFHC7Sm77tF+cEQNLXCj5uvvExFVKMjmLGPkzcyZvosql4BlHWDLNiWTZkGWINCQSeAh8VOJ2HkgrVybHmTeSnyrFTbToO1ZiJUedf2jdl9TGcnSBk48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=B8hZ4iwf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4965C4CEF7;
	Wed,  4 Feb 2026 15:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770219007;
	bh=PVDfDHW1t8VA/Tolfuyq8Eaeca2W039/dzBrkob9/gM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B8hZ4iwfdlwyg7i/Kz1i4HwqJgYXpuK88pkMUuS1ByH9Uoen1JfAb/01Pi2QwH8m3
	 vp7NaHjdwagWgHnmxlGuxYdjau2/czzn79RDXxAbrzVp01fNYL1eT7hUXsIQ1ORhLG
	 FfNZBgTyv5x+N+v2QhuJE6Y3jdd+GIaK3k0TDU5c=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Matthew Brost <matthew.brost@intel.com>,
	Shuicheng Lin <shuicheng.lin@intel.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 040/122] drm/xe: Skip address copy for sync-only execs
Date: Wed,  4 Feb 2026 15:40:22 +0100
Message-ID: <20260204143853.302731430@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260204143851.857060534@linuxfoundation.org>
References: <20260204143851.857060534@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-214233-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,msgid.link:url,intel.com:email]
X-Rspamd-Queue-Id: 2B8D7E9EF7
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shuicheng Lin <shuicheng.lin@intel.com>

[ Upstream commit c73a8917b31e8ddbd53cc248e17410cec27f8f58 ]

For parallel exec queues, xe_exec_ioctl() copied the batch buffer address
array from userspace without checking num_batch_buffer.
If user creates a sync-only exec that doesn't use the address field, the
exec will fail with -EFAULT.
Add num_batch_buffer check to skip the copy, and the exec could be executed
successfully.

Here is the sync-only exec:
struct drm_xe_exec exec = {
    .extensions = 0,
    .exec_queue_id = qid,
    .num_syncs = 1,
    .syncs = (uintptr_t)&sync,
    .address = 0,            /* ignored for sync-only */
    .num_batch_buffer = 0,   /* sync-only */
};

Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel GPUs")
Cc: Matthew Brost <matthew.brost@intel.com>
Signed-off-by: Shuicheng Lin <shuicheng.lin@intel.com>
Reviewed-by: Matthew Brost <matthew.brost@intel.com>
Signed-off-by: Matthew Brost <matthew.brost@intel.com>
Link: https://patch.msgid.link/20260122214053.3189366-2-shuicheng.lin@intel.com
(cherry picked from commit 4761791c1e736273d612ff564f318bfbbb04fa4e)
Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/xe/xe_exec.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_exec.c b/drivers/gpu/drm/xe/xe_exec.c
index ca85f7c15fabe..87a32b61bece6 100644
--- a/drivers/gpu/drm/xe/xe_exec.c
+++ b/drivers/gpu/drm/xe/xe_exec.c
@@ -182,9 +182,9 @@ int xe_exec_ioctl(struct drm_device *dev, void *data, struct drm_file *file)
 		goto err_syncs;
 	}
 
-	if (xe_exec_queue_is_parallel(q)) {
-		err = copy_from_user(addresses, addresses_user, sizeof(u64) *
-				     q->width);
+	if (args->num_batch_buffer && xe_exec_queue_is_parallel(q)) {
+		err = copy_from_user(addresses, addresses_user,
+				     sizeof(u64) * q->width);
 		if (err) {
 			err = -EFAULT;
 			goto err_syncs;
-- 
2.51.0




