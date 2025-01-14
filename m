Return-Path: <stable+bounces-108607-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29E5AA10A42
	for <lists+stable@lfdr.de>; Tue, 14 Jan 2025 16:04:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7EF83AAB4B
	for <lists+stable@lfdr.de>; Tue, 14 Jan 2025 15:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43F2A1547D5;
	Tue, 14 Jan 2025 15:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K2uhsjQp"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 660B4148310
	for <stable@vger.kernel.org>; Tue, 14 Jan 2025 15:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736867064; cv=none; b=kXRpan+69VU9TU1udEQ1xUQR61bDa9KUqHYwAfJX2GK54g/qLGcoBOKKBlTy5ZM6EApxfjsyih+WZcK0otdyuXwiOSZJhdZFZOxGuf2Qh2K6bOz3MmBtU2P6wwAtU2NcxlXQ7+ssDs11nX7VuAQnBgoUQXSUKGN8x+qXNQDlLOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736867064; c=relaxed/simple;
	bh=MZeRmO8ZTGgSQEVOU+NNtjEQeg6nypl3nl7iC8CEFGA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=IeobyCEDQtOK5wMofJYBseGz+Byd1cAh8KABYfoMw5xKFNEw1CH/nLD5ZdloXNMwimAJxc9404zlf08uBAMKR6sa/iDhmmzQRibWqiQo7DI1wO8bfD7Ks2LeH93bdzdTT0K6EhG897V0mMb7XviI4Uhecwp4B4G8MvyOnHH9hto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sebastianene.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=K2uhsjQp; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sebastianene.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-38a873178f2so2808003f8f.1
        for <stable@vger.kernel.org>; Tue, 14 Jan 2025 07:04:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736867061; x=1737471861; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iFUw03iAYkA2yPtETYQdaDhPmq7j8x1+kmN1DGn30Jc=;
        b=K2uhsjQpt9y1TybVUHBsKF9G/CZ+je+17hhO6OrtK/P2tA+cxkp2MM3HLmQcR5MSJp
         T/qPBBsaJbyodpAaU7cdm0Tdv8+lcL8M3xQHesBJPM52iGQpKzodxERTx8GS6jPgojd8
         qUyvKdBQB8aLRip8EPm2Yc7+T76azTR2t7A6oyMPlwdgJHy5qmgp6IQOtT2/EXMwUzMK
         G83IVHQTGS5DlCAScxATb7KuK00NJAhtpQvERxZi0sWkL5Pe6sa3GNM2zlrOLgHjX8uC
         hZ56Ztf5FW5e8WRACQtYotBzQ3hv7w+cjlEPRh8t9EMFNBqibv/0v8P3P7O9guRoGkZ8
         9Bdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736867061; x=1737471861;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iFUw03iAYkA2yPtETYQdaDhPmq7j8x1+kmN1DGn30Jc=;
        b=AI0W7VhedhtmhaEuro6wNNjy4mg4BbYURhdmc4+cSZ/QBWozPQMHAre49i34pM/3+G
         Hcp3hiKjhhswfO/ujaiiz0KNsIrZGx6BqJwZGr/NKWJjbpeT/f34+1+1RBURpIKXFmjN
         pic5KYRWP7VR+PhZyCHIDs9xsBkZHKC+PgAZczmRg6wL9wFVm9JevXhoqm7ZsHDhBrAc
         Y630IyNE+hiaWs3cqtjFUl0HJXCtVevdtQrdLyHqwvI/+TjKAXiKhvYES+7pgsxy3XMl
         8cY1FjEce2A0URzHNrEJXaIDCF16KurbGN2wWS3I0ZxfFAyaaECQ4wq9W9BcIVQ8bU5H
         Zpwg==
X-Gm-Message-State: AOJu0YziCYxoZncHHXf9latKFtdvcKL5/WboYOaioClKox4s5w/bAb/k
	D5cK2XxpedbXu7G4gkKj0UomLOYI6mxioTgT7Pvd0bY6Vx55l8Oqd9elTcYN1aLlr6Yk2E1T1Q8
	ZbkWpV8TzXvbr7krUnmoNeqkW5w==
X-Google-Smtp-Source: AGHT+IFpiqH515zLDuPDEl5YMg0JiAtp3YAmq0zTvt8gaVtr3+uGQ4dNXSPwKEF4OV6mX+3fdYiNTQoSKScQSyAyQUE=
X-Received: from wmbhu19.prod.google.com ([2002:a05:600c:a293:b0:435:4bd2:1dcd])
 (user=sebastianene job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:2cf:b0:385:e961:6589 with SMTP id ffacd0b85a97d-38a87303d73mr20369063f8f.20.1736867060920;
 Tue, 14 Jan 2025 07:04:20 -0800 (PST)
Date: Tue, 14 Jan 2025 15:04:08 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.1.688.g23fc6f90ad-goog
Message-ID: <20250114150407.566762-2-sebastianene@google.com>
Subject: [PATCH v2 1/1] KVM: arm64: Fix the upper limit of the walker range
From: Sebastian Ene <sebastianene@google.com>
To: catalin.marinas@arm.com, joey.gouly@arm.com, kvmarm@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	maz@kernel.org, oliver.upton@linux.dev, sebastianene@google.com, 
	suzuki.poulose@arm.com, will@kernel.org, yuzenghui@huawei.com
Cc: stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Prevent the walker from running into weeds when walking an
entire address range.

Fixes: b1e57de62cfb4 ("KVM: arm64: Add stand-alone page-table walker
infrastructure")
Cc: stable@vger.kernel.org
Signed-off-by: Sebastian Ene <sebastianene@google.com>
---
 arch/arm64/kvm/hyp/pgtable.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
index 40bd55966..2ffb5571e 100644
--- a/arch/arm64/kvm/hyp/pgtable.c
+++ b/arch/arm64/kvm/hyp/pgtable.c
@@ -260,7 +260,7 @@ static int _kvm_pgtable_walk(struct kvm_pgtable *pgt, struct kvm_pgtable_walk_da
 {
 	u32 idx;
 	int ret = 0;
-	u64 limit = BIT(pgt->ia_bits);
+	u64 limit = BIT(pgt->ia_bits) - 1;
 
 	if (data->addr > limit || data->end > limit)
 		return -ERANGE;
-- 
2.47.1.688.g23fc6f90ad-goog


