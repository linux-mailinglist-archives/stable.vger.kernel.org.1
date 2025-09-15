Return-Path: <stable+bounces-179633-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92B11B57F88
	for <lists+stable@lfdr.de>; Mon, 15 Sep 2025 16:52:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CD2E3B0C34
	for <lists+stable@lfdr.de>; Mon, 15 Sep 2025 14:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81A3A340DB7;
	Mon, 15 Sep 2025 14:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="pdUFRMFB"
X-Original-To: stable@vger.kernel.org
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5887340DA6;
	Mon, 15 Sep 2025 14:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757947748; cv=none; b=OTcA1UObTPCxA8iV51VJQtH+PyGoQUnScgAuEOC9sIdesRBG/INmyac8Vq/XgMjrmEjx9i1czCB/uOKNoWCJlIbD0NCTouS7LK5biLrcg25AHJ3NhZFL9AzNuuCn2Eb7114877hrrHfoVGZ+HiKHHKgeRLqVG2cv19W4ni3RyJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757947748; c=relaxed/simple;
	bh=482u6jxGleysWP98tfgATbmerynE8PjrJfFsYgUUIvE=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=sOEqdJJr+AKJzceJizhmcd3eyMu8dl8llVI+DJteS8HomWHaADFi+FvmMIWz2L9ZRSgQiwSaan2AQxuK+x6DmDVy1NfpYunMsGp87sOqJQOiRGy59wKoy2FVC3wJ2cQ22e3dXbjRDL1xKB4WNqB4fcUj+Gyxs15Ft6VdYo1R0HA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=pdUFRMFB; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1757947734; x=1758552534; i=markus.elfring@web.de;
	bh=482u6jxGleysWP98tfgATbmerynE8PjrJfFsYgUUIvE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=pdUFRMFBX3y9VNiuv90E5y0K3leDD3HcC/eJn9kyKVtbk8ehXu9KNl5gNs7pefxY
	 i8UpZPzts8g7x4rObabvMi0AoYCxeqMLw6qfQtvlibuTn+KB59b8N+C5waRiKd3O9
	 cJ8c5f1YbUE05Mb6mjGzPO212o6bSjeMunCFjH9QdyeJQr9VsNJB0bSw+KMZhREdx
	 vPZ/W3rHUVYpf3Mo4Ppurz6kyFlpAKvPdYVT9CBo+Ei8wyUgNNzt81iOG/+FLWPbT
	 uKKhmzR6ECq8WwR2l+Q9bhaym13UPCcvQb/mj4R3IbPgIxMOAlXDTzoxsjS/Q5IYo
	 GmcIWcFTrfvQ26oOJw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.188]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N3Gki-1uGtKZ3YIM-012td8; Mon, 15
 Sep 2025 16:48:53 +0200
Message-ID: <222e3744-554b-44ba-80d2-a40fc4e9bed0@web.de>
Date: Mon, 15 Sep 2025 16:48:51 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Haoxiang Li <haoxiang_li2024@163.com>, kernel-janitors@vger.kernel.org
Cc: stable@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Andreas Larsson <andreas@gaisler.com>, "David S. Miller"
 <davem@davemloft.net>
References: <20250915135201.187119-1-haoxiang_li2024@163.com>
Subject: Re: [PATCH] sparc: Fix a reference leak in central_build_irq()
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250915135201.187119-1-haoxiang_li2024@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:HDsnPt6XmmqvRVP/1lOnoyj4myfgeygTe+D4KNYgmudWzU5jvmG
 o8VsSczmF4GfmokRiZ53+/XkmSXI1+l5s8TmzCuGCfe+vFQXkEhLHvbe2RDr5WIasTDsL7N
 PCmIzrFThMCSFJ1yk2AgjzAFlYcdrgoD4F6KCggauaCwnJlqoVjFpgJ+2qF9Vak0Gq6GuTz
 2nEWFFSnoB8PUiboSU4qg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:CJifsE4RA+k=;lwfPRGdMa6c366xpf1kmb3zkRUd
 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

> Call put_device() once central_op is no longer needed, preventing
> a reference leak.

How do you think about to apply the attribute =E2=80=9C__free(put_device)=
=E2=80=9D here?
https://elixir.bootlin.com/linux/v6.17-rc5/source/include/linux/device.h#L=
1180

Regards,
Markus

