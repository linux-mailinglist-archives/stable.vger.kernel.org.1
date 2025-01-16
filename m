Return-Path: <stable+bounces-109196-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97727A12FA9
	for <lists+stable@lfdr.de>; Thu, 16 Jan 2025 01:26:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD0BB163B89
	for <lists+stable@lfdr.de>; Thu, 16 Jan 2025 00:26:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D9668F6E;
	Thu, 16 Jan 2025 00:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cQarpw31"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD7479EA
	for <stable@vger.kernel.org>; Thu, 16 Jan 2025 00:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736987163; cv=none; b=ASII7vkyEWhhS8Fo1PqP9k4/BPyRy9T5JViMDkj5oqHZyh3kqq6kbBjHrvCsJxsTDGBJUE1h8/rjTaVNCdz4l4NFc1bn6gdANZysOG6snk7r6gxuEfJwu8w4+lHEcGyo/NoCcl+Xj2ZZjDOHsoDbYZeTvOVPmnFsKoZeinw8WqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736987163; c=relaxed/simple;
	bh=WfV3Jso+sLZLFfF3Ui1yCgxVJmuzjPQWKs0MP8BQN60=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=t9JnmISU4CEpsQywnaEwTNYZIEz6gRMRZRyOiQx9mEm6kbfk1vEP7Pk1J9+fLRk3EXBGdkqOxLjnq284scOPe7xli4edKMWjGhxbCow67GfE80WWi7xNkU8eJL36tZnKk6gEL6vydPEG+6r1Va899aThSAXwkI7tMB9KXWRJpN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cQarpw31; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 949D9C4CED1;
	Thu, 16 Jan 2025 00:26:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736987163;
	bh=WfV3Jso+sLZLFfF3Ui1yCgxVJmuzjPQWKs0MP8BQN60=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cQarpw31aoEjBHuqNNzHPVVtQCuDX70yPoFeUWLGEFyxR/RiqtOXN9FUzrQTGPImh
	 4Empbb2hd+5L2UIxOhaFdfJFZaWbv0CdANBgkee+gloqrAdEtlT5mqTb5/cd+FoTa8
	 GL5fScvDecBqdfd4F3McwsvzI0ut43L6F55hOQKOyZpwieL3mkiP9goAC1jl/hgc/z
	 QotmTFtrHYAvJkEuePXmqF6jz8kWN3qLZS1Zxgpw71U2Q4OqCnn5vsVD/k6PeDKpAu
	 HVtzhYHM9osUoR82DFcU8oxgscbPaXND/cHcLKrO/Q1Tv9GAjpmOtXgUhk6o7eajtm
	 1aSdPlrYuBy4w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Tzung-Bi Shih <tzungbi@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15.y] regmap: fix wrong backport
Date: Wed, 15 Jan 2025 19:25:58 -0500
Message-Id: <20250115154132-527c137ff50f5752@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250115033314.2540588-1-tzungbi@kernel.org>
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

No upstream commit was identified. Using temporary commit for testing.

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.15.y       |  Success    |  Success   |

