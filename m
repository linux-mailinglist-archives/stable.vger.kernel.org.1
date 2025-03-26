Return-Path: <stable+bounces-126780-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B11BA71DC2
	for <lists+stable@lfdr.de>; Wed, 26 Mar 2025 18:55:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B9157A22DA
	for <lists+stable@lfdr.de>; Wed, 26 Mar 2025 17:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4170B1F95C;
	Wed, 26 Mar 2025 17:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vji3ulzc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB3AD1FDE09
	for <stable@vger.kernel.org>; Wed, 26 Mar 2025 17:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743011707; cv=none; b=WGgNX/VgKSEq5U3QYIa9wnBQy2L4IBM1Wpnegoo3uNe2wjfXc0NYxNDltFOR064KHXlaX3rGd7a1wleSQdnefD07EQGsA7Pvarab0C39Ouzpps+Rj5/byXkmwtP77u3GOffZai0p3g02UUCQizKnYNdfg5Hiy5+f+hz48URd4MM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743011707; c=relaxed/simple;
	bh=kZm0G3C0bCZYtromvq6WUxqDL8x2RM5Wwx8yZ2Xs1NI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aV4JsUN9AKtlPVjAaFrzho8Ns7OACM2ZHFJCakMT6rDfVpqxUEA9dYsV2oUP1nHt8/tH80UVg+Qw25Sg3HDarkEy5x1PncaUqbVV5LGWj2P+/wv6JMQdpOXpIxerVMCXozsEVbKUSHNPJuByGfQGIE+es+mc4BrgjiePt36ELX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vji3ulzc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53119C4CEE2;
	Wed, 26 Mar 2025 17:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743011706;
	bh=kZm0G3C0bCZYtromvq6WUxqDL8x2RM5Wwx8yZ2Xs1NI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Vji3ulzcKSJk8IAAgpfSoG58O9/CEu5i/NDoUdHxuETimHpqGflaQOz30PqZoNAKN
	 pcq0X47hrw2E1RnmvjOsrzlEeYf3TCKdmd6aja5H31VMknh/7l982A7NHfpB+NRah4
	 gkojRDK99ZJVGngwFle8a5vbdKJaE7IRis09esCYNaS8ul7S5B93F4jpDU06tybR89
	 vJor8VY0LPrzPSAgm5Zf4O+LwGcoFQ5N5cK3PH4rbKJ9CAYdCSFXup7nzEC64ZE0Dg
	 GuIAFqXco5gs6M2TyRE5l4yfF/xhWKtz82Wu/RXl/+nE6u12gjy14T4UQJYIuJTGA/
	 3FHAhVFYcCLLA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	sidong.yang@furiosa.ai
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.13] btrfs: ioctl: error on fixed buffer flag for io-uring cmd
Date: Wed, 26 Mar 2025 13:55:03 -0400
Message-Id: <20250326135051-cfc974442e0f5c64@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250326160351.612359-1-sidong.yang@furiosa.ai>
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
| stable/linux-6.13.y       |  Success    |  Success   |

