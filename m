Return-Path: <stable+bounces-77159-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A69A5985973
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 13:53:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B4A3281CC6
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 11:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7177381AB4;
	Wed, 25 Sep 2024 11:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CKODyYvm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD0C1A0BD9;
	Wed, 25 Sep 2024 11:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727264345; cv=none; b=HBEUR/tjFwCVf6BcmgkTC40p7QcC+ctOVRcu2w3b1ilcAwAeHfe+yNBi0J0KLhwLQIWz9J9McSj2zleVQ65+ffgjQ807YqXWR3jUHzOXPviiJwW7Hfi7MLpM+6pXUe95rG4ZH6FiOMSJHw8VhaWriiEIrW8m3rUdVwETG1wQZXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727264345; c=relaxed/simple;
	bh=446wkpH8icSTeDLBK2xDgroNp0rLQWSfdW+D7dkJ2oI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nQ+N6LVNla7vwom5ETcoWRNelQG1NwEjXjVsCOvMJJ4Bh0bi7ZuUPd0j8O/bOhRWNAoKdO2Or6fONgP6BroP2/gAOPg+BoEL/jK0iHYcwWimSf41aVzDgalRnvJCGmWz5GkdwhXWTmjY7i32iULIQ4pDMWx9GAACtbbe0/vU7rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CKODyYvm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF665C4CECD;
	Wed, 25 Sep 2024 11:39:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727264345;
	bh=446wkpH8icSTeDLBK2xDgroNp0rLQWSfdW+D7dkJ2oI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CKODyYvmoVuXHDe8Aaw8KQa0N2TB9PFC83poy/yZzc+Yf6X8SQOydYcAEAGPVgyUW
	 bjJmV4XdV4oZWV80rrjwDiC1ID6aMiM+9iw3o4UMaC9njLJaH3gscaJE6iMlx3HGBI
	 DxF1gzahXcMC0vlyUPAUfvIlFf0uRQTvu8+mdYH5H/an4iLZB+Iz/wIuR7lz4LKu68
	 RuA7Bu3H3gAjbTqKYnDFodTIgj7xlXrob5q3anKFIXlsQL1IHQcfpb+sEN+YBeByNr
	 yYTeXfcgttQ6/vgJ3UaUI1Ee+BuZfVrCpoarEbl7XnENyiR9uW25hW8ABml3YvHtGf
	 pjAyVNV9cjtFg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Nikunj A Dadhania <nikunj@amd.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Borislav Petkov <bp@alien8.de>,
	Sasha Levin <sashal@kernel.org>,
	tglx@linutronix.de,
	mingo@redhat.com,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	ashish.kalra@amd.com,
	michael.roth@amd.com,
	brijesh.singh@amd.com,
	ardb@kernel.org,
	kevinloughlin@google.com,
	tzimmermann@suse.de,
	dan.j.williams@intel.com,
	sathyanarayanan.kuppuswamy@linux.intel.com,
	u.kleine-koenig@pengutronix.de
Subject: [PATCH AUTOSEL 6.11 061/244] virt: sev-guest: Ensure the SNP guest messages do not exceed a page
Date: Wed, 25 Sep 2024 07:24:42 -0400
Message-ID: <20240925113641.1297102-61-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925113641.1297102-1-sashal@kernel.org>
References: <20240925113641.1297102-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11
Content-Transfer-Encoding: 8bit

From: Nikunj A Dadhania <nikunj@amd.com>

[ Upstream commit 2b9ac0b84c2cae91bbaceab62df4de6d503421ec ]

Currently, struct snp_guest_msg includes a message header (96 bytes) and
a payload (4000 bytes). There is an implicit assumption here that the
SNP message header will always be 96 bytes, and with that assumption the
payload array size has been set to 4000 bytes - a magic number. If any
new member is added to the SNP message header, the SNP guest message
will span more than a page.

Instead of using a magic number for the payload, declare struct
snp_guest_msg in a way that payload plus the message header do not
exceed a page.

  [ bp: Massage. ]

Suggested-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Nikunj A Dadhania <nikunj@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Acked-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20240731150811.156771-5-nikunj@amd.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/include/asm/sev.h              | 2 +-
 drivers/virt/coco/sev-guest/sev-guest.c | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index 79bbe2be900eb..ee34ab00a8d6d 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -164,7 +164,7 @@ struct snp_guest_msg_hdr {
 
 struct snp_guest_msg {
 	struct snp_guest_msg_hdr hdr;
-	u8 payload[4000];
+	u8 payload[PAGE_SIZE - sizeof(struct snp_guest_msg_hdr)];
 } __packed;
 
 struct sev_guest_platform_data {
diff --git a/drivers/virt/coco/sev-guest/sev-guest.c b/drivers/virt/coco/sev-guest/sev-guest.c
index 6fc7884ea0a11..c86be0cd8ecd2 100644
--- a/drivers/virt/coco/sev-guest/sev-guest.c
+++ b/drivers/virt/coco/sev-guest/sev-guest.c
@@ -1090,6 +1090,8 @@ static int __init sev_guest_probe(struct platform_device *pdev)
 	void __iomem *mapping;
 	int ret;
 
+	BUILD_BUG_ON(sizeof(struct snp_guest_msg) > PAGE_SIZE);
+
 	if (!cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
 		return -ENODEV;
 
-- 
2.43.0


