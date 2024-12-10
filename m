Return-Path: <stable+bounces-100295-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E83119EA7A8
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 06:20:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA9F8282CF5
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 05:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B45B1D6DD1;
	Tue, 10 Dec 2024 05:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="b/5meCK5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C43D3168BE;
	Tue, 10 Dec 2024 05:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733808041; cv=none; b=MR4wIELDAvMnbXqitnbneUKrtqxXqiHc2WF2S+MAwm0n6q4tGqnwSV4NjElJK/I0L0I8l1HUkFJt7DrC7d8bKZco5DRj2L5B9M42Jehe9Z/GXcv79p9MVbAgHucLzEXAIhz85TdaS+EOEddYvPw8AERhEZF48gW7sAg0J+DpZ7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733808041; c=relaxed/simple;
	bh=33pqDsqgI4dX23uvk5+42jVmm/upbfANq0rv+yhrOlo=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Ajt5GrtU8j0gpxWVX73K2hlLoHHIJiFtwdvRu0LVCDw0eeOXYb3sNTUElD7Z2xnT04Lkhk9tkUT0rF4HV5XbGrVuZVsLxGiuVr8c+mum5leoFykg2Sk3cgiRydyt9H0NYrYhavMt77ST0GazWnmdRETV4LUHQyheXytYcEMaY2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=b/5meCK5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4593DC4CED6;
	Tue, 10 Dec 2024 05:20:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1733808040;
	bh=33pqDsqgI4dX23uvk5+42jVmm/upbfANq0rv+yhrOlo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=b/5meCK5+BZVb72H1EbRVGvsuTR1IMw3uGVTSTFLRJvXpwfAho5RMss1TKHmqLyjQ
	 OvmQwwrzi2M8wH7xVq5jim/Gk0AE66/GLiFqlfFbS91M2Ipzsb0yKxHqqVUYaTd7TZ
	 gJZonZWVjtPe1gpqcS8hIzV8RBG/29Ws3mBnacUU=
Date: Mon, 9 Dec 2024 21:20:39 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: mm-commits@vger.kernel.org, stable@vger.kernel.org,
 deshengwu@tencent.com, kasong@tencent.com
Subject: Re: +
 zram-fix-uninitialized-zram-not-releasing-backing-device.patch added to
 mm-hotfixes-unstable branch
Message-Id: <20241209212039.69b30b998e5de7622fe10ab5@linux-foundation.org>
In-Reply-To: <20241210040815.GJ16709@google.com>
References: <20241210015750.7D4C6C4CED1@smtp.kernel.org>
	<20241210040815.GJ16709@google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 10 Dec 2024 13:08:15 +0900 Sergey Senozhatsky <senozhatsky@chromium.org> wrote:

> I'm not sure if this and zram-refuse-to-use-zero-sized-block-device-as-backing-device.patch
> are worth the stable tag, they don't really fix problems that people run
> into en masse.

Me either, but they're very simple patches.

