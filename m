Return-Path: <stable+bounces-215669-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iENEHek+i2mfRwAAu9opvQ
	(envelope-from <stable+bounces-215669-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Feb 2026 15:21:29 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 12EA411BD4D
	for <lists+stable@lfdr.de>; Tue, 10 Feb 2026 15:21:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0FC8C302E7A9
	for <lists+stable@lfdr.de>; Tue, 10 Feb 2026 14:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 302A7366827;
	Tue, 10 Feb 2026 14:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J03qPu24"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E56CF329E75
	for <stable@vger.kernel.org>; Tue, 10 Feb 2026 14:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770733224; cv=none; b=RhUXuPdzF/Q35CyNMHTKrJwD5dUSfKF/+glHNEgvItHEKi4fZeoQEf8RiGu6PZ4axpd78op24trIyLUpF5KJE+2yOQ0EnoMSgRYlQQiCAoFVAptQAlAxKJh1Zglvv8ZDehViBPjs8y3I9dPg0v6sH4Wv8lnBK3k2TlQGLDmAbHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770733224; c=relaxed/simple;
	bh=azL0Aj35JiZcLXEfdlN9GsFknlQL0wHI+36vWv/IGPI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o01IbQeQDHKTT6+qyq1qlnEAEskxVbuMJEGXZqYfAzvGpnKuHLrgbhyTi3frT9chFxuKV++MJCwbiwaCPpPChtPm9uYaTvxbto6Zzax6319d7hRZ8mCLS0jDsc5cpOMbnADOFLPPu5ObnDLvOwTf4LX9F0eIvd5i3SI1p6YaDE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J03qPu24; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A16E2C19423
	for <stable@vger.kernel.org>; Tue, 10 Feb 2026 14:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770733223;
	bh=azL0Aj35JiZcLXEfdlN9GsFknlQL0wHI+36vWv/IGPI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=J03qPu24TCvKbpnzosG1SnHPqnSqgtiNCkQl7/4QqzFNDOc6ZQtxP1BqMVnJqxvVG
	 A/uV4rMFNPy5MK3P0WWHDhBcgNMYIPlhNZvv0xFO1Mhdm0GzQ+r14YDgqE6W5xmuIA
	 yrqESZKX8fqpPHP0JGbyg0rP5znIPLqIJ5txflJzOVJLzrCMGwziuhBMCrSXcMVBfw
	 LnpbGPbCT76e3R3Ek46YkLxLrbCq0l65u1qOwvj/dxzkIlktGLQ/vvCbN7wdDqR+y4
	 to0/Hm2kHWPKVIIFXT6miz9T2Dz9wywithZWs/lkzdaUsjrJqyYTjYjohxXDHAswsu
	 MPMCLs1kDshXQ==
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-409521ba360so537129fac.2
        for <stable@vger.kernel.org>; Tue, 10 Feb 2026 06:20:23 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXZcpTEC5/jABxCO5L6/3r9gNRmW4v5rEKCJ7PBosYymRssJORfbQMRnnyHBl5Px1QdlDviMek=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdFIUsU6E/DUvW/Hr6f+jZA5gQTncvDli87UyQmQL6xKdrNxko
	H+suOCsKX2BTeIN2HMQq4yF1RTFW4iVtryioRSa+niUTRVkVkTo889A/CZkxHj+BGJ/2qWv/zoK
	+K4/jiwMjLt9UfBKdlO6vKY6Wl18B3ec=
X-Received: by 2002:a05:6870:ed8f:b0:409:8169:b40a with SMTP id
 586e51a60fabf-40a96fa3a98mr8130640fac.59.1770733222686; Tue, 10 Feb 2026
 06:20:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <006601dc965c$afe30280$0fa90780$@telus.net> <20260210093321.71876-1-luoxueqin@kylinos.cn>
In-Reply-To: <20260210093321.71876-1-luoxueqin@kylinos.cn>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 10 Feb 2026 15:20:11 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hW3xRnDz2DzHQBXacD8DoWdbOWGsn0J+A3ByFXy7-fZw@mail.gmail.com>
X-Gm-Features: AZwV_QgUTDZFh5OwoKC6wIYTWQzj-ayWYyh56KdYGoGBO2TYtIYCkdNEyfNUDtI
Message-ID: <CAJZ5v0hW3xRnDz2DzHQBXacD8DoWdbOWGsn0J+A3ByFXy7-fZw@mail.gmail.com>
Subject: Re: Performance regressions introduced via Revert "cpuidle: menu:
 Avoid discarding useful information" on 5.15 LTS
To: Xueqin Luo <luoxueqin@kylinos.cn>
Cc: dsmythies@telus.net, christian.loehle@arm.com, daniel.lezcano@linaro.org, 
	gregkh@linuxfoundation.org, harshvardhan.j.jha@oracle.com, 
	linux-pm@vger.kernel.org, rafael@kernel.org, sashal@kernel.org, 
	senozhatsky@chromium.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-215669-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 12EA411BD4D
X-Rspamd-Action: no action

On Tue, Feb 10, 2026 at 10:33=E2=80=AFAM Xueqin Luo <luoxueqin@kylinos.cn> =
wrote:
>
> Hi Doug, Rafael, and all,
>
> I would like to share an additional data point from a different
> platform that also shows a power regression associated with commit
> 85975daeaa4d ("cpuidle: menu: Avoid discarding useful information").
>
> The test platform is a ZHAOXIN KaiXian KX-7000 processor. The test
> scenario is system idle power measurement.
>
> Below are the cpuidle statistics for CPU1. Other CPU cores show the
> same trend.
>
> With commit 85975daeaa4d applied (base):
>
>     State   Ratio    Avg(ms)     Count      Over-pred      Under-pred
>     -----------------------------------------------------------------
>     POLL    0.0%      0.10         68       0.0%  (0)      100.0% (68)
>     C1      0.05%     0.82        187       0.0%  (0)       61.5% (115)
>     C2      0.0%      0.50         23      30.4%  (7)       69.6%  (16)
>     C3      0.01%     0.59         35      37.1% (13)       62.9%  (22)
>     C4      0.24%     0.65       1092      46.9% (512)      50.0% (546)
>     C5     81.88%     1.45     169745      52.7% (89450)     0.0%   (0)
>
> After reverting the commit (revert):
>
>     State   Ratio    Avg(ms)     Count      Over-pred      Under-pred
>     -----------------------------------------------------------------
>     POLL    0.0%      0.09         24       0.0%  (0)      100.0% (24)
>     C1      0.03%     0.44        222       0.0%  (0)       57.2% (127)
>     C2      0.01%     0.44         50      20.0% (10)       74.0%  (37)
>     C3      0.01%     0.49         43      25.6% (11)       60.5%  (26)
>     C4      0.15%     0.52        875      45.1% (395)      41.4% (362)
>     C5     97.1%      5.30      55099      13.9% (7645)      0.0%   (0)
>
> With commit 85975daeaa4d present:
>
> * C5 entry count is very high
> * C5 average residency is short (~1.45 ms)
> * Over-prediction ratio for C5 is around 50%
>
> After reverting the commit:
>
> * C5 residency ratio exceeds 90%
> * C5 average residency increases to ~5 ms
> * Entry count drops significantly
> * Over-prediction ratio is greatly reduced
>
> This indicates that the commit makes idle residency more fragmented,
> leading to more frequent C-state transitions.

Thanks for the data!

> In addition to the cpuidle statistics, measured system idle power is
> about 2W higher when this commit is applied.

Well, 2W of a difference is not good.  I'm wondering what the idle
power with the commit in question reverted is.

