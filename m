Return-Path: <stable+bounces-98264-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FAAA9E36D8
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 10:42:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C057161A83
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 09:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 350E01AA7B4;
	Wed,  4 Dec 2024 09:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KskDMryS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE6991A9B5D;
	Wed,  4 Dec 2024 09:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733305316; cv=none; b=p5cflscH9WcsN+6ZYHsT/yWQ3p/AQkxNqJ/ytTnAHHg6z1RZnxyQUHvHgVTusREPD17JOJ1zAU/IETc5XEuWibYIL2xGq9eXGnFpdwvjQ0/u3+enmrgqK/tQ1cDLG1VObhj/tGIT76J+sNUr8rXe0Xrk5+zmObNcRMYEGWfQSxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733305316; c=relaxed/simple;
	bh=ACL3HE7Q4RL5zEoxWfj1csSV0M3cM0i5iJau9yPsRbQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PNXfb9MbPr9vOdgFEaJvWhGrn6Cw8JfwcF0V3Vfd8MXLfthrfDlwRxbnAP7s+kVERYKwUaPr5D5jwTttKJOtuUNe9kcXBEzjEODc9t0uJu6iR3K3mpTES23pRQMAG6EEbzp6yizOGhvw5B0tfIqnacRQelj4NKlCKukFJotHT/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KskDMryS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8C3DC4CED1;
	Wed,  4 Dec 2024 09:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733305315;
	bh=ACL3HE7Q4RL5zEoxWfj1csSV0M3cM0i5iJau9yPsRbQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KskDMryS2g7bjDIh2qrrvQKIR/V3riva/+JSNvSIlX2iwujn3JDhvF23j+KY9/IQl
	 vRD3hRIbMGCReI/C3qyVZILwG2yXhHKzjMz6t/aERT3Xp4Gj7tMFJZ3uN3dSMYe9sH
	 Rp74/xdyj9WZhaYJEWCw1AIcgRdt8pfGcfmHvQ38=
Date: Wed, 4 Dec 2024 10:41:52 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: wzs <wangzhengshu39@gmail.com>
Cc: rafael@kernel.org, akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: kernel v6.7 warn in add_uevent_var: buffer size too small
Message-ID: <2024120410-overact-rocking-fe93@gregkh>
References: <CAGXGE_JSs1iBw+EtZxsXvRrcNCmpiNFh-xFGOyzuPzXNwTatCA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGXGE_JSs1iBw+EtZxsXvRrcNCmpiNFh-xFGOyzuPzXNwTatCA@mail.gmail.com>

On Wed, Dec 04, 2024 at 05:29:26PM +0800, wzs wrote:
> Hello,
> when fuzzing the Linux kernel 6.7.0,
> the following crash was triggered.
> 
> kernel config :  https://pastebin.com/3JeQFdUr
> console output : https://pastebin.com/9ADtBQtP
> 
> Basically, we use gadget module to simulate the connection and interaction
> process of a USB device
> (device type code : 0003, vendor id : 046D, product id : C312, serial
> number : 27B4, with function : input event).
> 
> It seems to be caused by a mismatch between the uevent's environmental
> limit and the buffer size used to receive the uevent, which triggers such
> kernel warning.
> 
> The crash report is as follow:
> 、、、
>  [203835.102225] input: wingfuz Keyboard as
> /devices/platform/dummy_hcd.0/usb3/3-1/3-1:1.0/0003:046D:C312.27B4/input/input5893
>  [203835.155527] ------------[ cut here ]------------
>  [203835.155533] add_uevent_var: buffer size too small
>  [203835.162092] WARNING: CPU: 11 PID: 57434 at lib/kobject_uevent.c:671
> add_uevent_var+0x2fe/0x390

I think this is already fixed in newer kernel versions.  6.7.0 is very
old and obsolete.  Can you test this on 6.12.1?

thanks,

greg k-h

