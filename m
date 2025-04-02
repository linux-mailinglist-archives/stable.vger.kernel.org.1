Return-Path: <stable+bounces-127439-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAF2BA7979D
	for <lists+stable@lfdr.de>; Wed,  2 Apr 2025 23:25:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C17D03B3A33
	for <lists+stable@lfdr.de>; Wed,  2 Apr 2025 21:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B608519D897;
	Wed,  2 Apr 2025 21:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o+J+svB4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D4D288DA
	for <stable@vger.kernel.org>; Wed,  2 Apr 2025 21:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743629103; cv=none; b=ObIvHMQXI3veVH7A4w1polpfX9No9LAZ4oDq890j3RUUHhFDICLr6jGEsq0WsYTDsndpbSLvecjFGmyTCYvL+tTanEZz18zf49yZoZdYNPMfUJc61qdszfybEE9dMRoj0OZ1jUAxEmtPb1Qfa45UPz5E2v9sO4qq8WFzTvP8KgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743629103; c=relaxed/simple;
	bh=kQ3NIpWMy5/myPnOTxsCug8XsgodRMxjaXyjKxXjaC8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G/nASTxhK5xLoNeJ48CxdnV7HLQ0uGtb5jVdr2hHZ7JppBFl2E2SzYHMyre8M1eS4+0X+5rU4a9BSwZg7ubHBXereECZvVeq73xpb1SXr87eXxUjN6VstGpbngdoDaUNMWdzhoTsxMqngyJCmOG8zm6DSKanb6uacGeedoGtQjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o+J+svB4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77378C4CEDD;
	Wed,  2 Apr 2025 21:25:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743629102;
	bh=kQ3NIpWMy5/myPnOTxsCug8XsgodRMxjaXyjKxXjaC8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o+J+svB4DzZNNMBu9n7kp+15l9tKmkwhr/Mx2jH96+cGEtdPuozw9dPL6HtZoYm+y
	 GidbHEbenDbmMMwVCZpWp9FEXIhsZ9z3+Vpp3kvDe5o+7yw3BAWcmd9KLYrLdwo3qQ
	 AfGJuauScNOL3BkNhJuH98nIU2+Dpf7xe2x22b44nq2scjybu5I36JWQuxia2NXH0J
	 GZTNiKl6Z8tkGhfGDEmY2ILIcYfAT38Ljcz6qAO0A3DlhyxYKoyaiMS7gc/j8mxgcE
	 kC0osqm0FRasy7MBgLlKWgtSKo+igW1MgBT8Iw5LCl3ebjq/3OIjRXkmtxEhCjVHM2
	 ghtGyyJnUAoYw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Cliff Liu <donghua.liu@windriver.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10.y] bpf: Check rcu_read_lock_trace_held() before calling bpf map helpers
Date: Wed,  2 Apr 2025 17:24:58 -0400
Message-Id: <20250402124727-e5de7a5a0e0983ef@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250402030457.617254-1-donghua.liu@windriver.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

✅ All tests passed successfully. No issues detected.
No action required from the submitter.

The upstream commit SHA1 provided is correct: 169410eba271afc9f0fb476d996795aa26770c6d

WARNING: Author mismatch between patch and upstream commit:
Backport author: Cliff Liu<donghua.liu@windriver.com>
Commit author: Hou Tao<houtao1@huawei.com>

Status in newer kernel trees:
6.13.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: 483cb92334cd)
6.1.y | Present (different SHA1: d6d6fe4bb105)
5.15.y | Not found

Note: The patch differs from the upstream commit:
---
1:  169410eba271a < -:  ------------- bpf: Check rcu_read_lock_trace_held() before calling bpf map helpers
-:  ------------- > 1:  39bb26e992067 bpf: Check rcu_read_lock_trace_held() before calling bpf map helpers
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.10.y       |  Success    |  Success   |

