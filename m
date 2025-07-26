Return-Path: <stable+bounces-164805-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 59B40B127FA
	for <lists+stable@lfdr.de>; Sat, 26 Jul 2025 02:25:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F2F91CC3827
	for <lists+stable@lfdr.de>; Sat, 26 Jul 2025 00:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E704939FF3;
	Sat, 26 Jul 2025 00:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cJcxR+jY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A64D23594C
	for <stable@vger.kernel.org>; Sat, 26 Jul 2025 00:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753489503; cv=none; b=IZmShjVYkj8SPox8f6kRUtSR/dG4/CYGP4SJdLkMJ2x3jzcOgQ2X4jBqTDHvo29hcUCoFieKAolLXfREFwhm0/FkMXXSXFKukxs1TaRMywzfid7AIuLuX9Y4qx24m5n4Hmo07FOBPt/pYmWGSGf2a9vINtOgUWg5731EgkzWZG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753489503; c=relaxed/simple;
	bh=czlpb0YQXPMDd1mGj6pu+Xp7WYJdjFgUlcxaw2+uPwE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GqJWB2DAtzLKTq6O9/5FPNjmGi84K1tvJxNu2Dgx3dgO7MrirVv8mHV1L8EHEXxvsuojOKWF7FgtY4ml2IYFWp87EljOyNmJsQrh68QdBF0vPik+f2E5lYGyoxyqViyyRnByHif+ZGfhA0mlFDySezk/1oF4J9FHCvJxjb6HLm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cJcxR+jY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4294C4CEE7;
	Sat, 26 Jul 2025 00:25:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753489503;
	bh=czlpb0YQXPMDd1mGj6pu+Xp7WYJdjFgUlcxaw2+uPwE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cJcxR+jYQy2BSxR/dBrdaKcB2lJ6Fhff/jEUQIdD34RXT5UjdGXsUpuzo9qpLANqC
	 Lef3Q2l5MqWrIXlDySxMTyF2cieMUPD3eaGagLf6P4OxmGoRtxYdAtJ3cOsmCuNU4M
	 MmDf52Liopn7Lte6h6Mt8mogKUrRDS2zLBnIHRo/sxRoMhe0xzdzQGOQxlf4ZAhAvR
	 Af9TJHfxss3lPh9+C92W5fMIZ0TWGagAI5e5Sxr90/cPPC1abaqWUUqypQZW0E/XZN
	 Eks7OkqBFIQy4PMtwkz3CTN6PoK1J0aTkXVb5WZQrhn9psMU2LNaixImRdXJ/TV+Y9
	 TS5RhqGQxogxA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.4.y 7/8] net/sched: act_mirred: better wording on protection against excessive stack growth
Date: Fri, 25 Jul 2025 20:25:00 -0400
Message-Id: <1753464062-3c61abde@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250724192619.217203-8-skulkarni@mvista.com>
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

The upstream commit SHA1 provided is correct: 78dcdffe0418ac8f3f057f26fe71ccf4d8ed851f

WARNING: Author mismatch between patch and upstream commit:
Backport author: <skulkarni@mvista.com>
Commit author: Davide Caratti <dcaratti@redhat.com>

Status in newer kernel trees:
6.15.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (exact SHA1)
6.1.y | Present (different SHA1: e0c12b9bfffc)
5.15.y | Present (different SHA1: 5b347652aebd)
5.10.y | Present (different SHA1: f5bf8e3ca13e)

Note: Could not generate a diff with upstream commit:
---
Note: Could not generate diff - patch failed to apply for comparison
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| 5.4                       | Success     | Success    |

