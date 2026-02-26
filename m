Return-Path: <stable+bounces-219872-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eCGyDtzWoGl0nQQAu9opvQ
	(envelope-from <stable+bounces-219872-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 00:27:24 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BBE71B0E49
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 00:27:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E32343020994
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 23:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C2FC32E727;
	Thu, 26 Feb 2026 23:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cMRmdk/q"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 076A132AAD3
	for <stable@vger.kernel.org>; Thu, 26 Feb 2026 23:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772148439; cv=pass; b=oSpIH6JHHpPmaxQCksHQa/fnAi9nv2FUnDF2meQd1mLTs8qplvtHuP2ScHbVUje3iOKEUNkN0amy5y/+FA551R7hpP2jVGVXLmzzkcpCKJ6cuB7WR/s84WrL2P4F6NoOxS9pO7tv6bOlp4e277x8euuAXKVOgYT283Ldb0x/ZBk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772148439; c=relaxed/simple;
	bh=V6ccR7OJWFg21dBkQIXawIBB+RMwmgb7a4hCFkrEjNU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u7+Rmhz1+0PZ9yP4LvNkg0qiWhLFTZCNkfOFbeFMUvwow59bKUDyskBsAFEO9grkt0rmbfQZM8KM65A+/iU1YOeDqQbuy6gVNllJl/LuABXO+n7GRHiwtZq83rNaNmCbQFPcWDI7wDPkx4QeYSWrbCHCW+rNKRdaps8l10mjBJY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cMRmdk/q; arc=pass smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-5069df1d711so12236181cf.2
        for <stable@vger.kernel.org>; Thu, 26 Feb 2026 15:27:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772148435; cv=none;
        d=google.com; s=arc-20240605;
        b=PRxS+BBOLsmXx/aKEGprTOHrpwEWotvx3AOD+yhCPtAWGI6wqOJc+KvYoR5jPTMyYM
         7WoCbcZBofwCro+hnHmrj/eDpHrjp4dqztp/gjmYa59Y8GbdmUWiBc0bVpjAKGq0FkjI
         w5E9NES3Ff/nf+sy3DGTLN4TxJL7RQK2nrpVW91w3Ye8mddOr/ysWGQykWJ8rWBxgamT
         uTPUWxBp4PRoVDJkkoIIwRM+HGK8T4zBtrOd5eLxtsV788o0AHsV/PpIsaqzH4X+WrzD
         LuHJIrE5omEdsdBXXN4YVwnq1QmTrzNSH7tU6u2g64JV8s1tGNi4xiYGJ0LRtixmCyg9
         y2Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+C13fuesOQsGWYIE+DwAPg3HyJpgm/lMqzmvJkG5mdQ=;
        fh=OX7HWIXxEAkcnAZJCFsLH0iXval9N/xmwY4omvIjxdQ=;
        b=gq/2YcwoomQf7zgYR3AuzxTjYjlJqT4yMNo0Z0SG6vaXDTOUKCOae2w+9/VlkClugw
         C7GnXxh8wzx+tQYn+thsC6IBurDHG44ymLO/bauC3bOPpcZLglDxWWAOKixJf3rf1uk5
         j2J5mZO2qBrSFhTecDVPvqGi7JAxlaqlg7+Ojknsv0Q0iAWWuuJkTVg81fJuIRRHrkRL
         ocZ4AIYknlhQPebnWsw7h2oz3QV4Xh+IYhsHVSMNH5BPsUi50Y8dvwtX7aKI8chi64Ig
         5YFgleMsc/sQE1dpzT75RNFJHixsrGEcNHZetuMjg+pXfT9b4wvSS69Q6jnlMN4zf3vh
         LWyg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772148435; x=1772753235; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+C13fuesOQsGWYIE+DwAPg3HyJpgm/lMqzmvJkG5mdQ=;
        b=cMRmdk/qtlmb+H3vUoCi0vXZCBtBxPP9FHDmj1G8xxh60UwRUOhaPzdX7H1r24ZqL5
         PWBiCm8RknssLKeK+3DdyHaFE0NHcS3hVunLYTJoeEgL8Nax33N6LMmlpAwOLT7o7+mS
         DE9V4WFbYtcUAsO9ZhHgkkItAv3McCW/zwzWXUNRm6sC4db3rj/wjnlGVY3ZxZdRb5lb
         xQ5VW/LcahTeKbZd7FBDfPXMbngBX0Dc/CgIQR3DZ4VJ434GJOOkuwmy7mfN+wCQFMlv
         unv5d8a1yhy1eYiXV6ncgN1pLNVJbr4qnE5iZqNTgNmiykq28GAWT/j7d0vgmnV+V57p
         Kehw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772148435; x=1772753235;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+C13fuesOQsGWYIE+DwAPg3HyJpgm/lMqzmvJkG5mdQ=;
        b=BGCREh/Z8ZN/fQGAUou3Js9HBw5pDhPcHtF53f5ZKQRlQuJleeWCLfs02vE8g6tC5+
         wYqWXTpS6wSdAmZxjlsOK0Kxariaka7jc1qx9nzoSLczOyoUrXaIBgYdskgMowBEGeW8
         kQqMZ41B3IpFWbM1PGRLoMOsF4gY/2qsBdih4M6r8yYgMMA+PW6BFoS+nW4ODJ/P8F4+
         zv4hTWQHESRJil048bO5a81mBfLgTNO6Z5ECWFt5zE4yZxaNbmr8mIa1k2X680CCIUrh
         /zweI859el1W4t4yD0nnEx3JB9DdGjvp0duOXO+mSk8xa8VIJp7q010kRj2iyjYmgxc7
         h53A==
X-Forwarded-Encrypted: i=1; AJvYcCXyWdcOM9H7KPm3v8t89Fu+TFqZcS8zKcZ3MXgycAfyd5A0TmOJJzVwbkdZ4Qlos/P4cw+V1u4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/+oVS0dl6fTXMbSbFuuXwcNFsmAvp4dzWuJuux2jKH/GLPKXw
	Y2qWZM+em04mEpjrBbAYKOnP20cI88wApSr86D6z8VmHUWQeYIuwOlXnouwsL/TS3J0eck4LSa3
	4TjmJ0PF+0dOKs9JfQXtgM9gYjUa0WGM=
X-Gm-Gg: ATEYQzyOHvCz3Kmt94EdwvLBLuDdAGFZWJEbi2w0GGKuhQPLY20eFVEKosl+wDddkL/
	FVNEoKH0tj2/KLhQhUsJTv0CpBwKDgnzzEfyMW2BRD1jwAyaGBea6g4BZXQOzmjOaypj/m4yTaQ
	XM5NWFYwrQwQPiEVwYqntiTKW6W6GVKHNBo7XU8USNFxyebAs3shfm1Xa8pZLXWcQY37RjVb8LS
	whG+DNjph4fqZkVXicNP1vAuAXsGUicB8edkvxiMelQXKy0ixarLE37MBZ2D5mhfV+Iz2w8ySQl
	9IMycJHHSWM/13StCncTWzmSivh+mUzHjD2O8yfNbWkLL/e9ig2C3F5QojA16wzobNZAixxuA3M
	xDjL4pOog/v8jlY5kAGV5Lmd9he9cX6bdAea6rlXoYC3QPGNuL/cT9SaWuRY=
X-Received: by 2002:a05:622a:14d2:b0:505:e448:1b0d with SMTP id
 d75a77b69052e-507526bcc0fmr10524131cf.10.1772148434610; Thu, 26 Feb 2026
 15:27:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260226212845.784172-2-thorsten.blum@linux.dev> <03d69afbe9fa3ec36dc39d6864a97b35@manguebit.org>
In-Reply-To: <03d69afbe9fa3ec36dc39d6864a97b35@manguebit.org>
From: Steve French <smfrench@gmail.com>
Date: Thu, 26 Feb 2026 17:27:02 -0600
X-Gm-Features: AaiRm51wPI5Op2zWvoWmQOWUXDQJX1JkcBIS0gDMA-jQaYOqTDy0vzpeGhzagAM
Message-ID: <CAH2r5mtubVce+VgPaQqZLx8m+uW6cJxGDqBVqpSu-pTVgd06FA@mail.gmail.com>
Subject: Re: [PATCH] smb: client: Don't log plaintext credentials in cifs_set_cifscreds
To: Paulo Alcantara <pc@manguebit.org>
Cc: Thorsten Blum <thorsten.blum@linux.dev>, Steve French <sfrench@samba.org>, 
	Ronnie Sahlberg <ronniesahlberg@gmail.com>, Shyam Prasad N <sprasad@microsoft.com>, 
	Tom Talpey <tom@talpey.com>, Bharath SM <bharathsm@microsoft.com>, 
	Jeff Layton <jlayton@kernel.org>, stable@vger.kernel.org, linux-cifs@vger.kernel.org, 
	samba-technical@lists.samba.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-219872-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linux.dev,samba.org,gmail.com,microsoft.com,talpey.com,kernel.org,vger.kernel.org,lists.samba.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[smfrench@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,linux.dev:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,manguebit.org:email]
X-Rspamd-Queue-Id: 5BBE71B0E49
X-Rspamd-Action: no action

Added to cifs-2.6.git for-next pending additional testing (also added
the Acked-by)

On Thu, Feb 26, 2026 at 3:41=E2=80=AFPM Paulo Alcantara <pc@manguebit.org> =
wrote:
>
> Thorsten Blum <thorsten.blum@linux.dev> writes:
>
> > When debug logging is enabled, cifs_set_cifscreds() logs the key
> > payload and exposes the plaintext username and password. Remove the
> > debug log to avoid exposing credentials.
> >
> > Fixes: 8a8798a5ff90 ("cifs: fetch credentials out of keyring for non-kr=
b5 auth multiuser mounts")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> > ---
> >  fs/smb/client/connect.c | 1 -
> >  1 file changed, 1 deletion(-)
>
> Acked-by: Paulo Alcantara (Red Hat) <pc@manguebit.org>



--=20
Thanks,

Steve

