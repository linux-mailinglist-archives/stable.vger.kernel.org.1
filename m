Return-Path: <stable+bounces-136634-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05CDBA9BB2F
	for <lists+stable@lfdr.de>; Fri, 25 Apr 2025 01:22:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87C6F3ADEFA
	for <lists+stable@lfdr.de>; Thu, 24 Apr 2025 23:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EF39211472;
	Thu, 24 Apr 2025 23:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uk+cdWul"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC17A93D
	for <stable@vger.kernel.org>; Thu, 24 Apr 2025 23:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745536972; cv=none; b=snWdgygC1sVwl3EvlVyjE7sDPZ8Ne5NwjQLSfpURHoXX6pYOuuvOSoXBYhXTQoKte6vsJCungnLWaQCMBdtf3GfQGIlkS/T0hxqORn6+Vw01ORjLis/WTbM4dtaaXmowANaG5/6k6cQWwU7LTBauiwrtkN+c41ohRhyohSFwUgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745536972; c=relaxed/simple;
	bh=mioiwomoUhCsY2EXAT9ApWzlzy0wpBehYUlIRn1FZxw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eo7FjrlPf0iD7xV+UQoTI8+2bxWJuVen/3OfZy2biyKVTvolbT+A1hn7h91AwqihOpv6iwIeitVBd759YMW4Kv6qb7AUHRfwTFgay6O+6Jr7Esu694BEFKN06UUKAxyX+qDwmwEwu1AHaA2wC+AomasNsq6j/gbFYSseMn77pEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uk+cdWul; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BF72C4CEEA;
	Thu, 24 Apr 2025 23:22:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745536971;
	bh=mioiwomoUhCsY2EXAT9ApWzlzy0wpBehYUlIRn1FZxw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Uk+cdWulI3WiVOv8xm171naJfxl0kE1C3cGmULd27vkwcvcptA+uA6xVP0zNTM0Gl
	 xB3p0+CrqbffIZxtOnoQHKChcnfkJw07QQQkZL/rxM2+w0XDErtuhGdeZwxl5c57PY
	 gu/cS9HHs7vHcackfyqK0qPSUx4K4j2kZ3yA4wjd6n1vD5aueXGfAl1aH0Fw08cAzA
	 IUimf2vGH0Yhf4A8tV43HbLtRIkXCKBbUnib5ly4ZMNRI2fKFsvy8OuUmQN+X5myE4
	 DtGUzsps13IBuZMzp2s0FmI8T/qG8RgVlovguPm4UkdhZd3MfYQ3aN37JD5yG46/Vf
	 zxFVZtFJ+HusQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	hgohil@mvista.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 2/3 v5.4.y] dmaengine: ti: edma: add missed operations
Date: Thu, 24 Apr 2025 19:22:47 -0400
Message-Id: <20250424163207-80fffe5229d8d17a@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250424060634.50722-1-hgohil@mvista.com>
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
⚠️ Found follow-up fixes in mainline

Found matching upstream commit: 2a03c1314506557277829562dd2ec5c11a6ea914

WARNING: Author mismatch between patch and found commit:
Backport author: Hardik Gohil<hgohil@mvista.com>
Commit author: Chuhong Yuan<hslester96@gmail.com>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (exact SHA1)
6.1.y | Present (exact SHA1)
5.15.y | Present (exact SHA1)
5.10.y | Present (exact SHA1)

Found fixes commits:
d1fd03a35efc dmaengine: ti: edma: Fix error return code in edma_probe()

Note: The patch differs from the upstream commit:
---
1:  2a03c13145065 < -:  ------------- dmaengine: ti: edma: add missed operations
-:  ------------- > 1:  1b01d9c341770 Linux 5.4.292
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.4.y        |  Success    |  Success   |

