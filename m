Return-Path: <stable+bounces-164783-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4FE2B12753
	for <lists+stable@lfdr.de>; Sat, 26 Jul 2025 01:24:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61AECAC0EFE
	for <lists+stable@lfdr.de>; Fri, 25 Jul 2025 23:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65F7425B1EA;
	Fri, 25 Jul 2025 23:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZEaMUTCh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 280501D9A5D
	for <stable@vger.kernel.org>; Fri, 25 Jul 2025 23:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753485872; cv=none; b=ZDLoB4XDK7Ga8MCHxejS9QZfFZIMmrqLt08xoRlJBN1JKfxLFafh3P3640wzdiKefN0PtjWcnLrmbIBqOLkGaUS1sY15+NPiZCfUp/2GNLkxrrzN6ve5gVX5Zv7doKrmMQYtNYgFz+72Ra6MmH5mma/RlKXkfjN0QuXjE0vx4xE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753485872; c=relaxed/simple;
	bh=2/UwDb5l07kd+bmcFIsWyVQ2PxSF/TD7jo/BC5kOwxQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CrB/fWxqGwW5n2O43FVT6DuCECTeAU1c525LlFLSTjMwhAqQYePBiNuOHPKrEVFbwQ6Dx+77pZ8dxzvBz52pNYvUvNEVQevcX8UrP6dYUMOjT/LDkHioav0fprfmoKQXGp+iWc3aVshPH+DSgnuHjhzADoGkAX9KHdBQckcJQj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZEaMUTCh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 785C3C4CEE7;
	Fri, 25 Jul 2025 23:24:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753485872;
	bh=2/UwDb5l07kd+bmcFIsWyVQ2PxSF/TD7jo/BC5kOwxQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZEaMUTChXQ82d4e5q4H+LXUrWpp0PEUHiIl4GIcVQG4mfVWtES3MoCNmXaxAZpcGA
	 o7x3BgQnKPHz1f7KP6bacX1vr7MI/jCgmaSAmCS4d/UalNvkLvyhOJMsjJdDW45hjI
	 w2W4D4Bp2xBYA+doCtyZT6Io0eO/9PfIdXbdkvrPj4XmvVotFiej90+pLNO11DrXHo
	 UPwwDPdalTX72tNeXNeStjpTMJUgCJWj9c9F6KPfZNOeVvqwd1n6tqtAlvm39V6zxw
	 azn4UJPDocliKIlNO5dNOhSFLsmwuaEYbE1URsljNFGC8D5LMHVMdZYtVEvGWr+mMP
	 9ha0xBit1hMmw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10.y] comedi: comedi_test: Fix possible deletion of uninitialized timers
Date: Fri, 25 Jul 2025 19:24:29 -0400
Message-Id: <1753472096-85a77cef@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250724181646.291939-9-abbotti@mev.co.uk>
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

The upstream commit SHA1 provided is correct: 1b98304c09a0192598d0767f1eb8c83d7e793091

Status in newer kernel trees:
6.15.y | Not found
6.12.y | Not found
6.6.y | Not found
6.1.y | Not found
5.15.y | Not found

Note: The patch differs from the upstream commit:
---
1:  1b98304c09a0 < -:  ------------ comedi: comedi_test: Fix possible deletion of uninitialized timers
-:  ------------ > 1:  670c09f3648a comedi: comedi_test: Fix possible deletion of uninitialized timers

---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| origin/linux-5.10.y       | Success     | Success    |

