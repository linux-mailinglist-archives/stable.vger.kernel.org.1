Return-Path: <stable+bounces-135178-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4615A97549
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 21:17:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81BDA3B5ABB
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 19:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F79B29899A;
	Tue, 22 Apr 2025 19:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YQEoaUl+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E43192980B0
	for <stable@vger.kernel.org>; Tue, 22 Apr 2025 19:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745349471; cv=none; b=pgCM8UhcA6OUeSrV539/XE8V7J0lxrX5HGfgTLEUWSOQROaer0dawA88293d+GMngPkb6GAJ81V0CkDhYVaukB8qbsB/T+qIGWuWu2ctiG49vxteQCX9F3XjaoV3wm3J+LWCbGTJXX8JnKg4tl4vUMmMD6Am+N3xsFVBjQp5X3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745349471; c=relaxed/simple;
	bh=O0ana3I5eenUmVcs8z6/ufJpxotZnbbpbvDZMNr5t+k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SWyqMEy5O3GiSi9Ekwe1N4JP0QsKprGfSSdGjSzOGtN/wNMwdxAdP5JJxYXvhTGoABOt9Q32UR0lCAUeqQiXwpmiRntpD+MITX+lvOcmKpJq2pwpiNxnUCggVp+OtItnGKZK5RssmyPHryLgdYzaWaSBm75nl4ZxahC7/C1CXOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YQEoaUl+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8183C4CEEB;
	Tue, 22 Apr 2025 19:17:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745349470;
	bh=O0ana3I5eenUmVcs8z6/ufJpxotZnbbpbvDZMNr5t+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YQEoaUl+w80H+KFoxH/X+q6/x4cp7k8qsYKjABBLZmWkKPwAGGidW7IdwAynVlyoA
	 oi4TwP3qATLGdlwawUPEC4Vg7ITeDtmymmlCu2LevYp1ao0nbk1/kYdMFD3xjNYw4J
	 4hxo0XnskB6d7omSqTgyLHvAg08YKo4sfU0fejX6M7sp58PX8kaoYL/tIw+CHcveqX
	 +TqruCa95cNFWmNqn+d+NnuvcBLp54igZwZbaO0OeZ9Ao/NKrpt+zT+8MGFAwIG97y
	 fOxa2JNoWkWczRlxvyAiGWuv6DE01rrlgLDIWIBfOebBQc5AxiXZ2OnWc3OrOjeO0D
	 KDhJQDzvMHiZg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: WangYuli <wangyuli@uniontech.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.12/6.14] nvmet-fc: Remove unused functions
Date: Tue, 22 Apr 2025 15:17:45 -0400
Message-Id: <20250422122445-17c378ce0639b111@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <56AA32057D5B8285+20250422083431.96652-1-wangyuli@uniontech.com>
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

The upstream commit SHA1 provided is correct: 1b304c006b0fb4f0517a8c4ba8c46e88f48a069c

Status in newer kernel trees:
6.14.y | Not found

Note: The patch differs from the upstream commit:
---
1:  1b304c006b0fb ! 1:  22cedca066da0 nvmet-fc: Remove unused functions
    @@ Metadata
      ## Commit message ##
         nvmet-fc: Remove unused functions
     
    +    [ Upstream commit 1b304c006b0fb4f0517a8c4ba8c46e88f48a069c ]
    +
         The functions nvmet_fc_iodnum() and nvmet_fc_fodnum() are currently
         unutilized.
     
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.12.y       |  Success    |  Success   |
| stable/linux-6.14.y       |  Success    |  Success   |

