Return-Path: <stable+bounces-134609-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93A01A93A0E
	for <lists+stable@lfdr.de>; Fri, 18 Apr 2025 17:44:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A97F3A3F68
	for <lists+stable@lfdr.de>; Fri, 18 Apr 2025 15:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3516E1E884;
	Fri, 18 Apr 2025 15:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iz1/0ivN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E468E2144B6
	for <stable@vger.kernel.org>; Fri, 18 Apr 2025 15:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744990975; cv=none; b=nroYcow52X4QATGp4q2/JhTKkSUYlr0IVQf8Q1ohBSZDz0E/3kIhvQoZ9NpYJjvg2IBTUhqJ6gegKT9ZhyUhRjkCoacXk96wC9GLAwi3t3dhH3yTChdMtbrGB7ETGY9hE5XPJMK3LX2FEfLvezL3mnc85o4l2L5vHve7QBBcINk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744990975; c=relaxed/simple;
	bh=BsFjDIpaMxEZCd20zJrYN2jn82vL386McjgmnCnKLgI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QZeUs3QA1ke7NKB4+Wx7zM/0WCA7Y2egyyfcWErhxQJGXZCLfhMqVH4zdMLv/uMhO8CiFrF5fhVhIrv93v/sJTi+LB4aktHySKOV9bQC+NqqEIqdFKpJ1apP5b/AZU7pUcvIIq9nr60TBpE3XZK8QZjyWoSsodNRbOrY875UM94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iz1/0ivN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E88B3C4CEE2;
	Fri, 18 Apr 2025 15:42:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744990974;
	bh=BsFjDIpaMxEZCd20zJrYN2jn82vL386McjgmnCnKLgI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iz1/0ivNEKtDhOxkWisbfadgNKfECDsPJdY13zXse3NnYduguzAdY7VYM5Xg069W/
	 5Sl/+O5QgvcfOQ3r2cwRrWZ2QpJWoO7mhQlWQpFBzbpoowqfKuq7xXaF0o1wDDhMhP
	 gdql37BX7nqY2/z63h8ZVBjt0nK3nI5p0cyl7LwW500W/33I8YwKmlA/7AVmbQS8Sm
	 2H1f53eYA458Z6r26IXFd5VSFifMjzQZPTjyvt0S3kSDEBRgEYWeYmXjOytWk8RZcs
	 GHM/2t0uuRdnTVdgTi1PBP4pH1/kSb1FSu0RSNG9Na4y5UxknVcneTwrFu73FFHeuo
	 NbXjgAV99g4uA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6.y 1/2] mptcp: sockopt: fix getting freebind & transparent
Date: Fri, 18 Apr 2025 11:42:52 -0400
Message-Id: <20250418083633-d88530477cfe678e@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250417172749.2446163-5-matttbe@kernel.org>
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

The upstream commit SHA1 provided is correct: e2f4ac7bab2205d3c4dd9464e6ffd82502177c51

Status in newer kernel trees:
6.14.y | Not found
6.13.y | Not found
6.12.y | Not found

Note: The patch differs from the upstream commit:
---
1:  e2f4ac7bab220 < -:  ------------- mptcp: sockopt: fix getting freebind & transparent
-:  ------------- > 1:  814637ca257f4 Linux 6.6.87
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

