Return-Path: <stable+bounces-118380-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC900A3D196
	for <lists+stable@lfdr.de>; Thu, 20 Feb 2025 07:59:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F22E171681
	for <lists+stable@lfdr.de>; Thu, 20 Feb 2025 06:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 338C41E3DF2;
	Thu, 20 Feb 2025 06:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GK6SB0yF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC0091DEFF7;
	Thu, 20 Feb 2025 06:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740034742; cv=none; b=P89HJNrz2J9im2fQLnKrZ9dDEoVa8J4E4hKJpfA3bcOxKZ3eWQtqHmoY2H3SMS5sVvUTvTZlm5DFSmNG9H5DM5ixv2YfPhO917MsT6feBgFipI8I1PWjviZuKuK9xARwwg9i9jOgfz6el/2hYjne7i23T97CNHYDAPaG3dM2BAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740034742; c=relaxed/simple;
	bh=RrYHAZXfx6TJgzsVG9QHhICVbb0egVD+jvjZhGPNwlo=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=PtabxRAKq6XU3JGdx6fbWJ7X3/+XHM/XluTA6nWivkMWF2NUFLFTbUiO/Fg7NU/7B4dcx3Ewx5//7FztlXXu5UcHO30cGlDeK5b/XLNon8BVuUKLYsKQreDheLrSqc8KZQN3Nnwg6mimLJri8Y3RKESQG/ggYvBjyUX60qJMJJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GK6SB0yF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8779C4CED1;
	Thu, 20 Feb 2025 06:58:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740034741;
	bh=RrYHAZXfx6TJgzsVG9QHhICVbb0egVD+jvjZhGPNwlo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GK6SB0yFxqyoVAGN+PgEpOxq2QMfAj4S9PyF9FctrmGWqqMYxt9yf70eGNRdYEkMi
	 T8DRIdBgFyGKgoliQDdg2ioXQORCltTpmZilUvqyR5/SmaxLY4Q2RT98AtTotOdqSB
	 ZTWxWpBTQO5PjsKENJyocU2gBjNdkI6VdonKRUvDFeqCCP7ASsWRHAN5ncDqjpvHWX
	 7Wbb9Koy2DyWYKkGEjDifbC4clLdTO+oNPh5Wp4yuajjLmI/c2V/mBaaIJcn5jCcIJ
	 zkFXjossy+JG1KDwcBfLA05b+qUpPD/oVVBh5gW1JJAz87I/jcc9dV/nmHGgdoxs7v
	 76pFAD/mp+Tdw==
Date: Thu, 20 Feb 2025 15:58:58 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Masami
 Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Heiko Carstens <hca@linux.ibm.com>, Sven
 Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/5] ftrace: Fix accounting of adding subops to a
 manager ops
Message-Id: <20250220155858.8a99ab5dae52b875fdbab1d6@kernel.org>
In-Reply-To: <20250219220510.888959028@goodmis.org>
References: <20250219220436.498041541@goodmis.org>
	<20250219220510.888959028@goodmis.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 19 Feb 2025 17:04:37 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> @@ -3292,16 +3299,18 @@ static int intersect_hash(struct ftrace_hash **hash, struct ftrace_hash *new_has
>  /* Return a new hash that has a union of all @ops->filter_hash entries */
>  static struct ftrace_hash *append_hashes(struct ftrace_ops *ops)
>  {
> -	struct ftrace_hash *new_hash;
> +	struct ftrace_hash *new_hash = NULL;

Isn't this "= EMPTY_HASH"?

Thank you,


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

