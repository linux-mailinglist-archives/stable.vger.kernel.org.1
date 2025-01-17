Return-Path: <stable+bounces-109317-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B43CA14735
	for <lists+stable@lfdr.de>; Fri, 17 Jan 2025 01:59:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 133943A06C2
	for <lists+stable@lfdr.de>; Fri, 17 Jan 2025 00:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF64711CAF;
	Fri, 17 Jan 2025 00:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H0HlG9rI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67EFD23BE;
	Fri, 17 Jan 2025 00:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737075557; cv=none; b=ofzATpuqi9f8FhCXnfi/HGySS1MpRlaVE1d+WVU2BvDU0s7JGDjLMZopzxQO9z3J4itbLgzIylWSKgRbTYrFwRlh9g2oVYaPUgo6i/ED3JGW0r0LPykjCUQW/TSRYd+YvbbId7YEHQofL2KnNyk5c1JSiwPSbFSuV+x8qGSofdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737075557; c=relaxed/simple;
	bh=MXxGeE8rkgxIZ0hDJ/rUzIhzoHyLBZofKIUf2wRAUys=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V2nEbD+zJHADDxCQ9xc8ySNf6+iabDOBFQFFHMN37D1NX9TiuM8Giz9rgd55kjJ2FJIkWNrZAchRTsDmr6bDNwwtPOjmIXnV93Hy5/mI8XRt1keNalS1gAoVZOORsq5m3GgWUORXw9g5NUO2L8hqYws+HZiG89QW5EWbeBcw5j0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H0HlG9rI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F7F3C4CEDF;
	Fri, 17 Jan 2025 00:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737075556;
	bh=MXxGeE8rkgxIZ0hDJ/rUzIhzoHyLBZofKIUf2wRAUys=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=H0HlG9rIN5Kw/i86LB0qtBRXAqUQCWWjhryrZq77lxTAT5k1qRcmz022/AYPqgQ52
	 pQvKIQCmBGRe0989KZvI1kTCR6QcpIqt0hHH4C67B2L1EDKYEJikbfUciTPO0X71iz
	 p0qyEnjDGEGyjIAL8luMHP7OCHQdJ5s5Hc1yeFf5ws1UC3uUpZvWdg8qNLeU/CD9OO
	 LFhJ6tNYogjXnD0/o5SCXaYPR7hgzle02FTr12JW8Ma2bfwLKRMm8ozvkxVqxqnq7u
	 rZTlE5ajaa/vxLROTHTW5JrTQTwJiZjOK24r95kT5qjRAnU8wS09tgtzuOYjC9mcgx
	 0Whr6kkHccRdg==
Date: Thu, 16 Jan 2025 16:59:14 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Gui-Dong Han <2045gemini@gmail.com>
Cc: 3chas3@gmail.com, linux-atm-general@lists.sourceforge.net,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 baijiaju1990@gmail.com, stable@vger.kernel.org
Subject: Re: [PATCH] atm/fore200e: Fix possible data race in fore200e_open()
Message-ID: <20250116165914.35f72b1a@kernel.org>
In-Reply-To: <20250115131006.364530-1-2045gemini@gmail.com>
References: <20250115131006.364530-1-2045gemini@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 15 Jan 2025 13:10:06 +0000 Gui-Dong Han wrote:
> Protect access to fore200e->available_cell_rate with rate_mtx lock to
> prevent potential data race.
> 
> The field fore200e.available_cell_rate is generally protected by the lock
> fore200e.rate_mtx when accessed. In all other read and write cases, this
> field is consistently protected by the lock, except for this case and
> during initialization.

That's not sufficient in terms of analysis.

You need to be able to articulate what can go wrong.
-- 
pw-bot: reject

