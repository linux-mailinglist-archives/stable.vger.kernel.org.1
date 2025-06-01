Return-Path: <stable+bounces-148361-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75EA4AC9E3E
	for <lists+stable@lfdr.de>; Sun,  1 Jun 2025 11:37:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DAD3177564
	for <lists+stable@lfdr.de>; Sun,  1 Jun 2025 09:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7B3F1A3160;
	Sun,  1 Jun 2025 09:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r58eZcZ0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875AF1A2547
	for <stable@vger.kernel.org>; Sun,  1 Jun 2025 09:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748770638; cv=none; b=KsRlpw13hY9nKUE7DER8SReJwfGFN165gz6QuEUIFfa2DtNyqXSv8IIWs4fTo/kg2zgnpubv3mf++tYswbn0Q7FdzgGxWQgtC9OeWoUo0M0md3QiV3Y8jo7rShcjewMzkFNxqrdTVztxGwvpGn1cHjz8XMat/RpBvSgVH9JJxKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748770638; c=relaxed/simple;
	bh=z7JeVj6sVv6OUcBIOL+N7sL67T/GTcIjF7ZndPaAOEU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JpWCTMHKsjkVBVAGm0cQ445KSzHgNkjdlZM1j5R21UqvGqkHs8LbsDhm6PCg/uVmCtmEGGWy8ashcziR6TnywGtRgPpbtdA/tjXfkp866nmgoH4EJHaVYOP1Zio0S8FYoTtWY9TXfXhEcZwosusGG7P8y8PVzHP2Zjii6pG+iso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r58eZcZ0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84812C4CEE7;
	Sun,  1 Jun 2025 09:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748770637;
	bh=z7JeVj6sVv6OUcBIOL+N7sL67T/GTcIjF7ZndPaAOEU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=r58eZcZ0dMaXdXIoGG05z0e8psSgCvFefDNTnGcM26D0rIsgbLUEf30YXfUjqoCbT
	 /7RGTzOzppxVBXWFgP34zKmt5US5cbP65OnjJ4pLEZZ1TGyQkn97LgUMpf6LCCUlYH
	 6WroJl8YXwYCOw8I4odLX08cRg5DCHOEAzSvDSQmyrd84Y64NhmgDg2PTek2Ort81q
	 doBp0++44ARbleLWmuXpydrau04hcwVD4s+hf9LwkUB1TqOUoe6hjRowP/lx2YUYcW
	 tiZ1qx+lTZUQvAI/3Iv4E59PvIGAiJ9xQSIALPnsxjoh8U1ITFqMeUs1s0R9Enzzyl
	 AZidVIPlPqGDg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	pawan.kumar.gupta@linux.intel.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15] x86/its: Fix undefined reference to cpu_wants_rethunk_at()
Date: Sun,  1 Jun 2025 05:37:15 -0400
Message-Id: <20250531221210-2929c98a88ef36cb@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <8c84125f71aec2fd81adf423dbc12156ac11706a.1748584726.git.pawan.kumar.gupta@linux.intel.com>
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
| stable/linux-5.15.y       |  Success    |  Success   |

