Return-Path: <stable+bounces-47704-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 25C478D4BC9
	for <lists+stable@lfdr.de>; Thu, 30 May 2024 14:43:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ABA27B21945
	for <lists+stable@lfdr.de>; Thu, 30 May 2024 12:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F25C132123;
	Thu, 30 May 2024 12:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="NPx7Ho5a"
X-Original-To: stable@vger.kernel.org
Received: from omta40.uswest2.a.cloudfilter.net (omta40.uswest2.a.cloudfilter.net [35.89.44.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2EB4132113;
	Thu, 30 May 2024 12:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717072993; cv=none; b=KxfGVlgLTnRABKQQMlbjEf4HyYkx+EIqE2FT70j8zrIRN8TnpZz2yoLPJXViCf3uemNaKJYetOAQUwaEjn6LQCff6Akd9a/dZBdHg+uW33sR1ovZoAPiXGsKvi0rf5FK9BMBH+mOTSUs/p6VOxkS9IJ6rKgKWGDMe+j65+Vg8n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717072993; c=relaxed/simple;
	bh=WezqI/UOXVIpTjMJypNZUq8DzqVTPIr5eJy3W7G97Rw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OOThUWJY/e8aha40Sr9jAroFBVXD9fjtwo0KAijgGiKTGHNUR+DWfavg3a55rFLhyo52Q/SQXNlh0Nkve6jlxe/bK3J54Cm/0clsjN2zWytghSVBJSJOLiJA07lhsUSMBx9TPqnIY2DknpxseVt4+zVm9QNR151RKW/slGsM6zM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=NPx7Ho5a; arc=none smtp.client-ip=35.89.44.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-5004a.ext.cloudfilter.net ([10.0.29.221])
	by cmsmtp with ESMTPS
	id CWxPsEM3QrtmgCf7csPyJk; Thu, 30 May 2024 12:43:09 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id Cf7bs1e7pGDo0Cf7bsN0Um; Thu, 30 May 2024 12:43:07 +0000
X-Authority-Analysis: v=2.4 cv=I+uuR8gg c=1 sm=1 tr=0 ts=6658745b
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=7eglLlv4HFOW3sTsDH6Jqg==:17
 a=IkcTkHD0fZMA:10 a=TpHVaj0NuXgA:10 a=wYkD_t78qR0A:10 a=VwQbUJbxAAAA:8
 a=NEAV23lmAAAA:8 a=nG3MMMVrgEngwwIGFzYA:9 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=veiVKH1vZWe9V2vON8q6NViu4bLJsZtyTGLVtkgabHg=; b=NPx7Ho5a5jQRoP/g1eCjaTAmwc
	G7ARIO3jxIMb7kKvdbCsbzwDL8MGIGFkvjnX3nsl/AEEHVnAPPMsTNlLdoW4dIOZWRL/Zf+2FPgtb
	ZsJ8witC9l1Nmung92orCnCv92dQN6R63fhvbRvN27erCdjoOv7guq+XoRNqx7KoC0pWe3CiRBdO7
	tDSjnjeydGCtZuZ7FZLjjqCmPQEb3nuT6DyqwKCP6ZG/yI5NxKroCkrt5h7zpuZIN6KycKX8CM0zt
	gVZyP6TiUSkbhxSnkYCLdJ8LoWnqYu679pdn7rtF2cVysMQ+gwJuBQ+1VsM/A5Vhbj9MTq2XQWdWt
	UAxYvSbg==;
Received: from d58c58c2.rev.dansknet.dk ([213.140.88.194]:38800 helo=[10.0.0.182])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1sCatX-000JCm-2c;
	Thu, 30 May 2024 03:12:20 -0500
Message-ID: <09445a96-4f86-4d34-9984-4769bd6f4bc1@embeddedor.com>
Date: Thu, 30 May 2024 10:12:13 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tty: mxser: Remove __counted_by from mxser_board.ports[]
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Nathan Chancellor <nathan@kernel.org>
Cc: Kees Cook <keescook@chromium.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 linux-serial@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-hardening@vger.kernel.org,
 llvm@lists.linux.dev, patches@lists.linux.dev, stable@vger.kernel.org
References: <20240529-drop-counted-by-ports-mxser-board-v1-1-0ab217f4da6d@kernel.org>
 <d7c19866-6883-4f98-b178-a5ccf8726895@kernel.org>
 <2024053008-sadly-skydiver-92be@gregkh>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <2024053008-sadly-skydiver-92be@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 213.140.88.194
X-Source-L: No
X-Exim-ID: 1sCatX-000JCm-2c
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: d58c58c2.rev.dansknet.dk ([10.0.0.182]) [213.140.88.194]:38800
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 0
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfHr2i5KQWxG0dMhbO6GVbp57V1oMLeUbFQInCQMUdSbmUdLGWpcrf45MFR2BsogghEgfIkba2KkVNpCIrffq9FwYQtz6E2NjhNtBt1Jsu/ilWCH7tHoC
 0QY5T/sNulM923Ik0h/AS4W7/OrBI3v7EXHFmx3Hvo9Pwza1/VpaH7ny0XPYBWSLz6KOuemVkK8NIsTO/JfvPiStKd6mQbQ9M52nknl7NUEiT5ZyqCz5LarF
 Hu/7iviLfYF2ICU/0OlejA==



On 30/05/24 09:40, Greg Kroah-Hartman wrote:
> On Thu, May 30, 2024 at 08:22:03AM +0200, Jiri Slaby wrote:
>>>   This will be an error in a future compiler version [-Werror,-Wbounds-safety-counted-by-elt-type-unknown-size]
>>>       291 |         struct mxser_port ports[] __counted_by(nports);
>>>           |         ^~~~~~~~~~~~~~~~~~~~~~~~~
>>>     1 error generated.
>>>
>>> Remove this use of __counted_by to fix the warning/error. However,
>>> rather than remove it altogether, leave it commented, as it may be
>>> possible to support this in future compiler releases.
>>
>> This looks like a compiler bug/deficiency.
> 
> I agree, why not just turn that option off in the compiler so that these
> "warnings" will not show up?

It's not a compiler bug.

The flexible array is nested four struct layers deep, see:

ports[].port.buf.sentinel.data[]

The error report could be more specific, though.

--
Gustavo

> 
>> What does gcc say BTW?
>>
>>> Cc: stable@vger.kernel.org
>>> Closes: https://github.com/ClangBuiltLinux/linux/issues/2026
>>> Fixes: f34907ecca71 ("mxser: Annotate struct mxser_board with __counted_by")
>>
>> I would not say "Fixes" here. It only works around a broken compiler.
> 
> Agreed, don't add Fixes: for this, it's a compiler bug, not a kernel
> issue.
> 
> thanks,
> 
> greg k-h
> 

