Return-Path: <stable+bounces-121117-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 016F8A50E8B
	for <lists+stable@lfdr.de>; Wed,  5 Mar 2025 23:25:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 495151889E87
	for <lists+stable@lfdr.de>; Wed,  5 Mar 2025 22:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 560AC265627;
	Wed,  5 Mar 2025 22:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="XiI8DT4O"
X-Original-To: stable@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DED725A338
	for <stable@vger.kernel.org>; Wed,  5 Mar 2025 22:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741213514; cv=none; b=eBfAgKATKVcJn7uJLJSJkl/b7uU3+M/JmZpIvbLN8L9yN/uFzVj3WxiIkosdUVogEUSajTMJy0G4cKczNsxSfC5sgwmB7cuTVEOBnS4BTYUVPZI1nb0qoPN20kcSG1BIhzmxNRyewHot/4yV6SFDokametB7XQLcqLt+j7RFkxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741213514; c=relaxed/simple;
	bh=KbJJW8jX/AgxaouI12LICpD6H4Cet84SJOA2Irz+ED0=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=p4j+XtqxjW0tZXD/hXb//K9OwmmtGceDWiwSV2/H3g1/aqlMVS+82pJ5B+HjRfV7xnAuodsECi772xwT6LhckYVsrGEv+TBCooFKroBbQWGMKSbt4r8bwpRHvqZwiMlUHf9ZXa1lS9IhjEl13hPTb/4QSJI5xHON2Yu+YcMBo3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=XiI8DT4O; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1741213502; x=1741818302; i=wahrenst@gmx.net;
	bh=KbJJW8jX/AgxaouI12LICpD6H4Cet84SJOA2Irz+ED0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=XiI8DT4OH8YpIGdxXJOsPa1Qhx2TrHGqqTq/RAsGyeLZ7zsma3T0GDqEO9ZrTAeK
	 yuGGN2rqHs0ojcLeeu4gN+jAQkuNIRRsiLGU6tm5LxcueuHWnNHOtiK+Zwms6diuU
	 jcBl7ERvLuvY7rFkbTTgD9hsg3bSTtCEbMbSFVqByy++ke6ZyaiO+d9qzEETH450P
	 Pi5fKnAHRBWPy0sV5s124hJVsF/6DmblZaybODK4yxJZ2dJWnmlS/CB0UYJtmZU5+
	 B/Z98C7jIMDNlmSlitNsfIxDOuLhwoYd8F2LU18NnBcrgp69DBMP4NCDGXIj/9h/Y
	 duXY/THQEJ6/Ksjs8g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.107] ([37.4.251.153]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MCbIx-1tzbo51nxT-00BKjq; Wed, 05
 Mar 2025 23:25:02 +0100
Message-ID: <a83d17ac-1d17-4859-b567-fe2abc8638ab@gmx.net>
Date: Wed, 5 Mar 2025 23:25:01 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sasha Levin <sashal@kernel.org>
Cc: Ralf Schlatterbeck <rsc@runtux.com>, stable@vger.kernel.org,
 Mark Brown <broonie@kernel.org>
From: Stefan Wahren <wahrenst@gmx.net>
Subject: [5.4/5.10/5.15/6.1/6.6] spi-mxs: Fix chipselect glitch
Autocrypt: addr=wahrenst@gmx.net; keydata=
 xjMEZ1dOJBYJKwYBBAHaRw8BAQdA7H2MMG3q8FV7kAPko5vOAeaa4UA1I0hMgga1j5iYTTvN
 IFN0ZWZhbiBXYWhyZW4gPHdhaHJlbnN0QGdteC5uZXQ+wo8EExYIADcWIQT3FXg+ApsOhPDN
 NNFuwvLLwiAwigUCZ1dOJAUJB4TOAAIbAwQLCQgHBRUICQoLBRYCAwEAAAoJEG7C8svCIDCK
 JQ4BAP4Y9uuHAxbAhHSQf6UZ+hl5BDznsZVBJvH8cZe2dSZ6AQCNgoc1Lxw1tvPscuC1Jd1C
 TZomrGfQI47OiiJ3vGktBc44BGdXTiQSCisGAQQBl1UBBQEBB0B5M0B2E2XxySUQhU6emMYx
 f5QR/BrEK0hs3bLT6Hb9WgMBCAfCfgQYFggAJhYhBPcVeD4Cmw6E8M000W7C8svCIDCKBQJn
 V04kBQkHhM4AAhsMAAoJEG7C8svCIDCKJxoA/i+kqD5bphZEucrJHw77ujnOQbiKY2rLb0pE
 aHMQoiECAQDVbj827W1Yai/0XEABIr8Ci6a+/qZ8Vz6MZzL5GJosAA==
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:iFJ2TUxYenI9hBt4TIoEDRWOZV4qwUtf3wV5EOlpN1G9Nuoy7iv
 va6DAeMaZBLhz+SlWWmijA8FDMzW33JTyB32pOXKr86cIqHseFah5nJioYkZhLVSRWU3NrL
 ZKxWkMPJe5LIUSqqkrKvHHxegz/IKVrEmTUqXzX0y5ctD9KBNu/yfC3MJAwNkmFsoArNJii
 N0tbpBIMrB7Sli/iCAUvQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:AEe8P3me12U=;j+PfwHq6Pw7/vmdm4LneYf7f+pU
 f5p9+pknEQpdCwIiGIo+ochAhpBVmMeUGFTrBgH4vgOXvWqkNfkA4fecS/oWuzyPgWDIo7UpV
 Sg8nqxMH92D6EC5rmXXrvPgV08zyHUsCZNFT1ZYkQPmdj5DXA0P7C4NKIkmVL8nP+1DY6hZgo
 x/82QJqckCNB1jJIholhX4g0IEbQrEIr/W10B+GTnnw15xXrjrE0pT9H4Vu4BGtEE0KLgcGtN
 sVb4QMJ5ILFsuG991Fq9aRs17Yrj9G6odCbylagIisChhGiyBckTxoFXJ0IWr3P6UI5AnEXoi
 THxzqjip3KoCDJhGVpJ6iTiRu8jP/e7tGpd8eLMbyVtGk0hmidCB9QLaGmV5kEEeSmAIOryH5
 z5KovinmsWfPiCbxSnj0ry47Upsvp7gRSiBoETp6rOMTqjEzxydwepJctPo7IcT/JTO5xzJj3
 jKv8J8Hu5eqr1qxlB/F1VhPYweVlafPAPV4gxVuNnZCIPHf+h6E3pqMaRiTtYdh10MwoE2/KP
 gLMX7FGZlicD3A4T78N+VcrTN2AdYS9a6jg6QRlL/QJxf8AoV7VbKgRodxSdh1JjpflZ4P+8f
 UE9FcME8VxGyQdFjyhib8u7tP6gnYXsUgnzE5qI7v1QNcx89d+X4MsJ61ihY3rFGdGMo8z7gc
 CW1lFGvzXdGEd+DKzqUWZXNDV8KHNxC1DZ3uV4NvC9RfufQ/f9EYXjHDMHnGBeaVWjQTUxh2C
 //08C1TGJkKQAIsZvSKBsnvQ4SLsDGqpMPegwH1Hl99y2tUwOfnH1kmLdk7rHZJm20oSnWjnt
 Yj0SCUHPHA9Sefy1C7UNtP4b5XQMkvUD5Yj8HYmMs06US1HdHIcIdwU9WYsLvfmMLOEHkdGlO
 wuub2QvVopYhZvKLzpnl7G2xAbk/Z5Nj7pEMIjAB8LsBIF3FLlo9eH4ODrNzirjVr7Der/ZzF
 XUQbkcPqjDEOXbgaqMunE4rs7LCuIrBb+UigyX1VCt/DYwV/X9AKK9X20/5frQPFXL/xB3Syf
 rMSKjJiBdNJhfdn2JmBAfwYRZewnl6HHKfoox2saIsa/RyNnLWsWGMf3Fc7qcxiXtvotYodAG
 oc6jTACI/PwH53tRWaHy0lMcaLADizgynFOf3YsOEkVyZLyMmiRQ3fv+ChLAArwMReCiDWCDI
 qxVuuFmq1e6OIlj8XvOifd0DD1RhUl0JT6D1XL+nzi+4LpdUcPQ2kjTFjJ3zViIhzjxZWYj7h
 EI6a2Fi2dMsG8qKC1fw7bnS22WG+lPBp7+L7T2l6aAv2haD+Uj3SblFOzoA99xB+2e3mPVz8h
 JX01WupqR/+32R6lgVqsCp/8d1EabisQLQXDskAhD2/fjB5g783gfBunIBAhlHJt8iRcNDUpJ
 C7ELFPgQ/l989eYcEu3P6NJa+DbFYaslbzlvuWZOQ4L5sJS1fVxzmvsig8

Dear stable team,

I noticed that ceeeb99cd821 ("dmaengine: mxs: rename custom flag") got backported, but the additional fix 269e31aecdd0 ("spi-mxs: Fix chipselect glitch") hasn't.
I think was caused by the lack of Cc to stable. Without the latter patch the SPI is causing glitches on MXS platform.

Please backport it from 5.4 to 6.6.

Thanks
Stefan


