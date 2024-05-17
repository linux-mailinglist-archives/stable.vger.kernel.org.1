Return-Path: <stable+bounces-45396-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB74B8C8620
	for <lists+stable@lfdr.de>; Fri, 17 May 2024 14:07:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 923C02821C0
	for <lists+stable@lfdr.de>; Fri, 17 May 2024 12:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5E773FBAE;
	Fri, 17 May 2024 12:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=rwarsow@gmx.de header.b="uRBsT+Kn"
X-Original-To: stable@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B7840BFE;
	Fri, 17 May 2024 12:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715947639; cv=none; b=fbk+ocjwOyZYoX2+g/A96L3HZSBh7PEWjqP+JIPDKwaQVbQyOu1ztMMN0rw3kGalyP1nGb9DsWveyP8ROevElVogBtJ4sN2WzgXadSZQ5R6yK42WE0TamicK5adU3983oIemwNg+7+73bLsUZcdKyYJthXHDthRtGV011tdkV7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715947639; c=relaxed/simple;
	bh=dmMdDLN3YgL1qMEqV22WwccWKGPvTDnUyQtKaq9KA84=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=hBqd8qIV/iznlHZmA/dDHGnXrrhIZsujjpEBp1satUUFbeTrRTVDS9ORwbdTulXIuX/yCucRIBH8L+asCFvuUyzKyGSgH/Dgo87nZgjCTVbKlJ3po5lmxV1a4moBynryN7XfcXE9Tx/U4y8bXPkpAC0jq3YY0+dWNrC77YmALL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=rwarsow@gmx.de header.b=uRBsT+Kn; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1715947634; x=1716552434; i=rwarsow@gmx.de;
	bh=dmMdDLN3YgL1qMEqV22WwccWKGPvTDnUyQtKaq9KA84=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:From:To:Cc:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=uRBsT+KnrKOJInNQPt1GhtEXaecdNjniEjuZR3tahHz4abQ8zSd/Jvo5+4NA61uY
	 53+lRtNL0dhHOCYTFDXJJSjP5zBopw0BGL37wUe99xT2OsiDhZqkoWPnkcsQGcbqd
	 0lxCJP4IjvdccvfbqE9DQTZSvLVzIBxSmkPJoQbryeB3GqWCAa5HqXrGFL06ylN1g
	 NTk6Mlz78eGU7VnVeoAH6VIfuB3jg42kcs7+NZKXmbaYCV2ep6FSMebulVm86i/OP
	 KQ7xVEJcKABjVU5BQE0D4B5lxhBCQnwLibGH/XnX0lbeyKCpijAXR2WzuEk/Y3scr
	 HJnHxkbJby5dFbgT8w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.100.20] ([46.142.33.192]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mn2aD-1soBzp1veR-00lEfY; Fri, 17
 May 2024 14:07:14 +0200
Message-ID: <2f091444-b48c-4170-90ae-c8449ebf66c4@gmx.de>
Date: Fri, 17 May 2024 14:07:14 +0200
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
Subject: Re: [PATCH 6.9 0/5] 6.9.1-rc1 review
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:M0+scqx4DmQ6QBqKMm4542s1zUzd0jAHabjxdxqRbkacYXhwxGd
 NXwu370cS8szVwkzZjkUF1WTM/1B5NjvpxuiFq3jovdH6N/fGUnL8ftsqAz1g/53wYv7lTP
 0Kaeic5qFOuLWj7AMJ1otrmJhpfr/RkMEhbMaZKeAKOr9r3knuiqzt0NIVJAQRCheiqvUAC
 /Zd4gvZP3OPYSZrRsR/fg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:MgLpCTcrkcc=;Qv66Xf4DKyfSCulz+oPVsZxHf4x
 R00aH6IpPdpmPWD86zEL3EEQckuhXuoeKwjBvkAKYJUje9j+cklUtZz4+L2XyOgi4PYmuU9Dt
 m5c/AGv0yinW7iUn2P/P6dwPGUeGuzVYu0Yyz4g7DH7tlU0qIpvl5ejYAM3x/NDRn32TT+Kp1
 CrVtuFUdKbL8BTjf/lGzOfAus1sb1o7v5s1BtMqXtKhTyNTjPsI3+k/+PQLbb0o8sMqsz5rTO
 k22KWyjXpJh2ABmWcOg8U2n7r7Ui4H9tWfVaqLxooHWWWTSMgKE2JvDopf7iLJcP291lwZM7z
 InboyNxXA7RrTC43uT6C6d2Wc7WeA/elG22p06aQIse3+jUqwXNoNkFDVvP+lMf2BXlOk93YK
 rLkF97QImUjkwmRX/POPIz8sjyarzZ6+ZfVkXZvzvsYDl5TK/vN8DBQBnzyzUDrFhWixkwyo8
 u/MUfUb3fSFzNu9VuMdz54cyzzCaXTj/IFrh/xwKBF7KEeAd6JcObfNwQmdf4PSEonxIKQ1Hf
 RzqTFmMbS3Igu2cKg/ably84PO+Lju1kgep7p10L6HdnJtkA4PkX2nCAD5D7jAd0tj6/UQkDY
 QMTGz5HK7QiP6oY3G5/jnsUrSJMgU7iSHBvvKvf5ygqr1coHyBkjoKHKP7dOjBavETOMV5PCp
 W2PTKsIvACpBLH2OqSWhRMli8N6KMKMghV/2qbdMV+oPsSmHCxVoWJzzOwR+OLXHbGAldfuWO
 IUZuiDBe5pzkqce0Kp3Oyq0JH6Bt5Im7QUWBh2xsm5d6Yn5g8bQvaXJBPFL3iil2rK72v+eP1
 rdXypY6RZjRx2rs1tEGEv2OmTx9kGuqA4AcGoi/wb8VuU=

Hi Greg

*no* regressions here on x86_64 (RKL, Intel 11th Gen. CPU)

Thanks

Tested-by: Ronald Warsow <rwarsow@gmx.de>


