Return-Path: <stable+bounces-62588-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11EB893FBDA
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 18:52:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B58142828B2
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 16:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C96F1146A9F;
	Mon, 29 Jul 2024 16:52:32 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A226B17756
	for <stable@vger.kernel.org>; Mon, 29 Jul 2024 16:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722271952; cv=none; b=Y6R1GttkpPxb2CYrv/2LEnEJi8KLIKaR/PSMHlbnqU/aXY2VvvPuAPWB3Q6yPjoTTk9Psn9IPm7HglLr1Wzj/MNujSdXtbq5OvjIGkqyTzZOQW1W3BPOv9FH2nonfJ0ZomlKKLdok2WqrTHnO2n/lDdQGd92WqkjfGml6fh+DeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722271952; c=relaxed/simple;
	bh=Of1MCFgP9hUg/bC2CGkJfTIpFtqLQi6+Hzj1e3z8fpI=;
	h=From:To:Subject:Mime-Version:Content-Type:Date:Message-ID; b=RjxPEsteKaPFyuFQWtSzeGnzOXM/EH+Y3UbP07VMSyiLuQwZ0m9/3/lOexru4790qyl42JWgsSVtPNP2wdCwfA3FbB7NRDvXQRjuhLCktSDe2jlvD6HJ5ypPPtVLuBa7SKn/2zjZuA1XjUXAYlwspeNI8ldrEYemWl/Z8k5LOJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; arc=none smtp.client-ip=54.204.34.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
X-QQ-GoodBg: 1
X-QQ-SSF: 00400000000000F0
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
X-QQ-XMAILINFO: NSEFX6u+4l+KmwF/QRDHm477mIK2O3fXCNuraiUdmTYF6eBh4ZK+/9uFDvxQhu6PNEPGUGGv3p+q1Li8KY153QrRlYQ03QDontoqdfF7mme90/w5h9MxLnZVR/AkoKAYnFbUNMNHVF2NZWtEGX7qABxp1b9Hqh+w6qyes6DFWxIhassgVKjCAknNgHlKCz71kbjv/JyjsrDbV4lr0XWuDLWtOe0uTaPLlvA7qffKORHFlehLN3Rdyggznegziu0BgUwTiLG4+AfVabrCMeOPkoX9+HO+uCFPOX5w0MqDj4tEF15PZT7OKX4j6fVvusjprHOKMB1CvI3qaVGQDlskjxHnVVGkabLDaNH6UrOhLktKI5fTAlli8msVpSghk7vK82YyXu1MT0B70I5Sr4hnNfkFy41A/3FjjEOaWzb6q0BaP40/QMr5AG9D/oP3jnA899sSjb0i5hc3ZiaU8UbGHvfx4vI63xas817o+AKxcYC9+yTVUkeJW7Xe590CzN7/oB24l307K2C7vgCPPiuREfcIUGZAMMsfxgcsLBm7aVpGhDcrpOR3uvBkRUNgHbguncWkGbkusROISyPv1iPAUPxuGo7S9boVIfm4V7HU8sy7pEjE27e7VdiX4qqcjRcpDg6UXg1+wUQbRqF1oT2HqHDYC6smuJ5zYoEhgWPiz48dwCsfejhQksFyQYyIwNqrNz0hOkFqm7ARhIUFMqSLptxiMHJXR5cyqVTsmjS8HjkiRpECS79OJIZFxpwrL9PqQAclqTlRr78u10svGEon4oatFE814Xf5qB2TA6CERkZ/+OLlpzSfMFu3loA2NXkJNcUU+G5XSCdmk1jFiEkIHIxqQLbr21qfuNP+WH7PeJpWbDXNz/K05+lRYL2UtTc2j1v+JCs71dJoCGm6rZ14MHcnPGPlV3wfaGks4fVp8siyw3YQn1cUozA=
X-QQ-FEAT: D4aqtcRDiqQ3ysovIs8Z6Y3iskiNb0Rkxm+oYapygZM=
X-QQ-BUSINESS-ORIGIN: 2
X-QQ-Originating-IP: w8yHmjzr0IqgLRun9Z5DYzSm9CsD0e1RXIHkJvenqOo=
X-QQ-STYLE: 
X-QQ-mid: t5gz7a-2t1722271942t961535
From: "=?utf-8?B?V2VudGFvIEd1YW4=?=" <guanwentao@uniontech.com>
To: "=?utf-8?B?c3RhYmxl?=" <stable@vger.kernel.org>
Subject: [PATCH 6.6] minmax: scsi: fix mis-use of 'clamp()' in sr.c
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Date: Tue, 30 Jul 2024 00:52:22 +0800
X-Priority: 3
Message-ID: <tencent_581E12207F4CEF552409D708@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
X-BIZMAIL-ID: 7983525582627121584
X-QQ-SENDSIZE: 520
Received: from qq.com (unknown [127.0.0.1])
	by smtp.qq.com (ESMTP) with SMTP
	id ; Tue, 30 Jul 2024 00:52:23 +0800 (CST)
Feedback-ID: t:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1

SGVsbG8gQWxsOg0KDQpQbGVhc2UgYXBwbHkgdGhlIHVwc3RyZWFtIGNvbW1pdCANCg0KOWY0
OTliOCAoIm1pbm1heDogc2NzaTogZml4IG1pcy11c2Ugb2YgJ2NsYW1wKCknIGluIHNyLmMi
KQ0KDQp0byB2Ni42IGFuZCB2Ni4xMCBrZXJuZWwgdHJlZQ0KDQpGaXhlcyA6IDc0ZmFjMDRl
YzJmNGU0MTNlZjZiMGM3ODAwMTY2ZjY0Mzg2MjIxODMgDQoNCmluIHN0YWJsZSB0cmVlKCJz
Y3NpOiBzcjogRml4IHVuaW50ZW50aW9uYWwgYXJpdGhtZXRpYyB3cmFwYXJvdW5kIikNCg0K
QlJzDQpXZW50YW8gR3Vhbg==


