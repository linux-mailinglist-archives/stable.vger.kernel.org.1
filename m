Return-Path: <stable+bounces-3243-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0079B7FF2C7
	for <lists+stable@lfdr.de>; Thu, 30 Nov 2023 15:46:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78554B20F20
	for <lists+stable@lfdr.de>; Thu, 30 Nov 2023 14:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8886651C34;
	Thu, 30 Nov 2023 14:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: stable@vger.kernel.org
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE2A693
	for <stable@vger.kernel.org>; Thu, 30 Nov 2023 06:45:57 -0800 (PST)
X-QQ-GoodBg: 1
X-QQ-SSF: 00400000000000F0
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
X-QQ-FEAT: A7bf7mETiWjtEkIHMIVyV9QvCCTXh+5mnyeiFxe2FqgvFgaXMFxbyQo/mwv6v
	LapWuSDcFmGIKWkGbn/N4voVialGkBm4IMX89z1FtXkoTd3cP/UoJfC5PhT9Ey15L2eXh54
	mAyHt0QEqrk6z84OvOp+PUAmAl5uewJomIefmb7e9r+/8lE/R3iIpaKLDsxNR8BkzR97zFk
	q/T6WpbU5awb660k72TpCeCIaGJ/rA8hBh2ZUoHUToVrBm+Yge0QjdrNkB9T9CRi2N2Kxc9
	v0VkyxClj4gepXmLsNiaXl/HWdDWVRYdqLOH/Z4fdu2miBIfsTV3M1i6wwTvTJzRjGsQqiE
	ZfdNmwdS0Dk2P7loBhnkIk1vrLuXsSa9URTMIgqHchSHbGZvks=
X-QQ-BUSINESS-ORIGIN: 2
X-QQ-STYLE: 
X-QQ-mid: t5gz7a-2t1701355524t1936382
From: "=?utf-8?B?5YWz5paH5rab?=" <guanwentao@uniontech.com>
To: "=?utf-8?B?R3JlZyBLSA==?=" <gregkh@linuxfoundation.org>
Cc: "=?utf-8?B?c3RhYmxl?=" <stable@vger.kernel.org>, "=?utf-8?B?U2FzaGEgTGV2aW4=?=" <sashal@kernel.org>, "=?utf-8?B?aGlsZGF3dQ==?=" <hildawu@realtek.com>
Subject: Re: [Re V2]:Patch "Bluetooth: btusb: Add 0bda:b85b for Fn-Link RTL8852BE" has been added to the 5.10-stable tree
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Date: Thu, 30 Nov 2023 22:45:24 +0800
X-Priority: 3
Message-ID: <tencent_31EB5F576CF463EF7C66CEDC@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
References: <20231124043548.86153-1-sashal@kernel.org>
	<tencent_27789A681229CCB77BE3E186@qq.com>
	<tencent_13CC3606408C86A21D09FB05@qq.com>
	<2023112442-glitzy-rocking-4a8a@gregkh>
	<tencent_429FA9BD3B6671BC788386A6@qq.com>
	<2023113015-justifier-nastiness-3c66@gregkh>
	<tencent_7B1A767250D25DDD0AA40C93@qq.com>
	<2023113024-huff-cushy-3b6b@gregkh>
In-Reply-To: <2023113024-huff-cushy-3b6b@gregkh>
X-QQ-ReplyHash: 3711289092
X-BIZMAIL-ID: 5136379285096628118
X-QQ-SENDSIZE: 520
Received: from qq.com (unknown [127.0.0.1])
	by smtp.qq.com (ESMTP) with SMTP
	id ; Thu, 30 Nov 2023 22:45:26 +0800 (CST)
Feedback-ID: t:uniontech.com:qybglogicsvrgz:qybglogicsvrgz5a-2

PiBUaGVzZSBkbyBub3QgYXBwbHkgY2xlYW5seSB0byB0aG9zZSBrZXJuZWwgdHJlZXMsIGNh
biB5b3UgcGxlYXNlIHByb3ZpZGUNCj4gYSB3b3JraW5nIHNldCBvZiBiYWNrcG9ydGVkIHBh
dGNoZXMgdGhhdCBhcmUgZml4ZWQgdXAgYW5kIHRlc3RlZCBmb3INCj4gdGhlc2UgYnJhbmNo
ZXM/DQpUaGFua3MgZm9yIHlvdXIga2luZGx5IHJlbWluZGVyLiANCkkgd2lsbCByZXNlbmQg
cGF0Y2hlcyBzZXQgdG8gbWFpbGluZyBsaXN0cyBhZnRlciB0ZXN0aW5nLg0KDQpCZXN0IFJl
Z2FyZHMNCmd1YW4gd2VudGFv


