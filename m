Return-Path: <stable+bounces-87589-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 775FA9A6EA0
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 17:47:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BA5F1F21DF6
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 15:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79EDD1C68BC;
	Mon, 21 Oct 2024 15:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=rwarsow@gmx.de header.b="bL9koBtI"
X-Original-To: stable@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF6401CA94;
	Mon, 21 Oct 2024 15:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729525567; cv=none; b=FTJLctB/wPUpeOFdJNe1wu/0UJG5W9xl2I/dQaARh+FzDFPrg58Sh9fFTQXGZ88G6N/cFovXYbkWawbo8y8e7blaDGFwr4nQE+3R0hVzPi7qOtb1YymPS8oMUOE6bbDxVhBi1tDm63P2vzUchgs7OcsTwy7oLWIdh3rSJ3TxABI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729525567; c=relaxed/simple;
	bh=HtuFhXI63urBA3dRKYyXQ6GHreCYVeNttV6YM+zDLlM=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=Mp8+7kC2l2kyDEe1IbSA4ysVjM2/SSKj5o3O8Nx7lMWCkZcm+/CxBTigm+ug7SpySeOx3rSb1bFQg8lHlb9nSf5ahqBIMqfPUUfzWGMoKTUG8dsCuCRAG/9xVMd79n405M65kHYhOOkTLZHvVyO485O/HklZa0Q7wAy/oPZVGdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=rwarsow@gmx.de header.b=bL9koBtI; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1729525562; x=1730130362; i=rwarsow@gmx.de;
	bh=HtuFhXI63urBA3dRKYyXQ6GHreCYVeNttV6YM+zDLlM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:From:To:Cc:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=bL9koBtIzv5Pzza3gmvHAO/khNIuodbgQh4levHJy1teb33IE8tD2diXiP57I6Uq
	 Tk70ITvQImFgrhcugWc1YS4gLZAsjIOv4tahgE9T0F/a9YsLcKA8KbpH4yWTLJpTO
	 oNwHMLE0Tmkev76w7bqjEj1Darrwx2Dsnd2AbP1pe5bT+//X/4PLktYIBOsp/m6P5
	 F//6MzegMiN75gQFXYhGN9VLAUPq9qadmPArXcZGtpEfzddfEsYPp5Y6DBFQwyZ3Z
	 /epJ8lyZEmMfp4TcVOTGgkfHZ3QFl/15suxFo2g2nHee39MSQyHqkod9qzn/qCsLm
	 NZBHIT54Y8UI5rdoJA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.100.20] ([46.142.32.225]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MZTmY-1tN8N202Yo-00WXRt; Mon, 21
 Oct 2024 17:46:02 +0200
Message-ID: <596c6696-8df4-42bb-9989-cbc02012b5a0@gmx.de>
Date: Mon, 21 Oct 2024 17:46:01 +0200
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
Subject: Re: [PATCH 6.11 000/135] 6.11.5-rc1 review
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:6ascOIiKDQHwNf685k3mdAeIjLmkPLEXSyRBtURP5SzXwm9xlrW
 DkOL7QUpmSHkJTPAP4J4ms/EDXqwfanXgLyOi7NfZ+t6w2fvkd6lAbck4BcBjrzxMOB7tK4
 9NH3HI8UEZ7f+1fh0vA1nZmgzbLvZF8KnC76C7zr6jc8WiiV3I7/DjJ0yay5bNtck852T7y
 U0xNkF38rTLCnfQr+78Nw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:IaBvQd7px4I=;Kb3LPD8qAa17m1w42EvXWQFg1+s
 B2PiOkipg7vcB0a5raPhGgwlzX/T6cFTxQDyjuh4upX8+T1k/YQWOO+pj7Ab9fm+cgKsX7fBT
 mNTCNgNORiIJJ401oMI6KO1Hu3YcACoIzKvIm0t7gNIBw9KWD+/+w5GVzka57r5pkbAxwhTGF
 efKTUUGJfQ7VslRGXfVh/d+6Vfagv51vS0jNTuwLg/o1kfOuTr3XxL2oBssdqSRIIxMZBJXcJ
 50rAFql5/TQemMFT9kZTqNvHchfPPXEyeqkMBGc/4YH0QX4TDpC598pUZqTm9R9IFBBgstPwj
 ly4zDLRsN4AUrHX47QNToPu6TaSwJ3ex5HY1/IPykHTsejCFvZDwbTcKeTlG4S8rUbwDouWdQ
 WkEnCJOqu6Hged1UtitpdwXdm3ZCia/ww/nCI+zniUbpfliy4+k+k665QkNHNmLkrPtg0fo8M
 GI34O7vgL4d/Anro5VrYMLoQmn/CjoBCLHpcAyFIyoU4AXOnbcv4F67xGpFed5Na3ircek5Hd
 iKyJPcccRphTVCYZDHVw6JDkuUpV75wkVQxYgZb749Ax5LuRfPPFYcu+24bNmP8utcXpd98c6
 DBYW9Vbw/+4oE5ekxwXyo8np05jwV00RLPLZHd3LVvX7uqreTo48e2kxY3u49XH5dWyFw5e/g
 mOsfR0TwikMkQuuIXMer/j8DiO6DeSafvE9HVW7sDoxts/caVdWXRmitzJ5bGS8za6459HQ2G
 CiRvgpQKZM90lEtzt85l7Wm7ylFqedI9fXsXsok91VCa2wJxYV/RNN3YGegXCdviJOFER+NSn
 EdVHRWv2SZXWqhKwrp3X5jFA==

Hi Greg

no regressions here on x86_64 (RKL, Intel 11th Gen. CPU)

Thanks

Tested-by: Ronald Warsow <rwarsow@gmx.de>

