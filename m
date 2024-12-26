Return-Path: <stable+bounces-106145-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B13619FCBE9
	for <lists+stable@lfdr.de>; Thu, 26 Dec 2024 17:44:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40070161367
	for <lists+stable@lfdr.de>; Thu, 26 Dec 2024 16:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB75E4D599;
	Thu, 26 Dec 2024 16:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MNwtXjrW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ABAF2CCC0
	for <stable@vger.kernel.org>; Thu, 26 Dec 2024 16:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735231461; cv=none; b=WcKlBT8fhN6/OcwBrLkM1Hq6vIH2Wvnt/bmbFYic6oue0zGIfQBz6Wca34UIaIoC9P+sJSDXp9/TmiQar9tQMTRdOrNWmh7I18uIgXDDzPJ0kQZVB7ZhOlDzQ/oqvPANNJc0GhgNvRckSTMbgDAa0JioXtJgg+RJGzctTTSn6Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735231461; c=relaxed/simple;
	bh=aF31gJLWCfgxx3punoxaR42EUAKFWOSH2xz5Kw0umR0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lfYfyIS2tG7mhxwe4aETojrDthMxp6yGNr8sIkwJwFSVa+fY9hqYjMFS8YUBXRxEo/TgLbS87B7mY82999EMTcAiT/Mkre2/1hfCg9yVt+cEu2499e4qJOIQidJbIcld5QG34bc3n9ReDH9LWdhai+czs/ZQRUEInmRouw3nj+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MNwtXjrW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A1D5C4CED1;
	Thu, 26 Dec 2024 16:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735231460;
	bh=aF31gJLWCfgxx3punoxaR42EUAKFWOSH2xz5Kw0umR0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MNwtXjrWHS+9+BFfSN109nx5I3ZDuqA79xhUfX0f4SMr2FXpVzJ8Cj+JglHrS2g1n
	 GW1986xr0HTxN4tjxQnaxOEZDu+sx8hqS6+0HUHgdnf60vFp0yDY5Kx17+pQmC530u
	 Sgezj7iRThkBoTFWXwZQJqJq0GivKb8aGUW/WRDB32v9pw55kFZjo80OpoH3UplX4H
	 4R49kyN7g4pWeIAJANrS50fHLeHfq9go+zkHnQE+5mWv1KYEUpGYm70ve1hzd/ytLl
	 zlYOO2vr3tCwcNYO4Y/Rx9enh24kHQenX3fZIfE6CQHK9+xZLjnrfLIEQ50YxnykaS
	 1kwMoZkNmJQ6A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "d . privalov" <d.privalov@omp.ru>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10/5.15 1/1] smb: client: fix use-after-free bug in cifs_debug_data_proc_show()
Date: Thu, 26 Dec 2024 11:44:19 -0500
Message-Id: <20241226093654-fb4c5402fba4e46e@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20241226092516.43194-1-d.privalov@omp.ru>
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

The upstream commit SHA1 provided is correct: d328c09ee9f15ee5a26431f5aad7c9239fa85e62

WARNING: Author mismatch between patch and upstream commit:
Backport author: d.privalov <d.privalov@omp.ru>
Commit author: Paulo Alcantara <pc@manguebit.com>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: 0ab6f842452c)
6.1.y | Present (different SHA1: 558817597d5f)
5.15.y | Not found

Note: The patch differs from the upstream commit:
---
Failed to apply patch cleanly, falling back to interdiff...
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.15.y       |  Failed     |  N/A       |
| stable/linux-5.10.y       |  Success    |  Success   |

