Return-Path: <stable+bounces-127009-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61AC9A757CC
	for <lists+stable@lfdr.de>; Sat, 29 Mar 2025 20:57:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1217016BAA9
	for <lists+stable@lfdr.de>; Sat, 29 Mar 2025 19:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C4E41DF26E;
	Sat, 29 Mar 2025 19:57:45 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1825190470;
	Sat, 29 Mar 2025 19:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743278265; cv=none; b=ojsgAZ7Ssc8HaDnJiNy8ronzDP4/GL1TEwtvdtL4eTIsY0UrqZwtph+ErSz+LKnRi26GN59+Bv/fkUXTV7QPX8HzBuQ07/s9oA7u9luvl3/moQYt3khn7/j5ghi7K9K7geMpcRBBibYFxvoEwRS5u4+LZ9dOdAKaDV3HqN5iINU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743278265; c=relaxed/simple;
	bh=nDtKHEALroPsCOl2psrdeC9yCUrrjfkkj9zKlm2Er00=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=V5SpvUqsd5IeTaplNWrRfeEK5Q//yswCIBobpdrlA8X+x2bShwr2kylYLJtv+rTRIp0XyqutL1ym+R54g3gI4+PvU6Bq3RO9TnU8fKW+BbOXBKIkui3ett5J1H09Ya62h1vBAhqilNB2h2CfDx2CmhYc6CIQjDFm8+1ZZxXECRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from [192.168.2.102] (213.87.153.136) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Sat, 29 Mar
 2025 22:57:32 +0300
Message-ID: <9d7f327b-330a-4874-a678-2cc231a4be8e@omp.ru>
Date: Sat, 29 Mar 2025 22:57:32 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND 5.10.y] KEYS: asymmetric: properly validate
 hash_algo and encoding
From: Sergey Shtylyov <s.shtylyov@omp.ru>
To: <stable@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Stefan Berger <stefanb@linux.ibm.com>, Tianjia Zhang
	<tianjia.zhang@linux.alibaba.com>, Eric Biggers <ebiggers@google.com>, Vitaly
 Chikunov <vt@altlinux.org>, Jarkko Sakkinen <jarkko@kernel.org>
References: <256fc608-5e12-4473-bf66-c88658722c76@omp.ru>
Content-Language: en-US
Organization: Open Mobile Platform
In-Reply-To: <256fc608-5e12-4473-bf66-c88658722c76@omp.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 6.1.1, Database issued on: 03/29/2025 19:44:11
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 19
X-KSE-AntiSpam-Info: Lua profiles 192222 [Mar 29 2025]
X-KSE-AntiSpam-Info: Version: 6.1.1.11
X-KSE-AntiSpam-Info: Envelope from: s.shtylyov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 51 0.3.51
 68896fb0083a027476849bf400a331a2d5d94398
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info:
	213.87.153.136:7.1.2;127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;omp.ru:7.1.1
X-KSE-AntiSpam-Info: FromAlignment: s
X-KSE-AntiSpam-Info: ApMailHostAddress: 213.87.153.136
X-KSE-AntiSpam-Info: {DNS response errors}
X-KSE-AntiSpam-Info: Rate: 19
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 03/29/2025 19:46:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 3/29/2025 3:51:00 PM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

Hello!

   Ugh, just realized that I managed to get the stable address wrong -- another resend needed... :-/

MBR, Sergey


