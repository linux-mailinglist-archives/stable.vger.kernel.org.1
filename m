Return-Path: <stable+bounces-219866-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cIuGHjPGoGnImQQAu9opvQ
	(envelope-from <stable+bounces-219866-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 23:16:19 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D70A01B0424
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 23:16:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 58CDA3014132
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 22:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F65E1CAA6C;
	Thu, 26 Feb 2026 22:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KvJqZ1Nw"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 195DA2D879E
	for <stable@vger.kernel.org>; Thu, 26 Feb 2026 22:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772144176; cv=pass; b=eCFW3qmgc5ZWbUtVHAbreQEjoWsllPpprpPSW9cyXa0jkqRYUPij2VxzntxISoRi/gkUBbm4SPytyL4M5U+XXzl3qy02Fq/QtQBPlVYlg3M0NIwy8U5I7dZz09v0AUfv88N5pDSMRt1Ig+LMUskAY4bI8Y5KYX2A6tQ53QhwRIA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772144176; c=relaxed/simple;
	bh=ZcoyTpfA4HkjTXMAUaYrW0VbtT6k/vrxz+1C/FMe8oE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nJSgan2Tg/UesMZ2rNDIj0PLf/GqD38apI4tvewX+81kS5l11xd0bLptkjkzFv+puneSJk8icqJGOsxMMoKr+Gw22gJ7fFAXdSffP1hOAtcu3J8kpaNvqTkwYCrqSQt5csO3teMsCkwQrQZLlErxPyBMICGVLmXggQ75bJR+BCk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KvJqZ1Nw; arc=pass smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-2bddba6da0dso73601eec.1
        for <stable@vger.kernel.org>; Thu, 26 Feb 2026 14:16:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772144174; cv=none;
        d=google.com; s=arc-20240605;
        b=U9/vhYihbJep1QXWqIkWcIt5oTM37Ih7NgyQIxmiME5KQgiTaBYSar1m1hUc2mgfui
         tibjyTq8wpF9vqlhoJ1CDCh9FmTpSwCCpPPxJASNjlRmWoG5imjbh0del6EsjYuFf+1N
         ep9WPRQ3WbwBC7LqIcsK3tJRz2lS0wIvbpVhTwEco3D778z1j8LEZMmkU5FOPFoXHc3Q
         rzt8ndJHQuflsPvfUIvQuT3OiViwgLcMJeN1ELh3By0jKPP+VUzOIN/Sh0WLuGvAVKJV
         SwB5O4UzJsFvfQdG7kUozTrg0Ij9q2GtcFquWzh0Gp1D6FpSb40NQlCSZWAzCv370rUG
         l3Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ulP51Bq7VHIGjJJp/bP8DBPXzvEaSZ2JqDdZ8djCmiM=;
        fh=Z1xhKmJ+R28ysqzakwYATrrUgyJzYuaB/jNsSwix0Wg=;
        b=F2N6mIdg5UC0Kk8SVxGhZOmzFPkjef+XbVOUH9giu1H8tmv2Yc0jhhaRMXSytiELzG
         mtfv2lMmgeFickHN7XHn3lklztcJRneN9Y9ofC8y4EUZuiP62xB0tC5ixueBqsle6W0M
         1f1/kKxHGzoGj+Pehxkfo4O+Ls+BuuvZ9fTDmKWmgYosSwE2mE1NM0JyQSqKshOvGIt5
         9NL40uvY0ofCK+kGVddjcc48qua0qNnOGl7e02Eyqhievcy8fqj71DrxnKF65Vy3tzZx
         IzwgqlyQtDC3SEJ+5RoXERs5la+vpPyqMhq4sv7y5oYPloAw9CjSCoynD/2hG0b08Bc9
         xcrw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772144174; x=1772748974; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ulP51Bq7VHIGjJJp/bP8DBPXzvEaSZ2JqDdZ8djCmiM=;
        b=KvJqZ1NwwbSR3WBgLAxiHFpCmLZ2kqqVEbQsz0I7kJzRUVs95xYDDNxfenZ3MLqphN
         4c1i3j3LmW8CDTU1+C2gRsKK2ociTWWP85oqW3wjbvTRG4SIBPtMIaAYZ0lTPHFI2yfg
         CuMfEnvcuASBs+Lh5ag7mAlssRz8SJ9sT50JfS8XKYxrCB32L+6g4aifgPJw8OuFuQzA
         n8An5onzGWLHya3XoS6ILU+XAcWBmEqieqhdUCZwI8KK7cj9Bf4DytTyvpps0wSKTBLK
         7TpUW0BtidEyTIkyUrHWwU3+d0sQuPen3GW3DivZNOsLrx66gpCQ97/wJ7prRATGQeZ1
         uJRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772144174; x=1772748974;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ulP51Bq7VHIGjJJp/bP8DBPXzvEaSZ2JqDdZ8djCmiM=;
        b=C7XA7MVIY3IND0i8t/+wFZ/bub5pWrIcGhVIfXYaLSb7B602x/18ZMmX09Kz/8wvc7
         863UexlpmSmReOh5DjACptYJgMPjCT6D2JJGk8P9YzKUJGXopM3QDIoFn/0HfMwJ9csN
         DZT/jFTdCbYsvBhfi5tkg93CB1a2P1bUk/Qly5L3VgCCaQ+9ouj51OfjOBUWxIGa1l8r
         F6tFFMTLY1ryf7vKDkf4W4B2Vk+i3oN27/MbsJqGbL/nSH6vHIjOkTnBH36mBA+RQVFP
         bL9E/WJxGztbvXX7SqBFEzIyoV/lWBt3dhkkCrZVVN5LEb7OEmfM/ThkYtsUwbXHuOzl
         qStQ==
X-Forwarded-Encrypted: i=1; AJvYcCX6mbXrLRE+oNNJLsH/FXgkc6fbvXBwhB1zzHMrYWhLDQIO4n92go3sG68DDjnr3920IsSd84Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/2u/G8ZTrETGBH2yF3UFzYIGfPuAGNrdyH2q8JNZvoyZh0YUJ
	pqYy/SvXL03wpjs11mv5kYMRbY7ak+A15m93JyBYYN/9cZpe4Hkae5KyiuFaqTF82TkGRQTY6wW
	diHSdmms91MnDGvRlgnDBIaecNSOIZhQ=
X-Gm-Gg: ATEYQzwgNqS5N465D5kKcL0uhAbJ496ScVVlFTAzoCyBl8UqAxWak6hPyi+gQmYOWVz
	bzsElUvHnDoVoSDLBIsL0IyFGGgUmUgtZYWXNbOkOwXjGcfgWhL6GrSWs5/vPey02f4fBSdVk38
	W1DWxct5NCH1e/om6ND3G3bq6x3fMXl9d6NODuAIfBvlC7Uh20j4XS2FJX0kkK+ACc5hugc9/8Q
	BmFdg9U0frumNi4FJEzJWYeJjqZq7rN6PqZjgOhoylb1VVU9X+pgF65ol+59+CxkMiZuXuxmH0T
	J/9xJEr0P1QR6EvQQaQgeh2CrukDQ9Dqp7QeLECcEJWgq50fnZBQHREutLkw5+OYoBarzJBRCLN
	4uO9YpUolWTJvA7sa0AGwidw8i631
X-Received: by 2002:a05:7300:dc8c:b0:2b7:f145:a98 with SMTP id
 5a478bee46e88-2bde1b2878bmr169080eec.2.1772144173982; Thu, 26 Feb 2026
 14:16:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260225155341.094945851@linuxfoundation.org> <20260226201056.28728-1-ojeda@kernel.org>
 <2026022640-ranked-resigned-83a9@gregkh>
In-Reply-To: <2026022640-ranked-resigned-83a9@gregkh>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 26 Feb 2026 23:16:01 +0100
X-Gm-Features: AaiRm50fZ4_63VFBPIPEmyA0KTAsuRCj5482jErZ-4aNE-tCfX9R395x0A74Yd0
Message-ID: <CANiq72=MJOc5KVrzUaebHxLpHwFct8Xh9g25sHAjO9HBE4nS4w@mail.gmail.com>
Subject: Re: [PATCH 6.19 000/781] 6.19.4-rc2 review
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, achill@achill.org, akpm@linux-foundation.org, 
	broonie@kernel.org, conor@kernel.org, f.fainelli@gmail.com, 
	hargar@microsoft.com, jonathanh@nvidia.com, linux-kernel@vger.kernel.org, 
	linux@roeck-us.net, lkft-triage@lists.linaro.org, patches@kernelci.org, 
	patches@lists.linux.dev, pavel@nabladev.com, rwarsow@gmx.de, shuah@kernel.org, 
	sr@sladewatkins.com, stable@vger.kernel.org, sudipm.mukherjee@gmail.com, 
	torvalds@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-219866-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[21];
	FREEMAIL_CC(0.00)[kernel.org,achill.org,linux-foundation.org,gmail.com,microsoft.com,nvidia.com,vger.kernel.org,roeck-us.net,lists.linaro.org,kernelci.org,lists.linux.dev,nabladev.com,gmx.de,sladewatkins.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miguelojedasandonis@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:email]
X-Rspamd-Queue-Id: D70A01B0424
X-Rspamd-Action: no action

On Thu, Feb 26, 2026 at 10:47=E2=80=AFPM Greg KH <gregkh@linuxfoundation.or=
g> wrote:
>
> So should this be backported?  If so, how far back?

For the warning one (`unwrap_or`), the patch doesn't seem to be picked
up yet, but I provided the Cc: tag so you should eventually get it:

  https://lore.kernel.org/rust-for-linux/CANiq72mMS2EeU9ayDpm+xCz3xQyRBgRyW=
W8KKvJLAuCC64Xi3g@mail.gmail.com/

For the error (`COMPAT`), it should be backported to 6.19 -- I will
send a message to stable@.

Cheers,
Miguel

