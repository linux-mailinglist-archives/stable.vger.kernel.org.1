Return-Path: <stable+bounces-115075-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C273A32EC2
	for <lists+stable@lfdr.de>; Wed, 12 Feb 2025 19:34:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C82DD3A3F53
	for <lists+stable@lfdr.de>; Wed, 12 Feb 2025 18:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0562C25E452;
	Wed, 12 Feb 2025 18:34:42 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 149AC27180B;
	Wed, 12 Feb 2025 18:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739385281; cv=none; b=suhs5Oke8YphULahJj5paPemGe/N0GOgUukdZ9G2KcrBc/bawXnHoGkOPI5Mgy2FGAQXmKJYvnMle80PhYNcPBSB6iG9EPTrnZCryJ8Q7EGYBGzDWwhVq4M+HR8wYzzT2AEIvsDX/kZltJLMv2k3fqB5rMPQQXOA6/6HWU97ihA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739385281; c=relaxed/simple;
	bh=u8Mj2f4Ky3af2LxP5bM5f51X8/5c/v2NRTvy9yypnhk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=d3wK+v0b9n86LB6f0+9SBLJvrCm5ZMnGl6tdFD4Ycw5hGAgosURDn/AbxvPLZlFEKxUcLRc5z8LKnBdA27i98EJ3Q9m5hCi7YvKk0nNix73wifAHU0h/NIMulwSacQRm9NswOIaW5zuMKNCEAYlFLKXScNM1ibnj7WbfU88J9ZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ab744d5e567so4657166b.1;
        Wed, 12 Feb 2025 10:34:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739385278; x=1739990078;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z+nB/4+H4IgI8wgO/HTb7HVIL1m/yp3K3cNW/qW6EO4=;
        b=XBkXZheEqIl16nezeMSKtXn6T3PO3jBTEsn+C4p4QjM4saSMiv6MxR65mdHjODcv1d
         6BSXF2mCXUnSstZeGrBj12nw+iQKu+XpKSmxCIGZ/RcOzg3Hgx/uLl5pHktieDm7tmvb
         0bstXxYKUNDFmLyw6f79gEnnIlf+lhN4i0TxOzNWQUwCn4NofsqvrdW/k3ZijC+Z1AfI
         h2n0bOjgKvHXq76goDNk4WQu1feQjpIy1v6Em9CBV4BTlxLlDysCXOFpE46nmQoLbIyc
         76pUnWAM8aQ6m80C3B1uhx1WnCzeCNxEGXFYdidIRNmzR5F7MoGV5gZ35rBtF22vXc4t
         oVUg==
X-Forwarded-Encrypted: i=1; AJvYcCU6cP1ckWzOX67BWONP18nFc3u6wJxM0gKszB5sMlrEGPD6cEtLM/QEbq9mk7sW7KRiQrOW01OA@vger.kernel.org, AJvYcCVuhmVgZ+0kqWMKum5zp7Md/8NdWXUetOYGaHNKfa/33zXe1UjzCZh1dl19UVtNu4dt43XRHNhQjVn8PHE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyM2gcvJ3HZSYiikiu9+WPNdAmIPK0KOqGwy++U9HPfXEEzzxAA
	HHjAzdd7PiUWJc9q3bW2QWsomV206qDjte3FmrEVywak1/ZoxbSI
X-Gm-Gg: ASbGnctG333i7yVJBV23QnHSjHLewmAcoCfbjb1HLm8x84eu2IWbjX4MdhrLinMr32y
	fCkq4wjrhrzb+BBHRtNTfPZbs6LvDVNsYBjtDWlUPCr+MyWdLZVLkQOrNr89rqa2mR8mKgKUkAE
	4inYN9mU83VdoX5WS/XyFWHms9VBBlA/smIr6Ddp9PhLvxRY0B9uVierEa/DUq2JwyifyEwk9Iu
	7MNYlSdMIIjsfJKt5Ht8GkFWQ5njDtstET7sFEK1zxrG4LBqrdR1n7WUJLc48mjzuXuM/Srhq8E
	F3etrgs=
X-Google-Smtp-Source: AGHT+IFCX0Y3wgXy426TeuJE+FiQhABLo3aftnl060EWxggaUXQjHOuam39ExfyyTi9NkjJiI+zHlQ==
X-Received: by 2002:a17:907:d1c:b0:ab7:d44b:355f with SMTP id a640c23a62f3a-aba17159e9amr33003866b.25.1739385278058;
        Wed, 12 Feb 2025 10:34:38 -0800 (PST)
