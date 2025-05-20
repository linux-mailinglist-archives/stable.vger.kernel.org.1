Return-Path: <stable+bounces-145687-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 769A9ABDFA7
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 17:55:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 273C14C0841
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 15:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0023D255E34;
	Tue, 20 May 2025 15:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fbJmG54+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B6E22D9E3
	for <stable@vger.kernel.org>; Tue, 20 May 2025 15:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747756340; cv=none; b=YH8H59iR0TneNL8yNY5FehkwKyzGdpHXfBhnzUunL8u6wMRVFKaM/w/Th+E2jGV772YiKTaJXFAwudZi9MKZuntt9ZDyzoLlq19lGM/dyODLm96B5loPPH9tsWaalVJbWKt4krU9jTx0TBu/naSSNclrX4zUcKfMDt4DsFuCeKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747756340; c=relaxed/simple;
	bh=NaxMbtiyYUlmuwTyUZ6+3Cu6ELXlTAkw4hR1zUa1D8M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G9vf8pBT78PQb3ff3oN4cccrTucGg2pqADyte12X2qYijAWDLb+gpWGasvqUxSr+Ayt5pbuJutoEmpDWZ/qgrLhRnreICsNCsmuN31Wa8S+5wBhwdXLQuA6FW6/fMzEpCi2aGNRoFvBjAX4dJ9G5am+4DhgfOb56CnC1TDd8pTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fbJmG54+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4CA4C4CEE9;
	Tue, 20 May 2025 15:52:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747756340;
	bh=NaxMbtiyYUlmuwTyUZ6+3Cu6ELXlTAkw4hR1zUa1D8M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fbJmG54+DIi/FcFzfNh45CgEEo9PbaNeuwTcMu/YzklVuJ+gSAy6SB2UrNRPF8QVi
	 tR4zaba/pQzXT3VMw6KXf8erh8aFWDj4TatNcRWQaph8QxXJ8a/7Xx3vBaI6uwLebc
	 +8F+eASqFPNYBOTTba9ip+JUczkBMUOAJrjNMf0EIhMicFBTlGWt9RVOsnR13WHu8k
	 P+tcjiIgjqZjJHfI4eHELSmBS1q2CFqtq0TwQQym26ZkNj/N3Y7Qdm5MzZ6EU8jzoc
	 Uuei9y0JVrnIl23kOHbz9Aiulfp9QekD2BXEqr0acuGuqnjvtn6pyW08IHQOW+HMRU
	 shQKEqXpiZXyg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: jianqi.ren.cn@windriver.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10.y] net: decrease cached dst counters in dst_release
Date: Tue, 20 May 2025 11:52:18 -0400
Message-Id: <20250520112507-a6256ddd597e4b41@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250520083304.1956521-1-jianqi.ren.cn@windriver.com>
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

The upstream commit SHA1 provided is correct: 3a0a3ff6593d670af2451ec363ccb7b18aec0c0a

WARNING: Author mismatch between patch and upstream commit:
Backport author: <jianqi.ren.cn@windriver.com>
Commit author: Antoine Tenart<atenart@kernel.org>

Status in newer kernel trees:
6.14.y | Present (different SHA1: e833e7ad64eb)
6.12.y | Present (different SHA1: 92a5c1851311)
6.6.y | Present (different SHA1: ccc331fd5bca)
6.1.y | Not found
5.15.y | Not found

Note: The patch differs from the upstream commit:
---
1:  3a0a3ff6593d6 < -:  ------------- net: decrease cached dst counters in dst_release
-:  ------------- > 1:  f6c680e0bf3fd net: decrease cached dst counters in dst_release
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.10.y       |  Success    |  Success   |

