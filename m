Return-Path: <stable+bounces-100290-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AF899EA62B
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 04:06:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2525B16A080
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 03:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D99361A23AC;
	Tue, 10 Dec 2024 03:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="QIopZxWn"
X-Original-To: stable@vger.kernel.org
Received: from smtpbg154.qq.com (smtpbg154.qq.com [15.184.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7EF9433CE
	for <stable@vger.kernel.org>; Tue, 10 Dec 2024 03:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=15.184.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733799978; cv=none; b=bYltALb2w8WRfji+4vsLH+IeWYaNH8HvQvPS3WI4AHTA9vFC4FhSpC84FTP5371Xna0jV+fBRzZ+PtExRxG0A3DboUTGHH7Tr/jtPbHyZyuNu17OC96P1zfptUDoEACL4qGjUkmFO/MY8AO61VyQRhn6SFOmf+QrAn6UUSQTqLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733799978; c=relaxed/simple;
	bh=a5RNvN6yhOLuXXEML1NHR1gboygZM1ZBmD8hpgI1s5k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eZb7QwdpvNCUqB5PBP3Urw1kwi2UCc4OOUmH1f5G1bC5je4QpQ7BmdcEJt8shbfpyF294bFmxFrs3HFKFwCkl7v6zGH+saldu6MxAVWVLdfw5xkGR684/InqEUt+QFsP/qQJyX4JPAUcG2cIaHi+CTNU7BnWESau4qHv9wHin5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=QIopZxWn; arc=none smtp.client-ip=15.184.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1733799900;
	bh=a5RNvN6yhOLuXXEML1NHR1gboygZM1ZBmD8hpgI1s5k=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=QIopZxWn1C9T5n0GBooMcuaMAC50BdURgnEBVo53LqD8yhMvQGdB17XBSegR/ERya
	 PtzNCl18rW6rCYNmmxR9H1+3MZEi9e6xSQqd2Kqw3pOz0q2ayJTRHN2SMsS7LXkwsc
	 i79vAu2gcxhnMD1jB46W3OgXWuNgi0PQsPJqo46I=
X-QQ-mid: bizesmtpip2t1733799891tx507g5
X-QQ-Originating-IP: vdtojL+6+pcHB7DVTA5S2d/v3jVV2NI9BE/6GpvodYs=
Received: from localhost.localdomain ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 10 Dec 2024 11:04:49 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 11641744602555595633
From: WangYuli <wangyuli@uniontech.com>
To: ulm@gentoo.org
Cc: helugang@uniontech.com,
	jkosina@suse.com,
	regressions@lists.linux.dev,
	stable@vger.kernel.org,
	regressions@leemhuis.info,
	bentiss@kernel.org,
	jeffbai@aosc.io,
	zhanjun@uniontech.com,
	guanwentao@uniontech.com
Subject: Re: "[REGRESSION] ThinkPad L15 Gen 4 touchpad no longer works"
Date: Tue, 10 Dec 2024 11:04:43 +0800
Message-ID: <7DAFE6DAA470985D+20241210030448.83908-1-wangyuli@uniontech.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <uikt4wwpw@gentoo.org>
References: <uikt4wwpw@gentoo.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: Mutteg8H72qDajYqujVPi4dXTr3VokEnl9qBVcNKOFytc+jbOg+c2A4g
	nQetRfc3+k+LM4KjwXvQIARj4hfWHP/p2YqtNB7CT0IDQKB1d3ivRxN2jVJratGfsRAwvP0
	gtVUFN5aMkGs8eMI6VXFkfAV8OAuglMjsVp+6R8ZUZEwvMTnjtTTYZUsD6IAD45PIdJHWtn
	25sZO+f69KX3lma/BuTjWz1Vt28X2pVhT48/0x9HusS8RXzmRAiMv+JXLM6UBSY0TAbMYpD
	9lFO+kh09xTwCN5E43JDfIu96T1B69SFTDtdCAxZvCUNgynuYc7BDtaU/IVTdZdaVsnNcQ7
	WRZUdfL2VAbjXai3kXY13Q7Xa7vUETEVQxykGkUvTfrtcK1fFhaXxtthSoJVW30ucQAVgcY
	51M9U8v/2FPOeB6ncZHESL7rbvZZI8YbTus+VXq/PP6BRBQzUo58n5yz/WEnMziemYlifQl
	1ZPiTx7g2mbeJJ7x7zE5t/PcR6YzdWWnxY7RlywwtmmVptOumBQRRoQjlNQXKcdzYPypgnZ
	hOZgbhRRTiy2ojGnJ/O0155VEJfr3E9jGKsUaQNgszA/cpiWX9bqttDvPcCCXwc4RtM+yOk
	mx2MvUn7RXqFAtjnrTZG1Qfgbiq3EcrHLaffuaMngFJtoTJvRqHmZ375MYNFGn15NC8SLP9
	oA55Cj8kb2Kb+VslifTcmpPwr1UCsx7Q0MRX4OrWHgJ9DSmIWksnrMEg8PiNpMOukcCTNA3
	uyMdYLZm9diaN23M96nbVvAlgTANe4qrakXt/jUBCKJXtr1zKSkMIriUgnPokoXpExYEUY6
	Y7mYDJlmWEl4lvg8ditoZoHFJ0tjevOSKLVK9BSz7Q1vMKFAGZRqmOF1C1qVgei6zA5fnxh
	vyPHzizVL4dDN9xMTB/SXz7AfvXWf33JlaDPbonXhujgz0eHshFukAcTofA29DtDBEiO3n/
	2kguxLL/2M29uvgMHOKDDlIJo1mqwGNLnEl7oZOGEljIvKw==
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
X-QQ-RECHKSPAM: 0

Thanks to Jeffbai's reminder. And I apologize for the late reply to the bug report
by Ulrich Müller.

He Lugang has left our company, which explains why he hasn't responded to your
emails as they were sent to his old corporate email address.

As his good friend, former colleague, and one of kernel maintainer for another Linux
distribution, I understand the urgency of this issue.

I'm currently testing with the affected hardware and will provide a patch soon.

Regarding the temporary workaround for Gentoo, while reverting the previous changes
is a viable temporary solution, I'm committed to providing a more comprehensive fix
that supports both Lenovo ThinkPad L15 Gen 4 and Lenovo Y9000P 2024.

Thank you all for your patience and understanding.

Thanks,
--
WangYuli

