Return-Path: <stable+bounces-100665-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A7AE9ED1EF
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 17:33:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C6AA166AFA
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 16:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 088111DDC1C;
	Wed, 11 Dec 2024 16:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LCv+iZue"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA8471DDC18
	for <stable@vger.kernel.org>; Wed, 11 Dec 2024 16:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733934776; cv=none; b=odJtBPDeUGraDKXPPD6RnIOVgeVxZNmYycafdAmKHElXiFULHAHJ9WeTqHa1gmE5fcqA1ZbLcEAmMoTFB7roCwGsIAlIDbJ0cJiYDslxaVWVGlmAX+82uyuFI1d9RFy7oGn2r3vbuWrhSSl7KFdFiKQxThuXXz+Hr/DOPywPyYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733934776; c=relaxed/simple;
	bh=u64+mG6rrGwDskig2C5oIhu6gOn4++3SI5UG1S+Ceq4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q2CDD+ptDlnPhOWnk0wFqm2pxoXjqKM/1GrrMI0UhpJpBlLE2AZZQ4OzdsWErzkiPj8vQdvO7jl8L9AZ0cVEj7kUqcNEN5FGccqPhLRamTBqS8NdJ37XtIrutD+4DUXT6p/JnwMA9F62jkTjKBXZOM44AkQMGn3/Zmwnk0hZvWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LCv+iZue; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC423C4CED2;
	Wed, 11 Dec 2024 16:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733934776;
	bh=u64+mG6rrGwDskig2C5oIhu6gOn4++3SI5UG1S+Ceq4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LCv+iZuewC4qs4WHTisT5QXJvm2elyKHn7Q/roENr0zX5TJ/AfnuQTyYyHRRzMULf
	 grSqGiA3aVMVfOVvGIAtQPaU9R30wBWhM1yjJ+ztuj4sFnLxDdgbiOAWDpb09Qmmlg
	 5nYMq73PVjVl1j+KyW9ryMuQSfNe3Zc+CDOzXU0i4blfFqrN550HfrnNR2muSfyx/G
	 frBX7uStV/WKZAK16rZeY0DtzR+MpCINQQemd07XqKG6c6pj+k+ovjYtkt1tjaPBvL
	 MGN/A5+CkmkOy8sAHZCSkmuHwt2k+SUFGIaFH5RMssMf9olTA1PezyXsa6qzzck9bR
	 /rwo//LS7Lk7w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: libo.chen.cn@windriver.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH] crypto: hisilicon/qm - inject error before stopping queue
Date: Wed, 11 Dec 2024 11:32:54 -0500
Message-ID: <20241211084127-dc114d54cfcc3647@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241211025442.3926281-1-libo.chen.cn@windriver.com>
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

The upstream commit SHA1 provided is correct: b04f06fc0243600665b3b50253869533b7938468

WARNING: Author mismatch between patch and upstream commit:
Backport author: libo.chen.cn@windriver.com
Commit author: Weili Qian <qianweili@huawei.com>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)

Note: The patch differs from the upstream commit:
---
Failed to apply patch cleanly, falling back to interdiff...
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.12.y       |  Failed     |  N/A       |
| stable/linux-6.6.y        |  Failed     |  N/A       |
| stable/linux-6.1.y        |  Failed     |  N/A       |
| stable/linux-5.15.y       |  Success    |  Success   |
| stable/linux-5.10.y       |  Failed     |  N/A       |
| stable/linux-5.4.y        |  Failed     |  N/A       |

