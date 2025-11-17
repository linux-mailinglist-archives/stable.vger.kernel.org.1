Return-Path: <stable+bounces-194927-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A7A72C62517
	for <lists+stable@lfdr.de>; Mon, 17 Nov 2025 05:29:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 586E324181
	for <lists+stable@lfdr.de>; Mon, 17 Nov 2025 04:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7619F3115B1;
	Mon, 17 Nov 2025 04:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wj/HPctG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32642259CBF
	for <stable@vger.kernel.org>; Mon, 17 Nov 2025 04:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763353782; cv=none; b=t2KkRqsRKLPBNOBL5vBwt2Vw4+2aPLGmt0IO8m1HJgqtXrP+vl6U26FV9uZNNJc5nMH7bwQoZr95nv+JfP7VmJUxrzkrWzGnbDLdzwLt1aFWqml+rhP/JDtfaE2Vx8l5T2RsNRvv8pimn7iWaMriNyIG70AInYHEggW0Ww00xuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763353782; c=relaxed/simple;
	bh=IgtNq0pKYkB8jnTqWN+sKkEaO9+QKgWyFTl4jpQf4tc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VBG6MrvKUUMRJlyi8y7LJiJtc7YobPxtHmR1Sue4UW0Efl+2ZZafuVsvDGQM0txSFDDiBh2ss9SJcaioNa1AY5oj4LrnuaqjZjU8b/0KjSG/SOrgef8oR86ed48kBMgxcuEHRXMzCFUVAJKlcLt3+9COlXtg9tEZaZBAYW4MRrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wj/HPctG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD445C19423;
	Mon, 17 Nov 2025 04:29:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763353781;
	bh=IgtNq0pKYkB8jnTqWN+sKkEaO9+QKgWyFTl4jpQf4tc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Wj/HPctGw43DnvtKKQVd5rWtRxEEdRVTOPnRdcriFaapNutzqYhY+CLNTMhnpoTCV
	 3WZ4RHOgBI6yRCYoVmf7VS4WrBltdPNL94HX8EyTdF89R0o5OZPWxgCMQ2JFo5dnwC
	 21RjLY/r3kx/cwAoWiecwjDarq/G9pTCstT8ZuxE29zAOBRaN4QiE7ihDIjetOL+VB
	 KCNuytG/hQvk86BdD91n7+n2oWBF9lCWWpWxX6xnqJyPk0weX1E9rpABQgqYKuzK2Y
	 xvlXCJevq/0a6tEbaaYRgifWFUB6swiR6ciUbqNPZQH4euvEzxHu9sZ76ZSj5/v8Oy
	 0HxOPWWxGgZPw==
From: Sasha Levin <sashal@kernel.org>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: gregkh@linuxfoundation.org,
	stable@vger.kernel.org,
	Simon Horman <horms@kernel.org>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Ruohan Lan <ruohanlan@aliyun.com>
Subject: Re: [PATCH 6.1.y] espintcp: fix skb leaks
Date: Sun, 16 Nov 2025 23:29:39 -0500
Message-ID: <20251117042939.3770333-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251109123915.789-1-ruohanlan@aliyun.com>
References: <20251109123915.789-1-ruohanlan@aliyun.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Subject: espintcp: fix skb leaks

Thanks!

