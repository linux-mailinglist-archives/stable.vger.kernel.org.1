Return-Path: <stable+bounces-161760-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C941B0310E
	for <lists+stable@lfdr.de>; Sun, 13 Jul 2025 15:06:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E4EA1893D6A
	for <lists+stable@lfdr.de>; Sun, 13 Jul 2025 13:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B57C219CD01;
	Sun, 13 Jul 2025 13:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tjMiU7CJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ADE26FC3
	for <stable@vger.kernel.org>; Sun, 13 Jul 2025 13:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752411963; cv=none; b=YfMTCtIh+qVtH3yPUhF9gej4lKyRsUQhOIrWZ0EGmU+TgBiVkKN9mC+vvzuM8uPzPyhrEHUC965I42GuVSjTtv6uFhFADtgkbaMptzrbgz6qGt+a8ZN2wPtNGNX5b5a2kj3C4mCeyu0N8/AqZ+TmQn3IqFi1U5TDcXFJ4zUrr0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752411963; c=relaxed/simple;
	bh=ofAjwtxJJ90hiXxaQO0TYvFGJ/CtVPmOp0RxlxCZStA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qo2KLVHiiTztIoGoehbQ1CGTEhRaVwD24R3xQT2Ue6X8hVFm+18jgEstCXkrzAXtHV3gZhwjvi95OE7bpW7hveKBFmshLiVYUlewYTtxRkV60hi72re3dXqSC4Rptfz0w8vwhT0kSSj7k4VogRXVv6CWPIVBOahdI9xD/0d7Fos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tjMiU7CJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BD8EC4CEE3;
	Sun, 13 Jul 2025 13:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752411962;
	bh=ofAjwtxJJ90hiXxaQO0TYvFGJ/CtVPmOp0RxlxCZStA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tjMiU7CJ5G6x/4akYxTLsJCzWwuOwwk5JnhS1HcWvVxXo2JncKgRxmAyb1IW/T3sK
	 BzOfivfS1/by6sEk2Chc2ZVVnjIBidapvSHKjMjIN5UyFH2gPFzLY9PMXlX+t0VLG9
	 IaJx1FQlKEctePq5FcA8W2dUl7NU7Ylyx0LO/nT8dvNGK0gX29f307txL8DxUxPyAM
	 46M9xJ+wOrdrh0twAaCJTpTNhAxwjryMmVUxcG3zNm+/82RF+weiWjgnR2/Fzb6xUx
	 +/3H40ej6njNvtvX7yaBGvtcrhFqGGsPD6nfdOFLcjzXXVTDdrG/OmQMaqgkRFkp6B
	 zqrY8d8pA2BGQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	bp@alien8.de
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.12-stable] x86/CPU/AMD: Properly check the TSA microcode
Date: Sun, 13 Jul 2025 09:05:57 -0400
Message-Id: <20250712202635-a16ae9be6fcbeec3@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250711191844.GIaHFjlJiQi_HxyyWG@fat_crate.local>
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
⚠️ Could not find matching upstream commit

No upstream commit was identified. Using temporary commit for testing.

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.12.y       |  Success    |  Success   |

