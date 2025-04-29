Return-Path: <stable+bounces-137078-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18FF7AA0C18
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 14:50:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FBC1843DD6
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 12:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 446B420E023;
	Tue, 29 Apr 2025 12:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mdajp0gE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 046C12701C4
	for <stable@vger.kernel.org>; Tue, 29 Apr 2025 12:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745931028; cv=none; b=cBG2IEn1vD0V57o9i+hk3ZAIiBqxRIe86SHTM0oHTo6YRL1kdrBHWICIAJopD+iwbUg4EOYt8ORw2b0V9JSCr37UuXu5JcmvjwB8KuiK/LyBBxN1r2vY4E16JpC3dL39Gxd+SGajC2GSiuqm2H3ltbsdovtrVYRPttRbPZdL+nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745931028; c=relaxed/simple;
	bh=CtWu7MUFebpWH661JODZrd13vStbCoXpbnc12KIEHhE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ha6heajaiQ5gRWupQfl5gYmZmwRGqDCStcvOlf1EbPfhsG87GrW0Vq6E6RR4+gNTDZnJUxFJNYT0Y3cSDnGOdn3CYpBVLFqq8I3THry9AyPOJqBx0lcD7VTCLImMtIGt18dapJ146A0X1Qf+wqWuClvNWdEaXTay9Zki57yQvFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mdajp0gE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66C91C4CEEE;
	Tue, 29 Apr 2025 12:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745931027;
	bh=CtWu7MUFebpWH661JODZrd13vStbCoXpbnc12KIEHhE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mdajp0gEr9Ticyzqcj1P+GgAmiEkwrPZa9jeXqrFC2XxK/GAwXSp+ZihgytsCDLuO
	 ktdyt2czFI2VRYZygP5yL+at1ptUFtzABfzJCRqRVYYyFCFPW4JdJm0hvo5K5JMXCN
	 Kkf0qhInO7ToHLqIVTKbmNFRM0Pea5/Lxur8nItQIRlD5nvsBjmrW6TPGUUSXDlevq
	 e5QmXxS7NDHTaVnN+Ouw77kBwSi4wUn3mMqHsDnoPrqbG69iHES+97T/ky2t6lBhW9
	 JteZSY1Uk+64vtIix6MfyU479Cg9C0SCbu4ce6ceaNDFWrJPNOVxNyOxytSdyBeR0n
	 f4rMET7S5reiw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: jianqi.ren.cn@windriver.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y v2] net/sched: act_mirred: don't override retval if we already lost the skb
Date: Tue, 29 Apr 2025 08:50:23 -0400
Message-Id: <20250429003113-2d1e50f66a422c0d@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250428080103.4158144-1-jianqi.ren.cn@windriver.com>
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

The upstream commit SHA1 provided is correct: 166c2c8a6a4dc2e4ceba9e10cfe81c3e469e3210

WARNING: Author mismatch between patch and upstream commit:
Backport author: <jianqi.ren.cn@windriver.com>
Commit author: Jakub Kicinski<kuba@kernel.org>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: 28cdbbd38a44)

Note: The patch differs from the upstream commit:
---
1:  166c2c8a6a4dc < -:  ------------- net/sched: act_mirred: don't override retval if we already lost the skb
-:  ------------- > 1:  799e00a9644fe net/sched: act_mirred: don't override retval if we already lost the skb
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

