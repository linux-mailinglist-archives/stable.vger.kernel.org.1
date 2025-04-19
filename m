Return-Path: <stable+bounces-134698-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AFD7DA94342
	for <lists+stable@lfdr.de>; Sat, 19 Apr 2025 13:50:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC74F3B05BF
	for <lists+stable@lfdr.de>; Sat, 19 Apr 2025 11:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9441240BF5;
	Sat, 19 Apr 2025 11:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D4GxeYr1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E0C1D5CE8
	for <stable@vger.kernel.org>; Sat, 19 Apr 2025 11:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745063430; cv=none; b=adM1ZVVyK3coyopBMBOgWVC1YyKlAzUMWoNLf5L05k/o6LzwiB6AlgMQCV6dWJ5r//FPO3GpQb7ovKkWuZZpl10P/UxCwK2O3ZgYUGbCOtqL7Rx4YomW0eTuWbpGP21AmU6Akb6YFYTarB0+4n6fpD61Qf3SPVsYH1qAku1YFy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745063430; c=relaxed/simple;
	bh=+iD9EAzNK/bT6ouZNcGgh9gD0qbOY4yHLxtrIVZ/k+o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ATl/oR+bjA7zahrIgeK7ML/nMC8SHmjcASkNd4eHu1A2z/7gmADWQg+KJkQImnZLFLMR/tStMsr6XS1T3wYa4VNDZUY6r7aaMqDd07EdCT60TTOpZIEWwslo8H/inPtJnX4Rxzcwlz3tQv9cemRZEHkxF9I4ACJ5+Ahqvb+H7O4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D4GxeYr1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2A5BC4CEE7;
	Sat, 19 Apr 2025 11:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745063430;
	bh=+iD9EAzNK/bT6ouZNcGgh9gD0qbOY4yHLxtrIVZ/k+o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D4GxeYr10nLYtplvzG1uN5gIx7Qr6MIWL0GpEyHhG6fDeuOZsEFrSP+dlPT37q/VY
	 F1N+SuCug2lvJy9JIUgtmM8borMxD3ZyLJGqojhellJZQaxv5Hepi21sD4g4a+7Ipa
	 GiWY1HptDiaO0ETyGBM1yiXVxTZAqw7D/82/VSufRISGE95YkqdjiHPY58BzD0Pfva
	 6vP6kSuCxwynXOrdcT2vFoqXwEMTHURCCqLGwDmxylVeO+Wof/R+TlDM6MaFmxiYQJ
	 +ngXvX3AtauL/AXearCIvvi0XCJGQFP2KvF6zNAli3AtvtqWS0gr2n8xgf5m/F/B18
	 wM+7JYdN54JLQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	hayashi.kunihiko@socionext.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.4.y] misc: pci_endpoint_test: Fix 'irq_type' to convey the correct type
Date: Sat, 19 Apr 2025 07:50:28 -0400
Message-Id: <20250418195531-145f711e80cda5c3@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250418124520.2046350-1-hayashi.kunihiko@socionext.com>
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
⚠️ Found matching upstream commit but patch is missing proper reference to it

Found matching upstream commit: baaef0a274cfb75f9b50eab3ef93205e604f662c

Status in newer kernel trees:
6.14.y | Present (different SHA1: 30ade0da493e)
6.13.y | Not found
6.12.y | Not found
6.6.y | Not found
6.1.y | Not found
5.15.y | Not found
5.10.y | Not found

Note: The patch differs from the upstream commit:
---
1:  baaef0a274cfb < -:  ------------- misc: pci_endpoint_test: Fix 'irq_type' to convey the correct type
-:  ------------- > 1:  ea14a425c0cf4 misc: pci_endpoint_test: Fix 'irq_type' to convey the correct type
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.4.y        |  Success    |  Success   |

