Return-Path: <stable+bounces-169903-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C599EB29605
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 03:15:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB638202397
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 01:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1C021487E9;
	Mon, 18 Aug 2025 01:15:15 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mta20.hihonor.com (mta20.hihonor.com [81.70.206.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B69F6219A67
	for <stable@vger.kernel.org>; Mon, 18 Aug 2025 01:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.70.206.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755479715; cv=none; b=h3RmpgNO1g8kXaumeepwZzU1VkTDWu4COxkxuOG0zG1NQm2JyJAxcazTTuULqDSOXFPqpxOwToMpmpTEtl/LByDMkEuTtn/9RKYkhPtjv8j/nXJsH95jaicHLfk4yx8oAEtd0DtBV2od/WTtMLprFD2JC4OsLMYVKwKAC9DTmFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755479715; c=relaxed/simple;
	bh=FAIDKtpDAhDQ6ufMvOwa6O4KaKsa0xOuLhpLVVrjZrE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WhtPL387ntQJTHpZB53oIoqqZJiCCejz06473WUcDLgQgJPpYtVxFBfGMIZU/kz1co8aPbI/E/tdiXRLfpZ6Huej2ViV/JCw+0djUFxf5sNBvUO7szI2hjUugYZXZNHeyzyOOcU/Wga8iFT5kgHAsSXHHYOpjyVu1actx6R+++0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com; spf=pass smtp.mailfrom=honor.com; arc=none smtp.client-ip=81.70.206.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=honor.com
Received: from w011.hihonor.com (unknown [10.68.20.122])
	by mta20.hihonor.com (SkyGuard) with ESMTPS id 4c4vrp5WqhzYl2mY;
	Mon, 18 Aug 2025 09:14:50 +0800 (CST)
Received: from a011.hihonor.com (10.68.31.243) by w011.hihonor.com
 (10.68.20.122) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 18 Aug
 2025 09:15:01 +0800
Received: from localhost.localdomain (10.144.23.14) by a011.hihonor.com
 (10.68.31.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 18 Aug
 2025 09:15:00 +0800
From: wangzijie <wangzijie1@honor.com>
To: <polynomial-c@gmx.de>
CC: <regressions@lists.linux.dev>, <stable@vger.kernel.org>,
	<wangzijie1@honor.com>, <akpm@linux-foundation.org>, <adobriyan@gmail.com>,
	<viro@zeniv.linux.org.uk>
Subject: Re: [REGRESSION] [BISECTED] linux-6.6.y and linux-6.12.y: proc: use the same treatment to check proc_lseek as ones for proc_read_iter et.al
Date: Mon, 18 Aug 2025 09:15:00 +0800
Message-ID: <20250818011500.376357-1-wangzijie1@honor.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250815195616.64497967@chagall.paradoxon.rec>
References: <20250815195616.64497967@chagall.paradoxon.rec>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: w010.hihonor.com (10.68.28.113) To a011.hihonor.com
 (10.68.31.243)

> Hi,
> 
> the stable LTS linux kernels 6.6.102 and 6.12.42 have a regression
> regarding network interface monitoring with xosview and gkrellm. Both
> programs no longer show any network traffic with gkrellm even
> considering all network interfaces as being in down state. I haven't
> checked other LTS kernels so I cannot tell if there are more affected
> kernel branches.
> 
> I have bisected the issue to the commits
> 33c778ea0bd0fa62ff590497e72562ff90f82b13 in 6.6.102 and
> fc1072d934f687e1221d685cf1a49a5068318f34 in 6.12.42 which are both the
> same change code-wise (upstream commit
> ff7ec8dc1b646296f8d94c39339e8d3833d16c05).
> 
> Reverting these commits makes xosview and gkrellm "work" again as in
> they both show network traffic again.
> 
> Kind regards
> Lars Wendler

Hi,
Sorry for the delay, I have a rest on weekends. I think I get what happened.
We should call pde_set_flags when create proc_dir_entry, and there has omission
in net related proc file. I will fix it ASAP.

