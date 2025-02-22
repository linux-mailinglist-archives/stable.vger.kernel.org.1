Return-Path: <stable+bounces-118654-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 261D7A408AF
	for <lists+stable@lfdr.de>; Sat, 22 Feb 2025 14:27:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C16DC3A8727
	for <lists+stable@lfdr.de>; Sat, 22 Feb 2025 13:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C53A520AF8E;
	Sat, 22 Feb 2025 13:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="dqjxE5Pf"
X-Original-To: stable@vger.kernel.org
Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D612CCDB;
	Sat, 22 Feb 2025 13:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.132.163.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740230834; cv=none; b=Zxm/nD87phJ/kEQBQHOSFMSjDtNGW1u+kD5qRjtasJ8mzUkLiTBQbKJbt1Y88skHjFHGDMvw2YhKExsfSb5VUNXZhO1dc8zewwVOo3O/fQsBIvYxA5KhCzfdBYqeGebYUjkjPbu605yJD4a9sculuwX+oVx2+nXRhW1EN11b3lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740230834; c=relaxed/simple;
	bh=0xS6Cu9zY503FYzv4hIWBT5pesLymuUmjYwkhhRzpwA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Nn1EFeoOMhK5IufDOsKK6KLeMr0OIE1zHqnA+dTQIi2ua4sMWOGgvM8yeicQvBBIgk75q4p8NacCIUHVdBK+5lHv/o3oMjOijqxhKaT0gC2uaGzC3SYJ7DKRrwHZnFQ/C8fMhL2MIhtI4d++uISRC1jxdEgwKJ06b9osbLFdrNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=dqjxE5Pf; arc=none smtp.client-ip=18.132.163.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1740230794;
	bh=0xS6Cu9zY503FYzv4hIWBT5pesLymuUmjYwkhhRzpwA=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=dqjxE5PfR+mf4cOGCjm8ecW1kbq1HY6m30vfICXUue+h8dNDqpUefr2Ob4lcG/Pt3
	 8q1RkUGPgNpT6pV810AfhbWYftu/R8qS5AwKCkm8QuSmZCsz6w/KVcOKBHGMSL+k/s
	 /YOio8BmOsmxmJj75VOpUg9rtl5/J/z4qDUgidxE=
X-QQ-mid: bizesmtpsz13t1740230790t96rlp
X-QQ-Originating-IP: td5RAHcEPQCqD7LgFggxdM/IlPGOPxUh3iz7gt13nOE=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sat, 22 Feb 2025 21:26:28 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 7706801830270063389
From: Wentao Guan <guanwentao@uniontech.com>
To: jkeeping@inmusicbrands.com
Cc: andriy.shevchenko@linux.intel.com,
	arnd@arndb.de,
	fancer.lancer@gmail.com,
	ftoth@exalondelft.nl,
	gregkh@linuxfoundation.org,
	heikki.krogerus@linux.intel.com,
	ilpo.jarvinen@linux.intel.com,
	jirislaby@kernel.org,
	john.ogness@linutronix.de,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	pmladek@suse.com,
	schnelle@linux.ibm.com,
	stable@vger.kernel.org,
	sunilvl@ventanamicro.com
Subject: Re: [PATCH v3] serial: 8250: Fix fifo underflow on flush
Date: Sat, 22 Feb 2025 21:26:27 +0800
Message-Id: <20250222132627.25818-1-guanwentao@uniontech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20250208124148.1189191-1-jkeeping@inmusicbrands.com>
References: <20250208124148.1189191-1-jkeeping@inmusicbrands.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz5a-0
X-QQ-XMAILINFO: OA8qd4daQrT+gspbIHyjZJSCZe0mGuFJEUOJnUJIUtlW3kdWKIWjXUoX
	uNcndV34u/vwofXTZXKFXifsW450JWsBelge09EWmusHmT31Az/GJeQocV626GgNUykG/nf
	Fjd9Xp9VY1dv2y0Sqxzhl6AJM4/TJXW4ppQS7x/ThESEEJraGCXeckW1yxinn9T8BilCYMi
	WAbz68mWXMg51TM2x0H9Y79m1r4CVDQTGmBjU5rC5mnz+DO04dVHcf01wxZX5rnUprFe1/M
	oMoHkACePkkFgxklL3krlF4/vPYSDQHwVQJ7GcRsnEmnKkTXmIoWg7nXckdHG+3n5hECMQB
	edNFbpNm/pXRSs/Obu4fX8sbrm894FXOVqw1bgvBMffFyT1AjePR0WS2L/peAjJF9Q7NpkU
	xBuER+i0JxiW71bfwH3EinFXB6fg4ZnMAgsrQR7nE72TgIT5/imUKp8WgZE/Bh5OyZbsm65
	SNZF1XiQNYlSpeXbUbRBBzDLWxYE3qjCXTmeKdpqzW+3llp7DXO5I19kjeltIoOdHCesToU
	BZxC9mMDY9c3p/UIw0XdN38rC5arUI5ai1lEVuZBsEj6XqeOrBMxAsMLEdOrj3hnuCK9eK1
	QwX2NQHaUIGtEcJPIWREWbATsniOm54lrjnc0JBN9Ru8O+aP+FnSLVbOcTKRQ1lyU36Jyzv
	MoLxygoA++rmOmnOBjfk/lhOBCDU05uhEAzWAUoWPhpY800IO32LFXQxF7qSpfsqolnF9iG
	CQjaZMMFOYlgMZ9attqVPskeszk6pxqJVVm93yf+AAFjoNJrFGJAgaNDUJ+5D3I+T4uN1xH
	rokc91Ujx1ZmrstB4rpDuxMVehqDYHcqU6Cf0F4zTVLhhcFP0EYaQKsdTWY5E5FmsPWuL3+
	0/m8zlyRNSqtXUnVrqW+DBkpJQstG0JI5wAeLVAzytS1Y4q13CnxxKDTrkkM2GpVTiPgJb1
	anekp8gHd7Saoh1ayA/K42EURZHYZmVsWcIneuBK3J66IGuLqZpCwXWOEzp9nYp3MUUR4tk
	mwTwIJIbhy4S+mnbKEeCMYplJ0zh05leMrot28tTs+DNTKo9gZ/98Dk2xH5zQ=
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
X-QQ-RECHKSPAM: 0

Hello John,

It seems strange that call 'dmaengine_terminate_async( **dma->rxchan** );' in
'serial8250_ **tx** _dma_flush' during code review.
I am not a professional reviewer in this module, could you explaim the change?

BRs
Wentao Guan

