Return-Path: <stable+bounces-119485-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CD0E5A43DD0
	for <lists+stable@lfdr.de>; Tue, 25 Feb 2025 12:38:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E71C77A6B9E
	for <lists+stable@lfdr.de>; Tue, 25 Feb 2025 11:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB272267AF6;
	Tue, 25 Feb 2025 11:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="Fx8DmUwN"
X-Original-To: stable@vger.kernel.org
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B28974C80;
	Tue, 25 Feb 2025 11:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740483528; cv=none; b=kyZ0b8T8fOYCNWhVB2N3NlnKwOMSRTFcmGuVcx4p6oiQbY+0cW/IBZ65XTkWFNkRQ8DxE4ng2JRjzoNAhz7tpdnBpcBeInP0TT/9BhMqG86MRs7Aoc7s9sc2oMpWOrIaKDm022QCz4810oDnb2NPUXfJHdLlnaGRuWZD0zlk9v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740483528; c=relaxed/simple;
	bh=7o1LhwlAcsJgqFTK4J681khp+AvnA4zXAdW/ZK8fgcY=;
	h=From:To:Cc:Subject:Mime-Version:Content-Type:Date:Message-ID:
	 References:In-Reply-To; b=cqALK0FjI1FTDIVOabHs0Y2T2wARYNGaVAclDlGqg5Y4GghsOfToPY83tyvw8msMPVb4U10bcrbrz1IVjggSm1oap2CcqC5Y5Gbm3JEUu4V58x+r9Y8swN4HybFEmYouR5n+XygWUvYv5ORzImdkcmCvnJaEar725UB5XVkX8rE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=Fx8DmUwN; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1740483461;
	bh=7o1LhwlAcsJgqFTK4J681khp+AvnA4zXAdW/ZK8fgcY=;
	h=From:To:Subject:Mime-Version:Date:Message-ID;
	b=Fx8DmUwNZJewxD15LNTJ5vMNr/YQUsIpa6YNjUaamLHwwREp5btz+eurbZ1nHB4Cj
	 +68/+D+/+9PuWQ4s4rf1GSyKtGfScO1zkgdZia3BxEZtylhuL2UfgEItxvv/q13d/o
	 2pzYSNqO29PCoNmypHUZINnrOA1qE0UEIk503a8I=
X-QQ-GoodBg: 1
X-QQ-SSF: 00400000000000F0
X-QQ-FEAT: D4aqtcRDiqT6iyfUez+DXx4B7ybItHVbSxkDlA8/kMI=
X-QQ-BUSINESS-ORIGIN: 2
X-QQ-Originating-IP: Xptfm9en8kSztH5x5sLIfL3u/YSEDpg5TCpVOgsGmtg=
X-QQ-STYLE: 
X-QQ-mid: v3sz3a-6t1740483459t397160
From: "=?utf-8?B?V2VudGFvIEd1YW4=?=" <guanwentao@uniontech.com>
To: "=?utf-8?B?U2xhZGUgV2F0a2lucw==?=" <srw@sladewatkins.net>, "=?utf-8?B?R3JlZyBLSA==?=" <gregkh@linuxfoundation.org>
Cc: "=?utf-8?B?Sm9obiBLZWVwaW5n?=" <jkeeping@inmusicbrands.com>, "=?utf-8?B?SmlyaSBTbGFieQ==?=" <jirislaby@kernel.org>, "=?utf-8?B?RmVycnkgVG90aA==?=" <ftoth@exalondelft.nl>, "=?utf-8?B?SWxwbyBKw6RydmluZW4=?=" <ilpo.jarvinen@linux.intel.com>, "=?utf-8?B?bGludXgta2VybmVs?=" <linux-kernel@vger.kernel.org>, "=?utf-8?B?bGludXgtc2VyaWFs?=" <linux-serial@vger.kernel.org>, "=?utf-8?B?c3RhYmxl?=" <stable@vger.kernel.org>
Subject: Re: [PATCH] serial: 8250_dma: terminate correct DMA in tx_dma_flush()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Date: Tue, 25 Feb 2025 19:37:38 +0800
X-Priority: 3
Message-ID: <tencent_729B631A3339DFCB4BFA873E@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
References: <20250224121831.1429323-1-jkeeping@inmusicbrands.com>
	<tencent_09E5A20410369ED253A21788@qq.com>
	<2025022434-subsiding-esquire-1de2@gregkh>
	<tencent_013690E01596D03C0362D092@qq.com>
	<2faa8912-a699-47d9-b9d6-dc2fb22fe7c8@sladewatkins.net>
