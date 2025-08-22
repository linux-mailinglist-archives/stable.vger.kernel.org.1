Return-Path: <stable+bounces-172339-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B322B312A2
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 11:11:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E7A81CE54D4
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 09:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD3AC2E8DF2;
	Fri, 22 Aug 2025 09:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="jdLPM1HU"
X-Original-To: stable@vger.kernel.org
Received: from smtpbg154.qq.com (smtpbg154.qq.com [15.184.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF8A4D599
	for <stable@vger.kernel.org>; Fri, 22 Aug 2025 09:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=15.184.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755853867; cv=none; b=l9PUo7V8k/X/C0+oZfp75PcpLUdZq8BqO9lZlszzIo7HMgl/uRcs9kRnBv6cx7rDeHcMUDANXF6B7MvMhnTSfrGZZLNVMxKXKMZwBRQr3TTJDupw1+hAIyQz+PxpgZhSqUrq+wEH6xcqsuF4q2T9eHyeQfLd/qjGIs73XCHaPXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755853867; c=relaxed/simple;
	bh=c16mbk8um0QJ0Q8y+2xYVklMpwZhK43khxGJ61YVfK0=;
	h=From:To:Cc:Subject:Mime-Version:Content-Type:Date:Message-ID:
	 References:In-Reply-To; b=f44AD+vbdzuSTlkAkQnRStKpWW5uJic5oUvq8gdQDsxkI+2FeOLXinpEvly3PtpYFFM32YuxJyvU1eW7z55Luu4IUuWZvsWcZNvp3LU0mVnYBXd+KIp67qKKU2Q3jicksovrAaiGaSLY/Btw77Zi/eFx6HSvOT5NrOA2BsDVy3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=jdLPM1HU; arc=none smtp.client-ip=15.184.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1755853824;
	bh=c16mbk8um0QJ0Q8y+2xYVklMpwZhK43khxGJ61YVfK0=;
	h=From:To:Subject:Mime-Version:Date:Message-ID;
	b=jdLPM1HUl++I4qQAiYGl7mB5PTZpMnXbVEARSjXlcr3y0E4uwATr00nrqNhogCV9o
	 7hR/24Qsv4o+gK0wLPlw/At3F2oCMq6ZtFBWyLvurW4YhQcXtfLRdbddQr7/IWfPWq
	 9UPtddETet5QDsGaL8RSGYqCtabVT0kS9rTSlFik=
EX-QQ-RecipientCnt: 6
X-QQ-GoodBg: 1
X-QQ-SSF: 00400000000000F0
X-QQ-FEAT: D4aqtcRDiqST8P4pfj07qGG6ZowgZlQrBrKFg+dHp6U=
X-QQ-BUSINESS-ORIGIN: 2
X-QQ-Originating-IP: Rjya1ZIHqibtWDwAPGlGw1CdRPbWvYPWxANvja8dRWzvSsE+HWCcpkbfuWqnuAfz8OE46Grn3YMxXW5Int5QOQ==
X-QQ-STYLE: 
X-QQ-mid: lv3sz3a-6t1755853821t715d58ff
From: "=?utf-8?B?V2VudGFvIEd1YW4=?=" <guanwentao@uniontech.com>
To: "=?utf-8?B?R3JlZyBLSA==?=" <gregkh@linuxfoundation.org>
Cc: "=?utf-8?B?c3RhYmxl?=" <stable@vger.kernel.org>, "=?utf-8?B?VmluY2VudCBHdWl0dG90?=" <vincent.guittot@linaro.org>, "=?utf-8?B?TGludXMgVG9ydmFsZHM=?=" <torvalds@linux-foundation.org>, "=?utf-8?B?V3llcyBLYXJueQ==?=" <wkarny@gmail.com>, "=?utf-8?B?SW5nbyBNb2xuYXI=?=" <mingo@kernel.org>
Subject: Re: [PATCH 6.6 8/8] sched/fair: Fix frequency selection for non-invariant case
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Date: Fri, 22 Aug 2025 17:10:21 +0800
X-Priority: 3
Message-ID: <tencent_5707A7E476AEBAFE766F163D@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
References: <20250815181618.3199442-1-guanwentao@uniontech.com>
	<20250815181618.3199442-9-guanwentao@uniontech.com>
	<2025082258-starfish-crunching-77ba@gregkh>
In-Reply-To: <2025082258-starfish-crunching-77ba@gregkh>
X-QQ-ReplyHash: 1918228742
X-BIZMAIL-ID: 14022799221289470424
X-QQ-SENDSIZE: 520
Received: from qq.com (unknown [127.0.0.1])
	by smtp.qq.com (ESMTP) with SMTP
	id ; Fri, 22 Aug 2025 17:10:23 +0800 (CST)
Feedback-ID: lv:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: M6xBo1OmhlkXMNRTY8qWqNQwRoYarOJTq1OuLwJ/vJCKFaxySs6ih0iA
	YfTd+qcV0ZnxVTcnqkSxJiQfnOQ7cA+KO6zPBqQQUbsI/HUPWPqm9/Uf5tZ1lkn6PboKJV/
	RaaeWK4ZiqTJMF0Q+ZVrypNsptBQ8YcWE2TRINNkQYw0G49PF1TUaUnt1vcG9GUKu2mi0Vf
	giYmv+6z6vw+coTZ6KatqeGR0hfQMNlIqBdhHbk7WMQOmEF2qv8XkourOUTC2EdNUI4nEeX
	7wxC93Sn+w/M2Tfs1Bar7JWvE+W02BMfhR5T4aFk3wIxOY4brc9Kpitjs1iWkh39Yoe6qn+
	UHlKI0FfwtQsQh1E6NDULYZMXzTQAhViVaxqk81onYKFRLL8nNwEhgPU7qmAO+SLziRlFfq
	o1JhG8+zK0lLWdfwHCAmzlChYHV0eN/Ndv41fnQFWfPUbpIhmW9ZYgNuZCO6EeYfEXqkWLk
	pRiYH/sOKnZoJkiuv6uC5WL/DzJZpKAPAjmMjklZklXY5OMqbZwHlezhc0urzTjbAP7jZto
	HVIB2yCuQJlaAq33Kbc2jr2+hE/gpUVKYWAiOjZ9kzT/1pKiGo4UoqpzR7PhXk91iXJU3T8
	pZTmGFpROGWPWLUtPvnMEmP/TckM9b5QTSUa8+iMCkKQGdVX3LUPNCGCGWIPqSnuNrviMvj
	mXaMhC3uzDkXWLEXoPR0xKxKVuVCJhJYWx0yBoo5Z5NeoXCmEzo0A2/2tcy0riJxD1ft+R6
	TFIWOZnrjhbIj1BigzkNvkdkvRuSq1wzZpN9qdM94SnWS+Qj+WeuV8x7t7tf9Hv8eWXqzTj
	Obais9z9BXbWMfx66q92CpofHvQWRGjbvNtxk3D3pdUjnmswQMcYP8DbfnMQdNkJI4PWgKt
	6fKieBxICCiG7hmoyfBD8bz76W7v7a57K9F8w7O9JiTMKud8dKbWDEEbATl1OH+Q/NE4oQy
	DDa54/hXuZKqkDVxV4BiV+u21AehjmWexA6wCjLvojAAxhk3wDGRv8S0uxfK0DI7zxBL47j
	Y74SHpxTQuHR0Axo/X
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
X-QQ-RECHKSPAM: 0

RGVhciBHcmVnLA0KDQpPaGgsIGkgZm9yZ290IHRvIGFkZCB0aGUgc2lnbi1vZmYtYnkuLi4u
DQpUaGFua3MgdG8gcG9pbnQgaXQuDQpEbyBpIGFkZCBpdCBpbiB2MiBvciB5b3UgdGFrZSB0
aGUgc2lnbi1vZmYtYnk/DQoNClNpZ25lZC1vZmYtYnk6IFdlbnRhbyBHdWFuIDxndWFud2Vu
dGFvQHVuaW9udGVjaC5jb20+DQoNCkJlc3QgUmVnYXJkcw0KV2VudGFvIEd1YW4=


