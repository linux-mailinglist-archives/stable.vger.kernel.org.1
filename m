Return-Path: <stable+bounces-197023-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id ECDE6C8A40D
	for <lists+stable@lfdr.de>; Wed, 26 Nov 2025 15:16:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0C295355D9C
	for <lists+stable@lfdr.de>; Wed, 26 Nov 2025 14:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C48DF2FB093;
	Wed, 26 Nov 2025 14:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dt6+rkFk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 553512FB0AA
	for <stable@vger.kernel.org>; Wed, 26 Nov 2025 14:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764166507; cv=none; b=Q+PoN8+4a3Psbe9wP0chnayT+B+ZnulPvNoKVrCsx+WMf8t+fU8URne+XRHVY1sa8K2BNwan/NfV2dQq2su9Lus5s9Nu22P20+PmySA8/TBP1/bopOW9O4rZZGRjlzgi98ysR1EYtIQZDO0MBjybg82usftTIRqMMyz94FH8y+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764166507; c=relaxed/simple;
	bh=LPbw8nmfdRPx1gStO3WJpiNvVHScxPjMArVC8Gf7Rpg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kHCUC+7LKpNT3awPcNJbOwJ69BnSEkWkXwSFm9ofiEMQnvnXd1y9icL4nMdgEwvKG4+exg25B/qoDHk+Oy0+DNL5XvKjnE2wiYXhCFG876yu/o4iZ639Ys0C3d1tn6pT8WBTbQu3CPU8HiqFgMP99ryX0PUb4LPr/nG5BTn9XyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dt6+rkFk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01548C4CEF7;
	Wed, 26 Nov 2025 14:15:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764166506;
	bh=LPbw8nmfdRPx1gStO3WJpiNvVHScxPjMArVC8Gf7Rpg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dt6+rkFk/OkjQNJu4djTVzI+3i7UKwCheMXZISxY1MfYYkIo4yNEW6pwz67VbLH/N
	 eyktQYM7DLV0wcZ5pvqKMXSQDMgthOIsJS7XBe3ID8eNc6I/ZUd5FLeHdyE50WjU8B
	 8M66WtgjIcazejcFEE9rI6XwRoaAxw53+XeZBuKZdKwuOhHPmVqGuW8gYHqz6ISoSl
	 yzyKrX2hL5b3OA6f38P5dEKa6alNwIWRHsqQpatSix9Uv661JI5n8AnJNMs0B31TER
	 kXDi6GljJ/WZrf38fl59e4YjPJTU21Y1gP3aSGQNa9m79zCviU214D/iuxmtI4eX92
	 X080TWI4wBa2Q==
From: Sasha Levin <sashal@kernel.org>
To: Harry Yoo <harry.yoo@oracle.com>
Cc: stable@vger.kernel.org,
	Liam.Howlett@oracle.com,
	akpm@linux-foundation.org,
	baohua@kernel.org,
	baolin.wang@linux.alibaba.com,
	david@kernel.org,
	dev.jain@arm.com,
	hughd@google.com,
	jane.chu@oracle.com,
	jannh@google.com,
	kas@kernel.org,
	lance.yang@linux.dev,
	linux-mm@kvack.org,
	lorenzo.stoakes@oracle.com,
	npache@redhat.com,
	pfalcato@suse.de,
	ryan.roberts@arm.com,
	vbabka@suse.cz,
	ziy@nvidia.com,
	Peter Xu <peterx@redhat.com>,
	Mike Kravetz <mike.kravetz@oracle.com>,
	James Houghton <jthoughton@google.com>,
	Andrea Arcangeli <aarcange@redhat.com>,
	Axel Rasmussen <axelrasmussen@google.com>,
	David Hildenbrand <david@redhat.com>,
	Muchun Song <songmuchun@bytedance.com>,
	Nadav Amit <nadav.amit@gmail.com>
Subject: Re: [PATCH V1 5.15.y 1/2] mm/mprotect: use long for page accountings and retval
Date: Wed, 26 Nov 2025 09:15:02 -0500
Message-ID: <20251126141502.1386669-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251125044646.1074524-2-harry.yoo@oracle.com>
References: <20251125044646.1074524-2-harry.yoo@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch has been queued up for the 5.15 stable tree.

Subject: mm/mprotect: use long for page accountings and retval
Queue: 5.15

Thanks for the backport!

