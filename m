Return-Path: <stable+bounces-112245-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CB5AA27BF1
	for <lists+stable@lfdr.de>; Tue,  4 Feb 2025 20:49:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1FF71887327
	for <lists+stable@lfdr.de>; Tue,  4 Feb 2025 19:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39444218E81;
	Tue,  4 Feb 2025 19:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ey6pHlNl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9947204C20
	for <stable@vger.kernel.org>; Tue,  4 Feb 2025 19:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738698527; cv=none; b=K+wFQBXtq4B+9wm+uU6Y8kBQzEgOfeOlV6DtVUI99bM35gSyIXNnNTFAwbItddL7myXmK9c1J9Qv8Yii3jP4pR0ToN5xeRC4X2C0S2fcnNgHFAtr6FL73Vvz3oV55gS+aVr1tELvyKlCrkoMFVsabjkzWW34v/i+HZ2W+UM2LXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738698527; c=relaxed/simple;
	bh=+npczuPMPsPyuLEEYFKWeCezOZzWKhX4ilDAi6kvdFw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NZiNIDj25qWuA8d93xhtGn3ua/YqMCCkb2cL4wkeza7uUToilfHDcOF6pe57OM0rvsddB+P4X1aUj/xoal5XC6pbG0Vytzr4cbPP486ocz20Jz9d6WvgWYMsmdcZHdcIYdJc5jC+5ewaKGX54p7juB6ckByHMQc576bJBxGNmDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ey6pHlNl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 226D4C4CEDF;
	Tue,  4 Feb 2025 19:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738698526;
	bh=+npczuPMPsPyuLEEYFKWeCezOZzWKhX4ilDAi6kvdFw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ey6pHlNlvfnMTYjIs4Wk9FaG0VhZrr2ByhhT5dOzk43ydxnVx0m/e3SjU5tEzurkj
	 Sx8kriJ0nXcDHthzNw2F3g3gRvqZT2eMyeonAVZFB2UoYLBGhRpxZIvan9kKONYRlX
	 85NNhVm9KpH2auNz7BJIUfOyBHGY1a457mN/yNYiSXr3ffTzFtFejJJ/2eCIq2GK7/
	 N1dJzLVc9NaX4LDOc3zhVna0pfG+5904wPaRLe3wOyOyq+J/KEtkOljem/wpujeMzP
	 5oSAdp94/lZS++vRCxSswy+rFP1TAjisKoBvzT0l5fA75wCT37y1a4FfOgSCkkaXtd
	 FEXp79ZSL9SFw==
Date: Tue, 4 Feb 2025 14:48:41 -0500
From: Sasha Levin <sashal@kernel.org>
To: Paul Kramme <kramme@digitalmanufaktur.com>
Cc: stable@vger.kernel.org, chengming.zhou@linux.dev,
	Bendix Bartsch <bartsch@digitalmanufaktur.com>
Subject: Re: v6.12 backport for psi: Fix race when task wakes up before
 psi_sched_switch() adjusts flags
Message-ID: <Z6JvGaA7tB3D9Bhb@lappy>
References: <CAHcPAXT=6GhKo4CnkveSm_X+EQXSz-GCRtigi5aFRscASSTFXw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAHcPAXT=6GhKo4CnkveSm_X+EQXSz-GCRtigi5aFRscASSTFXw@mail.gmail.com>

On Tue, Feb 04, 2025 at 04:31:44PM +0100, Paul Kramme wrote:
>Hello,
>
>we are seeing broken CPU PSI metrics across our infrastructure running
>6.12, with messages like "psi: inconsistent task state!
>task=1831:hackbench cpu=8 psi_flags=14 clear=0 set=4" in dmesg. I
>believe commit 7d9da040575b343085287686fa902a5b2d43c7ca might fix this
>issue.
>
>psi: Fix race when task wakes up before psi_sched_switch() adjusts flags

Hey Paul,

The commit you've mentioned is already queued up, so it should be there
when the next release happens.

-- 
Thanks,
Sasha

