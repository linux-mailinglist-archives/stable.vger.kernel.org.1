Return-Path: <stable+bounces-9147-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D574C8213B0
	for <lists+stable@lfdr.de>; Mon,  1 Jan 2024 13:10:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4F2C1C20BF3
	for <lists+stable@lfdr.de>; Mon,  1 Jan 2024 12:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A8D920FD;
	Mon,  1 Jan 2024 12:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mdYIEsb9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE7B6107
	for <stable@vger.kernel.org>; Mon,  1 Jan 2024 12:10:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4A74C433C8;
	Mon,  1 Jan 2024 12:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704111013;
	bh=7mrrOIbz5aa9ZPQnkl2t5IKAIwj9CPTXRTPLOFalI08=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mdYIEsb9dNmyn9pOLhbspUiYMrhtN9vKt7/TKDnBAoODx2PgbUGIUvKgcNrygmNRo
	 seEYpk/Lv70KSvC4l7CsOfw0ussdkjAH82+lWCwvXiihQNhuJAsqrVcB9Owz6GVNoz
	 3WdYG4yul0mxpbrfiqYgNEIBYjSK25vKxr/2zY8g=
Date: Mon, 1 Jan 2024 12:10:08 +0000
From: Greg KH <gregkh@linuxfoundation.org>
To: Tee Hao Wei <angelsl@in04.sg>
Cc: Andrii Nakryiko <andrii@kernel.org>,
	Francis Laniel <flaniel@linux.microsoft.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, Song Liu <song@kernel.org>,
	stable@vger.kernel.org
Subject: Re: [PATCH 6.1.y] tracing/kprobes: Fix symbol counting logic by
 looking at modules as well
Message-ID: <2024010101-stabilize-geography-7d63@gregkh>
References: <2023102922-handwrite-unpopular-0e1d@gregkh>
 <20231220170016.23654-1-angelsl@in04.sg>
 <279de9e4-502c-49f1-be7f-c203134fbaae@app.fastmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <279de9e4-502c-49f1-be7f-c203134fbaae@app.fastmail.com>

On Sun, Dec 31, 2023 at 09:09:36PM +0800, Tee Hao Wei wrote:
> On Thu, 21 Dec 2023, at 01:00, Hao Wei Tee wrote:
> > From: Andrii Nakryiko <andrii@kernel.org>
> > 
> > Recent changes to count number of matching symbols when creating
> > a kprobe event failed to take into account kernel modules. As such, it
> > breaks kprobes on kernel module symbols, by assuming there is no match.
> > 
> > Fix this my calling module_kallsyms_on_each_symbol() in addition to
> > kallsyms_on_each_match_symbol() to perform a proper counting.
> > 
> > Link: https://lore.kernel.org/all/20231027233126.2073148-1-andrii@kernel.org/
> > 
> > Cc: Francis Laniel <flaniel@linux.microsoft.com>
> > Cc: stable@vger.kernel.org
> > Cc: Masami Hiramatsu <mhiramat@kernel.org>
> > Cc: Steven Rostedt <rostedt@goodmis.org>
> > Fixes: b022f0c7e404 ("tracing/kprobes: Return EADDRNOTAVAIL when func matches several symbols")
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > Acked-by: Song Liu <song@kernel.org>
> > Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > (cherry picked from commit 926fe783c8a64b33997fec405cf1af3e61aed441)
> 
> I noticed this patch was added and then dropped in the 6.1 stable queue. Is there any issue with it? I'll fix it ASAP.

It broke the build.

