Return-Path: <stable+bounces-76124-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B1B7978D73
	for <lists+stable@lfdr.de>; Sat, 14 Sep 2024 07:02:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 309FE1F245AC
	for <lists+stable@lfdr.de>; Sat, 14 Sep 2024 05:02:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15C1F1A269;
	Sat, 14 Sep 2024 05:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="3U5qM59Y"
X-Original-To: stable@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA3BB17BA7;
	Sat, 14 Sep 2024 05:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726290157; cv=none; b=KDKsOM0mGzGnn4M7BHHtGhASfWKjPdVffseQAa3nKqCvke5RO8HCKRxzQZgDVC7BRACm6NPQvjSVNOcDaE1xlR8ix1KoCwHfDXhqZL3IYZ4dC8Zd3FalaqZBFEENfR0PbgqYiA6KyU7bQtv/LyxQEuyZlJkW5eKpPlZgowz3ytk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726290157; c=relaxed/simple;
	bh=SxC01V8/TmXQtXBzz/ZQO3nY/ChKsbJJ5/Wc7rTvnCc=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=lo+uh7To8NIYDp4vR5HZCjAMcRDfqwxKossjPlfY8/i0O30wJzIzy4kRQHTSPfr9GDoju/87VzQBVaoXjV+RFiNdkp26ssBoQ6A89SLNK5uQdZrrt6+CmIKCWTksCXsrKr9Dtv0IUOvHCSRXSjq+rkRQW9v3Tadwz9xFHozvTyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=3U5qM59Y; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:Subject
	:Cc:To:From:MIME-Version:Date:Message-ID:From:Sender:Reply-To:Subject:Date:
	Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=OLPaw2HIKIKnEngBpBW8Aq/vfCrhV9yI1WiUx6mDo/Q=; t=1726290155; x=1726722155;
	 b=3U5qM59YdqngpdJpYbGsu6HQY3/NuwjLmyafNpNb5g2oMcl9zpuZBMewcs2T66Jp2LfyhOrK4M
	sDhBhsByzQbN88Z6d005NaUdJr9BF/gJ71JIz7l/2U5yYdHUuckBlNjl9ASmJNMceCIiW0J7zSYpo
	6u0W9TI7aOFa4yWrfkAxG7g2xqWXLIstZbhI/1b/Q9lbraeJMfOItXVMsVWQxxUED++XOygFujnQo
	uzpGd6JDvUTABSfFwzRDdKbrOLGcWmQ0dPe7vV4172Ny2P4uiilgMqNv3+FNa1ualjAtfyp8UZvil
	BXxlpsvQ0kC2KUddM2pxJVTE3Y8LYydIUy5tQ==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1spKvT-0005lu-EJ; Sat, 14 Sep 2024 07:02:27 +0200
Message-ID: <bd49aa81-338f-4776-8c45-7c79945c0a81@leemhuis.info>
Date: Sat, 14 Sep 2024 07:02:26 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: en-US, de-DE
To: Greg KH <gregkh@linuxfoundation.org>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>,
 Linux kernel regressions list <regressions@lists.linux.dev>,
 Sasha Levin <sashal@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Bug 219269 - v6.10.10 kernel fails to build when CONFIG_MODULES is
 disabled
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1726290155;9f318e45;
X-HE-SMSGID: 1spKvT-0005lu-EJ

Hi Greg! I noticed a bug report in bz:
https://bugzilla.kernel.org/show_bug.cgi?id=219269

> Fair enough, you get a compiler warning:
> 
> kernel/trace/trace_kprobe.c: In function ‘validate_probe_symbol’:
> kernel/trace/trace_kprobe.c:810:23: error: implicit declaration of function ‘find_module’; did you mean init_module’? [-Wimplicit-function-declaration]
>   810 |                 mod = find_module(modname);
>       |                       ^~~~~~~~~~~
>       |                       init_module
> kernel/trace/trace_kprobe.c:810:21: error: assignment to ‘struct module *’ from ‘int’ makes pointer from integer without a cast [-Wint-conversion]
>   810 |                 mod = find_module(modname);
>       |    
> 
> but there is no find_module symbol when CONFIG_MODULES is disabled.

I *very briefly* looked into this. I might be wrong, but looked a bit
like "tracing/kprobes: Add symbol counting check when module loads"
caused this and backporting b10545b6b86b7a ("tracing/kprobes: Fix build
error when find_module() is not available") [v6.11-rc1] would fix this
(which applies cleanly).

Shall I ask the reporter to confirm or is that already enough for you?

Ciao, Thorsten

