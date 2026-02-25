Return-Path: <stable+bounces-219026-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ACUCEDFanmkjUwQAu9opvQ
	(envelope-from <stable+bounces-219026-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 03:10:57 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 89568190A84
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 03:10:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1B42E32EB48D
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 01:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A42EC27603A;
	Wed, 25 Feb 2026 01:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uTk3Z1Oe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6788626F46F;
	Wed, 25 Feb 2026 01:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771983940; cv=none; b=jsWuBK+5iSPwoWlNHAtANYiYi/WrYFzjlr5YDtFRHN24vFRw3T2B5jI6LIoAoIJ4FtUnlzWlgW9/eWCre/oHiNAh0OTski9tB15R9/szwbGFpwsJqDjqpe0BsA+QFQ/Yg8kq5RWbhpdsJYj8rddr8O6V3n6VUFIurBl5R3ZQGuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771983940; c=relaxed/simple;
	bh=HlkygQBv8Lu8fuv5npVtPZFRaM2wBbYMJ3x24AVCRag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PEcOrNe/kwbfEfo1tqUXrAxlRDrA6NkyPUFB50Tyek5i80qcJze7d4C/It+8QTt6vI9mf1gZsMP9FSnZjVb560QNUK7gERJuTRNi7VMewgs5IIWNVhMdjudVNY27grM8kIX6FSYkzNGZS+uty0dk4U2eM6xwSC6AQfXqDHLeuV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uTk3Z1Oe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 269C3C2BC9E;
	Wed, 25 Feb 2026 01:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771983940;
	bh=HlkygQBv8Lu8fuv5npVtPZFRaM2wBbYMJ3x24AVCRag=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uTk3Z1Oec+nhhlVUejMbOEnQ6ii8XOJgQnJTBAp+pGKjDX+3XTF4oOoloXkJncBtB
	 LszKCOVNH3C679QxDnABQB1Zubsorki00vtGdjjDL9aBZBoxGQ8kRu9GB9cFYpPb+Q
	 xD1Wy3bsAVUr04NCIIvblHXk4cclrXPwD6qt16dk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Micha=C5=82=20Grzelak?= <michal.grzelak@intel.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Matthew Auld <matthew.auld@intel.com>,
	Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 204/641] drm/buddy: release free_trees array on buddy mm teardown
Date: Tue, 24 Feb 2026 17:18:50 -0800
Message-ID: <20260225012353.908825341@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225012348.915798704@linuxfoundation.org>
References: <20260225012348.915798704@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-219026-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url,amd.com:email,intel.com:email]
X-Rspamd-Queue-Id: 89568190A84
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michał Grzelak <michal.grzelak@intel.com>

[ Upstream commit 7d0507772406e129329983b8b807e5b499bd74fd ]

During initialization of DRM buddy memory manager at drm_buddy_init,
mm->free_trees array is allocated for both clear and dirty RB trees.
During cleanup happening at drm_buddy_fini it is never freed, leading to
following memory leaks observed on xe module load & unload cycles:

    kmemleak_alloc+0x4a/0x90
    __kmalloc_cache_noprof+0x488/0x800
    drm_buddy_init+0xc2/0x330 [drm_buddy]
    __xe_ttm_vram_mgr_init+0xc3/0x190 [xe]
    xe_ttm_stolen_mgr_init+0xf5/0x9d0 [xe]
    xe_device_probe+0x326/0x9e0 [xe]
    xe_pci_probe+0x39a/0x610 [xe]
    local_pci_probe+0x47/0xb0
    pci_device_probe+0xf3/0x260
    really_probe+0xf1/0x3c0
    __driver_probe_device+0x8c/0x180
    driver_probe_device+0x24/0xd0
    __driver_attach+0x10f/0x220
    bus_for_each_dev+0x7f/0xe0
    driver_attach+0x1e/0x30
    bus_add_driver+0x151/0x290

Deallocate array for free trees when cleaning up buddy memory manager
in the same way as if going through out_free_tree label.

Fixes: d4cd665c98c1 ("drm/buddy: Separate clear and dirty free block trees")
Signed-off-by: Michał Grzelak <michal.grzelak@intel.com>
Reviewed-by: Lucas De Marchi <lucas.demarchi@intel.com>
Reviewed-by: Matthew Auld <matthew.auld@intel.com>
Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
Link: https://patch.msgid.link/20251208102714.4008260-2-michal.grzelak@intel.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/drm_buddy.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/drm_buddy.c b/drivers/gpu/drm/drm_buddy.c
index f2c92902e4a30..3f1a9892f2a39 100644
--- a/drivers/gpu/drm/drm_buddy.c
+++ b/drivers/gpu/drm/drm_buddy.c
@@ -419,6 +419,7 @@ void drm_buddy_fini(struct drm_buddy *mm)
 
 	for_each_free_tree(i)
 		kfree(mm->free_trees[i]);
+	kfree(mm->free_trees);
 	kfree(mm->roots);
 }
 EXPORT_SYMBOL(drm_buddy_fini);
-- 
2.51.0




