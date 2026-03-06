Return-Path: <stable+bounces-223288-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AFInE5AeqmlLLgEAu9opvQ
	(envelope-from <stable+bounces-223288-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 06 Mar 2026 01:23:44 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 957A2219C2D
	for <lists+stable@lfdr.de>; Fri, 06 Mar 2026 01:23:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 93E15301068A
	for <lists+stable@lfdr.de>; Fri,  6 Mar 2026 00:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0928C2BDC26;
	Fri,  6 Mar 2026 00:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="lzRe2iaZ"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 819F02BD5BF
	for <stable@vger.kernel.org>; Fri,  6 Mar 2026 00:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772756613; cv=none; b=aPYui2kHZfTTxpslI2GmHiXnzT5xgHG4oOcF6GLbVRNpdWAzeZbHbBsCmy+nHGg1K78OJlEIFFv/0ZgVr07m3uEmWg7xiozSmR9i1EW0y/TOJ17R9MbTXO2SJhLxdpUwu2dtx4oEF/rY+QymQ51PwjvwBDh40zb9ZovFGUWha7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772756613; c=relaxed/simple;
	bh=62L+6M7Xh4VkXJIXHXPtJXy9TEc+gLulzl24WMfZK/Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rOAfyCMFJMzuTWgunE6ufn0LZSR8CmXD5kF7q6YQvLW5a32pA2NaedMEzNxspXfei3ShEGTMIO8+NCOSfRh6cdVJv5TBsoEB0P8Bx/KqE/RuMSzLG29ivYx6N5s/UrPdkCiL8B+jov+lzz0XpBWl2CcLluJinBY7E2yyQrZcqIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=lzRe2iaZ; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-439c56e822eso2899792f8f.2
        for <stable@vger.kernel.org>; Thu, 05 Mar 2026 16:23:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1772756611; x=1773361411; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cURkb0Kn28gNKaPuK/J66U1F2W9xI12WyCWrTmdCGcs=;
        b=lzRe2iaZRKW6DRj2S++f4x8S4+06rn2eDglhTrSEiv0jfx0huVodeXV6O0r3DKVRaj
         YlWjbK6zu6ifXgIp99bHDHmNUr7g26O0IhccyZwD88gqb7e1YziPvaMiP1r2OjU3+7F1
         SPcPANJfdCZC/NpWuA6McYgc0fJmktAv/fQ8WIy32AOma0k83ZOfNJWSd4w2V7M6mION
         NSmdD0GZUpEFJpDP+T4GCziDM9GYByAOQgqO015lRT1AUzPMGnu60Hi3dHvjII7xqpkq
         Z067ec5Q2AR3L9J31zyu5saKwub2feGzLDe8ImjHRt3L9RAeCA0oUe3csysSA77GlD88
         +Udw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772756611; x=1773361411;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cURkb0Kn28gNKaPuK/J66U1F2W9xI12WyCWrTmdCGcs=;
        b=q9cCT3fcUmjH2LlQAqN/b4x1+FZs3m2duec+3dHFpx67B3liaFhTtUlGxlETrwCs1E
         ahUH0DepO57oXCfplIeWA6W9mQAsUCowzA11s5gzgTWw8kEdb26hd17YndXU4iFUyoEM
         YUu/2tVhVLHolldIIyShXmml1AQCARU7ewh1lll8JKe/zWTXtFLDZcGkMNLqA/Za1ecj
         fz/0I/YNahrOW+E9TZ9bqE3QwmXN1F+QCdOKmYi0fy4lo4gBD9V5b9Uit/uMIW/UfPOx
         eRjSuhrV/FzJdIKYKMirUWbKAYA4FEnta6ZALNlJdi5bDmdY9pRObEj5DPqeZXyymOLu
         Pbhg==
X-Forwarded-Encrypted: i=1; AJvYcCXeqngz+a+VrxtVXKcBbkUmqAIpYgBZaUvaAElrqOpmEMjx0Bqxk0n1AZ9f2ZlCOn8nxzEaXIk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUHgkfqYyXRvNdT9H9G6y2iLUoWpTyvaq+V1eoK6CQfGADH9Vl
	4Wi05GbR2EcpYg/v/7OtdpSFrr5TEnSb/Xin6rvrCuiM17cnOjIjGK8=
X-Gm-Gg: ATEYQzz5jJQe30sNWXs4ArgfJVcC/70LyvLbgfPHmkHFbkWIp1JKm80SOWY2MRYQhN9
	+73z+hoyDzTcW967MAUu4mh8o1NvsfWRDb+jlN3bo/FmWN5qTcPJW2XWLU5z7ONSHXpzAN6DYsX
	7uCCkD977pZwITwOxVsXHgo9WlLt4VqdUe+4tiLAg6Jl43yzE0C4gY98scGfB+vzAl0GL5qgVh3
	gUyYs/Tnm07edbJ1YCHtzYYopDvAoEleO20Mv2MxkJ0fPe10Bpt+HbSKb9QtbAh/lzDjyQ4WKIN
	wqezptineLIJMLPCNGzdUZASsIqcbj9knhC8lJwQFUPnGK9/XTl6CXYXI19UsC1mGgZT1VcN1lG
	RR+sSEU/Q5ND93MIr4C5PEsQBDeJ1pJKWu3WE7uQN/Uv/NqKmsLfsn0XA5ExWHUMZE48rePm1YM
	l/UUx6sLGth0L2wYAEG8+kFrwauJSVtH3HIocqAVqqX9SM3TkTU6myuCMESMhbqBCSp2RilG/2L
	g==
X-Received: by 2002:a05:6000:2506:b0:439:c356:9f65 with SMTP id ffacd0b85a97d-439da656bc5mr334376f8f.15.1772756610659;
        Thu, 05 Mar 2026 16:23:30 -0800 (PST)
Received: from [192.168.1.3] (p5b05772c.dip0.t-ipconnect.de. [91.5.119.44])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439b130abfasm35851035f8f.34.2026.03.05.16.23.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Mar 2026 16:23:30 -0800 (PST)
Message-ID: <40c1c7a9-a882-459d-9c2a-e00655e43025@googlemail.com>
Date: Fri, 6 Mar 2026 01:23:29 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [REGRESSION] Linux kernel 6.12.75 fails to compile with
 -Werror=implicit-function-declaration
Content-Language: de-DE
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
 Sasha Levin <sashal@kernel.org>, Brett A C Sheffield <bacs@librecast.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Aditya Garg <gargaditya08@live.com>,
 "zohar@linux.ibm.com" <zohar@linux.ibm.com>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "ardb@kernel.org" <ardb@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "graf@amazon.com" <graf@amazon.com>,
 "guoweikang.kernel@gmail.com" <guoweikang.kernel@gmail.com>,
 "henry.willard@oracle.com" <henry.willard@oracle.com>,
 "hpa@zytor.com" <hpa@zytor.com>, "jbohac@suse.cz" <jbohac@suse.cz>,
 Vegard Nossum <vegard.nossum@oracle.com>,
 "joel.granados@kernel.org" <joel.granados@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "mingo@redhat.com" <mingo@redhat.com>, "noodles@fb.com" <noodles@fb.com>,
 "paul.x.webb@oracle.com" <paul.x.webb@oracle.com>,
 "rppt@kernel.org" <rppt@kernel.org>,
 "sohil.mehta@intel.com" <sohil.mehta@intel.com>,
 "sourabhjain@linux.ibm.com" <sourabhjain@linux.ibm.com>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 "tglx@linutronix.de" <tglx@linutronix.de>, "x86@kernel.org"
 <x86@kernel.org>, "yifei.l.liu@oracle.com" <yifei.l.liu@oracle.com>
References: <DD397543-DDDE-4215-A116-318AEAFFC359@live.com>
 <0be301c0-f9be-4d70-9fdb-7a260ccf83ac@googlemail.com>
 <aam_-Y7q-c3gmfGY@auntie> <aanlzq-RqDF9xkdI@laps>
 <6f42cb43-c281-4565-b968-afc34502b9fb@googlemail.com>
 <2ffaf154-3b5d-4e49-a0d3-4aedef3501d4@oracle.com>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <2ffaf154-3b5d-4e49-a0d3-4aedef3501d4@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 957A2219C2D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[googlemail.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[googlemail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,live.com,linux.ibm.com,linux-foundation.org,kernel.org,alien8.de,linux.intel.com,amazon.com,gmail.com,oracle.com,zytor.com,suse.cz,vger.kernel.org,redhat.com,fb.com,intel.com,linutronix.de];
	TAGGED_FROM(0.00)[bounces-223288-lists,stable=lfdr.de];
	RBL_SEM_FAIL(0.00)[104.64.211.4:query timed out];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[googlemail.com];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[28];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[googlemail.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[pschneider1968@googlemail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[peters-netzplatz.de:url,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,mailvelope.com:url,googlemail.com:dkim,googlemail.com:mid]
X-Rspamd-Action: no action

Hi Harshit,

Am 05.03.2026 um 23:46 schrieb Harshit Mogalapalli:

> Hi Peter,
> 
> On 06/03/26 03:36, Peter Schneider wrote:

[...]

>> What does it do? Does is cause harm? I don't know. Do you know? Maybe Harshit could tell us if it's a serious omission 
>> or if it's not critical. This, IMHO, should have been avoided. The better wording in the release announcements of 
>> today would have been: "All users on X86 must upgrade", so that nobody stays, unaware, on a kernel with that 
>> incomplete patch set.
> 
> I think only people having CONFIG_IMA are affected by this patch, and whoever have that will run into build failure. (As 
> missing function is a for-sure build failure).

Thanks very much for your detailed explanation, you have relieved my worries and headache!

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

