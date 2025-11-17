Return-Path: <stable+bounces-194890-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C569BC61F5A
	for <lists+stable@lfdr.de>; Mon, 17 Nov 2025 01:41:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3E33935172D
	for <lists+stable@lfdr.de>; Mon, 17 Nov 2025 00:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88EF4188735;
	Mon, 17 Nov 2025 00:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JGSc9hS7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D3E16F288
	for <stable@vger.kernel.org>; Mon, 17 Nov 2025 00:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763340077; cv=none; b=kuSl74dlVOUfwIbJcqm4QCE/3QdBd/zbmG/Y/A0uOVscYdn22qqPBU+S41X2xUmAiXbBxVF0PrDm50RBj9AJvLrv2gq3YwpyVxa01rxVQ+vuj92NMkB/J11X3ilUjIn4x0ZnMu6LIFfK5pFD61uxmXJaYvQJHo4NsP5lLd6ZB3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763340077; c=relaxed/simple;
	bh=IgtNq0pKYkB8jnTqWN+sKkEaO9+QKgWyFTl4jpQf4tc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IRAiOf6rcrZ70O01tv8X5jk0SMf0eyKrW/cFMYhZpFo9VSy6KTaVea7nyWsKd/Z8FpJZQ4swoBBCirzIdtG+I7qrpomXSPDBjVwr7an0NuwsEZ2lig5NcHajcdBG2+eiNUwBfdOxjbKpNuO66kWaa1RAlJG/yGdTX9Lop47b68w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JGSc9hS7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E67AFC4AF09;
	Mon, 17 Nov 2025 00:41:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763340075;
	bh=IgtNq0pKYkB8jnTqWN+sKkEaO9+QKgWyFTl4jpQf4tc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JGSc9hS75bkQwWKyTouzID2p5L4kDqH/GbzB12UKi9J2c0GUsMNgo3pPCpozVRJ3u
	 D7sj5tx4+x6KVY/Zy1sqUolYyUaB6r0am/ACtjjLRhWWAKZHj8Uqi0q4ewc95kGbik
	 jXGs2QZx/ZuZZBtQPJgJkXJ9m8Qps9rRMSNbafvjWuokgcyX21Qb2OIGmSYw0BrMEc
	 tNClMGZq6ia/LCx4X/0kVisBZ4WFFxh8eeRoV1B8X2kA0aAvMtM7+srXxSAVBAZh4F
	 shTyOrphhcXLgPbslLxd0H5JfWQVxVgXLpvrm6EQHSrn9KTKDpaSTE/0Uq4RIT4g1+
	 H5COWeQZxmcdg==
From: Sasha Levin <sashal@kernel.org>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: gregkh@linuxfoundation.org,
	stable@vger.kernel.org,
	Simon Horman <horms@kernel.org>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Ruohan Lan <ruohanlan@aliyun.com>
Subject: Re: [PATCH 6.6.y] espintcp: fix skb leaks
Date: Sun, 16 Nov 2025 19:41:13 -0500
Message-ID: <20251117004113.3735259-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251107101100.1336-1-ruohanlan@aliyun.com>
References: <20251107101100.1336-1-ruohanlan@aliyun.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Subject: espintcp: fix skb leaks

Thanks!

