Return-Path: <stable+bounces-110177-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 407D4A193A1
	for <lists+stable@lfdr.de>; Wed, 22 Jan 2025 15:16:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BB6F3A14D7
	for <lists+stable@lfdr.de>; Wed, 22 Jan 2025 14:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F305213E7B;
	Wed, 22 Jan 2025 14:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CmexeBM2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E022A2135CA
	for <stable@vger.kernel.org>; Wed, 22 Jan 2025 14:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737555385; cv=none; b=QT5KXAq7PcouQhG1TjgbYRHy0UZ5Zkft5rC6+1Io/k9lwjS6biw+v6qhl3Qu1W2RQ+Rk7GtWZJUaBUkjS69Kh0FFw0mxOzKIIqsT7km94oTSp+H0lHKljf6aRgqO1zGsoEOOKRvvjkbAu1irHnRNdknO5n3jHvjYYoq7RPGrKNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737555385; c=relaxed/simple;
	bh=8e5zbRoTonbkd4JPeFSumOxLRaZsNxbmU2iwa8g4qd0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JaWTSPjCL5UNYaQKyQCPQaR6lGhf0NYCZTxC2fHu/zAalYriCdOV44ITXjTPHa+13uOWEZfuACQ5oZ0iTwTH/jUOc6l538pG8610mQlx7GsYpFk+oBJ4Jl69G3xN2nixKbyt59CW4+ldeYcIW1oHbzkZVyM0pztZIkZ/dcOJOdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CmexeBM2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D284FC4CED2;
	Wed, 22 Jan 2025 14:16:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737555384;
	bh=8e5zbRoTonbkd4JPeFSumOxLRaZsNxbmU2iwa8g4qd0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CmexeBM2DC5jQw8H3oTt+wTeOqwapxSJs3Nt70qMROJBwAEOAokmOoQLUu81G95cr
	 rQB90Ce6UMRlHEAFIiBy5ozr32ihfrWpdNgHFYv43r8s8Nn/UIs+KR3OdJZjJGqZRB
	 5HN5EAtda7ko8g5c/YrG8bNhhJLkzOHuADHqqgFFFvvZcgJz4AIMp5WfDn21Sntr8O
	 Njigk6w6uTak8N2Cg1CerWRwMYNSZCCttCBkgYmJOvh8/Nde+BUWHXIY2xuhpaIndG
	 IUON2JlmyoQgLta3oRRRJpBVoVZ3O5Ycb9o/R8I6CCbk6W2j72i+f2L2xiH8pgtPni
	 rY2UiWTIQnj6A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH] KVM: x86: switch hugepage recovery thread to vhost_task
Date: Wed, 22 Jan 2025 09:16:22 -0500
Message-Id: <20250122090247-2e5bca8e6a22b5e6@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20241108130737.126567-1-pbonzini@redhat.com>
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

Found matching upstream commit: d96c77bd4eeba469bddbbb14323d2191684da82a


Status in newer kernel trees:
6.12.y | Present (different SHA1: 91248a2e4101)

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
| stable/linux-5.15.y       |  Failed     |  N/A       |
| stable/linux-5.10.y       |  Failed     |  N/A       |
| stable/linux-5.4.y        |  Failed     |  N/A       |

