Return-Path: <stable+bounces-110435-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DA6AA1C3AD
	for <lists+stable@lfdr.de>; Sat, 25 Jan 2025 15:03:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 410A31881FC8
	for <lists+stable@lfdr.de>; Sat, 25 Jan 2025 14:03:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D50401EB3E;
	Sat, 25 Jan 2025 14:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gy8Hf7lk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93FC725A65C
	for <stable@vger.kernel.org>; Sat, 25 Jan 2025 14:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737813830; cv=none; b=eowN0KmR3Q19XegloCkKrtz5bqm67BQgVppbw1h4a9Ympd6jxybbS5GWWaC4THKQQb8IMwes4a5dzmfT2pNdmOX25IwHe/L07kOp8keYJj6oms7OCPDJMsqai+CdAk4FU9ZKmB9WzvV6mgK7cFzEUxFVOWWkLdDkJjm1yoWqcCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737813830; c=relaxed/simple;
	bh=URk10dDtj4ycoyhOPmzMsReyUOCJeMnpT1nzTOYY0Eg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=owthSL72gdreM3lb2J3sCn8ewzbnsr2WPJCLx9oLDzTWeSVwpoH1d1aNBRqXwW8l9khduhUrYNIuEZTD0WuNlvgf8pDHRiLuQg8s0loiAdeYWK5EMpuoTv6m8ZZvy2e+A/FpGHITaRrlFSQg0Gdb+TGENrvor9BDzYMvMR5eSeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gy8Hf7lk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1BF9C4CED6;
	Sat, 25 Jan 2025 14:03:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737813830;
	bh=URk10dDtj4ycoyhOPmzMsReyUOCJeMnpT1nzTOYY0Eg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gy8Hf7lku/A0Zg2UwoEjzI5eQD1cR7iInzMuTVA1tWpn05Ctq3jdWYhUJH0mBCxd6
	 MqwFdqLzbtj/7eE4J/+kobcH+SmdoG6Qumwb4BYQWuQOQXbWEPKJubxrxKT5LN208n
	 63Dx0xgN+gb+XJs0BU4o66Na0+6wpuZJModk0gzYjdP9Vg+GTEbDQzA5LRp5kAq6Ur
	 jHt6fhi47JByFp44CdyKtA6RRU9yf5QsVGojdbzmbSSCya4XI+2IFrcf0w47+Pf6Xx
	 msb7G2wxC7Pl42Yh7uVg7f3oys44iTl+nDXigF6XL4P0fmBlU4ZrUsV32VpqFQ1MC2
	 jVcimPXZlhtMQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Pavel Begunkov <asml.silence@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH stable-6.1 1/1] io_uring: fix waiters missing wake ups
Date: Sat, 25 Jan 2025 09:03:48 -0500
Message-Id: <20250124203355-493b4a6dd0a0742a@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <760086647776a5aebfa77cfff728837d476a4fd8.1737718881.git.asml.silence@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

No upstream commit was identified. Using temporary commit for testing.

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

