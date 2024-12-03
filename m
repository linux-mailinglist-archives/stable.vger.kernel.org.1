Return-Path: <stable+bounces-98151-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36E2F9E2A80
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 19:13:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1813284E67
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 18:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3457B1FC7EC;
	Tue,  3 Dec 2024 18:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GN9peWlo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E65441F8EE3
	for <stable@vger.kernel.org>; Tue,  3 Dec 2024 18:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733249603; cv=none; b=LJ1WwUh6yntm2k22IavTCV2jRygxTxwZKdrnwOrl4mPR2XH/uHE8PBTIg19WEZxmnxa5yFhGUPs9eYK9joTipKTxxBOIqf0bQ1BZw3R2BIe3sY7QtUhww2zU9SOi7LxSBLXr5adp9QJWFSg2bOsQcASLNRiRpK7CXu5C03JPVLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733249603; c=relaxed/simple;
	bh=qyGiwptkESZqOcrcdSsgb0wWefGfSB8D+7FW+S/t/Jg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iuBD8URimFw7J08iH8NjnVIVPuMf/1Rw1AKJBD6vtx+r0+H/y6TzgcJpnDAME5CuJYu2u7af7YwvPmASX7ewyrOvmr9pP60R1/wCsueDvgO1tmHwKAC/wI/H04F4kHQDX7AqwmyWWhGFhu6sS79lmaQYAoOPZtLzvMROBxSg/ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GN9peWlo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C58AC4CECF;
	Tue,  3 Dec 2024 18:13:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733249602;
	bh=qyGiwptkESZqOcrcdSsgb0wWefGfSB8D+7FW+S/t/Jg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GN9peWloTqDtidCu7sYeeBR1+pFgOJvBWshS40jPLTBsA0+yP9lxg2RutoN4usQYL
	 stpz2O5QTb0TYfpOM0HIWjlXcAABsC1kdWwUJMTrUG+mv4OkF+GBKrIH1aot0weYEw
	 FUy2eRxNcHeUyb40LAuKEx7gA9sza77vlHYEde6paPc7zLiiq6ck+Z5OH7Z7MBh4bf
	 ZCpkiLvz/wsebDrmnc6bxHxKL5eO0A68p7pJ7mZ/ABeifpXVFMWxgl8keuL4ewu5GX
	 blmZxR+OEhxksuMlWlO7ldGCvApms8QgV+8sL5/2LD/rKg7gf5IXDDqvqPx3F4UU17
	 0++PHafuDOOow==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.12 v3 2/3] net: fec: refactor PPS channel configuration
Date: Tue,  3 Dec 2024 13:13:20 -0500
Message-ID: <20241202130945-a900ad2d7ca76def@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241202155800.3564611-3-csokas.bence@prolan.hu>
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

Found matching upstream commit: bf8ca67e21671e7a56e31da45360480b28f185f1

WARNING: Author mismatch between patch and found commit:
Backport author: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>
Commit author: Francesco Dolcini <francesco.dolcini@toradex.com>


Status in newer kernel trees:
6.12.y | Not found

Note: The patch differs from the upstream commit:
---
1:  bf8ca67e21671 ! 1:  e7045250bbe8e net: fec: refactor PPS channel configuration
    @@ Commit message
         Reviewed-by: Csókás, Bence <csokas.bence@prolan.hu>
         Signed-off-by: Paolo Abeni <pabeni@redhat.com>
     
    +    (cherry picked from commit bf8ca67e21671e7a56e31da45360480b28f185f1)
    +
      ## drivers/net/ethernet/freescale/fec_ptp.c ##
     @@
      #define FEC_CC_MULT	(1 << 31)
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.12.y       |  Success    |  Success   |

