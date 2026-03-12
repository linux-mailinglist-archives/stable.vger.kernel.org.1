Return-Path: <stable+bounces-224786-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EBGYCqUismnlIwAAu9opvQ
	(envelope-from <stable+bounces-224786-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 03:19:17 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 80C9626C27E
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 03:19:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3D92F3051A82
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 02:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE8AD31F982;
	Thu, 12 Mar 2026 02:19:14 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx2.zhaoxin.com (mx2.zhaoxin.com [61.152.208.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 457571A680F
	for <stable@vger.kernel.org>; Thu, 12 Mar 2026 02:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=61.152.208.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773281954; cv=none; b=J1g5bFr/aN84wEvq/bxyG4NkjIG140Ybg9syNo97/uzcg4072YHUa7Sw4bkqb/t5fZvdjVy9mzTfhwnATiObyMfT+2jnt12NC6uUSAXZ/6ABuKEzBE/pIYI5m7HcevZzXXHS2XPiBLll9Fd1vcxpV1j5etJNCEAxg6++6dxMquw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773281954; c=relaxed/simple;
	bh=y+40TWpBQ2zOxGY+nsk1kvKXHJo/yz5hLRfwRDOlt7g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YzmFa/rYpH0GMMamG9P6USgSm/+7P8GDr9gkt0yNIMMyeecFFOAekHQnZmSP0p52WMc/pYjVkqx/ZTUHHmbb1myDIfnmwjQj0yQeeKhTUd46lv9IZ4IURIuoVzNNdPGo06bcilXDM5wozBB12KSfcP8iIhJtZZdsqZ7D8GKyNYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com; spf=pass smtp.mailfrom=zhaoxin.com; arc=none smtp.client-ip=61.152.208.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zhaoxin.com
X-ASG-Debug-ID: 1773281949-1eb14e06ec0c440001-OJig3u
Received: from zhaoxin.com (zxmail.zhaoxin.com [10.28.208.166]) by mx2.zhaoxin.com with ESMTP id Ao9zuXIpI4CvRof1; Thu, 12 Mar 2026 10:19:09 +0800 (CST)
X-Barracuda-Envelope-From: TonyWWang-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.208.166
Received: from [10.32.64.22] ([10.32.64.22] [10.32.64.22])
	by zhaoxin.com (f222c4) with ESMTP5ec05cd12c134825a730b52d4c57502c
	Thu, 12 Mar 2026 10:19:04 +0800
X-Eyou-Smtpauth: tonywwangoc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.32.64.22
X-Eyou-EnvelopeSender: TonyWWang-oc@zhaoxin.com
Message-ID: <8176878c-970a-48e3-b237-2c57ed39f7a5@zhaoxin.com>
Date: Thu, 12 Mar 2026 10:18:38 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/cpu/centaur: Disable X86_FEATURE_FSGSBASE on Zhaoxin
 C4600
To: ludloff@gmail.com
X-ASG-Orig-Subj: Re: [PATCH] x86/cpu/centaur: Disable X86_FEATURE_FSGSBASE on Zhaoxin
 C4600
Cc: me@ziyao.cc, andrew.cooper3@citrix.com, bp@alien8.de,
 dave.hansen@linux.intel.com, hpa@zytor.com, linux-kernel@vger.kernel.org,
 mingo@redhat.com, stable@vger.kernel.org, tglx@kernel.org, x86@kernel.org,
 lukelin@viacpu.com, "TimGuo@zhaoxin.com" <TimGuo@zhaoxin.com>,
 cooperyan@zhaoxin.com, benjaminpan@viatech.com, QiyuanWang@zhaoxin.com,
 HerryYang@zhaoxin.com, "CobeChen@zhaoxin.com" <CobeChen@zhaoxin.com>
References: <CAKSQd8WpwYV0rxd7soKDqcv09Oxx1sUZPTHf+b_5hqgbxHcLLA@mail.gmail.com>
Content-Language: en-US
From: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
In-Reply-To: <CAKSQd8WpwYV0rxd7soKDqcv09Oxx1sUZPTHf+b_5hqgbxHcLLA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Eyou-Sender: <tonywwangoc@zhaoxin.com>
X-Vid: 0bc6c7cd8a2ebb3ddea73d59766eff8f00@zhaoxin.com
X-Barracuda-Connect: zxmail.zhaoxin.com[10.28.208.166]
X-Barracuda-Start-Time: 1773281949
X-Barracuda-URL: https://10.28.252.36:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 1541
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No, SCORE=-2.02 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=1000.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.155726
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------------------------
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-224786-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[zhaoxin.com];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[18];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[TonyWWang-oc@zhaoxin.com,stable@vger.kernel.org];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.951];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,zhaoxin.com:mid]
X-Rspamd-Queue-Id: 80C9626C27E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 2026/3/6 04:26, Christian Ludloff wrote:
> 
> 
> Tony,
> 
> can you confirm whether F=6 M=1F is affected or not?
> (Supposedly that's ZX-D... but the F in the model does
> make me wonder/ask.)
> 
This bug existed only in certain early ucode revisions of the ZX-C/ZX-C+ 
series CPUs, and is not present in the ZX-D.

> Presumably the 6FE and 10690 microcodes which are
> out in the wild do not fix the bug, correct?
> 
> 000006fe_00000000_20110809_8f396f73
> 000006fe_00000000_20110809_8f397072
> 000006fe_00000001_20160525_7214d1e1
> 000006fe_00000001_20170109_25646399
> 000006fe_00000001_20180726_6e07329b
> 000006fe_00000001_20180726_6e1e984b
> 
> 00010690_00000000_20110809_259878a5
> 00010690_00000001_20160525_3c34fc1a
> 00010690_00000001_20170109_a8b24dc2
> 00010690_00000001_20180726_0c55f25d
> 00010690_00000001_20180726_41faefde
>
No, The four patches with the display date of 20180726 should not have 
this bug.

> As for making the code conditional for Centaur/Zhaoxin,
> stepping E seems to be when FSGSBASE arrived – and
> while there are CPUID dumps for 6FE that say VIA Eden
> it is possible that they too have the bug.
> 
Sorry, VIA Eden is too old, we haven't been able to find actual hardware 
to confirm this.

> As for making the code conditional for Zhaoxin models in
> the string, that would require more than just C4600 – the
> collection of known dumps includes others.
> 
Yes, ZX-C/ZX-C+ series CPUs have other strings.

Sincerely!
TonyWWang-oc
> --
> C.

