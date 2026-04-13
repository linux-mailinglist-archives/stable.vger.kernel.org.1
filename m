Return-Path: <stable+bounces-236137-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eNLTDhYL3WkZZAkAu9opvQ
	(envelope-from <stable+bounces-236137-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 17:26:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 924AF3EDEF8
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 17:26:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BC8213018AC7
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 15:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14DA13B0AC2;
	Mon, 13 Apr 2026 15:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YjR1yM5t"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3CEE3B8BD5
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 15:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776093687; cv=none; b=rWG+4eNNP8zhTRyHLWNgAU5f18mxDb8MmXqpqbD4/VducAZH8UA3AGJo1B7xkyWeUgP7drVPiROrFMWQZCiSFzmqQHGGoSgsjem9if6ECFhwLiuuXnnMg2lDynJoW/ZqH+ZbodWACqonUQ26ehJkZNSqZdc3O6gOtMB7HEgT3SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776093687; c=relaxed/simple;
	bh=IBD/JgVsoz0ZuJmAgbQmjE5N4nkq2J8x1FpFUjapBN4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VZHZOrrD4GGJp8d3IoiikbDF4GP5dffm6uQ/QEvdwawzzJ8mQFonfcaFCeP4JH+g55NKCrV9KfMcGeCRV1EdJkHvVfRgWT4vOdHMpETO4lZNId8JfCSCsQOzNfoFKQ43+CM+zJ4djzFG+XqKAYXW3RO76Z84OHHtxH3RtKywKg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YjR1yM5t; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-8cb20bcff5aso418647085a.3
        for <stable@vger.kernel.org>; Mon, 13 Apr 2026 08:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776093686; x=1776698486; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IBD/JgVsoz0ZuJmAgbQmjE5N4nkq2J8x1FpFUjapBN4=;
        b=YjR1yM5tDn5JTn9me3m3WYhQqtz+mCEkOReJVBzAYDa3/UWpqrg6FZxciMGZd7iaN0
         8H/SHe5v6cXnUkJfXba3a4gdv5y8H/35dO4C6rGQFVBtTmqoQxqviI9ln8mddApQz4Le
         89ZuXt06KqdLfdvbgaUrnWnxu3fxHKQKmHhsTONn3sJEQzXcHwM+n3Vz6vdh57/KZyyS
         jcm900uz8F3YMWJKVD4lB/EVvBkTgZW2lp0ridmcCR6xR/VmENNw52eAGPkCwHXX/I8k
         KmJWYT2G0N57ZbtnjTsCbvvbj8MpSblgKZbTwbWu4GNjRbCcWNJ1iK/r4CiYQB1LrL6q
         wlbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776093686; x=1776698486;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IBD/JgVsoz0ZuJmAgbQmjE5N4nkq2J8x1FpFUjapBN4=;
        b=F5hPgFyLe7VPLMqrsAhWV7R6WPl0o/94X1n/WetSz58hyBZYzp4EqFofYBWJvE3p4m
         wFcBF3v5+nXg4sF7p/adVOH1//YGQBl3kC6fKmf7mR9JtnNUIBnFO9rLLuuQr2g6ooFL
         KRYGZ5UJF3lpw/DVVuSp+18llZBCShDNEszIQjpRNxNppd+ZY847lYgpTuspaoS56PU7
         yFOXGWBA2KhwDm8tappTuIEChmDMWcMbpL9s3L54B3cAtjxpnKa04zBMVVOvMivYnGdW
         J6iXeWEIfgIAr6QrZP2wkNgRWB1QzCa/XiVfJSDx4zXArAx0S/xpjVahJ360MRLLBcb1
         jcsg==
X-Forwarded-Encrypted: i=1; AFNElJ9Xd3yztK7aogxD3ZIIBVv/xJA7UZkMWJnmPaivT55DOMkgPDnJhvgzHpeDn9xalAej3XN6V0Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYLt1M+C8G72A8nYRiEh6jevOrPBJKK66jSuV0fScrp9BWizdR
	D2ljk2hMqDwsebFSNqy92ZyW24cAaC9e5iap9S3a4TiqaL++k28nSMqa
X-Gm-Gg: AeBDietpxpq6bSixwKOm4Jh/0Mv3BVhON7/xCrPTAiWGEszzTjZ/l6OUuMw2C57FqA1
	gnZh3QmYqAg14dzJsTSZ7MJVUcpb+BEQ6vO7H5dV3w/SCyt5ivU6+bzkcoIrCOV/+Wn29wCgQIL
	Afa+NIYhcZLSDNfDCShZqOcVLSxbVP8yK02uGbSunN5Y3gvvzIlQKf9GyjUFCZAUZnjiHq1GpoI
	/QMc0dGjIu9gZh3Bk/SXcuFjjwPaBTQrCrARzU0NRa5vFrDHiijhMFVdlTTDVrnuqhaatH3KMB/
	MKSgf75Q/uXTGgIlo0Bhab1g/mMRhbdBBiBjrpFY2SO3cy3y1cYPD4TwKz0LZrgBfYH0aN2Y8Yg
	v8XQpaHtb7TPq8+j4rZZy3X80yLa/YGp5N/NEa2ZC2/iSHxESQIfQK6EKOb/SdCsxvyXDci23lw
	SKiWatxjaFpBDwJnxBcmwOcD7f0g8Oq1Fv2L1u+sx7ZalA0eozpnYbGwgH+MosCgfovvbItqMuM
	herCa/OjBQ60WexwUgqgOPW9Q4j
X-Received: by 2002:a05:620a:1a11:b0:8cd:b3dc:9d4e with SMTP id af79cd13be357-8ddcf1b8049mr2119875185a.32.1776093685356;
        Mon, 13 Apr 2026 08:21:25 -0700 (PDT)
Received: from TDC4045031631.e0cglfehwr0e5gttmepj3hi3hf.ux.internal.cloudapp.net ([20.63.37.123])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8ddb9351afasm864057385a.36.2026.04.13.08.21.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 08:21:25 -0700 (PDT)
From: Ashutosh Desai <ashutoshdesai993@gmail.com>
To: mcanal@igalia.com,
	dri-devel@lists.freedesktop.org
Cc: itoral@igalia.com,
	stable@vger.kernel.org,
	Ashutosh Desai <ashutoshdesai993@gmail.com>
Subject: Re: [PATCH v2] drm/v3d: Limit ioctl extension chain depth to prevent infinite loop
Date: Mon, 13 Apr 2026 15:21:15 +0000
Message-Id: <20260413152115.3444105-1-ashutoshdesai993@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <80158c8c-a270-498b-b947-bc3276359d4b@igalia.com>
References: <80158c8c-a270-498b-b947-bc3276359d4b@igalia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-236137-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[igalia.com,vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ashutoshdesai993@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 924AF3EDEF8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Maíra,

On 4/13/26 09:16, Maíra Canal wrote:
> How about checking if (!multisync.in_sync_count &&
> !multisync.out_sync_count)? After all, it doesn't make any sense to have
> an empty multisync.
>
> I believe this is better strategy than using a hard-coded max.

That check makes good semantic sense and directly closes the attack
vector - I agree an empty multisync isn't useful.

That said, I'd like to raise one thought before sending v3. The reason
xe and i915 added a general depth limit wasn't just to fix a specific
known loop - it was to make the extension walker generically robust as
the extension set grows. If a future extension is added that can also
tolerate a second visit without erroring out, the unbounded walk
vulnerability class reappears without a counter. Since the current
architectural maximum is 2 (one multisync + one CPU job extension),
capping the walk at 2 would reflect the real limit and provide that
safety net without being arbitrary.

Happy to go either way - just wanted to raise it before sending v3.
What do you think?

Best regards,
Ashutosh

