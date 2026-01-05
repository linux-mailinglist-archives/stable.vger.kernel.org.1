Return-Path: <stable+bounces-204627-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F1CFCCF2F3B
	for <lists+stable@lfdr.de>; Mon, 05 Jan 2026 11:19:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 190DE301F5D2
	for <lists+stable@lfdr.de>; Mon,  5 Jan 2026 10:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73AEE3101DA;
	Mon,  5 Jan 2026 10:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="XVT72kka"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f228.google.com (mail-pg1-f228.google.com [209.85.215.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC14E2F3C13
	for <stable@vger.kernel.org>; Mon,  5 Jan 2026 10:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767608274; cv=none; b=hiMlq0v1DQv39ecb79qAVn+9+sF0tTr6AgQOpSu//LmJs/xFIjj+uQ7Oo5DXJFzBOQ2wsMtBSEKwQDCjI1oghYxB40JW7M86BrIxC2fSDyfYamfAP26fNN1MS/KokzAFCrAnvFGqpS7Yf1Mhcoc+VbcAOPIa2f5deZ5UUcrx5LM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767608274; c=relaxed/simple;
	bh=QY3HTEVaHPlfhfn0LQXxca+zyPZhcAwhzUarq0fwl9Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=I+6zxD1arlQODn4ptzQ4bn0ORigdGN2JzXLM+oTN5GgtaNZvURdauVHr96mTA2TvH8m0zpKzE42F+OB+Qh5XvmDOa3uZbAs5q7IbhU+mY+plDwAUzJzbtFBIuZwK6iNZFBm8xynvaSHPHpoGWgcwcV08n0bERK66h3Brx4HI0u0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=XVT72kka; arc=none smtp.client-ip=209.85.215.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f228.google.com with SMTP id 41be03b00d2f7-c03e8ac1da3so12025246a12.2
        for <stable@vger.kernel.org>; Mon, 05 Jan 2026 02:17:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767608272; x=1768213072;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZDEZfxXGKUHqnD6uzu3JESKT0vdq+bi9ssWL2yPlp2w=;
        b=qQN8QWXJkPeRFFUI5oZCnc5sBV0fk3yp0gp7SsSaXoHoQWFISTlBa0VeDDlTMsJFWe
         4v3732j1DzOSK4nzYJBEmCyU2hKxA+pvNDSlq+hs6PmnyD1ehHrOylTPsGLGXUp4tcfi
         XOn0cKCCiLF66HjZwokwGPVpUBHScuLQXYsRDeTvgmHPP+s8Bf+7gAgIjjjENMENE4OQ
         VjKcx2H/V3byJjPetf9PbpscpHPG9GKcQaoh703gjTw1mkHuNsT3MRpq+O7Vdg+/IiHh
         GuXqoCk2ofzZ+nkUvk7NnWlhDoR1kE5x2cq3pA9khGgqBlPvjSBfaMWHR3OyDP76+rWq
         mQJg==
X-Gm-Message-State: AOJu0YyHb9kFxIugFQSGzJLVkeZC5PWW/rs5aeu/IwEbJ/K3qkKrT1LY
	DnMZWvCNU0xZL9R7VQo+vPV36oGAJeX7BBHg0UhDvFyF0mM1sx2APn5MfhmmMtVYSYc3qyZHx3u
	GT5yEeFbQApR9t+enBF+X9sk/DHo47nCXayEkScXqdRweNjgpQveVCjGcMvlHte1BHQ/v5l10x4
	g2ISn6h1QJdD61DACzFIdN9m331MC1TJrfcPdbXUf96T7AU2jnkhiCgNl5J6JMWXSvNiB1grkm5
	IJTaAPZdKkjlwU0/Q==
X-Gm-Gg: AY/fxX7E7E9x7DD+72JZpb4tqUQJhYuxWSnkWR1H+p78UQdCEE//N8sNTIrQDSVCw1B
	nBCJgtWPd3i+aKjwhwDEwrsqaP/eSwKw1qn3AtBrm2V/CXofJxpck1YSvvbzUXAeoLDqsYAPSi+
	eo3IW4KzCMGxd97xRLIcil5YlLRtJkznLLkG17XHu10dHJ89qrjZQHBnmFsCk7JRVpioe9sZZTx
	wQV/j4hpy+6jtp/7ke+eOfV9aIQba0RsNrf+FY2z30MYh5auzYhOghVkXaTBSeHWL/w8drZuiOt
	N+KtI1eaLcNR/iR/M6NHwcLk7FK3Pd90TjenPn931Kw/m8R3qYvwTbAAfRcFaIeaFsioSZoS5Rr
	IpcVu0TlDqdYnJYek009x9xRwSWnMiYwcv5a8zJbzfXlSCgJvGjPst0vZFFUA/9Vj2jVYcwDP6l
	4+TACmm7NNkkbayQrIyv6tFZmqp00x/4MUpiQ/xVMqSf3qDg==
X-Google-Smtp-Source: AGHT+IE0X5vclTX86wy+2jUPubDvuFID7HDhWbhUnoVKXQRRAkJcKJBoajkkwZ+x5rVBypKCRwmbA1B34ITG
X-Received: by 2002:a05:7300:e50f:b0:2b0:5609:a58c with SMTP id 5a478bee46e88-2b05ec47d0emr38140583eec.32.1767608271982;
        Mon, 05 Jan 2026 02:17:51 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-2.dlp.protect.broadcom.com. [144.49.247.2])
        by smtp-relay.gmail.com with ESMTPS id 5a478bee46e88-2b140c61369sm1305758eec.5.2026.01.05.02.17.51
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Jan 2026 02:17:51 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b9ceccbd7e8so31293428a12.0
        for <stable@vger.kernel.org>; Mon, 05 Jan 2026 02:17:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1767608270; x=1768213070; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZDEZfxXGKUHqnD6uzu3JESKT0vdq+bi9ssWL2yPlp2w=;
        b=XVT72kkahmHtaf719+HMdZO37C3gfnmLQw4FyrAMadM2CYk3a4lhAJOeKTrdwNfv5W
         gzNHLCfteYMe/qZhuUZ/gG7ZnauTI9+wYtcgITdjvpX1JtUGeTwoxK7sfJZlfrrbTj5Q
         5s5EbShd9BYjVHhQvn7CNcjg4S6XdoIvJ11cY=
X-Received: by 2002:a05:7023:905:b0:11d:fd26:234e with SMTP id a92af1059eb24-121722b821amr43934368c88.16.1767608269994;
        Mon, 05 Jan 2026 02:17:49 -0800 (PST)
X-Received: by 2002:a05:7023:905:b0:11d:fd26:234e with SMTP id a92af1059eb24-121722b821amr43934337c88.16.1767608269346;
        Mon, 05 Jan 2026 02:17:49 -0800 (PST)
Received: from shivania.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1217254d369sm170077924c88.16.2026.01.05.02.17.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 02:17:49 -0800 (PST)
From: Shivani Agarwal <shivani.agarwal@broadcom.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: sudeep.holla@arm.com,
	cristian.marussi@arm.com,
	rafael@kernel.org,
	viresh.kumar@linaro.org,
	arm-scmi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	vamsi-krishna.brahmajosyula@broadcom.com,
	yin.ding@broadcom.com,
	tapas.kundu@broadcom.com,
	Henry Martin <bsdhenrymartin@gmail.com>,
	Sasha Levin <sashal@kernel.org>,
	Shivani Agarwal <shivani.agarwal@broadcom.com>
Subject: [PATCH v5.10] cpufreq: scmi: Fix null-ptr-deref in scmi_cpufreq_get_rate()
Date: Mon,  5 Jan 2026 01:57:01 -0800
Message-Id: <20260105095701.659420-1-shivani.agarwal@broadcom.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

From: Henry Martin <bsdhenrymartin@gmail.com>

[ Upstream commit 484d3f15cc6cbaa52541d6259778e715b2c83c54 ]

cpufreq_cpu_get_raw() can return NULL when the target CPU is not present
in the policy->cpus mask. scmi_cpufreq_get_rate() does not check for
this case, which results in a NULL pointer dereference.

Add NULL check after cpufreq_cpu_get_raw() to prevent this issue.

Fixes: 99d6bdf33877 ("cpufreq: add support for CPU DVFS based on SCMI message protocol")
Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
Acked-by: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
[Shivani: Modified to apply on 5.10.y]
Signed-off-by: Shivani Agarwal <shivani.agarwal@broadcom.com>
---
 drivers/cpufreq/scmi-cpufreq.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/scmi-cpufreq.c b/drivers/cpufreq/scmi-cpufreq.c
index bb1389f27..6b65d537c 100644
--- a/drivers/cpufreq/scmi-cpufreq.c
+++ b/drivers/cpufreq/scmi-cpufreq.c
@@ -29,12 +29,18 @@ static const struct scmi_handle *handle;
 
 static unsigned int scmi_cpufreq_get_rate(unsigned int cpu)
 {
-	struct cpufreq_policy *policy = cpufreq_cpu_get_raw(cpu);
+	struct cpufreq_policy *policy;
+	struct scmi_data *priv;
 	const struct scmi_perf_ops *perf_ops = handle->perf_ops;
-	struct scmi_data *priv = policy->driver_data;
 	unsigned long rate;
 	int ret;
 
+	policy = cpufreq_cpu_get_raw(cpu);
+	if (unlikely(!policy))
+		return 0;
+
+	priv = policy->driver_data;
+
 	ret = perf_ops->freq_get(handle, priv->domain_id, &rate, false);
 	if (ret)
 		return 0;
-- 
2.40.4


