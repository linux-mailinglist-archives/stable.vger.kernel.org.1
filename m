Return-Path: <stable+bounces-194963-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A6CFC64B7A
	for <lists+stable@lfdr.de>; Mon, 17 Nov 2025 15:52:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 9897824146
	for <lists+stable@lfdr.de>; Mon, 17 Nov 2025 14:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D822627C842;
	Mon, 17 Nov 2025 14:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mqwt7SGB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3461136358
	for <stable@vger.kernel.org>; Mon, 17 Nov 2025 14:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763391154; cv=none; b=JHehlt0v/mY5s1hWEudL9D/E7bVebTlczyF52mcGSWwMOoXV1+HPI3iKbqNDtnT+eYMhqgq+aguF8/EEe3CZcUmzah6EYKKnmr12G3L3sI+kJXoXZ2yi24gcarRaO6On7oZ8+QmzZjBzOTtfHKyi2ly8Okcijz4GW7jB/j6qZPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763391154; c=relaxed/simple;
	bh=ewoY4fGIoe07SiUAA6GkX4+xUxh6mD5ALYEWaudhoJA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XPtCFMeAW5WKn/D9ZgmQLQd35dJcqTRISQ22rDQd3XCfzP6Hn/g1Sx30xcqJw1Xf4nDWMIPcu4ijSjDYL87OOPcmQnP8EtC8xwkpUoh2rSboouLgo7VYR5MpXEOAdul8TZ24dCNTSDXzI2hUjrZC1gexd5le4slf6brnj+SzbQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mqwt7SGB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19E0FC19422;
	Mon, 17 Nov 2025 14:52:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763391154;
	bh=ewoY4fGIoe07SiUAA6GkX4+xUxh6mD5ALYEWaudhoJA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Mqwt7SGB+6GifL/UMOgmmy5tFyVeFMIkIK40IFNJusOlZSU8nn1vcxf2lxgRnqpS4
	 1q4XL5Ib5aB6kdVemM/pHZTw343HcEHjBrhII8vGbeagtFNwC2JV5cjLYs6/ieuey+
	 udRiHJtBzy5CfLUCin/39qvfYU4HJRCzau+Plvk5hHZlM3zdC5yPHUTHWmNbadmtTx
	 CzGRbStReLnO89eyT7VFuooIxJ1vXufX7qb3K9sH2k6lcyfGtHbJ4tO+busHqWuJ8t
	 KrFX2U6fLs+M4X4XNwBWE5gkOI58UvcnOfCPx+q1aIebcJA9kdnvpYFThEPEvE5Lwx
	 KxqVMZnIYb0+g==
From: Sasha Levin <sashal@kernel.org>
To: Jakub Acs <acsjakub@amazon.de>
Cc: stable@vger.kernel.org,
	vbabka@suse.cz,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	David Hildenbrand <david@redhat.com>,
	SeongJae Park <sj@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Xu Xin <xu.xin16@zte.com.cn>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Peter Xu <peterx@redhat.com>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 5.10.y] mm/ksm: fix flag-dropping behavior in ksm_madvise
Date: Mon, 17 Nov 2025 09:52:31 -0500
Message-ID: <20251117145231.3874169-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251107121905.18132-1-acsjakub@amazon.de>
References: <20251107121905.18132-1-acsjakub@amazon.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Subject: mm/ksm: fix flag-dropping behavior in ksm_madvise
Queue: 5.10

Thanks for the backport!

