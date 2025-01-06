Return-Path: <stable+bounces-106791-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B4DEA021BE
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 10:26:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B3F11639F0
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 09:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94F2E1D90C5;
	Mon,  6 Jan 2025 09:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="pw8eAlgV"
X-Original-To: stable@vger.kernel.org
Received: from out203-205-221-231.mail.qq.com (out203-205-221-231.mail.qq.com [203.205.221.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D978B1D7E4C;
	Mon,  6 Jan 2025 09:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736155606; cv=none; b=tkRJMoMsgQUfNKaoE/fjxwYENjdqay6AhhKQNDKOukhYHM6YkmVWlWLDEoMN8URqUbXeZiAlsYz+Ye+Kyas8uWR3jNBKgLIq1A7bP9b8RxVyXAxIFaxTqrWl8L3A+W4w95kwzvh0s712+0wU1uxlLvI0osUIIOqtnhE5609uIuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736155606; c=relaxed/simple;
	bh=BXRd+tQvO/Ro4RNGymliswSRym2+KsntVA8cipQI4HU=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=lUVT7Az9XFen/zt55g3FqFJ1B/Sh551YOILCq42+g/5HrArYb9W+MCSxS/jNnfRYMEWff3X7TQXSBKF6mCV6+gs3v8t93TFT5LopRyp5/z0sJMFWRoxu76S7B8vd1N4scLnSBkAmvIueS2qk14erxnTlG772myRr4MJ2J7RwBQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=pw8eAlgV; arc=none smtp.client-ip=203.205.221.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1736155598; bh=8sCIGxuaWy6T9YXV5e3s9X3b7PEsSlpDK/wRLpKU03g=;
	h=From:To:Cc:Subject:Date;
	b=pw8eAlgVfkdsS2Suf3wA56Whw3woy1FPCV7U0YdOdZKOdbWaCr54eIAZ7KT1Fw90W
	 nVElyGqnk0pjPO+rT16Ixtyhf5piOdzx+qDRiZjj8ss4+KzjlqPTlmLcRKB1NiIMS9
	 uIxDywc2sCZBEsmzepOWeDw3QrnsHouq5y9+T4ZA=
Received: from localhost.localdomain ([101.227.46.164])
	by newxmesmtplogicsvrszgpua5-1.qq.com (NewEsmtp) with SMTP
	id 6A426423; Mon, 06 Jan 2025 17:26:36 +0800
X-QQ-mid: xmsmtpt1736155596t7v67da6z
Message-ID: <tencent_160A5B6C838FD9A915A67E67914350EB1806@qq.com>
X-QQ-XMAILINFO: NvgtgL4Jzwx/1jbRVoHTsBCgipl0HoD1tLFyw5ahOZLU2ho0d3TCfbdiNcdlRG
	 ov5tYxMxkR0/4nVjsTdo2If7SdUiF3S4SD5NER4GdjY4vfqGKF7qCjLA9KThbZ+esT/NJysS8naw
	 3UpH2mBphegwaD9urtcYINCtW+U+PNcE6uwVmvHlW6QKkt32Yq/oHy1bioqNjiuJ7eOHyN4DcVl/
	 tJbgYdGb+fwwrf+fupeXpRZbRFMfFddZEtGZ/KlsPO5di7+UkNL9kEhO90lIOQg1Lhbs/AWo2tTL
	 h81BGzusLhJHHD5uuEBvWAvhW4T5Qf3aqTXeQ+FoND+zT1X2FUPCL9EOseQj8SiBC7ptqHqlw9HM
	 eXP17KZ+cRZ7EajqcH7eOdpamB/DI+qH0+eVF8Ql+u8VpSd1zUFXvGkeazJyl3MWig49CaiMq0il
	 Br/S/S0UQCgMYTOgfJ8q/7euTmS9lA/uHrSpqx8LTYHkhsKgQ1ogFlUi+qQ+1zFv/IDJOtZ+BsIm
	 5DaA3FvJOTwuIdByGa43/Qt9PC9aYoJIB4uLTLQmxx0W4Wxyn82ZohOgwWFvwPm6iwKcZpzFI6fN
	 5C96cJ9ztCBzHtMAn+wWI0oqExjytzkDcmwNwlTawu4tGeuKZwCan9iJL2oOMr3oZK3C1+5gRvE8
	 K1/gmKufxPx4cacZzovl1rhm2QjglxRVu7RlQLJBsbMPZXbunaYylziF0ihLMOE76ibb8w0wxF5K
	 WZ0DEZUoC9WFmFFeBIebLwddSCEdjAKIivJbrTuILYyle1Tw4EXIMzVw0INU5S5dASR8oJQrpKNN
	 4LkcbWFyrN8IWlrNBcp4AdoPXZewfzUG1MqxleKoZKxB6VJgIKa5eMNpmHI955JJENmsP8ANTiMQ
	 Mm47Yrt3wM8qn7DhHIdM9I9tiN1nFMX7/6ulEA7HShwDLwzrlQf6FkM+TbCRD5EeqiXasTQ1f4oM
	 DblitnyRxpdcKdWBuQDlSuMr/wjpcx
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
From: wujing <realwujing@qq.com>
To: gregkh@linuxfoundation.org,
	sasha.levin@linux.microsoft.com
Cc: mingo@redhat.com,
	peterz@infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	wujing <realwujing@gmail.com>,
	wujing <realwujing@qq.com>,
	QiLiang Yuan <yuanql9@chinatelecom.cn>
Subject: [PATCH] sched/fair: Correct CPU selection from isolated domain
Date: Mon,  6 Jan 2025 17:26:34 +0800
X-OQ-MSGID: <20250106092634.113262-1-realwujing@qq.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: wujing <realwujing@gmail.com>

We encountered an issue where the kernel thread `ksmd` runs on the PMD
dedicated isolated core, leading to high latency in OVS packets.

Upon analysis, we discovered that this is caused by the current
select_idle_smt() function not taking the sched_domain mask into account.

Kernel version: linux-4.19.y

Cc: stable@vger.kernel.org # 4.19.x
Signed-off-by: wujing <realwujing@qq.com>
Signed-off-by: QiLiang Yuan <yuanql9@chinatelecom.cn>
---
 kernel/sched/fair.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 09f82c84474b..0950cabfc1d0 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6171,7 +6171,8 @@ static int select_idle_smt(struct task_struct *p, struct sched_domain *sd, int t
 		return -1;
 
 	for_each_cpu(cpu, cpu_smt_mask(target)) {
-		if (!cpumask_test_cpu(cpu, &p->cpus_allowed))
+		if (!cpumask_test_cpu(cpu, &p->cpus_allowed) ||
+			!cpumask_test_cpu(cpu, sched_domain_span(sd)))
 			continue;
 		if (available_idle_cpu(cpu))
 			return cpu;
-- 
2.39.5


