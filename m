Return-Path: <stable+bounces-139713-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 18C26AA9711
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 17:14:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F8C6167245
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 15:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE6F625CC62;
	Mon,  5 May 2025 15:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ToyaE8Es"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF10E25C80A
	for <stable@vger.kernel.org>; Mon,  5 May 2025 15:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746458043; cv=none; b=Tl0CsNL5Mou6hTeRKRpdWGESKF4CdnNj9l9u6Leq1bjxRokokGDMwMYN7jqNBnLbxQNR4C0Z29qFFwsQPMwDlfBS0XztRll5Rlutb/m7GHtnx7FhAuVeMW+pUhHgBHhTyoavUYvzPD8uJ1VBLDRbVqJ5SC3+oOv4ftW90TcGRLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746458043; c=relaxed/simple;
	bh=F1R5fIBjLEVOw0K8LCtdzq/yHNqsYaFxWD59c+iBF44=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=afsbKohozlyxVo/JMS9TzQvDXQ10DVSTNGPTMtNiOs2zTXm9j2+PKAVK2f9tKgEfqIUsFLJSiBZULgGf9ONZeCkCa5bvbbtUEKvgCumr3OvbJP/tt10OYMPGcablU4IoEOjNVLJ1bPbnWcaMW8ksF9nEDimwjNJRZVZNPOuHnUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ToyaE8Es; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92439C4CEE4;
	Mon,  5 May 2025 15:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746458043;
	bh=F1R5fIBjLEVOw0K8LCtdzq/yHNqsYaFxWD59c+iBF44=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ToyaE8EsQnIPVYrzZ7vCfCPZWDUolw70YwH8WmlrvRotEsAMtJtsEZuyv1Jd1vNb+
	 q/9l4hYf9jKgM1I5KOqlQJpsQffQR+VnfNnvkec9XDwPQOvhqvMrQKOrbzpGjyGt3L
	 Sef4fsLpfpV3BZjP7zmtvkAV+G5YnaGolz+R6Y3qCFftWVqM8GRu14HbpURF1LXGPy
	 LHbXzLtK4KH2t8wp4UZLPN2UDgfnY3YloW8fouetMLxxZ02bvu+HYzTs70IQ3PgArf
	 W5HbcROcFF0Z7+YxhL5RRR1A0fqtAUjTZVvaN5kSjv0QoJgS6zMihT/X5ByKujlrg3
	 pFkzib8EhHbeQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	chenhuacai@loongson.cn
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH for 6.1.y] LoongArch: Fix build error due to backport
Date: Mon,  5 May 2025 11:13:58 -0400
Message-Id: <20250505075755-47b742a3d177ed05@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250504021054.783045-1-chenhuacai@loongson.cn>
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
| stable/linux-6.1.y        |  Success    |  Success   |

