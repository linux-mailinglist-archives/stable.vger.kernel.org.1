Return-Path: <stable+bounces-85101-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2601E99DF2E
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 09:16:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D63A22834C7
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 07:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B52416CD1D;
	Tue, 15 Oct 2024 07:16:39 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A45DA171675
	for <stable@vger.kernel.org>; Tue, 15 Oct 2024 07:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728976599; cv=none; b=qdxHBbZUY08ubfR+sGIyK5O4F9JKmtUMo9dXamtc5G2FjJ0NHK44EcBAu7Aoa+MYhX75mC2eNeFnjgBjsRWwqvXlnyAMN1YxxInis24KAMjeF2As8r1hA/ZzWLqZGQ2/f5FbfpoYSx+dm5tkgKrvCeNz14WxoavRGptw/tr7pnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728976599; c=relaxed/simple;
	bh=6TxBdzUmPv5J8fwq7wFMBltZy1nvSphud4EqlRi7GQU=;
	h=From:Subject:To:CC:Message-ID:Date:MIME-Version:Content-Type; b=pR1PlG9j76KAUIZbLj956DDiAuORjj1zOvOQ6Za82Uyotbs/HMtOqEp8Gn8ZAj+jFloD4ti7ASCjjGYFB3IcBpYXwd9cFGOMPoyIoO1okpBepCVpDk9e6MPv4KYLyH11F14SH09vz3f0seauXBLEwx8hzwtsq9MObRtkGkG5c7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4XSQNH4YF3zyTQb;
	Tue, 15 Oct 2024 15:15:11 +0800 (CST)
Received: from kwepemm600007.china.huawei.com (unknown [7.193.23.208])
	by mail.maildlp.com (Postfix) with ESMTPS id 439F3140257;
	Tue, 15 Oct 2024 15:16:34 +0800 (CST)
Received: from [10.174.178.219] (10.174.178.219) by
 kwepemm600007.china.huawei.com (7.193.23.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 15 Oct 2024 15:16:33 +0800
From: Zenghui Yu <yuzenghui@huawei.com>
Subject: Request to backport "irqchip/gic-v3-its: Fix VSYNC referencing an
 unmapped VPE on GIC v4.1"
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sasha Levin
	<sashal@kernel.org>
CC: Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>,
	<tangnianyao@huawei.com>, <stable@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
Message-ID: <1057d0bc-f4a5-3ea1-b281-c78e74bc8b85@huawei.com>
Date: Tue, 15 Oct 2024 15:16:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600007.china.huawei.com (7.193.23.208)

Hi Greg, Sasha,

Could you please help to backport the upstream commit
80e9963fb3b5509dfcabe9652d56bf4b35542055 ("irqchip/gic-v3-its: Fix VSYNC
referencing an unmapped VPE on GIC v4.1") to

* 5.10
* 5.15
* 6.1
* 6.6

trees? It can be applied and built (with arm64's defconfig) cleanly on
top of the mentioned stable branches.

Thanks,
Zenghui

