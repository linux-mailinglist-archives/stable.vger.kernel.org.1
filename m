Return-Path: <stable+bounces-165130-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A6FCB153D4
	for <lists+stable@lfdr.de>; Tue, 29 Jul 2025 21:46:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42CA4188D2F4
	for <lists+stable@lfdr.de>; Tue, 29 Jul 2025 19:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 688B625485F;
	Tue, 29 Jul 2025 19:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QmXthhD2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 109622512C3
	for <stable@vger.kernel.org>; Tue, 29 Jul 2025 19:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753818318; cv=none; b=liDiax0AgDNGtIWBnGJjSuzYTGTcf50v5axIlPdGLy1IR8DzZ9BBeTu85KSNvgOJxoEh2HvLVDLETLkRyi/glQszRgNkHmt4Mrl6zp5KHmNWs7NPoLsSw225m9huyrsZKovyj9jOLWU8I7hNnIfmLtCgznLn+LNQV7aGHZEJlZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753818318; c=relaxed/simple;
	bh=wNil73O1vTn795+iuNhXhPDbVfK989UN3LmpKJjcIpc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ODbPAm06XpBskyrz0Hy6rQWCcsRdvwB3k2B+0UG8HA+5fJq9EHElMMweb75V84myuRVXHqKqy3Ypw97pgkoznGbjJhzydXWEuhIRQGvhKnRQetsi5STul0FlfgfK7eq0GDQ1vrmg5y1bidrTw9oohb9fjPnYL6yWD5lVmz1/7SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QmXthhD2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06256C4CEF6;
	Tue, 29 Jul 2025 19:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753818317;
	bh=wNil73O1vTn795+iuNhXhPDbVfK989UN3LmpKJjcIpc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QmXthhD2AjfM5xjKQJmN0yrQtIOqvjabqtD5GV742z+ycyuzdP8FE+TNejya7lceU
	 OIyGtPbgtoxDkbg0CAqgxbtIv+dodXPAnV/6sAZQGBAlCm/oPfsl7uGyL/zo6sTUlA
	 neE+jUjfQVaZdarfBzp9gAY9jef5sGupvBRc6I5uteiq0oxmBfKZlhfxAPo84Nh5H7
	 6pqkZrst/8qv8YnO5szuvhIbCwjBnF2su9malciHwfstcmEl2kKgv6UIhqoo1YYd7G
	 cfa7OQG0SabT20fGPAVQ9eCwRGGPdtjaXD4cYkdFACK1jnEtm27/wvVhZmvQC/Tou1
	 HWESVlaazxZwg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y 2/3] mptcp: plug races between subflow fail and subflow creation
Date: Tue, 29 Jul 2025 15:45:15 -0400
Message-Id: <1753816622-79c4ccd0@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250728132919.3904847-7-matttbe@kernel.org>
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

The upstream commit SHA1 provided is correct: def5b7b2643ebba696fc60ddf675dca13f073486

WARNING: Author mismatch between patch and upstream commit:
Backport author: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Commit author: Paolo Abeni <pabeni@redhat.com>

Status in newer kernel trees:
6.15.y | Not found
6.12.y | Not found
6.6.y | Not found

Note: Could not generate a diff with upstream commit:
---
Note: Could not generate diff - patch failed to apply for comparison
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| 6.1                       | Success     | Success    |

