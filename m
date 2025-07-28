Return-Path: <stable+bounces-164963-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82175B13D01
	for <lists+stable@lfdr.de>; Mon, 28 Jul 2025 16:24:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD75C3A5364
	for <lists+stable@lfdr.de>; Mon, 28 Jul 2025 14:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1121126B76D;
	Mon, 28 Jul 2025 14:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sSUmMjYd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6E0E26B0BC
	for <stable@vger.kernel.org>; Mon, 28 Jul 2025 14:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753712429; cv=none; b=oDIJar7VqBTJ9dOZZdT5Qe3CpbCvwJQ/esjYQlX1KHkAgScmQw2Ud1UIe3vS/2aW17pPBSaAQCLXuEE4tJ0L2gVCudqmPDwKSscewgPZ9vHAaqlfDH+l6i8UuMUZDIRvWzT68f0+4OXgChoVEQMMyAXr8QS97DtNfU+1Wldd5ZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753712429; c=relaxed/simple;
	bh=RmdGIvcF/hleP1EA7oHdV3uZEGotLFRb16Tp5OPq3iU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZLlZHeZZpwMw666iZGdcuibJLv+iYGWHOGGfM1Jz+54i2hQ9pZBidxibk8df7HMIqSeZe4O3c/YW+QJmzt/zTCCJ+JERI+ufvRYIgywMMIKGHkq30tNwJJLNtmYNehbsiEyOkRtuv6rLYWczourxmHjnygdXyOacet7qN0aBuxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sSUmMjYd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A032AC4CEE7;
	Mon, 28 Jul 2025 14:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753712429;
	bh=RmdGIvcF/hleP1EA7oHdV3uZEGotLFRb16Tp5OPq3iU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sSUmMjYdOdYjmvhwDg1qpbTSmrrgjuHiXKNDJ7pzQ5hbTXYc4mB6htNYo9YEc1q4k
	 ywPidjgD2YEK7t8AurHikafCCcLb8qtSCr/kzj2UG11oWV80A9ts3SPqqn8JSE0UdH
	 U3V/IFRQdbkZOk13421CEoObVzM1KzBTWE2vRIsPxJjKgl/RjHTZXuAn82gyvn4JHp
	 kenrNJMlGpSBiTetEsFFc0LtFL1PV8W3ETj75tjiTwJM7yDIkaeNaMgHyg3ETdS6gy
	 +UGqlKf9+wzCNs8uBJ4uKdG19bdp4KPITd6dK9FDHSEsk6f+oMeU+dAzpLsX5M8fff
	 tJKB2jKU/+bfg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	chenridong@huaweicloud.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6] arm64: kaslr: fix nokaslr cmdline parsing
Date: Mon, 28 Jul 2025 10:20:26 -0400
Message-Id: <1753711580-06838f1c@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250728124644.63207-1-chenridong@huaweicloud.com>
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
| origin/linux-6.6.y        | Success     | Success    |

