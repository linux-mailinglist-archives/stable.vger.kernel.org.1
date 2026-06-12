Return-Path: <stable+bounces-262928-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id pQRMFzoULGoKLAQAu9opvQ
	(envelope-from <stable+bounces-262928-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 12 Jun 2026 16:14:18 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CBEFC67A17A
	for <lists+stable@lfdr.de>; Fri, 12 Jun 2026 16:14:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=En8tTTKU;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-262928-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-262928-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2913430EC318
	for <lists+stable@lfdr.de>; Fri, 12 Jun 2026 14:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72D2E3845B3;
	Fri, 12 Jun 2026 14:14:12 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C86374E71
	for <stable@vger.kernel.org>; Fri, 12 Jun 2026 14:14:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781273651; cv=none; b=PVwiJMSgfbhjYJucgovz5nEivM+uiAjaGju9rVY8UtkrNMvFAuS+0XjkV75Q8L51gl3UvpcuiV4jxqha85Qi+CsA5p6vBnenwPNtxWusfecHnSXpYPpL3djH3Pzx2CI1sRpiG8R3sYYEt4UZfjhIbRSyDfCUpip0knt52EQuMRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781273651; c=relaxed/simple;
	bh=vx8DmG5UbqBiDuSam9D1jCMImr/IEBCJFdfijvNQdKk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aBeGTAsxluSuP6sbqWLo9OMKhcJ/wDbU2WSmcd4DQ+MO7FemPvhByUWQmFVo/VUkhZotg++LJKH3UYjQ/coq8n3eWXNmBgSUnFhQl+CMJt+Uv/V8qa4O+gfyGIx/C2Cgbya+RHwY74z5WaRkiYZO/mE59pt39daM6IGl+HOO68I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=En8tTTKU; arc=none smtp.client-ip=209.85.221.50
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-45efa80e0afso817273f8f.2
        for <stable@vger.kernel.org>; Fri, 12 Jun 2026 07:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781273648; x=1781878448; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vx8DmG5UbqBiDuSam9D1jCMImr/IEBCJFdfijvNQdKk=;
        b=En8tTTKUgsgEKsbp4c067InHO3bs7OhMsj9WkHHY2W3zznqnGrfv2c+V/2I5rm5RMi
         Lx49edctNFLWTUZ4kae5iRxq+APAIJk2h98QfTkeXXcE0Tn6pjJK9zpmCWCZgLuqnQYs
         4NC1uloUq4X0+zeHqfUQWANvpAOwfpCJdR5KYywYnY7tZOEAIlz/7htodYb5rQ/riiY9
         rUe1WK235zsSxCZVI0l2Oi8LLkXgJKhcwoApeNe/r3O3YZeLtb9Oo+lk9EXIGsZnrvax
         j4jKazjqvdApeK6D95VRZj72KTo5YQ94KQ8IYxA9T53gEdFkkFzhvcJdsDmUQmpFAIBv
         h7Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781273648; x=1781878448;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vx8DmG5UbqBiDuSam9D1jCMImr/IEBCJFdfijvNQdKk=;
        b=cTJ1OB9pUp9Q9J8tM2KLWl5UrfRSLcY2QQuw4jorX2cCuzWEbWLZ9bwd/lCONY7LgQ
         MqmYknIigsQB7l+2MOpex24o5FrxLGbx4Qy1F7H+7n2teHWXMkr0zbXDlMvax8NvlYK7
         KfibXdn2pr+oQDbzB3IrdTziZBF0IyKXjYb7mdwB3H4yuFA1rWwihWtvazYiSrN0mpIB
         nI6JwPW1V1AtKWNkMGEnHJQX7XoXJR4PpM72sP5/ZTuULTusdbSAos5WaGCj15ZUJBAt
         vd2TNjH8/uy1GSqmAhIG4GSdmckvr+BHcUVVrgiOQ6iLUUfLu0/IoiO2oScR2qN4rnlX
         HU8A==
X-Forwarded-Encrypted: i=1; AFNElJ+fTOYZHNfHoep2oRluGzhXM8c8ZazQ4CB2nZ9GGGlbIyHGn8KgH6ftqSh0zo0H51tfS3MmtUQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6TG3UHdL51qdExI4J5HcWOiXKQ1CrvSY7+vE/bYRWIbc6pCgu
	BD4kMb5V9qYs4/ClW+oQIBHc+WJqjbl1ZsvgyI7tLuFifU1Y9o/tN99r
X-Gm-Gg: Acq92OHb+xWrzLO4rBfn5nTN8lWC5WWOrnRPTJ0W0yYQ3lGEA9VS4EyYU4+DpieYyhW
	XuwdMRzcsPhFuilTDHxnKmF3xKjN9SPkCf2VjjVNXwEqaHJsjZ00p5vjvXk2e97Pw11+ZMiHpMU
	SeXB1C5+QlXx736XtHydLpaqXvinK0Qz4GlWXJ3LM0vk6gwhNcJlyGwdOvvNN/bvvpODqzKQrdm
	TBpfoPc4Kwd0TbjBvAS9SPDFvlLq/yEVtzFdXUhujZ+kLeU/Vsd4qyhyJqjcNyDIlB34f75eSK4
	IT8R6+D6UVKbW+GStz7nkPdflLVPpjaFP+DT/+kEFJe54HIi3qFOfZ1XUtzEUIDgqCZwohUs7/B
	Z57wtkdrdGAbQcgTp1fNxyv8RLyXrG0UCavYcPhcYczZDuzhouBSbs8jOSdrpm3I9xXsc0UNpf7
	Q5kKcDSRcHD5pFGawIWjeOERU/D/aMJfjApPImNImHZcvGnTbH8rJX06DI7oqHkK4YZX5e/K8Bm
	ybF8YzlaCoscypC9vDhaz4=
X-Received: by 2002:a05:6000:228a:b0:460:1957:1b33 with SMTP id ffacd0b85a97d-4606db96685mr4520852f8f.3.1781273647702;
        Fri, 12 Jun 2026 07:14:07 -0700 (PDT)
Received: from ?IPV6:2001:9e8:f11c:fd01:da7:7547:99a1:b76a? ([2001:9e8:f11c:fd01:da7:7547:99a1:b76a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f26392esm6485031f8f.3.2026.06.12.07.14.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jun 2026 07:14:07 -0700 (PDT)
Message-ID: <ec27912c-a66e-4a81-8c8c-318d27ec62b5@gmail.com>
Date: Fri, 12 Jun 2026 16:14:06 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v9 1/3] net: sfp: initialize i2c_block_size at
 adapter configure time
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>
Cc: Russell King <linux@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, =?UTF-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>,
 Simon Horman <horms@kernel.org>, stable@vger.kernel.org
References: <20260528205242.971410-1-jelonek.jonas@gmail.com>
 <20260528205242.971410-2-jelonek.jonas@gmail.com>
 <20260603180607.353551af@kernel.org>
From: Jonas Jelonek <jelonek.jonas@gmail.com>
In-Reply-To: <20260603180607.353551af@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-262928-lists,stable=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[jelonekjonas@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:linux@armlinux.org.uk,m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:maxime.chevallier@bootlin.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:bjorn@mork.no,m:horms@kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[armlinux.org.uk,lunn.ch,gmail.com,davemloft.net,google.com,redhat.com,bootlin.com,vger.kernel.org,mork.no,kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jelonekjonas@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,sashiko.dev:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CBEFC67A17A

Hi Jakub,

sorry for the noise.

On 04.06.26 03:06, Jakub Kicinski wrote:
> In the meantime - AI seems to also be saying something the cap being
> potentially off by 1 in patch 2? We add 1 to the len? Maybe I'm
> misunderstanding..
>
> https://sashiko.dev/#/patchset/20260528205242.971410-2-jelonek.jonas@gmail.com

I had another look at that. The concern is theoretically valid, the I2C
write path prepends the length byte to the data buffer. This could exceed
the limit and would be rejected by I2C core/driver. But this is not a result
of my patch, it can also happen without. My patch probably just brought
that more into awareness.

However, this isn't triggerable right now IMO, thus has no practical
impact. In v8 I had a look at in-tree drivers with a potentially problematic
constellation of max_read_len and max_write_len [1]. And looking at the
SFP code, the biggest write being issued might end up with 3+1 bytes.
This doesn't reach any existing driver limit.

Given that, I'll send a v10.

Best,
Jonas

[1] https://lore.kernel.org/netdev/4a1b13f4-9c68-4f4c-a676-fd61e2aeeab0@gmail.com/

