Return-Path: <stable+bounces-192489-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DA30C350A2
	for <lists+stable@lfdr.de>; Wed, 05 Nov 2025 11:10:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D71C03A1D62
	for <lists+stable@lfdr.de>; Wed,  5 Nov 2025 10:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC6F02C17B3;
	Wed,  5 Nov 2025 10:07:14 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA81A2DAFBB;
	Wed,  5 Nov 2025 10:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.132.163.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762337234; cv=none; b=r1M7zkrCh2AaWnyPiUER9r0P579BcVFjmVpvGSpTJH4SaXwIljrIkE+ym33NkNTofBqkNGvodSSoXrmd2yP299syjoeWI9lFj+fPuHwzxukakE+sYt9gYPPcBxJ9FIrjprs75N4A+hI1sXg6/pC4kA4/hyOUGHnv4M2Sz/H/lTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762337234; c=relaxed/simple;
	bh=uCTGPZrf+nEi4gj5GPFN0YN0GHlDRKEdv9HP5ZZLBtQ=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=o6wphyVfUvzz9zafMe7BHeRmLQmXgsSY4X+VI0Rqj5+yEXgodf+6yejYhuqQlzO4CCa3JYgCkBWFHhlQ2UKldSCSCyUmqWsuSMI88eF4ZT4G8eWNgXczRpciLJvJEr/6Nw1UgXxM0nZiT4UzMDccqCtNrUh3XO8IRQ6QuL9GBIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=18.132.163.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid:Yeas4t1762337130t767t10097
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com [125.120.71.67])
X-QQ-SSF:0000000000000000000000000000000
From: =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 4853440442999993292
To: "'Simon Horman'" <horms@kernel.org>
Cc: <netdev@vger.kernel.org>,
	"'Andrew Lunn'" <andrew+netdev@lunn.ch>,
	"'David S. Miller'" <davem@davemloft.net>,
	"'Eric Dumazet'" <edumazet@google.com>,
	"'Jakub Kicinski'" <kuba@kernel.org>,
	"'Paolo Abeni'" <pabeni@redhat.com>,
	"'Mengyuan Lou'" <mengyuanlou@net-swift.com>,
	<stable@vger.kernel.org>
References: <B60A670C1F52CB8E+20251104062321.40059-1-jiawenwu@trustnetic.com> <aQsf2tTu3_FAeRic@horms.kernel.org>
In-Reply-To: <aQsf2tTu3_FAeRic@horms.kernel.org>
Subject: RE: [PATCH net] net: libwx: fix device bus LAN ID
Date: Wed, 5 Nov 2025 18:05:29 +0800
Message-ID: <093901dc4e3b$b753c630$25fb5290$@trustnetic.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJxNjcH0uQA1KRbS7ZenkO9evNXlQJvG/UCs6aRCIA=
Content-Language: zh-cn
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: NHGFjaVOIMm21TWmf7RX+X7PQDFF0YdBb04ZIKdtE/zHyJMm3zdSJfeC
	Mj4stF9t3SkrXijUrU4nOvpoGjbpSS7nhLAYBtUNpOg59TSFmLFOlZyqV7v8gxTi5nzUuQp
	AXszlxeIcrRiwO53uxs4xdf1Z8eWVfuuzBHImM2fsTwdbEx+mhw7HC8xpxnpOgvIVTX6V2f
	feAGmjcWp5iT3l1kJsebk/e9My/hT3EatDIUOUEVJfSubMZnuMbgCMdf6IMsIkSLsmEqFnl
	5zG12hmiOvvnZ+d9aI8kv5ozVSACM5G3NDjbYB22HoOqyTDQDntPuj9m0sgTuN+5OHUwIxe
	I+g+XNXxqiUlo+7+WK2VfWrin0pwHkNLKj0Fp5DR3P68cRIF+kIpR5VJlgXNM373B+7vHLo
	POBH0IiWNkP86GyHla8ymW/GPURtvjjZ4NTSSyJ0qlXs8Zs7y0+6zuMxZVvu1+UD0VhGcSa
	shckXR5Ktz4tpl97CakEwE/LdPS9RXyPMSo4D9T6t1W6w8QicdJt0FeRJmZAERUySBTAbJ1
	kuhB6HveHARGmduNx7ihiPT7xN/5/5bngwEaMFMVzibbh8OcFsgD/9g8/DoAyD8s/z2LOkX
	ezZt2+YH03yqdT9W1Y3mnc9gllvyWKDdlhS43iRQArrz1KruxRbjtkP+ag6KXeFEpe+xg8M
	EYEZDCSl6+yScDZhC10eNa6kdTJIMp+ddqcX+67x+YAitPw+razvSGmfjkOIIb9Z7L9lXZV
	d3rwO5GN9ZXHS/b9KVsSuFoxAcMrz5qn592CWRfqZ+ab3SMu5guKozMsEuimZxoq+pjaiRY
	atb2VwBFVKDIH/5Y6IxZZL8m87Mz/ajc3kn/MYlJtz5833Do/+JrOM7m+x03vR75tC5k5gP
	/2RtSaqyiUHCXS/ktEa8V+OjEYx102veR5cbjgpTdTZhvANwJjCTwZlg2pP/GLYXuUCwSpZ
	aOUstQp2wg36KufYCCMHQ2THkyyV6j2U/SBa0NDAYg950uQDazPSMfHSajJK+kItqK8Biqj
	CE87WaVlMXHX2n5uRMc5hYKGJkppbUodSZaQVu4v6mQP0JgchN
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
X-QQ-RECHKSPAM: 0

On Wed, Nov 5, 2025 5:59 PM, Simon Horman wrote:
> On Tue, Nov 04, 2025 at 02:23:21PM +0800, Jiawen Wu wrote:
> > The device bus LAN ID was obtained from PCI_FUNC(), but when a PF
> > port is passthrough to a virtual machine, the function number may not
> > match the actual port index on the device. This could cause the driver
> > to perform operations such as LAN reset on the wrong port.
> >
> > Fix this by reading the LAN ID from port status register.
> >
> > Fixes: a34b3e6ed8fb ("net: txgbe: Store PCI info")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
> 
> Hi Jiawen Wu,
> 
> I am wondering if these devises also support port swapping (maybe LAN
> Function Select bit of FACTPS). And if so, does it need to be taken into
> account here?

Does not support yet, thanks. :)



