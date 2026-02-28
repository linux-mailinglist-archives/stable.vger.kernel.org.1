Return-Path: <stable+bounces-220426-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4KcGDbI6o2nO+gQAu9opvQ
	(envelope-from <stable+bounces-220426-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:57:54 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 83A001C675C
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:57:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 88BDE34194C1
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1A233B2B9B;
	Sat, 28 Feb 2026 17:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YelTuJbl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C5093B2B90;
	Sat, 28 Feb 2026 17:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300316; cv=none; b=SUMU5CNK1QH5dxaX+2i0Cs3NmsniQyr+pdqJRwonDYcJdVIal/VKKPrECjITVEUqmVrmiWu90a6csOOViAJAih9uW5NUaX6v+CGOYaHFmknJoJl/sFfhgSne6N0UbDkiyj75xXR+faq8UIXQ2DhaRIGRREeKpBvuHiIaG6JEFiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300316; c=relaxed/simple;
	bh=r4lrx2nj3u2+CGFN1JGcpYkK+fPBSPbhx/8GeLZs6mg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wv01DHMR52jB7+gsfshkyWcCLivrgiaNl1SUCMGTeOApuvVIjiCfb81Vkc/GgpEQFsYYndBWB8wzsLFpBoeapH2LjkxIk37A2/6jMOTY6WZJp3ZFPTjooWGASaWF5C7vtcBpn+IU0yAHDjTMBq+DcdOUPuN1c3GHF7vuwBFIvno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YelTuJbl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E147C116D0;
	Sat, 28 Feb 2026 17:38:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300316;
	bh=r4lrx2nj3u2+CGFN1JGcpYkK+fPBSPbhx/8GeLZs6mg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YelTuJblD8CBDS12Jl1X3eA0Cb12WRokL7kKTYC2wGB1VQtNAucncVAp3XGDp1V2p
	 1JBuuD18onHjAK/hMiVqsdw0KUBykuQ7KWen0vRa/PQW+CyR63Dl8CiBwoLXG3IupT
	 uELD2zWmBCGzbLWLxErTHunE2yoGCnRYA87lYK6yAQB0wCjjUi2sEKbe5ehiisj/cD
	 1jR6oV+ZQnepr6sewuVADVSvZPF1wkQq5E7snknbLx9BlcNMfOpBIcqvpqA2rMf1Rz
	 Wfa5q1/Czf5IisfE1JnroaWkO/CvQUk+eAwE9jrJeoJuVgrVXGiOpNQzaHQ26vZfw4
	 W1PvpPLspdaXA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kommula Shiva Shankar <kshankar@marvell.com>,
	Jason Wang <jasowang@redhat.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 347/844] vhost: fix caching attributes of MMIO regions by setting them explicitly
Date: Sat, 28 Feb 2026 12:24:20 -0500
Message-ID: <20260228173244.1509663-348-sashal@kernel.org>
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220426-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,marvell.com:email,nvidia.com:email]
X-Rspamd-Queue-Id: 83A001C675C
X-Rspamd-Action: no action

From: Kommula Shiva Shankar <kshankar@marvell.com>

[ Upstream commit 5145b277309f3818e2db507f525d19ac3b910922 ]

Explicitly set non-cached caching attributes for MMIO regions.
Default write-back mode can cause CPU to cache device memory,
causing invalid reads and unpredictable behavior.

Invalid read and write issues were observed on ARM64 when mapping the
notification area to userspace via mmap.

Signed-off-by: Kommula Shiva Shankar <kshankar@marvell.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20260102065703.656255-1-kshankar@marvell.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/vhost/vdpa.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index 05a481e4c385a..b0179e8567aba 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -1527,6 +1527,7 @@ static int vhost_vdpa_mmap(struct file *file, struct vm_area_struct *vma)
 	if (vma->vm_end - vma->vm_start != notify.size)
 		return -ENOTSUPP;
 
+	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
 	vm_flags_set(vma, VM_IO | VM_PFNMAP | VM_DONTEXPAND | VM_DONTDUMP);
 	vma->vm_ops = &vhost_vdpa_vm_ops;
 	return 0;
-- 
2.51.0


