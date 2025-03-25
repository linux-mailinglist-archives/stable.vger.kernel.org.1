Return-Path: <stable+bounces-126022-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0063FA6F423
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 12:33:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D29701891CA5
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 11:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41B431EA7F5;
	Tue, 25 Mar 2025 11:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aMrCu1ZL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02916BA36
	for <stable@vger.kernel.org>; Tue, 25 Mar 2025 11:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742902425; cv=none; b=mJRURctTM9lYVmNhYwsXgSl6xR8rlXxS1idr/SZcmiRz99Il7a2S5m1j1dcOR09iA38zcCwXJM1qQeXOJt4VGFoZzCeXzXvrmPEMmgj2uBUOplJCtVOaZ+ehf2obJMYUEpCs0w1Km0I0neSwlsa25dSo8mSlU+EXn+ud/z2L8x4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742902425; c=relaxed/simple;
	bh=uprh4taSwrCav/RvTpuPhgXCwHIsU3rl0cTnIERE2Zg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HkPJvMVyaNqEqivT/ySFokFBns9CwrtO1UdjgMA2oiUzgxOSTx1qqodoGegqVaHjvn0dODVfmF99TtWlqUeXFPvgNhPdL5E5hZCh8u9yktwcmy2eplZxwhTLH5iVrz9gzJPEbAu6L9thCXp324cRDbNiSRzagq3q66AXupqqJJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aMrCu1ZL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DD24C4CEE4;
	Tue, 25 Mar 2025 11:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742902424;
	bh=uprh4taSwrCav/RvTpuPhgXCwHIsU3rl0cTnIERE2Zg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aMrCu1ZL9jgGIXoTSQFgKhc1g2N5qnKWdMmJYAqFF8uZOPkL0FUnlCHHtOd7j6XTX
	 Cy5AkBWqChf/dYxzyqveonpeuSqZNAtVb5AvxjU7FCimtx3+Uoelwt0E7tBrVk9930
	 9Ch6Es4M0sDYnfpyPGbocMlplnCQvSe6ttOOgYTbA5yInEKtcHYRCjfmVWcz41f5uF
	 0VUQ/rsS4f+HA9wvCIIdgwftKevgtkMX5s1hB5vfxqQ5UGgKg6FA6blPev7q81S09N
	 Ny/JvgSHer0DmR4mIoqKz7ul4hZFciaCioWfKGTjRMDcXo3JzD0lXmTXGveIXSGStj
	 U4HvPTdf3V0OA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: jianqi.ren.cn@windriver.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10.y] smb: client: fix potential UAF in cifs_debug_files_proc_show()
Date: Tue, 25 Mar 2025 07:33:43 -0400
Message-Id: <20250324212130-0402752e201f7d17@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250324071328.3796049-1-jianqi.ren.cn@windriver.com>
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

The upstream commit SHA1 provided is correct: ca545b7f0823f19db0f1148d59bc5e1a56634502

WARNING: Author mismatch between patch and upstream commit:
Backport author: <jianqi.ren.cn@windriver.com>
Commit author: Paulo Alcantara<pc@manguebit.com>

Status in newer kernel trees:
6.13.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: a65f2b56334b)
6.1.y | Present (different SHA1: 229042314602)
5.15.y | Present (different SHA1: 8f1f8fce89f6)

Note: The patch differs from the upstream commit:
---
1:  ca545b7f0823f < -:  ------------- smb: client: fix potential UAF in cifs_debug_files_proc_show()
-:  ------------- > 1:  7fe3ac5caef48 smb: client: fix potential UAF in cifs_debug_files_proc_show()
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.10.y       |  Success    |  Success   |

