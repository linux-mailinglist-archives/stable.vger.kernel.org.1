Return-Path: <stable+bounces-242221-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OAtfJoHt82ms8wEAu9opvQ
	(envelope-from <stable+bounces-242221-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 02:02:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D4BD94A9140
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 02:02:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BC8BB3034BF8
	for <lists+stable@lfdr.de>; Fri,  1 May 2026 00:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DE12379ED6;
	Fri,  1 May 2026 00:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MZVbJGzh"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A3AB37A481
	for <stable@vger.kernel.org>; Fri,  1 May 2026 00:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777593669; cv=none; b=rXV8pGwg9YJzum0HguctbU1P6Rrb3rdXREvczb9N9QGriWhAUx4d7cwPWm7az6hG4AEO5yNCt7DUzfJK12ejF6Tc+CYtUSvbeKagdiVPajfjmRyd3U8zdx2aLgL3zHXBtFAT+kFR1hBpFAty4ASu1BJQKQx3euTTejfFgMNX3bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777593669; c=relaxed/simple;
	bh=vFS/zQjd56B3fLWY6rq0TVzIfgce3sBAg1mKjG6Ekhg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZTJrui48/0Nasbx3VplrE4/bAgcutUTF+LlewZj0uxfIT/DPFH6P8ajR/IT5pUbxpy7KjtQn887rLeUWZ8VG6d3bn8dHmtu8Q5jsIvM9pTz+SbkdhQBBRJkAixMR29U6VbQmWa/h0gIK687dGHOarylHr87wXOWIXStq8EjiFGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wnliu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MZVbJGzh; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wnliu.bounces.google.com
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2dd6fb4c867so6571871eec.0
        for <stable@vger.kernel.org>; Thu, 30 Apr 2026 17:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777593664; x=1778198464; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xHpNReJ/NE9/UeuqVc7wulNIRWGmhInh1blTLbI9Cu0=;
        b=MZVbJGzh55A9Su1fraIBCGJHPCGPv883TCnOE26A46HL7Uk0ygPwUwcbqna/ktyMuA
         XkkoXrtcgapn4K1gzycHOk2pMdsZgvZb4T9/BP2XgDAYMOPhmBE6poV/0falVx9LfHTS
         gUjyjk9inGcUeGaC1vAN7Hev7wzRG3SPdXYqr6IbSSYn5iqcSo53sI5xb9z7FpNogOnT
         smCHB3+Ojl35sdhAO0uorphQrQXqwp7/qxNftGJrUsXyilIwgdX841vPcKdz2Qr358q7
         uR5UmpQXDO7hFCqtXLUp2nM+Q/GoXGbNReImrFrrEJammXC7xeEse5/niq9k3W3i2tFV
         9MBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777593664; x=1778198464;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xHpNReJ/NE9/UeuqVc7wulNIRWGmhInh1blTLbI9Cu0=;
        b=su2q4gIPWDinDX5tjJlBlDBQHiAcA4a085FDk1e0CGx+XUn24wvpeQ/FTNBUSaBFxI
         wPf3f3bJyMDKuLTWU7N5wqDbmItvKy2f7BRSAQieSgHVO9IbMboD0jOiQuW7LPTQi9ic
         3fsaxZkS53B06qVWKM8pRWHzRJ5cDjGKmhpvsjB3nC4WtIOQTIejN9d9mV2ap/kkxrc1
         X90SZm1KyfbPFUJqUBIaY09/jBasMgk6e3XotpjQWYgq34oDJgRcVa33HDWdVBRSPAKW
         fBZXF5/aZT6et3iF7je5vOXmxFE8dLZI/A7naRSd6OlqA91wcxr+gOcuNzZZS9YgNS8p
         1fGg==
X-Forwarded-Encrypted: i=1; AFNElJ+eZNhhOlU5O6q6lG3HhaHblm/fcpkVRXfXQSRz7l6R8FnLDace60tofuMlNLTABhDL/4pGIPE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/beSo3BJD1o46WadNRkJHJKbOg3nneOFFSU+m1cr4KxXW2WdA
	4j/w6F1j1rR1OkR/bFAX12UafcwQKvgAS0gu5hR0FH2WdXmmstC7bxRw3/8re3M+02dgNa7E5Et
	mSg==
X-Received: from dybvi26.prod.google.com ([2002:a05:7301:531a:b0:2d8:dd18:baee])
 (user=wnliu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:1284:b0:2ed:e17:d50d
 with SMTP id 5a478bee46e88-2ee88e25449mr433736eec.32.1777593663040; Thu, 30
 Apr 2026 17:01:03 -0700 (PDT)
Date: Fri,  1 May 2026 00:00:59 +0000
In-Reply-To: <20260430232851.236666-1-wnliu@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260430232851.236666-1-wnliu@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260501000059.262516-1-wnliu@google.com>
Subject: [PATCH] iommu/amd: Fix precedence order in set_dte_passthrough()
From: Weinan Liu <wnliu@google.com>
To: wnliu@google.com
Cc: chrisl@kernel.org, iommu@lists.linux.dev, jgg@nvidia.com, joro@8bytes.org, 
	patches@lists.linux.dev, robin.murphy@arm.com, santosh.shukla@amd.com, 
	stable@vger.kernel.org, suravee.suthikulpanit@amd.com, vasant.hegde@amd.com, 
	will@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: D4BD94A9140
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TAGGED_FROM(0.00)[bounces-242221-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wnliu@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_TWELVE(0.00)[12];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Bitwise OR | operator has a higher precedence than the ternary ?:
operatior. It will be incorrectly evaluated as:

new->data[1] |= (FIELD_PREP(...) | dev_data->ats_enabled) ? DTE_FLAG_IOTLB : 0;

Wrap the conditional operation in parentheses to enforce the
correct evaluation order.

Fixes: 93eee2a49c1b ("iommu/amd: Refactor logic to program the host page table in DTE")
Cc: stable@vger.kernel.org # v7.0.*
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Weinan Liu <wnliu@google.com>
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


