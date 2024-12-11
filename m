Return-Path: <stable+bounces-100655-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 376B79ED1E0
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 17:32:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 215AE166736
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 16:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A305B1D9A6F;
	Wed, 11 Dec 2024 16:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bmkqDp6v"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62E6138DE9
	for <stable@vger.kernel.org>; Wed, 11 Dec 2024 16:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733934752; cv=none; b=Pfbc9hvTSr0pezlpDNatyzjUCn4mz+jjtFiQEuQXuPIEV54uCYqsNEO6l61N6xtQm8wE+PxFmbGU+6oOjdvSPfr/GBtklcL67L6STOvBKJf/lJ+4sWc0IwvU79NiBuHmNBPB6t/kRVV6WOZtnsEbis+S6Uhn5fiPTl2z97O240A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733934752; c=relaxed/simple;
	bh=SmO4fNex2Uk8XOmrK2BKXwMJiM0gJSJbo9ivEHJicW8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sgr1sljgHW1xih+JqgYzc9sc+6HTff3GxHo2TmZU8TjNU/vozB92Ujbc0mAlLJIY0CvOxMBRMfEVSDfGQVgmfMPs47vg2EsVDwpWaffbeG0/fdeVzcMn93dncKjkS+y4BZZzJb+uLvOgCrZwKt0Jbg+uaNVnIrcBpKCAfo0FaVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bmkqDp6v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C363DC4CED2;
	Wed, 11 Dec 2024 16:32:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733934752;
	bh=SmO4fNex2Uk8XOmrK2BKXwMJiM0gJSJbo9ivEHJicW8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bmkqDp6vYypcLFQnRivbPl0svecDHWikaUCicXB6SYHU2b9pt5j60rH7d7MmLfKU4
	 hf7cRvgJEiqymTrJ/+WODCTR0eZPM7McaP23ijqcFAgjKyZdgNtVkxiQ1ffsQJ5ivk
	 iL19MQQdM/a00ddrdGFh3Cj9ZYeww1su04litIu/f4HfTWFBUUWH1SZnpuNMaD3zyk
	 NoFXdF0Jrw03U4DUyTogq/2eIRN05OjnDFmRuxmOJfNQy8O8g7JZi2amu+k1dJXyNg
	 ddZP4l2yUKuiCgkqo375ZgIG4EKHIA8yI3kgjeNzHTQ4Z1DJbjHlqo7YcomB3Yi7NO
	 o5/JHiBBbSuxA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: jianqi.ren.cn@windriver.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y] i3c: master: cdns: Fix use after free vulnerability in cdns_i3c_master Driver Due to Race Condition
Date: Wed, 11 Dec 2024 11:32:30 -0500
Message-ID: <20241211101335-4735b6eb2b3c5a77@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241211101157.2070087-1-jianqi.ren.cn@windriver.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

The upstream commit SHA1 provided is correct: 609366e7a06d035990df78f1562291c3bf0d4a12

WARNING: Author mismatch between patch and upstream commit:
Backport author: <jianqi.ren.cn@windriver.com>
Commit author: Kaixin Wang <kxwang23@m.fudan.edu.cn>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: ea0256e393e0)
6.1.y | Not found

Note: The patch differs from the upstream commit:
---
1:  609366e7a06d0 < -:  ------------- i3c: master: cdns: Fix use after free vulnerability in cdns_i3c_master Driver Due to Race Condition
-:  ------------- > 1:  60a42e2236b35 i3c: master: cdns: Fix use after free vulnerability in cdns_i3c_master Driver Due to Race Condition
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

