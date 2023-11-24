Return-Path: <stable+bounces-321-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49C6A7F79BA
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 17:57:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35A6CB20EFB
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 16:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9474925749;
	Fri, 24 Nov 2023 16:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: stable@vger.kernel.org
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ED16127
	for <stable@vger.kernel.org>; Fri, 24 Nov 2023 08:57:06 -0800 (PST)
X-QQ-GoodBg: 1
X-QQ-SSF: 00400000000000F0
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
X-QQ-FEAT: 5t5I+dY+gqrNRWZRLr9PZhN5EwjshSa/ihRsCC0LCOi/L3qEjIt/FILsA856x
	g3Pe8T+sEjiSnv8Mn5ccoKv3Q52uEyYRDAU7v39iz73DniU6SVS4dqeEwP01IrfklFnib0b
	eW5zvriLXnkJkXkUh18YD0BZXFRPHvlMixzR1glDjmTG3smBhpuZBRpmU4JSBbzWvcRrEnX
	9YqMnJRmViXHrx4basGUlTTr8lXsCN0NJwciysq5uNFOuiWXNQERLvXvYYN/YqeS2/4KHMr
	bUU3DdJoaqR0DcKgENMZ0RYBtsDCOrLXDr0EqJuMJRbV7BIBBMlvW9Z+dJnwKsTsQZ6n6D5
	21i/AiZU9vdE80d++/C++2LvIyULWkUpiI056mV
X-QQ-BUSINESS-ORIGIN: 2
X-QQ-STYLE: 
X-QQ-mid: t5gz7a-2t1700844994t7846476
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
Date: Sat, 25 Nov 2023 00:56:34 +0800
X-Priority: 3
Message-ID: <tencent_429FA9BD3B6671BC788386A6@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
References: <20231124043548.86153-1-sashal@kernel.org>
	<tencent_27789A681229CCB77BE3E186@qq.com>
	<tencent_13CC3606408C86A21D09FB05@qq.com>
	<2023112442-glitzy-rocking-4a8a@gregkh>
In-Reply-To: <2023112442-glitzy-rocking-4a8a@gregkh>
X-QQ-ReplyHash: 753283421
X-BIZMAIL-ID: 15878798818860015155
X-QQ-SENDSIZE: 520
Received: from qq.com (unknown [127.0.0.1])
	by smtp.qq.com (ESMTP) with SMTP
	id ; Sat, 25 Nov 2023 00:56:37 +0800 (CST)
Feedback-ID: t:uniontech.com:qybglogicsvrgz:qybglogicsvrgz5a-2

