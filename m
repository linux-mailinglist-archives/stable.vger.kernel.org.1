Return-Path: <stable+bounces-241088-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wOHkAHUq7GmVVAAAu9opvQ
	(envelope-from <stable+bounces-241088-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 25 Apr 2026 04:44:05 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F941464C71
	for <lists+stable@lfdr.de>; Sat, 25 Apr 2026 04:44:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C2EEB300F5DE
	for <lists+stable@lfdr.de>; Sat, 25 Apr 2026 02:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31D2C245008;
	Sat, 25 Apr 2026 02:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GtJ02XIc"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9056221F1F
	for <stable@vger.kernel.org>; Sat, 25 Apr 2026 02:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777085037; cv=none; b=SMngj6YH5gVAtElA1Y/SOIZeuLUDPk5CxFxDx8gEONz8EDxZ2AYBO6yfONC9X66avLtfi7KQ0dd6bZWO1qbzLxNQ7K1X/kgqymwR4onRlu9cDbA3Lero226pejD6UqWhDaXtAF+7soUWcS+Nz/LFDjzMPc5RB6XrzJKF1uFJeUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777085037; c=relaxed/simple;
	bh=/p/S8kUDUJ1olhsEvmLElM8ozexRk8Qir2DHZwWEN5s=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=HgWDol4U31T/XmmAIMmkco5KBlrXYst9nG0EX4jxmk5QeR041qM9+e7UCN+ZCnbghIXGhMndIHmhpCDV/j91Wyi7voROF2dTblkDl84eDpaOzA72VylORoYoqP3FGUWqDlHBm0QV1eKGltYLcFdnxideBZElTZ6HW4zVEzDwark=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GtJ02XIc; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-35d971fb6f1so6738926a91.0
        for <stable@vger.kernel.org>; Fri, 24 Apr 2026 19:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777085035; x=1777689835; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/p/S8kUDUJ1olhsEvmLElM8ozexRk8Qir2DHZwWEN5s=;
        b=GtJ02XIcMxWufMeBWwfhnmOlxx68ESDO+A9UwiIvCNrO49t/JI63dDYBYVDMlPf/v6
         z74MtLniIdNalcDIJEH68uwXNAjuz8ZHUw06zWvrF5p0qF1/4W2JZW2uGeJZFGL8lWlj
         FaNizbvcOTw/Xjl71cQhbLrZ7nlYFSPP/+30l8+srPpLpbTljrPimGeDBINnYAfl5qXx
         8OiAc/w2qSdQH8paf2Q4+0PRuTjZ8rqQ6L+5+77P6hxTj5ZwmcSzvY3/v0rZW5V6ZEl4
         sUO1ovcSpgqFii7kiId0HSP6uV6WcUDha3L5uSui4vS/9sukv7dy3Bg++ZLMh///lJik
         /k3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777085035; x=1777689835;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/p/S8kUDUJ1olhsEvmLElM8ozexRk8Qir2DHZwWEN5s=;
        b=anMWKmmP1XQ4W0WiFrBx6dQkUwQ4x5Jm2gTDJzOmi4KW2DFCLK8xjguiHUpnNAMVm1
         12zkgKf74EaotV+mCLWKIcOTPlKA5AU2E+SsRrYpCqXN4dzH++3Fh3oadoxkCxVlS6u+
         IRPuW6G2o44kIIvhbOl86MFKepWAMxItVa6Bxc/jK4rH1K3bS7p/6m+cMZWhBbhV9TSL
         82lLSibK7M21qI9Rl09crgjRLvSHV5q0nUIT+xKdB4lN/AovrN9QOoQXzpHiZnLG0+MX
         3WA6WKEGDmhBxX+SGazsQ3iDcR5heGif9sN3VkS+fXHTD8RcLAtP6xJyq9uaiGSHLYFU
         TZ1w==
X-Forwarded-Encrypted: i=1; AFNElJ81TgVC01cRjKG3yGi1cUQSJySiB2XHAP8K0Pis4AON1tWFUEyXD8AYV+mUbMl5bc52YVkea5A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOsjcaTPpcwz/zabFlPQDtfZbWb5Jj72Yi9CNYj1hn2znKLm8E
	By6kcXEx69vjGOs4AWU4eSorFdeXo9YgQ4i1UNh9xrVngqi3/DMANjlB
X-Gm-Gg: AeBDiessQdU/nFb5wa3GCH+xOJFIpaIffB8mUuCIP+s2+kzhtImsgy0biwRjCxnmjcr
	dU0hTCFQUaTSG1YpdlOVx/9sG8YivNnCCWpxR0IL4/zr79dMzmCbTpXs2p0a2Ibpu5+uoMenBpQ
	Ws+qgf2ZAiQGPYuicB1jiDsxlFvS1eO/ffDgoU3+my+lDH6Htxhgx/7U2RepoUNOgDJ9H2EwcR/
	J7yfS2lJVeFpAiJGODrAJAEkNjRVxGUpoPYXAkUAYge7keQYH32GN6ZG0athXKFZmuZubT+/OKs
	1Ove0jYzcgNHAgAulNPQqAFItRT5yt1bmkaIE/mCebbu+n43U48efE2bPTRBKchtDdqF3Khylaj
	VP44hmTTlJ7Mc51Qux8/JhH1x/7G8AEC7hHsR0XqVniYFXOKAkK3pzf0zWn2M8ekQxi0x5bUmZN
	/yXJj1kUnjzpqyoy/mraV4E6+Rcx58GC8dgmhf/Y3livJ5Umfs/qM=
X-Received: by 2002:a17:903:1b24:b0:2ae:66c9:494f with SMTP id d9443c01a7336-2b5f9e64bfcmr357108255ad.2.1777085035096;
        Fri, 24 Apr 2026 19:43:55 -0700 (PDT)
Received: from ehlo.thunderbird.net ([203.184.33.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fa9ff390sm234089145ad.9.2026.04.24.19.43.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Apr 2026 19:43:54 -0700 (PDT)
Date: Sat, 25 Apr 2026 14:43:48 +1200
From: Brite <brite.airgeddon@gmail.com>
To: Lachlan Hodges <lachlan.hodges@morsemicro.com>
CC: Johannes Berg <johannes@sipsolutions.net>, linux-wireless@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, fjhhz1997@gmail.com,
 oscar.alfonso.diaz@gmail.com
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_wifi=3A_mac80211=3A_restore_monitor?=
 =?US-ASCII?Q?_injection_when_coexisting_with_another_VIF?=
User-Agent: K-9 Mail for Android
In-Reply-To: <4i5nyqdrtpgm575dd3swyp7662wjdxu3hky7ucgwnuwigx5ge4@tc474ip5qxtc>
References: <CA+bbHrVWmSpWZ9GBVJ5vffh1qYEye=EWMq9tKA-_uzfW+raC8A@mail.gmail.com> <20260424120807.25005-1-brite.airgeddon@gmail.com> <4i5nyqdrtpgm575dd3swyp7662wjdxu3hky7ucgwnuwigx5ge4@tc474ip5qxtc>
Message-ID: <6EC55EE4-4534-4832-9FB2-393182829B22@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 9F941464C71
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	SUBJ_EXCESS_QP(1.20)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[sipsolutions.net,vger.kernel.org,gmail.com];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-241088-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[briteairgeddon@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[morsemicro.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]



On April 25, 2026 1:47:28 PM GMT+12:00, Lachlan Hodges <lachlan=2Ehodges@m=
orsemicro=2Ecom> wrote:
>Hi,
>
>I will leave implementation discussion to Johannes, but I have some
>generic feedback;
>
Thanks for the feedback and now i know why the code was flagged as llm cre=
ated=2E My approach to finding the vm freeze issue followed by the 5ghz dea=
uth not working, was done using debug prints everywhere possible, with adde=
d delays between function calls(the delay was added because the vm froze ot=
herwise, without any dmesg logs)=2E Since I didn't have the proper knowledg=
e, the fixes i tried initially (spread across 6 or 7 files) led to other is=
sues, intermittent failures etc=2E Everything was done inside a kali VM wit=
h no comments, full of messy code, not using git commits to revert etc=2E i=
 had to start from scratch but then i added comments alongside=2E Even thou=
gh the initial patch fixed every issue, being too invasive, I tried to trim=
 down as much as I could which landed the sole chandef and then the 5ghz pa=
tch=2E I didn't pay attention to improving the comments when removing code =
sections=2E I also had very limited time to spare for this and my intention=
 as I said in the airgeddon discord channel was to send a cleaned up code t=
o the kernel devs so that they could get a hint at what the issue is and co=
me up with a proper fix=2E The commit message is what i summed up from doin=
g all my research and testing=2E I didn't know the format to submit a patch=
, so i used information from AI, Google, previous threads/replies etc here =
to submit an email=2E I didn't check if AI changed any comments=2E=20
As I mentioned earlier, a community had been waiting for so long to have t=
his issue fixed=2E My sole intention was to find anything that helps with r=
esolving this=2E I've also packaged 6=2E18, 6=2E19 and 7=2E0 with the patch=
 and uploaded it for the users now but as Oscar said the proper way would b=
e a fix in the upstream and backporting it=2E
If v2 patch by Johannes(no need for sole_chandef) + 5ghz patch from me fix=
es the whole issue(I've tested this today) please look into improving it an=
d providing a fix=2E
Thanks

