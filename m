Return-Path: <stable+bounces-164378-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F9EDB0E9A3
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 06:34:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF89C5638C3
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 04:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BE33188CC9;
	Wed, 23 Jul 2025 04:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WuLCD52d"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD7FD2AE72
	for <stable@vger.kernel.org>; Wed, 23 Jul 2025 04:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753245252; cv=none; b=nVjZORljueeaZQl2LnK2O+CWnJ50j5fmpjJ/qq/GKdOzJF8PcxTw+u6V9BzEGZ06iuGl1AnsO9fru8ozvKQWp0EkxS0vJZfrUFSNTSjYti8GOX/3IPObrMpREhGDZJ13NeJNSTWOujgZOt/r8f+uurHZkOoAsqE89cD4foHcPLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753245252; c=relaxed/simple;
	bh=2oSKXyTjziw4ZZsZPy65532hVDpL1lJH+YjaDe1Ir7c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lgqgNbN0tdz9PR80SHV2q6yQzd0RjyMjbvseOspGe2HChhD2GxnLobDt6P1sm/Da80/rBMMguMZtfclay+9/+B6gjOb239vYsffjpQYA07lK/d5UbFFbm9v/hFHb6/Hol07/XErGWn9lz1i3T2GtvxkhvgyElkHVBRfHvreALhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WuLCD52d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4204C4CEE7;
	Wed, 23 Jul 2025 04:34:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753245252;
	bh=2oSKXyTjziw4ZZsZPy65532hVDpL1lJH+YjaDe1Ir7c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WuLCD52dU+fgG8gsf57aAoe7cXFZqpezYTXX0DfoSTHHPX/GwabcEfqDUUPnfgBFJ
	 DBGMbjkNwo1IT/NKEH28T6vIVvuG26b4pM9A1vickWyiadNqEFvAd1lb3g5kxrYKUz
	 fQ8NggBVy1mkz13EQgW6iNXdiVim18WcMCt9yZ3GfEcI3qHdILPpEcaVPvzJOccs2L
	 CtwoLwHdoAZC3R8+95pgPcuV7RnWY0N9a9X72oWorWoyGEXMYN6OVi0JKpBN+8DR+b
	 k4bRboXW0iObOEzsu/N0tK56VTlMkzHPj+vtD1gFH51hNpV+auMXTa4Hi1gC8OMFaR
	 MoRfv+bmM3HMw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y 4/5] erofs: simplify z_erofs_transform_plain()
Date: Wed, 23 Jul 2025 00:34:09 -0400
Message-Id: <1753229246-22eeac79@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250722100029.3052177-5-hsiangkao@linux.alibaba.com>
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

The upstream commit SHA1 provided is correct: c5539762f32e97c5e16215fa1336e32095b8b0fd

Status in newer kernel trees:
6.15.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (exact SHA1)

Note: The patch differs from the upstream commit:
---
1:  c5539762f32e ! 1:  a606c7746417 erofs: simplify z_erofs_transform_plain()
    @@ Metadata
      ## Commit message ##
         erofs: simplify z_erofs_transform_plain()
     
    +    commit c5539762f32e97c5e16215fa1336e32095b8b0fd upstream.
    +
         Use memcpy_to_page() instead of open-coding them.
     
         In addition, add a missing flush_dcache_page() even though almost all

---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| 6.1                       | Success     | Success    |

