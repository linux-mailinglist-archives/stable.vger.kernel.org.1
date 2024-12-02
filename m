Return-Path: <stable+bounces-96157-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 285FA9E0BD6
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 20:16:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E28F928255F
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 19:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DBCA1DE3C0;
	Mon,  2 Dec 2024 19:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dD6oZDeM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24FB1DE2A0
	for <stable@vger.kernel.org>; Mon,  2 Dec 2024 19:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733166963; cv=none; b=q9O6GjkJD1gd80dF5lbGt5A03iPqwstJwRUHwLbTVxhc68u1RkQm8P5GsQrpYAWA9/aA6QIw51+dt9/722vqG9lAlk2cxyXqZZapVtnyZdxLLCpjMyXGBZbytjknmBSxImi8yxaZKdRuBb8gAMvdajFisKkAWOqzA6Wr7AD9LzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733166963; c=relaxed/simple;
	bh=l7NH6pn0e10ZXjr5p08hMutSQQQkyLTnd1Nlrn40sJc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gbqFxm7ycdoCGFQO2L/y0Oar24lPC5HfFoKZxTQ8cP7k12vvZGGEuEgtOcetFdRZKWkkz1HnVXYTp2ATsv4Vts2dNP7wrWx5A+3CAu+W5lHKeGbHly0nN13OsG4h4k4eyUCQqtB2ofwnz3UZ8wWhZ41hR41s6Vb5Q9Wnn2itu7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dD6oZDeM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F102CC4CED1;
	Mon,  2 Dec 2024 19:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733166962;
	bh=l7NH6pn0e10ZXjr5p08hMutSQQQkyLTnd1Nlrn40sJc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dD6oZDeMh87+D6LD0x3ZyNLVuvX+NIjFCTgbfEqfZinkU8U51bm/Dprc5S/CBzWgw
	 584Yx9wDUdXlc/VE9snEoYfz6YfgB3DYBj1okkO3j/cJgLjgdqyMFgDqCxEdDTh834
	 ujgBWKLZR8IuiYmY2RWvGOab4kGE2y6y1i4Qkc7hSU/gS69ivHvMLo0JUU+GJnJuWn
	 CzvtgimiOzGPVMmqAzPZ535RBtZPtmUwaIrXxSyiA1G4VI6ZZWxmBlCOr/l/TMspUM
	 Od3eyV605WNhHpJrgU6DExl7p/iLF/iabNZ53kt3icGcbTRzXqSDPXe3AlAAAf/eyp
	 UEZf8yjilZR2w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Brennan Lamoreaux <brennan.lamoreaux@broadcom.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH v5.10-v6.1] driver core: bus: Fix double free in driver API bus_register()
Date: Mon,  2 Dec 2024 14:16:00 -0500
Message-ID: <20241202140724-6a2ef98a8a604527@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241202183330.3741233-1-brennan.lamoreaux@broadcom.com>
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

The upstream commit SHA1 provided is correct: bfa54a793ba77ef696755b66f3ac4ed00c7d1248

WARNING: Author mismatch between patch and upstream commit:
Backport author: Brennan Lamoreaux <brennan.lamoreaux@broadcom.com>
Commit author: Zijun Hu <quic_zijuhu@quicinc.com>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.11.y | Present (different SHA1: 9ce15f68abed)
6.6.y | Present (different SHA1: d885c464c250)
6.1.y | Not found

Note: The patch differs from the upstream commit:
---
1:  bfa54a793ba77 < -:  ------------- driver core: bus: Fix double free in driver API bus_register()
-:  ------------- > 1:  488cd01e46650 driver core: bus: Fix double free in driver API bus_register()
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |
| stable/linux-5.10.y       |  Success    |  Success   |

