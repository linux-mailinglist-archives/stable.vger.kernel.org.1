Return-Path: <stable+bounces-68045-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FC3495305F
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 15:42:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0788FB21717
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 13:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 953F619DF58;
	Thu, 15 Aug 2024 13:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="Bq41KcuO"
X-Original-To: stable@vger.kernel.org
Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974691714A8
	for <stable@vger.kernel.org>; Thu, 15 Aug 2024 13:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723729324; cv=none; b=gC5L6IV1kNrUToHhF88WDjNo5XSmdwM+IrJV7aGKnNmM0ZfdlpgOjX5DUidUYQvF6vEoVqw0b+bL1sqrrscFr9bGzzIRwnBLfU6KtBroigtmQJ3luKt/egwqy+XzQtZ9WsAQtklidIlDdkEihmcWxw+u8B1TjZxZYDmSBSKBgbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723729324; c=relaxed/simple;
	bh=WsmPYdjM3t0L/W4ViuIdjVED78UDOOasuWoKZjTtMvE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eLaIoNk8QUkhnRYrsfoRNQCv0/tP6KSOXKh8M288X9txjNKyeZfEYJU+KAoU4QHRyLgwBUKEoZYlbWuSsgaaXbP/8nnUaWNMi7dQb8hRXlMXrZCXo4mwHhlrMcgq2pFWKfCnHBSLN78hdc/I8f4EwkU34XqZfT79wGGL4yttSKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=Bq41KcuO; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4Wl5rh3BwSzlgT1H;
	Thu, 15 Aug 2024 13:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1723729315; x=1726321316; bh=WsmPYdjM3t0L/W4ViuIdjVED
	78UDOOasuWoKZjTtMvE=; b=Bq41KcuOIfQMbB2ycjicRZ5cO7Tq5Ei9nZo4i4Nr
	w2xOCy+LNTztGirqY6ORVbEHHTcaoPSK7ytbvZ2c1FyRuLDAQKoeRpBB4h7whlR0
	YXSI5B470bBEQQpkLJZ27yeuwmhwyXqWxxOIq631b5MdgqpWBI9YZCjBVibxlLNg
	G9+7gAteYIIpu5MLu7Q46rN3cyCAM/WptrZpngnsw7jVf5UDcg1EmP6sFnhCM/LH
	dHqIGOTcp4q6IUq8BtZLiImCxEjQmfBsvUqxnI7QhhyOMg8y1ZN1u/Mo1ZR6jOHo
	yyfhPpp61mf5WonR9LiaT/j3luzGUx1+VRiH6LKkS99pJQ==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id AqG-30HdzS38; Thu, 15 Aug 2024 13:41:55 +0000 (UTC)
Received: from [192.168.51.14] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4Wl5rd4QZqzlgVnW;
	Thu, 15 Aug 2024 13:41:53 +0000 (UTC)
Message-ID: <44c8337f-2ce7-48ae-bed5-d5f454e34b3b@acm.org>
Date: Thu, 15 Aug 2024 06:41:45 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 1/2] genirq/cpuhotplug: Skip suspended interrupts when
 restoring affinity
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: David Stevens <stevensd@chromium.org>,
 Dongli Zhang <dongli.zhang@oracle.com>, Thomas Gleixner
 <tglx@linutronix.de>, stable@vger.kernel.org
References: <20240814182826.1731442-1-bvanassche@acm.org>
 <20240814182826.1731442-2-bvanassche@acm.org>
 <2024081532-excluding-subpanel-2424@gregkh>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <2024081532-excluding-subpanel-2424@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/15/24 1:35 AM, Greg Kroah-Hartman wrote:
> When forwarding patches on from others, you always have to sign off on
> them :(

I will keep this in mind for the future. If the patch can still be
modified, feel free to add my signed-off-by to both patches in this
series:

Signed-off-by: Bart Van Assche <bvanassche@acm.org>

Thanks,

Bart.


