Return-Path: <stable+bounces-154753-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BF59AE014E
	for <lists+stable@lfdr.de>; Thu, 19 Jun 2025 11:09:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 294A519E1DC1
	for <lists+stable@lfdr.de>; Thu, 19 Jun 2025 09:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8A4D26E707;
	Thu, 19 Jun 2025 09:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OSP9eXdk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E9D21C9E3
	for <stable@vger.kernel.org>; Thu, 19 Jun 2025 09:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750323752; cv=none; b=owJBqUILTK8ASHfZpHsThV1yczZq0U2xZRvaVE8izKUQjka7sOD0CCU9NJCJ8tj0mPt8NRE1aCWOKPi93+fj0dkSBnyy0eLeqSk4BsNsJbwB4CrSrk9GsaRveFKsQPedbXbXitkNQEaIwPRqZhbXewaeEs7vdan/5sfuEgY0Ig4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750323752; c=relaxed/simple;
	bh=UW75sPu6VFnM4UeP/OdwujRmLgIW8fq9ZPYp2XJrmxs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rMXilKrdZJ2UyBtUCAb13DAuarICGoXS6yxl3gP+iTaQiNcbvOaJZ0YZiELFSS9mA4i/lN0BBwOQvWYpmKkzk1dup55CqXW4qD5i3rE4FjhR5bncP4lYwbpW8gwdovh/ZHgzKnvpL87rOH/9zj3Cp/LK13TfQt2SI49kuSYr/i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OSP9eXdk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA715C4CEEA;
	Thu, 19 Jun 2025 09:02:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750323752;
	bh=UW75sPu6VFnM4UeP/OdwujRmLgIW8fq9ZPYp2XJrmxs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OSP9eXdksWMeF8SmYoByWGWsJnI1ltsHa1AipAGWrsT5OUnCpTdlE06pWYQPkO+gu
	 d3h3Ju1wQ4iifPdq2FI+DZzQy0TNdG5vu1GuSfkE5aAGsGNnqYAPuJqYSm7KPNIZt7
	 7Gx7/aashewwqXCKZVikUmaVKZQatJCdGf6mnTVFBjnalikvNIOKOXyhVhpasbBsX+
	 jE0OF4YxKbzLku90a6wYn4j7ncrxwN4YQhQulcmYD2//5Q4IktF118ihpLKA4znNGm
	 uhPhJqXCifT9D4KT5ztlPrw0/8XFoZpIu6IPfLZm7J+aiYlB/4EQ5pu8UL8Es0kKDb
	 s2bBYkXbfxXsw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Amir Goldstein <amir73il@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15 1/2] ext4: make 'abort' mount option handling standard
Date: Thu, 19 Jun 2025 05:02:30 -0400
Message-Id: <20250618163746-e5d04fd8379a58c2@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250617210956.146158-2-amir73il@gmail.com>
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

The upstream commit SHA1 provided is correct: 22b8d707b07e6e06f50fe1d9ca8756e1f894eb0d

WARNING: Author mismatch between patch and upstream commit:
Backport author: Amir Goldstein<amir73il@gmail.com>
Commit author: Jan Kara<jack@suse.cz>

Status in newer kernel trees:
6.15.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (exact SHA1)
6.1.y | Present (different SHA1: a8dad6db0ed6)

Note: The patch differs from the upstream commit:
---
1:  22b8d707b07e6 < -:  ------------- ext4: make 'abort' mount option handling standard
-:  ------------- > 1:  448450a6537d0 ext4: make 'abort' mount option handling standard
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.15.y       |  Success    |  Success   |

