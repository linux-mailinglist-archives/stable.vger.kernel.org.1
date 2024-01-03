Return-Path: <stable+bounces-9279-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1EE582316D
	for <lists+stable@lfdr.de>; Wed,  3 Jan 2024 17:44:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E89651C2389A
	for <lists+stable@lfdr.de>; Wed,  3 Jan 2024 16:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27EA31BDCE;
	Wed,  3 Jan 2024 16:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DloDjGv8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA5A1BDC3
	for <stable@vger.kernel.org>; Wed,  3 Jan 2024 16:44:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1F37C433C7;
	Wed,  3 Jan 2024 16:44:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704300283;
	bh=M4lNz1Oc22Fa8ylrUSae2bWBhDKuet9gv2V4rgzEsG0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DloDjGv8Cv6I0S5cAMXP9s1feHL2BkLGPK9a6mFfaT/rVUnWvs9lA0du03dT6LbP+
	 NzJiQVrAu6hoePnNZQhlP6RP4EblL/YST596shDlr1YMOtOY3cS4GAhHFvuZF4bJ1W
	 BVNOEdWsVKp8nUGHPXk+K07aneCffHlwekoUgWFM=
Date: Wed, 3 Jan 2024 17:44:32 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Hao Wei Tee <angelsl@in04.sg>
Cc: stable@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>,
	Francis Laniel <flaniel@linux.microsoft.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, Song Liu <song@kernel.org>
Subject: Re: [PATCH v2 6.1.y] tracing/kprobes: Fix symbol counting logic by
 looking at modules as well
Message-ID: <2024010321-hefty-truce-be6a@gregkh>
References: <2024010101-stabilize-geography-7d63@gregkh>
 <20240103163350.18573-2-angelsl@in04.sg>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240103163350.18573-2-angelsl@in04.sg>

On Thu, Jan 04, 2024 at 12:33:19AM +0800, Hao Wei Tee wrote:
> From: Andrii Nakryiko <andrii@kernel.org>
> 
> commit 926fe783c8a64b33997fec405cf1af3e61aed441 upstream.
> 
> Recent changes to count number of matching symbols when creating
> a kprobe event failed to take into account kernel modules. As such, it
> breaks kprobes on kernel module symbols, by assuming there is no match.
> 
> Fix this my calling module_kallsyms_on_each_symbol() in addition to
> kallsyms_on_each_match_symbol() to perform a proper counting.
> 
> Link: https://lore.kernel.org/all/20231027233126.2073148-1-andrii@kernel.org/
> 
> Cc: Francis Laniel <flaniel@linux.microsoft.com>
> Cc: stable@vger.kernel.org
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Fixes: b022f0c7e404 ("tracing/kprobes: Return EADDRNOTAVAIL when func matches several symbols")
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> Acked-by: Song Liu <song@kernel.org>
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> Signed-off-by: Hao Wei Tee <angelsl@in04.sg>
> ---
> Fixed for 6.1. Please cherry-pick 73feb8d5fa3b755bb51077c0aabfb6aa556fd498 too.

Both now queued up now, thanks.

greg k-h

