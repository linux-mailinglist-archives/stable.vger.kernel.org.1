Return-Path: <stable+bounces-121312-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F11CBA55641
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 20:11:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21F2F3A9958
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 19:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C465526E153;
	Thu,  6 Mar 2025 19:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JA9stpCQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8608226D5A7
	for <stable@vger.kernel.org>; Thu,  6 Mar 2025 19:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741288292; cv=none; b=CdnSYoF16i0iyo9g8tyOKPqAko5RmUuZX90JRdfhKQrA6+aMrzL63MI8/9KIRnO31+pzpxtXWbwTvIm91g0WeZa1zHO/Zs/MAPx1zzzm0UcPJFcWaumSfqAeKNY/2iK8rvTbI9m99HOkmSMgmW4Qr6ukUBl2phXXw980myp4fU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741288292; c=relaxed/simple;
	bh=0HDvXsquJe35RxC/4exG6QdLKMdNUeFZF5pNc1hetFI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oqDWwNyQ0qwkF54PgGsbWIFZk8D3GTDDmRErsfDXJozjX89zwvtZe8L9uIwLd4If+O9UjIYmwUSf1JNxjlF6VT/fcm0NRw+Jprjj1KJ7r7FjTRS3CkeSvXgL8w/Wbjw+AxpqyumaIwh3mJM2/2jJ/j1Ll92P88ww5s1KPkimMnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JA9stpCQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8D83C4CEE0;
	Thu,  6 Mar 2025 19:11:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741288292;
	bh=0HDvXsquJe35RxC/4exG6QdLKMdNUeFZF5pNc1hetFI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JA9stpCQ3nz9IS0Eh9JkE8RBUBNrTaYDV+ycS/k69EUhfhLZyFwFfz7hcjhKhAAyC
	 O9R12VPIXwhSHLETw2mYY/PpFHBSZvlwJtSxYwADdU5jH/qjDAMPs9kNATbKYRmTKb
	 wI0yRr5r0kLDN6V5vPfkl24u0FnXi3+O/Zq0DdCkSGVmBQnEJ63AWuu6lpsozkWi+T
	 RRoYJI1Skjd+nxFXgPwnMlXrZd19dlfpojy+ZG+b7QjV/PMpMtmZ4DSe4zhuM9U58Q
	 tTsBYQZNq6ZbtIerL55jpDAo8dJJXXtPfRDjx2nXQ5rRaB/VeX0O51hkIzW0i4STSZ
	 Ji0Kg4/gdPjWQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	sidchintamaneni@gmail.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6.y] iommu/amd: Fixes refcount bug in iommu_v2 driver
Date: Thu,  6 Mar 2025 14:11:30 -0500
Message-Id: <20250306131304-e730dbac2bbe193d@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250306051822.4267-1-sidchintamaneni@gmail.com>
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
⚠️ Could not find matching upstream commit

No upstream commit was identified. Using temporary commit for testing.

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

