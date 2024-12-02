Return-Path: <stable+bounces-96161-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 328F99E0BD9
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 20:16:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B68EF2827E4
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 19:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51AA31DE3BC;
	Mon,  2 Dec 2024 19:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QlP/Yoxi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11BB51DACA7
	for <stable@vger.kernel.org>; Mon,  2 Dec 2024 19:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733166972; cv=none; b=K7ZJ5rLEWxttBVhpdzzOmqCINk9AMLrMXNKQYx1B2V4/zPvR1ZP1vkBAYIYgf/HCow2O/X0G3UrfU4g72X8ZiShsfvLK7MFQFY+A5OQUTk2pRrEztuUOHPsk+aUO1SmuiJ4s2jzyYzVWz8MjaLGJrPlIqvXpjRVZQRodZPGW/l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733166972; c=relaxed/simple;
	bh=dh5bYB+6/8wXlVMlBqfwdU8bJ/nsBjY49weGLWjTe48=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U2ZZjlM+IKZzxNzvAF5rX4bpXl4beJGLyTMoOg8g9jMWuve5SznEGHothXcNc3WBocub/TtHXIsooKRqW7G0UEQCbn5S8I6BYR40j5Ac8Kkx4s1YYZb5of2dzV/aF0nrtg+C5rWQ/ITPEDK36Nqeb1mmwgEl6Y7wNmY4ilml9L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QlP/Yoxi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C101C4CED1;
	Mon,  2 Dec 2024 19:16:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733166971;
	bh=dh5bYB+6/8wXlVMlBqfwdU8bJ/nsBjY49weGLWjTe48=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QlP/YoxisNwHx8CdN/DBzpAicVVwzCdXfKQAXZNpXIqeMC8a3A7gARniT3EKivHAL
	 Or9PPqaB5Z5OXXt1WCZefilwX+z/JAfzvm3dkQC47RUp+VYSJdziBu4zv72NmTXWCc
	 So/20JBtMw9TIPQesr2Tgi02OxU+GuF24N0KfmPr+nlhd96Obqggiag+5TJS4ty2+8
	 2kVIhIESqjzUdi0u4j9Ea3gog4h1oTu7JlDHFoz9Bd8zjW55l3G6e1lfh/R/nvfocD
	 HxgNLGhuRHgIVbh04bYWX6PXbsSTYnvtZgZnuWzHBUlLBck97hM0RorcUyPuaXMXe0
	 33HVtnlOb1bOw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.11 v3 3/3] net: fec: make PPS channel configurable
Date: Mon,  2 Dec 2024 14:16:09 -0500
Message-ID: <20241202125809-a4b6e45bc387a071@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241202155713.3564460-4-csokas.bence@prolan.hu>
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

Found matching upstream commit: 566c2d83887f0570056833102adc5b88e681b0c7

WARNING: Author mismatch between patch and found commit:
Backport author: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>
Commit author: Francesco Dolcini <francesco.dolcini@toradex.com>


Status in newer kernel trees:
6.12.y | Not found
6.11.y | Not found

Note: The patch differs from the upstream commit:
---
Failed to apply patch cleanly, falling back to interdiff...
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.11.y       |  Success    |  Success   |

