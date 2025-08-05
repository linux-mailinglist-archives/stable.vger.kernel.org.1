Return-Path: <stable+bounces-166518-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A205B1ABE4
	for <lists+stable@lfdr.de>; Tue,  5 Aug 2025 03:06:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BECFA18A1E0B
	for <lists+stable@lfdr.de>; Tue,  5 Aug 2025 01:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7D2114E2E2;
	Tue,  5 Aug 2025 01:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g/QBtSIo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 975791459F7
	for <stable@vger.kernel.org>; Tue,  5 Aug 2025 01:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754356007; cv=none; b=CjcYAQI5pVTTElSsl90XsRlDuatroA8LFeV9pSmDF+ejUeCzX1I8+PGbKPvvZqr2EmU2RLJ7QhA3E5kmjXxowQf7+DGixK6rpToHePpDt4b4ZKhuYF4+1+iW28WRm0SMpn26sTrvvSrC6ilUxXPmWCuxde8z0XONbiNPE560vAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754356007; c=relaxed/simple;
	bh=Eb1peYBm7Jwz6aErsIvkqNFI3iLhhb6lyWZxMgfdh3k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m+0hzFE0Lo4TRwdqnm1Qh9YWmTOFnopHDEOePaELw39+bGcJQz/dbCrbMZNWZ3gnM8OsuTSI+U1JxtmcI4jzt86kA30n+pByDWOloGX3v0gOnclTeaV5SAl4EhFu0hi7Mci8vI2ytPyU0BvwRcNLCiPp5Lh7tcyA5j4DAWsZysw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g/QBtSIo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 965E5C4CEF0;
	Tue,  5 Aug 2025 01:06:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754356007;
	bh=Eb1peYBm7Jwz6aErsIvkqNFI3iLhhb6lyWZxMgfdh3k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g/QBtSIoW5+6rnhj43ZjkVA0P13HW/n/mvsmNZyS08BAMuMXgbh+ukkNv5g9PHFxo
	 IouIF0BoXjYImhv34mIDOEu/V/gCDHVblpFof2hhD3TTyqaZy+hEec7Hd0vpXnEuWz
	 l2WFByZD9NnvhoRGoKzUUiRa+siwvHX56dx0h9xDIhd/5XvdWR1a2I1kYfZhkKw3pb
	 a7wmaOEdzpOxlvY616bCPqeGMc9S2EYxMHyTb6GDWDyzORYqXqQ5vJ3BOb1YTVhzHx
	 phkeTsdXf58De4k20iji40ewe1CRVrTDn8Y+3uRaWaYp/DZmevtgtWMufMWRo/lUnJ
	 ialwjlKxgr9CQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.12 4/6] drm/i915/ddi: gracefully handle errors from intel_ddi_init_hdmi_connector()
Date: Mon,  4 Aug 2025 21:06:44 -0400
Message-Id: <1754321587-4b1c432b@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <d064859cde86c25f3be1b9b09d274b0082ca337a.1754302552.git.senozhatsky@chromium.org>
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

The upstream commit SHA1 provided is correct: 8ea07e294ea2d046e16fa98e37007edcd4b9525d

WARNING: Author mismatch between patch and upstream commit:
Backport author: Sergey Senozhatsky <senozhatsky@chromium.org>
Commit author: Jani Nikula <jani.nikula@intel.com>

Status in newer kernel trees:
6.15.y | Present (exact SHA1)

Note: Could not generate a diff with upstream commit:
---
Note: Could not generate diff - patch failed to apply for comparison
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| 6.12                      | Success     | Success    |

