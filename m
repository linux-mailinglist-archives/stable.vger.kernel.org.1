Return-Path: <stable+bounces-139360-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55AECAA632D
	for <lists+stable@lfdr.de>; Thu,  1 May 2025 20:52:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAAD546823A
	for <lists+stable@lfdr.de>; Thu,  1 May 2025 18:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE99021FF52;
	Thu,  1 May 2025 18:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SsGnOqYB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F70B2153FB
	for <stable@vger.kernel.org>; Thu,  1 May 2025 18:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746125526; cv=none; b=rF6ZUFrbt4E8IgwsnWP/AEBSD7HC2fd/vBu8NNeq1bHpR39PCQqWvx0DeZ5keWPZEN/PNO6T6CHbZQ16XQb7miiGDNaFynMdxpbB//YMMwxb70Ohc7eVVnvO1Hl3+0gUON3Pp/VUUKbZYJ0sIkooSkftTb/XQmDYECmKqJdSu+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746125526; c=relaxed/simple;
	bh=XmZLzPc/BqjOqU4yyqz3l9RYXdLeMbmOLcy3nlYI5gE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Mfd5w8ZzDNa68VvQlYYR/OB9WSKKKLDSFLeoFEggeR/PDcshbyvjavPUhV0jCTrPJj9zZEQpSMpjd9GhKnHuuPzi80vnUYQ8XpyKJGUWCuyXEibVMUUHSXqpw6duSHOXwszhcKj4XsdXR2iZaVqeipYjusUbRbYbVEleWG4N2Wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SsGnOqYB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3120C4CEE3;
	Thu,  1 May 2025 18:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746125526;
	bh=XmZLzPc/BqjOqU4yyqz3l9RYXdLeMbmOLcy3nlYI5gE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SsGnOqYBV0v5hsh+2RrnvYPs64QjYyIK75nCqzDI0DKa4UffCZgmtEe35NgyHoNch
	 +JLnXqwyQculBB/ERIrGs8OsB05MRB1exaeS/5hF5Ams1lYKoEKW/KG/48ppso3wWD
	 RUNiKOOucwpUzTceORpPIrzIlPHkkFyLEThcINRKUyVbqwxnenAxOaUynC1kupjlNA
	 laKEtEMuv0g5NYL9tLneiJQ3VV/9ye8Ag+2yf/79b93RTAbV+m5E/QD4ZydAmHDhSo
	 kubjZyo24Dx6z3eq2F3iokUCrfJw3PR7v6HBshfEM62M6xCycbhN44PWKoOK/Y1f9i
	 DLLX6/K4YqMmw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH stable 6.6 09/10] bpf: fix null dereference when computing changes_pkt_data of prog w/o subprogs
Date: Thu,  1 May 2025 14:52:01 -0400
Message-Id: <20250501091715-6b807b421bbb9fd3@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250430081955.49927-10-shung-hsi.yu@suse.com>
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

The upstream commit SHA1 provided is correct: ac6542ad92759cda383ad62b4e4cbfc28136abc1

WARNING: Author mismatch between patch and upstream commit:
Backport author: Shung-Hsi Yu<shung-hsi.yu@suse.com>
Commit author: Eduard Zingerman<eddyz87@gmail.com>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.12.y | Present (different SHA1: f0946dcccb3d)

Note: The patch differs from the upstream commit:
---
1:  ac6542ad92759 < -:  ------------- bpf: fix null dereference when computing changes_pkt_data of prog w/o subprogs
-:  ------------- > 1:  23ec0b4057294 Linux 6.6.88
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.12.y       |  Success    |  Success   |

