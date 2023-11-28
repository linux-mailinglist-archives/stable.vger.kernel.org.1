Return-Path: <stable+bounces-2887-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7BE97FB9C3
	for <lists+stable@lfdr.de>; Tue, 28 Nov 2023 12:57:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B8BC282ACE
	for <lists+stable@lfdr.de>; Tue, 28 Nov 2023 11:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FA3B4F89F;
	Tue, 28 Nov 2023 11:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: stable@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87A5494
	for <stable@vger.kernel.org>; Tue, 28 Nov 2023 03:57:37 -0800 (PST)
Received: from kwepemm000007.china.huawei.com (unknown [172.30.72.55])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4SfgpY3ccJzmXHD;
	Tue, 28 Nov 2023 19:53:57 +0800 (CST)
Received: from DESKTOP-8RFUVS3.china.huawei.com (10.174.185.179) by
 kwepemm000007.china.huawei.com (7.193.23.189) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 28 Nov 2023 19:57:34 +0800
From: Zenghui Yu <yuzenghui@huawei.com>
To: <stable@vger.kernel.org>, <gregkh@linuxfoundation.org>,
	<sashal@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <kvmarm@lists.linux.dev>,
	<andrew.murray@arm.com>, <mark.rutland@arm.com>, <suzuki.poulose@arm.com>,
	<wanghaibin.wang@huawei.com>, <will@kernel.org>, Zenghui Yu
	<yuzenghui@huawei.com>
Subject: [for-5.4 0/2] backport "KVM: arm64: limit PMU version to PMUv3 for ARMv8.1"
Date: Tue, 28 Nov 2023 19:57:23 +0800
Message-ID: <20231128115725.964-1-yuzenghui@huawei.com>
X-Mailer: git-send-email 2.23.0.windows.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm000007.china.huawei.com (7.193.23.189)
X-CFilter-Loop: Reflected

Andrew Murray (2):
  arm64: cpufeature: Extract capped perfmon fields
  KVM: arm64: limit PMU version to PMUv3 for ARMv8.1

 arch/arm64/include/asm/cpufeature.h | 23 +++++++++++++++++++++++
 arch/arm64/include/asm/sysreg.h     |  6 ++++++
 arch/arm64/kvm/sys_regs.c           | 10 ++++++++++
 3 files changed, 39 insertions(+)

-- 
2.33.0


