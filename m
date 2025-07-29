Return-Path: <stable+bounces-165127-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F323B153AD
	for <lists+stable@lfdr.de>; Tue, 29 Jul 2025 21:38:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D10C3BA6F2
	for <lists+stable@lfdr.de>; Tue, 29 Jul 2025 19:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00E72298991;
	Tue, 29 Jul 2025 19:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KoqowPvc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD78729A30D
	for <stable@vger.kernel.org>; Tue, 29 Jul 2025 19:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753817857; cv=none; b=pv0QQXxzXejD4NPXQXOpbM6f2tyf9XGswEG+rVSnU4v7xQYPZOQW9g9HNS8+XkC0rSF+VcgN8MVvHpVFabQBsyzN48t8rUXck9+Jy4VA4NhxTogzdp9zKziZ5teSnht9g1JtkqSAigBpKSdBk0xxj7PkFSSvq1GbJh1tf34hlXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753817857; c=relaxed/simple;
	bh=OyyxP0i9DDz39H4oyEaipQNoR26tN/irYh7twfPHhhI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bXleiP3qU77nGFGY0Emag0CxJBB/A8xJh2ZMYwsG5yOGnMUt7iQ2uxdkp3uHvWSXRyj45Mj+db+ZTy4kelNxQjvIFi67SwYJzF6tQ971moDgeKaOjEB03ixPLUntf+lng8E1rcGCLdPLzQ+N2I/Z9m0eEVCR9n2cAChzxDyFgZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KoqowPvc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89FF9C4CEEF;
	Tue, 29 Jul 2025 19:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753817857;
	bh=OyyxP0i9DDz39H4oyEaipQNoR26tN/irYh7twfPHhhI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KoqowPvchjfXNjlAKraAIW4mAJZmPJ15tOjzBjYRY7I3sF38TShaCeXAyKIzmOudG
	 HbiM05KQm754TOzTBhPfJgvog9q0eMJHoqpD2jaTClrzdrRp+l/dV8O3SiIjZTHOdX
	 o4dxXXAOBcSF3abBBXbpIKOR1oBnoQmaLRjEP+ECLv+30kBMRugS5v9B/02aQflNRV
	 Eq9o9BvFuwOr1NtX/V2S9qSP6q46Nui2DgAw0hTY5MiLoJUe5cdClsS0iXLlrKQsZ4
	 MfUWzne91Y8Qk1wijU5R59dW/zPIC8Hztkxzn7iLohgDYWWOeFFVPVoFpK+lyMkprK
	 9CfnLLAMzoBHQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	shivani.agarwal@broadcom.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH v5.10] block: don't call rq_qos_ops->done_bio if the bio isn't  tracked
Date: Tue, 29 Jul 2025 15:37:34 -0400
Message-Id: <1753812096-cfcbafef@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250729050901.98518-1-shivani.agarwal@broadcom.com>
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

Summary of potential issues:
⚠️ Found follow-up fixes in mainline

The upstream commit SHA1 provided is correct: a647a524a46736786c95cdb553a070322ca096e3

WARNING: Author mismatch between patch and upstream commit:
Backport author: Shivani Agarwal <shivani.agarwal@broadcom.com>
Commit author: Ming Lei <ming.lei@redhat.com>

Status in newer kernel trees:
6.15.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (exact SHA1)
6.1.y | Present (exact SHA1)
5.15.y | Present (exact SHA1)

Found fixes commits:
aa1b46dcdc7b block: fix rq-qos breakage from skipping rq_qos_done_bio()

Note: The patch differs from the upstream commit:
---
1:  a647a524a467 < -:  ------------ block: don't call rq_qos_ops->done_bio if the bio isn't tracked
-:  ------------ > 1:  2b3b2e94a12e block: don't call rq_qos_ops->done_bio if the bio isn't tracked

---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| origin/linux-5.10.y       | Success     | Success    |