Received: from localhost ([2a03:2880:30ff:71::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab7d855b61fsm433358166b.124.2025.02.12.10.34.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 10:34:37 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Wed, 12 Feb 2025 10:34:22 -0800
Subject: [PATCH net] netdevsim: disable local BH when scheduling NAPI
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250212-netdevsim-v1-1-20ece94daae8@debian.org>
X-B4-Tracking: v=1; b=H4sIAK7prGcC/x3MQQqAIBAF0KsMf62QA1Z4lWgROdUsstCQILp70
 DvAe1AkqxQEepClatEjIZAzhHmb0ipWIwKBG/YNO7ZJrii16G7Z95Fjy73rPAzhzLLo/V8Dklw
 Y3/cD5KbPaWAAAAA=
X-Change-ID: 20250212-netdevsim-258d2d628175
To: Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, David Wei <dw@davidwei.uk>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 paulmck@kernel.org, kernel-team@meta.com, stable@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1420; i=leitao@debian.org;
 h=from:subject:message-id; bh=u8Mj2f4Ky3af2LxP5bM5f51X8/5c/v2NRTvy9yypnhk=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBnrOm8K0cdWJEi+dhd9KtwveqxaxumG27ROINAA
 yYK31zDnaGJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCZ6zpvAAKCRA1o5Of/Hh3
 bZWRD/9PFlyKC8K71F3bBSy9LDPmdO4A1AWtnouoP8B8PIolh0Ayx4Ef9ZSAr7V8+9/WsTNZo0R
 AOIWnkhQCgYNJs+2nF6feU7rql3w/UEPI5Y3+Qqq6TCkSLnCLdBbO7WX5k5G6OsWRw+oIMVhxBq
 SYQacu2IJuI5zygw9rOhd0+Jjcsajsodsu6lpwciUdqZeu4b61xFJ3SPuAlU/hk6wbdBNCAj+0k
 +hicJPwH2GljOqT2k27O60CtTXhJfH2ZydafJTXdp2c9AVPEUogw+HDlYfg8EfvwNd7uaLxnZup
 SnWoRr9PX3OfpPSvXtGnf0kv7+HZ+hSi4Deky156ctghkV4lLQMTuJ4FtBvvmu3XiBs5nFYxDz7
 hUpiL6DcZInOSzg7WBoRUwY5atOhjqlbLB4rmdKsTasw1f2ahcrS2B1Uh1VnhRi3QaNGoax7aGx
 1Ha93QvzfAw+tvpAog+gwSLLtJZkjWld7EUWtlKAbzciv9lO1nWVr7Y5YJuc7fSMsthPlF/rGzb
 uGDVXPEco8bhdsa0mPG+Q3MXeSyT3mOJNDW0TsjNm/aJXSnNf6pqSZWDn6qK1ZsJm6mvoyiDaVc
 vvI1dfq0QOzoF1WP8Xt5uoIwA/WCwaQqzX3DIo8MKc5j3qMQcc8i5zG8gzhtqqrRi9Itc1jNAr9
 mcuHh6OfBiU0gpQ==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

The netdevsim driver was getting NOHZ tick-stop errors during packet
transmission due to pending softirq work when calling napi_schedule().

This is showing the following message when running netconsole selftest.

	NOHZ tick-stop error: local softirq work is pending, handler #08!!!

Add local_bh_disable()/enable() around the napi_schedule() call to
prevent softirqs from being handled during this xmit.

Cc: stable@vger.kernel.org
Fixes: 3762ec05a9fb ("netdevsim: add NAPI support")
Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/netdevsim/netdev.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
index 42f247cbdceecbadf27f7090c030aa5bd240c18a..6aeb081b06da226ab91c49f53d08f465570877ae 100644
--- a/drivers/net/netdevsim/netdev.c
+++ b/drivers/net/netdevsim/netdev.c
@@ -87,7 +87,9 @@ static netdev_tx_t nsim_start_xmit(struct sk_buff *skb, struct net_device *dev)
 	if (unlikely(nsim_forward_skb(peer_dev, skb, rq) == NET_RX_DROP))
 		goto out_drop_cnt;
 
+	local_bh_disable();
 	napi_schedule(&rq->napi);
+	local_bh_enable();
 
 	rcu_read_unlock();
 	u64_stats_update_begin(&ns->syncp);

---
base-commit: cf33d96f50903214226b379b3f10d1f262dae018
change-id: 20250212-netdevsim-258d2d628175

Best regards,
-- 
Breno Leitao <leitao@debian.org>


