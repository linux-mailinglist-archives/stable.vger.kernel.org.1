Return-Path: <stable+bounces-223103-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wILFLpFrqGn9uQAAu9opvQ
	(envelope-from <stable+bounces-223103-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 18:27:45 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id BB2A0205214
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 18:27:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A2DCD300404D
	for <lists+stable@lfdr.de>; Wed,  4 Mar 2026 17:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47A633B8940;
	Wed,  4 Mar 2026 17:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="BevbOVdz"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D9B3B7B94
	for <stable@vger.kernel.org>; Wed,  4 Mar 2026 17:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772645227; cv=none; b=pL19ngmw9WMCgQJ8HddOJutHEWskfVp+UKGcbeQg8lqMnwBn0/kONc5QOR+KlrDk8PPqpwL5FY+quEFZX2PLMiwr/ITzfCR8mYoCBpeHJPEx26s9cdWcU1evihkaCgUzU8ugroo6Bvei1CF8BqYdd5piSMzoCA8dJJY8zcYtJYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772645227; c=relaxed/simple;
	bh=rXW73qPdcL9DlUfKZXq1aXxoHgD1lYtRopAL96jVQjs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lWfCg6HPwGuF3R0zEwcjfJ3zNOYh2UrnvrriWM/8QABrARb3a93bj/HMD9xojzyTKCEqVghSoqrNbFz8KuMleMzIIjIQhlArYHsD3u8m2n6kaIzOI5yF+d+RhZblNnmL1qQgvgbV7NwahLZcgvTyAgIpLgWgLYg0gNcsbeAqzK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=BevbOVdz; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4834826e5a0so80976765e9.2
        for <stable@vger.kernel.org>; Wed, 04 Mar 2026 09:27:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1772645222; x=1773250022; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ld6kA80Z1AV7JAV6scb1O1n2C2MSC9/dhASUBILtfT4=;
        b=BevbOVdz2Dk+KkF8QVIWOB+sLIkpJVQZbf4UaeQi2wWip4pjPnLYxTXEtEHLRKk3PL
         Ja/AM65jIhwu7t+U1lx3j+aeep1cUEGBtsQ+ppc0T3/rQuE7DCklDhsg8tIrgblh/BQA
         h5y2DJRuxhi0aV8nhYDIEvmFKjD+rVREdYWg4N83SoPCgsrK6M9wgnnc/YHQRN/eqdP1
         rfHltNPGRHZrWEvhArh24OyUP908fbqpgU1buwk4YwOX4PRpEeCLk3jHf11tdiNHXu8D
         MuQnNPVfR3vJC0vwN1dXdhkK31r0Sj4cK4aboZ6TwXPSEiRr0F28ITY/Lhx27IkM6yGn
         ARBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772645222; x=1773250022;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ld6kA80Z1AV7JAV6scb1O1n2C2MSC9/dhASUBILtfT4=;
        b=vQwlxrthgImkeupt7T/MLBld0saDzqqkThL9Xa2FWrY+/JlSwcV4VVG+xnTPUNWML7
         qbxXvt40A6F2vnS/1fBqvLXgij18EBG/dBtDtFsK0+eY29ZrPhrXFGhqvCk5T+lpOWpx
         x7g72H6uAA+FVNfL59Fe3dmqLSNi01KSq/4zQ2oTNtl+EqJ9SEUJZWkJaUQdTq/2LWDL
         r9X8egNyGGE1+gQ2/QfYVeoKbswtcjxn6uiuWx01Pi1H8A+qqMa2VNOd/jhnoQuQ9k3p
         N8mQs0UgbsmfwXMjxXgmimUhxSAT4NJWZlLgFjtI5M/PknsS+Gi851yX1iGn0I0CcsVm
         F1HQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZKXbSOu276ly9fNdgmAIEbNbVWJgyyHFkVxYAswMl6Vge6isQATA/FOU5SIdgPbSg4hstfVA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1vpO9oCBQ4ovtfCoZQLoDFqiRX1wCxmIbZMESYeV93v1ECG4k
	VJ517S9TCf7E92b0qMmrJ8Z9ZhX8zEHLmdFBA7o00ZUSSECTZuU/Up8=
X-Gm-Gg: ATEYQzwQ6pnHy4USP5f1NELSCdxDJjvb23u5XNkwppLEFkUMURtSs0XXZ8Q+o710UF3
	FCWfXITY8RidsJgYO8GCiEfbOfs2sq8TNMXL0DQYhoovs86OtxE5RLeVVdAGKJjAeV+c3OzWBOw
	OdrJD8SIpVGMMSr0NBqsWQ5TIj5S9dMXoJ7QDPOM3ofgrJ1PjPNdvsUqo06cEvECZDpTL4U2NY3
	pll2sA7p4DQ0JUZ3d9TNzcQ4kYzqdyF6kZUNvn4L52US4gSLCshkcTvEmabBbPa6TveYr2GNcw2
	j9eVlSwYWcv5Z58LcwAb5wahc7MMRU20lQERNFCYNQeJYqKYmOAKNqfZ8frBTJtRDode6LPPeT1
	vkhMO24DnbYNV5+wva8sUxUYsi9JCGqHFCh5QsFdb3jt8hl9l8P6pMRVOTzGzcbmaNsuu9AsiGw
	CYvqgQ5ewHkgl9O6KtUZQXBMtBlQi3fPIvGZuQsSMksKvzkwiMI8WkJnTEXIrXd+8BcOnaR+GCo
	l+gLnIEAxbn
X-Received: by 2002:a05:600c:6812:b0:483:9139:4c29 with SMTP id 5b1f17b1804b1-485198480b2mr52936405e9.2.1772645221411;
        Wed, 04 Mar 2026 09:27:01 -0800 (PST)
Received: from [192.168.1.3] (p5b057b4d.dip0.t-ipconnect.de. [91.5.123.77])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4851ad09476sm20129075e9.8.2026.03.04.09.27.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Mar 2026 09:27:01 -0800 (PST)
Message-ID: <c435a3c6-5952-453f-9e50-31e0c6cdd09f@googlemail.com>
Date: Wed, 4 Mar 2026 18:27:00 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: Linux 6.1.165
To: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, akpm@linux-foundation.org,
 torvalds@linux-foundation.org
Cc: lwn@lwn.net, jslaby@suse.cz, gregkh@linuxfoundation.org,
 Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
References: <20260304131525.84627-1-sashal@kernel.org>
Content-Language: de-DE
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20260304131525.84627-1-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: BB2A0205214
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[googlemail.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[googlemail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-223103-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[googlemail.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[googlemail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pschneider1968@googlemail.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,linus:email]
X-Rspamd-Action: no action

Hi Sasha,


Am 04.03.2026 um 14:15 schrieb Sasha Levin:
> I'm announcing the release of the 6.1.165 kernel.
> 
> All users of the 6.1 kernel series must upgrade.
> 
> The updated 6.1.y git tree can be found at:
>          git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.1.y
> and can be browsed at the normal kernel.org git web browser:
>          https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary
> 
> 
> Thanks,
> Sasha


In the now released 6.1.165, I get the same build error as I have reported in the 1st incarnation of 6.1.165-rc2 (see [1])

   CC      arch/x86/kernel/setup.o
arch/x86/kernel/setup.c: In function ‘ima_get_kexec_buffer’:
arch/x86/kernel/setup.c:385:15: error: implicit declaration of function ‘ima_validate_range’ 
[-Wimplicit-function-declaration]
   385 |         ret = ima_validate_range(ima_kexec_buffer_phys, ima_kexec_buffer_size);
       |               ^~~~~~~~~~~~~~~~~~
make[3]: *** [scripts/Makefile.build:250: arch/x86/kernel/setup.o] Fehler 1
make[2]: *** [scripts/Makefile.build:503: arch/x86/kernel] Fehler 2
make[1]: *** [scripts/Makefile.build:503: arch/x86] Fehler 2
make: *** [Makefile:2025: .] Fehler 2
root@linus:/usr/src/linux-stable# git status
HEAD losgelöst bei v6.1.165


So the offending patch seems to be still in, although in the 2nd incarnation of -rc2 which you force pushed over the 1st 
one of -rc2, it was then reverted after my report [2]. When i git blame arch/x86/kernel/setup.c and look at the 
offending line I see:

37f18915a261a arch/x86/kernel/setup.c    (Harshit Mogalapalli           2025-12-30 22:16:09 -0800  385)         ret = 
ima_validate_range(ima_kexec_buffer_phys, ima_kexec_buffer_size);
37f18915a261a arch/x86/kernel/setup.c    (Harshit Mogalapalli           2025-12-30 22:16:09 -0800  386)         if (ret)
37f18915a261a arch/x86/kernel/setup.c    (Harshit Mogalapalli           2025-12-30 22:16:09 -0800  387) 
return ret;
37f18915a261a arch/x86/kernel/setup.c    (Harshit Mogalapalli           2025-12-30 22:16:09 -0800  388)


which is this, now with a different commit SHA1: ( in [1] I found it was 73b97ee06bd635433d1c429ecdbc9167da5de588 )


commit 37f18915a261afe84dab462624ed829cddb77a9b
Author: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Date:   Tue Dec 30 22:16:09 2025 -0800

     x86/kexec: add a sanity check on previous kernel's ima kexec buffer

     [ Upstream commit c5489d04337b47e93c0623e8145fcba3f5739efd ]

     When the second-stage kernel is booted via kexec with a limiting command
     line such as "mem=<size>", the physical range that contains the carried
     over IMA measurement list may fall outside the truncated RAM leading to a
     kernel panic.


So, somehow this has come back between the new -rc2 and the release?!? But how and why? Did you retest this before the 
release?


Not good...


[1] https://lore.kernel.org/stable/66461c13-1bb3-473c-b57f-adba9db4f756@googlemail.com/
[2] https://lore.kernel.org/stable/a04b1aa6-ba46-4368-9dfe-6320a2dafa79@googlemail.com/

Beste Grüße,
Peter Schneider

-- 
Climb the mountain not to plant your flag, but to embrace the challenge,
enjoy the air and behold the view. Climb it so you can see the world,
not so the world can see you.                    -- David McCullough Jr.

OpenPGP:  0xA3828BD796CCE11A8CADE8866E3A92C92C3FF244
Download: https://www.peters-netzplatz.de/download/pschneider1968_pub.asc
https://keys.mailvelope.com/pks/lookup?op=get&search=pschneider1968@googlemail.com
https://keys.mailvelope.com/pks/lookup?op=get&search=pschneider1968@gmail.com

