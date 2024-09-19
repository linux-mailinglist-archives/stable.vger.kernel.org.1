Return-Path: <stable+bounces-76745-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D6E2C97C690
	for <lists+stable@lfdr.de>; Thu, 19 Sep 2024 11:08:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61C94B2266B
	for <lists+stable@lfdr.de>; Thu, 19 Sep 2024 09:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59345199E9E;
	Thu, 19 Sep 2024 09:07:38 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5FA6199396;
	Thu, 19 Sep 2024 09:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726736858; cv=none; b=OnUoaoYia08Rf1YjVO47HHhmx3nQQgl71RbznetTCqWhA9hJv7pRCeW9AwRxKDpWHh8sKkjlO1GrhNdjv8xIRD4xMBKew4IiUu4tKW5AJOX4Me8buibWdEW8CrUbCAuNmabD986q+LaLUamLwPqa0VtYL/QSr6YZROnCkY07yXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726736858; c=relaxed/simple;
	bh=nTGu3Z8YPhHU4/lZ6nBmTnAyIqUnJqT9r1caIzKNTxI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=FY6S2amONMpcn6GZirL9cPKvqSuvFgoUxNqNHK/VcH9o3+oLUgJkJ51j1PLZHstOkqqvvJOr3BnRLkT8/t3SLbOnr/vD1oyL27xY3Yhcv0wpELlLu0dwyaNI1U/tasbgVTckdBZHNWiGObRhPM0tOZR01lwnvn7J/7U0rHXYm5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from [192.168.1.110] (31.173.85.95) by msexch01.omp.ru (10.188.4.12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Thu, 19 Sep
 2024 12:07:10 +0300
Message-ID: <914b2a1e-cef1-b047-f9d3-d202368b9be9@omp.ru>
Date: Thu, 19 Sep 2024 12:07:09 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 6.1.y] udf: Fold udf_getblk() into udf_bread()
Content-Language: en-US
From: Sergey Shtylyov <s.shtylyov@omp.ru>
To: Jan Kara <jack@suse.cz>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>
CC: <lvc-project@linuxtesting.org>
References: <3996808f-711a-3861-8388-c729045bd28a@omp.ru>
Organization: Open Mobile Platform
In-Reply-To: <3996808f-711a-3861-8388-c729045bd28a@omp.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 6.1.1, Database issued on: 09/19/2024 08:55:21
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 59
X-KSE-AntiSpam-Info: Lua profiles 187853 [Sep 19 2024]
X-KSE-AntiSpam-Info: Version: 6.1.1.5
X-KSE-AntiSpam-Info: Envelope from: s.shtylyov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 34 0.3.34
 8a1fac695d5606478feba790382a59668a4f0039
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {relay has no DNS name}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info: {Found in DNSBL: 31.173.85.95 in (user) dbl.spamhaus.org}
X-KSE-AntiSpam-Info:
	127.0.0.199:7.1.2;omp.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1
X-KSE-AntiSpam-Info: FromAlignment: s
X-KSE-AntiSpam-Info: ApMailHostAddress: 31.173.85.95
X-KSE-AntiSpam-Info: {DNS response errors}
X-KSE-AntiSpam-Info: Rate: 59
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 09/19/2024 08:58:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 9/19/2024 6:00:00 AM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

On 9/18/24 22:46, Sergey Shtylyov wrote:

> From: Jan Kara <jack@suse.cz>

   And of course I forgot to mention the original commit... :-(
   Ignore these 2 patches, I'll respin/resend...

> udf_getblk() has a single call site. Fold it there.
> 
> [Sergey: moved back to using udf_get_block() and buffer_{mapped|new}().]
> 
> Signed-off-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>

[...]

MBR, Sergey

