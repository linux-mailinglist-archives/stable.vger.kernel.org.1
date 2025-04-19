Return-Path: <stable+bounces-134696-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 602F6A94340
	for <lists+stable@lfdr.de>; Sat, 19 Apr 2025 13:50:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EBA3189A60C
	for <lists+stable@lfdr.de>; Sat, 19 Apr 2025 11:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD4EA1D63D8;
	Sat, 19 Apr 2025 11:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WihWO0oy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D7F31A254C
	for <stable@vger.kernel.org>; Sat, 19 Apr 2025 11:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745063426; cv=none; b=GbEkVoOC0mCTRhzZ+Y8KBS96Oo36J9166GkEQq0YjVg3PTLHdijhc8jz5pS5J+8MUPS2LPVhom1u9E2L56InqH/FMuYIed5M9o9JSXgsIwppPUnUbL/HhSVuRXpKzrgBjOf/ukJKP38IAR6yxDP3/alGeJKJGthGgLpT5j5z3bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745063426; c=relaxed/simple;
	bh=/eIKpeYO4feyy32caLaGgcPiz4XIhouMl23Wr5/MRN0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VAeTx8HTCTlS2yzhQBu46L6R0pzJWowVErHs2mhs/1Kp4csJPtfU8BnUu6YuT6CWB/mIOeRRLGTJieElJ6LYyvLfQaMSAbFLJuMOAj9p5YvmSCKF4d9HAZpkcfG3z5K3BogFeiHvQ8lkXWwPuKX59A958tvIXnQ21IXxFiN4aiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WihWO0oy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4132EC4CEE7;
	Sat, 19 Apr 2025 11:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745063426;
	bh=/eIKpeYO4feyy32caLaGgcPiz4XIhouMl23Wr5/MRN0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WihWO0oyGkn3MEOeRbvBKvb249Am35tQ2GW9SZ3u+ZZRob0B+J15xVNSp1KZ367mL
	 EEOdSfsCDq4Or9m6ELm9BNzekxJ4zYn7EjrN+cN/PHTnduWDpon55i8PnNBdW9RrPt
	 Z34r2GOUwjI33xRXy2PVUI+pVUXuZYdMJj8Bd5oCJJAt5Tq0o0Xnk5ll1sPqUxE2UC
	 6s5TJejd43/J5E/cwkXQUYQMR2ueC0L+4AdXznloXtW/spoEJDc2BjOpc71T6Fvugd
	 D0GrUGzy149mPUcrNZWNEKgBDfHW1w5y4DP/D0d/0DaVjFaXd1u7xpmbGZgCXGzx3x
	 k74xZB+e6N1sQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	hayashi.kunihiko@socionext.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y] misc: pci_endpoint_test: Fix 'irq_type' to convey the correct type
Date: Sat, 19 Apr 2025 07:50:24 -0400
Message-Id: <20250418195205-99b00abaac32a3a8@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250418124443.2046080-1-hayashi.kunihiko@socionext.com>
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

Note: The patch differs from the upstream commit:
---
1:  baaef0a274cfb < -:  ------------- misc: pci_endpoint_test: Fix 'irq_type' to convey the correct type
-:  ------------- > 1:  319e40852ec27 misc: pci_endpoint_test: Fix 'irq_type' to convey the correct type
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

