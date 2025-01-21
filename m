Return-Path: <stable+bounces-110073-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8A59A187AB
	for <lists+stable@lfdr.de>; Tue, 21 Jan 2025 23:16:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D58C3AAAFE
	for <lists+stable@lfdr.de>; Tue, 21 Jan 2025 22:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5ED61F8674;
	Tue, 21 Jan 2025 22:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=rwarsow@gmx.de header.b="LYtFcU3n"
X-Original-To: stable@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C0F1F7081;
	Tue, 21 Jan 2025 22:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737497742; cv=none; b=RKYSptPrtJuPO2cBZEkIlUp3YXvCz+2gZRgM6JS09kZZa+iKZtQTzi2nVDUrhUUkh3ChNSz10WToGt1PvT6Sn7uUUIaZN89Loh47VGxn5yXGEDP6yhc55ff0olVuWJBv4iH2VsTK2cHnNPIC2cqtRPBuODw/zs6pD0/NNAaBO38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737497742; c=relaxed/simple;
	bh=uMorsxGt4LfNafcfhIBWNdbhkfP0zHCQHijrPjTVmfQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XmDyQfw97NLq1uNOw0F2KYz1ymAPiACyntgBAx+qrwuHAeVnPSnfTgJz6d3POeuIXgGvZyMn2qRmVIcZG+GzT7cNtV0Yn67NVMWzYK6aKVfXp2d4Rr/cge08l3mQp1iCm3iz/qKELUeMgzrPMQCOiF8I79dVS1a/5wcHnZMQ9Es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=rwarsow@gmx.de header.b=LYtFcU3n; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1737497737; x=1738102537; i=rwarsow@gmx.de;
	bh=5dVzJSUskcHqJqoFPlLYgEvkoIq/ZdRW26Mf1szpmc8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=LYtFcU3nRX7w42oM0u1hmVNyoDAP5j60AP+Zuolz7jVuWEPYUMBYp2nqzogIm3m3
	 Cw2S7FiftGJ8yNi3yCblMflwtv2N9Qa6XL3ZOrvar1dIb1Hat87Z0fMF4Axv9ljk2
	 cIrlXJOczpdlo8ERncoIyuWb6FdNYNYLnWkGzTKVf54Uy/poUUpfsOJ9IxCxrdAJM
	 UeSFZhP6Gw7HHQsuABgcXXA87kU3whB4akXa24o7sRtT25t6Qcdts2L1cQcLb4vyF
	 Fh6Pvg2JZ3z7/kCLpxqSBiEliMvGqt1Q+CgnbFv0hDe32p4j3OGfH7FRElWPRrxww
	 +TmfO9nxLLILV5I91Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.200.20] ([46.142.34.42]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N2V0H-1tVv0g1A3L-00ysqu; Tue, 21
 Jan 2025 23:15:37 +0100
Message-ID: <e6aba3f6-d4e4-41ae-b49e-c40b3599885f@gmx.de>
Date: Tue, 21 Jan 2025 23:15:36 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 000/122] 6.12.11-rc1 review
To: Salvatore Bonaccorso <carnil@debian.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250121174532.991109301@linuxfoundation.org>
 <Z5AVm4cQDGjnDet2@eldamar.lan>
