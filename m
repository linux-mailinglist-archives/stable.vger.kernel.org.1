Return-Path: <stable+bounces-194959-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FA88C64A64
	for <lists+stable@lfdr.de>; Mon, 17 Nov 2025 15:32:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 441F63A2A17
	for <lists+stable@lfdr.de>; Mon, 17 Nov 2025 14:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 529061DE4E0;
	Mon, 17 Nov 2025 14:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BHE7Hh5m"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 118392AD3D
	for <stable@vger.kernel.org>; Mon, 17 Nov 2025 14:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763389924; cv=none; b=gHwhuweUpSPVJVK8hadOdSQhNsYRVVAciDLgP4R6lxIX6nRNcm1gsy2Hn981jORw0+t4HWq8J6X9vnvsgiLV6EknkdWqw59dea0EZ4GSkN1bl++HMEfq4ptNaqD2u1SEmzMek6DR7iqZqehyXpmoHDrGVkxHQqYicQmqdLLBNJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763389924; c=relaxed/simple;
	bh=w2fmK6DiLCFksejMpXPzcH6OfH+GXa1cDoYCOm4daZ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qNG1996LEhUuPIr9q4MEkh5sLxozjXtGQPqSfhxkT5iFwEqSICQGHuua2sa8fyue1YFgv05ZsjDvfGLqAwYPkRx7Yq9BGKXj5KvxFS3/Pa0uxGnEBo3cIb1Fa5/Rq9yvFyM9DyWXSvoVJzSWTnaBGhv1+x5U9IJkQhiwVCW07Fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BHE7Hh5m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26B57C116B1;
	Mon, 17 Nov 2025 14:32:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763389923;
	bh=w2fmK6DiLCFksejMpXPzcH6OfH+GXa1cDoYCOm4daZ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BHE7Hh5mAlVcPH8ZhBItukThdilrNC15jmG2MwyNRCNVMHnQHEpsUivuAY1fPlLdI
	 ZrbctGi5PuBjlW60scTsMrea8CuXT9eQ3ZgGdbE1ZZ4KS/APHwgVL3q4zC5rk3UILv
	 Zs3prAmKMXfxYykmESNof5giwHUgOvRrHHNKgXehK6TloO7vJNqQrooRmR0aDbKHKy
	 R+JMkVrm4FAnJ1TOoBTMAq1j+3S6BR3fIIBtrGIee0p8FvDPSldUU84Z1o6NA//7CI
	 6KWArNFuZKi2u55EpUgdyI7SX0LZHWGmUjMhp/mMKYMalC30e/AFqZmG5dsU5Du/zw
	 8O3g7h3g66Y6A==
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
Subject: Re: [PATCH 5.15.y] mm/ksm: fix flag-dropping behavior in ksm_madvise
Date: Mon, 17 Nov 2025 09:32:00 -0500
Message-ID: <20251117143200.3868356-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251107121755.14479-1-acsjakub@amazon.de>
References: <20251107121755.14479-1-acsjakub@amazon.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Subject: mm/ksm: fix flag-dropping behavior in ksm_madvise
Queue: 5.15

Thanks for the backport!

