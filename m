Return-Path: <stable+bounces-100657-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27ABF9ED1E6
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 17:32:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92E8E283E4D
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 16:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43A871B6CF3;
	Wed, 11 Dec 2024 16:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EISMurxp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 047F438DE9
	for <stable@vger.kernel.org>; Wed, 11 Dec 2024 16:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733934757; cv=none; b=ZHmBTkjFvnlDmN4QKic/FY+a+ous3M+CQCvsXucl1+4hWZ/svkyUi6szRCTZf0sWlRiTBkRCzriew187sNqfuoMpB3fabM0iy85tLuFoEhlNcyJrbKuSftD+gYrP23ejzFh79+izdx77gizPY1/+d7MvuSkIbDJDSrUrJObJZC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733934757; c=relaxed/simple;
	bh=tMGpXT/Kc233mzoFZLRAd7T6G/Egbj2Flom+T0PFbaQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WxbefTStdkvUFEpI0aGpR00fD8BehyPhsfHJP4Ta73ArYFtELdssYpZNt3En4dLHuQRqnfvEzRAdLCvV/sKKhBGVVgMFz7PWhqZRky0EH+v/q0mxOnFdueMPjeSpwKMSEzRCGYyMM7dTd+s4DYNbbIBJ9VrFiJ4+O1oWMrPyb8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EISMurxp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1501BC4CED2;
	Wed, 11 Dec 2024 16:32:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733934756;
	bh=tMGpXT/Kc233mzoFZLRAd7T6G/Egbj2Flom+T0PFbaQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EISMurxpyhyK0HMPyH+KfjbZFjlum3ZP9AdsWmdpGWYUygkUBJeANATzdyxwMReeV
	 WOhJGLzdEzKTMsvE05aTSDyOMhpNRzBmQ/JXCkwfF6+cmOi8lVFieadgUwo0TlJX2v
	 E+Raj6ooXVz6APS0gAo0rj6m+yO/JthP5Rxt9nth8RJgOcQNJQo0CkxQJgd9Gjbba7
	 lemS+m+8qG0BSNeNVqeDLYyCM/pteoCcKzIryfEbf/E4nkyeUx09511LYyesZj+QK3
	 tljtfE+B22+wnQe7r+EeIt2xgI+CrIB/vQSvqXKUUXoxVZbo91qe1CwFAQjkk3W0s4
	 +oxq/H3xdS51A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Hui Wang <hui.wang@canonical.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [stable-kernel][5.15.y][PATCH 4/5] serial: sc16is7xx: remove unused line structure member
Date: Wed, 11 Dec 2024 11:32:34 -0500
Message-ID: <20241211110609-db4e9246fc623d66@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241211042545.202482-5-hui.wang@canonical.com>
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

The upstream commit SHA1 provided is correct: 41a308cbedb2a68a6831f0f2e992e296c4b8aff0

WARNING: Author mismatch between patch and upstream commit:
Backport author: Hui Wang <hui.wang@canonical.com>
Commit author: Hugo Villeneuve <hvilleneuve@dimonoff.com>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: 2f6ae16a5874)
6.1.y | Present (different SHA1: f6c58552a8d9)
5.15.y | Not found

Note: The patch differs from the upstream commit:
---
Failed to apply patch cleanly, falling back to interdiff...
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.15.y       |  Success    |  Success   |

