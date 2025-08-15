Return-Path: <stable+bounces-169798-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43052B2852B
	for <lists+stable@lfdr.de>; Fri, 15 Aug 2025 19:33:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 965E1B065CE
	for <lists+stable@lfdr.de>; Fri, 15 Aug 2025 17:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC4BC317718;
	Fri, 15 Aug 2025 17:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="HNOKpU2X"
X-Original-To: stable@vger.kernel.org
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05CD6317715
	for <stable@vger.kernel.org>; Fri, 15 Aug 2025 17:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755278976; cv=none; b=HHY1jMEZDj3oZC4yVmiW7HtffPEFhIFXeygmwXEj6qDypmFpAv5d+/OzQk643wkS11gNb8arzqH75Xtpexbmq+ODoy5nGJpS6bpBT/6bqhktuAu1YRJ8T5RkyepIfdEohDboRaGLXYqlFBLSNYpXfG6DDYyn22rnSzSwncIhBAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755278976; c=relaxed/simple;
	bh=wCisWX22EQIkWsVm1TRlYG329sskuYmFSjravK4sSH8=;
	h=From:To:Cc:Subject:Mime-Version:Content-Type:Date:Message-ID:
	 References:In-Reply-To; b=rOFSwEOPfbESLzHU1Fvm0JvUmoa3L7kIO6dwMRKEGjxw+ohnWxVMksL8FCevvHP+8GKpT8uTRg6sgVMV0H+x3i1wXDaFpRncQcrbxyoDQ9HDzViOusrBjvVT5/tWlRVnl4wgtCWcsuP2kVJf3rOxTIom2eCRlLQ4CHVMWTL36R4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=HNOKpU2X; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1755278965;
	bh=wCisWX22EQIkWsVm1TRlYG329sskuYmFSjravK4sSH8=;
	h=From:To:Subject:Mime-Version:Date:Message-ID;
	b=HNOKpU2XZ/NyPda3CFmpESH0KCb+oLENvZ+sJ49Qq5YsmfEPxUHgkeYixUq2dDleC
	 VE7ZBtjtv2E6Utf9kJ9yKSz6MyLsIrwOAoKwt1sC4zRs/4LcDr8NznsVbIN/K83pwc
	 O7VQKBTdJSofeav7be9zZGzC+Lm3jya+NqIwnmUI=
EX-QQ-RecipientCnt: 2
X-QQ-GoodBg: 1
X-QQ-SSF: 00400000000000F0
X-QQ-FEAT: D4aqtcRDiqST8P4pfj07qGG6ZowgZlQrBrKFg+dHp6U=
X-QQ-BUSINESS-ORIGIN: 2
X-QQ-Originating-IP: qHzhyaMAiA0nU/h1HnhdEmnixf2IUGuQ8LySTy3zTkY=
X-QQ-STYLE: 
X-QQ-mid: lv3sz3a-6t1755278963t66f04a9a
From: "=?utf-8?B?V2VudGFvIEd1YW4=?=" <guanwentao@uniontech.com>
To: "=?utf-8?B?R3JlZyBLSA==?=" <gregkh@linuxfoundation.org>
Cc: "=?utf-8?B?c3RhYmxl?=" <stable@vger.kernel.org>
Subject: Re: [PATCH 6.6] sched/fair: Fix frequency selection for non-invariant case
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Date: Fri, 15 Aug 2025 17:29:23 +0000
X-Priority: 3
Message-ID: <tencent_22A78AF256A8A111670D11A2@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
References: <tencent_07D4D9EB5CEA414A085CA5C3@qq.com>
	<2025081504-overplay-unaired-854e@gregkh>
	<tencent_7A3AC9F50BB7F1803289E2C9@qq.com>
	<2025081531-spectacle-cubicle-8a01@gregkh>
In-Reply-To: <2025081531-spectacle-cubicle-8a01@gregkh>
X-QQ-ReplyHash: 1939796674
X-BIZMAIL-ID: 10275337337222192457
X-QQ-SENDSIZE: 520
Received: from qq.com (unknown [127.0.0.1])
	by smtp.qq.com (ESMTP) with SMTP
	id ; Sat, 16 Aug 2025 01:29:24 +0800 (CST)
