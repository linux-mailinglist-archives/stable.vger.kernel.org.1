Return-Path: <stable+bounces-296-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FC917F7715
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 16:01:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41CBB281F2B
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 15:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D61772D7BA;
	Fri, 24 Nov 2023 15:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: stable@vger.kernel.org
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E3E6D72;
	Fri, 24 Nov 2023 07:01:24 -0800 (PST)
X-QQ-GoodBg: 1
X-QQ-SSF: 00400000000000F0
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
X-QQ-FEAT: 5q30pvLz2ieQiYrv5Af2uT/XHof+9zwahlTxVP+BvkfSJnSazPUsgzsKXGU5P
	a77P2TJ3TN4latNmxMv/ljP6WXZdTQ5EaCCcSxInpa0sPcpTkRhSs1z7I68n4BhruvhnPuG
	iY5JsgqFZZiGJ/4d3Q6qTxwB8YZjyDRHkKzjGiIhZozTMdjdEUMPr1dl8lsWMouXapp+imx
	3rrOOYWoh7NT9jpQY2QOmd8h/fd+wB/r2cOVqf6J+aZ0WyjdDNXjwF2Z5ue77GIINdeAAgw
	noL0RMxintuXJp4TJ4VxhOUjBPWtuOpNmrF2Wyx0E0bdOM7izB1P3r0NldrGb0dXtw9Va14
	DcxKGAhBKCkXlX6BxRjRq085aX6hTn5B950ixacvtCVx0gY8aqAiPhQCcGfB16qYk/ma4u9
X-QQ-BUSINESS-ORIGIN: 2
X-QQ-STYLE: 
X-QQ-mid: t5gz7a-2t1700837956t5750172
From: "=?utf-8?B?5YWz5paH5rab?=" <guanwentao@uniontech.com>
To: "=?utf-8?B?U2FzaGEgTGV2aW4=?=" <sashal@kernel.org>, "=?utf-8?B?c3RhYmxlLWNvbW1pdHM=?=" <stable-commits@vger.kernel.org>
Cc: "=?utf-8?B?c3RhYmxl?=" <stable@vger.kernel.org>, "=?utf-8?B?bWFyY2Vs?=" <marcel@holtmann.org>, "=?utf-8?B?bHVpei5kZW50eg==?=" <luiz.dentz@gmail.com>, "=?utf-8?B?aGlsZGF3dQ==?=" <hildawu@realtek.com>
Subject: [Re V2]:Patch "Bluetooth: btusb: Add 0bda:b85b for Fn-Link RTL8852BE" has been added to the 5.10-stable tree
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Date: Fri, 24 Nov 2023 14:59:15 +0000
X-Priority: 3
Message-ID: <tencent_13CC3606408C86A21D09FB05@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
References: <20231124043548.86153-1-sashal@kernel.org>
	<tencent_27789A681229CCB77BE3E186@qq.com>
In-Reply-To: <tencent_27789A681229CCB77BE3E186@qq.com>
X-QQ-ReplyHash: 1213644692
X-BIZMAIL-ID: 508532518924342186
X-QQ-SENDSIZE: 520
Received: from qq.com (unknown [127.0.0.1])
	by smtp.qq.com (ESMTP) with SMTP
	id ; Fri, 24 Nov 2023 22:59:18 +0800 (CST)
Feedback-ID: t:uniontech.com:qybglogicsvrgz:qybglogicsvrgz5a-2

