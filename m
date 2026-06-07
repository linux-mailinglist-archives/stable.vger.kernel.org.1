Return-Path: <stable+bounces-261890-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Pkz/Mk9RJWqqGwIAu9opvQ
	(envelope-from <stable+bounces-261890-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 13:09:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C7BD650553
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 13:09:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=EGFnHFJB;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-261890-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-261890-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 77D9330143D0
	for <lists+stable@lfdr.de>; Sun,  7 Jun 2026 11:08:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9CCC38E119;
	Sun,  7 Jun 2026 11:08:24 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C0238E5EF
	for <stable@vger.kernel.org>; Sun,  7 Jun 2026 11:08:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780830504; cv=none; b=ACQ5c+W1RBJV04Qsd5aNaGy1+MPKtOkgM75vKA22Yak4vfkWoGemuNP9BmUGMZvik4++3Pv0GIOwsCaC5P7wsPEp4Q9NrLkCTbVQe1gXoT+DQX72BUeBRD6le2aviwIDhUQW12HFjCcl9mFFrFUQ2W+Ie/XkZUoJhECMz3HtDGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780830504; c=relaxed/simple;
	bh=AOgI9qJFRjoVJ06WbokHbmBDTumJdvoTNpQhxuw+ZHE=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=cEDOYFmpyubwlWPaNNDfQTD4WO8uoqKq/M914JXGfx5uWnGmAFLnZ6KjU4zKs3KkOt5a3Fx9F0esKmgVvHC0iWIemtudblj9wMwvbacGMgYpsup6zMSUz/ZqmV2RUfkLw7H+U8bUpfMhP6n/xuf+sVuukYgAfVIDH9KgmQhGHBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EGFnHFJB; arc=none smtp.client-ip=209.85.128.68
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-4903d730b1fso37808795e9.2
        for <stable@vger.kernel.org>; Sun, 07 Jun 2026 04:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780830501; x=1781435301; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AOgI9qJFRjoVJ06WbokHbmBDTumJdvoTNpQhxuw+ZHE=;
        b=EGFnHFJBkDElNMcTpyjmJAl62CDsIJnOXnOM/zL4b09ml/0GLOCqx43XQMel/bbNAR
         bO3QNPVkSYB5K9bjWKqX6I2mcw2Aml5zPTJ7zcjZ3Ayd8PlX4pbD9lbqGacyYIrUaRIY
         ZWGZw/pIvWIqzVaNGFPTff2DOdw9BL6K44eZBJk6SYSf2gjr8qwOiM50tlB6rWV5djrE
         ABJR8t9M/ADPL8ZMxCVMaVNTfY3o7qu6Y6a67Zhj55JoHd/S3YcjyGsGDqBA34GsIO2d
         bb2klHnX1vl3o9AGBAAQzKQUeSR8hXKhSKma0xEgPGR3DKlzRlaAYpCdUK4Kfwr+MPA2
         qKAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780830501; x=1781435301;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AOgI9qJFRjoVJ06WbokHbmBDTumJdvoTNpQhxuw+ZHE=;
        b=UpCSca+M7XAclC6t80dBeDYaYXrqbHIJ9f1NFvuBtQO6C6TIucXE4GKpmv/+9ik036
         QRSvB9zwH1O1clOQQDHS7AakMhu/jVoXu66EqtxnI8Kxkzdad84KLoO3lGkeq738vUzv
         /Bdp0Cr60LYhRSElXmR0FH2KXzxOVZTzdg5NKe5zNKka4CEIScnSPojNvJVlhAeuJWzg
         eRp0c2wRItnCab4O3Uq3FOedHkITjrnCoDPqY2fg1Y9gDUQKZuB4sAEQYpy+h+aP4I/y
         9yxwyC6BcRsdFf8pt0/nBU7wIUDGc0ypAc03F3pKqBCdVlWjUzYVLuwCnJd2iE8/Vch5
         jZGg==
X-Forwarded-Encrypted: i=1; AFNElJ/3rRJQFAQBKBASAzBoppy8YT8JHr5YmtZpwpTBabSrNhYvTjV3/5djk8/UsycZRpVaLhmCMKs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1nkwVlL23zf8es6H/tIhtcGoBZuvtjzYPNHFbe3YZJHWPM76/
	sI3CnM2bWIKh/gKrYg0fNgoObSgdmAlWUNVXBXtA/c7gOkZXplKg4y8WsHbISOlU
X-Gm-Gg: Acq92OH7y7dKVIeGQyAH9STaT/+9R/XM1V/QuJVtCSsuEE4qxMs8N7PKNd6K1gtsSAO
	3qWQt7qrd1jj5YJW+Jaj4thNsUwxAd6kHsnVpiZ8LYo8gVnmSNGVUhuIADe9RKLA92yvZjKAyyD
	1spZ3BTU9hgSz3lGgUX+y+QkCSLr7dOgZqYcHu74C14zlV2Wvl44hFkg/U8rZSfZwkUfq2X9Ist
	NqZxKEqgV4JB0+vtIA3kRzWilb8Pz4xrpdOnEi52FxbYBQ0d010s2e4DjgDRR3dBpXbWsS5JOOx
	gQ0p6VPe3bXk9BEuRvh0MbNhEejWZsV4XmvP9Y/2p307N01QaHAhVPXWk7IWLElJGczmW3QMBDj
	GMxi4BJbV3IBWV1WroBXKRjWXq/gm/2rIIOUDNEvuHyaYN7gC8MBjNWIvCxRqSBKAsd5z4r5UNB
	FIEayBm/1Zloc8Iu01Ej0dIhF/4mliOGKVTtIqhQtZB4ZwejIQB1wZK3JMFEiUwHD5g0f15QrU0
	GqUpsCLYNlXtSdXMWN0nfblUllw/BDisGFaxTNBw3ZIYMw/Ulh0b8mAKEXeknwyzzoQ5vfvNg3G
X-Received: by 2002:a05:600c:314b:b0:490:548e:b854 with SMTP id 5b1f17b1804b1-490c25f5e25mr179077305e9.26.1780830501193;
        Sun, 07 Jun 2026 04:08:21 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3e4b5asm312996515e9.13.2026.06.07.04.08.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2026 04:08:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 07 Jun 2026 13:08:19 +0200
Message-Id: <DJ2RQ5NHDCZT.2R218ZSS80NQ4@gmail.com>
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: "Paul Moses" <p@1g4.org>, "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
Cc: <martin.lau@linux.dev>, <ast@kernel.org>, <daniel@iogearbox.net>,
 <andrii@kernel.org>, <eddyz87@gmail.com>, <bpf@vger.kernel.org>,
 <song@kernel.org>, <yonghong.song@linux.dev>, <jolsa@kernel.org>,
 <houtao1@huawei.com>, <linux-kernel@vger.kernel.org>,
 <stable@vger.kernel.org>
Subject: Re: [PATCH bpf] bpf: Validate BTF repeated field counts before
 expansion
X-Mailer: aerc 0.21.0
References: <20260605234301.1109063-1-p@1g4.org>
 <DJ2OZSCSEVEI.3APUCE7ML9X4Q@gmail.com>
 <E0xEdilT0Z6figMeDAyw03ex29iX0RfOAUXuh4aTJxUrKHK2Bg5N8lKCHNvQoQQ1UzndFFqDJ_zmAMYHLqSgSfF1menSW7C9VKDSBhYrTT0=@1g4.org>
In-Reply-To: <E0xEdilT0Z6figMeDAyw03ex29iX0RfOAUXuh4aTJxUrKHK2Bg5N8lKCHNvQoQQ1UzndFFqDJ_zmAMYHLqSgSfF1menSW7C9VKDSBhYrTT0=@1g4.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-261890-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:p@1g4.org,m:memxor@gmail.com,m:martin.lau@linux.dev,m:ast@kernel.org,m:daniel@iogearbox.net,m:andrii@kernel.org,m:eddyz87@gmail.com,m:bpf@vger.kernel.org,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:houtao1@huawei.com,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[memxor@gmail.com,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[1g4.org,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linux.dev,kernel.org,iogearbox.net,gmail.com,vger.kernel.org,huawei.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[memxor@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2C7BD650553

On Sun Jun 7, 2026 at 12:11 PM CEST, Paul Moses wrote:
>>
>> Do you have an example where this actually occurred in practice?
>>
>
> Yes.
>

Right, I know you can get a splat. But how did you stumble on it? Is this B=
TF
produced during compilation, or hand-crafted case meant to exercise the lim=
its
such that we get the splat? If you have a small reproducer, it might make s=
ense
to include it as a selftest as well.

> [...]
>
> Also, I still haven't made the connection between the CI failure and
> my patch. I produced what looks like the tcg variation of the same
> failure as a oneoff while testing an (functionally) unpatched kernel.
> I'm not even sure it's the kernel at all and not some weirdness
> between clang and qemu. Seems low frequency intermittent from what
> I've seen so far. Any ideas appreciated.
>

It is unrelated.

