Return-Path: <stable+bounces-143051-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EC3DAB15E9
	for <lists+stable@lfdr.de>; Fri,  9 May 2025 15:55:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 953F54C2C03
	for <lists+stable@lfdr.de>; Fri,  9 May 2025 13:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E096829209C;
	Fri,  9 May 2025 13:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d5p1Mi5Y"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A933292083;
	Fri,  9 May 2025 13:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746798927; cv=none; b=gSTENmnxddboneF0kfDhHjZCro3CNFwxwhl15Z+2uGYlFpZLEyUz2w88hYlnwWC7f/UCKTIUNA2BaMHnweIFhH9AOUbjybtcDr13YtvONw/zesqERZQDXafdAxt6lzL+vH+FCnc7L0a9+T3DG83kOo4bjSDYBlDkY0tHEjJtfg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746798927; c=relaxed/simple;
	bh=da3RkCqXANyBGgu6g4hnmz+mJdGqS579klvM2K7ikjo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Gu5/kjAZ2kfkgF25ZOPy+VNu8QQQoAwiu5wLf/Nn0BJ49sVHAp5ShF/yuKKoFbjY0Ty/kM/kHCMhyUMzEXdclH58Lv2n0aEMK/11b8dS2FM8wSU73OdgO4T1gaZ555A9Bl4xCBOxSS6qjijpC1t6pWxDrsMWX/bjsz3YWs18bBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d5p1Mi5Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 753D2C4CEEF;
	Fri,  9 May 2025 13:55:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746798927;
	bh=da3RkCqXANyBGgu6g4hnmz+mJdGqS579klvM2K7ikjo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d5p1Mi5YCMihuJE9OfUQVXe4W23KR5UspW7XhDDz4gIVp+fQhLKLlXaOlvlf49hxp
	 bK6YqSIhX+3MGRHodGeOe0x2HPZJb9x4OpMERBGopPXlJbd/MS4GgCqNvXNo94bMqK
	 iW9l4NIBaoWU+mu7HoZCHN6Ir7fOUDNr7FC4vA0mloabHlz+GIVLGDoPNLe2gs9qKU
	 DHGY8h6a3jIEVVCzXYJuvol6T0ZJaNHLR/Rv5/K2jh/JCkY5thxNvs8DGhnm3rGRrg
	 DaoO8nlRlyD7P0mBBdkhRpMnKyhpHykI9CJmXwdNlxFwSqCEW5YHhGyNgiE9wsT9Zp
	 qbGlJ2p8qP19A==
From: Will Deacon <will@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	mark.rutland@arm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] perf/arm-cmn: Fix REQ2/SNP2 mixup
Date: Fri,  9 May 2025 14:55:17 +0100
Message-Id: <174678933203.1772245.7314989125641687120.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <087023e9737ac93d7ec7a841da904758c254cb01.1746717400.git.robin.murphy@arm.com>
References: <087023e9737ac93d7ec7a841da904758c254cb01.1746717400.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 08 May 2025 16:16:40 +0100, Robin Murphy wrote:
> Somehow the encodings for REQ2/SNP2 channels in XP events
> got mixed up... Unmix them.
> 
> 

Applied to will (for-next/perf), thanks!

[1/1] perf/arm-cmn: Fix REQ2/SNP2 mixup
      https://git.kernel.org/will/c/11b0f576e0cb

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

