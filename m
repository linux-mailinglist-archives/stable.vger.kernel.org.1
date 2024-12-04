Return-Path: <stable+bounces-98592-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 969029E48B9
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 00:23:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50139281617
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 23:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F644202C3C;
	Wed,  4 Dec 2024 23:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OwywkzWY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F297202C35
	for <stable@vger.kernel.org>; Wed,  4 Dec 2024 23:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733354613; cv=none; b=cPOh8g6NZ8hUqokWI3ROH1lrwYtJvyEolsS/cVGXELNO6CfP4yIGkgkfh9HkyUQr9Ej2WQ7x8rEvfasN8cPHN+xpXBBZCBKCjxBrrIbZQQr7OzFXyOiTz/P/umvRgQr6DwGVwQb3Z6t+RRNcClhR0KLCuufJRduTllQGHjZ9iVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733354613; c=relaxed/simple;
	bh=xWrufHI/5y35gERJlxW/y9jH5HTbaO77RgpGJC3R5uY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TB8BW3NJG75L3E4pAGMxL9lGN8bGmlPVDwPiCmvcSdY4Z/UxedEwLwK7V+ZnW93atC2L4pJITwYrislMwEtStxcxOYKW34SG58nTacfJnS8fWbF+mY53ck6if6Z9BcZTtYqc93iMahVVF3VzHO7EDwEgg1WqTzHVjPpoWOxvcpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OwywkzWY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ABBBC4CECD;
	Wed,  4 Dec 2024 23:23:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733354613;
	bh=xWrufHI/5y35gERJlxW/y9jH5HTbaO77RgpGJC3R5uY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OwywkzWYrAZ1IvLlDgdkHABZT4szaYvDo/HQuFb3JzM80y104GiB1Rw9tO4J3Ih3m
	 rqf1ylwKM7QF3ttqJhcQGRhd5/HTmtK7HupNKdH76wTZk6IOq1roKT8OUItyFvfax+
	 fk4Fl+hsb/jDmaq2hSU57lIPp2HfHAsTFIabx8PG5Rw1Uy9Ju2ReNDi5xpJnF9vMNr
	 5pXGwu4rcZLxb+CdfWaU32eLF5XbQhov500EiWY8VxnEWWiP1bTEead3M4qZgtQ5HS
	 8Qp5sGfQAgbXTGSNlnNnODmVvzcUTferFffr5YrjK0+8Vlu48el97AQAoS+ueeVJCH
	 B0PW5skHEDGyw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH] riscv: Fix vector state restore in rt_sigreturn()
Date: Wed,  4 Dec 2024 17:12:13 -0500
Message-ID: <20241204071627-8caffcd5a052a5bd@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20240403072638.567446-1-bjorn@kernel.org>
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

Found matching upstream commit: c27fa53b858b4ee6552a719aa599c250cf98a586

WARNING: Author mismatch between patch and found commit:
Backport author: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>
Commit author: Björn Töpel <bjorn@rivosinc.com>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)

Note: The patch differs from the upstream commit:
---
Failed to apply patch cleanly, falling back to interdiff...
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.12.y       |  Failed     |  N/A       |
| stable/linux-6.11.y       |  Failed     |  N/A       |
| stable/linux-6.6.y        |  Failed     |  N/A       |
| stable/linux-6.1.y        |  Failed     |  N/A       |
| stable/linux-5.15.y       |  Failed     |  N/A       |
| stable/linux-5.10.y       |  Failed     |  N/A       |
| stable/linux-5.4.y        |  Failed     |  N/A       |
| stable/linux-4.19.y       |  Failed     |  N/A       |

