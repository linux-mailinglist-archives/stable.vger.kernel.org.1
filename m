Return-Path: <stable+bounces-164375-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3674B0E9A0
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 06:34:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C74741C855FC
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 04:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 291142AE72;
	Wed, 23 Jul 2025 04:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="twxAiX1I"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8395464E
	for <stable@vger.kernel.org>; Wed, 23 Jul 2025 04:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753245243; cv=none; b=VxzbxI2odty2znz1cGdsgafaIMe0vUTauS/scvspWEYcTXR7xsxWD+BTjjJikoy/Zf3Nq5kOe6vN1TUAEC2w/BDltDzz20SEK7POGeLr5X0QEQNVSEjReLx4q0/r3eoIfwrQckm8bofmX8hUbReteNgvI1JnoXBKslVTto82EuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753245243; c=relaxed/simple;
	bh=wVO1No3p+diKunIpowHFsAFEcELZ0DWdCRiYqcIKRrQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u217hivpgO+MqztQiWbs1yK4HBSbodycq1xWfB0H8mA56h1uBs4LqKeBsMwJawfIq5LFvL3ijQ/xC8icQENw+7xy+VZZDIqgO3WsYdzUq87a4k6fMTcsCJbefgVnAg+cc0GYAY6cDJFO5l+PJ/LVfQR+PIKAp1Si9Rip0tCS1vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=twxAiX1I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33500C4CEE7;
	Wed, 23 Jul 2025 04:34:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753245243;
	bh=wVO1No3p+diKunIpowHFsAFEcELZ0DWdCRiYqcIKRrQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=twxAiX1ITFvsRcJpa5hNbdxlX7oxgOg1MOVdwVMM1lTmAiTGM4XhfhWi3alW0YMrI
	 oWqU/4fmO0SVP0QnhRPMZk0GR40TTWGadSXq+pqSYo9Io637YDJceuwGqBJrTA3Lx7
	 /Ez+tcDPXFrMhB09msVMULzVo63hjofxFCQrMPDESSuXyj3EPmQIEOxE3ZXS7R6oXS
	 Jh2WOwR+LO2HZ/Px8nPym6gtBnobvIz6QHN4G0vNgPK18PRth0o/LVQJ30n8uRwKvo
	 yADY6gVsoCiLpkx9bUnwZ3eWr8qNC9l88FvDU5wtdRHyRi91m75uFSVSNGIjYHE1OA
	 WxXuYGV0wsnag==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y 1/5] erofs: get rid of debug_one_dentry()
Date: Wed, 23 Jul 2025 00:34:01 -0400
Message-Id: <1753229082-9d9e16cd@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250722100029.3052177-2-hsiangkao@linux.alibaba.com>
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

The upstream commit SHA1 provided is correct: e324eaa9790614577c93e819651e0a83963dac79

Status in newer kernel trees:
6.15.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (exact SHA1)

Note: The patch differs from the upstream commit:
---
1:  e324eaa97906 ! 1:  b7f6cd7d3810 erofs: get rid of debug_one_dentry()
    @@ Metadata
      ## Commit message ##
         erofs: get rid of debug_one_dentry()
     
    +    commit e324eaa9790614577c93e819651e0a83963dac79 upstream.
    +
         Since erofsdump is available, no need to keep this debugging
         functionality at all.
     

---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| 6.1                       | Success     | Success    |

