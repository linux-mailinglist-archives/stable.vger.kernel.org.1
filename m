Return-Path: <stable+bounces-268104-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Qkw4ESmaO2rnaAgAu9opvQ
	(envelope-from <stable+bounces-268104-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 24 Jun 2026 10:49:45 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D94A76BCADF
	for <lists+stable@lfdr.de>; Wed, 24 Jun 2026 10:49:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=bynar.io header.s=google header.b=Pr+6ZLnk;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268104-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-268104-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=bynar.io;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5798130F1A61
	for <lists+stable@lfdr.de>; Wed, 24 Jun 2026 08:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C55CE395AC7;
	Wed, 24 Jun 2026 08:46:56 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 340C22F7F16
	for <stable@vger.kernel.org>; Wed, 24 Jun 2026 08:46:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782290816; cv=none; b=RLxuttsCU1xz2OzWoALHP+yZw4lztEBTUfIDrjJzuJj2AOCL2xrPeBShCLujOYOyBA/TH7MaKHNYXM5LvkzpJITVVHc5wJb9e/1t0IMo1ephQneDcKB1ET16yk4YRL5nyvZQjKVuIQaJ0hGnDmfyh4PqGyvjEaUMBVq7nRlP+uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782290816; c=relaxed/simple;
	bh=JYmu2+JdkqGyZTP1oLieVZekIxSdPrIlArUvGyIdG1o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MZlCu2KXy3KFMt8aNg3GbLO8KUR333MU5zy2ybGYRGPanKrsQLrMeUGkHRobsOK202/AHIAGXY4H/UQugyLR5lo/LZ+SpHvIx2rICtQz/AAC5G5x8O9kUXV0i5JPsXS4cqTU+SzP9EA19OXGeQ72bQWvvAdlm405yTSxgRwJ7xA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bynar.io; spf=pass smtp.mailfrom=bynar.io; dkim=pass (2048-bit key) header.d=bynar.io header.i=@bynar.io header.b=Pr+6ZLnk; arc=none smtp.client-ip=209.85.208.42
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-697cd68d7adso1186353a12.1
        for <stable@vger.kernel.org>; Wed, 24 Jun 2026 01:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bynar.io; s=google; t=1782290813; x=1782895613; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EVe3tCAxlFJeaGN50Dp+OHqy135nya+hifIMDSlUhLs=;
        b=Pr+6ZLnkFJ/CK92fIeBD+pneWmBW8MO0IhIk9kGAKCFKAdy8z2r76aUPFsba2Obcju
         621IactixP9QJrmpGsycrc1I1xUBHfzhkjsWXU7tXsB2OrGXJraqNXU+rgHZl0megyrC
         XaFl4ivYa0izGw7rIgJTVH2uIhISu28xWOl30ARz4r7h97lrtI5MK4L5xFNYfroNaZPC
         mu6WtvqyvUv1Wpd0L9Ct/VFAA1dyElY2k3Vzqbcmf8lRYuMfzhh+s6UOpkqj3PEopoW+
         HU4o7JN6g2DJeDgLHdKHqXCl8QRZ5TDUNHOmP9MPQNSXxgDHniSHKL1gIIbIBHlREMXZ
         gFBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782290813; x=1782895613;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EVe3tCAxlFJeaGN50Dp+OHqy135nya+hifIMDSlUhLs=;
        b=A3dRico0qeHTHk48mUwYAgl7RxCWsz7pi6JktUIbz+tEcEtoMPGUCOdMEUbT8uxCO2
         B3kvuszFqvDOVQRmp/kxag/+c3KDWbETFZQuox5Oxmg/+z1OxNn01Rpys/l/RlrSam1/
         z/Qr3Sef9/5RfukVe+gDdkYi8iDT/iEWmNzupiqKuwCH4Mws8TlVTCspzbNnJHzv18lN
         TKoznRIfy0Pl5izSuH5lyHdmKhvEua8yGEmS205lnIIGA2jFgOE9GAAokBbN1dWAs5f0
         WT3bryHXVFEbSBsJI81GG46FGoqd7JcJAocGLVGgMqmZdBbcLqK4+HEzIYpKuPJaBS/U
         jGbA==
X-Forwarded-Encrypted: i=1; AFNElJ9b+WQaHKx0vy+LhcRt6GuyjWLexw+SjO8ILVX8opKgq7ZElEo0912aplV66VD5LxP5KjtBJ+Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6Dn0NkYbVnjqX3Qs4dNmc6uh9A8Kiy8Uwa3UCCl94xk1l+voI
	tzSfkG85UXJcOVIDejgF8HoZLfdvKl6JcGbhGhfKZCQ4lEkhRL+AyG/KcEJImoqg5U+j
X-Gm-Gg: AfdE7cn23VO+a0Ncsd9Opr0EeqoJ/4y9RTKI7fy5JSl72UJ1hVJBlObausnEf+Lvy7+
	nXEXgELQ+8CYFbkyOssVD2MEKkOlKgU/EP9P9H+Sk5/QtvxWTkvBVDeeOosqIFCplBDiLBqEvHv
	xNiArMJgt+U5gQL2CsvYm2m+7fcxWyJ2gJe/FR1XzgCKtSes7Tl3Cc1q9tQK83nwcG5FG+DF9E9
	wCP0Fp/Wxx6+bVBqM6ar2mFE8lyuiDc5o7ZiQpTJR6i2a5Uqra04539xMlUlGVPy29nkJJ715Yq
	l0egcu3HroKKg0axnD1FuEQACLqde76Ux4J5FyRMyzT4oqFLNeIV2gkBGY1V3evwItAimpSowKu
	k2JOxN/DAvW+NVv7FyYEmV11VOBhmv0FqC6dyNPka1TfY7iZXwPbTsmWt9iz9X5IhjRrbNjnbzi
	krq/4zoVCF5yJHu8ngbhMckbEL5D7M1uwHZc0qh8OtFvc1iA==
X-Received: by 2002:a17:907:a392:b0:c08:417e:3696 with SMTP id a640c23a62f3a-c107d7137b7mr319688366b.20.1782290812994;
        Wed, 24 Jun 2026 01:46:52 -0700 (PDT)
Received: from ?IPV6:2a06:61c2:d427:0:b321:1c7a:b072:326e? ([2a06:61c2:d427:0:b321:1c7a:b072:326e])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c0c61610b2esm640641866b.57.2026.06.24.01.46.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jun 2026 01:46:52 -0700 (PDT)
Message-ID: <c9abc633-239c-4562-b1df-5c9d687e70d4@bynar.io>
Date: Wed, 24 Jun 2026 09:46:51 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot ci] Re: nfc: nci: fix uninit-value in
 nci_core_init_rsp_packet()
