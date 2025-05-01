Return-Path: <stable+bounces-139350-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42A69AA6322
	for <lists+stable@lfdr.de>; Thu,  1 May 2025 20:51:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACF4F467990
	for <lists+stable@lfdr.de>; Thu,  1 May 2025 18:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 396D81EDA2B;
	Thu,  1 May 2025 18:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oz3aZuZk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE19820C009
	for <stable@vger.kernel.org>; Thu,  1 May 2025 18:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746125482; cv=none; b=ZPrKqXS4QtLr5IlurHZJDG6jy1wtaDbLu6sHLmtmK4u1FPvu9LvmF5pxDWm6o4HRjJR6LoKv9Oafk+Itmyhno24moitlNVHKaStkcBaiWxZl5WgWes7giGJcF4KVFDS9JGz0W0aucTCIrbKoNw8PLLdy6VXj49p14xFUkbRsRRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746125482; c=relaxed/simple;
	bh=VlEAVbzZ0TG+Hw8Rq6hPUMsKCjzPrZoHxvZSXk1P80Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RcNCyJhJDs3cpFFdtcEOuiSASjffqRo+/fW4XGG4MntZS+Ku0VdT0f8o4ZSVM+p/fr/VCB5qnWLF6lihut/AtyMy36NnvVih62/TCqyMwUvgpnmesgunBF75SWNvfXPhVpI2uHp8MicV/AfHUmc1WeeVlH1adO4V5CM8rcElRkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oz3aZuZk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E57FDC4CEE3;
	Thu,  1 May 2025 18:51:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746125481;
	bh=VlEAVbzZ0TG+Hw8Rq6hPUMsKCjzPrZoHxvZSXk1P80Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oz3aZuZk4DkH0qGcTYtx1dCLtc8a8bgcTExRESs1pbgA36pQCRDjlN8KOY3caOFbX
	 yBsPUJ6N7KRuBQsk06CpmgJwvrtNQJ5cs2unuJ6xIOMgpw83VgyrfOekTZ0Ujyhwlh
	 QxEQcsOWcQZlj77IugztHMlAdpEAc2jHTnpbkTn6ynBVKoTZVJmjBL3JN4ZLKmopdu
	 1cyH/GgrD5IjWihpW/+pb0btLb+cegxOEe3UxljQw76m1Sqm9KSgHUOPU2KDi0Kuv4
	 0cp8TzDMv8dgMj2Yltr1Gq+5nRhdzupdXA1Z3VZvO4z++30YwSE8P6Hvw+XcxoqZiY
	 oWABZUzf+h+Nw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 4/7] accel/ivpu: Update VPU FW API headers
Date: Thu,  1 May 2025 14:51:17 -0400
Message-Id: <20250501115322-77b53c2cfb2a796b@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250430124819.3761263-5-jacek.lawrynowicz@linux.intel.com>
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

The upstream commit SHA1 provided is correct: a4293cc75348409f998c991c48cbe5532c438114

WARNING: Author mismatch between patch and upstream commit:
Backport author: Jacek Lawrynowicz<jacek.lawrynowicz@linux.intel.com>
Commit author: Andrzej Kacprowski<Andrzej.Kacprowski@intel.com>

Note: The patch differs from the upstream commit:
---
1:  a4293cc753484 < -:  ------------- accel/ivpu: Update VPU FW API headers
-:  ------------- > 1:  ea061bad207e1 Linux 6.14.4
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.4.y        |  Success    |  Success   |

