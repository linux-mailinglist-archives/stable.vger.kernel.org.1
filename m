Return-Path: <stable+bounces-108032-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 337EAA0658F
	for <lists+stable@lfdr.de>; Wed,  8 Jan 2025 20:49:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DDA23A217C
	for <lists+stable@lfdr.de>; Wed,  8 Jan 2025 19:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54E3B1F130D;
	Wed,  8 Jan 2025 19:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G8ayWUBv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14F3522611
	for <stable@vger.kernel.org>; Wed,  8 Jan 2025 19:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736365787; cv=none; b=PbX3+a0RRUomLZ2n6LO9btX+DB5LsuNxLSyav8qdeJKdrT86ZwYw9Qr+GEwKXcdoYvEUtDXlvfzN+3kL0COPq85UF9BSL1jSbXRlHnuSG7wmrxL099882hpSxkiDhfm7NXhpHJOWBT1W6I0omjsWRvIpWiL+2ZWJrAUYQYirmTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736365787; c=relaxed/simple;
	bh=JyWfvrPwH5egLjx2xqCX9jwNymqmiC6JtrxC5g/CeDo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dTzNlPOEjj62KNbLa7Pc9M/3Xkr6DhhaT4/QEGzzqMfg2h0EqOJhRzwirpO64hOhnpqYzFRZENxNnI+QqT7u6jCAkIkbz6zhJRUPNyHqDGZMfe9vchc2/CRdVP/E61tnfBgdKANYkWFNgiTGq9BnhWM54xlwSdduUxI93e5H54E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G8ayWUBv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 211C0C4CED3;
	Wed,  8 Jan 2025 19:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736365786;
	bh=JyWfvrPwH5egLjx2xqCX9jwNymqmiC6JtrxC5g/CeDo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=G8ayWUBvplBBMMG4CKORCS1kunwnajNhrtEVMZ7oHd1MOX7kXP27QEMmWuaZ0GAGg
	 iV5SVwDCu3tMn0VgrByWwO1tDlUMGj/KDsME7yxglsN5Y9iH5WphuAlwUSAQSyfyID
	 HflkY6yVxnTn77H8zJvJ1B9ajQhZ8pd3gWY7THibcvDdTmTi4S1MQQvLiNqX+h2w85
	 nfolRKCUCrjfwAAZHxy8/qNM3KQU73eYZsaniSDVZrIQ4VyNGtouIuSaeafaNRUg2D
	 9D9C5X3MpavrVV8UaudOYg9uDD5enJRav8CNEAllh9dxsbM93ULAhvjU5+lfLMzn2T
	 opPykWz1OXMpw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6.y 1/2] erofs: handle overlapped pclusters out of crafted images properly
Date: Wed,  8 Jan 2025 14:49:44 -0500
Message-Id: <20250108142223-422716577eda8f5f@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250108151520.2515903-1-hsiangkao@linux.alibaba.com>
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

The upstream commit SHA1 provided is correct: 9e2f9d34dd12e6e5b244ec488bcebd0c2d566c50


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.6.y | Not found

Note: The patch differs from the upstream commit:
---
1:  9e2f9d34dd12 < -:  ------------ erofs: handle overlapped pclusters out of crafted images properly
-:  ------------ > 1:  adc4faa17184 erofs: handle overlapped pclusters out of crafted images properly
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