Feedback-ID: lv:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: MPEeF6PUOsC8IUoy46yL6QqZih0v2ayyP/x2oE731azc+IXo9m26X4Kg
	MnnI++KHm44dWeasW+Umyu3ay9l9MHpEYvLl1g0u11nmh8f62HgjyFmFNw8O0UKKBja9hTd
	R3ReZFznhli2eHXZhQ3smmuuq+0erlqCNY7fqbED6YIOL2iInjRpt6PQn87+tGD24UvsUEh
	CG3K0tKPjxpbaK69pMdmtebJGtbTiod9vt5nfDpiLayeYjFvV2FI10qhfCLA7m9CUpE9D20
	0VthUNofssJqoJV8IKW5sDA7pUsj7+1csQgRR8b3Qt4/dcgmtOUiGPeWk1R/U/qIdc40wsn
	526bJ5gLTKGA/RQXjW/eB5vENQXQA6MqB0rnHwtAqZfwNFbf3oaN0iHOVkn1dfHfMUkCgTT
	2Xe1SRTeVr7sA6j5c8bJMr4JgTdLO9rMytYNa4ZCgLmY4dZz0yGvwo1xdTTVULyNQzUnDBL
	/XcH2tMYngytknxHQgPEiNu/1XtQmCgVpwJ9aaj2xZGq7FLT7vuY5XqNAgl4QOU3jVUxXQD
	uq2bXnFC+8cQBxky0AktDt45a7XHHKhqXy0LATPGrxXF1DK8rtPQ0W52Kpq6ehBymolMCL4
	78SLpQMYZAnGzlKnCDhmMuAvP6xqZmGblOVAmfkJ7vm0PR8h/Z0+Dys7SaUr5u+HIsb7kvV
	XF8VDAZIFcF70LK5SN9lBfyfmBBKCAcAdtN5KAzDZubPHhGNZTKVKqVye5R39A8Li06o2ec
	UWCPDlBu9DBn7AY11rKNrFFE/nNJ4vCF/yDqBVuNnwo9nsscP7XprCZ5LbDsXTuS4EkLc37
	VJmtV0pR0SuXWe22sKbK+2udGbgJtI8nM/Oml8ZOIzUNC4Tkj51Y78qeqB3qG9SIikTbYBV
	hAiM9lMVgoHuYlx1YEpaOXB/KMGRjLykE1mnWYuZzcWwiH3oWeXq6otdNxodWwE7yRjxSfC
	/lWetmfv+fL5yQajRoGq9PnDIjzxXNCSOlrk9YaQC5DLaKhIRmNtUpqzQn+33wlxE4a80j3
	qUlTGC6nqp+Jac60VfpIsrmNq8yTUgAozGDOZ8XuAQeT1KHzT4Z0/k0eYz9A7r70Mk3S80w
	A==
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
X-QQ-RECHKSPAM: 0

RGVhciBHcmVnLA0KICAgIE9oLCBJIG1pc3MgdGhlIHRoaW5nIHdoaWNoIGZpcnN0IGFwcGx5
IGIzZWRkZTQ0ZTVkNDUwNGMyM2ExNzY4MTk4NjVjZDYwM2ZkMTZkNmMNCigiY3B1ZnJlcS9z
Y2hlZHV0aWw6IFVzZSBhIGZpeGVkIHJlZmVyZW5jZSBmcmVxdWVuY3kiKSwgdGhlbiBhcHBs
eSANCmUzNzYxN2M4ZTUzYTFmN2ZjYmE2ZDVlMTA0MWY0ZmQ4YTI0MjVjMjcNCigic2NoZWQv
ZmFpcjogRml4IGZyZXF1ZW5jeSBzZWxlY3Rpb24gZm9yIG5vbi1pbnZhcmlhbnQgY2FzZSIp
Lg0KDQpzb3JyeS4uLg0KDQpCZXN0IFJlZ2FyZHMNCldlbnRhbyBHdWFuLg==


