Return-Path: <stable+bounces-116496-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D7CB3A36EBA
	for <lists+stable@lfdr.de>; Sat, 15 Feb 2025 15:20:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90AA5170D56
	for <lists+stable@lfdr.de>; Sat, 15 Feb 2025 14:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE3101C6FFE;
	Sat, 15 Feb 2025 14:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=rwarsow@gmx.de header.b="H+1KhE0P"
X-Original-To: stable@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0614E13DDAE;
	Sat, 15 Feb 2025 14:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739629220; cv=none; b=nleHEhHOkilqBf6ZYs922cO9EUiBplFg3dZH5PuVlndEx81YP9XJquDzEn7IKZ1pQmAaDHdVho2NiFVN7WrXopv6rtTzTfUca1rVR9+4CJB995N/VLJ3WtYwe3WdxI250xaX1Bo9bDXOGBItEctkufwyyNIwmcbHOH7KVcJqS0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739629220; c=relaxed/simple;
	bh=HtuFhXI63urBA3dRKYyXQ6GHreCYVeNttV6YM+zDLlM=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=Ak1nz46dIIsxwOv7//m4fI4hrdm9B2gtYzqkWFVeglyule8e0Qc0ZeDXwTT0QnrA1CYdMqeWj/wE6Iv+SuW2OPM3+irnEKPWOtQEg/DJPBMgCoHwsH1yg1W3Wg+FCqeUbsyQm4ykyt8912yE0A17t1fFQeFnVU4Wftp+op/w32Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=rwarsow@gmx.de header.b=H+1KhE0P; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1739629215; x=1740234015; i=rwarsow@gmx.de;
	bh=HtuFhXI63urBA3dRKYyXQ6GHreCYVeNttV6YM+zDLlM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:From:To:Cc:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=H+1KhE0Phd+tQmRRasQ1xdHWO3bMDgCJfXUWaLTSaCrH6xzyCRlxR79B+1KfLVCJ
	 WUpZVk2MRy1Jk0MWAUPgZWpCprA8zypvfQy8/HWRg9LQ925LXb9ngtDdH/bNSlcm5
	 rmzfzz5LXMXiVfqpMh1crCG128MMTt1vtWI7FT6S31iqQY2KcocSWo5zDKgY/qFth
	 cRZwHd5CcIkF6FNlyQZfkaB4zHnZD4Z/z5MJuVNDnBKkpI8H4mdAaVV93BCPMwjSi
	 4wFbzcZ47LVBDgjA5Ne3vKpMh+lLI2nWzvPrYLZQNACrcDNOG++zix1iawH0acc2w
	 cHNUSrBT5BZE2dvYLQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.200.20] ([46.142.32.147]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MuDbx-1tVE7G1csf-012qn5; Sat, 15
 Feb 2025 15:20:15 +0100
Message-ID: <dd2f2a88-1fcd-4c1c-8edf-48a6650fc74d@gmx.de>
Date: Sat, 15 Feb 2025 15:20:15 +0100
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
Subject: Re: [PATCH 6.13 000/442] 6.13.3-rc3 review
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:CV1d0g9Yque2CD7d+Qgskoa8OF4S9MyqkIEzbso76TA6hlE5AkW
 3Q4d73O3zzsKxrVQwMQaIWTtbvk6tqy1Vo5lVokMcmj2oCJ3KVpeFaTOgo8bV8ovj4NEJ53
 To+2q4SC3PlCX7sn5TJnDXWf/vCGycXJh+UP29WvF/gvuC53812eOQM4WwIS8LxbUKD4G0S
 FA9tc98tGtES7VnoPqRag==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:QM7NkFV+U/8=;DpsJgsG1ZGDiDIiMFyAHw8HC33M
 IelNK/YEvanqVJ2bgC5s6cQxRwUTIzkDjwhioRE+tlN8+q8drVtayqWR0hCO/XCovED5OISSB
 Wzt46/PriCR/FluIVaicnOFy0dfcdvzwWxFMDVM3IwNc6xZvVOcfnIg55MzPZpc9yXJIumkAs
 3F+oDPPk0OhC7qGvqKN72HrM+ZQQwCKLKlXkDWDw3N2Ba375+8Bjt2bXhjeWa8jDVV2qhV2la
 8WUrUxysv865Afooh/x81rV8WJNaqM9Tp1X+1ks+ED1cBSweHsAHdc3IYUTbzncajxeS8Kvhs
 1JACMi7cbwh9QyhTgGVB2LpXkoNGCEuh8XbWlDWVAsclgMw4ngq+U4yYdTt/sC4GyZodAh6jb
 h1hCrQqtHGKiiPski5ceViGD2BjTctojFLKMIEYSIPTnWjtWqpEWhzIcQ2kuTDAB8QzBX/DKH
 tCzbg+aFj3clmjk3LCKeD3+joTt+RD+GdFckqFwdtkubZcTDT6vesOFFxFH5AR3aW5+Cx2vlb
 PfCDtytX8NHSwTp2POldn6GVbbt9vlnoigHyP4DMKlCq+d+e3/PHcY/dBdkOG2oNnED2XDsC/
 ld5zP06TTUAeGodjqjZGYFVA9S7cQWDh1rnXHZpLMC9DPqB/Fdv28uOnQzOos1z7qG29cR1Ue
 gE19JGQNAK+IlTtrz+BsxTSaDOTj8qdeqSanIf+XUAVIaKbJXm+mVuEotDoCTILVf9g+uWsQu
 +mywbK0B496jpHo9zDf7tEDlWm/7HZBaFxpBeji4tW1HuJylEp1PHm+2Z9OXzDQxppqKXbQaI
 VZXmlnEP4nnEnjYWYvbLBhhs0j+DSbRF/gP3f/VQtV8B64gop6Yj5LYQhaMjMTHOklvCU4fNG
 +X/uhRK343zzipoHStX1+MOwUI2RFf/Ic6bfxYjaianDYvOKq715PP1dyqZ3Lzt0bA45BhNEo
 FyzruR2nyS+ytuW5yGBQKEo4vFHNE++zdnmAs1D82ZwhZAg7lbg+ajhfWjnrbuXj0gg5YSKAO
 HrQjqEsH53WyLCjiRyhh5t6CmxF1twlJ5/dc/mzlu1g4rmnukRH+WegeoZMkayW63ryHj2VkV
 KEWY8HNcdc8/sYDcj61n78MxE1MA8r48bzMQ4WGRT6GpTX4ZM/gb2zL9EcL5J07HBLttQo98c
 ytNdhNQHFirP4Md9lol5b4rQZmHcfARLSntHkE/05C9p44Y/cpBZNT7zv8Y/ioBa8HmC6U2TV
 pdf/UfNzmZcUSXPAfS1RowXhIy6f4HijIDtdem7dPC+56egoodpiJrM+OkMu1kOIEuyKUbow1
 +p1zD44ELSPxzk4+49tA7s68FCLMZAoLSYhf5pYSI6LUOkUUrsxBLr2CdYvE1xzLFsF00rSbI
 dHkD6bW/RGjD4FZwpyMxel1YVcxhrM15jt+sU8l9v0Btyk84R98ohuh0C+

Hi Greg

no regressions here on x86_64 (RKL, Intel 11th Gen. CPU)

Thanks

Tested-by: Ronald Warsow <rwarsow@gmx.de>

