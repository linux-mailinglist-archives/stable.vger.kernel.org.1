Return-Path: <stable+bounces-132903-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35BAEA914A4
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 09:01:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5B26445BBA
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 07:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01FDC218AAF;
	Thu, 17 Apr 2025 07:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nppct.ru header.i=@nppct.ru header.b="ZfCkEqU5"
X-Original-To: stable@vger.kernel.org
Received: from mail.nppct.ru (mail.nppct.ru [195.133.245.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 306341BC9F4
	for <stable@vger.kernel.org>; Thu, 17 Apr 2025 07:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.133.245.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744873256; cv=none; b=EE/A38NQd8PdQmxzW+QLsDVNKr+WDT5fhCQ1id9ANntYw5WNEt6RsnZ2+FCNX4EffifwB4iGKdcQS6GmROIG259JwcbSpkQ9f6YoIsKIwzvzx6M26XSEWB5aSsxOtx1/YFGmksEFWkXbwy/zD7PCs6AGYdAsiZmpwZxwcWbQGaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744873256; c=relaxed/simple;
	bh=w5PRKU5sdEGDHRp4fP0Y606LJOfqnZ6orvNNl1CuqY8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kj2NV2NAK2WSypVGEpHXx+++h2iRavbtXNjgZc07V5ymwSuEtzuFs3WuvPgYtafo6yI9NbaCZfXkoCBVd5LeBQGJZ4S4dT4Xgo/V9zfHS81SYVyUCG8zxVwXwgrBNCPxKs2CLPSbeQmP2l5T0L3A+kQSBvg/KCmj8MXnpQpdPZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nppct.ru; spf=pass smtp.mailfrom=nppct.ru; dkim=pass (1024-bit key) header.d=nppct.ru header.i=@nppct.ru header.b=ZfCkEqU5; arc=none smtp.client-ip=195.133.245.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nppct.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nppct.ru
Received: from mail.nppct.ru (localhost [127.0.0.1])
	by mail.nppct.ru (Postfix) with ESMTP id 638131C0E89
	for <stable@vger.kernel.org>; Thu, 17 Apr 2025 10:00:47 +0300 (MSK)
Authentication-Results: mail.nppct.ru (amavisd-new); dkim=pass (1024-bit key)
	reason="pass (just generated, assumed good)" header.d=nppct.ru
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nppct.ru; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:to:subject:subject
	:user-agent:mime-version:date:date:message-id; s=dkim; t=
	1744873239; x=1745737240; bh=w5PRKU5sdEGDHRp4fP0Y606LJOfqnZ6orvN
	Nl1CuqY8=; b=ZfCkEqU5CLR6zk1GoYwHVG/iZlY0AdlFJg282mLJe4nkN2qZX1J
	Cb5rv4fUlmG1P2YEyKsMu8Dg5aPHoYiQE+ZY8WEobLCnQpD+MCp4f8QvbMU3FiGm
	5EISN9Iwymnq85CIrv+UGGuibFc6vtqHf850X3qrRslHFkKZR3iNYKKE=
X-Virus-Scanned: Debian amavisd-new at mail.nppct.ru
Received: from mail.nppct.ru ([127.0.0.1])
	by mail.nppct.ru (mail.nppct.ru [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 3L0rDhbMnOx4 for <stable@vger.kernel.org>;
	Thu, 17 Apr 2025 10:00:39 +0300 (MSK)
Received: from [172.16.0.185] (unknown [176.59.174.214])
	by mail.nppct.ru (Postfix) with ESMTPSA id 8B6BC1C08D8;
	Thu, 17 Apr 2025 10:00:23 +0300 (MSK)
Message-ID: <fa91aad9-f8f3-4b27-81b3-4c963e2e64aa@nppct.ru>
Date: Thu, 17 Apr 2025 10:00:22 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] xen-netfront: handle NULL returned by
 xdp_convert_buff_to_frame()
To: Jakub Kicinski <kuba@kernel.org>
Cc: Juergen Gross <jgross@suse.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, xen-devel@lists.xenproject.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 lvc-project@linuxtesting.org, stable@vger.kernel.org
References: <20250414183403.265943-1-sdl@nppct.ru>
 <20250416175835.687a5872@kernel.org>
Content-Language: en-US
From: Alexey <sdl@nppct.ru>
In-Reply-To: <20250416175835.687a5872@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 17.04.2025 03:58, Jakub Kicinski wrote:
> On Mon, 14 Apr 2025 18:34:01 +0000 Alexey Nepomnyashih wrote:
>>   		get_page(pdata);
> Please notice this get_page() here.
>
>>   		xdpf = xdp_convert_buff_to_frame(xdp);
>> +		if (unlikely(!xdpf)) {
>> +			trace_xdp_exception(queue->info->netdev, prog, act);
>> +			break;
>> +		}
Do you mean that it would be better to move the get_page(pdata) call lower,
after checking for NULL in xdpf, so that the reference count is only 
increased
after a successful conversion?

