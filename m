Return-Path: <stable+bounces-116806-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BAEDA3A256
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 17:16:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5357B3A6CFE
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 16:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF3E726F442;
	Tue, 18 Feb 2025 16:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="f5lg3l4Z"
X-Original-To: stable@vger.kernel.org
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3D1B197A76
	for <stable@vger.kernel.org>; Tue, 18 Feb 2025 16:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739895362; cv=none; b=DkvrG4xuBSzM9utWzWxtIIuuCwLMa/Ulpw7XS3Fy1tHoXTXVt8qGMVBKiXcrN41ZVeBRZXS78L8FN5crm5NYvRhT06Ux3Uj5FDp2e/1+WZJAFZnW35J9meBuNI1DGJPtwjYLV8Faalv96Ei7bjh7bLjAontDdYMBU2PCSr09wlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739895362; c=relaxed/simple;
	bh=4DCRbtgkDw0IZjAW49il1ZVipOsM68oGgrvBByju2I8=;
	h=From:To:Cc:Subject:Mime-Version:Content-Type:Date:Message-ID:
	 References:In-Reply-To; b=DFlCLD2OBFvUfjgYgatROrpEF1Kk6Wu7tOQ7heNQBnrnQ25ToVV7nhqtbC+cUT2cgubjkJQpYVDRaXsANQZa4lU6lsRGHxXB2iAnyiz0s9c8fBHmA2dXAFOCjhU/XkbWJ4fa85U2zlDcf9Th+9aN+Ve++oj5EdHPyPeoq7/9wSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=f5lg3l4Z; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1739895325;
	bh=4DCRbtgkDw0IZjAW49il1ZVipOsM68oGgrvBByju2I8=;
	h=From:To:Subject:Mime-Version:Date:Message-ID;
	b=f5lg3l4ZhFICqyMPkwa055O6+ewj2E417mKt1D336/IU9r2BVsh/XOoVcN2I79TWF
	 0tcG9FDeld4FjuV6Dq1AG5rK8Vo/Ei0Fs0x2nCosevq1J8M+KHGilzuplo+aZWzbf4
	 gWobTUHnXHSxRK03Y8Uz8H456mPsH7CQ1/TpK9gY=
X-QQ-GoodBg: 1
X-QQ-SSF: 00400000000000F0
X-QQ-FEAT: D4aqtcRDiqT6iyfUez+DXx4B7ybItHVbSxkDlA8/kMI=
X-QQ-BUSINESS-ORIGIN: 2
X-QQ-Originating-IP: 8hQkX+uVq0WVgQcfgVStrEMe3/btD/Dx1I92wJ2RjVQ=
X-QQ-STYLE: 
X-QQ-mid: v3sz3a-6t1739895310t4318913
From: "=?utf-8?B?V2VudGFvIEd1YW4=?=" <guanwentao@uniontech.com>
To: "=?utf-8?B?5YWz5paH5rab?=" <guanwentao@uniontech.com>, "=?utf-8?B?c3RhYmxl?=" <stable@vger.kernel.org>
Cc: "=?utf-8?B?cGFiZW5p?=" <pabeni@redhat.com>, "=?utf-8?B?ZWR1bWF6ZXQ=?=" <edumazet@google.com>, "=?utf-8?B?a3ViYQ==?=" <kuba@kernel.org>
Subject: Re:[PATCH 6.12.y] Revert "net: skb: introduce and use a single page frag cache"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Date: Wed, 19 Feb 2025 00:15:10 +0800
X-Priority: 3
Message-ID: <tencent_4EA91163291FFDC7005AD482@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
References: <2025021859-renewal-onto-1877@gregkh>
	<20250218161035.25064-1-guanwentao@uniontech.com>
In-Reply-To: <20250218161035.25064-1-guanwentao@uniontech.com>
X-QQ-ReplyHash: 2288748950
X-BIZMAIL-ID: 13233809376332602693
X-QQ-SENDSIZE: 520
Received: from qq.com (unknown [127.0.0.1])
	by smtp.qq.com (ESMTP) with SMTP
	id ; Wed, 19 Feb 2025 00:15:11 +0800 (CST)
Feedback-ID: v:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: OPxYnD53Kkts4fnFn89V/1i07YqL5nAkElceSQoUbAF6gvsAZcvEmWBz
	MIvEx/JMZSjRMqTOED6xkEjweDWQvlV6YiGgNtWYwHE0gB7YPW99l4ooX8u/ECkbGbu4lGW
	y1z7gcxCt2GkYfxoUqSrXFaDuRU1QWl8mRzK8Mkl3GLRGivSHNP8p7T/CTunqgPfA0n2yg7
	qILpelGVxXFiSN2qV5yGzntrs8uwrNReodJsocn1GEviW9MIWGK5UPf+oA76DCXh945C5h4
	LLy+BELQenN/NDewpD8cEHk1ErXWlMyZEQGVXuZHEbt7zqQestWS3UB0zcxu+tTEL0avRNJ
	IbJFaPZdzDp249ozl9AGOGFa2VJ3PM1DxivOriZtj8gutSrfMkQMYevPRU0Hy2YFdJuY8iz
	ABNUdx6P5n+iCLS1oJ0Zn5rM9txFsW0m5DULRzQW2SQNbz2PnoyTkAG+4MUprVw5z9MPkCk
	G7+3kODCgQBVVQKrIV3M85MtETwBOFH6aRhszy7sihVXel9n13qAGDjQNbQqPyH+w4qrYof
	SB6zNVrmvj7GFw7n94OKT5tyiGLmEK5g49prEQxUyZVJGVk+6HmuaIrBtlSO4Nz5fH5dhkf
	4CYNofxGAfNzpaMzMvkN27DX1UiaPBQaXwDF7dNUMW1loud8c/PWQ4ZTWJ4ksyErbmTdQMj
	w/MaEEG0bJ5XQY3wfrGPV/cEBa6hxzbfihUWFMjD1RxbgjlBZGq8hUc4xdo/clKtALR3g8t
	yQkdr7SQ6xv/qqT3WATlxUMAruTWt5yY0kky8aj8kwqfA2C84lPEJrUSwL+W24TOjCYh5bY
	XRBMPeOq203nJLOTUK/oT3wSqhNKP56jXwQg5JmUnbdGkwQ52SOWUG2zRPRqhrg28GKE1AQ
	lVLg7snuzjRcbVRC1byZ2lltKTqIElV9vXSzUCUdtV5xs4lGQ1hn2fz8ulEDkv1vUK9BPOx
	c1gWRXR8SR5FI/LoeCAWIUHHw8IrZ/Axv++wkqIo2Y+j05prtHw0mAmbHUuUCqSRtP8b4te
	S1nozOpo9kozDDTXqdP53NV+1h8uOFk16kW8ieiFEkn96BnYniH8mZMAX3DoJT46kijS2yU
	fmuJ1vNLhYS+iiYKNXZttpKwWATIrGURQ==
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
X-QQ-RECHKSPAM: 0

TkFLLCBhcyBjb21taXQgMDg5MmI4NDAzMThkLCBqdXN0IGlnbm9yZSBpdC4=


