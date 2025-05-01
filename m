Return-Path: <stable+bounces-139365-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 23EDEAA637D
	for <lists+stable@lfdr.de>; Thu,  1 May 2025 21:09:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D05691BA704E
	for <lists+stable@lfdr.de>; Thu,  1 May 2025 19:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2836F224AE1;
	Thu,  1 May 2025 19:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rFrvcDBr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD5CA215191
	for <stable@vger.kernel.org>; Thu,  1 May 2025 19:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746126578; cv=none; b=t63Hq2C9X/7x1Ff9NFlb+wcpAhiSQ7oTOeIRGrCjo0kAitOW4BC/b+nO3r56bYMOBPgoFCz8sCI2sLI7eD0wyNqKGf+xIGyhrO7Yf3n3jSGb76Zs6IsVZyJbYw6e5MXXhoQjBdrC1l4oQmw8gVm4VaJBCX4u4Bn7BXQF+F2NJV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746126578; c=relaxed/simple;
	bh=0HDvXsquJe35RxC/4exG6QdLKMdNUeFZF5pNc1hetFI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tT+CA4lSvmXq0y4uqU+Tpuj133Ym0sGg5jdEIJNGbqlNNopI5rqhtVKyYlkVnAlCacImc9QCcdA1+E9I1+1o2T4Q5+2O6I1X/GmSV3Z2uRegY01rw42idijftHkGGmiFpxiEgj8fkFPZxcW5aX0lnqeo2nFWlFJzfjdhcEAKfxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rFrvcDBr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8532FC4CEE3;
	Thu,  1 May 2025 19:09:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746126578;
	bh=0HDvXsquJe35RxC/4exG6QdLKMdNUeFZF5pNc1hetFI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rFrvcDBrZlWlFYGanoSIUip48Vl6bqspADaMXZ521vTKi19tggJFWrC++13r8qmSt
	 KYm7W2zyAbRwHPfXb5QmZUSRh618mKDsb+fFmiAnfmnis4tEABU2F+pLcFmgHrd77y
	 I6CL8gaM/tS5280DKdhebQybxBHNThpmp75LJs7IMrPdWW0Xv3GyxuCi1CzG0vRF2z
	 Y6pDUnsNdJHzHxGT7iPkAOvXKtdzQxOCh2z5qU14xYS0nV3HueZREuj5om6aroDwVN
	 Fm5BGJsUREX4rGCEuhdPz6b9S7W55tVMfxDcj/PCgcvpEtjB0vJGT+EmNUYKOgBjoj
	 vwPfcYjK6ukmQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	namcao@linutronix.de
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH stable v6.6] riscv: kprobes: Fix wrong lengths passed to patch_text_nosync()
Date: Thu,  1 May 2025 15:09:33 -0400
Message-Id: <20250501083458-7961f068cb7501ba@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250429161418.838564-1-namcao@linutronix.de>
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
| stable/linux-6.6.y        |  Success    |  Success   |

