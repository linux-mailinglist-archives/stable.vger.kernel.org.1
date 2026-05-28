Return-Path: <stable+bounces-256433-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6HanHGfCGGp4nAgAu9opvQ
	(envelope-from <stable+bounces-256433-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 00:32:07 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 193345FAFD5
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 00:32:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 689DE300E03A
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD386369990;
	Thu, 28 May 2026 22:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XOcK1ThF"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D32F30567E
	for <stable@vger.kernel.org>; Thu, 28 May 2026 22:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780007521; cv=none; b=Ti9yhhml5rwg+umR8AJncwrpMtS/wsoOy+TOuf3qmDy2hfEgjN5DVPvj+bW6f0OucsAR9ujR8rrh/sbKIjBgnJJjkkCSLEWVl+TjcESolq/Cw50MH3cxn0Axk7bO7e62C/hJndrten2NtHtPEftPN7f75Eo+x+t0w24YF8ZQ1qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780007521; c=relaxed/simple;
	bh=0yNCf/FZmVdH7OxyVcTRK0azQYedr/GytLYxP6I0HHc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OwRSKoy2YDMAObX5y+Fb/EZX7WOFXaonz4W2sEn7vnSmn77TUIGyr5YV72xbwxpjCV6AMsrIMR4jFIVuHysDwwQZyaC698dTqjyVtg9BcoiXQi1wW1r3itoYMrnIu+7vSveBA8KpE0xFXbjNLkM3nUBKlSRU9QjgSSS9HIfsH08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wnliu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XOcK1ThF; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wnliu.bounces.google.com
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-1353ac304f3so18955412c88.0
        for <stable@vger.kernel.org>; Thu, 28 May 2026 15:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780007518; x=1780612318; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qnJY90lzCZa7sp51vCdlrsdl5wBeEKPOKUYIM3PKwp4=;
        b=XOcK1ThF2rp9uHAYf0JSW4eb30d/cXBQ26bDbPohArVRbmIOg2n58645Nd1xvjJ5jp
         /yzefYelQDYvTMJu93R9paFlWVcdzRLcQRjEb0TLg0D8s+vLV4hkn3DUHRN1BxtFviJg
         Zu4J5vnQcZC5aJ+mrF5dBrVXLMYQ5POqPqgmz6DWTocyVuEIrVDmCkrtvsaeAJltzAwI
         EHkPeQXw9mP0ZvRhawuGK86F3ytFclf3VbaoUBpyGWjZH4Yte3z2gW6MzuxojnexpgFA
         JeqDUFxtXZ0Rwiv2LdTP6NhU26h9itf3f8SR2ZgSijejR2YtzQJQyKU3Ws/+4D9vO38x
         IeWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780007518; x=1780612318;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qnJY90lzCZa7sp51vCdlrsdl5wBeEKPOKUYIM3PKwp4=;
        b=FBNzsQ8lJbUY6IuoXUTCuqf/yFf/WBLq0CIUocoQe/420qA6pHoX8pRgUoCoGH/N/J
         WYK3/1Up/USiP+zJNBtaIGRFe9OkEDz7EL4tApR4E+07u/FlQ2CprHr9ZHkyvx1F+FU4
         I4vRYy/V1d1uwlkN02AlPEx2ndbeoK21dKLBj9mSeT5noJxl84AXKSzFltC9fXI5bLbo
         qjdwIJ2CGnhkeROqZRUOTMM/8VGdoveYakEKSlOWt1r8aWAP/BaTniFTo56YqAigK0fz
         HIvn1q7lVMXOxMjgcSqj9Rkgb/QXls4FOeKrVZyCH5lx/VWxkVgUsRmrOd5KBbXR/9aO
         6D0w==
X-Forwarded-Encrypted: i=1; AFNElJ+yLCZ8xaA3sZdti6hXEi8XCjbPZaec71tV5D1luzf0hseTK2FmZ5+41QbBjCLOYg+smPmo2jg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw26V8nnu+9hPkZ4k5eqP/e++x6RhAVGptP6twdTIatZTctGK/S
	cC0+0iY/lU1ZXdFHffGN1rQow8U2+rmzBwmzXTh8pyg+NttVhMB9WhLR3YCTjqjhiKrYzFeecrp
	V1A==
X-Received: from dlbrl13.prod.google.com ([2002:a05:7022:f50d:b0:136:f9e9:6d7a])
 (user=wnliu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:ebc5:b0:12c:856:ddcc
 with SMTP id a92af1059eb24-137aeff8d97mr118590c88.27.1780007518036; Thu, 28
 May 2026 15:31:58 -0700 (PDT)
Date: Thu, 28 May 2026 22:31:47 +0000
In-Reply-To: <20260528223147.750229-1-wnliu@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260528223147.750229-1-wnliu@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260528223147.750229-2-wnliu@google.com>
Subject: [PATCH v2 1/1] iommu/amd: Don't split flush for amd_iommu_domain_flush_all()
From: Weinan Liu <wnliu@google.com>
To: iommu@lists.linux.dev, jgg@nvidia.com, joro@8bytes.org, 
	suravee.suthikulpanit@amd.com
Cc: will@kernel.org, patches@lists.linux.dev, stable@vger.kernel.org, 
	robin.murphy@arm.com, vasant.hegde@amd.com, santosh.shukla@amd.com, 
	chrisl@kernel.org, josef@toxicpanda.com, Weinan Liu <wnliu@google.com>, 
	Wei Wang <wei.w.wang@hotmail.com>, Samiullah Khawaja <skhawaja@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256433-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_CC(0.00)[kernel.org,lists.linux.dev,vger.kernel.org,arm.com,amd.com,toxicpanda.com,google.com,hotmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wnliu@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,amd.com:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 193345FAFD5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

We have observed multiple full invalidations occurring during device
detach when we are done using the vfio-device.

blocked_domain_attach_device()
  -> detach_device()
    -> amd_iommu_domain_flush_all()
      -> amd_iommu_domain_flush_pages(..., CMD_INV_IOMMU_ALL_PAGES_ADDRESS)

      	while (size != 0) {

          -> __domain_flush_pages( flush_size /* power of 2 flush_size */)
            -> domain_flush_pages_v1()
              -> build_inv_iommu_pages()
                -> build_inv_address()

         }

build_inv_address() will trigger a full invalidation  if the chunk
size > (1 << 51). Consequently, the guest will issue multiple full
invalidations for a single call to  amd_iommu_domain_flush_all()

Without this patch, we will see 10 time instead of 1 time full
invalidations for every amd_iommu_domain_flush_all().

Cc: stable@vger.kernel.org
Fixes: a270be1b3fdf ("iommu/amd: Use only natural aligned flushes in a VM")
Suggested-by: Josef Bacik <josef@toxicpanda.com>
Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Weinan Liu <wnliu@google.com>
Reviewed-by: Wei Wang <wei.w.wang@hotmail.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Samiullah Khawaja <skhawaja@google.com>
Reviewed-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/iommu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 57dc8fabc7d9..15ffc4742183 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1774,7 +1774,8 @@ void amd_iommu_domain_flush_pages(struct protection_domain *domain,
 {
 	lockdep_assert_held(&domain->lock);
 
-	if (likely(!amd_iommu_np_cache)) {
+	if (likely(!amd_iommu_np_cache) ||
+		size >= (1ULL<<52)) {
 		__domain_flush_pages(domain, address, size);
 
 		/* Wait until IOMMU TLB and all device IOTLB flushes are complete */
-- 
2.54.0.823.g6e5bcc1fc9-goog


