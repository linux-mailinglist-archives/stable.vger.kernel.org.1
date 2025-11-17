Return-Path: <stable+bounces-194968-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DF31C64D69
	for <lists+stable@lfdr.de>; Mon, 17 Nov 2025 16:18:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C233634ED29
	for <lists+stable@lfdr.de>; Mon, 17 Nov 2025 15:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97E38338928;
	Mon, 17 Nov 2025 15:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XrkD7ePQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 540123385BC
	for <stable@vger.kernel.org>; Mon, 17 Nov 2025 15:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763392318; cv=none; b=FE9xfeqfmDhwo6GWioo6mBoht/9dAh4z5pCN5QvvuWyeh/QG78B9s3K0Sbo9Bikcrp1i6FKfmu1lr5XKETJ1i6ZFCW5LtgiT8gcRcHTTdQRVBaiQ6IT1M3ScUC0S9Od1FZ138ynKI09GdQEDnA+QSGnypb3h8qA1zDieF0uVCLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763392318; c=relaxed/simple;
	bh=N+xjMv3WWIgvDqubtkWQsnb9EEn1d7Dx3y4amduFMa8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I4fFzKFy9tHlywH3u4qyNtyF520qIYTnufntAR+cpeX92cjueaTMrlH7BtPyOOTCUh1Bd+mJ+uHN+OQAGX+LW7HMJVRgvOg1e+IiVn6MYFudmiSJ/+HU5VuYSbBcC+7g6CRNlKT7BdS0pIqufAYFtWiL0NBPyq7jz0wXDYB8KC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XrkD7ePQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ACB9C19422;
	Mon, 17 Nov 2025 15:11:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763392318;
	bh=N+xjMv3WWIgvDqubtkWQsnb9EEn1d7Dx3y4amduFMa8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XrkD7ePQZTJXYVHbx1A7crQGR6nONcwDAn1BvTRNBNQU/IHYd3yjdzGUrjMavVSHB
	 0roH9stnTWtH0mTXESU9VdiLgHB8PKasAvYOzJds01F696s4nlyZL7gS1uDwQ3fjGA
	 EZSYeOTDMjeURZ0Digu6Yuxsbtb1sXieSYceYkN+/L07jVrb4HHN49V21u/3JEYWYK
	 BEnIHPWPEAVnu8yWw+bvADtWDE2rD+whRAnG6GdQzxbrjFfKKzZPkbHKyqQlzWlJlv
	 nxh2Fvjb8tarIN9avgS11Vjwh1+0nwIGUDkzZDD7f65bE8RRLi2NZBs2wYxTUxOK6Y
	 v1c5F3REIRQ/w==
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
Subject: Re: [PATCH 5.4.y] mm/ksm: fix flag-dropping behavior in ksm_madvise
Date: Mon, 17 Nov 2025 10:11:55 -0500
Message-ID: <20251117151155.3878553-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251107121920.19211-1-acsjakub@amazon.de>
References: <20251107121920.19211-1-acsjakub@amazon.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Subject: mm/ksm: fix flag-dropping behavior in ksm_madvise
Queue: 5.4

Thanks for the backport!

