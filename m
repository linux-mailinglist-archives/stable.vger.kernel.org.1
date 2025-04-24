Return-Path: <stable+bounces-136587-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 978A7A9AEED
	for <lists+stable@lfdr.de>; Thu, 24 Apr 2025 15:26:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3AD397AE011
	for <lists+stable@lfdr.de>; Thu, 24 Apr 2025 13:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F088B22A7FF;
	Thu, 24 Apr 2025 13:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tPUKRuxh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B23263B7A8
	for <stable@vger.kernel.org>; Thu, 24 Apr 2025 13:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745501168; cv=none; b=TYJ7BdNzlYeGGuO1NBx/6JkGJ0mI/dN2ss18ADG9q/NZhE6XHoqbillVck2YwJtITfi5WXDjJp7NtJ5LJP7Sgfu0IfU3l/K8P4Y5MnDxG43kxJWiJLvyM8lWoRS3ahhA99qt4dnU6sGQIZg8FSfbUdSJp6cSLZcDw1xDTbKvXG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745501168; c=relaxed/simple;
	bh=BiQHjJ36lPavvyhuCSFZN1nJJsTPlMyn4R5fHz/oGLE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E9CFc27H2BHbDI/r/eHJ5Zgl8S+25rjgKLX8Zqjpf5ICAdM6R+Umi9ApHhEU+BtnfuKZNjsNRmcP2fSedUJo5O8sYFn/tRMZFjCfxWrLdbKB4oisXOycmGp4fizlEwbEWfsVjt1HG+OQzE+ikAkvPu49eBDu5qje8R9FdyjtCnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tPUKRuxh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF192C4CEE3;
	Thu, 24 Apr 2025 13:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745501168;
	bh=BiQHjJ36lPavvyhuCSFZN1nJJsTPlMyn4R5fHz/oGLE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tPUKRuxhId7oC8rmzReOYFmsDsXCgj4TRzR0DlPXN4Ux0vjjCwdG6WB5g6YMG5WO8
	 gef6abXsTlB4vzwwU7aRzednHaGnFG+HpQNXeJbL3nc2ByzoaH33EqyEL7XCuITkHo
	 f4ZTmKVt9zGxbP1nbJsXxoW9vjK8kYh2cghosINsyH3njlJ9VnHlr2oCLtowIEV/DD
	 nVcRHEePUtm+hHsn+tGaBDyPEVw/cC0AMCw7eCiUqLp103cgCHtfKMAHTkpab1vecm
	 2S9UaNsxVwiDKfda0SzFSyOgQt+pC9vtvHqnlGBIq9kWYHHHUJ06RrjnIxZ1tErEEw
	 8SwQ8ITfouOdw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Nathan Chancellor <nathan@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.12 v2] lib/Kconfig.ubsan: Remove 'default UBSAN' from UBSAN_INTEGER_WRAP
Date: Thu, 24 Apr 2025 09:26:06 -0400
Message-Id: <20250424003727-caa2fc3e8fc04d05@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250423172241.1135309-2-nathan@kernel.org>
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

The upstream commit SHA1 provided is correct: cdc2e1d9d929d7f7009b3a5edca52388a2b0891f

Status in newer kernel trees:
6.14.y | Not found

Note: The patch differs from the upstream commit:
---
1:  cdc2e1d9d929d < -:  ------------- lib/Kconfig.ubsan: Remove 'default UBSAN' from UBSAN_INTEGER_WRAP
-:  ------------- > 1:  31b9ab35d27ca lib/Kconfig.ubsan: Remove 'default UBSAN' from UBSAN_INTEGER_WRAP
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.12.y       |  Success    |  Success   |

