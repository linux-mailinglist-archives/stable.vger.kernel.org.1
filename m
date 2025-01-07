Return-Path: <stable+bounces-107882-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 58602A048FB
	for <lists+stable@lfdr.de>; Tue,  7 Jan 2025 19:10:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3C771883476
	for <lists+stable@lfdr.de>; Tue,  7 Jan 2025 18:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B94AB1E3780;
	Tue,  7 Jan 2025 18:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S/UHICAK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B161E0DE2
	for <stable@vger.kernel.org>; Tue,  7 Jan 2025 18:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736273421; cv=none; b=RBYkJlJTPaH5zw/D7/ne4OhllU7Xh1U/Xd3LjD4v4N7Q2+7URsiYaSR1NEvRNtg+SXbabqQlkrXtHZxAVli8OBcS+LNvuBwjqmjecKlh9zTbjiQL/LWEXS/s1f6MQQWokig5VXmu7lN1VSFO14VNCyzaGOM+bgCbZeGCef5pem8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736273421; c=relaxed/simple;
	bh=3gZbILM0RkhDMy2craYdZuen2po2j3Jypswf2Ll1gqs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZwMfEyjtUEeovr15RTVeFRnVxl5siom0pocjMoqiH3o9Nse1p03eIOrHD8kmTuNhQKSdWyc+6+HR6rxG7trJRSYPwubs8bavpTpBb5Giy73z7YxD5l1c66IbdasXcjLRdlTs1rqV6P1L35RWZWl/60Xtby1s/LMq2YgBgabf0l4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S/UHICAK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 372F9C4CEE1;
	Tue,  7 Jan 2025 18:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736273421;
	bh=3gZbILM0RkhDMy2craYdZuen2po2j3Jypswf2Ll1gqs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S/UHICAKEniaTZa315/iu7wpISTUiXBsQTm1Y5S+zeVnx7YKfZDqCpTYTheyrU6K6
	 SEj1JzLEHWfsN5XYKYB6UraNgI67paswrzLdsu3Q4ncAak2PK4epBAtl1+ctDxJslU
	 zqyKlwfJ5nrzwZUnkwClxlQq5SnP3hY2/aFP03+821HG1oTKznuOkSEzVbCd/M0hDv
	 hIjLUs+g1r0Mv2AaPxaY0gu9rzMLAelC8hxB/i1HGEmnH/oaiW4RhhlmQuhgypj4W2
	 RLDhoscpa4ESRTWrb1AYdxgtYLKBM98uMT7QMnR0Ig959BpYFbPql2FxQo4ko8kk05
	 +Nw6asu1zCGjg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH stable 6.6 1/1] Revert "bpf: support non-r10 register spill/fill to/from stack in precision tracking"
Date: Tue,  7 Jan 2025 13:10:18 -0500
Message-Id: <20250105093442-86208c130d4fcc3e@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250105062753.1854065-1-shung-hsi.yu@suse.com>
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

No upstream commit was identified. Using temporary commit for testing.

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

