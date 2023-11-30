Return-Path: <stable+bounces-3226-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 538AB7FF19E
	for <lists+stable@lfdr.de>; Thu, 30 Nov 2023 15:20:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 915D0B20FA3
	for <lists+stable@lfdr.de>; Thu, 30 Nov 2023 14:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E26574A986;
	Thu, 30 Nov 2023 14:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: stable@vger.kernel.org
X-Greylist: delayed 73 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 30 Nov 2023 06:19:47 PST
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DEFA103
	for <stable@vger.kernel.org>; Thu, 30 Nov 2023 06:19:47 -0800 (PST)
X-QQ-GoodBg: 1
X-QQ-SSF: 00400000000000F0
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
X-QQ-FEAT: RLrSOnjbvYFLS9Au1WgMEEqTHGu/f2q+3LyWQUIupY3HppRYU1RHAXoMr6Y9b
	tL+7McPbnjP6rY20AdB5khpnDysVAGmikqc9aLT9fg9UB1OagwA7ENP54De9hpcoMzqEwrI
	0U3TUMjd61A6/OjpvyLwBehbVygy0eP1p9qBH1jeVSwqSm25cBB16PfJMzjhWPJx0twd76u
	bMSns+UMkYhjyjtYsFQFfSPJsGSgAo6N3VMjDylR7mBz5XQkbJRtL9Sq+YIAdIi8QkeF+Vw
	o672Ee3AA/ZvlM4+s6Mme9LIJC/d5cc+78nYQjWR6ccOnNeljcX9U0EcEhk5By97PE+o33n
	r6PVRXCQ5Vv8yqI6h3gHVKYSPiquo955j8kTj/vPP5qG+3n2Xc=
X-QQ-BUSINESS-ORIGIN: 2
X-QQ-STYLE: 
X-QQ-mid: t5gz7a-2t1701353836t3882909
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
Date: Thu, 30 Nov 2023 22:17:16 +0800
X-Priority: 3
Message-ID: <tencent_7B1A767250D25DDD0AA40C93@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
References: <20231124043548.86153-1-sashal@kernel.org>
	<tencent_27789A681229CCB77BE3E186@qq.com>
	<tencent_13CC3606408C86A21D09FB05@qq.com>
	<2023112442-glitzy-rocking-4a8a@gregkh>
	<tencent_429FA9BD3B6671BC788386A6@qq.com>
	<2023113015-justifier-nastiness-3c66@gregkh>
In-Reply-To: <2023113015-justifier-nastiness-3c66@gregkh>
X-QQ-ReplyHash: 4276312837
X-BIZMAIL-ID: 2044580030643976529
X-QQ-SENDSIZE: 520
Received: from qq.com (unknown [127.0.0.1])
	by smtp.qq.com (ESMTP) with SMTP
	id ; Thu, 30 Nov 2023 22:17:19 +0800 (CST)
Feedback-ID: t:uniontech.com:qybglogicsvrgz:qybglogicsvrgz5a-2

PiBDYW4geW91IHByb3ZpZGUganVzdCBhIGxpc3Qgb2YgZ2l0IGlkcywgd2l0aG91dCBmb290
bm90ZXMgb3IgbGlua3MsIGFzDQo+IHRoYXQgaXMgYSBwYWluIHRvIGF0dGVtcHQgdG8gY3V0
LXBhc3RlIGZyb20/DQpTdXJlLA0KDQp2NS4xNSBnaXQgaWQgbGlzdDoNCjE4ZTgwNTVjODgx
NDJkOGY2ZTIzZWJkYzM4YzEyNmVjMzc4NDRlNWQNCjhiMWQ2NmI1MDQzN2I2NWVmMTA5ZjMy
MjcwYmQ5MzZjYTU0MzdhODMNCg0KdjUuMTAgZ2l0IGlkIGxpc3Q6DQowZDQ4NGRiNjBmYzBj
NWY4ODQ4OTM5YTYxMDA0YzZmYTAxZmFkNjFhDQoxOGU4MDU1Yzg4MTQyZDhmNmUyM2ViZGMz
OGMxMjZlYzM3ODQ0ZTVkDQo4YjFkNjZiNTA0MzdiNjVlZjEwOWYzMjI3MGJkOTM2Y2E1NDM3
YTgzDQoNCnY1LjQgZ2l0IGlkIGxpc3Q6DQowZDQ4NGRiNjBmYzBjNWY4ODQ4OTM5YTYxMDA0
YzZmYTAxZmFkNjFhDQoxOGU4MDU1Yzg4MTQyZDhmNmUyM2ViZGMzOGMxMjZlYzM3ODQ0ZTVk
DQo4YjFkNjZiNTA0MzdiNjVlZjEwOWYzMjI3MGJkOTM2Y2E1NDM3YTgzDQoNCkJlc3QgcmVn
YXJkcw0KDQpndWFuIHdlbnRhbw==


