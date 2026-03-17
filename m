Return-Path: <stable+bounces-226094-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AL8uNatvuWm8EgIAu9opvQ
	(envelope-from <stable+bounces-226094-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 16:13:47 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D22C2ACC2F
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 16:13:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7114A3098595
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 15:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CC833EB813;
	Tue, 17 Mar 2026 15:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CJkiIDO4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1FEC3AB273;
	Tue, 17 Mar 2026 15:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773760068; cv=none; b=RH4cCoItKWW027BuLMhowZHPjkGx17OjLe5s1hrIS0jb3BKBroD4lw2wJWu4SaZtgaczA57WpErHago+6QqysrkoFsySHH4zfxh2Px/TZyfoodfc3p4edXbslDmeYW1GpIoPgW03Gckp7l/aMefZXaBMS6CkeVT9vQWi+Qzd0/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773760068; c=relaxed/simple;
	bh=AAkLl6I8DEWD0DH3jFQPg+HmOR+tfYeIuPntrROUHX0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=I+guvtAf3UCEChCVKLKhPQS1lxnZE2FIFEh28OTPcGkNmani7mRYvc1gqxWGxmom11rAMpAUspRjNLrujFLd7yf3AKSc1nFoEfoZHcWciZQpJosTguIKkBiXXM5OcDnIs2VAaLkr8f7WyOjUD+MS2bNfeQ/NAwnTCnlfOSxBGW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CJkiIDO4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2EB0FC2BCB3;
	Tue, 17 Mar 2026 15:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773760068;
	bh=AAkLl6I8DEWD0DH3jFQPg+HmOR+tfYeIuPntrROUHX0=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=CJkiIDO4+q3revlyLViqNBCHkB/zglhH9iZF+KJap2fLvMkWzLxZeq/XuwC5TqL3Y
	 g3c8rNhhwNQD1FHScpHpi5zD2n2yKN3Y1/CKPC9JyygzZcaMBfrOk7kXcyDUTeEDuD
	 1swlZiNsmJIKv+9HJ48VRYX8erFPqBjkMCVRPr6tQTo4/ya1ICkDkivBww6p4UCetw
	 m+rz29rngqqZw4AESbYyxoHBYoptfHTwNt3vcDyw+W0QTW94DMgm980KL0FiLECLHE
	 vNMxpwNk9NKLC77dHRD8gE/faAqJ1qdmaYvArtjYfR1rLV0894mPDjF0Y5xq4QkHj3
	 bByHAQm4+vNoQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04D4AFED9E4;
	Tue, 17 Mar 2026 15:07:48 +0000 (UTC)
From: Max Boone via B4 Relay <devnull+mboone.akamai.com@kernel.org>
Date: Tue, 17 Mar 2026 16:07:45 +0100
Subject: [PATCH] vfio/type1: Retry follow_pfnmap_start() when PFNMAP is
 zapped
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260317-retry-pin-on-reclaimed-pud-v1-1-1f0d0a23f78d@akamai.com>
X-B4-Tracking: v=1; b=H4sIAEBuuWkC/x3MQQqDMBAF0KvIrB3QCLZ6FXGhyU87UGOY2KKId
 zd0+TbvpAQVJOqLkxQ/SbKGjLosyL6n8AKLyyZTmbZq6gcrNj04SuA1ZNjPJAscx69j5+cOpsX
 8tJ5yEBVe9n8+jNd1A2Wt4g5sAAAA
X-Change-ID: 20260317-retry-pin-on-reclaimed-pud-dfb9e26eb8cf
To: Alex Williamson <alex@shazbot.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Max Boone <mboone@akamai.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773760067; l=2028;
 i=mboone@akamai.com; s=20260317; h=from:subject:message-id;
 bh=b2j73waNF0S5HuzVon7vQ+MYHgI3mNVa+AVmFCvIi3w=;
 b=7xTZNEDX40oqQAxYCRx209sugRRIcmmUHTQXOgPlFSP+GvJ/znoV8z5HCrd3iwy17TATbR+ZE
 Scmbbbu2iNSAQegKpxl0SkrHLBDsmcOHOjVj1zVDbbLDnYUY6mHcsFZ
X-Developer-Key: i=mboone@akamai.com; a=ed25519;
 pk=jWdC/h5H2KWQCiC2kpr/puMVX0mJmP9W5sM8YTGBXA4=
X-Endpoint-Received: by B4 Relay for mboone@akamai.com/20260317 with
 auth_id=685
X-Original-From: Max Boone <mboone@akamai.com>
Reply-To: mboone@akamai.com
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-226094-lists,stable=lfdr.de,mboone.akamai.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_REPLYTO(0.00)[mboone@akamai.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,stable@vger.kernel.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,akamai.com:email,akamai.com:replyto,akamai.com:mid]
X-Rspamd-Queue-Id: 7D22C2ACC2F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Max Boone <mboone@akamai.com>

A race between page table walking (e.g. via procfs numa_maps) and VFIO DMA
pinning can lead to temporary failures in follow_pfnmap_start(). When a
PUD entry is split and concurrently refaulted, the PFNMAP mapping may be
temporarily zapped, causing follow_pfnmap_start() to return an error.

Although follow_pfnmap_start() returns an -EINVAL this is not due to
invalid parameters, but rather because of the pfnmap being non-present.
Treat it as such, and retry by returning -EAGAIN, similar to how GUP
handles such races.

This avoids propagating an unexpected -EINVAL to userspace, like follows:
[dma_map]
dma_map iova=0x000000000000 size=0x000004000000 vaddr=0x00007f7800000000
dma_map FAILED iova=0x020000000000: [Errno 22] Invalid argument
dma_map iova=0x040000000000 size=0x000002000000 vaddr=0x00007f5780000000

Which would've succeeded on a retry.

Cc: stable@vger.kernel.org
Fixes: a77f9489f1d7 ("vfio: use the new follow_pfnmap API")
Signed-off-by: Max Boone <mboone@akamai.com>
---
 drivers/vfio/vfio_iommu_type1.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index 5167bec14..3a0d0bbb9 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -559,9 +559,17 @@ static int follow_fault_pfn(struct vm_area_struct *vma, struct mm_struct *mm,
 		if (ret)
 			return ret;
 
+		/*
+		 * follow_pfnmap_start() returns -EINVAL for
+		 * invalid parameters and non-present entries.
+		 * If that happens here after a successful
+		 * fixup_user_fault(), it is likely that the
+		 * pfnmap has been zapped. Retry instead of
+		 * failing.
+		 */
 		ret = follow_pfnmap_start(&args);
 		if (ret)
-			return ret;
+			return -EAGAIN;
 	}
 
 	if (write_fault && !args.writable) {

---
base-commit: 96ca4caf9066f5ebd35b561a521af588a8eb0215
change-id: 20260317-retry-pin-on-reclaimed-pud-dfb9e26eb8cf

Best regards,
-- 
Max Boone <mboone@akamai.com>



