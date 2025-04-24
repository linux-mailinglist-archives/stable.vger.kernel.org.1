Return-Path: <stable+bounces-136585-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F17DA9AEEA
	for <lists+stable@lfdr.de>; Thu, 24 Apr 2025 15:26:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56B171B601E6
	for <lists+stable@lfdr.de>; Thu, 24 Apr 2025 13:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5402E27BF99;
	Thu, 24 Apr 2025 13:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o0DwhFFO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12BE93B7A8
	for <stable@vger.kernel.org>; Thu, 24 Apr 2025 13:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745501165; cv=none; b=Xv1iouWYj04vhlYeqmsBosysHDdCmCq1hxIQuJjADG+1AfCpEGFOlIOdfVyWk0dGyDQmhazilHJCMPVWi7V/c9kMw/QovU0FTrJJ5TDkCcoNYsWp8XVjbS/ymNx4tBeE2kX7SbJfVSDnu4T2r6E+jrVPSn/wh1MG46CCpI/ID70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745501165; c=relaxed/simple;
	bh=j6kww5tyNbvIYznXTIP+QFwbp+bR8reymAgxTrZnqAw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Eby2x2RCvFAyagiZZbUpSJgiW0xWzY1qby6K84ku3zaTLgEIYATuTHE5OlU48ypNjOo2qall6Xd16ogEv0lfYqz7F0lv+lH4WM1nhJJCAx5F16VoY2pYUYPCyCuDWQFVS8cAdg6hpaD+LETmmbe4U2Ln0kT3FDU/+Q+WqNOQ5pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o0DwhFFO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF9D6C4CEE3;
	Thu, 24 Apr 2025 13:26:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745501164;
	bh=j6kww5tyNbvIYznXTIP+QFwbp+bR8reymAgxTrZnqAw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o0DwhFFOqMzEIfBRCduwPocBkI1NualA7Gilky2jM/lIkrrS9H603h3VEYronlcQS
	 3/pzd3sfsJv74CezqzJ4mHr5IifjXqIkS80kfHcvRswvAW0pzAK6TnlukdrYdv8kBK
	 xj3DoezE0vHci0S+rt/EVHcoH3vWka0OoolsvNuIbTCTNjPabukERlmC+CzsUk01B5
	 ai7GLsuagfMkdqSY7bQ12K00Gcq6ZsgfpdAf5YFXJ+/shspAqkwJmwY6Qznp3ccj2H
	 meGLNBlGszPhTH8yE0Dy27Xzg+89DEnoi1Jfad4YDaxwc3GWYV3/9hI//tLL0YXS3s
	 dGd+IAc0zzqlg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	pimenoveu12@gmail.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10/5.15/6.1] netfilter: ipt_CLUSTERIP: change mutex location
Date: Thu, 24 Apr 2025 09:26:02 -0400
Message-Id: <20250424004755-52bf1c86af877bf0@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250423181245.14794-1-pimenoveu12@gmail.com>
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
| stable/linux-5.10.y       |  Success    |  Success   |
| stable/linux-5.15.y       |  Success    |  Success   |
| stable/linux-6.1.y        |  Success    |  Success   |

