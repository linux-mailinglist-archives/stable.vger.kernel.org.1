Return-Path: <stable+bounces-119919-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77C9CA4944F
	for <lists+stable@lfdr.de>; Fri, 28 Feb 2025 10:02:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3146C189512F
	for <lists+stable@lfdr.de>; Fri, 28 Feb 2025 09:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51BF8253B57;
	Fri, 28 Feb 2025 09:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ggtHIdq9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0830E1CF5E2;
	Fri, 28 Feb 2025 09:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740733305; cv=none; b=D/hMKUJpKuWjgj51lSJMPgzNzzzBTN2RExJvLXygeiae/nxVUhHcFv2sDlVBOnQ72+gu9Ad3Pm0h653WSV+xewfR7RqgXAuXgzWaPGoG3/W7b0SV2fGXrLluY8IMcDTpdBhLtg3k4esmXIPIEnAf6mRKpnKAC3vyIZqzLoIiIuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740733305; c=relaxed/simple;
	bh=FY3ybLZSKYEjtXBoRdE5nTqOVzSb7P97rfLfGyen67s=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=GdvjqcFZDbux/b7yj8BsWFMdez8dBpZBv5TPjmOp5xpfy8/0L9K+bbjPINPfbcaHa0Of2YMYiCF1XRTNPG/bXcPCX1Cmg1mMHlQyJZoMOQWZbnfFHkYk2/BXstpnDuK2KGoXaK7vzWWuJAeuG0cF48tSWfsYxM4LkqkviBhQah0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ggtHIdq9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80A09C4CED6;
	Fri, 28 Feb 2025 09:01:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740733303;
	bh=FY3ybLZSKYEjtXBoRdE5nTqOVzSb7P97rfLfGyen67s=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=ggtHIdq9+XgRAY7ES2CIuPTKn6yhrkNWhk6uhBpIE197zo102cx0zbVptvLFfhR4X
	 li6s7W915Ky9BpWr8ULsWT5D+2QjAe0LNp7fuh5VIDbxzY9X2ZQMbGqqFWglYaS0M9
	 hgV6FJa7xXSxwIPECm458o75GVuZ+PlRBjOGVfcmbmcWWNcblSXSlU6bUgNyhSqgCw
	 IYJgtV15kZ66RuGqGDnMngyQsPsmkLlO/dCgB7QnVCJ9MKnNHYYVdmHkvjX+RRTIZx
	 1AkyGeIZuYY1jCUviIFyxlXpJVt6XNULDCOkCGtVuSRwb0UCX5i4LWglQUdZi/sDGX
	 jwLbWHeNCfb6w==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org, lkundrak@v3.sk, Chenyuan Yang <chenyuan0y@gmail.com>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20250224233736.1919739-1-chenyuan0y@gmail.com>
References: <20250224233736.1919739-1-chenyuan0y@gmail.com>
Subject: Re: (subset) [PATCH v3] mfd: ene-kb3930: Fix a potential NULL
 pointer dereference
Message-Id: <174073330225.3713551.10593826593909771979.b4-ty@kernel.org>
Date: Fri, 28 Feb 2025 09:01:42 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15-dev-510f9

On Mon, 24 Feb 2025 17:37:36 -0600, Chenyuan Yang wrote:
> The off_gpios could be NULL. Add missing check in the kb3930_probe().
> This is similar to the issue fixed in commit b1ba8bcb2d1f
> ("backlight: hx8357: Fix potential NULL pointer dereference").
> 
> This was detected by our static analysis tool.
> 
> 
> [...]

Applied, thanks!

[1/1] mfd: ene-kb3930: Fix a potential NULL pointer dereference
      commit: 61234ece5d37b3c1dce388cdb85fea4d9246318a

--
Lee Jones [李琼斯]


