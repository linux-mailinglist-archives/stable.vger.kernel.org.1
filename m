Return-Path: <stable+bounces-164368-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B7ACB0E999
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 06:33:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6098A56327E
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 04:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15D401DFE0B;
	Wed, 23 Jul 2025 04:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JADV+QYe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9FBC5464E
	for <stable@vger.kernel.org>; Wed, 23 Jul 2025 04:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753245223; cv=none; b=DUcQRg/mM29WdKr3kYd+FTToQUIbyL+zbcyhBqFIkqFJi6JaLcpxypgsLG2kJX5ab9zEwWIVKBCQkE7rUccjTNWNv1HaTwkjo2PrWoLbewQqH0QnjEctezEXRjHrgLqtP+rP8HBep2TjWeyF4Yd7TuZIfpis4DdFWUjKEIJPpTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753245223; c=relaxed/simple;
	bh=CtL1YjEHEc6Bk7s2st65++lsJYav2y14qXC6ckvI2yg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Humdduq1Fvvcr9lWQCu5UsCa/XIEBPsRyCLZNOvJ+4q2CDW0EYCYFytJ0vAjcyMjKB6lBp/d9nYuFywDO/AKGm+EwhmXMKLBfbNVwJGHM8ZhRVxIjNwUdSAfgcqygS9qj79ysTo00WDG5QsH7qcZvZxXn2EGeom9m0KCZqID2Dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JADV+QYe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8275C4CEE7;
	Wed, 23 Jul 2025 04:33:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753245223;
	bh=CtL1YjEHEc6Bk7s2st65++lsJYav2y14qXC6ckvI2yg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JADV+QYeBFZBuagBRPUT9XIpg7yquYzfjt1Y6zC+dKVHo60/nYJ9QDW/EZpZUay+c
	 BYvpHfJuLyMhYp0n2AJEn1wdZED2FzfWxUvEdrfdxSx2W8SgRBpcNcgX0nyAXhthf7
	 23k6YfMzo4p73qkq0FN6WWSgL1lxWCNLcAvKyqvLWbodhD5mRxUcNW5j/wMkzBONHx
	 +kSTLUTiYc+bMyaoisiP+n3HZLFX2ttJnJ1yuXrb/+0vzX3frLPGFGt27aGoZ+zgJi
	 gdB8S/iW3wyft8CcK5uNHAZHYXC1KvR8GSZ9pZnW1NJJn67I19oXRYiuGTnQSDw+Yv
	 dcRsKey7v5Klg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6.y] erofs: address D-cache aliasing
Date: Wed, 23 Jul 2025 00:33:40 -0400
Message-Id: <1753229903-ae8f1588@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250722094449.2950654-1-hsiangkao@linux.alibaba.com>
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

The upstream commit SHA1 provided is correct: 27917e8194f91dffd8b4825350c63cb68e98ce58

Status in newer kernel trees:
6.15.y | Not found
6.12.y | Not found

Note: The patch differs from the upstream commit:
---
1:  27917e8194f9 < -:  ------------ erofs: address D-cache aliasing
-:  ------------ > 1:  e00d41cf735d erofs: address D-cache aliasing

---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| origin/linux-6.6.y        | Success     | Success    |

