Return-Path: <stable+bounces-197094-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C37EC8E556
	for <lists+stable@lfdr.de>; Thu, 27 Nov 2025 13:49:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A6CD3A7B24
	for <lists+stable@lfdr.de>; Thu, 27 Nov 2025 12:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C3F821D3C9;
	Thu, 27 Nov 2025 12:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m6tZaaLh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59CCF1EB9FA
	for <stable@vger.kernel.org>; Thu, 27 Nov 2025 12:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764247789; cv=none; b=djYBGGSqkyS9rPdIqEQVvyJKAvrE2LwD3U3CSrfxAZBGAxDOi6zatIuOHLabo4Rg6uzP0mPyL1csoLIl6YEGqkKx3os2dh+/U4HOdTPD41IcwRDODunCOvmegXM2Fz9ZjFOCmYdP2zYbyIkC9Ol8Ptl0ao2Ra8Zavx8HQ2xeL0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764247789; c=relaxed/simple;
	bh=jzJqFisASzR/XPIuI3xK7fA1MH7E+8pM4xcu2RxJxhk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GCk+TAnKMrFfWEiFbmRXR+SbuAZ9TOSb4JXKCElHdDbD+XSEZ0cdX12kdHPBFzOQl7eoVhv2kzsStejmYyLClha5RRVJpSU6ZBuMOr5qXuocMXRQhP5GHMVpVrX1OVpCX9s0AOF5JkzuKRi+osWaiOM0V1T4ZD/x9i1qz/+6cew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m6tZaaLh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAC09C4CEF8;
	Thu, 27 Nov 2025 12:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764247788;
	bh=jzJqFisASzR/XPIuI3xK7fA1MH7E+8pM4xcu2RxJxhk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=m6tZaaLhyl3IJUxv4VZANxvmFlq9rE8/RoxKWkeUQwCHqx0o+cztGM2PUOqVruKkl
	 9sW3BtIgajKIu6K5u4gWlVPvauEUuzLhzF+0nwR8Qe24nXuTRcCvsRW+2o+2BYQZiA
	 jcpKIdsMI2HJDRmhc7v0AAWJitSS5suV6cEFtI2m+zzwOcwT7tCmmDd6w/+cg7ef5z
	 EtSnVC6kd4JFi1u9lIPqOl2es5pqjtn0yBc1YnoQ7yZOJSoDRA39NlD+vb6tPS9R9K
	 7Hx0W+G7Iq9HqHxqEHXzRNO6jy9eXuFgm/nbp8OzNKSeV/abe+oqaX1K5cZeJFXTYq
	 rI9Srwb+VQjXA==
From: Sasha Levin <sashal@kernel.org>
To: Kiryl Shutsemau <kas@kernel.org>
Cc: stable@vger.kernel.org,
	"Darrick J. Wong" <djwong@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Christian Brauner <brauner@kernel.org>,
	Dave Chinner <david@fromorbit.com>,
	David Hildenbrand <david@redhat.com>,
	Hugh Dickins <hughd@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Liam Howlett <liam.howlett@oracle.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Rik van Riel <riel@surriel.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 6.1.y 2/2] mm/memory: do not populate page table entries beyond i_size
Date: Thu, 27 Nov 2025 07:49:45 -0500
Message-ID: <20251127124945.1637925-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251121135057.1062568-2-kas@kernel.org>
References: <20251121135057.1062568-2-kas@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch has been queued up for the 6.1 stable tree.

Subject: mm/memory: do not populate page table entries beyond i_size
Queue: 6.1

Thanks for the backport!

