Return-Path: <stable+bounces-104111-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CBEFA9F108A
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 16:13:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C33981638B1
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 15:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 461061E22E8;
	Fri, 13 Dec 2024 15:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UL2CdA3x"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 056DD1E2009
	for <stable@vger.kernel.org>; Fri, 13 Dec 2024 15:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734102786; cv=none; b=EF4aN72Pi7uE5TmB+BGxVlpIXUwOPgUYwOvgwKBiTMXQ1IEL+nWxAgaLd7Oz4JIOoIKDSHkwCCSwyyfKBIWkmidUZuPnH3PZQZCxnCQS1VayzVqkbNkJBmg3lzGuz3NB9TCDGUYhlvVDkhSXqFJBt5T0Jp+iDZ1c+nsclTQ7uj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734102786; c=relaxed/simple;
	bh=MP8FpX1vrbHfr5LxOoVYefKH23ZRSyM5Hywyn+3Y4bk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GIiT/PnqnY2m1gUSuziL2Zo+qDVbsaniBtlLJAxCQxTEod91A+1phllvMtRJNN/sZXsl52d0DZlIk3HgVOG1imYolW3b/lg97d0SY3MLznTPxTa5LOmTd0iZBAUJ6j4axZxKCuUeJIUH8tHNfkleDTW6UqNRrwErBog4dhQy5qI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UL2CdA3x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D346C4CED0;
	Fri, 13 Dec 2024 15:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734102785;
	bh=MP8FpX1vrbHfr5LxOoVYefKH23ZRSyM5Hywyn+3Y4bk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UL2CdA3xOxzGEEbE6m++5+C6XGkpP+sQuF8flbuI0BDcniOgSIauLo4krLtCzqwZ+
	 /3155Pn0VhoItFczhVit2XUBQNmgZps3HVzIOB99SoV58tnCURgVHfM41rsZyD4mE0
	 PwJ2WD9EH2taHh7Fh9joVzKMWoWmBHmCGDC7JatBkBp2vKUk/3g55PUwEBDSIEIOOc
	 2dfFFQVJXt8dhmc2gvFcjuO7j7jO8yL+ePb3ERMb77FJAWffo2qfKLpQFHoImNxhbB
	 lfRh73bkzNcKu/vQ4AJpVfflYVvzimFIllmTmebCNGzR7VQ7Oez8f0RYYtHxsVmRCF
	 EEQ2u2GRVjh7g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Tomas Krcka <tomas.krcka@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15.y 5.10.y] virtio/vsock: Fix accept_queue memory leak
Date: Fri, 13 Dec 2024 10:13:03 -0500
Message-ID: <20241213094346-ee914ed559696b17@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241213104357.15964-1-krckatom@amazon.de>
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

The upstream commit SHA1 provided is correct: d7b0ff5a866724c3ad21f2628c22a63336deec3f

WARNING: Author mismatch between patch and upstream commit:
Backport author: Tomas Krcka <tomas.krcka@gmail.com>
Commit author: Michal Luczaj <mhal@rbox.co>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: 897617a413e0)
6.1.y | Present (different SHA1: 946c7600fa22)
5.15.y | Not found

Note: The patch differs from the upstream commit:
---
1:  d7b0ff5a86672 < -:  ------------- virtio/vsock: Fix accept_queue memory leak
-:  ------------- > 1:  1ced3c5ad58cf virtio/vsock: Fix accept_queue memory leak
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.15.y       |  Success    |  Success   |
| stable/linux-5.10.y       |  Success    |  Success   |

