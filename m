Return-Path: <stable+bounces-145985-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D88EAC0226
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 04:06:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D28031B67939
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 02:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FDE27083C;
	Thu, 22 May 2025 02:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GnNbIobU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F35561758B
	for <stable@vger.kernel.org>; Thu, 22 May 2025 02:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747879566; cv=none; b=kYC/5FgDO0QY3lVx2lU9h1Q8TsLDgBiiXq1JHaozU1uDDnWCqnmCU2xvu/HaGe7wNamSsXsfNiJ/wuEHNOaa1vVbOO7FlJ6opWVDsup/tj7N7JZJOkbNYXcsoDFAMls+ooiic8Vr+/Z93YSac7/OoDTaGv5Nq9uIUOHB5IBKGWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747879566; c=relaxed/simple;
	bh=efrnb1nxwpPmIgOOv1o9mbkDvgryWXQrOvs2XoTa0os=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ix0eNIg5GD4QZokwqeHr4ZnaVgFXJnO2/qStkGuaWiPcrrteIViYxKSEVCCzduZX0TpaC0MdUY8jVKK4AZxgElgy7aTZ4zdUW9PaQwgQ2ps3nutt80a+VbanO/BJ0Kzk3kbdLWZIhKMihMX9eSdVXgwrxEoLxZxfQG6JCBU4FjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GnNbIobU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E052C4CEE4;
	Thu, 22 May 2025 02:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747879565;
	bh=efrnb1nxwpPmIgOOv1o9mbkDvgryWXQrOvs2XoTa0os=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GnNbIobU/RKz5scQ1Z2F0xtGE0i+EgJVnmTAJCfGZZRBtimZRcR37q55A7g9fw2zz
	 OUnjc8Hm06y13l6yqCtsS4F+xqZmT7HananYVw6s2h2sckBamvEJ7sr0B0eeEL7YEU
	 4JcITOPBgQDEa7eoVxIqb3fIS77JKnDlGnc4F5RRxM7xZb5a2/BHS+YqbSdeWR4CS8
	 DutcosWebXaEdHVYx4tsXMAcFKdjjyUGLr4OhGCho0w+8Zw/UQkaT3cQz3Z29v5Nn6
	 6OO6EpuduEs/1o7GtwK7PdB/YDLA7cXBaZKO2xKCm2XP3DLIJCvDAtLHO3RUfD6hgt
	 AaQNEsfZltOQA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH v6.6 08/26] af_unix: Allocate struct unix_edge for each inflight AF_UNIX fd.
Date: Wed, 21 May 2025 22:06:02 -0400
Message-Id: <20250521171255-ae0bc444926f2d81@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250521144803.2050504-9-lee@kernel.org>
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

The upstream commit SHA1 provided is correct: 29b64e354029cfcf1eea4d91b146c7b769305930

WARNING: Author mismatch between patch and upstream commit:
Backport author: Lee Jones<lee@kernel.org>
Commit author: Kuniyuki Iwashima<kuniyu@amazon.com>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)

Note: The patch differs from the upstream commit:
---
1:  29b64e354029c < -:  ------------- af_unix: Allocate struct unix_edge for each inflight AF_UNIX fd.
-:  ------------- > 1:  615b9e10e3377 Linux 6.6.91
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.12.y       |  Success    |  Success   |

