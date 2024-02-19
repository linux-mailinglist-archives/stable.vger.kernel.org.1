Return-Path: <stable+bounces-20516-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6882285A1CE
	for <lists+stable@lfdr.de>; Mon, 19 Feb 2024 12:21:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED030281822
	for <lists+stable@lfdr.de>; Mon, 19 Feb 2024 11:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 998632C195;
	Mon, 19 Feb 2024 11:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="b13SKENs";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OlFO0d6U"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C5E62577C
	for <stable@vger.kernel.org>; Mon, 19 Feb 2024 11:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708341668; cv=none; b=Ja/V5r9wgKilJImw1gCG4G0T1zMFWtw0rLcudLiYvE4p7d2bqSnd0uDPD4SUQSKB1hGAmrOYbFThUq20pb4qRIRgR6MTaIi88gNwRG8+Yea0fn/hRzZY31tNKtYSC36baOiHXtBF3Zf/b2wI1fgoT0uubVIT5erIhfIy0KsA2yY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708341668; c=relaxed/simple;
	bh=yo/ZvKzViqjvGMWdGdo3x3uekMZOwz9bQ0ZXVLTJDes=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YwuyMgkpqBGqlnHx5OjLt8++syIjKDRTyDY/TVYBCdldCUNuEw1pVNLe4IsFYOQdwdn35cgk4fCpArLzf81sE2kHr2oQw+YsaDDDEBqsG9qbcsbRoGIVD+6/5dDYHLjzbVF1JGunxDuxPKTznbdFMpSP108lnocO/pKytXYejEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=b13SKENs; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OlFO0d6U; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708341663;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yo/ZvKzViqjvGMWdGdo3x3uekMZOwz9bQ0ZXVLTJDes=;
	b=b13SKENsz2b2T1uBEPVPwbOu3Nu7NwHmO5zhIcMAkoasXeXgtrTt23rIVzrZIYgEE9ikQx
	rY/HlC2jrSyWZ/j1BjyM12zeZ5kfNMNcH8/H5UovsrX8aaD6o2klixk4ASFC748GxoSu4x
	uX9RlVqFasK4/j9tAG6ban+G8dxihUco3Owwa0P3eldLoMNROVK4Ozya9AvrIQzYqTCMMe
	+SW0XbwowneXwvnfnMCpsdmXfk5UtV989bmpcJieR++9LdHoX6C7B4mwBUMxcE0Dvc085t
	cAcR0T9aoJnJqlgS4R21XLL+0WvDAIu/XY2IPZmP9D2pmIzthwKn0B3ghRsurA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708341663;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yo/ZvKzViqjvGMWdGdo3x3uekMZOwz9bQ0ZXVLTJDes=;
	b=OlFO0d6Uwg6+UkoBUbUmVjUFoAiQYoTU3Nkc0lFM3MRXZ2EN8xlgobHHVV0KTVs/Oa34GW
	iTjUTgbJGibT1aAg==
To: Felix Moessbauer <felix.moessbauer@siemens.com>, stable@vger.kernel.org
Cc: dave@stgolabs.net, bigeasy@linutronix.de, petr.ivanov@siemens.com,
 jan.kiszka@siemens.com
Subject: Re: [PATCH][5.10, 5.15, 6.1][1/1] hrtimer: Ignore slack time for RT
 tasks in schedule_hrtimeout_range()
In-Reply-To: <20240219080851.27386-2-felix.moessbauer@siemens.com>
References: <20240219080851.27386-1-felix.moessbauer@siemens.com>
 <20240219080851.27386-2-felix.moessbauer@siemens.com>
Date: Mon, 19 Feb 2024 12:21:03 +0100
Message-ID: <87sf1oaee8.ffs@tglx>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Feb 19 2024 at 09:08, Felix Moessbauer wrote:
> From: Davidlohr Bueso <dave@stgolabs.net>

This lacks a reference to the upstream commit.

Commit 0c52310f260014d95c1310364379772cb74cf82d upstream.

> While in theory the timer can be triggered before expires + delta, for the
> cases of RT tasks they really have no business giving any lenience for
> extra slack time, so override any passed value by the user and always use
> zero for schedule_hrtimeout_range() calls. Furthermore, this is similar to
> what the nanosleep(2) family already does with current->timer_slack_ns.
>
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Link: https://lore.kernel.org/r/20230123173206.6764-3-dave@stgolabs.net