To: syzbot ci <syzbot+cie92d4e0088e1c4d0@syzkaller.appspotmail.com>,
 davem@davemloft.net, david@ixit.cz, edumazet@google.com, horms@kernel.org,
 kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 oe-linux-nfc@lists.linux.dev, pabeni@redhat.com, stable@vger.kernel.org
Cc: syzbot@lists.linux.dev, syzkaller-bugs@googlegroups.com
References: <6a3b838b.c358b6d0.89040.0007.GAE@google.com>
Content-Language: en-GB
From: Sam P <sam@bynar.io>
In-Reply-To: <6a3b838b.c358b6d0.89040.0007.GAE@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bynar.io,reject];
	R_DKIM_ALLOW(-0.20)[bynar.io:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-268104-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[sam@bynar.io,stable@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_RECIPIENTS(0.00)[m:syzbot+cie92d4e0088e1c4d0@syzkaller.appspotmail.com,m:davem@davemloft.net,m:david@ixit.cz,m:edumazet@google.com,m:horms@kernel.org,m:kuba@kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:oe-linux-nfc@lists.linux.dev,m:pabeni@redhat.com,m:stable@vger.kernel.org,m:syzbot@lists.linux.dev,m:syzkaller-bugs@googlegroups.com,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[bynar.io:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sam@bynar.io,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,cie92d4e0088e1c4d0];
	DBL_BLOCKED_OPENRESOLVER(0.00)[syzbot.org:url,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D94A76BCADF

On 24/06/2026 09:13, syzbot ci wrote:
> syzbot ci has tested the following series
> 
> [v1] nfc: nci: fix uninit-value in nci_core_init_rsp_packet()
> https://lore.kernel.org/all/20260623222402.175798-1-sam@bynar.io
> * [PATCH net] nfc: nci: fix uninit-value in nci_core_init_rsp_packet()
> 
> and found the following issue:
> UBSAN: array-index-out-of-bounds in nci_init_complete_req
> 
> Full report is available here:
> https://ci.syzbot.org/series/2a9a8657-37a3-4dce-8cb5-2035027791dd

Oops, looks like this patch did indeed introduce a regression due to bad
check ordering. I have a v2 prepared, tested against the syzbot repro and
NCI selftest which I will submit after the ~24h patch resend period is up.

Thanks,
Sam


