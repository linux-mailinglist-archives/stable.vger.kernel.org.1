Return-Path: <stable+bounces-96053-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B441A9E0649
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 16:07:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA19BB3D7F6
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 14:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB0AA204F66;
	Mon,  2 Dec 2024 14:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ECC5YJK7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC1D2040A8
	for <stable@vger.kernel.org>; Mon,  2 Dec 2024 14:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733149612; cv=none; b=VojCoQsytfNpOWguJmnsqiGZB/fqfe5Vf52aJJRe/JMPr/vHJAh/mVZ+fH8KayoAPiu8/Hzjq2zzdzk3AFwc7NI5nlH1/yA8+RAgIX3elJGZaubW7b7NlwZ3Z0TwON4swm7gdvvlvjvQBw95Lgk2RT2urN2eq3JDo0npWNErwgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733149612; c=relaxed/simple;
	bh=/Az+hhvtBqhlIbI6qoyG3vBI2JK04wplhHsjMA/yTYI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UB0aXlqdXgshDEldH1P39JMJ7cQFFkD3sFDZdoeg+pos6XkaBhItBywL0a7v55/4QzeiWkdVQKthad/E21mhLXc4NWRmhNtDiDnCKgR7cLp0MrttVaPbCOfyaMg3+h933qAThyTflkAaVRam1JgpnMff+/2ZOERVoSUFyIXcXOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ECC5YJK7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09D66C4CED1;
	Mon,  2 Dec 2024 14:26:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733149612;
	bh=/Az+hhvtBqhlIbI6qoyG3vBI2JK04wplhHsjMA/yTYI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ECC5YJK73ZNNL1awYeBCSmTpDDF24JpC5lvwwZRhvBIeloyQGBbc+eQMmwjz7z3R8
	 KLhHUMEGlyL0R8n2wTOy+dPwAZBO+Z9MqW/EUpMrNn4Eue9kFcnDauy+bpWJG9A6xt
	 6dTnv5Aijz80jEscazJPuiZInxmD3ku86qXrXKryEoBAeonu9rHY++DSsV1MwjbmK8
	 DQEfXNY+PJl/8KQG+nIPRDF1NPEInsdR78b0qzoe3Z3v3xhfL8/0XG45p6m+BfhJtB
	 SvPCy50img81YOatmLBsAiT/CEISF7c2aWrxtSNsdyaAuTWBc+gQm6S12v7ULiFMfB
	 +9GEkxV201pcA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.12 3/3] net: fec: make PPS channel configurable
Date: Mon,  2 Dec 2024 09:26:50 -0500
Message-ID: <20241202080333-0a4368a970077a25@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241202110000.3454508-4-csokas.bence@prolan.hu>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

Found matching upstream commit: 566c2d83887f0570056833102adc5b88e681b0c7

WARNING: Author mismatch between patch and found commit:
Backport author: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>
Commit author: Francesco Dolcini <francesco.dolcini@toradex.com>


Status in newer kernel trees:
6.12.y | Not found

Note: The patch differs from the upstream commit:
---
Failed to apply patch cleanly, falling back to interdiff...
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.12.y       |  Success    |  Success   |

