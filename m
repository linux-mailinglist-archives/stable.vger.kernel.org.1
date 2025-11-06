Return-Path: <stable+bounces-192565-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B059C38CA4
	for <lists+stable@lfdr.de>; Thu, 06 Nov 2025 03:06:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 18A894F09BE
	for <lists+stable@lfdr.de>; Thu,  6 Nov 2025 02:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A9C221C9FD;
	Thu,  6 Nov 2025 02:05:44 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACDDE42AB7
	for <stable@vger.kernel.org>; Thu,  6 Nov 2025 02:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762394743; cv=none; b=E1qhxXIv6JMQpgm8jqFKDgM16lQGb+jK05Bc2rhFEvznGsqh4gFJO1xu7hFDHiwKEiPphbpsIA6g/RV07a3QIwtbtn8m8B1mNTvjxaON3KvTI3/HaEDEEBhGbJSTnlXyjKLpBT9sjYVVV3wYkF1BIbBshG/mXV74v+6B1t/+skA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762394743; c=relaxed/simple;
	bh=EJN8BYKOS2MGnzXt0xqWICyUTtWv7RNKzKBIB3bLhZ4=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=LYyDejmCaw5uS/YDq4ZpIxL/bOg2qhTBvsnXZzk6Hb8tk4kVXgwkDjddEcEQ7ynscvZgeJbePRtwozdpcpqmCxYiXDRcZpK8/7xlXwOosjwM7sO5oPhQlwzGnsKTMLjbTw/CjXmYjTCCbwWyG5yHa5Oc8NZOBks0KsbczTRcZxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.204.34.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid:Yeas5t1762394725t979t24403
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com [125.120.71.67])
X-QQ-SSF:0000000000000000000000000000000
From: =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 13201316561911771087
To: "'Vadim Fedorenko'" <vadim.fedorenko@linux.dev>,
	<netdev@vger.kernel.org>,
	"'Andrew Lunn'" <andrew+netdev@lunn.ch>,
	"'David S. Miller'" <davem@davemloft.net>,
	"'Eric Dumazet'" <edumazet@google.com>,
	"'Jakub Kicinski'" <kuba@kernel.org>,
	"'Paolo Abeni'" <pabeni@redhat.com>,
	"'Richard Cochran'" <richardcochran@gmail.com>,
	"'Simon Horman'" <horms@kernel.org>,
	"'Jacob Keller'" <jacob.e.keller@intel.com>
Cc: "'Mengyuan Lou'" <mengyuanlou@net-swift.com>,
	<stable@vger.kernel.org>
References: <17A4943B0AAA971B+20251105020752.57931-1-jiawenwu@trustnetic.com> <de2f5da5-05db-4bd7-90c3-c51558e50545@linux.dev>
In-Reply-To: <de2f5da5-05db-4bd7-90c3-c51558e50545@linux.dev>
Subject: RE: [PATCH net] net: txgbe: remove wx_ptp_init() in device reset flow
Date: Thu, 6 Nov 2025 10:05:25 +0800
Message-ID: <09a701dc4ec1$d0cc3210$72649630$@trustnetic.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQExXBZeSPIacREnfT1C8jsshPjwPgIYC4qltioGyIA=
Content-Language: zh-cn
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: ORCyg9Q6uqViggrym+tLMLGzjtD5NS5+VwE4of+1SoyjX6QAlln9+7B/
	tAnW/frRMTpOZ4Vz+EHeRqhhcUh3oBXAtd7S0Lk5C5OV8ykJIBI6Mmm5dfjGaKhdw7bUXlS
	pvN3C/DvoPwjImxXEOrd+MY2QNVbRo7FN84vj1dkaTiH6LOgVxe1d/Jz1fhFSSL/eZv/g+N
	Y0MNdVdWcDslaehXO4Z7AX/bk8U0P/Kfdu0m8VuJmuVvVQiuLKwQ21XTbtXiF4rz0TARvRy
	IstWzgEqpE/8Lvn01nHR2XF5lL4ZzAb44+UaA4kiimPIHJXC6Eec17OyfaTA7SDYw91UMHp
	11PK+2DsRFscT35xDnanxcQvVjRShp5jHR5b77Gygw8xpNgCi8GJhdRFulSltlNU0OLSNjX
	LwyoaBBgq0q5ddvmZtVbFFdrsOSE5yG9kG1srl55CgeEU3Li4NqgbLw0gTz0WDaV58yJ1z0
	5hmQNnrnBqstjccf4svtYlJCQklGQ7OEc0HYpepybxSbgs4sly1tlu0zHMXpke0ucsvQTTf
	HGXPJOWwZSFF0KAGevJ+3tgnJDw2394hsiH/pkT4Z4++r89WXEN2iYYw0Pn/QwJmyo8tE+g
	WZghWslMN6k3KX3O6O1ET6emxFMTEt1yyUhNnzWREsoQ+pcM0Ne3i+i6rNkoSnrLOofzZAk
	hor3FbelzJymIcpUjp8DTWLqwdQZ6FRO9Lwp1T/c1wsOOaqFPx6b6+7QlJniMNbViSYdG7C
	daucCmW5JZ7/yqXGhpDXnQy7uJ53Rbhec6ZeGQHHlfrLoL0bic8juXcbTgqNKWo7rZUW/l6
	kYQRgsi1SWfwl4GxqRMnbuq+4RNhm+VJKSLFwjMDI4TvkpR2heyg/NQVzZTZsjhlUgTBUzm
	hnNc7+TChKFDJMLqE9VY5e9P+uDG+RfX4C+olXMNcV0r3s64Ushwbo+7hcSoJuoSPSRPL9G
	f5hdwGuUQgtuA0uzdnbYyu694VwKQrO5Dmg6U4L11okWn3B6Lg/Z1WDaxgruryJtl82vF5A
	fkPQuGKw==
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
X-QQ-RECHKSPAM: 0

On Thu, Nov 6, 2025 4:03 AM, Vadim Fedorenko wrote:
> On 05/11/2025 02:07, Jiawen Wu wrote:
> > The functions txgbe_up() and txgbe_down() are called in pairs to reset
> > hardware configurations. PTP stop function is not called in
> > txgbe_down(), so there is no need to call PTP init function in
> > txgbe_up().
> >
> 
> txgbe_reset() is called during txgbe_down(), and it calls
> wx_ptp_reset(), which I believe is the reason for wx_ptp_init() call

wx_ptp_reset() just reset the hardware bits, but does not destroy the PTP clock.
wx_ptp_init() should be called after wx_ptp_stop() has been called.

> 
> > Fixes: 06e75161b9d4 ("net: wangxun: Add support for PTP clock")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
> > ---
> >   drivers/net/ethernet/wangxun/txgbe/txgbe_main.c | 1 -
> >   1 file changed, 1 deletion(-)
> >
> > diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
> > index daa761e48f9d..114d6f46139b 100644
> > --- a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
> > +++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
> > @@ -297,7 +297,6 @@ void txgbe_down(struct wx *wx)
> >   void txgbe_up(struct wx *wx)
> >   {
> >   	wx_configure(wx);
> > -	wx_ptp_init(wx);
> >   	txgbe_up_complete(wx);
> >   }
> >
 


