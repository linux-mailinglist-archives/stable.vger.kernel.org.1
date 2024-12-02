Return-Path: <stable+bounces-96129-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22C0E9E0952
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 18:02:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA47D167470
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 16:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 939321D9A49;
	Mon,  2 Dec 2024 16:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gY1z77+l"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 533291D95AA
	for <stable@vger.kernel.org>; Mon,  2 Dec 2024 16:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733158633; cv=none; b=q1FsYsjkQdkezzHwqQkn3gNEW+30AQ28Mp032GRcjLOjsJck15mnFwKQmbWBAgQdaSH/l3hKzwkoFbdZqZYgYfxBJT3sSRWxXKU36vClj2rTiMclgo4M/F45zCgrFMuMQSMCTnE21Liw6FaMPGxqZik5/i8eNJlk3cjZ63zPn+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733158633; c=relaxed/simple;
	bh=/Az+hhvtBqhlIbI6qoyG3vBI2JK04wplhHsjMA/yTYI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M6MiryFfuVzWfQbc/CF2x+gRYI72qxEOJAxA6JZhWfuCDbcQmYirU09gFo9btnH67OskXSI5s//SJ7CQZQbSUwKxer9Fe1dhn5OPRcaS2QtcuuvKOLPS6QMjV6vG8KzDNKnm5W+KlnnR+hRTGo2OJ77A5Y1Vtr2t6rBU2qEEwME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gY1z77+l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EC06C4CED1;
	Mon,  2 Dec 2024 16:57:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733158632;
	bh=/Az+hhvtBqhlIbI6qoyG3vBI2JK04wplhHsjMA/yTYI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gY1z77+ltPwkJzEnzQVI4eGv9dGB7lkNLLjYIXryDkZuM3Uy0/NdBVbZm0TaTZlKm
	 xkDXvJCamzT20VFakhVLBlM0lkpUdBlmGcavVfMe50XL8vO2lzzvg2qAhnyNbPS7Q1
	 eYnRtCdnGh6jK9MPYciZBDF/PWlDqbRd/ELto26Hca8BT7VsxppcE6YweLj01kK6DS
	 K5ZawmSGgHXFrIJF+A7a6qh5cmKwLadreBPHEyJkkyfgPcbKtfWXNZBvg47s9CG0m8
	 znYl4Ug3e2aR1tQiNj6RMDfjvvpujNFluY+BXSyXdPzkBaYuSavUxKpJ6EllA04JUW
	 /INuouLGsPD6w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.12 v2 3/3] net: fec: make PPS channel configurable
Date: Mon,  2 Dec 2024 11:57:11 -0500
Message-ID: <20241202105027-eb06894090dc9d47@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241202130733.3464870-4-csokas.bence@prolan.hu>
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

Note: The patch differs from the upstream commit:
---
Failed to apply patch cleanly, falling back to interdiff...
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.12.y       |  Success    |  Success   |