In-Reply-To: <2faa8912-a699-47d9-b9d6-dc2fb22fe7c8@sladewatkins.net>
X-QQ-ReplyHash: 829435416
X-BIZMAIL-ID: 9039354056843283055
X-QQ-SENDSIZE: 520
Received: from qq.com (unknown [127.0.0.1])
	by smtp.qq.com (ESMTP) with SMTP
	id ; Tue, 25 Feb 2025 19:37:40 +0800 (CST)
Feedback-ID: v:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: MgQY1K25Ph0m1naNLl6PTlAFYKFI+WJ3bVu4EThSbzozVxcMfEWbbzRW
	4N7uMs+393LogP+FLkIofNR0nsWjS2BN6UF1YAIr/gACxhPL2xyPJ9lf5T0R+mh5kPbkdgc
	NaE7RdGocNgBAOkmmuN+6ecjMuw7H4StlEk/OS8pEB+xyCdV3MWoQeb3p/nQye6ICleV7sn
	uGtDZneJklQ/Jn//jJ1C7KgTx5jr8SzbnL4NeBkETJvf2OH5AFmCRDq49FP90vWZXLM4qF2
	oFyzo2eJ2sCi+PlvNTPB/EpCubrqGfYnrPgT0d54yVbcToQHM92t2UR35bazj2KJ4vugHB+
	MlmmaHQYldK5smP0g+w6C8X40XwldoB5c8ReLbb0e0s3R0ifUDonYzdrdW3i6EpjpvelwzQ
	U6tikRNjBAkrPLGsIUPVYAVCwzqRMpHfWAcpBHUzsfRz8ZSf7K8dFAo8bsgqIR5EBZuH5nM
	XdpWFvBfoiw35y4TI4da/ZDShTOagmckk7mEKgPV194vLHjy5zkJGKY66o3weON0iRmEvkF
	15g5/WgprvwVRKZfbN8N/wtjINikYh3QvnTUcAlxPe4vpYdrbGuxNWYv4I2X75QvSqY/8sQ
	1NVOL8ZTWNSrnVd3QjXAylK6tCb5kGE9/UQqKzqfwyGCPCFpaDJiC9ahGjw7hzXOtz+7lmk
	7MB3zOIDDpd74SkE1un7X141YvA+2lWmjtsokUt+Q0/oPypW3yUBYCOc358Ys04b0rR2VTR
	viJypw/uawzgxsA0/PsTL6Lzwhm/Wox883so+s0o49/m25FGeG1xy4TDiFg88DjDa/sJBrV
	ev/O8HnxoyJZ4CpoqfkiCJVJ4TQPU2Y4274+n75Y6wkgSb6cYN7gt9b6SVWTAqrW8PTOeAl
	jg5i3xpDasIAKUKtBjIlwT/iv7RcX6fe6aIb9kC9/n5vjvYUCH7m83QvQADt9xxAuwWLvkw
	0xJ7ErqmVSdDY309erRfxQ6MLgLkRTPl2eDDdzLwpB6uivlLK8/hZ0PmrMvRV2CCAJMZEF/
	GrZOZAQA==
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
X-QQ-RECHKSPAM: 0

SGVsbG8gU2xhZGUsDQoNClRoYW5rcyBmb3IgcmVwbHkgbXkgcXVlc3Rpb24uDQoNCkJScw0K
V2VudGFvIEd1YW4=


