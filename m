Return-Path: <stable+bounces-126011-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B90DCA6F41C
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 12:33:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 589C91891988
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 11:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0625C255E58;
	Tue, 25 Mar 2025 11:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SbBMxOUy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB872255E51
	for <stable@vger.kernel.org>; Tue, 25 Mar 2025 11:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742902402; cv=none; b=TmJfInB4Z0pqJoXnnyMiVMRKuUEJCxhviTnb+2X7EpnnS4bwroWF5MLFiBVH8cStw2FIwNjTRPgBYztRGtTHN5/LVXmOfqvRgzzCWarTjsuuu2/aKO7gyE5Vl1Wq2Q2c90SsY8VVAzcYKqbExlpRf5MTJAdLPyx07v2CpoONqEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742902402; c=relaxed/simple;
	bh=F1R5fIBjLEVOw0K8LCtdzq/yHNqsYaFxWD59c+iBF44=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pxoK7zY8rkCE8Dt78W4VuxdEjplRCaer08rey44hyNp3OeNZOxQtCe3nmOuEcXb7hIVvBk3eYhzyxcJXb6VP27QDRynY1lj5TKtz1wccfkALP9hcBUVt7lCJgcVL6bWPU+SRGTw1osBjxUaXVTvRyf4S65Z1XUgNseI97h3RGAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SbBMxOUy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27A65C4CEE4;
	Tue, 25 Mar 2025 11:33:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742902402;
	bh=F1R5fIBjLEVOw0K8LCtdzq/yHNqsYaFxWD59c+iBF44=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SbBMxOUy9nTvTKuUYNYSQFwD0InEkMvYq2Tj0y3LgnjvGOv1d4AS/f4PJMyQGLD8l
	 tLhv/HvX4DCfDD4liyUYDEsGeL8CFAyfZogOUnIGQoGG6KsXDpgClxO1nPfGx/n4A+
	 YM7xzletww4as9WDZ0pqDsw5s0dMCFBPnJbTEFnr+zjBQPp8DWvxzcLn59gU49Sonu
	 2lkFdSkTyeHBrlCBMJjsKkxNNbPC8NisdPnlAuxmoC29PUCCmtK6HSCSRwE5m1WqvI
	 uQvG5eJZEMgGpjKmww+Ybj2a+9IESn+9kvRFbxSwZnDEm3PgsMs8lhA/Uj3QIzYtAz
	 F+f8KB1acD9QA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	laoar.shao@gmail.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y] Revert "xfs: Support large folios"
Date: Tue, 25 Mar 2025 07:33:20 -0400
Message-Id: <20250324215044-8c26b9b33cdf7f2b@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250324030231.14056-1-laoar.shao@gmail.com>
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
| stable/linux-6.1.y        |  Success    |  Success   |