SGVsbG8gTGV2aW46DQoNCiAgICBBcG9sb2dpemUgZm9yIG15IEhUTUwgZm9ybWF0IHBhc3Qu
SSBkaXNjb3ZlcmVkIHRoYXQgdGhlIGJhY2twb3J0IHBhdGNoZXMgYWxzbyBoYXZlIGRlcGVu
ZGVuY3kgaW4gNS4xMCBsdHMgdHJlZToNCg0KWzFdaHR0cHM6Ly9naXQua2VybmVsLm9yZy9w
dWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvc3RhYmxlL2xpbnV4LmdpdC9jb21taXQvP2g9djUu
MTAuMjAxJmlkPTc1NzQyZmZjMzYzMDIwM2U5NTg0NGM3MmM3MTQ0ZjUwN2UyYTU1N2QNClsy
XWh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3N0YWJs
ZS9saW51eC5naXQvY29tbWl0Lz9oPXY1LjEwLjIwMSZpZD00MGUyZTdmMWJmMDMwMWQxZWQ3
NDM3YjEwZDllMWM5MmNiNTFiZjgxDQpbM11odHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9z
Y20vbGludXgva2VybmVsL2dpdC9zdGFibGUvbGludXguZ2l0L2NvbW1pdC8/aD12NS4xMC4y
MDEmaWQ9OWM0NWJiMzYzZTI2ZTg2ZWJhZjIwZjZkMjAwOWJlZGYxOWZjMGQzOQ0KWzRdaHR0
cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvc3RhYmxlL2xp
bnV4LmdpdC9jb21taXQvP2g9djUuMTAuMjAxJmlkPTNhMjkyY2IxODEzMmNiN2FmM2ExNDY2
MTNmMWM5YTQ3ZWY2Zjg0NjMNCls1XWh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9s
aW51eC9rZXJuZWwvZ2l0L3N0YWJsZS9saW51eC5naXQvY29tbWl0Lz9oPXY1LjEwLjIwMSZp
ZD0xYTJhMmUzNDU2OWNmODVjYWQ3NDNlZTgwOTVkMDdjM2NiYTU0NzNiDQoNCiAgICBhbmQg
dXBkYXRlIHZlcnNpb24gMiBkZXBlbmQgcGF0Y2hlcyBsaW5rOg0KDQpbMV0gUlRMODg1MkFF
OiBodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC90b3J2
YWxkcy9saW51eC5naXQvY29tbWl0Lz9pZD0wZDQ4NGRiNjBmYzBjNWY4ODQ4OTM5YTYxMDA0
YzZmYTAxZmFkNjFhDQpbMl0gUlRMODg1MkJFOiBodHRwczovL2dpdC5rZXJuZWwub3JnL3B1
Yi9zY20vbGludXgva2VybmVsL2dpdC90b3J2YWxkcy9saW51eC5naXQvY29tbWl0Lz9pZD0x
OGU4MDU1Yzg4MTQyZDhmNmUyM2ViZGMzOGMxMjZlYzM3ODQ0ZTVkIA0KWzNdIFJUTDg4NTJD
RTogaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvdG9y
dmFsZHMvbGludXguZ2l0L2NvbW1pdC8/aWQ9OGIxZDY2YjUwNDM3YjY1ZWYxMDlmMzIyNzBi
ZDkzNmNhNTQzN2E4Mw0KWzRdIEZXOiBodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20v
bGludXgva2VybmVsL2dpdC90b3J2YWxkcy9saW51eC5naXQvY29tbWl0Lz9pZD1jZjBkOWE3
MDVkODFhMGY1ODE4NjVjZWZlMDg4MGYyOTU4OWRkMDZmDQoNCi0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCg0KICBJ
IHdvdWxkIGxpa2UgdG8gZXhwcmVzcyBteSBncmF0aXR1ZGUgZm9yIHlvdSBlZmZvcnRzLGFu
ZCBJIHdhbnQgdG8gcHJvdmlkZSB5b3Ugd2l0aCB0aGUgYmFja3BvcnQgdGlwIHdoZW4ga2Vy
bmVsIDw9NS4xMCA6DQp0aGUgUlRMODg1MntBLEIsQ30gQlQgY2hpcCBzZXJpZXMgZGVwZW5k
IHBhdGNoZXMgaW4gdGhhdCBwYXRjaCBbMV0odjUuMTEpIGFuZCBsb2FkIG5ldyBmaXJtd2Fy
ZSBuZWVkIHRoYXQgcGF0Y2ggWzJdKHY1LjQpLg0KQXBvbG9naXplIGZvciBteSBwb29sIEVu
Z2xpc2guDQoNCmxpbms6DQpbMV0gaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xp
bnV4L2tlcm5lbC9naXQvdG9ydmFsZHMvbGludXguZ2l0L2NvbW1pdC8/aWQ9MGQ0ODRkYjYw
ZmMwYzVmODg0ODkzOWE2MTAwNGM2ZmEwMWZhZDYxYQ0KWzJdIGh0dHBzOi8vZ2l0Lmtlcm5l
bC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3RvcnZhbGRzL2xpbnV4LmdpdC9jb21t
aXQvP2lkPWNmMGQ5YTcwNWQ4MWEwZjU4MTg2NWNlZmUwODgwZjI5NTg5ZGQwNmY=


