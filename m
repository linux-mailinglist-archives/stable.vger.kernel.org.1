Return-Path: <stable+bounces-212820-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iBZ/Ch7ke2nBJAIAu9opvQ
	(envelope-from <stable+bounces-212820-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 29 Jan 2026 23:50:06 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B9306B582C
	for <lists+stable@lfdr.de>; Thu, 29 Jan 2026 23:50:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E481A302E785
	for <lists+stable@lfdr.de>; Thu, 29 Jan 2026 22:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85BF736B059;
	Thu, 29 Jan 2026 22:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=telus.net header.i=@telus.net header.b="LnFebDH0"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE02136A007
	for <stable@vger.kernel.org>; Thu, 29 Jan 2026 22:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769726864; cv=none; b=gqZnAQYzYscfGjce2KGr3J5yagCA/x3+OG8GfyNF8JzOAKhzIN5yeiOCjKNfcSrLkbKhV8r/bOQK6MhnFyCCR2R8o4oWkvDNsHyAmcKRMW7CQuqudXLSi42WxEsJwtMIXRwXgBnQCcRd9W1anh1jki/H8pxTBevmJhvVc1+xRtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769726864; c=relaxed/simple;
	bh=hfYyvqtsJ2DZsqWErIFYG6zpLCB1Uf+HzWmz/zhk4e4=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=PyoZO0JV0q3R5vHg6dc8T4zGqR06oiM4Mp1s/q6vkmmAwjS4olnNbMMdM+DmpTN9KVa6XbgsOICM7dUIRFwYnSV16wPPphyQDgE+bXzfq9qUJuCxzuzbdV0Gu49TXMq5j7TGifGCs7Xdu7EEUPbZhgWw/qe7jSXglzAkzordHl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telus.net; spf=pass smtp.mailfrom=telus.net; dkim=pass (2048-bit key) header.d=telus.net header.i=@telus.net header.b=LnFebDH0; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telus.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telus.net
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-29f30233d8aso9264125ad.0
        for <stable@vger.kernel.org>; Thu, 29 Jan 2026 14:47:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=telus.net; s=google; t=1769726862; x=1770331662; darn=vger.kernel.org;
        h=content-language:thread-index:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=XUwVzLNccvEjs/hOpikLQg82MEZ6/pMXIYUJ1ScKMh8=;
        b=LnFebDH0NTLBWwnXLZKo87ZU48Lohm7MpnsyDV5CZYDcGdRgjNB+m9OyrDsA7NDHM5
         ngyqF95esnENoZ/4YcqIgvN9274v0Sfvny6Uyt7MGsfckY19OE7bEsFwD8UTXPVU7lzy
         bt749xpM9Osw5L3qC02AW9rH45sRh7BYugsFa+Mx+FBVpka5KjSCy0c5OrT2ICFEG8cl
         AcC4URjRs4BLc1s3V21cNH1KoqAtqkzpapUHjmY8oqE8drpU7dE/Sb1xPw8SYtMP3qlo
         +eoLf7IfFBDIY4std+9EFYyoO7BIbcfV09wyZQAJmmLN2dgnb9wLg6aBBlY9l4JQgRgA
         IW+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769726862; x=1770331662;
        h=content-language:thread-index:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XUwVzLNccvEjs/hOpikLQg82MEZ6/pMXIYUJ1ScKMh8=;
        b=BadBb5m5x/oDBN9HFCTNlsoPaEDffkTrvt63eO0P3BkLTvTlmS/D35bFFSLSiy329c
         mS6sMI+ogAwMIwnK0cQsyxKNqRUXwIVVQs2ib3x32DmrMXZjwGlYjcZnRuPJXXtptSQF
         pRjHPr0mzrslRCgKtwhuWgwu7/I9U7kisHGVetwGjnmiU0/pC7tSNYhrg7N2tgUTvPdc
         75R/UOANHV8EDi1HDzX7FQaCA1uXLj+CKjRpNvq14DwiIYjq1e2noUtMkACVCMQA/ovX
         XyRIyMZJbPuMVREYhCLdrBcIiPSqqU4g3K94wMsD9POBP0y8SqAzyfjJyw4vajBCNzvS
         xb7w==
X-Forwarded-Encrypted: i=1; AJvYcCUOc5+4OrR+bwrlcfmUsKOfvMmw48kC3WPbFtu4cF0flLRj/v2x1sr0vp2AYprXh9tVAY5XWkI=@vger.kernel.org
X-Gm-Message-State: AOJu0YymwsyWEcUz7QtPTiqSaqwnBXx096LTid61vTTsmdcAR+adSNcv
	CmIG6tl35K99QedzwsAnvktKlg8T0gyJ8pTkIMcIPPoJSbz+Gc6/EYYCz9HTjCh/t7LeXkHSJeT
	jB7pj
X-Gm-Gg: AZuq6aIgUPcrD6wf4s3xvW1444dGxkXFyqNCQGR7YrHt0LDcLmaQY9MMfrYfNNR5bPw
	tVuI645gOASSHFVy5cgWuqslYgniW9vQWq7TZMBWthRvu3H3v10g+dBaomyajBH6/EbDUEmpDR/
	dPhGiv0WiI3knbJ5/hZEZI+Zey+1gkysOoD1UnN9oWNlOY+3raaud9h1zuoS0krLRR7Xz/V/tjI
	5U+vfD7ZjEeQsw/yGVyJtk1dGSocTOuOr28UGtdqIi7pCkFwAcZu7DAEG6tWw20F8yR4ObxvUea
	dLzvuRuGdKVVOuWxxaRKZptStJEOte6/uSa/aPHAZuFfIG3rPz3VyE1Om3sRUYQHjyXwuuCnMGP
	fIrhl693Y7NRgxn+e2gnRmUQLyVUP/ujP7eKNlcMhmRcjXvwM6ZWcRje+DIggr1kmN6br69a/Vd
	noTwtx450jT10m3tZCnRfsVCzkCcWLWbNckRFji8Rq1h6jVTcQIO/3yfKYglZ2ZQH1cQ==
X-Received: by 2002:a17:903:1ac8:b0:2a7:952f:97c3 with SMTP id d9443c01a7336-2a8d7ed8b01mr8989795ad.21.1769726862350;
        Thu, 29 Jan 2026 14:47:42 -0800 (PST)
Received: from DougS18 (s66-183-142-209.bc.hsia.telus.net. [66.183.142.209])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a88b4c3deasm61488625ad.57.2026.01.29.14.47.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Jan 2026 14:47:41 -0800 (PST)
From: "Doug Smythies" <dsmythies@telus.net>
To: "'Sergey Senozhatsky'" <senozhatsky@chromium.org>,
	"'Tomasz Figa'" <tfiga@chromium.org>
Cc: "'Rafael J. Wysocki'" <rafael@kernel.org>,
	"'Harshvardhan Jha'" <harshvardhan.j.jha@oracle.com>,
	"'Christian Loehle'" <christian.loehle@arm.com>,
	"'Sasha Levin'" <sashal@kernel.org>,
	"'Greg Kroah-Hartman'" <gregkh@linuxfoundation.org>,
	<linux-pm@vger.kernel.org>,
	<stable@vger.kernel.org>,
	"'Daniel Lezcano'" <daniel.lezcano@linaro.org>,
	"Doug Smythies" <dsmythies@telus.net>
References: <d4690be7-9b81-498e-868b-fb4f1d558e08@oracle.com> <39c7d882-6711-4178-bce6-c1e4fc909b84@arm.com> <005401dc64a4$75f1d770$61d58650$@telus.net> <b36a7037-ca96-49ec-9b39-6e9808d6718c@oracle.com> <6347bf83-545b-4e85-a5af-1d0c7ea24844@arm.com> <e1572bc2-08e7-4669-a943-005da4d59775@oracle.com> <CAJZ5v0ja21yONr-F8sfzzV-E4CQ=0NqLPmOeaSiepjS4mKEhog@mail.gmail.com> <CAJZ5v0hgFeeXw6UM67Ty9w9HHQYTydFxqEr-j+wHz4B7w-aB1Q@mail.gmail.com> <rsqh4kpcyodnmcxcdd3yvysdmnfj34fgjtr4pmfhlg2cqtvlhh@iakffruxcnac> <ndqg2mysdc4bsvokmrqubx6rw3oj3lrflxw3naqiohbg7yablf@ccm3rl36dnai>
In-Reply-To: <ndqg2mysdc4bsvokmrqubx6rw3oj3lrflxw3naqiohbg7yablf@ccm3rl36dnai>
Subject: RE: Performance regressions introduced via Revert "cpuidle: menu: Avoid discarding useful information" on 5.15 LTS
Date: Thu, 29 Jan 2026 14:47:42 -0800
Message-ID: <003001dc9171$4797e0a0$d6c7a1e0$@telus.net>
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
Thread-Index: AQHo/NwLGJZTeO77XmxNlnPhSwOGkAKJCFtJAex1orYBu9KCwgGuBEkcAfMdCK0CPSmxvgKqxYimAbaXPzgBl4v++LTAn6eg
Content-Language: en-ca
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[telus.net,none];
	R_DKIM_ALLOW(-0.20)[telus.net:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[telus.net:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-212820-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dsmythies@telus.net,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B9306B582C
X-Rspamd-Action: no action

On 2026.01.13 20:50 Sergey Senozhatsky wrote:

> Cc-ing Tomasz
>
> On (26/01/14 13:28), Sergey Senozhatsky wrote:
>> Hi,
>> 
>> On (26/01/13 15:18), Rafael J. Wysocki wrote:
> [..]
>>>>> Bumping this as I discovered this issue on 6.12 stable branch also. The
>>>>> reapplication seems inevitable. I shall get back to you with these
>>>>> details also.
>>>>
>>> > Yes, please, because I have another reason to restore the reverted commit.
>>> 
>>> Sergey, did you see a performance regression from 85975daeaa4d
>>> ("cpuidle: menu: Avoid discarding useful information") on any
>>> platforms other than the Jasper Lake it was reported for?
>> 
>> Let me try to dig it up.  I think I saw regressions on a number of
>> devices:
>> 
>> ---
>> cpu family      : 6
>> model           : 122
>> model name      : Intel(R) Pentium(R) Silver N5000 CPU @ 1.10GHz
>> ---
>> cpu family      : 6
>> model           : 122
>> model name      : Intel(R) Celeron(R) N4100 CPU @ 1.10GHz
>> ---
>> cpu family      : 6
>> model           : 156
>> model name      : Intel(R) Celeron(R) N4500 @ 1.10GHz
>> ---
>> cpu family      : 6
>> model           : 156
>> model name      : Intel(R) Celeron(R) N4500 @ 1.10GHz
>> ---
>> cpu family      : 6
>> model           : 156
>> model name      : Intel(R) Pentium(R) Silver N6000 @ 1.10GHz
>> 

Those are all 6 watt TDP processors, the same as the earlier emails.
We know from the turbostat data that 6 watts is exceeded in the
test case and that it is likely that power limiting was involved.

I don't think we ever got to the bottom of it for your case.
I still would like to see test results where there is no chance
of throttling being involved via reducing the maximum
CPU frequency.

>> 
>> I guess family 6/model 122 is not Jasper Lake?
>> 
>> I also saw some where the patch in question seemed to improve the
>> metrics, but regressions are more important, so the revert simply
>> put all of the boards back to the previous state.

In all of our testing we saw some minor regressions in addition to
the improvements. Overall, the patch set it was deemed an improvement.



