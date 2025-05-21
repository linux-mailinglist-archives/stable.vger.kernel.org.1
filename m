Return-Path: <stable+bounces-145783-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 755B2ABEE27
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 10:41:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5ACDC7A4755
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 08:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6188223875D;
	Wed, 21 May 2025 08:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="sleVw0vy"
X-Original-To: stable@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED2E1237172;
	Wed, 21 May 2025 08:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747816840; cv=none; b=PkEsAaSId80fq8hbjV/1oEjMyW57V0paZ+9YrjoYIwihv33zfQrtLQMSa3rQoSvz8vAxYfggvWYbP/NCcT46lRzulNQBcf5TE5ZPSCPWqURZmEPhoHdvCXTRT+2zyH89yzqavwzgQCa2Sxwm3IHH9uuXvIn6ghY5a9nUGTolvEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747816840; c=relaxed/simple;
	bh=FcZ4rj0HTHRfpV6mo76/+aaCSsr4jpuW3NYUeTQzbVA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JSu1oocy2JX6QPJkjJo91HDdzolfHCZwe7tPekPiTu5OCvpJghsPrjYw82hIDzQ4ta8kizpFL8GVf6BLgPVssmIs70y/ly1uT+WkrJtJp4TKA7JChj93ihrvy0DelB+ah7c0aK9N5nN8S8wW3CgjGj/41z2DCTzv8YsNflKyLfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=sleVw0vy; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 54L8dtGbB4069531, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1747816796; bh=FcZ4rj0HTHRfpV6mo76/+aaCSsr4jpuW3NYUeTQzbVA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=sleVw0vyhjq7ckYs5nE7D6HDhONa8BxVs0Ulx3QMAM+4XpP2eBLKr5lF2riXlZtDq
	 mX6JPMK0bdRRJyemuCdKaeDwvB7VoN7/Q0RZiVyh/oEboReDdLLeFRvDFKGiHVH1GQ
	 E9jb4Tta4iiakzQy3m4FPziHfe2raz9apw27YyGE9EBZ6ZlTImQOTOicZdBic13xZB
	 sOWW0oxCoZKxyGUMFtTngb2mnPicRHFtvhvlJgIbEu304YYI3ZOcE3xLtqsPzNyinG
	 dmT6DHKM1IRdDPFC7dII2bAPgA/IxzSZSOd4koQ2Rm0ys/hDJ99Q182uUCIVQ4xj6o
	 O6lc9U143LFeQ==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 54L8dtGbB4069531
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 May 2025 16:39:55 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 21 May 2025 16:39:56 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 21 May 2025 16:39:55 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622]) by
 RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622%5]) with mapi id
 15.01.2507.035; Wed, 21 May 2025 16:39:55 +0800
From: Hayes Wang <hayeswang@realtek.com>
To: Wentao Liang <vulab@iscas.ac.cn>,
        "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org"
	<kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "ste3ls@gmail.com" <ste3ls@gmail.com>
CC: "dianders@chromium.org" <dianders@chromium.org>,
        "gmazyland@gmail.com"
	<gmazyland@gmail.com>,
        "linux-usb@vger.kernel.org"
	<linux-usb@vger.kernel.org>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH v2] r8152: Add wake up function for RTL8153
Thread-Topic: [PATCH v2] r8152: Add wake up function for RTL8153
Thread-Index: AQHbxgL3hH/sIcTMKEyDGu9tnvFmWLPcxKAQ
Date: Wed, 21 May 2025 08:39:55 +0000
Message-ID: <8654b1d586ef48f081f7d3931cbc5ea9@realtek.com>
References: <20250516013552.798-1-vulab@iscas.ac.cn>
In-Reply-To: <20250516013552.798-1-vulab@iscas.ac.cn>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
x-kse-serverinfo: RTEXMBS01.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback

Wentao Liang <vulab@iscas.ac.cn>
> Sent: Friday, May 16, 2025 9:36 AM
[...]
> In rtl8153_runtime_enable(), the runtime enable/disable logic for RTL8153
> devices was incomplete, missing r8153_queue_wake() to enable or disable
> the automatic wake-up function. A proper implementation can be found in
> rtl8156_runtime_enable().

r8153_queue_wake() is used to prevent the loss of wake-up events about link=
ing
change during the process of runtime suspend. And, I don't think RTL8153A
supports it. Does this fix something?

Best Regards,
Hayes


