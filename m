Return-Path: <stable+bounces-220201-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QGwTE4Yro2mF+AQAu9opvQ
	(envelope-from <stable+bounces-220201-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:53:10 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E9FD1C52AD
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:53:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A740D3068149
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 17:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 587D04D2EF3;
	Sat, 28 Feb 2026 17:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mROXQa4z"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC444CA26C;
	Sat, 28 Feb 2026 17:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300107; cv=none; b=PIokPMotF3EevgfOj1SCtywX7L1uWW8joMd/MRiUcT/84bvPWTHDTzg0QcK2pN0r6xoqv2z38PtoYwi341s9cT7E3OogQrI8+/+1P65L26hcTMc/H27NFR3HhPdPnf1gfkk8yoBZ0niAHUVNNKhsGKO5V/e2a8CybszUVGwkTk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300107; c=relaxed/simple;
	bh=Q2NV62oJ9Rk/vMU9B7uyWbpa6IUD0HHYXjbz4QRK468=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BumdZBPVoeGdBEk+XktUi6RuexOIvkOJoXybS41DuPCXX4b89oyMhs58WnifXtFI/T8Dueqn+WGYir5RWDv2yYmsipphEhUM+GOgOf5Is6XVBniegco1Rlg/CzwRTI3NX4jZPNsQtajSSZAuV7FFNpQGSZUwXQg/WmmHbXo2jr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mROXQa4z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6492FC19425;
	Sat, 28 Feb 2026 17:35:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300107;
	bh=Q2NV62oJ9Rk/vMU9B7uyWbpa6IUD0HHYXjbz4QRK468=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mROXQa4z70cL4KsxQCjDl1jvvYgi32EJci9/hE0lom6GRekfxrA9682O02+AdQUE0
	 92kK35oh27FSKgaUVe1jaiJiXeKk0Cku5+iklN45L4xR6TdbI7vZWV8cDAjRVrrS3L
	 pHf0MifBWs/yQ8jUXTk8yqYAC8YaTuCoJqBw+9hzGX5jqp3l5BOi0PP//w6m1JXzeD
	 x6LA+3U8B6DbztKwW1OcjrPICyIMwvytwOzn3GDO6VQGF/z7zBbTBBSCKG0LLiyHW/
	 Qd5ObXauPpInUTz7fqYc7Yt30Ex+DUyEGR5qKlp/gCm/FXk5tny2G3uN3mjo347B8s
	 rkG8WP9R6Gu8w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Matthew Brost <matthew.brost@intel.com>,
	Tejas Upadhyay <tejas.upadhyay@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 123/844] drm/xe: Covert return of -EBUSY to -ENOMEM in VM bind IOCTL
Date: Sat, 28 Feb 2026 12:20:36 -0500
Message-ID: <20260228173244.1509663-124-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220201-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,msgid.link:url]
X-Rspamd-Queue-Id: 9E9FD1C52AD
X-Rspamd-Action: no action

From: Matthew Brost <matthew.brost@intel.com>

[ Upstream commit 6028f59620927aee2e15a424004012ae05c50684 ]

xe_vma_userptr_pin_pages can return -EBUSY but -EBUSY has special
meaning in VM bind IOCTLs that user fence is pending that is attached to
the VMA. Convert -EBUSY to -ENOMEM in this case as -EBUSY in practice
means we are low or out of memory.

Signed-off-by: Matthew Brost <matthew.brost@intel.com>
Reviewed-by: Tejas Upadhyay <tejas.upadhyay@intel.com>
Link: https://patch.msgid.link/20251122012502.382587-2-matthew.brost@intel.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/xe/xe_vm.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
index 095bb197e8b05..9781209dd26ed 100644
--- a/drivers/gpu/drm/xe/xe_vm.c
+++ b/drivers/gpu/drm/xe/xe_vm.c
@@ -2451,8 +2451,17 @@ static struct xe_vma *new_vma(struct xe_vm *vm, struct drm_gpuva_op_map *op,
 		if (IS_ERR(vma))
 			return vma;
 
-		if (xe_vma_is_userptr(vma))
+		if (xe_vma_is_userptr(vma)) {
 			err = xe_vma_userptr_pin_pages(to_userptr_vma(vma));
+			/*
+			 * -EBUSY has dedicated meaning that a user fence
+			 * attached to the VMA is busy, in practice
+			 * xe_vma_userptr_pin_pages can only fail with -EBUSY if
+			 * we are low on memory so convert this to -ENOMEM.
+			 */
+			if (err == -EBUSY)
+				err = -ENOMEM;
+		}
 	}
 	if (err) {
 		prep_vma_destroy(vm, vma, false);
-- 
2.51.0


