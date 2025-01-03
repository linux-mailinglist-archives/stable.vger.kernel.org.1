Return-Path: <stable+bounces-106707-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8813A00AE6
	for <lists+stable@lfdr.de>; Fri,  3 Jan 2025 15:55:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B49018844D2
	for <lists+stable@lfdr.de>; Fri,  3 Jan 2025 14:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD4871FA851;
	Fri,  3 Jan 2025 14:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="afcE1Vk3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB2F1F9F73
	for <stable@vger.kernel.org>; Fri,  3 Jan 2025 14:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735916122; cv=none; b=HEo9j+VOt5QzXn/MEqG7I3U0poNsdh90r5rDMRebMdfsyMi+osL0mxBwyCSDXbEEDtWlXr7oT1ARoThuq1PpAWu/n6eF3fXbRDAE09W6M5gbmzpL61NEk3/RS7uHD4HlxrCdUOJQcZmvlFzVX/lDqwqFxzKkSTwSFBNitemMzrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735916122; c=relaxed/simple;
	bh=BoGLrOYq6/nV+o1Kd3cGdqhPSL2N27iTx2Ojof1OVp4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=R6omoX6R4nRZEZaSYfMTmJ4+3/mgsuKkBeZUN8OT7baHM4xhY4WI50Py/mGtbZUy3L5Eu+rAdHKfI9I2xUnXBBeloGAeuq2oZVVb9QZdNgHbQUsZOeKEcAiZ75CznDH5Gn9huslKYP8rS8cdMorqnbzMlbMwBhtCzoTP78C32TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=afcE1Vk3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97A5EC4CECE;
	Fri,  3 Jan 2025 14:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735916122;
	bh=BoGLrOYq6/nV+o1Kd3cGdqhPSL2N27iTx2Ojof1OVp4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=afcE1Vk3GPX6YPANf8TBOxR6In4uAcDfU3ezYWFpS2xaAYuKNjTMFbEftfcxJ2hPg
	 vr/kfOfTqVqDUGhf29sFIQxBtZH8FsSMIcfy26+MwyoBUxUBjMbtIcr7yRxQOVzu97
	 IQHTVUj9Ov8ZNvJvDqkudA5nTOFIx6NbyP/mttFIbV6hDXRA1ju15+kGqI9VD9ss3U
	 b8neGPZZIX66nQhowuGvNED8bwptkKNV3jKIINF3lrDXioUL3zPryGmW2Rwdpn9CXM
	 05Z2+rfBp/V92hoZ3LmiWPMLIL0rVwyqsS4GKfF55li+gnEQGzcpfzPqSd4BfxUmm0
	 XlAouuFe1sT3w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: jianqi.ren.cn@windriver.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y] i3c: master: cdns: Fix use after free vulnerability in cdns_i3c_master Driver Due to Race Condition
Date: Fri,  3 Jan 2025 09:55:20 -0500
Message-Id: <20250103085512-5e390e90e9d6d02b@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250103070420.64714-1-jianqi.ren.cn@windriver.com>
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

The upstream commit SHA1 provided is correct: 609366e7a06d035990df78f1562291c3bf0d4a12

WARNING: Author mismatch between patch and upstream commit:
Backport author: <jianqi.ren.cn@windriver.com>
Commit author: Kaixin Wang<kxwang23@m.fudan.edu.cn>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: ea0256e393e0)
6.1.y | Not found

Note: The patch differs from the upstream commit:
---
Failed to apply patch cleanly.
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Failed     |  N/A       |

