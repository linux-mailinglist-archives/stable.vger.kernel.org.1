Return-Path: <stable+bounces-137067-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8D0EAA0C0D
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 14:49:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5DF98439A5
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 12:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D9DB2C374B;
	Tue, 29 Apr 2025 12:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bitJ0Gt5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F902C2593
	for <stable@vger.kernel.org>; Tue, 29 Apr 2025 12:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745930981; cv=none; b=LBBHAxt3L9kOp29edLE71R403S8ofkLLkhcXw1HAo57ObLzZPdraVkVVY7vC2ScDhIOf/p/EJaMNDRDw75X/ZDGbaRpeye52zJ7Lvk3TPZuaqkXaJxUkgxeYQhA8wcKZwtSxO9jB7B3Y0UkXY7t/u5nrgPdm97+unUwwbB30PpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745930981; c=relaxed/simple;
	bh=syl+OByRhXkxY/ZrNYzBa6lpaomsumfDUYV1uPeb76w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rsZbLJQUf2ZYp39ZI7QlyVGim5IGiDqTZcUxguiH1etHo7kskv68q+LJO+yA0sydTUy/llheMLwK+6c0gS0SpBxyTBVxa6YMRbcNbuJ80jLYGw6ge6FoCdtPMqhQ4bs0RQ0wIHuh63/iS3uXuodAw9hNQejlHuf4jMHcC9jw5ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bitJ0Gt5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 547E7C4CEEB;
	Tue, 29 Apr 2025 12:49:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745930980;
	bh=syl+OByRhXkxY/ZrNYzBa6lpaomsumfDUYV1uPeb76w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bitJ0Gt5prqqOf1jiCtWwGKtXltuOxXGdULIzo/7Na7gAC4VmI0ZqX99uWBH5LLw1
	 RX8KHBK7L/oZyGR92Z8eK4AjwdVUYkzwqwNSOZrOgWGhJJlHc/429I3b15tE6cK5ah
	 Uu4z+Nrm0Ad9E5tVCfdrGt0psPnUPqlZECKa4kgcG241NbJ4Gs/hHr/H2iAdRvjil9
	 5i3yucykOAk16StGOPgG8yrICrpCoDEB9qZN1+h3sCHvi9ZxKquoCug2C25NzhukQw
	 YkHClOIGnuFoJS77KCpi1JXI0CaM++PfYxtFwTzZulz0OAcMz+mWgUmsCoybXGccwU
	 O8I12ydCBvCfw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: jianqi.ren.cn@windriver.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15.y v2] net/sched: act_mirred: don't override retval if we already lost the skb
Date: Tue, 29 Apr 2025 08:49:36 -0400
Message-Id: <20250428214912-8463d455e2dd7889@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250428080216.4158232-1-jianqi.ren.cn@windriver.com>
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
6.1.y | Not found

Note: The patch differs from the upstream commit:
---
1:  166c2c8a6a4dc < -:  ------------- net/sched: act_mirred: don't override retval if we already lost the skb
-:  ------------- > 1:  8ded85d1d65c1 net/sched: act_mirred: don't override retval if we already lost the skb
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.15.y       |  Success    |  Success   |

