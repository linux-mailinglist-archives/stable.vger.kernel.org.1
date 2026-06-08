Return-Path: <stable+bounces-262014-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 79vjKmejJmpNaQIAu9opvQ
	(envelope-from <stable+bounces-262014-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 08 Jun 2026 13:11:35 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ACF24655875
	for <lists+stable@lfdr.de>; Mon, 08 Jun 2026 13:11:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=mojatatu.com header.s=google header.b=gQ0EGIZ6;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-262014-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-262014-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 10DD43035C35
	for <lists+stable@lfdr.de>; Mon,  8 Jun 2026 10:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F77832470F;
	Mon,  8 Jun 2026 10:57:28 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB1D2E62D9
	for <stable@vger.kernel.org>; Mon,  8 Jun 2026 10:57:26 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780916248; cv=pass; b=WwQmU+JxWkwOqhTrUmS0EGff+yfnkrNJWyuAbfhkc4DsfAWszjcp5Evsh9K8ZDABoljYHlKx0SGT+2QlpFxcMRIHyocYFMX667TL4jyW9S1QqLdErX1otv6Vj935Vn5XPyJbwZEPJMM40q/ZrvNFw/iaqN4aGXEYLzogURdi29U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780916248; c=relaxed/simple;
	bh=h5GwtUrO5YjewAia1LKWw8eyP/OHFDrD+FZ3lR6jbPw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QWsQBFCbHAccdS7qyzngX1cmPnfKfvaeyc2iRMX6SK8aE6DSeVD0CMivF8lS+d/yGxMXSni5Td5nVAG/yF23jBJ/ZB2PwaShqD6tFQOZRGOa1kNqigKDUx2D21yE3W0yvbPZ8tZMmOZy2DS6tMNoNWN4r8XrK/jEIP0CfzkvR7A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=gQ0EGIZ6; arc=pass smtp.client-ip=209.85.215.180
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c8583b8fd89so2556562a12.0
        for <stable@vger.kernel.org>; Mon, 08 Jun 2026 03:57:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780916246; cv=none;
        d=google.com; s=arc-20240605;
        b=lSmrhZz5YA59mPvs95lMgaOmBPnsY5Voz0hWqvMo2CFejFy7bkVc3Cxpj/nQKH0mjk
         JUbYuspe4CAqxZWoQYWCXkRCKG/EHJeuEBG2n7GKVfJ+e2EpVQvCc/yjslSjbtKgRVe8
         7TtlvUH0dtYBZbK1MdOGsh8xiKxLchdny03rr71/OxWlqzTa46L5Mbczo64HJJxWcTVn
         NxASbOQNUpkH5WJO6FmedUcSqsJqg3csvxfZw6SQpddrpfO7kPF6FnNgPv2MHeTw186Z
         XKpHc+HLZvH793ZFn18OAYb7/ETL7xpfErU2ZfE6jYdzRPVMtVTRoXjt4So6fv3Mah6C
         qLpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ahSludj4wZP/wYjbZjK7tn5JJdzUwAesoF596bb6ciA=;
        fh=DEx3cC6c+xf+RYZaPwDtnMlGwFbbnaBOADuWtzkO6UQ=;
        b=aS4OKmuYczRSCST0/c4WPkOFYMYjF8oXFBTJiLFM7duJhvZ7LxmEYx3xbLdjXCw5R8
         n3XT3QKu0t3qfuRRYYNXbK/37bqXavuJzyJQ69TajZMC3kTOkyliCPIbeQMmyK1Z6K4g
         1NxRdZJzTO1AyHXE0CKqvfv3vfLoN7YeunzuS0+yaUpe9jVyW3cILsqooVF5h1H+kdSc
         JsgC6gY+l0zDJ0JdUETzNjBrAdVP2nAq/9K2M7JKQvHXZWwcv4OYV0rzjq0S+lBUd6Dl
         TRy3h4pM+cZSPBSmTqSkfrLLuUTlGPT2t4niFtzW5CQrcrpKXF/PajbTxe9KdoqbViNi
         eTfQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1780916246; x=1781521046; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ahSludj4wZP/wYjbZjK7tn5JJdzUwAesoF596bb6ciA=;
        b=gQ0EGIZ69FI0StN90EvGes4izXiy38ewH3nES8oD3xkgoD1whxJRBaKB0UvZQsYMTB
         PxuUQqcw9YK07WcuL8gD8V+Ptxw1q/N5FAEBumX3h6zqktw/+RFMWDy/FkZtiUlvCNe4
         HZjrRDVkOrOb72dIpWs2T6lL4cpJEz4vy+ZR0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780916246; x=1781521046;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ahSludj4wZP/wYjbZjK7tn5JJdzUwAesoF596bb6ciA=;
        b=OmpnLIWNhcGReLYA8Mm1IQDYbQaiAV3CsK9Nxf22J2s6eQpxoq+5irVViHcbnjMT7n
         p1hUysR7vZdS74UL4KAqjTellGHMEPwZ1wM5h4JNKmaXDhAu7QxSxg2qW5IdycJR5swa
         30v7WL9SAlr3jT7Ww5izwnOGi5CJYDGPP9NHddwTk8Veret2uyDvppb7i4L+rpnfzeYa
         d0LV2VUQDPCd93CbbHk6ySn26vep33IWxeOV8IkOVd/XQbvZFALIRGY5PPRnTwLjNMov
         +TP8y+V88EjM8jnt2O2w7z5kJEWzNkVRGRPyTnyum4RgNRKrvrWmKaD+XxFIay5G6ENB
         StLQ==
X-Forwarded-Encrypted: i=1; AFNElJ+eIgKyr7fQqo+ZIeomtAVuxykjDqk7Ad+6DLDS1smcTAlHIUZwtvsrbsG1YLskpdgD8cijEAc=@vger.kernel.org
X-Gm-Message-State: AOJu0YziYnHEZZfnYA0x818fpDM6sdHnelc2Qs2+WIAE2oe/fusVTpXM
	2FRoZE78IlWRMk44BJnRwIksagi0yyMIqp9DW3lL75eYxl9eHu5H9Lpfy2Wp7vMCHu7lxSllW51
	XmyzMpNQ8iAVIsQyVxYKqmFSoWcn5nTkmr7BJiTkMfcls2Qyh8nZ/wqNl
X-Gm-Gg: Acq92OEIDwwgSXC6jvFycUwFC0D4MdZUZgVkIWgP0aRLNoDkKzYfSLFa401M/hEhUo+
	noJduiyHuhZNnfZvnjp4iaMuutj0GHHE06bHgIfvxTb9RNfg+q+QRzfCGlxrhyKtJQysikwQv0k
	WGZL9Pxf1IM10ZFTSAYvmb+INtZkNkMha8TIjeJxNSsxBiJHQi9FCh3gQHLbz8LTXy0/k1fIzp4
	x1XXwicDfLFoV0QlWnyepDB4Ss1DzMkCVYXS89UPvoOjpogUKiWtgsX8euzdHIlOy7K4CdLTPoF
	+pZSHseR4hyp6+Mj8bM=
X-Received: by 2002:a05:6a00:228d:b0:842:6c02:2fa4 with SMTP id
 d2e1a72fcca58-842b0d60127mr14721457b3a.14.1780916246453; Mon, 08 Jun 2026
 03:57:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260607095727.647295505@linuxfoundation.org> <20260607173214.92693-1-ojeda@kernel.org>
 <CAM0EoMkszTXv82To=KnEYTgzQSmEdRW9XrAMVtJsUaDn=Akf6A@mail.gmail.com> <CANiq72mJNbNzYO37VK7s=ua5v31xBrRp8EnHDvEnKF8Z77jDmA@mail.gmail.com>
In-Reply-To: <CANiq72mJNbNzYO37VK7s=ua5v31xBrRp8EnHDvEnKF8Z77jDmA@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Mon, 8 Jun 2026 06:57:15 -0400
X-Gm-Features: AVVi8CcZH7gb8WPQEP1bwBGyGn6nbunXL5d0GcMBpIG4fwbjLQQVvr8yXfV8paM
Message-ID: <CAM0EoMmHd10iivCpDoEd3h+eae9fSnoGWAH_AkwFhrnS6PN63g@mail.gmail.com>
Subject: Re: [PATCH 6.12 000/307] 6.12.93-rc1 review
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, gregkh@linuxfoundation.org, achill@achill.org, 
	akpm@linux-foundation.org, broonie@kernel.org, conor@kernel.org, 
	f.fainelli@gmail.com, hargar@microsoft.com, jonathanh@nvidia.com, 
	linux-kernel@vger.kernel.org, linux@roeck-us.net, 
	lkft-triage@lists.linaro.org, patches@kernelci.org, patches@lists.linux.dev, 
	pavel@nabladev.com, rwarsow@gmx.de, shuah@kernel.org, sr@sladewatkins.com, 
	stable@vger.kernel.org, sudipm.mukherjee@gmail.com, 
	torvalds@linux-foundation.org, "Kito Xu (veritas501)" <hxzene@gmail.com>, 
	Victor Nogueira <victor@mojatatu.com>, Paolo Abeni <pabeni@redhat.com>, Jiri Pirko <jiri@resnulli.us>, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[mojatatu.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[mojatatu.com];
	FORGED_RECIPIENTS(0.00)[m:miguel.ojeda.sandonis@gmail.com,m:ojeda@kernel.org,m:gregkh@linuxfoundation.org,m:achill@achill.org,m:akpm@linux-foundation.org,m:broonie@kernel.org,m:conor@kernel.org,m:f.fainelli@gmail.com,m:hargar@microsoft.com,m:jonathanh@nvidia.com,m:linux-kernel@vger.kernel.org,m:linux@roeck-us.net,m:lkft-triage@lists.linaro.org,m:patches@kernelci.org,m:patches@lists.linux.dev,m:pavel@nabladev.com,m:rwarsow@gmx.de,m:shuah@kernel.org,m:sr@sladewatkins.com,m:stable@vger.kernel.org,m:sudipm.mukherjee@gmail.com,m:torvalds@linux-foundation.org,m:hxzene@gmail.com,m:victor@mojatatu.com,m:pabeni@redhat.com,m:jiri@resnulli.us,m:netdev@vger.kernel.org,m:miguelojedasandonis@gmail.com,m:ffainelli@gmail.com,m:sudipmmukherjee@gmail.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	FORGED_SENDER(0.00)[jhs@mojatatu.com,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-262014-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[mojatatu.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,linuxfoundation.org,achill.org,linux-foundation.org,gmail.com,microsoft.com,nvidia.com,vger.kernel.org,roeck-us.net,lists.linaro.org,kernelci.org,lists.linux.dev,nabladev.com,gmx.de,sladewatkins.com,mojatatu.com,redhat.com,resnulli.us];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mojatatu.com:dkim,mojatatu.com:from_mime,mojatatu.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: ACF24655875

On Mon, Jun 8, 2026 at 6:08=E2=80=AFAM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Mon, Jun 8, 2026 at 11:55=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.co=
m> wrote:
> >
> > Thanks for reporting this.
>
> You're welcome!
>
> > Unless i am looking at the wrong code version, in the current code i
> > see m_eaction is always initialized before being used.
> > m_eaction =3D READ_ONCE(m->tcfm_eaction);
> > Probably a compiler false positive?
>
> No, it is an actual bug -- you have:
>
>     int i, m_eaction;
>     ...
>     is_redirect =3D tcf_mirred_is_act_redirect(m_eaction);
>     ...
>     m_eaction =3D READ_ONCE(m->tcfm_eaction);
>
> i.e. the assignment goes later.
>
> Maybe you are looking at mainline? Please note that this is a 6.12.y
> -rc thread -- are you looking at the commit hash I mentioned?
>
> Or maybe you are looking at `tcf_blockcast()` instead of `tcf_mirred_act(=
)`?
>

I was certainly looking at the wrong version.
For example what you described as commit a01fbdecc3a2 ("net/sched:
act_mirred: Fix return code in early mirred redirect error paths")
shows up for me as commit e80ad525fc7e

I believe this bug slipped in during a small window but was fixed very
quickly. Probably some fix never trickled to stable.
If you can point me to the exact tree where this happens i can take a look.
Still curious: So only the arm compiler catches this?

cheers,
jamal

