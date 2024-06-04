Return-Path: <stable+bounces-47924-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F10E38FB39D
	for <lists+stable@lfdr.de>; Tue,  4 Jun 2024 15:24:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A921528844D
	for <lists+stable@lfdr.de>; Tue,  4 Jun 2024 13:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76996146A6B;
	Tue,  4 Jun 2024 13:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="S/Lj+JzM"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87664146587;
	Tue,  4 Jun 2024 13:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717507485; cv=none; b=IlhNhyZVWOYqasWDVhrPdOkx8HjHegxL9ttbSci57UdoCAT+jOCuzn8jPjSvrZJA2q7i4J24gr6OLry0qs0BW/ebytWsLgDw4keRH/e5iZYCbb5ZGhKoktYBxJl41oiY3SxA1umAy+/YF1nWAyU8Z44J7TH2QGsXJxBBJlqSwgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717507485; c=relaxed/simple;
	bh=cupXqcFF9fa59A9+cgbWg+iQop5ZvtZxHIDzCVlCOgA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Ywzocuy0rxI2yJUH6hK1XxB3fphzifkUzpfSymSrsRaLeQcChaazC1BLc03ZHEVXn3J9YP1QIMkzwfJRZAVbGdba2G5KQrZc4W5fmL0dXopr+QkESkgy35CGFWhRsRXPgIE1EjfM0rqBnNr3HZmwnnvxELjR1Zy3ciCoVWXt0vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=S/Lj+JzM; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:From:Subject:
	Content-Type; bh=t+6uf2ZT2trzXSMZhwTL2CGLO411ioJ/4VBZBE+VM2w=;
	b=S/Lj+JzMfHO2B96kre5fWy+jA8lN2dNCKjWdqrgjZYYZJ8LCCsshDbmtnecPTE
	dOY24mCAwjbsbC1NSWbYOooxaJ30/kC6UyoExdy5ZuwxfveCLCmrIsPYjUAo5B1d
	OTt3cFGNz824lODk6cx14SCaGTLLl3jgRaOTjmf5unKps=
Received: from [192.168.1.26] (unknown [183.195.6.89])
	by gzga-smtp-mta-g2-4 (Coremail) with SMTP id _____wDHHyZjFV9muQnjBw--.50874S2;
	Tue, 04 Jun 2024 21:23:48 +0800 (CST)
Message-ID: <00c2798f-61d7-437e-8c12-e2872f4c2bc4@163.com>
Date: Tue, 4 Jun 2024 21:23:46 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Lk Sii <lk_sii@163.com>
Subject: Re: [PATCH v2] Bluetooth: qca: Fix BT enable failure again for
 QCA6390 after warm reboot
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Zijun Hu <quic_zijuhu@quicinc.com>, luiz.von.dentz@intel.com,
 marcel@holtmann.org, linux-bluetooth@vger.kernel.org, wt@penguintechs.org,
 regressions@lists.linux.dev, pmenzel@molgen.mpg.de,
 krzysztof.kozlowski@linaro.org, stable@vger.kernel.org
References: <1715866294-1549-1-git-send-email-quic_zijuhu@quicinc.com>
 <f343ecae-efee-4bdc-ac38-89b614e081b5@163.com>
 <CABBYNZ+nLgozYxL=znsXrg0qoz-ENgSBwcPzY-KrBnVJJut8Kw@mail.gmail.com>
 <34a8e7c3-8843-4f07-9eef-72fb1f8e9378@163.com>
 <CABBYNZLzTcnXP3bKdQB3wdBCMgCJrqu=jXQ91ws6+c1mioYt9A@mail.gmail.com>
 <f7a408b4-ccef-4a4c-a919-df501cf3e878@163.com>
 <ca7adc9d-9df3-4050-8943-3c489097b995@163.com>
 <CABBYNZJwPr_1u+NYnAVaPOd+Wkrb9Jz40hjWF_8v6p6tTaZjtg@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CABBYNZJwPr_1u+NYnAVaPOd+Wkrb9Jz40hjWF_8v6p6tTaZjtg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDHHyZjFV9muQnjBw--.50874S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUa5ETUUUUU
X-CM-SenderInfo: 5onb2xrl6rljoofrz/1tbiEwjzNWXAldQ0eQAAs0



On 2024/6/4 03:27, Luiz Augusto von Dentz wrote:
> Hi,
> 
> On Thu, May 30, 2024 at 9:34 AM Lk Sii <lk_sii@163.com> wrote:
>> @Luiz:
>> do you have any other concerns?
>> how to move forward ?
> 
> Well I was expecting some answer to Krzysztof comments:
> 
> No, test it on the mainline and answer finally, after *five* tries, which
> kernel and which hardware did you use for testing this.
> 
That is wonderful, let us solve Krzysztof's concerns containing above
one mentioned.


