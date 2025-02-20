Return-Path: <stable+bounces-118423-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B387A3D901
	for <lists+stable@lfdr.de>; Thu, 20 Feb 2025 12:41:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E355E3BD581
	for <lists+stable@lfdr.de>; Thu, 20 Feb 2025 11:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE3661F4191;
	Thu, 20 Feb 2025 11:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=rwarsow@gmx.de header.b="CgTAK+Ir"
X-Original-To: stable@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 582111F3FCB;
	Thu, 20 Feb 2025 11:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740051650; cv=none; b=aZ0HX0lVL0KwD9ddBv4kd6r6Cxzps2zNcr0p/dWHuhldAjrCkXeS42ensTDvlr0hNht/Xe0otprWv+21/ThR9ch+EhLmWHOw0rqWZf7Q9AbDio4vKSbG2Xs6+TbyTftqRqC4djxNJOSTdgFssW9NcYc1tlpy54K/4rW4QE8K1k4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740051650; c=relaxed/simple;
	bh=HtuFhXI63urBA3dRKYyXQ6GHreCYVeNttV6YM+zDLlM=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=jl2xw6e1GTN/CqY97mkJYtqyNosPGj2E0aW+BwjDQ1rtsN8lDHwYKmXTTyx+SUNl959WC49PBYpmPpa2m2cuv5ibVH5huNaLQhIlc4AW57wnzXaURnynUb02CHA7CwIs8xZlMJ27oYy/Tjf4Bm12o9FF5vhubtChtnjqhnHzyOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=rwarsow@gmx.de header.b=CgTAK+Ir; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1740051645; x=1740656445; i=rwarsow@gmx.de;
	bh=HtuFhXI63urBA3dRKYyXQ6GHreCYVeNttV6YM+zDLlM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:From:To:Cc:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=CgTAK+Ir+vHnbZdBiQc3YnWwJnVDnse/wJ0aozLfbJvuavxsldoWG7511WlgtTf3
	 GIVI9vYTGw9zLq1GpRB8geJq/PCHrPw/QckqjSXgGvBE7CHm/jlgh6/2S77jw2TU1
	 0Dyfc5eyXP1pl0xEQxYkzr/58vtXE8EO3GDKKsqYNlKo6JFpIeNeWJ3o3TSZUWA15
	 zwWhdNof2a4/vYFtmyhxu1Mq+h3KHT5HOz0IIieV6EPQmSEbrxQxUvL0gNKJa8yzO
	 xwWoDkx5qRjmgkSgimw/duFpJgTX9KIbvo5yTQojyaOyPAjc22+CyKMTa4JAYL8zV
	 PHOpTBoHR2jNXEPVVA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.200.20] ([46.142.33.75]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MgvrB-1t8Qm81DUj-00lcGd; Thu, 20
 Feb 2025 12:40:45 +0100
Message-ID: <4f43d2dc-3d3d-4a08-8638-e77094881f57@gmx.de>
Date: Thu, 20 Feb 2025 12:40:44 +0100
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
Subject: Re: [PATCH 6.13 000/274] 6.13.4-rc1 review
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:Udw1d7aD6ut+3gJnOiUJ0XcbcCMe5ehceYhjJQe+PSas7cfjAj7
 ZUpjdgLp4+TmIfTez63r6h4twWAJcAPPpRof8ZA9fT3ONL0uv8iDc41/bdW5+JTt1Y3fy+X
 D9XHOV9qAU+LgRaqJck2+ApKaMUejGWXsYPWzosCpHpKBaUi55RWIVX00RCBdQQtiRi249A
 YG+BxXrTdK3gY0xq+PUkA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:yppLq0ULLDU=;HIQ6ZFpXAOADA4Ca012+1G+XeBX
 B30I6OWIEMRMLXQ+pauTDdVHQfjMPNWGOMFa3lfzSdLncMk5nRJBjykC/aSondfNrbmAKynzv
 65bNhly0JaJSv6rC0IBs3VYSGUb8VscSlk+rQVQXJhxA6t4Sa+hJsUHOU/isXhSNzsmwmV5MY
 Ywri6Byk5bTMHBpN1jXACjg2nv8okVOWjBo1oCwizmdhzFuhekKbbDbxmvmALBQ+txHBqQYOZ
 bdH4so/+P5c7Wzvkm0F2OU7GWlEyR4kuNfgx7C2MzFu2I4ZU8FJYWdIbomV79DDOtTGwi82wA
 axjj+LLrNwR8KnDMZBLa7JdZRV1tcQyLBaUM96G8f1qPHEaRdyt+c45896K7D+QTpwvYK06Bz
 zoY6TPfGbhNMy0OuCF5JUnEW4BUj46rloy2Rf32FnlUPjlGhZHCmlArlHFWq6qDJk5DTJVo7X
 hldfAJVlfGZ4H9oi4/wiawdz8EX78BPRMTZ5chmdFu6Ic5kHDnU9Si0wCr9fJYbrQzj8EdXst
 /lasqo+hXxf0yQ3+xP6jAGcBth0N1e7G+kVb52t06SoNWPsINoSWCucInIWrOIkhb+/VWOFIf
 u4AprGgkSJ1OQxM7h2G5RCWmbxNUFe7v4ZMPLBmcLKGiUF8gLkGsSvYEvUq3S4Ph1pFncooaI
 42j/yj7ujUdj+aG5sYaJssicEMTURdw5hrGISU6oyYmCjzRwBj022aopmVJyhCUbeDVm8qowt
 MzTMID1xuDqxVg1FnXTCExz+hu0eqtPQYOAJy7dqMlD4VQmdmi1ir5t6jZpnI7ELuFTn6EuUn
 +6k1NesiCnsWDBGQ4gxLi/JMUZ8t5ziSmRJw/rcv1xeZH+lhWdnP0q0Z4H+YLiDjqyRG6JDFk
 rVRNLgnSj0IFABTS3eZed0jwclaFJMOZVltC3HU8EbJ7gn3BWaOuqwv+pYQAeK/Yf2h5O23H9
 XNKJVstqSlmijzQePY4+EgZtdSt4vZ9nDJPNtyOUth7HR3f0g9+5ryfeKZpVlwF7ggjoLi/OF
 VIyNU/Fjpg6cFFkipg8wWF3Nq/CWMOjsGDkPP8IwPsN4HZ2wpMPqL/zPO64wbIzrE0PFCJ/bu
 8tfz6orG6nDXE8bBWOzEH9oW6aBxd8PPTjNN1hlHHJGDWbyjp1vUlzS+e9Z8hjolOVMAwwWeV
 p9uK/ztBPuat9yaoAeBejVw/f4ojcPjS5p/Wf3LeRG0CqiReuxQkp4j9HAmwaj6YB+OvGB5s2
 0thrjhNazl5mDy14dTqeX8IijiQ+Nhb1cCuzJPmSr5h9fvOOtTf/MlphivevTHZA+aid4WWva
 RB8RyGYyEPi7CAcdM+sEElNy+z6v965GaBjKVJfRk8QETU4fXOHxQRtdI1ah+fGVJlKhZ+qCJ
 UWex+1BzotfLpHn5bjM2+aL6STBhBzQBNU3PRlkNNWOdekt5MEcxbcBcO9

Hi Greg

no regressions here on x86_64 (RKL, Intel 11th Gen. CPU)

Thanks

Tested-by: Ronald Warsow <rwarsow@gmx.de>

