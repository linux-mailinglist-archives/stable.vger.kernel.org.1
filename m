Return-Path: <stable+bounces-158576-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C90BEAE85BC
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 16:09:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E35E85A5A2A
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 14:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 589C0265CC2;
	Wed, 25 Jun 2025 14:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uaojOTGl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1635225EFB5
	for <stable@vger.kernel.org>; Wed, 25 Jun 2025 14:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750860445; cv=none; b=eqVqziSgTNapVuHu1EH3zjRZgruCv18bMoPoFVJAUxe026v/ioo8f+W9Dc2xKTIgLyCDzCbLEmpjaDOv45WuJbYraRWXISm2UNYgjp7sDQXeQfRB/lBvkEjDfdsqJOd9NfkgZLXFWTZhqJ8BU1Jsq70aFdGFIVeMBF1b+GCQGAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750860445; c=relaxed/simple;
	bh=yjwndwg+z+r9DxxCqP85NTyoloO+NYAhjaUk5zz30ec=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hzmv+salfEaffmnnTkVohN0xgM3CdPVSiG/vFbrESprh3YhT/SDUEWFCYXbGDHi1PL8u5gXj04JZJanow/M103664NJ6Qwvwrh4KjvZZNf3SWuhcHNAAHy7Y4PvlxkMCB6T4TEZdRig8o5yTOOTlYHj5muByewRjUYPeG/2TcH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uaojOTGl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7895FC4CEEB;
	Wed, 25 Jun 2025 14:07:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750860444;
	bh=yjwndwg+z+r9DxxCqP85NTyoloO+NYAhjaUk5zz30ec=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uaojOTGlhacxkc+iKdHv1GkNq54c3YMHR2HD+3HqOEAKe89TZVofBcVck0J3/SxsT
	 gnhpDWKcZ38koxxjSBw0GsQttAEd5XknlFjBhz0DnS9hk2kuh95qY8jjuxfZZa6xQu
	 FzrLfOqZGQ6TbfB/wxla6QhXepDDd3DdRi3QgYiaQymIt+YtcQXOCF9XY87NfT9frN
	 OYuM/mVAPzsoUPC1D3YTmfr3LN1lXqS5jZ3JBTj9PMSu3QUZO9LyM4zNbcMbYMpOkB
	 /S93nfjb9NHUp8xr2bTBX9HA2IPr5jd5SMji9s8hLQYrZ4qJ3vxSP84BDUwF/tk8wo
	 9aDOEC/ZGdImA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Larry Bassel <larry.bassel@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.4.y] btrfs: don't abort filesystem when attempting to snapshot deleted subvolume
Date: Wed, 25 Jun 2025 10:07:23 -0400
Message-Id: <20250624213237-d32dd2bd102e09d7@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250623220816.51405-1-larry.bassel@oracle.com>
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

The upstream commit SHA1 provided is correct: 7081929ab2572920e94d70be3d332e5c9f97095a

WARNING: Author mismatch between patch and upstream commit:
Backport author: Larry Bassel<larry.bassel@oracle.com>
Commit author: Omar Sandoval<osandov@fb.com>

Status in newer kernel trees:
6.15.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: ec794a752819)
6.1.y | Present (different SHA1: 6e6bca99e8d8)
5.15.y | Present (different SHA1: 0877497dc978)
5.10.y | Present (different SHA1: 2bdf872bcfe6)

Note: The patch differs from the upstream commit:
---
1:  7081929ab2572 < -:  ------------- btrfs: don't abort filesystem when attempting to snapshot deleted subvolume
-:  ------------- > 1:  db0e7a8388dcf btrfs: don't abort filesystem when attempting to snapshot deleted subvolume
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.4.y        |  Success    |  Success   |

