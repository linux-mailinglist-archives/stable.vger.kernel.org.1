Return-Path: <stable+bounces-165701-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23CE1B17911
	for <lists+stable@lfdr.de>; Fri,  1 Aug 2025 00:20:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3C4B3B111D
	for <lists+stable@lfdr.de>; Thu, 31 Jul 2025 22:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70EB1276059;
	Thu, 31 Jul 2025 22:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kecvE9Ah"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30DE1275878
	for <stable@vger.kernel.org>; Thu, 31 Jul 2025 22:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754000416; cv=none; b=k8Lm3Nf9d2IjFBAOQzXMsHO/+iUQ/8Zm8ptShNwDxoAWAe7djeoOb6Co8IDurX8vBCDnXPi72j5TrTZgXUM1vm20GeERCVARdX2P0wX5meupjXZUhZ8z8e5lPxx0Z5+QNu1u/eVu14W000Y0enLw1Wdcso5Q25QrqGCC5kCfedc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754000416; c=relaxed/simple;
	bh=dgv5FM3u4wZ6WusU/llvMaTmEHh2McO4zZ1iU/wPGjM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IvO4E+lgkYC1OJMFKLBrZK3fRJgJ/yFTkXF8678/uPosqrSMkH50ss7TxETpZo1XZltwfsjMSLI6Ra8O37CIBbaqxWGQAtuyF+dFF/6+N4F6ze0jHY2/CayYLBLBiS0L5rBLWtWXkzk7ryBG8g2zMxYBQIqKDy5ZtLG2K7cSCjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kecvE9Ah; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F648C4CEEF;
	Thu, 31 Jul 2025 22:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754000414;
	bh=dgv5FM3u4wZ6WusU/llvMaTmEHh2McO4zZ1iU/wPGjM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kecvE9Ahqm7ZF1s04/t4zGxWJHpEHOy47xLZfQAhHBMRqSiJ2iBF/t3vR42kGN7N+
	 +f9n45qcZD78zZwDXrJnuhD4ndCRv32vORG9BvBQCwt7RmK24pQkIPtLHbISxhmC5U
	 I41y3fawSRcVky+iB5uf88b2ZcnmPvf3YgLZPOYA/RVJ/fOGI1v3c6lZG8MhPMEvNe
	 2x2tJwb5A90hjQLYme8YKCFELJrK0qwVCfEy7ghRm9cxVejaMTcnWzIOIrDrIqnX2U
	 dnQ2hj00RhxygmqVYgLleIXuyUl+nTVhjCsKsGfygIMla1sJgx53cHcbx5Fm8DSJR3
	 xYIp4raKQBQCw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15.y 2/6] mptcp: fix error mibs accounting
Date: Thu, 31 Jul 2025 18:20:12 -0400
Message-Id: <1753975974-3ad2be7e@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250731112353.2638719-10-matttbe@kernel.org>
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

The upstream commit SHA1 provided is correct: 0c1f78a49af721490a5ad70b73e8b4d382465dae

WARNING: Author mismatch between patch and upstream commit:
Backport author: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Commit author: Paolo Abeni <pabeni@redhat.com>

Status in newer kernel trees:
6.15.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (exact SHA1)
6.1.y | Present (exact SHA1)

Note: The patch differs from the upstream commit:
---
1:  0c1f78a49af7 < -:  ------------ mptcp: fix error mibs accounting
-:  ------------ > 1:  b91cf40fe637 mptcp: fix error mibs accounting

---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| 5.15                      | Success     | Success    |

