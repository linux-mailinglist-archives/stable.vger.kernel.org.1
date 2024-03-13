Return-Path: <stable+bounces-28073-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 879B387B0CA
	for <lists+stable@lfdr.de>; Wed, 13 Mar 2024 20:01:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2713C1F2261C
	for <lists+stable@lfdr.de>; Wed, 13 Mar 2024 19:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 118376026E;
	Wed, 13 Mar 2024 18:02:30 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail.aaazen.com (99-33-87-210.lightspeed.sntcca.sbcglobal.net [99.33.87.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B94E60264
	for <stable@vger.kernel.org>; Wed, 13 Mar 2024 18:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.33.87.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710352949; cv=none; b=kCmrtLpxtp5BFA6YSYF/1THyuJ9rh2XGBYVFTLsmERRenWdPcYSpO09ESYDL3ojf41//SamvZ0emGAzbdzveDvFMICQUrn/0VJezJ0uUmpILMOTwxLQX9SnHIl34iElJJenSC2a4zUNi29aKJDTijeRNwBBZ45QZzlLNNGs1ZBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710352949; c=relaxed/simple;
	bh=IA9qLRuNwfDjIaZUYKSq0kdQjsuY6oTW+IY+KW5ZwUk=;
	h=Date:From:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=YeDxsLFhIV6xXovW41RNK3TIeboD43B3MVQEC91zQvfNxqjufjl5ykeOynNkLCut6voLuaeHDvxnx8kuvHFMj1+wikZmMrZsWaibvCVJ3yrJMxPekOB4v8ZRT81LuxnjASCYvo0tnGfq9e9F3JIYDmHhIQQqXiBDNJANGk/R68Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aaazen.com; spf=pass smtp.mailfrom=aaazen.com; arc=none smtp.client-ip=99.33.87.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aaazen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aaazen.com
Received: from localhost (localhost [127.0.0.1])
	by thursday.test (OpenSMTPD) with ESMTP id af2ed0fa;
	Wed, 13 Mar 2024 10:55:47 -0700 (PDT)
Date: Wed, 13 Mar 2024 10:55:47 -0700 (PDT)
From: Richard Narron <richard@aaazen.com>
X-X-Sender: richard@thursday.test
To: Sasha Levin <sashal@kernel.org>
cc: stable <stable@vger.kernel.org>
Subject: re: [PATCH 5.15 00/76] 5.15.152-rc1 review
Message-ID: <7f21928-bc75-adac-7260-d2b0cc8dd3fe@aaazen.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

This patch file link does not work for me:

https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/patch/?id=linux-5.15.y&id2=v5.15.151

When using Mozilla Firefox 115.8.0esr it gives me an error message:

  Bad object id: v5.15.151

And it gives me no download patch file...

Richard Narron

