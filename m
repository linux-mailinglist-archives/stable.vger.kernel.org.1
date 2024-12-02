Return-Path: <stable+bounces-96046-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8B689E08DE
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 17:42:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6BE5CB3C741
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 14:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6BBB205AC3;
	Mon,  2 Dec 2024 14:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UpUSH21W"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A37FB205ABB
	for <stable@vger.kernel.org>; Mon,  2 Dec 2024 14:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733149598; cv=none; b=Jc81JO5JILWVfkDWA8kUWZuuAFPh9QMzSJ1vciA+w+kcrxM3kLoHk4rbHBKBRkvpcWCztqw4wCM1a/hw7utAdeJCYkjUXqe8IEhT4qn3zCRoFRrDEA9gT45XmakPSdhPh5gxjCQwa1m5YHB4s06URjDqeND44klnJCPmtzORLDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733149598; c=relaxed/simple;
	bh=D5n7lDtMv0tZ4UGOe5MOFI5huZPvwlHhiXJNfH4EzGo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SxaZPTKLU2QIo0JzkmlVnL84PJRS9riVSGRoB6UKS0EP89vNtlFkHiHRBS1h+fGYwpVeHNDGEk+yB75zKchiYiLHr7c4jhNVjTNQIvWqML2fdcq/IdY5i82ubZBPnZSz+IgPybg858Mrp777r+6v8djzL21vdVUfbfmSRLAEFGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UpUSH21W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B17C3C4CED1;
	Mon,  2 Dec 2024 14:26:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733149598;
	bh=D5n7lDtMv0tZ4UGOe5MOFI5huZPvwlHhiXJNfH4EzGo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UpUSH21W9SLpZKHcbG1UadZbQ/z5eArQ0MYuEiKej/LI8+D9Teu3Rh7VBVuJQm5TY
	 BQUxQhWNV16a3OD39gkPW501tjMP8wI6YxewxbiftLItw8PcfRJWq2tMcsBdZ1zSyV
	 DSB0V7KOge5u7UZaALaSCOYifynaIF607shmto8f4Fe8fyEMI/Du57l66BHfFeA4/3
	 quC3YsUK1ehbefAKtbYtGZE5Egfq8/r2Id4kScCg2GFWFXdKZJUMCD/jUH2KgojyYr
	 sWRiiw0LiLfkbb9da/Xnd33V0t2WjNC8ee5aZ9fxay5t+G82XCuuWdbM6Q9KsjyBeH
	 Cnsw9fECoQ+6g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.11 1/3] dt-bindings: net: fec: add pps channel property
Date: Mon,  2 Dec 2024 09:26:36 -0500
Message-ID: <20241202082427-ab4af3e7ca87cb9b@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241202105644.3453676-2-csokas.bence@prolan.hu>
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

Found matching upstream commit: 1aa772be0444a2bd06957f6d31865e80e6ae4244

WARNING: Author mismatch between patch and found commit:
Backport author: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>
Commit author: Francesco Dolcini <francesco.dolcini@toradex.com>


Status in newer kernel trees:
6.12.y | Not found
6.11.y | Not found

Note: The patch differs from the upstream commit:
---
1:  1aa772be0444a = 1:  5da2b2c0837a1 dt-bindings: net: fec: add pps channel property
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.11.y       |  Success    |  Success   |

