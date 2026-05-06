Return-Path: <stable+bounces-244287-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CHTaNauT+mm7PwMAu9opvQ
	(envelope-from <stable+bounces-244287-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 03:04:43 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C8554D5253
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 03:04:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 340B33028836
	for <lists+stable@lfdr.de>; Wed,  6 May 2026 01:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43320C2FF;
	Wed,  6 May 2026 01:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b="GkDIJ5Q1"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF9519DF6A
	for <stable@vger.kernel.org>; Wed,  6 May 2026 01:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778029479; cv=pass; b=SZsBtXb5I2l32k9byMkWKOI2Ja4cCGHIdiAa4sN5kjdq+Xlt99AVGxKBJVFO9oaIRdFjWIearlx5tsVqg7/IKxWFFFjBNHfikJyOVwt0//BgkrooON7DG05zIi0Gr+N0Svw3XOzwzLf4ZtJHt9UrW5+RX8W5+gSDeVAor51/rHQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778029479; c=relaxed/simple;
	bh=WeSGqUsBPS7NdUbSMuKhfVFAr+0NNERLbgb+lqLr2OA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=GDA5eAKl0nplYHnjyWLkszcGkaSUCIB+aifVWbO++IM7dGFFaD6H1vPJt05WurCFXVVm/hm7tn25yaNZfHet9zv+w6ncLAlSpF3pb8Hn0iNqk+mRMrp7UmIcNcARYckCiycMOSOljAVAwWO6AZxnMo5UmU87eOPumMonb8CHh1A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com; spf=pass smtp.mailfrom=shopee.com; dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b=GkDIJ5Q1; arc=pass smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopee.com
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-2ef8d6ba48bso294687eec.1
        for <stable@vger.kernel.org>; Tue, 05 May 2026 18:04:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778029477; cv=none;
        d=google.com; s=arc-20240605;
        b=I19jiK5Jml3/4dxxsCMMGzp2x1hn7HWebHNqjdkaZJ0And7wEG+vDFnWIM+Rv8qzEE
         mgBC//xuX7cz6JPW2H9OaRfWcDEW2cB6zjiW1xAi3pjr6ITrX3bQJ9ECIezWeu86XXLo
         90M2fMkAp83Gw8k3+WYpmy0Picx5ET7b7TGKp3nMW8IMk+/vcl1HD/Ig70Zzq4JuQSOK
         cM5ZHbWOaabW42pAM5DjUdQPW5GZax/2X+BBYZTlczikPMdY/1n2zZroscX7XiIDex8r
         DcNaIv6ANvB5vcRd1ULNHP2IbSKGGUfvwB8Sl5ZhEIw42kHZdTu7P8azPfbOkqZUoQHS
         04og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DsE+PeSrf/NzrEl9og37JNUjubQniqz8TNKhe4A4HRE=;
        fh=fpsWYCr+Qvuun0vLGt33CtYAhxZfrZgSIR9inwDOHgY=;
        b=c10Qs65JGDggtJZ0qKp9f9nx0sLnObswT9C8i8tkQYugsixT1Cy39kgCnI7ur0UjbS
         3rj9SLzt9o/3RFcH+ml0mW7OvIl3s1ma6Wu338KFp3OZPVSGt9Nk96woxt5BY/srx/Ky
         KYzYXN2jl/6OjmepA24qwj2rxC8UdKfbDBhOfELsSLJWbT8JOUY6RHnoYTRXoKM7Mk4G
         QEW3lOMyp1EORTJnkZpmM/MxtBrk96jd3XWjrqeBV64H3QrpMaYGxLvZYC/74SBJtrz8
         CvORwxHPwa5ytCLtBvf4Bmi3Rqdz/EQufkOI3ha5vNyUAZdkimTncZFO93ms1zI6/Cov
         MmyA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1778029477; x=1778634277; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DsE+PeSrf/NzrEl9og37JNUjubQniqz8TNKhe4A4HRE=;
        b=GkDIJ5Q16pQYzhz3pxEUIV6u6NsnwzQydrTn5gtw8yeh5rh2fwqY9SZOgZ/umVRlIg
         x25fBQ/xqpyGonZ5xhYP7rnMQSzs/KM4F/Wc1riMXoP+PS9HmJSpIYb/7gpKkxY2n3Hc
         2sPBZ0Yhjg5vmkebqES7epv+idEbs7ozke2DaK/G+IwU7/VR+VBDW0bnHSHGkvzGWmjV
         /ZEFtPmgTRoP6CHugrB9kfD+YwzLTIeY1C7CYC0WkGKHt+Nx1VM9z27PLynFDGKM/A8w
         I3NFWbajCfZ6Pc/UKcveLGVBcEko36b/N7qpe1Ty5h+9NBf76nOzp4diqHMz9Wj+TeTR
         c0FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778029477; x=1778634277;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DsE+PeSrf/NzrEl9og37JNUjubQniqz8TNKhe4A4HRE=;
        b=G3WqXtBCDNFt130SwIa7JQBthaIfTd+lKMmiuCMfRjKOPdAL6aUlXBx/LQTg1ueH1h
         sWbKC1YC6xIq+5aTQIUZGAnYYoNwhcVZJqgaRx4cg6wTMjplD/WlJ+ir38+H8RW39IqP
         tdOdVztR3R41u9W4vqybf+9HY+LoCjNUqIP1aquQkLT94S3WdKBwZLDEhz9ZsEY13e0T
         jBu/g/4h/QX8sTsshBXubUiSNPdoQtK2KHlA6zlG60F1SopyWcOFIQm+2ndswZRJZFHI
         aahHvs9Qtdtzu2BgEj45W3s6/rkGaMLhPwB3/wtMWAtYElqm5FHrXV46/t62BVb+5PO8
         Yzbg==
X-Forwarded-Encrypted: i=1; AFNElJ9waDSW6NnKYS3W88sPxqPAuL2zHalD3OS/+Al1IWdobiuhu28RLrjk5jW0LZMWzBReRvrai4I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSawqSj3LE+GrhZHcmn+dLcbXg0mClDtSS3scqhIP3ujKf47RQ
	CoPqkfmf7a+hGs5AaZNpSsDctXDYztO7dB3mmK6LifthijjeDT9GoUXTiiyAR4gG8K32KTRasZx
	67FOTmAfa9UUCpLPTvJia0F6Ynwv7i6zo4x6QyvPxew==
X-Gm-Gg: AeBDies2/6+MfGhfjXy8fE52QxEBhoAm4jiyrini3Yg/XbFIyfKfzNUklZ/c6VyNVYq
	krH/As7C7usXUjg+QBT2Xd1TrelLguVMLj9RasNWg7eDuX/h7IVfvrWSLrW2lenHlg1hd2zHwND
	OSA5flQCbcD3YETYKMT/EOIrtp53NSWPbA5Wm2m6BIEQKlc2QDOzKazV5z57RAmATfQs+TBwv74
	fC1N9oKqo0Hxg8f5lfC5LxQIFrB1RBJw66K7SZ49w9UIFS0vv01fGNE6AJ0M+BgKJSLw72juP2a
	wuItIzl0gz7wP9hf2/XnevxGc7E=
X-Received: by 2002:a05:7300:fb8a:b0:2c1:82c2:bc31 with SMTP id
 5a478bee46e88-2f3d079d433mr2147391eec.10.1778029476904; Tue, 05 May 2026
 18:04:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <177771348699.1898023.16904466444228860838@eldamar.lan>
In-Reply-To: <177771348699.1898023.16904466444228860838@eldamar.lan>
From: Jiayuan Chen <jiayuan.chen@shopee.com>
Date: Wed, 6 May 2026 09:04:24 +0800
X-Gm-Features: AVHnY4Ld4uQUyoOaqaQn_pJ5ltYCQOi65ut2p0eYluQk8TlWIlP0ecsVLB1r7No
Message-ID: <CAL3Ev5070_=K9F9+03GrE2+4tgr=j_CO19=m4ZPTd17YSwmokQ@mail.gmail.com>
Subject: Re: [6.1.y regresssion] 9a95ec9144ee ("xfrm: fix ip_rt_bug race in
 icmp_route_lookup reverse path") causes log spam on ping to unreachable host
To: Jiayuan Chen <jiayuan.chen@shopee.com>, Paolo Abeni <pabeni@redhat.com>, 
	Sasha Levin <sashal@kernel.org>, regressions@lists.linux.dev, stable@vger.kernel.org, 
	1135514@bugs.debian.org, podorski <podorski@gmail.com>, 
	Brad Barnett <debian-bugs5@l8r.net>, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 3C8554D5253
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[shopee.com,reject];
	R_DKIM_ALLOW(-0.20)[shopee.com:s=shopee.com];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[shopee.com,redhat.com,kernel.org,lists.linux.dev,vger.kernel.org,bugs.debian.org,gmail.com,l8r.net,davemloft.net,google.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244287-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@shopee.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[shopee.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,shopee.com:dkim]

I think it because we failed to backport  this patch before:
https://lore.kernel.org/stable/20250207161555-b1a8749027831a1a@stable.kerne=
l.org/T/#m0c880c1f04f7211aea9b7f6b4de0b64aa1726417

On Sat, May 2, 2026 at 5:22=E2=80=AFPM Salvatore Bonaccorso <carnil@debian.=
org> wrote:
>
> Control: forwarded -1 https://lore.kernel.org/regressions/177771348699.18=
98023.16904466444228860838@eldamar.lan
>
> Hi
>
> [sending correctly including the needed mailinglists]
>
> This is a 6.1.y specific regression, so I'm not CC'ing netdev, but
> maintainers, hope this is fine. After a backport of 81b84de32bb2
> ("xfrm: fix ip_rt_bug race in icmp_route_lookup reverse path") was
> applied in the 6.1.y stable series as
> 9a95ec9144eeff1fc6fbcc21b677e322c6f1430b, user are reporting that on
> pings to unreachable host the log is spammed with the "detected local
> route for %pI4 during ICMP sending, src %pI4\n" messages.
>
> One report is at: https://bugs.debian.org/1135514
>
> This does not happens with other stable series versions (6.12.y
> tested explicitly, 6.6.y I have not avaiable to test).
>
> Is there a missing requisite in 6.1.y?
>
> #regzbot introduced: 9a95ec9144eeff1fc6fbcc21b677e322c6f1430b
> #regzbot link: https://bugs.debian.org/1135514
>
> Regards,
> Salvatore

