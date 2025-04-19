Return-Path: <stable+bounces-134693-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ACD8CA9433C
	for <lists+stable@lfdr.de>; Sat, 19 Apr 2025 13:47:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 977908A4442
	for <lists+stable@lfdr.de>; Sat, 19 Apr 2025 11:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DED71CAA7B;
	Sat, 19 Apr 2025 11:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VZLIpQCT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C45BF18DB29
	for <stable@vger.kernel.org>; Sat, 19 Apr 2025 11:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745063251; cv=none; b=LAoT0+gv+0nRIwlewJot8Mfu0UqFmeIftyAzi8lLF3FXF+MsDHnXGwJOmtb4TSk0NnzvKIvr5OrUBesSqVB7Ld7odw4WAWKq4N3HRGCfoj/pz6cDE1BOwYp39S++se2CPMSgOAWdUVsXbiNG1iubmF1vfqvTMjF3+BN92FfkNaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745063251; c=relaxed/simple;
	bh=IZ87J3iyitysnDK+7lsZ9m5XSgiQX/3iu/rG6kjDCcQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iOdmfmWtXReZb9EHzbAVACy/b6ST2Wyum44bw/KHcDF5Rk26RNWfhbNijCW7Gv51aarD+JD2qmLyx2oae0C/6BYTq6becYZlKd6SIF6fdqEOR5CMW+MyS+IiodC+qsfpqHVzJgAaCb0fhXBzRH2zf0+6iNeUHlounkkebjZYJto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VZLIpQCT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B89DC4CEE7;
	Sat, 19 Apr 2025 11:47:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745063251;
	bh=IZ87J3iyitysnDK+7lsZ9m5XSgiQX/3iu/rG6kjDCcQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VZLIpQCTfVBFIXZru7w1NLyj3fwfKtqTtS3eDqz/cR3LmqnG4aaWqavvEywYEVCtq
	 IlrE7qW3F6vIknx7/+QtyFWm0zX1kRdubo3REn3ReVheQSQO40GpMqDHwOWIyZ7GFw
	 1h3LUrq1usrJZLgVfOdPU5hbTV7tgCJFxEs89t9YQsiR4SwSZ6gT4kLwwVUYF8lxrI
	 kOlNPyT66ZbvHnuGDwZ1iRpzCp6H4mvf+Y0TUd9Hn8syUeSEjYGECgZgPgeHSa4wKP
	 qC+4qlwB84L+//xy3Dcuhz0An7IuFdaD1PSYmjkmUUzfZzjg0aGK3S4qieaJBNkj7Y
	 +kaNtyx85nZZw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	bvanassche@acm.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 3/3] block: don't reorder requests in blk_add_rq_to_plug
Date: Sat, 19 Apr 2025 07:47:30 -0400
Message-Id: <20250418190648-ba511104ed8c68f0@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250418175401.1936152-4-bvanassche@acm.org>
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
ℹ️ This is part 3/3 of a series
⚠️ Found matching upstream commit but patch is missing proper reference to it

Found matching upstream commit: e70c301faece15b618e54b613b1fd6ece3dd05b4

WARNING: Author mismatch between patch and found commit:
Backport author: Bart Van Assche<bvanassche@acm.org>
Commit author: Christoph Hellwig<hch@lst.de>

Note: The patch differs from the upstream commit:
---
1:  e70c301faece1 < -:  ------------- block: don't reorder requests in blk_add_rq_to_plug
-:  ------------- > 1:  9bc5c94e278f7 Linux 6.14.2
---

NOTE: These results are for this patch alone. Full series testing will be
performed when all parts are received.

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.4.y        |  Success    |  Success   |

