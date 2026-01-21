Return-Path: <stable+bounces-211140-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wMLmBGI9cWnKfQAAu9opvQ
	(envelope-from <stable+bounces-211140-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 21:56:02 +0100
X-Original-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D115A5DABE
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 21:56:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 605078802AE
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 18:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 952FA3D6473;
	Wed, 21 Jan 2026 18:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rA9vEWT6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B02F37BE9C;
	Wed, 21 Jan 2026 18:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769020574; cv=none; b=AxJqAGjmPp2Z/qI0nJOE/4xpyQ/wmH+3pFW88vq8ZPwlT0Mb71ez2t5yqL34Gn/jbyFzOcrDvQKz8nn+S/NBQUrUNf53udyK3Tt+3+aqjwa2lPITBL+TKNYQVwFMnnfXPiQrwj+RiybGEROsrdSob/hDcRrAC1YORLrnbHHdR6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769020574; c=relaxed/simple;
	bh=toqRmke59ka0v6HISf7AI/RBY0U5rtmuK6C1hNgltqk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EEZh1+Pa6v14kjXpBntp5DHv7uqnDET76CK2//aMEyI7Al4D4f32/hUZTYdIAMer4dIxnSvyIc0MvgNCFi9iUdoAq7LkOgTsPhchiX3nB6jOMSZeyoc5lZ0EZS/9bv4j8kgaaWWMvrasDv/l3vwthaG05MzrbXHy8ru2uPHI5Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rA9vEWT6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B4E7C2BC9E;
	Wed, 21 Jan 2026 18:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769020574;
	bh=toqRmke59ka0v6HISf7AI/RBY0U5rtmuK6C1hNgltqk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rA9vEWT67bt1KG5K9aVt61w7Kra/8V6J/ctgK5pzCHSX9xT9tPvtkSBhLzbvfmTuN
	 Ohro9x6N8NJWSgsbwjHe+UDpm6+GvQH1hRi/MOh+Q50wd0Az1CYpDbuD7br+b21jB2
	 t+ZvL84RYxGgW5zDfbD/XQisZRxiFEFfpL27c03E=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Carlos Llamas <cmllamas@google.com>,
	Baolu Lu <baolu.lu@linux.intel.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Joerg Roedel <joro@8bytes.org>,
	Kevin Tian <kevin.tian@intel.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Vasant Hegde <vasant.hegde@amd.com>,
	Will Deacon <will@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.18 198/198] iommu/sva: include mmu_notifier.h header
Date: Wed, 21 Jan 2026 19:17:06 +0100
Message-ID: <20260121181425.684082633@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260121181418.537774329@linuxfoundation.org>
References: <20260121181418.537774329@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DMARC_POLICY_ALLOW(0.00)[linuxfoundation.org,none];
	TAGGED_FROM(0.00)[bounces-211140-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux-foundation.org:email,arm.com:email,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,amd.com:email,ziepe.ca:email]
X-Rspamd-Queue-Id: D115A5DABE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Carlos Llamas <cmllamas@google.com>

commit 4b5c493ff762bb0433529ca6870b284f0a2a5ca8 upstream.

A call to mmu_notifier_arch_invalidate_secondary_tlbs() was introduced in
commit e37d5a2d60a3 ("iommu/sva: invalidate stale IOTLB entries for kernel
address space") but without explicitly adding its corresponding header
file <linux/mmu_notifier.h>.  This was evidenced while trying to enable
compile testing support for IOMMU_SVA:

   config IOMMU_SVA
          select IOMMU_MM_DATA
  -       bool
  +       bool "Shared Virtual Addressing" if COMPILE_TEST

The thing is for certain architectures this header file is indirectly
included via <asm/tlbflush.h>.  However, for others such as 32-bit arm the
header is missing and it results in a build failure:

  $ make ARCH=arm allmodconfig
  [...]
  drivers/iommu/iommu-sva.c:340:3: error: call to undeclared function 'mmu_notifier_arch_invalidate_secondary_tlbs' [...]
    340 |  mmu_notifier_arch_invalidate_secondary_tlbs(iommu_mm->mm, start, end);
        |  ^

Fix this by including the appropriate header file.

Link: https://lkml.kernel.org/r/20260105190747.625082-1-cmllamas@google.com
Fixes: e37d5a2d60a3 ("iommu/sva: invalidate stale IOTLB entries for kernel address space")
Signed-off-by: Carlos Llamas <cmllamas@google.com>
Cc: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Kevin Tian <kevin.tian@intel.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Vasant Hegde <vasant.hegde@amd.com>
Cc: Will Deacon <will@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iommu/iommu-sva.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/iommu/iommu-sva.c
+++ b/drivers/iommu/iommu-sva.c
@@ -3,6 +3,7 @@
  * Helpers for IOMMU drivers implementing SVA
  */
 #include <linux/mmu_context.h>
+#include <linux/mmu_notifier.h>
 #include <linux/mutex.h>
 #include <linux/sched/mm.h>
 #include <linux/iommu.h>



