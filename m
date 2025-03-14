Return-Path: <stable+bounces-124482-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 158B2A62148
	for <lists+stable@lfdr.de>; Sat, 15 Mar 2025 00:10:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53CAF3BE451
	for <lists+stable@lfdr.de>; Fri, 14 Mar 2025 23:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1B141D63C3;
	Fri, 14 Mar 2025 23:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PVZQ9w2p"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8981F92E
	for <stable@vger.kernel.org>; Fri, 14 Mar 2025 23:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741993817; cv=none; b=Cu6HtZtMViV7MftMRihEnK7BpcqtyduPMBIW/5f32N62AJk2TmvYHds9ytI5q5igc0EElf0uNdfTjA/Ezf0E3l5PDLm3cHb06MBtFythN5izm1u/nt9lH2gGlnB+2UkhJaLqmh2wyRZu44MNroJGeX1m+aiv84YPJXtb0flx5NM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741993817; c=relaxed/simple;
	bh=nk/jc5FIgCMATA/yqv4/H6L1PcEDwAXmdhOuX8HJ69A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aFKhX6WgefG1JC2QqqQ0Qny+U8YNbwFV1A26uySu+Vv6dIsaPFjJO7VpAwhG2fVXnQ9BcrE1x0YLNlEq3K91AOyCBPTF1Xt8mcEgmjt0nnQ46kvZF6tmlMM4TMKMu3yoAj1EzM1Lm6FyJfa5hMyQkUxAwJfEOSw2VIyDfrK0+2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PVZQ9w2p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BCC6C4CEE3;
	Fri, 14 Mar 2025 23:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741993816;
	bh=nk/jc5FIgCMATA/yqv4/H6L1PcEDwAXmdhOuX8HJ69A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PVZQ9w2pnTrMPuvEsGOWA8WF6D5UYqsq35YI/FcU4sQS33rLccCaxmifBlwOYfAdt
	 nw+3HhAGSavTL74m/dz01woI5VwXXEq4/vJrWUggEcP1ZsHFfsA0AufnUnK7X4LFV/
	 mWFK5KXvufIly6VvYfGeXA4PDOfLIkFR4Och7MQiF+OFqsEsEHWyu2OBK0j5mbg123
	 ddr1e3OA0JNyNb141bUA/0oW27j/dd5oub8nwTC69Grnz4J34kX8fuyZG6EyQTwBWB
	 U6UNyXpUKRl+y+SQ1fJmZs32F5RRGcokv8WaxB1misAnCppTvNewh6Rza+CapTZiph
	 /dDmhjyBWfbSQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chen Linxuan <chenlinxuan@deepin.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH stable 6.6] lib/buildid: Handle memfd_secret() files in build_id_parse()
Date: Fri, 14 Mar 2025 19:10:15 -0400
Message-Id: <20250314083811-82152b90557ac49c@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <0D63CE7960D94BE9+20250314090337.31408-2-chenlinxuan@deepin.org>
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

The upstream commit SHA1 provided is correct: 5ac9b4e935dfc6af41eee2ddc21deb5c36507a9f

WARNING: Author mismatch between patch and upstream commit:
Backport author: Chen Linxuan<chenlinxuan@deepin.org>
Commit author: Andrii Nakryiko<andrii@kernel.org>

Status in newer kernel trees:
6.13.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)

Note: The patch differs from the upstream commit:
---
1:  5ac9b4e935dfc < -:  ------------- lib/buildid: Handle memfd_secret() files in build_id_parse()
-:  ------------- > 1:  251f716878081 lib/buildid: Handle memfd_secret() files in build_id_parse()
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

