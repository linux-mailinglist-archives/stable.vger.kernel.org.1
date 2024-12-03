Return-Path: <stable+bounces-96180-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 834939E111F
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 03:13:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10EE7B223F6
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 02:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FFD712CD88;
	Tue,  3 Dec 2024 02:13:06 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DFBB17555;
	Tue,  3 Dec 2024 02:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733191986; cv=none; b=T4wBrpX+xl0Ik6XbrGqFn8oSvOezFBj8R31uJygwCFTlRGPkBkj9ldiN/HILQiyHyxtmm1atn/0PNERs9fRE7NwnlWd7+JWu2cwVWKs/LMsnU9xKLbg/9rsAc4lFzIFF+dJfYEH5Ag7lKLehxv73UzhSLVEf+ZgEjbnmqWRmLwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733191986; c=relaxed/simple;
	bh=OITbt8m1ZjkkKayd9WEvOey1U/w1G3we8gTmVfOrfIU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eBUmfTw8Az+BbMdo7gyDa6uIU3pbP3lxIvDYMCZmXnYowvFk/uSoKQ/sGNSPsn4FyH0mwlrKeuo+j2ed02lzX+/iMImTO1f6GxMCCwYphb/kTugbCc2JbGIz62e3gggcoPV0U10wJiq1UgVaMu9q7UNP+bCjmdi/j9DG8LnE73s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Y2PHd2XvvzxSPw;
	Tue,  3 Dec 2024 10:10:05 +0800 (CST)
Received: from kwepemf500003.china.huawei.com (unknown [7.202.181.241])
	by mail.maildlp.com (Postfix) with ESMTPS id 5DF48140137;
	Tue,  3 Dec 2024 10:13:00 +0800 (CST)
Received: from huawei.com (10.175.112.208) by kwepemf500003.china.huawei.com
 (7.202.181.241) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 3 Dec
 2024 10:12:59 +0800
From: Zhang Zekun <zhangzekun11@huawei.com>
To: <gregkh@linuxfoundation.org>
CC: <cve@kernel.org>, <linux-cve-announce@vger.kernel.org>,
	<stable@vger.kernel.org>, <kevinyang.wang@amd.com>,
	<alexander.deucher@amd.com>, <liuyongqiang13@huawei.com>,
	<zhangzekun11@huawei.com>
Subject: Possible wrong fix patch for some stable branches
Date: Tue, 3 Dec 2024 10:06:51 +0800
Message-ID: <20241203020651.100855-1-zhangzekun11@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <2024111943-CVE-2024-50282-1579@gregkh>
References: <2024111943-CVE-2024-50282-1579@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemf500003.china.huawei.com (7.202.181.241)

Hi, All

The mainline patch to fix CVE-2024-50282 add a check to fix a potential buffer overflow issue in amdgpu_debugfs_gprwave_read() which is introduced in commit 553f973a0d7b ("drm/amd/amdgpu: Update debugfs for XCC support (v3)"), but some linux-stable fix patches add the check in some other funcitons, is something wrong here?

Stable version which contain the suspicious patches:
Fixed in 4.19.324 with commit 673bdb4200c0: Fixed in amdgpu_debugfs_regs_smc_read()
Fixed in 5.4.286 with commit 7ccd781794d2: Fixed in amdgpu_debugfs_regs_smc_read()
Fixed in 5.10.230 with commit 17f5f18085ac: Fixed in amdgpu_debugfs_regs_pcie_write()
Fixed in 5.15.172 with commit aaf6160a4b7f: Fixed in amdgpu_debugfs_regs_didt_write()
Fixed in 6.1.117 with commit 25d7e84343e1: Fixed in amdgpu_debugfs_regs_pcie_write()

Link to mainline fix patch:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=4d75b9468021c73108b4439794d69e892b1d24e3

