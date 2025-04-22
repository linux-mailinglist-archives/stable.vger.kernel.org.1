Return-Path: <stable+bounces-134896-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C334A95ADB
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 04:15:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D95747A8ED8
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 02:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DC361624DF;
	Tue, 22 Apr 2025 02:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aHzr97Ya"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0ACD33C9
	for <stable@vger.kernel.org>; Tue, 22 Apr 2025 02:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745288150; cv=none; b=RAYaV3Ulu0vDBLwxjIIePabHx/kB2Aw6XERJb1qrv/41AC8NXWVPfNrI+h/He+2V7GtTAlsxELElO0+X4wv47Ih8VXIqDh4CUgplKxIz7JTw/pt649JXJjUFmOneSmtYzBqOZ6d0IWcCR1LXMDw8nSGqENHaTpzfA1YEwFQgPPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745288150; c=relaxed/simple;
	bh=QgRXySa7O2d1TVaBJv4Wh2+nEfMOr6exKcLB4FEcxDw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dEzJZROMlOzMAQQ9F+2O1FvckMY80MZV2UYUbHjS2isGdYKD9gRyZosbTTz4dByrjXbKXdsLOhhtcxN6q8yDe+AENQXrctM3Uk7dTPgjMQVSqQoICmf0bAPn30MZaDgc5auxq6It6duRwEKp/cSMmuLq024NY02kPl1VJg9fIK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aHzr97Ya; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA14EC4CEE4;
	Tue, 22 Apr 2025 02:15:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745288149;
	bh=QgRXySa7O2d1TVaBJv4Wh2+nEfMOr6exKcLB4FEcxDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aHzr97YaMg5d5M1BaDAtgI9teFIu5QUWIDi7vETnvuKYK+/TSAOA9v+P+Ge9ejbW0
	 nJtsfCr5OJJvmMN/8z7FV6IOD/2JL3ZWCFiFcF2M55zDFFa17wbpQrtCeon9ZL5QYT
	 LMQ764mANQ8RdlXrse5VdTkvhy/XlWgX1mH2dld2oBuk2v+BJ1vh695MMTFrKAmLts
	 T10zx2HJdkvlWkPGp6fGXw/mBA/1DYFpK++zew8Ual80JxL3pRa4HDpiFVjUPGRVsi
	 D0n4vBhuOX5zqALueglCTcYq10gq3C66Y5if4wZnBIcl9bB5Qbya7+C65U5urkcNED
	 us6Km4qcHGJMA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	kuurtb@gmail.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.14.y] platform/x86: alienware-wmi-wmax: Add G-Mode support to Alienware m16 R1
Date: Mon, 21 Apr 2025 22:15:47 -0400
Message-Id: <20250421194752-dae6d9e7d710530c@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250421164953.9329-1-kuurtb@gmail.com>
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
⚠️ Found matching upstream commit but patch is missing proper reference to it

Found matching upstream commit: 5ff79cabb23a2f14d2ed29e9596aec908905a0e6

Note: The patch differs from the upstream commit:
---
1:  5ff79cabb23a2 < -:  ------------- platform/x86: alienware-wmi-wmax: Add G-Mode support to Alienware m16 R1
-:  ------------- > 1:  edb98d43e362e platform/x86: alienware-wmi-wmax: Add G-Mode support to Alienware m16 R1
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.14.y       |  Success    |  Success   |

