Return-Path: <stable+bounces-87654-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21A2E9A95FA
	for <lists+stable@lfdr.de>; Tue, 22 Oct 2024 04:07:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB03A1F22597
	for <lists+stable@lfdr.de>; Tue, 22 Oct 2024 02:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F212413957B;
	Tue, 22 Oct 2024 02:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="FsQoOP9Q"
X-Original-To: stable@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4518F1E51D
	for <stable@vger.kernel.org>; Tue, 22 Oct 2024 02:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729562850; cv=none; b=E1U8HR1Q/CcFrBPylOmTtjVEDJyKNXKTCgWDy2jTL9J2eRh0L/DskFz2bBuz1uJjB9Q9mPrC4M46iim2lnWE1TXOOmpBHGSUVeYh7WnomHQpWfHJ6wW0szBaU1T2OEWHRIC4WzvLjjh7AEInyH9naNiXfoZX5iQTV937V/0QZ+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729562850; c=relaxed/simple;
	bh=BHFDBHmXrFVTq2LDr69fRgXZNPDCVTVOX0JKjSQ7ULY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RIG9OEYXpCAWfuC0uR3NEqb1XRV1JKpPO6v0l+/nZadu//X5lChKgFCf4UfgtaRGpbmcWqwbIhFkc1YDs1LlwK1Htb10DH15SpUdPoysFGPrJ01sDfBTXXLaMyeqXRY0Soj4KCwEiIVVgoP243WNHJcMDTajFwPCOzM2gNP/N50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=FsQoOP9Q; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 417A388F4B;
	Tue, 22 Oct 2024 04:07:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1729562847;
	bh=Ic1GVRm0FdHiv/nv30FttgeCaj6pILjNQDk2SrvbxWs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=FsQoOP9Q4UsGzjS29tRr+JFmLwrUlOSgGl9Lu4Jwa/PditJ3ax5/ykFdSunxCDAty
	 +Ot6aZmbb96x8XJqUUFa0Wi36oF69//KV1Khc0XJDq/i/w+vqzMN+WfASZW1FTCimk
	 nRt3bSfc2oxZ+poVyVgfQ96M4L+drUQKOFS30rBIau4QTcHmSeIb06pdtxSCNRVPeA
	 Jhqk2xIl6MO/LyaKPVTntUCHG38n/32tdX7GNYz/ZvUpqYAc4jzMaagzPzf0BWYgcX
	 Be2ACxrnoSkq//fXEZo+oXivcooGgueq39+aunj1FxnnkZYj0DgauHUeYe0veGqX1A
	 7kfusP8MiBBtA==
Message-ID: <1bfcbff2-cf9f-490b-a537-7ee51ddda049@denx.de>
Date: Tue, 22 Oct 2024 00:42:33 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: FAILED: patch "[PATCH] serial: imx: Update mctrl old_status on
 RTSD interrupt" failed to apply to 6.6-stable tree
To: gregkh@linuxfoundation.org, esben@geanix.com, stable@kernel.org
Cc: stable@vger.kernel.org
References: <2024102153-fiddling-unblended-6e63@gregkh>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <2024102153-fiddling-unblended-6e63@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 10/21/24 9:53 AM, gregkh@linuxfoundation.org wrote:
> 
> The patch below does not apply to the 6.6-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
> 
> To reproduce the conflict and resubmit, you may use the following commands:
> 
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
> git checkout FETCH_HEAD
> git cherry-pick -x 40d7903386df4d18f04d90510ba90eedee260085
I just tried it on 6.6.57 , the patch cherry-picks cleanly:

$ git reset --hard v6.6.57 ; echo ; git cherry-pick -x 
40d7903386df4d18f04d90510ba90eedee260085
HEAD is now at e9448e371c87c Linux 6.6.57

Auto-merging drivers/tty/serial/imx.c
[detached HEAD c75708544badb] serial: imx: Update mctrl old_status on 
RTSD interrupt
  Date: Wed Oct 2 20:40:38 2024 +0200
  1 file changed, 15 insertions(+)