SGVsbG8gR3JlZzoNCiAgICBJIHRoaWluayB0aGF0IHRoZSBtb3N0IGNsZWFuIHRoaW5nIHRo
YXQgYmFja3BvcnQgdG8gdjYuMSBsdHMgdHJlZSwNCmJlY2F1c2UgaXQgaGFzICJBZGQgc3Vw
cG9ydCBmb3IgUlRMODg1MkIiIGNvbW1pdCBsaW5rIFsxXToNCg0KICAgIEluIHY1LjE1IGx0
cyB0cmVlLGl0IG1pc3MgcGF0Y2ggWzFdLg0KICAgIEluIHY1LjEwIGx0cyB0cmVlLGl0IG1p
c3MgIkFkZCBzdXBwb3J0IGZvciBSVEw4ODUyQSJbMl0gc28gImdpdCBhbSINCmNvbW1hbmQg
bm90IHNpbXBseSB3b3JrLGJ1dCB3aXRob3V0IHRoZSBwYXRjaCBSVEw4ODUyQiB3b3Jrcy4N
CiAgICBJbiB2NS40IGx0cyB0cmVlLGl0IG1pc3MgbW9yZSBpZHMsbmVlZCBtb3JlIGVmZm9y
dHMgdG8gZG8uSWYgc29tZW9uZQ0KbmVlZCxuZWVkIHRvIGJhY2twb3J0IHRoZWlyIG93biBw
aWQvdmlkIHBhaXJzLg0KICAgIEluIHY0LjE5IGx0cyB0cmVlLGl0IG1pc3MgcGF0Y2ggWzNd
LHNvIGZpcm13YXJlIGRvd25sb2FkIHdpbGwgZmFpbGVkLg0KDQogICAgRm9yIGJhY2twb3J0
IHBhdGNoZXNbNF1bNV1bNl1bN11bOF0sDQogICAgdGhleSBtaXNzICJBZGQgc3VwcG9ydCBm
b3IgUlRMODg1MkMiWzldIGluIHY1LjE1IGFuZCB2NS4xMCBsdHMgdHJlZS4NCiAgICBPdGhl
cndpc2UsSSBhbHNvIGZvdW5kIHRoYXQgaW4gdjUuMTAgbHRzIHRyZWUgcGF0aCBmaWxlOg0K
ICAgIHJvb3QvZHJpdmVycy9ibHVldG9vdGgvYnR1c2IuYw0KICAgIE1UNzkyMiBpZCBbMTBd
IFsxMV0gYWRkIHdpdGhvdXQgaXRzIGRlcGVuZGVuY3kgWzEyXSBbMTNdDQogICAgQVgyMTAg
aWQgWzE0XSBhZGQgd2l0aG91dCBpdHMgZGVwZW5kZW5jeSBbMTVdDQogICAgU29ycnkgZm9y
IG1heWJlIEkgbWlzcyBzb21lIGRldmljZSBpZC5Ib3cgZG8gb3RoZXIgcGVvcGxlIHRoaW5r
IHRoZSANCnNpdHVhdGlvbiB3aGVyZSBzb21lIEJUIGlkcyBiYWNrcG9ydHMgYXJlIGRvbmUg
d2l0aG91dCBkZXBlbmRlbmNpZXM/DQoNCkJlc3QgcmVnYXJkcw0KZ3VhbiB3ZW50YW8NCg0K
bGluazoNClJUTDg4NTI6DQpbMV0gaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xp
bnV4L2tlcm5lbC9naXQvc3RhYmxlL2xpbnV4LmdpdC9jb21taXQvP2g9djYuMSZpZD0xOGU4
MDU1Yzg4MTQyZDhmNmUyM2ViZGMzOGMxMjZlYzM3ODQ0ZTVkDQpbMl0gaHR0cHM6Ly9naXQu
a2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvc3RhYmxlL2xpbnV4LmdpdC9j
b21taXQvP2lkPTBkNDg0ZGI2MGZjMGM1Zjg4NDg5MzlhNjEwMDRjNmZhMDFmYWQ2MWENClsz
XSBodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9zdGFi
bGUvbGludXguZ2l0L2NvbW1pdC8/aD1saW51eC01LjQueSZpZD1jZjBkOWE3MDVkODFhMGY1
ODE4NjVjZWZlMDg4MGYyOTU4OWRkMDZmDQpSVEw4ODUyQzoNCls0XSBodHRwczovL2dpdC5r
ZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9zdGFibGUvbGludXguZ2l0L2Nv
bW1pdC8/aD12NS4xMC4yMDEmaWQ9NzU3NDJmZmMzNjMwMjAzZTk1ODQ0YzcyYzcxNDRmNTA3
ZTJhNTU3ZA0KWzVdIGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJu
ZWwvZ2l0L3N0YWJsZS9saW51eC5naXQvY29tbWl0Lz9oPXY1LjEwLjIwMSZpZD00MGUyZTdm
MWJmMDMwMWQxZWQ3NDM3YjEwZDllMWM5MmNiNTFiZjgxDQpbNl0gaHR0cHM6Ly9naXQua2Vy
bmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvc3RhYmxlL2xpbnV4LmdpdC9jb21t
aXQvP2g9djUuMTAuMjAxJmlkPTljNDViYjM2M2UyNmU4NmViYWYyMGY2ZDIwMDliZWRmMTlm
YzBkMzkNCls3XSBodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVs
L2dpdC9zdGFibGUvbGludXguZ2l0L2NvbW1pdC8/aD12NS4xMC4yMDEmaWQ9M2EyOTJjYjE4
MTMyY2I3YWYzYTE0NjYxM2YxYzlhNDdlZjZmODQ2Mw0KWzhdIGh0dHBzOi8vZ2l0Lmtlcm5l
bC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3N0YWJsZS9saW51eC5naXQvY29tbWl0
Lz9oPXY1LjEwLjIwMSZpZD0xYTJhMmUzNDU2OWNmODVjYWQ3NDNlZTgwOTVkMDdjM2NiYTU0
NzNiDQpbOV0gaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9n
aXQvc3RhYmxlL2xpbnV4LmdpdC9jb21taXQvP2lkPThiMWQ2NmI1MDQzN2I2NWVmMTA5ZjMy
MjcwYmQ5MzZjYTU0MzdhODMNCk1UNzkyMjoNClsxMF0gaHR0cHM6Ly9naXQua2VybmVsLm9y
Zy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvc3RhYmxlL2xpbnV4LmdpdC9jb21taXQvP2g9
bGludXgtNS4xMC55JmlkPWYxOWFkZDVjNzc2MDE1OTlmNTJkZDdlMzU1NGU1OGRhNWQyNTM2
N2MNClsxMV0gaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9n
aXQvc3RhYmxlL2xpbnV4LmdpdC9jb21taXQvP2g9bGludXgtNS4xMC55JmlkPWMyMDAyMWNl
OTQ1ZjM4ZTg1OTc1NTE2ODdmZGIxMTViZmNhN2FlODYNClsxMl0gaHR0cHM6Ly9naXQua2Vy
bmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvc3RhYmxlL2xpbnV4LmdpdC9jb21t
aXQvP2g9bGludXgtNS4xMi55JmlkPWZjMzQyYzRkYzQwODc1NGY1MGYxOWRjODMyMTUyZmJi
NGI3M2YxZTYNClsxM10gaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tl
cm5lbC9naXQvc3RhYmxlL2xpbnV4LmdpdC9jb21taXQvP2g9bGludXgtNS4xNS55JmlkPTNm
NTAyMTQ3ZmZjM2Y5OTczNDcxYWRiZjE2Njk3NTY5ZjYyNmVlNWENCkFYMjEwOg0KWzE0XSBo
dHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9zdGFibGUv
bGludXguZ2l0L2NvbW1pdC8/aD1saW51eC01LjEwLnkmaWQ9ODc1ZTE2NzU5MDA1ZTNiZGFh
ODRlYjI3NDEyODFmMzdiYTM1Yjg4Ng0KWzE1XSBodHRwczovL3BhdGNod29yay5rZXJuZWwu
b3JnL3Byb2plY3QvYmx1ZXRvb3RoL2xpc3QvP3Nlcmllcz0zODc0NzUmc3RhdGU9JTJBJmFy
Y2hpdmU9Ym90aA==


