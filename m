Return-Path: <stable+bounces-106108-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 993BA9FC74F
	for <lists+stable@lfdr.de>; Thu, 26 Dec 2024 02:21:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 146DA18826D9
	for <lists+stable@lfdr.de>; Thu, 26 Dec 2024 01:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 838AB4409;
	Thu, 26 Dec 2024 01:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DEZel8+o"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43581EC5
	for <stable@vger.kernel.org>; Thu, 26 Dec 2024 01:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735176098; cv=none; b=GXwl8Um2mqDqDjmwAVUSQqwZQlN2H9xTcpAVh7PfJ/gXrkio25MDBWjgku/0HYaJoXTvGG8Ag9cYTnsdRiZ5nJsekwj5Cx3qFgMp3g8SRwW9DQiq7IS9Uhj+bSNyiwrhjm/q3p/gVx70tmkt3od48gP4i7Ey821mLrxwX/TZ9iE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735176098; c=relaxed/simple;
	bh=7KZxp6I/YlRRD6EOXem9zuSjAXiZz2MKAoRYF4kFpBU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lJFUghLg+sFD1XHSNaoRLcyku1rvHGG8VKPjscqkTznAJhRwNq4OqY5kmtzg1do6z09r64GGnJEcjYdrRJEOKyJ+wf5jZmRsN6dWAj2VDJLwddGZUJjV7KoGcMgpVELNBK2dk39UGKjd5lvQtrUgh2MaJQzV5a3XEJ+fJbpPj+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DEZel8+o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53011C4CECD;
	Thu, 26 Dec 2024 01:21:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735176097;
	bh=7KZxp6I/YlRRD6EOXem9zuSjAXiZz2MKAoRYF4kFpBU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DEZel8+owJ/11YTJObT2ivlmdGi7NqPQXbm41Ng9P5xi6Lwx/Cf/hvmLoF6GI3JFF
	 2rFY/3KfdLkS5zfy7llS21z1QgxdRwEnCxVFgtsgUbD9/XGjpnKOPS1QSRmD74dzIw
	 8/nt7TXaMGd0iprSQ3z/lKXbUSem65vLXWdx6IWXdxNoWXjIPiZ3EyQt3+zdx+/AMj
	 eliDB5sJi9lZUsFsIBdgmt3tGHw2+gK9cLlbiAl3kP1FpmjpKeMouXbGpAayZf7hW7
	 HRRHrpgqS1ulsKJ9fPl5roWkbcsjLmtHpBFWKxXKBKMlOha3gqDiYEacLcTK1uhKVX
	 B/FDhFejjLsSQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Harshvardhan Jha <harshvardhan.j.jha@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.4.y 5.10.y 4/4] ipv6: fix possible UAF in ip6_finish_output2()
Date: Wed, 25 Dec 2024 20:21:35 -0500
Message-Id: <20241225194729-5e899a2109d9e3f9@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20241225051624.127745-5-harshvardhan.j.jha@oracle.com>
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

The claimed upstream commit SHA1 (e891b36de161fcd96f12ff83667473e5067b9037) was not found.
However, I found a matching commit: da273b377ae0d9bd255281ed3c2adb228321687b

WARNING: Author mismatch between patch and found commit:
Backport author: Harshvardhan Jha <harshvardhan.j.jha@oracle.com>
Commit author: Eric Dumazet <edumazet@google.com>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: 6ab6bf731354)
6.1.y | Present (different SHA1: 3574d28caf9a)
5.15.y | Present (different SHA1: e891b36de161)
5.10.y | Not found

Note: The patch differs from the upstream commit:
---
Failed to apply patch cleanly, falling back to interdiff...
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.10.y       |  Success    |  Success   |
| stable/linux-5.4.y        |  Success    |  Success   |

