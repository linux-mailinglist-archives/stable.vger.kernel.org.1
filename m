Return-Path: <stable+bounces-124752-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5091BA661F1
	for <lists+stable@lfdr.de>; Mon, 17 Mar 2025 23:48:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 399783B42E0
	for <lists+stable@lfdr.de>; Mon, 17 Mar 2025 22:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3F4D1FFC55;
	Mon, 17 Mar 2025 22:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="145oZ/59"
X-Original-To: stable@vger.kernel.org
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C5A1DE3CB;
	Mon, 17 Mar 2025 22:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742251726; cv=none; b=QyJ9dK12gPyg4+36dRwvUBvfOXOzk0ikj7ZLH3a9VdDg9JzXMlsslx+Pd5pOb+jKDVACw4T9eioV0Q1DpQW85D4ObjHeMDi7wZQhheHqA4bhCoYf+3FevS2S7MOVTT40p5n4BKU9xncuWtfbvJIlSZFXc5uqbtPMKTrZYmokdTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742251726; c=relaxed/simple;
	bh=ioTnEAuhr3Pub8Z9EfYIwul2H8ShlzATvu1Td70qjTk=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=AX6l80AOt+prp0BK6/4ByxTF0hRKsLRDCTopqJa42WZPFyHWuO5UbJ5xdIoq8fXg5C7YrNWmLikCtWR1W5A0L3LMJUEVNiWrrrwOj4SQx2kJopMAJ6fCAP+O1e2y/XxBnCTOu9lJNZXvVHkAPtxhkId7CpQHj1I33WNExyGyMEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=145oZ/59; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 61DE711401FD;
	Mon, 17 Mar 2025 18:48:43 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Mon, 17 Mar 2025 18:48:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1742251723; x=1742338123; bh=R1vaJFtFdJW8YWR8qMo2bNDCNqTwTcZARad
	vxpaOfME=; b=145oZ/59WJ4ni4RaK4uhJiEFFhRV97I0tCa4ETLMCzlrpl91Qpf
	6sc3fVJSZ7qC6/VBO9zSSvJ5pNolKGVb09S0VD/cZb8gtuuDvBPXb4BlM43xA3AQ
	Djl4+TvoIu9gtpm+c3dmk4nKcA4LKxIuTE7IQFaYl288/m1H3MlnTiQeRf1jeBP6
	mXR3CjF398r/EJ4iL6nF1WwW0AAo36beFvPDUn74vYsrL2k8KY7Xvs7dS+xB6xsT
	69+SsGMxzVn9qbzU1Px37wxCk7ctdgrBuElPBoAHX2+wWEX0ghaN6hls3MwAUn7e
	HPM+9m5P9r2QFRUKl1XCfRTrHAGBxpLOUsg==
X-ME-Sender: <xms:yqbYZxsJPxNzqKZpqXms7lnnXCN1fCLivLdSG4yzyL5i1ycQJaQybg>
    <xme:yqbYZ6c-3-r3PrPjZZLuxg-C2SomgvjLyBTpNbk6N7SV1CtC_YGSwiniDDx6qFA9l
    1GuRL2SjP9iFDx2kXU>
X-ME-Received: <xmr:yqbYZ0wPrB7rEHw0qsS_EDx2ZtIUwLFjgz1ykBB3uIGn8mlAeJexsG2mc2KpFe9UyQYIQFcR60dFC7JZQmvL3SjbnFni4YfAMkM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugedtjeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevufgjkfhfgggtsehttdertddttddv
    necuhfhrohhmpefhihhnnhcuvfhhrghinhcuoehfthhhrghinheslhhinhhugidqmheike
    hkrdhorhhgqeenucggtffrrghtthgvrhhnpeffiefhudeggfefgeejleekfedtkefgudev
    ueeguedvffeukeetvdfffeefledvkeenucffohhmrghinhephhgvrggurdhssgenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehfthhhrghinhes
    lhhinhhugidqmheikehkrdhorhhgpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmth
    hpohhuthdprhgtphhtthhopehgvggvrhhtsehlihhnuhigqdhmieekkhdrohhrghdprhgt
    phhtthhopehsthgrsghlvgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hlihhnuhigqdhmieekkheslhhishhtshdrlhhinhhugidqmheikehkrdhorhhgpdhrtghp
    thhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:yqbYZ4M39OseBdSKpG9v-NWHlMNAru5VXKg4SyRSlaItdx3MtFQP2Q>
    <xmx:yqbYZx8Z4-PfwZmDanSIyXKRU5VXqfPFx9Bq6eoFqFLcjGvZCtrNEg>
    <xmx:yqbYZ4UovpuNJ65Sh8FU-sZ81ltzpXa3fD01tN8wdGokbbn1fInVFQ>
    <xmx:yqbYZydQmEvtCkg9EfqNARPQRqEQZpeB5xXf4PVxcR2w-80RTjMOfg>
    <xmx:y6bYZ8Y5j4pQXfEeSuNUqwnvw7TF6YsaRTa8TcnJ_bhiHpLNCb0Tg0X0>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 17 Mar 2025 18:48:41 -0400 (EDT)
Date: Tue, 18 Mar 2025 09:48:40 +1100 (AEDT)
From: Finn Thain <fthain@linux-m68k.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: stable@vger.kernel.org, linux-m68k@lists.linux-m68k.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH] m68k: Fix lost column on framebuffer debug console
In-Reply-To: <c03e60ce451e4ccdf12830192080be4262b31b89.1741338535.git.fthain@linux-m68k.org>
Message-ID: <b504b718-0ffb-ff28-0c91-badf92282b32@linux-m68k.org>
References: <c03e60ce451e4ccdf12830192080be4262b31b89.1741338535.git.fthain@linux-m68k.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII


Please disregard the patch below. Further testing shows that it does not 
completely solve the problem. In particular, when line-wrap also produces 
vertical scrolling. I think the recursive console_putc call may have to 
go.

On Fri, 7 Mar 2025, Finn Thain wrote:

> When long lines are sent to the debug console on the framebuffer, the
> right-most column is lost. Fix this by subtracting 1 from the column
> count before comparing it with console_struct_cur_column, as the latter
> counts from zero.
> 
> Linewrap is handled with a recursive call to console_putc, but this
> alters the console_struct_cur_row global. Store the old value before
> calling console_putc, so the right-most character gets rendered on the
> correct line.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Signed-off-by: Finn Thain <fthain@linux-m68k.org>
> ---
>  arch/m68k/kernel/head.S | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/m68k/kernel/head.S b/arch/m68k/kernel/head.S
> index 852255cf60de..9c60047764d0 100644
> --- a/arch/m68k/kernel/head.S
> +++ b/arch/m68k/kernel/head.S
> @@ -3583,11 +3583,16 @@ L(console_not_home):
>  	movel	%a0@(Lconsole_struct_cur_column),%d0
>  	addql	#1,%a0@(Lconsole_struct_cur_column)
>  	movel	%a0@(Lconsole_struct_num_columns),%d1
> +	subil	#1,%d1
>  	cmpl	%d1,%d0
>  	jcs	1f
> -	console_putc	#'\n'	/* recursion is OK! */
> +	/*	recursion will alter console_struct so load d1 register first */
> +	movel	%a0@(Lconsole_struct_cur_row),%d1
> +	console_putc	#'\n'
> +	jmp	2f
>  1:
>  	movel	%a0@(Lconsole_struct_cur_row),%d1
> +2:
>  
>  	/*
>  	 *	At this point we make a shift in register usage
> 

