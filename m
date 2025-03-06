Return-Path: <stable+bounces-121148-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 60F69A54201
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 06:18:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88B6F1889C56
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 05:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4721D19CC08;
	Thu,  6 Mar 2025 05:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kWcaqQFn"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B08AB199E84;
	Thu,  6 Mar 2025 05:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741238323; cv=none; b=Ayx4yjckJwnDy0Sm+wlUnjUgItA3TOSbP+xE8EJe98sKIkgPlC/VriqynpkMsp9yj5KT6H/cQsjxhOBBavzt1OlkQJQ1jIzcNcm2iRfLitbCV6FkU+myA3vhMS8Z/U0gqXLy9ngfrEgin1I//2MMXlKCUdHTBKKAgL/LcXNYqas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741238323; c=relaxed/simple;
	bh=bqnnQoj67Yy7FVaCgMfaUiRBSx45piKOGM6OjRIjMd4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ldKc6Gf/SwVBiccy2RhX6aXBqyYxZAq7ZY5M7+3DcpolnQ+ZSDglBP7CoGI0iKamfDl4B16eHpVdxOYUqWVJkBPsIP7TIKCJiucZDk9qVM6AARJwkXEgT5egJoYCRxjk2M2QvrYl4TfCUACP5lL1mWMHsDL+Fn05hO8ArjNllVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kWcaqQFn; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-223785beedfso3124425ad.1;
        Wed, 05 Mar 2025 21:18:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741238321; x=1741843121; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lNP741CtQxhlrtQYl+bTHrt0/2VLrt4PvoQqY1xd1+k=;
        b=kWcaqQFnB9GhODjYEESGGmfUdKJ0nLV/6pFAfwYtVYcfZTMlRnvhUPPpOWZMsJWvSK
         XH6ib2KSaClTs2enHghXqbSmFUP0jCq9uO1QB+kY7qzfcQy9nkLxdvZ0OYLh8mfeLZUz
         OPe15GCY25YqNidgFJVQY7XF1KFjMsckMZRl/i3aAnuxMYFFHw6wUMW/LgW7JAECCCV0
         NrQ08YRmmWh8pjGn6v1juCUBIM9avNd3h7IZ6xa9cCfT5CvoZOR7PsWWuEu//hEgQkw1
         jUJezdTTC/yMEACff5T4LjlMC3xadkTfoHYxn4S1PeKXbVAu3i4VAodjO4kwsegIVCft
         PbTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741238321; x=1741843121;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lNP741CtQxhlrtQYl+bTHrt0/2VLrt4PvoQqY1xd1+k=;
        b=C9jDaFDqzRUUzURTmCshWnL/iL5OfAGMP9+nn2JW2KiJDtnrUN714VUJkXX7LIjMJP
         asPtgFKRjm1nJ56JQM1UifhKBEiZxc+2YVldv39OEkE32u+cNiw/gCObay8I6dN3QTm8
         3DJykBaieMByJAl0nl+/INquiUS2WPWxnhR+eppctvpHNf/ea1FMn8KOEtq2y4tNhxjI
         V/KYWJcTdbyF1/Aqxagyk9WQfVqeoUPD54wKMSxnKyWHS5oedKtdzjmK7BQv7yZy2HfV
         sn4Qt3TWY+pD8Qwog4Q+j7vc5ddNSrGApBEfsp12FCzD494DDuVHvxtboEkLfsYIhHFF
         F2QQ==
X-Forwarded-Encrypted: i=1; AJvYcCXiZpoomMxNfNklAsYk97hPfamnirrtXXuWaLF6uW66Zr6FSOnXpq+4WBajBdK6eUwIc0FX81uKtANZYzc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJlwhCpN0m9Z0rGqBcY1psxFX8gvy1IB6kNFRLHx9NYZf9AzaU
	aIkAdroBF+4Vi2vRth9oHHqzR7y6ihm/4VmTuqYdWHTh5cdy4ip6so2AbzCW
X-Gm-Gg: ASbGncscd+q3WaqjY0yTdrVTeuD3kg5Rnu9xnKqsT05NlEYI5febu4P2NHh8O6ioM8C
	CykOdaVlgkjyUuEH61PvfESs/p6C5JmjnL0npMFq1eJ8PaY7W+T55gsx4fRq63w0RXBsZR6mmuG
	N7VBo3u9ISDtzWsv7u3lk6RACTkWx/i4QPtV8v8Gvr8t8vCRnNHaszmpHlnbCkDs0cxuLAZYzwq
	ix4UrYF/S4AH8D/0YgW8zMP9yGACTaQNsj+74hsvUKNeilVzasjJ1XDO0Hr9lccAbPqytDRuNZ7
	QzoiBsdBYAQD1jNlfcb86O+QKGqiMYBydkEMsgt9hzfYvuJrDDfIRqDvBk3PaxkTVlYqKoDCzcy
	JJPwqSELi4m2XRfen/V+N/Dyu6qNi9tIHzMoAuI6Fsly2NQ==
X-Google-Smtp-Source: AGHT+IGmB5z3KokiR0t+qvpxsDCS1ZtXYiH0T0OZsd2nmtwUeBX2F4OmXpBlbHbee6eDUemX0A/peA==
X-Received: by 2002:a17:903:191:b0:220:c4e8:3b9d with SMTP id d9443c01a7336-223f1d0ff79mr79888065ad.37.1741238320728;
        Wed, 05 Mar 2025 21:18:40 -0800 (PST)
Received: from sid-dev-env.cgrhrlrrq2nuffriizdlnb1x4b.xx.internal.cloudapp.net ([20.120.208.174])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-224109ddcfesm3332345ad.29.2025.03.05.21.18.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 21:18:40 -0800 (PST)
From: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
To: stable@vger.kernel.org
Cc: joro@8bytes.org,
	suravee.suthikulpanit@amd.com,
	will@kernel.org,
	robin.murphy@arm.com,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	wei.huang2@amd.com,
	apais@microsoft.com,
	Siddharth Chintamaneni <sidchintamaneni@gmail.com>
Subject: [PATCH 6.6.y] iommu/amd: Fixes refcount bug in iommu_v2 driver
Date: Thu,  6 Mar 2025 05:18:22 +0000
Message-ID: <20250306051822.4267-1-sidchintamaneni@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This fix addresses a refcount bug where the reference count was not
properly decremented due to the mmput function not being called when
mmu_notifier_register fails.

Signed-off-by: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
---
 drivers/iommu/amd/iommu_v2.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/amd/iommu_v2.c b/drivers/iommu/amd/iommu_v2.c
index 57c2fb1146e2..bce21e266d64 100644
--- a/drivers/iommu/amd/iommu_v2.c
+++ b/drivers/iommu/amd/iommu_v2.c
@@ -645,7 +645,7 @@ int amd_iommu_bind_pasid(struct pci_dev *pdev, u32 pasid,
 
 	ret = mmu_notifier_register(&pasid_state->mn, mm);
 	if (ret)
-		goto out_free;
+		goto out_mmput;
 
 	ret = set_pasid_state(dev_state, pasid_state, pasid);
 	if (ret)
@@ -673,6 +673,8 @@ int amd_iommu_bind_pasid(struct pci_dev *pdev, u32 pasid,
 
 out_unregister:
 	mmu_notifier_unregister(&pasid_state->mn, mm);
+
+out_mmput:
 	mmput(mm);
 
 out_free:
-- 
2.43.0


