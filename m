Return-Path: <stable+bounces-134676-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50D28A9432C
	for <lists+stable@lfdr.de>; Sat, 19 Apr 2025 13:47:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB96E3BA71A
	for <lists+stable@lfdr.de>; Sat, 19 Apr 2025 11:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E61DF1CAA7B;
	Sat, 19 Apr 2025 11:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eLYQrXl2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A465318DB29
	for <stable@vger.kernel.org>; Sat, 19 Apr 2025 11:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745063216; cv=none; b=C2oRbY3VkH6kS8UQhl3L4wgFK5DW0svvqFrrOz3Xz00aQAtzlTnEwPe7R7xUY77O5NVnmCTj8fh5VONNTQeZ4wwX6ytPArvF+dPT+pldETfGTR+KfGHqXjsFadB4erEhOHBmpdV7BX1ewnZVOzeLewhuIKGwRQ629D9ULLjfPZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745063216; c=relaxed/simple;
	bh=Oh7LphJizm/5eNG3YZWZq9GXGwL5IJrXPGszME7ghVw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MYfj3uRYbRv2jfApjpnRQJd7Mv5HZEQyah8LlvpEh/PM33o67I60doUvJtCbyVoUNQ7N3UCsOqIXzBHkiwdiJW0eDhgAM2gZoYAmtXbwKk6qcY8nPA0N0W5rUiMHn+a97NkTHFDDZ5qIPerkEIWz4OLKA4+MjX5k8eLCn17gC4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eLYQrXl2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADEC7C4CEE7;
	Sat, 19 Apr 2025 11:46:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745063216;
	bh=Oh7LphJizm/5eNG3YZWZq9GXGwL5IJrXPGszME7ghVw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eLYQrXl2qRZeseEi/Fob4odi6XMPTU1OxT3QbWi7olKuS49XEGqiUOS5b2OxgUb3R
	 r9wMACbdT5de8Rn/9jZR4m1u4bRG5xwJKlpYW6fYjCnPWT9Kei9K/7z8fLWrYh6ECr
	 XT0cSA+8mNYS7wb8c2hvh62Ddr/bznY+1ft0A+U2J4v3ojMXhjrS58yBYguBkyPhLO
	 NgzXytaYB3Rp51UfMXl458jWjRa1X02jazNOs9ivk5/hV/BVAnOSYAYJI6IM+kvwOH
	 SSUjX3P26qSRLfk5Eaz5q1ehJA8URBADO9uuqh0+E5n+YUMyLQ9ZmSf4bLxs0OGZO0
	 JfZ4tU8Ex12+g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y] mptcp: sockopt: fix getting freebind & transparent
Date: Sat, 19 Apr 2025 07:46:54 -0400
Message-Id: <20250418163742-0130cac3f98137c2@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250418083955.2844365-2-matttbe@kernel.org>
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
6.14.y | Present (different SHA1: 2a2500503200)
6.13.y | Present (different SHA1: b5e0598bcb6f)
6.12.y | Present (different SHA1: f54dbb16eb73)
6.6.y | Not found

Note: The patch differs from the upstream commit:
---
1:  e2f4ac7bab220 < -:  ------------- mptcp: sockopt: fix getting freebind & transparent
-:  ------------- > 1:  420102835862f Linux 6.1.134
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

