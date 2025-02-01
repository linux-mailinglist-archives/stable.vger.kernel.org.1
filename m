Return-Path: <stable+bounces-111923-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0C79A24C37
	for <lists+stable@lfdr.de>; Sun,  2 Feb 2025 00:53:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FBC43A4613
	for <lists+stable@lfdr.de>; Sat,  1 Feb 2025 23:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59A101C5F34;
	Sat,  1 Feb 2025 23:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IqZa1JYh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17B321534FB
	for <stable@vger.kernel.org>; Sat,  1 Feb 2025 23:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738454026; cv=none; b=U97yuRTWZWmLF0DTRUVK/P5myO047HiWDUC9E/E9jI3U0DgiJeBiz4j9QtoObPCbC/ZtFVMu7SmNUWM5YIJApecmgy1kBpbJDTpVHN1gEXhKc4ZHZFvjXP57xthsdojl6i4dK/wsmDoO1xBb+FV3nY5AlQKfqIX85He+WuMzF3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738454026; c=relaxed/simple;
	bh=c6YvfMbbbOwL87/W6EhnbCL7vHDyH7JRdqczsO4sZuo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=puDstcCkM09U6qiiTonqHrbCB//PP1U1PG0oUuL5cw6l5r7DbJw0YAHkvowPp2rja30Hs4bXvtO5c5S64vybGmGgMxzlRB8Dx3Pg38vDySa1zXfisdoB+jv3Gy4TPan1GkWAJLD49g01NDHR60lQN53pHDhgzqJD0qgmTg7WdtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IqZa1JYh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76FF1C4CED3;
	Sat,  1 Feb 2025 23:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738454025;
	bh=c6YvfMbbbOwL87/W6EhnbCL7vHDyH7JRdqczsO4sZuo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IqZa1JYhJlsYoour3kpPFcWAUqfZ2e3eqPyngCIa3Sdc13IjqBNJGakHHpXsgzyWH
	 HOWx2DgU2HUouIRX8tXYALFMJrIg5/W1BMGiYhcTYEHwjYXbozVKvHPSO1HQ1NLYOy
	 ynUljvkDyyVsgCaSJRcdW/MTG+oxfxK9isZI4X1trmJ7B5c+VJsepS7oDL6TfmQDSh
	 Q9dw/m/ePFaWbISHYhAmfCICiL4VuKCx5JpLDu5MQpm2vdRogT02SDhqeMx+5fLZTp
	 8aLnL40kpNkiuhwyDGSq5Cd9EslnR17NgaSlMTDg2nDUeBkLDr9OEppJA2W7YyVMPs
	 siISaR4hwKATQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Leah Rumancik <leah.rumancik@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1 04/19] xfs: rt stubs should return negative errnos when rt disabled
Date: Sat,  1 Feb 2025 18:53:44 -0500
Message-Id: <20250201132953-61871c865353df47@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250129184717.80816-5-leah.rumancik@gmail.com>
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

The upstream commit SHA1 provided is correct: c2988eb5cff75c02bc57e02c323154aa08f55b78

WARNING: Author mismatch between patch and upstream commit:
Backport author: Leah Rumancik<leah.rumancik@gmail.com>
Commit author: Darrick J. Wong<djwong@kernel.org>


Status in newer kernel trees:
6.13.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: fe327b8234d4)
6.1.y | Present (different SHA1: f81de59216c1)

Note: The patch differs from the upstream commit:
---
Failed to apply patch cleanly, falling back to interdiff...
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

