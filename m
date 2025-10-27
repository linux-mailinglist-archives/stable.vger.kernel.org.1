Return-Path: <stable+bounces-190020-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77D96C0EE3C
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 16:18:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B01D3BF3BB
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 15:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B26E2FE057;
	Mon, 27 Oct 2025 15:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kJ7ja//h"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D74D81F5820
	for <stable@vger.kernel.org>; Mon, 27 Oct 2025 15:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761577795; cv=none; b=GPIKKAVjS57IjYtyV5rB/5PWSAlt1iCUpxIKdRy87gV2490KVAurgYjtKpUQscea4ErEVOEWD6a5j1/uc23q/gnEmeH9kWfX5OsnCh7/AjNP4CDcOuoDPgGFy0Oyl8Xq8tYjYSMUk8VJEj4dJUk0Rk8p2yOlmW0782wzbzDm7X0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761577795; c=relaxed/simple;
	bh=ZsCPFXC9R6NQL97nYWlCY006QYpTpfOsDxb5I2LLUOE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=a8GEsvofGVGa2yHFN40Z+g7cgqHmydVYGulsZbTeSQ+QwD25cquSwGwqnJE+T+2m7NTHxCwbGuSs/bvbi5iypxMUcqiWQwA9oCBN18gV4PaqpuPAhWbQ9xxgyMXZVUP6Z/ytLIIsmozieBZyjPsM+xbCEyVmxR/0PjejgWHHTQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kJ7ja//h; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-290aaff555eso44107555ad.2
        for <stable@vger.kernel.org>; Mon, 27 Oct 2025 08:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761577793; x=1762182593; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bOWeTrE1BXy5AjZlTLFESliT17UYj7Zas8RzdCqx+Q0=;
        b=kJ7ja//h1GuoShmdPrCSmyeJEW9lvcDD9TjI7HmOoqCiqUww61jtinmFyFPki9aVRB
         XgmaLqmysom2tx/vUAfxD79ODDCZbfnnqYwHvIdnK+vcABfymOOvyqqiRRWun8hkXVRI
         qDrCOxp8pXBPb9o1Fp9D4isFqnu7mMnHnCgLIusz7m/+j+WpKQUQ87HEx13fi3u9jl6t
         X1ltlZ5Mlk6tDKI5MOpscQiB+XZk86RFKweU6kmzejVblEu4mf+QL1gDbijVQ+1Q0mwP
         HKTrnEPib67AbFuJ961hiJsyReugDUHr7V+/RynxjsSbG0jpyGhGRQN+ZEM/vxRzEh5E
         ODVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761577793; x=1762182593;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bOWeTrE1BXy5AjZlTLFESliT17UYj7Zas8RzdCqx+Q0=;
        b=Fz2ifLhBq/YO5dohKU5tHYMimeEAj707HMBcI490IsZX8NDeZ/PW8B5yy+T4CQm6AM
         6Ke96H4sH0pB9u6aYbkktMlpO8BlKuvFK+Vz0JCDncIjnbT7feti+Zr/d2N0efRUkdwk
         pYV8FKZkdBzXvP4Yy6OMNidDVTWQMKyPFo9O4vzAzBrityINKVtwCTxxbljYzKlE9O3R
         qXxTUOgnMvnCSA/s0iNoL1AAdcloZ7WFyEGPKJAUBDophZ29C3oTotOMU78pwZaUkWPh
         nImP9EhIGTmsAZjA7ncO3GNvDZKyItWVkHu726Q7iL3D9DqEshCCnJ4eSTdUSyreieXl
         9YKg==
X-Forwarded-Encrypted: i=1; AJvYcCUtFwcBPXWdBZ3oGA8ze3w5QyJU8pA8YzT7lPalfGnDtXzG0gS+JsLHxJilJgFd/HYx6Sf2wD0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6cGuVeC9SgSBZKISdp44UyyJkYtZ1m9A620lagPvrGxD16ii/
	COMVpSY4cr5F1W2rjUcZ5/36mVS62QaPDNCYEIQc0+BJ/4uc/NmrDwzq
X-Gm-Gg: ASbGncs9LVHRkdz2F0NIjYzwtyVBXTG/WgGYkhGaXMUOy0ipouPRy7EwH6FHyxHkSeS
	IRFjRMbgFHrPMUSa/4NbiRU9zjEpQjlTCwktJp5lHbbQomkdZjR+RZSgLjAM0FAkEEha/zpnigb
	tMIWtzEsgf52WJf1cV7ManCOD3+z83MId9c4kn0suHQXKxTDJQDRvGE36YlbqmsLo8i8vH8b8Z7
	s0BeXFuPmRudy7ecCLX6pr8MCT1X8SIsGsQ31MU0GWo1m8EdTgqowvKXA5AwWRr0/a3kGzQYLkQ
	i1AAP42hvIRxywom8tyc+T2PfZpQmgqB4Kk40n9XaHMl7R2qoA7KFKYS17tDAXtbth1A7/SkxrI
	0imoUSWpSuL0xpQtR6Ibudbt/g8BkbovRnIogZAfplzuF/OwukGK90rlS1sUC18USOXZP2iuvoT
	BPqL+XluWkH3fVMeugtCCkr7oLy4TYwy0A
X-Google-Smtp-Source: AGHT+IHm+qmEs3k8KDkI28OdIfpmmkZKiOOzJFODhG9t1YR8Za920Qncpnz3yBINujjAHcwPpw/fHQ==
X-Received: by 2002:a17:902:ea01:b0:252:a80c:3cc5 with SMTP id d9443c01a7336-294cb3d6169mr3033825ad.22.1761577792933;
        Mon, 27 Oct 2025 08:09:52 -0700 (PDT)
Received: from localhost.localdomain ([124.77.218.104])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-29498e4113fsm84234275ad.90.2025.10.27.08.09.48
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 27 Oct 2025 08:09:51 -0700 (PDT)
From: Miaoqian Lin <linmq006@gmail.com>
To: Weili Qian <qianweili@huawei.com>,
	Zhou Wang <wangzhou1@hisilicon.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Kai Ye <yekai13@huawei.com>,
	linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: linmq006@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH] crypto: hisilicon/qm - Fix device reference leak in qm_get_qos_value
Date: Mon, 27 Oct 2025 23:09:34 +0800
Message-Id: <20251027150934.60013-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The qm_get_qos_value() function calls bus_find_device_by_name() which
increases the device reference count, but fails to call put_device()
to balance the reference count and lead to a device reference leak.

Add put_device() calls in both the error path and success path to
properly balance the reference count.

Found via static analysis.

Fixes: 22d7a6c39cab ("crypto: hisilicon/qm - add pci bdf number check")
Cc: stable@vger.kernel.org
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/crypto/hisilicon/qm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/crypto/hisilicon/qm.c b/drivers/crypto/hisilicon/qm.c
index a5b96adf2d1e..3b391a146635 100644
--- a/drivers/crypto/hisilicon/qm.c
+++ b/drivers/crypto/hisilicon/qm.c
@@ -3871,10 +3871,12 @@ static ssize_t qm_get_qos_value(struct hisi_qm *qm, const char *buf,
 	pdev = container_of(dev, struct pci_dev, dev);
 	if (pci_physfn(pdev) != qm->pdev) {
 		pci_err(qm->pdev, "the pdev input does not match the pf!\n");
+		put_device(dev);
 		return -EINVAL;
 	}
 
 	*fun_index = pdev->devfn;
+	put_device(dev);
 
 	return 0;
 }
-- 
2.39.5 (Apple Git-154)


