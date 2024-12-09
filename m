Return-Path: <stable+bounces-100204-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 064C99E9906
	for <lists+stable@lfdr.de>; Mon,  9 Dec 2024 15:35:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F19121887C97
	for <lists+stable@lfdr.de>; Mon,  9 Dec 2024 14:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C8541B4243;
	Mon,  9 Dec 2024 14:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hfMBvbWu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A8D81B4242
	for <stable@vger.kernel.org>; Mon,  9 Dec 2024 14:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733754933; cv=none; b=jJv81DWwgm+yDcfjAqfoN4krKyyKB4m3FY12VqYA2FjBnANweKocKrz2Qb74nQ6E53YZhADqM/mA4lNNSzm6+xZvk8suKyfzUrSchaSJ6k7BXy9nyuYcXH0tBP2YA83DnwByLFSLqAcKJJhzROmnuLs+mHBhD0ZcChd+dlkXmuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733754933; c=relaxed/simple;
	bh=oVtMPiXdYEqKiim4wXDM88fnwtaMrwKXaXD4uOgpCcE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KqE/5vP4fbdNGZpGVEYx27Shb09cpQqKIy6gKnCGW1QgSbVrWcH1yYaJz8DJ0Zap8Jb4TaUYnOuO8sirjVqMGlltG0JsazJsWOKPwciMySssatWZFicxuViO11sA7clV5s4piWmHynDPEHzFleYrE63vxpLtV7vNeufba7YBZ8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hfMBvbWu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07737C4CED1;
	Mon,  9 Dec 2024 14:35:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733754932;
	bh=oVtMPiXdYEqKiim4wXDM88fnwtaMrwKXaXD4uOgpCcE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hfMBvbWuvw1Q34PSZm1w7znpUCEDfaFRzmdLHgI5S0WzqFZ1wom7rFfQBuhajE5Fv
	 Y9hpzT422c/PHmtCK/lYYqPet7YWw45aBhapqmMpfnLU+3V+N0prWN7BfFh/ZHytb9
	 Hsv9I7sM3xhR7ENnr9W3n2CzwTfEdnTKRIwPZjiOdpnY2+r1ZAAEl+wi04GQSlwnyV
	 V3fX1iVppHAQWxI08NyZ9HRK+mhgHq3M5/+gn+x1m4FZDiE2GaY6HXsr3cT6WhJFIo
	 9UDD5v/LwttuQDT8IfPjcLTtPulvczqycLeItAqqQFUozwF2JmszWHWgv3k8AlWuhk
	 gWB2LVE5z6/+Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH for stable 5.4 v2] usb: dwc3: gadget: fix writing NYET threshold
Date: Mon,  9 Dec 2024 09:35:30 -0500
Message-ID: <20241209080455-39ec5952412a7a30@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241209-dwc3-nyet-fix-5-4-v2-1-66a67836ae70@linaro.org>
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
| stable/linux-5.4.y        |  Success    |  Success   |

