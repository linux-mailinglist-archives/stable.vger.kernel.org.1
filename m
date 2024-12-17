Return-Path: <stable+bounces-104487-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B21A39F4B53
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 13:55:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7560D18896A2
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 12:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3E7D1F37DE;
	Tue, 17 Dec 2024 12:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aWMUGakz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D9B1F03DE
	for <stable@vger.kernel.org>; Tue, 17 Dec 2024 12:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734440131; cv=none; b=Y35/pjg8Gk9HDBJYQc6iplQ7jYxZDlh9LwpH/+NWnoeWvyBhAkFp8U+XC5y44LFUELZxOBHdx2sHHJ4Wi/DZ0ukKgH8OeGpVmf9lAeuyVZ8kOzo19x8n/TKiYeD0LlUM2fs18+eboMNXZidaWkDTZrBR+tFTZgjSq/bwX1d7lcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734440131; c=relaxed/simple;
	bh=3gZbILM0RkhDMy2craYdZuen2po2j3Jypswf2Ll1gqs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Y4cHA7H7GImZ/TXJhlDHmjyIAlLRLn8YV4/3Ptpdpv7Yt5oGSKo9x2+YtYzdG99bmPyPYjICrLbZaUGenqdxJ0vq7aMDP29n0JjW60oyDDkdLDqdQpWFfuOnXccIKnfvFYfmVBNmYXZC2hCMUzbhHGXl+7aS1xya6aPBdQ+AH44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aWMUGakz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6660C4CED3;
	Tue, 17 Dec 2024 12:55:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734440131;
	bh=3gZbILM0RkhDMy2craYdZuen2po2j3Jypswf2Ll1gqs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aWMUGakzCQ4SGE/bvjX2K2QjqkDw85Jln8XKzYAdSJpQB2LhBHltbGG7tpGZJnTQm
	 I8cT4WSWxfBZLpzijCXJC2cU3e9L0SVLihqc6HtSjOq6ivmzAkNuJRevT8bBAZ5jun
	 YaFVFFhv3Bw7oEsTpkbwGbG6ZBCMvm8XRWTk8aX4WDFxqBf200nKJfyur5fjFGK8C7
	 U6SGrz5sGMGbV88e43rSG63QrG/jsRg1OR5D+/XUbUtRN9512YtEQnHosryxPoKbvX
	 4MqTJP7Lp9Xl6dqTzW1KSgrRNEbhoNhfxaSvp/fWIyvtzr7X1sS7K/1vgY5pHDqObZ
	 1sQsGAQSbs0vQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH stable 6.6 v2 2/2] selftests/bpf: remove use of __xlated()
Date: Tue, 17 Dec 2024 07:55:29 -0500
Message-Id: <20241217071503-a3de6d2a788ad18f@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20241217072821.43545-3-shung-hsi.yu@suse.com>
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
| stable/linux-6.6.y        |  Success    |  Success   |

