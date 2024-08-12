Return-Path: <stable+bounces-67367-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 684C294F535
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 18:48:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0384BB217E2
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 16:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72F5B187328;
	Mon, 12 Aug 2024 16:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=rwarsow@gmx.de header.b="l6we3NDL"
X-Original-To: stable@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F2218754E;
	Mon, 12 Aug 2024 16:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723481323; cv=none; b=X3dtJ2XUSh2PN1p2bdfHoKhMSm70PfZFLHTJEYV/FLjq6pQI0MRgc5qbuLX3y9NVt8Lfmy1wWuaPZjwXmAsRvkJdmNhcBD+JMGJisyIXdlOWGeVocOiShuZMUEnWiuF0dY6VKmAtcd9Jr9Zqm6mdCnRf4WI/hySAC+mJDbvWERw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723481323; c=relaxed/simple;
	bh=HtuFhXI63urBA3dRKYyXQ6GHreCYVeNttV6YM+zDLlM=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=CCwLm2LLv+QlCAKhqRlGqwKFqQGmNrIzentFOZ/UylXWKSaBHRCZTaUUyddNnWHzaVsuYXyH4rUUMvfDGxrLM6lPOj/HLLOjbp4NpHhNwIaS0RJlFDqohfDSePJ68QfZ6oRpcNeK/OJx4+qh71GG4FgcL6cOvzZxVeAgCsZ9q5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=rwarsow@gmx.de header.b=l6we3NDL; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1723481317; x=1724086117; i=rwarsow@gmx.de;
	bh=HtuFhXI63urBA3dRKYyXQ6GHreCYVeNttV6YM+zDLlM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:From:To:Cc:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=l6we3NDL5vRvPSfK9bmgXjcpXzi+bWZDBuomZ7kpOm3jQbdIcab8xJoKFqV7qNA5
	 BQU7obcwPykaOqyk2Z27znSRk3uBYWmKvg4ux/1/z5eklVztmLkXAXTqQBQ/hWgtm
	 wXTOuBbBva/7knG6EkZVsPW5v83UMfpB6orLxZasCIDY5iAdhvosq0uVS/v+oI0jo
	 6BquBK1etY7zU6f6qTmfF7ogIJ3R0o6HmSNZPVMnpxalGreP0B36bGRnXNJQ+Zz04
	 0rx5QkAYnXY1YsC4f5U+oUa3HdhR0bI6OmOwE9cbnuWXZopW352ISBSom9d4OivDP
	 kusDvHwNd9Hqc2RUXg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.100.20] ([46.142.32.4]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Ma24y-1sj3yb2yhg-00Uyi4; Mon, 12
 Aug 2024 18:48:37 +0200
Message-ID: <907be9df-7173-40ac-9381-80455e73dea3@gmx.de>
Date: Mon, 12 Aug 2024 18:48:37 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Ronald Warsow <rwarsow@gmx.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Content-Language: de-DE, en-US
Subject: Re: [PATCH 6.10 000/263] 6.10.5-rc1 review
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:70C765adf4rNhh6BDR0qKncMl/12M0RxNChIhrt3uQhXLn7X9n6
 ojDnFNk3O3cWBZ9YonRsyV1YS2B+eJxLDOQM2tXCZwP8Y+03QM+AoOPEddwiEACIjuDqqLG
 AScohIxfXsozAfDYjWFqjolMHVw8DMqD5nfM+kz0CGXyGHov8rqTHM64DmxLe5d3lnpwy1H
 uh2Dlw1IGcV8oBaA/XzVg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:L3Xbrp5wygA=;ljmNZ45VEmIALCdTV4EI7mQHP18
 +Ujfm5Zzg+sQx/nlqWzrOdNDsfeYrP+2CcUuoMJeZIlP29npax/M0h1153F1xHOi1ns57F+xM
 0uP5OiS9A7Oc2ncQduzrEoKB50jmLPzaecRFYx9incw/o1NStLe10RXQuAuNOlbC8b7gF3caQ
 pFfl4WJ2b40N+ZAJBQulU/Qol6kwm786K8FHBrcd9jMWdYeBrhJVkyz82zrbdHqKLMLAEvPpx
 FMRyfBjgARoQecpCZ1ksveWQPlIxf1oNSB0yvH/+eMW1jKjbvByQdc4V8SMqXGBZJ4ezYeG6I
 kVO9Lm1Ot3EKuWnUxdfHXoSZmQ1jpuH3hYq/5Y4G55xIUx+U2B6xqOuBUzVOSGtBNee4arz12
 3Eb74IIM6Ogza0v2x2zKBFXLPDpEP83yPEZJAyzSeJ+gpHZgI1nWPm9jodSMvbnzvN1wQ1z5q
 +LDgBkdjj7zbG1gI0tQPj0fWogvwy0P56PH1gjzRWKdQ08eMZE66bajaC4IwnTCkX1Ej8Fo3x
 ahzqmyAYsBvDkWHnAWupkPma3yhDGZUPwwgX1BXyuD/WX1mUJ8m4ePUKmqH2sBaFAbkQUQBmB
 LCcv9zXkj/uzN6KsFq1yI7FXrET2aC4z8Gg2CBOwBCi4GYuo/GEGQsly6nQjLfOuCSjxXyZcl
 hvouTQ0QtxzTBB/OMKTQDg0/K8dfds1e4D/Y0Q43x7RxRwuiZ5YM2xw0ZU8Zpdn8qUzALG5sX
 9GpS/nCE6LSJoQYCTHTcTy5WD3RBwLlFGjiiIGpwXErqt0fJxQmbbxMxl7APHKsXdp26lWrY9
 yAtSM+9+z89g4LBy3riRIc+g==

Hi Greg

no regressions here on x86_64 (RKL, Intel 11th Gen. CPU)

Thanks

Tested-by: Ronald Warsow <rwarsow@gmx.de>

