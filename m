Return-Path: <stable+bounces-270688-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id L1riImySRmoiYwsAu9opvQ
	(envelope-from <stable+bounces-270688-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 18:31:40 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EBB4B6FA34E
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 18:31:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=D1jMZTu9;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-270688-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-270688-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F055B301E77C
	for <lists+stable@lfdr.de>; Thu,  2 Jul 2026 16:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CD56346A18;
	Thu,  2 Jul 2026 16:26:31 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3DEE37A84C;
	Thu,  2 Jul 2026 16:26:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783009591; cv=none; b=DbFURfgw7/K93ICYx5rX8WGArYJaQN8DQhUQJwy/oudsAFje35XyVjcRyWpVo6ChgS8R1GSwxl98/2aZseYZs5IERCkuK4+20oFwzz9yozTOGs/L7OHS/4LJI45ASWUiVjYbxjG26XUEHb2FmeE2oYITfG3CXU0CfG4Xi9mLBzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783009591; c=relaxed/simple;
	bh=lduNFFY9V800NeNLy56p0rwwiXG9hRxL0sMwQzu+CeI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ruu1M/b+ZwV6pKKfeQJcKXHRQCeur8VpoEMkhacZmXJj/+Hkk1x3fHW9QOs3FEsxzz+m+WA2gPVTtiaREcfb6OphxTevZ35QKEzv6ZkiGFHGtan/5SHzRpvd3fFLOClvTW6ZLmWrJkaaWH2YBeKGN1xDEDarKGYGiidDfA5rkPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=D1jMZTu9; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E69461F00A3A;
	Thu,  2 Jul 2026 16:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783009589;
	bh=GsJp4QIweRXqok4ZwMfIrMp04CtLbS+86Ewkqi0QUDY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=D1jMZTu9toJwXL06K2DVFjHgNa7inY3YbzmpqJGriKjotYX9e/zgWsPa6+u7Lj89w
	 Ne5DE6aICMXi0w7Ug9RrzePRCL4+XsYqU4mg1rk/Xm+AXy4pULeHyMWZJYcXrTyHVd
	 40pxCDxEw8AUjiaXDiTL61OMDv5ph90PCY56JEpw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jiacheng Shi <billsjc@sjtu.edu.cn>,
	Alex Williamson <alex.williamson@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 13/95] vfio/iommu_type1: replace kfree with kvfree
Date: Thu,  2 Jul 2026 18:19:16 +0200
Message-ID: <20260702155109.485592152@linuxfoundation.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260702155109.196223802@linuxfoundation.org>
References: <20260702155109.196223802@linuxfoundation.org>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-270688-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:billsjc@sjtu.edu.cn,m:alex.williamson@redhat.com,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linuxfoundation.org:dkim,linuxfoundation.org:mid,linuxfoundation.org:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EBB4B6FA34E

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jiacheng Shi <billsjc@sjtu.edu.cn>

[ Upstream commit 2bed2ced40c97b8540ff38df0149e8ecb2bf4c65 ]

Variables allocated by kvzalloc should not be freed by kfree.
Because they may be allocated by vmalloc.
So we replace kfree with kvfree here.

Fixes: d6a4c185660c ("vfio iommu: Implementation of ioctl for dirty pages tracking")
Signed-off-by: Jiacheng Shi <billsjc@sjtu.edu.cn>
Link: https://lore.kernel.org/r/20211212091600.2560-1-billsjc@sjtu.edu.cn
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/vfio/vfio_iommu_type1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index 6a89bbec738f62..2bc79eee63d524 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -262,7 +262,7 @@ static int vfio_dma_bitmap_alloc(struct vfio_dma *dma, size_t pgsize)
 
 static void vfio_dma_bitmap_free(struct vfio_dma *dma)
 {
-	kfree(dma->bitmap);
+	kvfree(dma->bitmap);
 	dma->bitmap = NULL;
 }
 
-- 
2.53.0




