Return-Path: <stable+bounces-249940-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GKo6MMPGDWr93AUAu9opvQ
	(envelope-from <stable+bounces-249940-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 16:35:47 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C1E358FB5E
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 16:35:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2B20C319B0F4
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 14:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCAE33EB7FF;
	Wed, 20 May 2026 14:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pF51/FNy"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 487EC3EDAD6
	for <stable@vger.kernel.org>; Wed, 20 May 2026 14:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779286387; cv=pass; b=ehRmidX3GyrgHOCqrKsuHg277/7q7nXbQEzHKg/Pz2IjU0qo1wU++rPEZ93XeoTuNqOBud8nG8vreMXYLzxckuj6MOiwSYTVfHeYs8UKDuHbzkE2/hTfddMUUOuLhlFJjb4Z8HuiuNINB9VCimydMTtktam7F9mxgCWkqphFst8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779286387; c=relaxed/simple;
	bh=Sde/gBT/xp0UIfybWtie6NS5tW5ikwXgAQMSfd/pE0k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bZai+jATkyCjpNS/7iE85K+vVG2O6UWae8nJ0LQR9wm9GOFSG+8IcT4caIf+usWvOujrSN/+iJdBsqD4C0zpbJ5lZWvoPXfPz4e4n2b2YG0rzLjYPssO7kufXfhLwgU7q9Pf8vNhTX1VyaJwJA24rdFOKmRJInwrshVsrg4aJLo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pF51/FNy; arc=pass smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-7bd4c61765dso45853237b3.3
        for <stable@vger.kernel.org>; Wed, 20 May 2026 07:13:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779286385; cv=none;
        d=google.com; s=arc-20240605;
        b=SNlosfwS05Y9UFkA4gxyK5AoUKrP5iU5y+hQiyYuG371XVZ3zBHxGSATLw5Eyu7P0Y
         0jesVq12AV9kOSoMIdBAiPspICotrrT9iUNDTiG8gli3+fej+O7KLAaVPzjn4XCnIQ07
         bkoCvUIAXGlNCnMLkOmAVsBo4xdWOSkqNOz97gAyfBsn+6XCmnjkXD34DnSQMX2X5K1d
         Z7kxfVPKytYATkVcLzeiStojcwYAbNhX5A2qs1WTIhE5yvctNu4JKI9POgejnKt27q3Y
         mgMQ9GuMJ9PM34Y208ghJFiOlcRp5yg6Goj6k6gNz1hraqgd8kkJhQ/g/ssD0QfIJ02r
         oWuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Sde/gBT/xp0UIfybWtie6NS5tW5ikwXgAQMSfd/pE0k=;
        fh=t3NkIkgnbWCjKm6xLTr2VKirPclsxeM4pkNWhQ6uqcc=;
        b=g5kNOwJCg+mszUeieS+Is2olf+gB4V+BjJP9qk46pfDgywtzAVUH9XnXowKdMm/IQy
         hhJ1uLuZFfNT6KnS63eI1FqPYEdiwjYxEdm8xw91p4ug/OVwgN7ZV9gotjAsJm9jmWXP
         turSWMnMZHwJ+ggW0EIe5RX5Vc4QhTJmYfHmupJgfGspC0MvGA9zJBo8Jd5u2aNRSSsI
         QTuuB3WrBW/klKrYWBrH3ATs2Sn8Ul2Ag1Bue6kUrr0SjI6MCOmcMh2amifVPFBtSfcR
         2JNjwIuAtQ0MuC7EWD9+KZWB0BaE5f56lEJEhevksvCM6eqoSHcfCL0Dbt/YfSRIjCGt
         MdQA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779286385; x=1779891185; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sde/gBT/xp0UIfybWtie6NS5tW5ikwXgAQMSfd/pE0k=;
        b=pF51/FNy/aGNyuPKZxf2LLRRzc6339p9TzxGRpp1NpOCaAChzTbDKcIKKxFiyYdz94
         8ZPl1zLMbIwxQCar7nY4utT+/6g7rD8r6Oqa4I+P/XabwlnZYlOzI04Jta6EfEppmrx1
         9O+zQiXRhl517v/nhZwM+6R5r6oThGd4ctK58L8/pKEiLUfDYBx6ps0nqUgmlHF2/mFq
         qZgIxRtuuAQWHZeoIiGmpNWClsE8HHCSXq1X5/d8Jk4YkcMW7Evoq/7HqsUFtjELulXx
         8DBW0htzglbzB6uDdDpCkOW+vdMcu59tcTYjohodZQCxX9e6YcrAQ4G0/2N/YDUtkdqX
         oKGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779286385; x=1779891185;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Sde/gBT/xp0UIfybWtie6NS5tW5ikwXgAQMSfd/pE0k=;
        b=C/7RBddRV4Vvbr7RNCnzVUF+PIyK8MzRfYXr1WClwhsum29qllxyjWYr8AV6ZtclaE
         vd2AVjxzqdt6Y3IZPV4llb4oJIIuI7wcJrIB+gdxjxrLn2BlmEs220lE8lTZOb6892yv
         ooKkzNnoVg7seKAZ12PYuJRf/yocgPmS08wQg0UwG2tZdc3rAWXsX82VgWyXHApIs98T
         n6qOJcbWE1AaDpd0egtQk7LL4tKRNwcshILK5FopwbYkuH0tgNagE6egH+a1YB1Lir5j
         cT0AGsMFEfMfLVpaSMpu/FgN/1YyRBFgxvbqcrZeesZqPmTFoxn1IzsmjxglP5zTzCoQ
         4RJg==
X-Forwarded-Encrypted: i=1; AFNElJ/ZbSakdlZl20FWKDHuc0YFaNiAwc/sGznxTOn5049kHcfmnCxOwPjBpqqeX/fP/VkGj7sy5rU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdsgyoLnSJx65TjWQOvLmQ/bS25wPLRYZaEZhdVOnnyYM7RwXZ
	M1uQ0qYmXkYI4fZqRsYsgczG1J2zuIi2Lg2BboWMvRkEHCKcgVmdw+YFk35qewvODAvvcpg/Kfs
	7zI3FiSdw3yaqyAUds8rTzbDf70OY4Ok=
X-Gm-Gg: Acq92OHNMf9MEjrbzmgw4R+D8SBlqJwPTurkbD4HKuSjThWTJCuNP4yRfOfm3lGSVp8
	atXsNXL30qruvm9tl1gSn6aO/9eFAh3SUfjTC60E6lNcDIfvngh+tUsC9187LNmxVs0Ii6xt49f
	uVyaO2xDmwWpGYpLDbuE+gHSIFODN9stszNv9Gw8oTz2C+E1FjabYTzZaJ+pVRbI4LW1uTUOfD0
	E2VPOBmeyCccvija7pd34UteGiRfBiZZsy3XTZX3kF7yEI+xbqfdzN9w93Gg5yTSYMazF17yNwl
	MjGkq7BxlX/Bj12tTjMji67ClTA/ld0vsXPpofph4QTSZETKZuc9SqOTuA==
X-Received: by 2002:a05:690c:f09:b0:7bb:712:a768 with SMTP id
 00721157ae682-7c959b92a05mr260964467b3.7.1779286385081; Wed, 20 May 2026
 07:13:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260520135034.1060859-1-michael.bommarito@gmail.com> <CABBYNZLLw=VFfjaF_TXA=5ZgDt7rw=XgUULoc4JudMpUBf_BWg@mail.gmail.com>
In-Reply-To: <CABBYNZLLw=VFfjaF_TXA=5ZgDt7rw=XgUULoc4JudMpUBf_BWg@mail.gmail.com>
From: Michael Bommarito <michael.bommarito@gmail.com>
Date: Wed, 20 May 2026 10:12:53 -0400
X-Gm-Features: AVHnY4Jw2SUIqejxTca-2HXdzAfWn9R-0elBcKvZqiV0qBvm6QtxRM6lQabcQeY
Message-ID: <CAJJ9bXw9r2XHYMkmjbJ9XAiGEG3VEWK6bjKHbHgwJqnOBzTu9w@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: L2CAP: reject BR/EDR signaling packets over MTUsig
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249940-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 2C1E358FB5E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 20, 2026 at 10:00=E2=80=AFAM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Weird, does the AI come up with this? The id is actually _not_
> important because the error code will essentially indicate that the
> entire packet was rejected. Therefore, it doesn't matter if the id is
> for a request or a response, it still needs rejection if it exceeds
> the MTU, so this seems overengineered.

Yes, and I debated this with Claude, but it convinced me that the
lifted helpers were more idiomatic for the actual spec and bt system:
"The identifier shall match the first request command in the L2CAP
packet. If only responses are recognized, the packet shall be silently
discarded."

So if we ever lifted or refactored the code, it would be abundantly
clear/safe to reuse elsewhere.

There is also much shorter version that just peeks skb->data[1] and
exits early if not ident=3D0 if that's what you're going for.

Just let me know what version you prefer.

Thanks,
Mike

