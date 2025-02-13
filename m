Return-Path: <stable+bounces-116314-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B098A34B65
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 18:12:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CDAB16B32A
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 17:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B3AA1FFC41;
	Thu, 13 Feb 2025 17:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=rwarsow@gmx.de header.b="C4UFB8Uz"
X-Original-To: stable@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9D628A2A5;
	Thu, 13 Feb 2025 17:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739466421; cv=none; b=WvHPuWusyLphkiJ3aog7yV8W7MqNMDg7MWFAEBH4i/FrIQ0WENYVXtNKNRhvSD2twPoXvpods54sOcOu4YWa0Wi0CL3CLWPPG7+7E8Cw2Jp7lm08TUuVFu2eKtFBDOhZ41GvBlFCpPmPz1YMbfxJMldJsdymTOIpoqe71JFQqeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739466421; c=relaxed/simple;
	bh=HtuFhXI63urBA3dRKYyXQ6GHreCYVeNttV6YM+zDLlM=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=kbAtqNhHyPubB9l3TL81Vx4OyRE3PG43u8kaU2i+h8kizzNIh0TUsnL8WV5n4sSH6ORh9Y3wLOywuZAKXXbkxqiOtyWxhbQmsmEh6fU3w5sBP1P3gmU2cZpu4JRzDx5TcCU3dNtiqcd3n8fuf5BUxUWnYbwhcVwO5wm2s2jRYNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=rwarsow@gmx.de header.b=C4UFB8Uz; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1739466417; x=1740071217; i=rwarsow@gmx.de;
	bh=HtuFhXI63urBA3dRKYyXQ6GHreCYVeNttV6YM+zDLlM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:From:To:Cc:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=C4UFB8UzCbC4hLijV/bYhB/+IhC6vvXoWIsSMMEDor238/+OBN8IwAAv4xsWnAu0
	 QP+rW8MbRS4Hoa6dL5sCy9Lbb6EYAXvhLKLdU/Q2KnhjC/REQ6CDltLzoHZtCZphM
	 MK84+AiR1OW6j9UfrRfaNLRXuqcHZcXmrosVq+RFd5wDAjzh4ZBt2vbLLmomnJeFt
	 zniBJ9LjQRZyHbggBL6H4QWq37kXJy+55QpOHTykf7eLXAcVXK5dBRwlC4BNuMmcl
	 16SgYN2GMn+xAYg9TXWSIp2TOOvIZBDrjEIeAsF+uBCiaejrv9UQS1f2xbLZ/KgXA
	 V1UwPzadprVnaaY2vg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.200.20] ([46.142.33.122]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N8ob6-1tL9lP0Buw-010agZ; Thu, 13
 Feb 2025 18:06:57 +0100
Message-ID: <e25ab657-354d-4ab9-aa85-c970629f7cd3@gmx.de>
Date: Thu, 13 Feb 2025 18:06:56 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Ronald Warsow <rwarsow@gmx.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Content-Language: de-DE, en-US
Subject: Re: [PATCH 6.13 000/443] 6.13.3-rc1 review
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:bfj5pM8DZ2LweJHpc26W0gBQNNi70NUk7ygI5eaUvqMM4dv8f7C
 FWjXLwjFPJO1PuKC4Q9YypWfJ+2rAr9fAGb0rwRyGS+Yrqo7At7QdpnnrMboX83us5sLWXl
 Tj3rEgm61YL5s8qFFnxRQtUL9OgS7QAlRcPOARJM1JdmqO0d4Tbz871SayQGrG8dRC/Zmtk
 yQMs1c8yLxA/eLQi2uCDw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:qNMwFtcrgQo=;LufSXFZyqaMId8EKBea60FPUIUG
 +Uj2K35gE8dUzuiVPxxDd/kjuzZJREXJM8jnnR9qlSBonpXTSSzkaaZNu814+C24MjlpCMSGk
 9R2zNnvkwXKyE+BA1jvbjNIJvoiw+ryGsc4Qfljk+Y/1K43ugmYbMRMMxQot1VJMx3hXDpuvW
 IJvQpdE367lpZ7+eXrDIcAsXun8FknCsvRnTNELtmml6Gs4efXyer65JzejBksAXSpcRLSyLo
 6EfcU5QP8aju1V1zBNkIKrqVS3lrX+papDAcxbhjh+NTApdyKZOJ8b/YVDI/V2rgA1IOe/mu4
 RLP+gS9IZ0x2Xlhp1jOyaJLfI+i++5a+Nlma9CjUvCkqvnUvXERPg0aZT43GcRYRGnc29O9B1
 SMwtbxJ8Xh5ytyoVINLwjnvJYIHIpF9R87b+YfaL/UV0jr1d2sL54QTHYMVyIbkuvd0erICCG
 O4Gu33jQR4wqKQIrJ1/WR0MnawmT1zzGPcbpFkK2N8PsvOiaqBhcVUEMWR44yObpFSO9iq+o1
 x5jSkQtEqKtlSw/cbMUGkTDdZOC1YGHqMYH0ukDyoP7H9FG0bmIqfjQ6ABslPsTgTPRUv631O
 uNDwDQxpmLRdkneVS3anb4L/xkLVwSHIeG8Go0qPcYN2VUx2LfrMgRFmRudGKw3jrlKxdiEL2
 EINjiK5kIBgccE6l1XkCCGnPDczGjDKyql3XqSYCOTcdWAfeXJoQjaHV4u4nYtAC6qALbSbYR
 yvxv0sPsrYz1KVAh91G3eRInN0i9rWKABC1blupNZ/wnQlItEEhUKcsvYivP/AyI/gfj9ORUE
 w9e/rFRCRSjlgTke2hJjEMy8FxQbzDnLKYI1YwI0sHQYZAbkNv/GxGAE9i6xVONPeGblA8p1g
 TiditWgII7J306YwyK40FFb08KlmTx0hl6tOB+tNazmY8XkD5yWeiJ/8R7EG6fGP/iC/cswTJ
 /GXimZgFmiOiUIBr/zRoPrw/Fflr46JUFBwjrb0jClptO/Wt9CNpUJoYnpEt9dGtf28sL6nIS
 /3j3TenP/SQK7ukQz3s/dlHsgyp28F5wn48Hd1rAbA2DhAMcBGO1zwKHNZD3QPYlyYHdgZohu
 5rQWEgLaYIN/lsa1w0fkHYnY8sG6oaBypuScZi5SynohblYLhdMQmLl/Cq+ov6EN8BVPLVO2M
 n9WYt4LYvKLhk4JrM58f+22ahT89hVPxj5h3YsnHc3a8A5ZIPqifAXC3kbyFMYWS0RBnQe4Qv
 XYM+Ofmi46e8rMH/LvfqIC3fTR7b9fai23Ij4RKEvq2pgOAT0gpeW7zi1X38tu6gmFOBLPNnV
 Of7v+wjPPTrsEavSf/OB0zi7XZLRLvuckP4OVZ9JVQ3RG+I1JPBSvoN2oFiJv+FtRBGXZXh01
 Eoq3mkZePijntL3G1aTRHRPrO3GgPFgzEtbdToHcYdRWyvQwgnbuNG0BsKyo+DLIX9vG0L6y5
 UHXslYA==

Hi Greg

no regressions here on x86_64 (RKL, Intel 11th Gen. CPU)

Thanks

Tested-by: Ronald Warsow <rwarsow@gmx.de>

