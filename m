Return-Path: <stable+bounces-99737-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0FCA9E7322
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 16:17:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04D3118860E6
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 15:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B5D2153BE8;
	Fri,  6 Dec 2024 15:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="u7EeClvk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4620C14F9F4;
	Fri,  6 Dec 2024 15:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733498184; cv=none; b=gAbdguCPtTG5gqN1Q48fFyrQhfB1DL8qH+K9Mugv+DTaxTuEYf1TIBRCCEKhOsBgscte0TA88l/FfH0WIvHq4gAjoadCvOGB4M/EE+s/LjmiaUp2iev8BrQRRcpFmnagdIVIphlf7IujsEfyLA8IRSRllNpn2/CT4xzwCheK6tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733498184; c=relaxed/simple;
	bh=01MkATgIIngVAIX1fk/f7/4GSXmdLGT2TD5JsWYiYe0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fv7MSA9JuXiR1S/qM4Y0FfDlVrjSGYt3Ra/oKIH7z21Ba1o+MKzVTOsDqaJ4sVIG2f6tWi0BdfkT0suExAcwWVyYo4FidigoUQgoO1GXm/z5T8oSbDXRtDr51p2QbNGcATdOrDg9xgRnrrLWM5etyMrSC4GtJUkDe0MqbCweGRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=u7EeClvk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AFF0C4CED1;
	Fri,  6 Dec 2024 15:16:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733498183;
	bh=01MkATgIIngVAIX1fk/f7/4GSXmdLGT2TD5JsWYiYe0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=u7EeClvkw0yKbAGe0isTqtoi5pXReOo6hMJty9f9L4PeQpgm3RJXcIaN2T6+Amdlw
	 zigcvshfypxE45ZTYDffxBUKPpi6OpFTOxXQStQww8U7hMP+GXPKoxim4HEdd1CZ/a
	 /6JbMYAGFWOXGe0aCx6ivj+nJJiCfC60nKXrZ+rg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Lukasz Luba <lukasz.luba@arm.com>,
	Jinjie Ruan <ruanjinjie@huawei.com>,
	Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 6.6 509/676] cpufreq: mediatek-hw: Fix wrong return value in mtk_cpufreq_get_cpu_power()
Date: Fri,  6 Dec 2024 15:35:28 +0100
Message-ID: <20241206143713.237800596@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241206143653.344873888@linuxfoundation.org>
References: <20241206143653.344873888@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jinjie Ruan <ruanjinjie@huawei.com>

commit 172bf5ed04cb6c9e66d58de003938ed5c8756570 upstream.

mtk_cpufreq_get_cpu_power() return 0 if the policy is NULL. Then in
em_create_perf_table(), the later zero check for power is not invalid
as power is uninitialized. As Lukasz suggested, it must return -EINVAL when
the 'policy' is not found. So return -EINVAL to fix it.

Cc: stable@vger.kernel.org
Fixes: 4855e26bcf4d ("cpufreq: mediatek-hw: Add support for CPUFREQ HW")
Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
Suggested-by: Lukasz Luba <lukasz.luba@arm.com>
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/cpufreq/mediatek-cpufreq-hw.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/cpufreq/mediatek-cpufreq-hw.c
+++ b/drivers/cpufreq/mediatek-cpufreq-hw.c
@@ -62,7 +62,7 @@ mtk_cpufreq_get_cpu_power(struct device
 
 	policy = cpufreq_cpu_get_raw(cpu_dev->id);
 	if (!policy)
-		return 0;
+		return -EINVAL;
 
 	data = policy->driver_data;
 