From: Ronald Warsow <rwarsow@gmx.de>
Content-Language: de-DE, en-US
In-Reply-To: <Z5AVm4cQDGjnDet2@eldamar.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:zQiRmBVZy7fkaG3iLNsaWOyQ0rZv3TULIMb/zPFZIxkAVE9hp2I
 7INrOlx5Iq8L0XL1pqO1fAT4lwALeq+aCu0141NEKmY1KIfiDbTIWXXiDOeWSWmjHnHii8G
 Ek6UDrP/mnwBjp4U2xRkpODp1302hcfr9zDuP5Cf2IKPfXXPPqp4h7FMJSxfdEyBjwJyAzw
 aaT59g2/RkOkgSSDk/8sw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:24dEWDzQQGw=;YaownT6SmN5hFbVIZ95KJ7AflIL
 XO/Z/gvIU97olozCGbPGqVjw5EtBqQuLZIucBZHOCMKAJglxKTSaSIl2vIzHM0mnRaS/PLLE4
 1IY5zkcttayx4y9NWRmaMEKh3IRQP1kGEFauE1nKyZR8dua+xSVNtuO0nuT+V0IuZrFspSZDE
 Ljs8oyX3ZzsSDazgkegvVPgMRVRGOxZQUZxQK0lnCf2jNcl72kAqeEaGZOuDCazTVtlpX6/bP
 oRZI0EDWZk6IYJyr+Hm7cJznC38l+16VsaKmOrha4rw5Mx4T7Tn4tQDGn7h9WThOPQwhxVl6V
 W/DbbigCEWzpJD6Ztq2G6Y1YuDZ8DMn+6pjHBwgzVgFAdF2qjPnolPZtuL/xrvygpCY+ObQP5
 Kw649Zegqa9nVDa0dVyfDcL+hQj2SgEZJAiPC9wg0Lw16vyhUmvNfvZKACN/OEbof0whxNCmz
 2MPjbaaly3n6OIFgTUM0t3PLX1lM8xb0dPyZWIKn9TOYAWJQ3ezxLKBzdSNBEC8ILZ0zOffDX
 0URQVx3wT4rfB0gFUCqeO9YUSyoVQMaQC9QBkVLDtMAN3KAD2u2PBHWSCzY5U6rgPs7BLWvfO
 872ssGGeMl8B8g3fGR4em/6KS+gdnweyCmHPq4EdFz8KzFChZZxKyCaPZoZZpH2Mhwcdqxuky
 q7ebWE8S01bnRaGRZCaQF9hJD9s0I9ef9nOmmliUDDQvBOPG61O1ip3ubzkoUO2FXPfyNrKPg
 8foZ+z1dl8F0q3p6hz3DxiCyUllegphkfF8jH2u0FJd33UaxgqockGTjanC+LEw7PG9MnLam7
 a3s8BSztDpucevSRkKjsou4hB9nTCGU4Jg73Z2PBofVejPLZT3kt5Iu08H2AUT9LCYWRqwt+o
 aafh21TRsNzjrdo8r/eUMgeFCnH07yaJPo2VFB78njUpkmVHKvL8hz2XfZX85cObom2WndGoj
 R8nzWp2TXA4vqropiEi6Za8voQCqrJSUGNfzVH7uG/E/zjlcH35JrMfqODoZBAwnw/KtNsonr
 41GMn4Jmm5D4T89eASuZIYeTTiLKbQy2pd9OYJrQx4f74J5oOBFUJX2Lq2I7gH7zoxZG6zsOB
 3DZn13jct64u5tJsiPmn92gzvNoIFtV15iND4RLskr8/yVZgQAWncjBnjEuMX5bE9+Re/D/V7
 jPsNWb0ikEW8bzR78WCLehYfXqCoes7JQjP+2eo/qSKzGLC2XJDJF42luZXxjg97EkySEuxsj
 uASVWmkOzBWX9M/UNzOL9MUeYvD880mHOAkcoLiuef6Onk8TqInfMYm4TGlf/pTx2G4G/0/4B
 GP2O/iGrazbW42KuTPyI++2zZJYI3eSG4XnPx5QSJqIbZY=

On 21.01.25 22:46, Salvatore Bonaccorso wrote:
> Hi Greg,
>
...
>
> Built and lightly tested, when booting I'm noticing the following in
> dmesg:
>
> [  +0.007932] ------------[ cut here ]------------
> [  +0.000003] WARNING: CPU: 1 PID: 0 at kernel/sched/fair.c:5250 place_e=
ntity+0x127/0x130

same here [no time to bisect]

Ronald

