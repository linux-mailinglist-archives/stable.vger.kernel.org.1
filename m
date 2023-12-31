Return-Path: <stable+bounces-9138-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9660A820B6E
	for <lists+stable@lfdr.de>; Sun, 31 Dec 2023 14:10:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A75E8281B69
	for <lists+stable@lfdr.de>; Sun, 31 Dec 2023 13:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC9A33C13;
	Sun, 31 Dec 2023 13:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=in04.sg header.i=@in04.sg header.b="EJSqQHw4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BIoLjUa3"
X-Original-To: stable@vger.kernel.org
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74BB84418
	for <stable@vger.kernel.org>; Sun, 31 Dec 2023 13:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=in04.sg
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=in04.sg
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.west.internal (Postfix) with ESMTP id 05E3A3200A76;
	Sun, 31 Dec 2023 08:10:04 -0500 (EST)
Received: from imap47 ([10.202.2.97])
  by compute6.internal (MEProxy); Sun, 31 Dec 2023 08:10:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=in04.sg; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1704028204; x=1704114604; bh=H2x0Q38Wwf
	2qcQoO2ebpBNqiplIFrHytqmZUQrdmcLc=; b=EJSqQHw4eO1zVEEyhk1NkdzOFm
	cZ4bF/6NTsEN8vc4SAHzabzlUe2cNO4q7lIZVWB8di1/bYRn5+5peVC2ZiYT9Ldu
	wwVP+wBEDYpKQVZ28/MNQEuV3/Sx0Bl0AirpbN/0tz2H9hqpWJGWonROupUrPJfr
	XeBTDrMx8dsJGbyxo8NbEdGp3UibaxYUy6fosZh1SEud9fA89N4JBsujFE1WuRQv
	GR6BGTGbJDbVCp/fThDuIV8WFeIGBLiGnCbWafOxX6JFH+LTNIX/Soa601cVW9hW
	dwy2m5pEurgSJ5WJv/HMK+4nRvAKlLZXgnB/gfS3vxmdvm3OYouOsoCTA1YA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1704028204; x=1704114604; bh=H2x0Q38Wwf2qcQoO2ebpBNqiplIF
	rHytqmZUQrdmcLc=; b=BIoLjUa35fbeJJFxKEpHLXj0RMu31TmkxXujImejKI6n
	XMOe/BaHOfGGByg0VTx+F2AUM1mkQChTlxq8gAPn/FH6/SnhZFCxkH7afL/b8khC
	0dxHmg6Kxw1p6IR10BMfT8BLjwOS7qzR5FHf/YZNtamHe5v/90wxBZFIPQhW6VXw
	qg9ObO29sceBiCwaZpyLFTXSGxuSMXRNxnf6hhMMqmeJJ9ZCJFQwk09i3Fl/aaXY
	+2i9eZMcaRhCcbcunoGvgDbklP1FD2tnhjwYDmw/fmjiqxX0RXqcYrkxfLiaz8EX
	Ng+MSGrScL5Ker/FfblXWhxYXji8m7fDMe9rPP1ATw==
X-ME-Sender: <xms:LGiRZYLpk0UgoLm0y6TdcdedRtbj7cb4kXPqnUS4IilNUjWbR96Q2w>
    <xme:LGiRZYJUk8sshGpZTRMp96GzGvzWm4jPJ2hqB63Gy3JrVoH1I6YS81NiqJqZNCrWp
    HEBVQiffMVv4I2vXsA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdefkedgvdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedfvfgv
    vgcujfgrohcuhggvihdfuceorghnghgvlhhslhesihhntdegrdhsgheqnecuggftrfgrth
    htvghrnhepvefgtdfggeeifeeufedvgeejvdevvdeffeejffeujeeuffeifedujedutefg
    teeknecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrnhhgvghlshhlsehinhdtgedrshhg
X-ME-Proxy: <xmx:LGiRZYsf4KZRp5Pr7YAhx-JFpdsqVFu80RbkcMjCQRORlg9CFzfKHQ>
    <xmx:LGiRZVa8y0yn722wIi5veY_lGsIx2T8j4aCkNbW85wpXbUpwGplDrQ>
    <xmx:LGiRZfY4gC3MCU470NuFm_ELm-rLOqhPA-dUPhkmhFH2XXZNt4prOw>
    <xmx:LGiRZeVo8TD6Sk2Q423A9V85WSoA4nW2XicsM-bVtqMsTprKFJR2Vg>
Feedback-ID: id6914741:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 30BA8A60078; Sun, 31 Dec 2023 08:10:04 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1364-ga51d5fd3b7-fm-20231219.001-ga51d5fd3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <279de9e4-502c-49f1-be7f-c203134fbaae@app.fastmail.com>
In-Reply-To: <20231220170016.23654-1-angelsl@in04.sg>
References: <2023102922-handwrite-unpopular-0e1d@gregkh>
 <20231220170016.23654-1-angelsl@in04.sg>
Date: Sun, 31 Dec 2023 21:09:36 +0800
From: "Tee Hao Wei" <angelsl@in04.sg>
To: gregkh@linuxfoundation.org
Cc: "Andrii Nakryiko" <andrii@kernel.org>,
 "Francis Laniel" <flaniel@linux.microsoft.com>,
 "Masami Hiramatsu" <mhiramat@kernel.org>,
 "Steven Rostedt" <rostedt@goodmis.org>, "Song Liu" <song@kernel.org>,
 stable@vger.kernel.org
Subject: Re: [PATCH 6.1.y] tracing/kprobes: Fix symbol counting logic by looking at
 modules as well
Content-Type: text/plain

On Thu, 21 Dec 2023, at 01:00, Hao Wei Tee wrote:
> From: Andrii Nakryiko <andrii@kernel.org>
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
> (cherry picked from commit 926fe783c8a64b33997fec405cf1af3e61aed441)

I noticed this patch was added and then dropped in the 6.1 stable queue. Is there any issue with it? I'll fix it ASAP.

Thanks.

-- 
Hao Wei

