Return-Path: <stable+bounces-165132-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBA8CB153D0
	for <lists+stable@lfdr.de>; Tue, 29 Jul 2025 21:46:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7679E7B0440
	for <lists+stable@lfdr.de>; Tue, 29 Jul 2025 19:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA1632571C3;
	Tue, 29 Jul 2025 19:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CMom9gD/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86484255E4E
	for <stable@vger.kernel.org>; Tue, 29 Jul 2025 19:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753818320; cv=none; b=Sh5wXUFYjD3k2Gin5l+KhIGxyDF0o1aeCpL5YymgMvWLRX+rRjwNR/8wIBI7RIqa3sH4KaOCH11zaTgSO0paUA4gqpUrGSsLiwJRnfvITsTNao5VwB9zhXixSGd3m522kEiQlHuIcXVE/GWgo/37K4nQdwFbd6Iar2Pq++mmJC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753818320; c=relaxed/simple;
	bh=qjFNjxOnaQeiKkL0RnSEubeIB7xZVz4io409kYJ+wFg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H+s/EdzNEvhzLZKr+5EOFt0G6PPjrXJsOm5GmEWTkoI9hkfYmiCUG8PsPOLy8zrGDK8V+i3RmBp2Jcy/jvBAjI9eRhZmq7Mzs7xZ7EZNRDIFG0yyJBI2FWw6YHA0E4JqE/Cx+W5CTM3Sx5F8dlBlPB3s4/XGs2aU07o20ENOp6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CMom9gD/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE8DFC4CEF7;
	Tue, 29 Jul 2025 19:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753818320;
	bh=qjFNjxOnaQeiKkL0RnSEubeIB7xZVz4io409kYJ+wFg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CMom9gD/rKi6tuDm5fmnGuTmKcwiu41bGtx1+7WO6X87EFlvcFUWa86bTwU38NzOm
	 vs5m+Y2hrbc4V/+EdiqLa1qnNjFviuiChgVTPQLdpZmW05zqT62DpYUH5x/7Z1yBZy
	 1gq3Bzm4MPmH2MpIiHPy6RXvAdk1ujXNTRhnAlhvbA7U9kutMai9gXyYrOjYjNWom5
	 MfZqHPwYPSijoXPmt1vVh/D+YdvBWzBqSRLsSUXEkGIlUXPxedJfgx6n3APr4oMB89
	 qOB+WCGumrscJbQc0mq9kBIXyhHQis+RqSbXEFQYxcRBaYSPH/T/NZg4sfGQsSwQJt
	 IbHI+tt5/fp0Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	justinstitt@google.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15.y] KVM: arm64: sys_regs: disable -Wuninitialized-const-pointer warning
Date: Tue, 29 Jul 2025 15:45:17 -0400
Message-Id: <1753813753-44ec066e@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250728-b4-stable-disable-uninit-ptr-warn-5-15-v1-1-e373a895b9c5@google.com>
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
| origin/linux-5.15.y       | Success     | Success    |

