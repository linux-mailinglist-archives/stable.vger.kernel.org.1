Return-Path: <stable+bounces-166896-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEFF2B1F14E
	for <lists+stable@lfdr.de>; Sat,  9 Aug 2025 01:27:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFF7B177BF5
	for <lists+stable@lfdr.de>; Fri,  8 Aug 2025 23:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FBBC28B519;
	Fri,  8 Aug 2025 23:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jL6DM+f0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D22528B3F6;
	Fri,  8 Aug 2025 23:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754695615; cv=none; b=pnwiBY3g/R415BJ8TDrBRYCbp7LBthuRHeUSwJ5FKYyu4gcuuvZfy9uKmdvMw0UF3nrmbPtiN6AVUuT4sRmyfuIEAdUugYs4SNF5QxCN/fhz2zyhNxeqcdex9AgFIwDb77MVv60D6xdkfI6zVSeRTH0mM7AX4UwQJNV8e8SGeJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754695615; c=relaxed/simple;
	bh=KFBtPZD28zjWCeCW3N/MBJ1COAMg+BR6ai4xLjQzuBo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Td7PsSU4htBG5+iqUu2EljDA4kFJ7fA8+j6AFaknpYJV4xcBnKtO8xvJ02kUsqwsBJzrPVWYcNQiaOnw2pMAyGT57HjOyCQ4BmQRrw1Fa83v2aFrSXgLM+FOnMXxUB6CGpfkvf2Ssjrw0R8/s6vhygCc5lRUMD3gaj02nvruPIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jL6DM+f0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93C85C4CEF7;
	Fri,  8 Aug 2025 23:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754695614;
	bh=KFBtPZD28zjWCeCW3N/MBJ1COAMg+BR6ai4xLjQzuBo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jL6DM+f0wSE4G5Z0slaEH/nY8VWhi58k6Q6ZdDasfPklTv20tv5Q2a4RRU+WqbOUf
	 10kWAHGgHLvfzrBebWtvknmLTCW4RrxZokronUH2adSF+oZMsaR6i32khxeumK0BNY
	 A/l70J/jSdLGhpZs0UJ5MHp8v80DaGbaFGXfYawB4YHjZtZXnMLuHkMk1PVBecmNTI
	 2FjwsgJYtJNyWa4Mp8CAQ+MPTI7IEPhLw6/VvemwxUmAwniBXbFW1SOo4IvKNIjDn0
	 cD08vi4+ZOvhFAPoH9/Wa5jr8GoSAEmOtKdj3qWn7VcTxvnY5+dfqbRGVjX18fugrl
	 A5HctDdvVOPpA==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: Sang-Heon Jeon <ekffu200098@gmail.com>,
	honggyu.kim@sk.com,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	stable@vger.kernel.org
Subject: Re: [PATCH 2/2] mm/damon/core : fix commit_ops_filters by using correct nth function
Date: Fri,  8 Aug 2025 16:26:51 -0700
Message-Id: <20250808232651.51186-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250808220815.49644-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Forgot saying this, sorry.  Please update the subject to not have a space
before ':', for consistency.


Thanks,
SJ

[...]

