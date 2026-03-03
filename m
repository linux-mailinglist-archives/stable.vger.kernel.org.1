Return-Path: <stable+bounces-222893-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sPeVCCzupmlKaQAAu9opvQ
	(envelope-from <stable+bounces-222893-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 15:20:28 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 908E11F153C
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 15:20:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 72E4A3068A06
	for <lists+stable@lfdr.de>; Tue,  3 Mar 2026 14:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA0BA3D6CA2;
	Tue,  3 Mar 2026 14:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ciq.com header.i=@ciq.com header.b="niWeoARa"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E5C3D6CA0
	for <stable@vger.kernel.org>; Tue,  3 Mar 2026 14:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772547338; cv=pass; b=BSCU8KMyVe3RuvXqLjwzoVOmVls5Zjn3saLm2kDjgDQo9+pJnAiAscw+nJce9WTvJbjTzAeKmB47Fj6WvTnIsAFIw93WGJ2NcDkt9A9ANIsjTf9bE4BnDtFd3VYnkr45R2Bi3HRjheBHXO7vSfgkK13jQeHFGCEgnpgVOZhAphY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772547338; c=relaxed/simple;
	bh=wWJbpY/42fHgMyOjdlR2gjXY5cxvMff7kY1YRZ1JHWI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kd3hv3RlWdwLVhsWIkeEpTsK2TJLh+XTzBxnHBgvc7cyBmPzQokBK7LcThAhc+0i+tpIG0z43NVQJqi2XnutOzFgF61tcCDldxswFKXPOKPDARuJ8oTkH4vryfeyFamwwWgnyHgVXM244Ct6nzvfYSGXgdmAuBu1l6AJUNQgqpY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ciq.com; spf=pass smtp.mailfrom=ciq.com; dkim=pass (2048-bit key) header.d=ciq.com header.i=@ciq.com header.b=niWeoARa; arc=pass smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ciq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ciq.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-8cbad8e6610so625416285a.0
        for <stable@vger.kernel.org>; Tue, 03 Mar 2026 06:15:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772547336; cv=none;
        d=google.com; s=arc-20240605;
        b=Cg7CPDMGz+6JUS2xAom9MO5JIFio9Vs/8txWCJYSqS7lWMbl62oUj+fJoJZglnxZ1M
         ry0gQipSQZXhQh50B58JRMgzyqRUfn8rKBFMwyK5byR1iW80xAE6x/F7hiqsJx47s1Hf
         vUBuptcwaHEo5VQBcT3b/KcyzuQHbykqyZWH0xJ7KkfzjjTLQ815uhS/AK3eCr1iFlrZ
         BtxAIaT8svXPnmj8/ymni6AJS1qxA3p3/jAlijnvbkrlgOw7z8kYJpkWvnsvKbBKrFCE
         GQuqz4P32UztLBzu+1uMvymIZMqCFPit1DlnzaFsPQ02tDcT/9q93P4g2M2Be4dSY1so
         5YJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=M67oupMhXrY0+DWlqzwxQF9Ii8HtL6+92EQ63WLDIvc=;
        fh=YXkXGO+dq6LnXt8IqmoMeArouzE0VMsUHcz/RhtgoVY=;
        b=XrXaQSssw+zSCk648kYPGg1nSZsiDG32tSUaf9oRV4K7EQbX0BIcOyswwkrFzp0zbN
         8vokfFyCwUPpg6GHSKxh5gfytoU4BFrxda1izxCxACok9/RHvXGPSN1XQ9/TVpQJBuLv
         usSD4N1WALA3KcYWNHL9G/inZlCqr0fGNBj56ZKpcXlPvO9Ht/N+GQgJsNjqIQ7ZUoST
         QStte4DrYayn6BVMQxzzBL5mQxgw0FQNQNiYjXvIWkNvLs9I9ovYAdcIwBxygf/upauH
         nNq5WCGVH26r4i+8tiu30rChEaKxVWkvnUrSDvCVdSzwjyBI+RmVh8Xr8maNjWpTx6rE
         kBzw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ciq.com; s=s1; t=1772547336; x=1773152136; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M67oupMhXrY0+DWlqzwxQF9Ii8HtL6+92EQ63WLDIvc=;
        b=niWeoARaEIMYeS4EGXKfoM1HmXrWFzUY6AB49Jm+c3rNXm9FTjy4aaVlEnDJaXjxBp
         3ny8HRtAaYdAfdtrveRg1eLvjnt7FlvOw8WYvxZAJJYisIFnZaxs0Q2yz8p7fZblb4dl
         +dS47VbywZuxuCawrn8gDce1mPMKJgXfyGSzGSehjC2nOhcqqQbLNAo7Ys1eU0/cKL84
         gOIHsXmDVkL1Pjhdbjszx9ZGQSQvZFzkwMLJlJuWOcbzxOwGmb3aJOP2ViSLlpt+za6i
         Cc/014pmhO9xtsTAMwVYu6bcfsZgY2LnX63ulOwZuRc+JR+zmZa9zd5LfvF5qTZkMXR+
         vCYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772547336; x=1773152136;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=M67oupMhXrY0+DWlqzwxQF9Ii8HtL6+92EQ63WLDIvc=;
        b=bB4FIPNGzTHTwvAg5+IKTaTW7UJI+neQ7IOt3DITpQCdk7QA3e2f8EtVxeExEpPeOx
         tYTz8g1ZYXyzdq+6G44rDuE5/heGbpORnEcD9oD53+sWP99q6FKtnfMv1jq+CzXJtLWR
         2dkY1K4kOj1Ydc9rOoVhdNlqURQgHyYuWCor6w8ZPEgI3mWxfbiL9E0En5UqypzrZPHY
         EMg5NJ/bTSA/l9rAKgZB6p20ed/t/ylvEeth3FvYCqumYl5l8Ze2jShsDHDt7lmW+6Za
         0WVlgn5NNrk3zX4ku05wyOPDzPh033clUEgEArDawGoFL6AskoiUjI05WlXkPhPB2lEm
         GUjg==
X-Forwarded-Encrypted: i=1; AJvYcCW7zacvka6fA8yJp+zUBnP3K71KDm/phTR4bbUHrNgvu4TN/fNh71+yszK0Bpz8kqA8kHrvv/0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZzWY4H3yVHYidUJuL0PiHcqgMG5MPEgJXDChw6WtAO+ZeinnR
	HZ5qejAasrNuw7o5201Bri3XdCLoMQ3qGNqf5EMYpF7tI+4FjvIQvRrP9uImG8yD3JL3zOiD8KB
	qgyxnHs5EMb+brzTmQ/rda9/7y8+eGvJlU4MUqQ6tq2SiEVvzfkNSnm4grg==
X-Gm-Gg: ATEYQzx1OKj7hGGKVN7e99LwCX4wIWrpY418kRymbl+t/nFK7j/3Rbcf5Rj01rzS6/a
	2TG3iWqnsvgqVL31FJfq2OslZq4lX/fta+G4ihupBdWORFWaxrzxsSHs0hnAbq4wqJqewFkYoyH
	ZFyyn/iClky/6ko13z+bhrKZUTDURNSWo8Ammz2Rshk7z336Lsj7YszU0Z4R9kT8J9i64UX162L
	mQZl3dLMFlsJmJDH24INEJwV07XSjFVSXlf2Dw9RkpDCiuuL8gnJbvI7P/cfXVnn8FhS//T31kV
	88/lU9tYqgAKmr+6nts=
X-Received: by 2002:a05:620a:4509:b0:8c5:338b:bfa0 with SMTP id
 af79cd13be357-8cbc8e7dc6dmr2032573685a.20.1772547336078; Tue, 03 Mar 2026
 06:15:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260302160918.2520730-1-sashal@kernel.org>
In-Reply-To: <20260302160918.2520730-1-sashal@kernel.org>
From: Brett Mastbergen <bmastbergen@ciq.com>
Date: Tue, 3 Mar 2026 09:15:24 -0500
X-Gm-Features: AaiRm53-OaYjRfWbC9pMghHZGosU3gXJ2IxK_UISbdkSNGhbNsynY5rfwvgLYP4
Message-ID: <CAOBMUvjE=nLRuRiD6gt_oFvC0gd6zqGK96kT+PoL8x-r9xAF1g@mail.gmail.com>
Subject: Re: [PATCH 6.12 000/956] 6.12.75-rc2 review
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	gregkh@linuxfoundation.org, patches@lists.linux.dev, 
	torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net, 
	shuah@kernel.org, patches@kernelci.org, lkft-triage@lists.linaro.org, 
	pavel@nabladev.com, jonathanh@nvidia.com, f.fainelli@gmail.com, 
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org, 
	hargar@microsoft.com, broonie@kernel.org, achill@achill.org, 
	sr@sladewatkins.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 908E11F153C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[ciq.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[ciq.com:s=s1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-222893-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[vger.kernel.org,linuxfoundation.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bmastbergen@ciq.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[ciq.com:+];
	NEURAL_HAM(-0.00)[-0.997];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On Mon, Mar 2, 2026 at 11:27=E2=80=AFAM Sasha Levin <sashal@kernel.org> wro=
te:
>
>
> This is the start of the stable review cycle for the 6.12.75 release.
> There are 956 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed Mar  4 04:09:04 PM UTC 2026.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git/patch/?id=3Dlinux-6.12.y&id2=3Dv6.12.74
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.12.y
> and the diffstat can be found below.
>
> Thanks,
> Sasha
>

Builds successfully.  Boots and works on qemu and Dell XPS 15 9520 w/
Intel Core i7-12600H

Tested-by: Brett Mastbergen <bmastbergen@ciq.com>

Thanks,
Brett

