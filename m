Return-Path: <stable+bounces-169799-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E51EB2852D
	for <lists+stable@lfdr.de>; Fri, 15 Aug 2025 19:33:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD5D15A3E22
	for <lists+stable@lfdr.de>; Fri, 15 Aug 2025 17:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AD3E3176E9;
	Fri, 15 Aug 2025 17:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="gSjX2RzV"
X-Original-To: stable@vger.kernel.org
Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 405BF3176E4
	for <stable@vger.kernel.org>; Fri, 15 Aug 2025 17:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.169.211.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755279148; cv=none; b=UKZu5B5sF3YA1lezXCLRia5O6q5YPMP1a/KUWKo0lzH30QuhvB8/+DG14SKthhRHU3WKH+aTP5Xhb/tYg3BHiQEoRZiMJ3nVMBScScQL2DYssAL4G4hmbyEu2jMmz10w/Icqftwl1FAIi+t2Gu4GzVZ2ltDi94cWpqWxyNsZUog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755279148; c=relaxed/simple;
	bh=wMwF+6R5tf8Qr5wPp7W/Piz0j0Tca1jHE+ufN5Y0+7k=;
	h=From:To:Cc:Subject:Mime-Version:Content-Type:Date:Message-ID:
	 References:In-Reply-To; b=ZlbWOJFTLcuNGC+NZmTfm6JUYZV1/nGRb/jWHJklgS1LXBPpeCAwVvoktCl/CiJP2OTDB5mCKQFjrqwZ4PfWqrpH084/xghnmyIfgHpKpqPPm0nDrFIn08/aWyy4Jb/fc0vBY/DMMsb4y7ORH5Tx/tblnHs0ntVwqJZ+knDL/0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=gSjX2RzV; arc=none smtp.client-ip=18.169.211.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1755279125;
	bh=wMwF+6R5tf8Qr5wPp7W/Piz0j0Tca1jHE+ufN5Y0+7k=;
	h=From:To:Subject:Mime-Version:Date:Message-ID;
	b=gSjX2RzVLJuYeyjsHYqgai2U8f8twE9aof/ysGYsf12+Hsu5L9fbn7yqLkZ/2rP94
	 nLgQwCwqDMDhSNwRzqCZs+Xwuh9b63IFFmd41WyYhrx+U/a4vpk7UnE18XN5w/mgnd
	 wLgizgYWFdPk+1hTCyGpMqnEGBZgXmFmxPOga6oY=
EX-QQ-RecipientCnt: 2
X-QQ-GoodBg: 1
X-QQ-SSF: 00400000000000F0
X-QQ-FEAT: D4aqtcRDiqST8P4pfj07qGG6ZowgZlQrBrKFg+dHp6U=
X-QQ-BUSINESS-ORIGIN: 2
X-QQ-Originating-IP: /g6HJ1IUINW8UegX24sCAhZr68J626u51VqN5T+xEZo=
X-QQ-STYLE: 
X-QQ-mid: lv3sz3a-6t1755279124t0b5e8ba7
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
Date: Fri, 15 Aug 2025 17:32:03 +0000
X-Priority: 3
Message-ID: <tencent_51B9769C7A0CB78C42BEA895@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
References: <tencent_07D4D9EB5CEA414A085CA5C3@qq.com>
	<2025081504-overplay-unaired-854e@gregkh>
	<tencent_7A3AC9F50BB7F1803289E2C9@qq.com>
	<2025081531-spectacle-cubicle-8a01@gregkh>
	<tencent_22A78AF256A8A111670D11A2@qq.com>
In-Reply-To: <tencent_22A78AF256A8A111670D11A2@qq.com>
X-QQ-ReplyHash: 1858571711
X-BIZMAIL-ID: 1753730599056413524
X-QQ-SENDSIZE: 520
Received: from qq.com (unknown [127.0.0.1])
	by smtp.qq.com (ESMTP) with SMTP
	id ; Sat, 16 Aug 2025 01:32:04 +0800 (CST)
Feedback-ID: lv:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: NzOHSugmTg7Xpg5qCW4H+RDhGSA2MVa+r55Om/U9F0N6xJk7QCRjsqKx
	ADXYj3ctWSSeIlKCxF0Z3eUkq/0Yx8X45pGw8Erd1I/Kp37emM2kjGo/O/7ThGFhfjtvcVW
	g9pM70e7IQLc2MBIH34j6erJLc5MvatnOyAwr+LihF1adOTDiw+iGFEgwxrc2zjGh1kC9Q/
	OAPcR7CxsOf3hPOuNsRhO8k3eD/if1ZiFRbyoA3irL7+ybyprmv9YOOjH8zUBO6BVRR+rkn
	vzJRYp4tLpfGvQjxSgDsg9W8+Gurz5p08BEtEtAy5RLNfzcp+uJ8oBnYLJ2v+X75lR6p5eK
	bEjXkWbi7hZrUEH0FqxJcuuhicpr+y/V8sm+IruxHELCaRum09maI4PbX5ScSs/1KSQfcXH
	wttm9WnFP1WjYnqDKPRicCKBBJfOFMd/wZQb3sciGbNjAB5Uxf69IcDoA6HnZPK9EUV9DVF
	PMGW6xBy2Ep3U7ZIl93naKiGSG78coMjGdaCKxCGFof8fYx5R2+NusuUnZLRWLqqIoFrbah
	fkcMWCBjiC5R2QksxsJkDWVRZ2817Bl87x5P9euDw85xuvtDAguWerDHK9ncb5srWFnUZ/q
	kcjm4zw0dBebE7oyV2dVY+1mOaqMtgNfS032fgXM4VTjKL5bxeyWDmSlG/qwiWFsS22WWng
	eW6ZShXR8dyDKEf+zXqtz3Pt2NXEtejy2lyXC6P3ZocNodd8kB+lFtwKJTRkv+UjD2UU0kU
	QODCmk10M8ddJUeAoDRAo9sV0jb6SBjIOuZqp08AEoIdFExB/JkbG7YPJsXOPT2KIrr1kfm
	EU/KsfWiF4t79uBR382F1ugugHU45acFMDVlSk8UEyrrPOq/TViSKvfF2CrPXwDllmYFR7H
	//BdotnhV4Dt+clljhGq7x18BKvBp3Xvq+buX57Q8efMVaqKnPGd6IB9J3bY5qO8x86HnCF
	L956SqwY9Uqu5mU5BHVeQCT1NJPiID+c62s/QZasxNXQ08/mjAaR9iPSDSq1+sV+aeboD6n
	QL2CLkUEyd7p/6R89uapuJE263nRE=
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
X-QQ-RECHKSPAM: 0

RGVhciBHcmVnLA0KDQogICAgT29wcywgSSBtaXNzZWQgdGhlIHdob2xlIHRoaW5ncywgaXQg
d2lsbCBidWlsZCBmYWlsZWQsIGkgd2lsbCBzZW5kIHRoZSBmdWxsIHBhdGNoZXMgc2VyaWVz
IGxhdGVyLg0KDQpCZXN0IFJlZ2FyZHMNCldlbnRhbyBHdWFu


