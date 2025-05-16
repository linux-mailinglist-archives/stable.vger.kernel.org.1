Return-Path: <stable+bounces-144611-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C029CAB9FA1
	for <lists+stable@lfdr.de>; Fri, 16 May 2025 17:15:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85F2B1702F0
	for <lists+stable@lfdr.de>; Fri, 16 May 2025 15:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C306026AF3;
	Fri, 16 May 2025 15:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RAopw077"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B7619E96A
	for <stable@vger.kernel.org>; Fri, 16 May 2025 15:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747408389; cv=none; b=DlkMTngSyCTb8DUP5+AXgamIFnKfsAkoFB7vrxatw6Kg3ZzJsEht3rKcwki9nsGnQcNWEAIMGjYuILj5PH045Ehwboj2W8kH7xB2YmaTW2DLhacIdQUwALU2R+v/9UX3gRdQ43Heoo+XuNZ6QfpSKVXaTwhwSKfp49NdWFuz9Zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747408389; c=relaxed/simple;
	bh=T9HlE4ie65eWk9SLpdN2zyEhcOFcy2P/XBggxwLNyi8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ViXME5R0lN92UfvvncGx+HvJdB+UviCuWA4sTGevMRhh3DXLDCyFRqbU1Oa68y9SfgNA80/h2Gvw4C2kNYqDqZHfV+o4oRk09145wwEWnOyGkEA0Ky7gR6wlBTDwc9apGPKuhO6LYQFpiy3XmCdSJOQFgG5eGVw+3NL6BPepcHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RAopw077; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8D70C4CEE4;
	Fri, 16 May 2025 15:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747408389;
	bh=T9HlE4ie65eWk9SLpdN2zyEhcOFcy2P/XBggxwLNyi8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RAopw077BG75vAjgtqNEBjEJOBKRsRGArZ7K2DQ4DIW8xgUHLAiS35x6E29uPydru
	 +cht0MguDt7Vo4085IzJmrAlxBdTPc1wETCJDLA51IByc+Vo15vfsiwyDJgJQEAzPi
	 L5SfqpfZHhiOAwd8msN3X/DbsOWzb7R4aCCTuTSLNunY6euNiOq2hk8stlbTcdMbFW
	 5x5rOWhmgNksmFRyWJwN7bcf+sSmjLRXj4Ff1X635S42+9dacPyU2CRW6ajxzXadSb
	 3ku8OV2apduiQ7H8T4pL/IRl1ZFGuArxecggu7ybyXzQ4+SMK1ZEON75yB3mEFVlwQ
	 vyX7befGMrUFw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zhaoyang Li <lizy04@hust.edu.cn>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y] ipv6: Fix potential uninit-value access in __ip6_make_skb()
Date: Fri, 16 May 2025 11:13:07 -0400
Message-Id: <20250515092327-30e6fd9151a0ac4c@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250515055533.408837-1-lizy04@hust.edu.cn>
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

The upstream commit SHA1 provided is correct: 4e13d3a9c25b7080f8a619f961e943fe08c2672c

WARNING: Author mismatch between patch and upstream commit:
Backport author: Zhaoyang Li<lizy04@hust.edu.cn>
Commit author: Shigeru Yoshida<syoshida@redhat.com>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: 68c8ba16ab71)

Note: The patch differs from the upstream commit:
---
1:  4e13d3a9c25b7 < -:  ------------- ipv6: Fix potential uninit-value access in __ip6_make_skb()
-:  ------------- > 1:  aa818515f6643 ipv6: Fix potential uninit-value access in __ip6_make_skb()
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

