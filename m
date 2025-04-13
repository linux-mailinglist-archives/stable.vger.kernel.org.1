Return-Path: <stable+bounces-132341-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 904FEA872A6
	for <lists+stable@lfdr.de>; Sun, 13 Apr 2025 18:46:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 436503B73CA
	for <lists+stable@lfdr.de>; Sun, 13 Apr 2025 16:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38EC91D7E37;
	Sun, 13 Apr 2025 16:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UjTS7NDc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC40A14A0A8
	for <stable@vger.kernel.org>; Sun, 13 Apr 2025 16:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744562801; cv=none; b=pEjarJkqR6cc3raloj4OEhtNC4/O4AAWp+5YBijVSjeAuvdcmaERac65+Spg8h+6RXNPKKxPo9grIvghFcDr9iJN0b0lS1I+3Eb9wdQ0BIHPGwg8lTsPSIi4BS7rxFTg2zMb54lJHBYx5MJFoNRKSF4gWH+Z1INPJ7SeeAL36CI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744562801; c=relaxed/simple;
	bh=8gF4xNhhknuqn+cfgFlLMNFDRV4Ig8Shrt+esN0WkC4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P7mBu11PvKmlZnQtUIlCo/undrsEG86UDUyl0wyatRE7xf0gNQ1R7i/mzhSDDJaZ1OzkuzdM7GN/9RHZ0KSSdYuU1KgTzPd7TyUg+xPxwEG97WdG3ipTnnkJ+1c3jH+b2BrxedbgzS1vbSuNgBygs3VzmN1CwFNDvactuy/HROU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UjTS7NDc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDBAAC4CEDD;
	Sun, 13 Apr 2025 16:46:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744562800;
	bh=8gF4xNhhknuqn+cfgFlLMNFDRV4Ig8Shrt+esN0WkC4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UjTS7NDcjwkg1XiMIA33nU/jejNFWjZ1w3jFuiFo0X/CeOgALS2afxWDPNakLRxrU
	 djhuXw0xVOSkpaQDKyDQ8qltYQ1ZmEgPigs67RXjLMZBLnosuEznH5ugx2OAtjM4Yx
	 wO1EJ3neEyEuY5Glo1BWiVuZix14t2V94x6GfQ9d/dFf1qLgIxMC3gFN2W9k2q4WjH
	 NUHicVc5JHDyMms4EImV9/4l/EMmeDLKyrRa1BWzTRaK0bAi2HI7aWRfg5FbWD2Kz3
	 15/BWfbWOV8hUXH/aoMfXupOHqejuCzyknN/pUkQnbo+QR7DbvgdyrGHJ3DWOfwD2J
	 m/H0ldVL62MSQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jason Andryuk <jason.andryuk@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 2/2] x86/xen: fix memblock_reserve() usage on PVH
Date: Sun, 13 Apr 2025 12:46:38 -0400
Message-Id: <20250412122848-be3e29878eb8d8d4@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250411165122.18587-3-jason.andryuk@amd.com>
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

The upstream commit SHA1 provided is correct: 4c006734898a113a64a528027274a571b04af95a

WARNING: Author mismatch between patch and upstream commit:
Backport author: Jason Andryuk<jason.andryuk@amd.com>
Commit author: Roger Pau Monne<roger.pau@citrix.com>

Note: The patch differs from the upstream commit:
---
1:  4c006734898a1 < -:  ------------- x86/xen: fix memblock_reserve() usage on PVH
-:  ------------- > 1:  9bc5c94e278f7 Linux 6.14.2
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.4.y        |  Success    |  Success   |

