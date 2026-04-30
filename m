Return-Path: <stable+bounces-242218-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CAI3AMTl82kK8gEAu9opvQ
	(envelope-from <stable+bounces-242218-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 01:29:08 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C1C484A8D8E
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 01:29:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E98953012205
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 23:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83DFC37F8C6;
	Thu, 30 Apr 2026 23:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kvhJKMr0"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D7DB3CA4B6
	for <stable@vger.kernel.org>; Thu, 30 Apr 2026 23:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777591741; cv=none; b=DpFnvPri6Mk5Hf7/Qbv99MaibcLUiT9J7gd3Ny2Xnvx4bP6xLYvRVNvf2FdLqMXC5jIk1qGutrw8W0iOCz+g1GvoNNkGE19pvNwc5l7DbUatTmEVRaE3F5aI/lo+Vm7lN8B61WyX8DHkjw4ImMTlD9MbQy4yqfIgOUAknQlpdoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777591741; c=relaxed/simple;
	bh=05e4kCmh5d4jmhjGWrDP68fi2cOhrwkmP/2S+lC/vVc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=R62d35fVPnCOz2oIWIxeba+Er+vkyLpYLlW6Em1TZTq/2heuE9+cceWIDzIIUXXVqr2q1abmOe3YKqE+VoZ+UHNZ3lYVFEaV+4VGaX4DNMDdCfuMBTCZFlfJirw6t2c9yIf52KY4m/bgpKJ5yf5/C+4Mc6OQloV5cL8H6dg3bCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wnliu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kvhJKMr0; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wnliu.bounces.google.com
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2dd6fb4c867so6511668eec.0
        for <stable@vger.kernel.org>; Thu, 30 Apr 2026 16:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777591736; x=1778196536; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=J7V+aJczrYa+luWKSbD/4vJrKAK9nvJvKMYrb9vqHfk=;
        b=kvhJKMr04ku1nxBeneCkLqKEo59xDl+HlYyDe/uSlCg5rEPkAjZ1I/vovf9lQaAOmr
         6sdpK+6R1WHTd6zAc/BQj/eIe7jSxObV85zAuH7DYOfUp7IjoCrNS46a+LwIc9kYF/2J
         Z2Wge3Ihd3owJ8YRB/sqEfhWvo0EBXGHyuTPw6nnKxA/Qt64iFmYm8Q3Gy5l5mHwWtyu
         HAJZjBWugdu/BhjsCDTVRZ6brPI9iss46rll8PFsitRd2PZQn5UMXrZoBN3GuOX3ktsL
         NHqle/Y7yZkMeegEprZmkUA3BPq4qrYIaxg0CdFWHFsgLAiuSC9Erv56I2x99pZVwFr4
         mPbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777591736; x=1778196536;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J7V+aJczrYa+luWKSbD/4vJrKAK9nvJvKMYrb9vqHfk=;
        b=cbUTlE0lfdQQdgWvMbLdNo2URkSD7QFosmM8raj4zCs4W19Km1UyBY1ty5/oKGWlql
         slohxWhOtvugxT4OEi5qF6EE58ssZOKSVDar+pjPgN0BPfUV+8AmbDo5SRYg+nNjfOyS
         StWFXnwjfhKkLcY+/JpZSq9Vrq1JHTAHFw5GNoNKC1kbTUFdGuj1222da9KpohKVPIV8
         kTgdmabGIFEN38imlYJuAvYsnTdKTbXPv+cNecpz24HDdtsPhqzmuEt1irYB4YRS0uCw
         S5EIg4faDRjo6wfT0Dn1FUr4aSGun/S7+czjSeG2N4r02vHTvgh00iOUP3Zr26LJSgR+
         tgDw==
X-Forwarded-Encrypted: i=1; AFNElJ+Fq1ByNfwlrVXm2HB1c2RMiqwWKpW3TvkAiVGnyAqH1SHjNqB8pLfRS9oF0+cjAOD9QJoI5Lw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8JNwd22JSRN9posMQyHwmgY3cmcdbJGNBt/iYP21Dt9Jyx4zo
	1WG0ZecMFM4NHseb1k8Qf8cuihoBEOsKEPQdxC6S9UxsyPExe9sUxREqe+tCA9KqGKLWfc7GusQ
	AYw==
X-Received: from dldnz3.prod.google.com ([2002:a05:701a:ca03:b0:12d:bd4b:5b09])
 (user=wnliu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:985:b0:12d:b7e5:a691
 with SMTP id a92af1059eb24-12df822905emr291576c88.7.1777591736300; Thu, 30
 Apr 2026 16:28:56 -0700 (PDT)
Date: Thu, 30 Apr 2026 23:28:51 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260430232851.236666-1-wnliu@google.com>
Subject: [PATCH] iommu/amd: Fix precedence order in set_dte_passthrough()
From: Weinan Liu <wnliu@google.com>
To: iommu@lists.linux.dev, jgg@nvidia.com, joro@8bytes.org, 
	suravee.suthikulpanit@amd.com
Cc: will@kernel.org, patches@lists.linux.dev, stable@vger.kernel.org, 
	robin.murphy@arm.com, vasant.hegde@amd.com, santosh.shukla@amd.com, 
	chrisl@kernel.org, Weinan Liu <wnliu@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: C1C484A8D8E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-242218-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wnliu@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

Bitwise OR | operator has a higher precedence than the ternary ?:
operatior. It will be incorrectly evaluated as:

new->data[1] |= (FIELD_PREP(...) | dev_data->ats_enabled) ? DTE_FLAG_IOTLB : 0;

Wrap the conditional operation in parentheses to enforce the
correct evaluation order.

Fixes: 93eee2a49c1b ("iommu/amd: Refactor logic to program the host page table in DTE")
Signed-off-by: Weinan Liu <wnliu@google.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/amd/iommu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 01171361f9bc..ccffbecb15c2 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2149,7 +2149,8 @@ static void set_dte_passthrough(struct iommu_dev_data *dev_data,
 	new->data[0] |= DTE_FLAG_TV | DTE_FLAG_IR | DTE_FLAG_IW;
 
 	new->data[1] |= FIELD_PREP(DTE_DOMID_MASK, domain->id) |
-			(dev_data->ats_enabled) ? DTE_FLAG_IOTLB : 0;
+			(dev_data->ats_enabled ? DTE_FLAG_IOTLB : 0);
+
 }
 
 static void set_dte_entry(struct amd_iommu *iommu,
-- 
2.54.0.545.g6539524ca2-goog


