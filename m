Return-Path: <stable+bounces-192669-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 01794C3E3C1
	for <lists+stable@lfdr.de>; Fri, 07 Nov 2025 03:22:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91F241889412
	for <lists+stable@lfdr.de>; Fri,  7 Nov 2025 02:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7CCE2BD035;
	Fri,  7 Nov 2025 02:21:58 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CFE928D8F4
	for <stable@vger.kernel.org>; Fri,  7 Nov 2025 02:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.169.211.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762482118; cv=none; b=jY4cNR3Ts+ZHrWeHcqQqpP2ky6wTaBbifDlMKFyiXLAVgh9tW6Re3WEUiQ+rbCkNllxtyL7jVbZ+2bM1Qg9luYJpyZEvuZg5Tb5f5CRj38EWOmxVZgh/6Oa1dFMLBGIkquLkl2lymB/sx8L4BkdVz3ygVHkpLbVvOWl9WFjx8xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762482118; c=relaxed/simple;
	bh=v2YWqnCq3BoAzNq27ROrOCMT/qzVUerObh5rQwSo16I=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=FoKkTs33i+mr3Ba5rgle6bl0t4Zp3YGsxua8waNUcGxgGfmk5WNsZwb3w46fiUWkOnfDWr/fSUy5YjG4E8S7LTa1gp2+Cht6flXYSDnM3jWZo1f8+NRUk83oG5aI/EDFpcFL/OLQNDTkRg+5D9cgk9mldE30amBoaR9q0CdP66M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=18.169.211.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid:Yeas1t1762482107t440t63233
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com [125.120.71.67])
X-QQ-SSF:0000000000000000000000000000000
From: =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 3816815724803750602
To: "'Vadim Fedorenko'" <vadim.fedorenko@linux.dev>,
	<netdev@vger.kernel.org>,
	"'Andrew Lunn'" <andrew+netdev@lunn.ch>,
	"'David S. Miller'" <davem@davemloft.net>,
	"'Eric Dumazet'" <edumazet@google.com>,
	"'Jakub Kicinski'" <kuba@kernel.org>,
	"'Paolo Abeni'" <pabeni@redhat.com>,
	"'Richard Cochran'" <richardcochran@gmail.com>,
	"'Simon Horman'" <horms@kernel.org>,
	"'Jacob Keller'" <jacob.e.keller@intel.com>,
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
	<stable@vger.kernel.org>,
	"'Mengyuan Lou'" <mengyuanlou@net-swift.com>,
	<stable@vger.kernel.org>
References: <17A4943B0AAA971B+20251105020752.57931-1-jiawenwu@trustnetic.com> <de2f5da5-05db-4bd7-90c3-c51558e50545@linux.dev> <09a701dc4ec1$d0cc3210$72649630$@trustnetic.com> <04492fd4-4808-421a-b082-a05503b1d714@linux.dev>
In-Reply-To: <04492fd4-4808-421a-b082-a05503b1d714@linux.dev>
Subject: RE: [PATCH net] net: txgbe: remove wx_ptp_init() in device reset flow
Date: Fri, 7 Nov 2025 10:21:46 +0800
Message-ID: <0a7601dc4f8d$44034400$cc09cc00$@trustnetic.com>
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
Thread-Index: AQExXBZeSPIacREnfT1C8jsshPjwPgIYC4qlAnOcZc8CJ2bJhbYGxueA
Content-Language: zh-cn
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: OatzRg8pHEjpzGxovdm05ab1gFKuXFKw0CZWGrRucYBHCH51/5LoJyge
	jQ1Q1qLH7/3jzKdDQJuHWqpS2HtxiaK1I7Lvgmcj0WE0goYz3g0EYIHfGcQXKv4aYkAuGJ8
	HZKJsiJJtwH7J9JWZjp/cI8BBrx1n+v9rKCvDbsYIZpt2YmTzAR5q/AabZjgNyUiijOMh1o
	jTUXQs7Wr9fJPeYRDjUZ3b3dWBPIneLyGgtb2ntmKmDH1u3QsDaGJ8PNMo9a6iY/J2e4Q0+
	xI+dYmjrT3ZOJyPtm35IZSRv1RhlM7sTyYikvv6Qyzs5x4aRTz2kWDwE3V8xI3JEy6bHWLN
	6PtuahBImoLDGCtaByMNacNqTSvCs9GZ/H19jJeISt74H0tRPQlQH6vAhxwIWcePgMK4WD9
	es2gZxZKCarEtyuTw5bx3ysyC0iUUes/Vjr+hICc8ZBp6Q391yqVH5gVWgQmA143L4T3kaX
	+5MPey/lnernpGQnx6Xcp5SjPso2QPJ956HLOPsfk7AWpia/MmA2vk3rWAFX6PFz6gBshzr
	XSkHBaBE27/mK03P+fnYyhmucvL55U/U1gWzyjNls8Qr0Qm2IHefzM74zSdtKnHrsWK6XtC
	3RQdkXjMemW1nUppUzjG98tAVITr45UBV+NxP2hXetmQWGsVdaOC1ZzDK2999ItbSkVZI6m
	y9Um1COyOij52BA3jBulI0OOLaNUHDKF5/lnzVya+c6TXCUZ3PRsMOOikl0FGKzDjRqnlvN
	HRaAh1VJaSpaYGYTe5bfOZpZ4H5uZqSlbEn5iyuc+WC9WhB637RZLugptY5EkxJu2Q2PUdW
	QBiB3YhroVgM3GLqUL59ehHAHC4Gva2xPYZkgpjXjjWXrHO3Acv6Ur1GvgnEnBCnmTEfsSW
	3Xx2hHMWSoznVKSX6nfNVhnBv6C60dE5Dqtrf9TbirDHKaNt5zevkEYbDJeRv73NaOERvo2
	NHJghvay7Iz+ALKpPzMrnG1r5jjJxlycvFxrMo4+x70Z0ray63YDevU+pTjN6QvfWYzXEXX
	eI5PmAPNr1/HcNK5qfRnIqgB5mEIVA6ettctn40A==
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
X-QQ-RECHKSPAM: 0

On Thu, Nov 6, 2025 7:27 PM, Vadim Fedorenko wrote:
> On 06/11/2025 02:05, Jiawen Wu wrote:
> > On Thu, Nov 6, 2025 4:03 AM, Vadim Fedorenko wrote:
> >> On 05/11/2025 02:07, Jiawen Wu wrote:
> >>> The functions txgbe_up() and txgbe_down() are called in pairs to reset
> >>> hardware configurations. PTP stop function is not called in
> >>> txgbe_down(), so there is no need to call PTP init function in
> >>> txgbe_up().
> >>>
> >>
> >> txgbe_reset() is called during txgbe_down(), and it calls
> >> wx_ptp_reset(), which I believe is the reason for wx_ptp_init() call
> >
> > wx_ptp_reset() just reset the hardware bits, but does not destroy the PTP clock.
> > wx_ptp_init() should be called after wx_ptp_stop() has been called.
> 
> wx_ptp_init()/wx_ptp_reset() recalculate shift/mul configuration based
> on link speed. link down/link up sequence may bring new link speed,
> where these values have to reconfigured, right? I kinda agree
> that full procedure of wx_ptp_init() might not be needed, but we have to
> be sure not to reuse old ptp configuration.

This indicates that the original approach was also wrong. wx_ptp_init() would
return here: if (wx_ptp_create_clock(wx)).

But for the changing of link speed, wx_ptp_reset_cyclecounter() is called in
.mac_link_up() and .mac_link_down().



