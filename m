Return-Path: <stable+bounces-238594-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id vOWLNtml42k1JgEAu9opvQ
	(envelope-from <stable+bounces-238594-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 18 Apr 2026 17:40:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3975F4217BB
	for <lists+stable@lfdr.de>; Sat, 18 Apr 2026 17:40:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3B819302D0A3
	for <lists+stable@lfdr.de>; Sat, 18 Apr 2026 15:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F12B2E8B83;
	Sat, 18 Apr 2026 15:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GmnlTe6G"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B03D1142E83
	for <stable@vger.kernel.org>; Sat, 18 Apr 2026 15:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776526804; cv=pass; b=FYcczz4uwVH292lNW3sd6EqyefaSvpQ0KRYdvbX56eklu6lSaIadaeSeiXngpUXQslWdylby69/gtzplzkptCeoXg4DXsHUaj/Yrw9SR2CqXceBq1vQK9mYL7Kft32Jx6xN1ak8rB5hUSUTIYp32ZCsl1TC7ZihDsw5uQCLDfUo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776526804; c=relaxed/simple;
	bh=cEvYDuFXuVic9scYpdvaU/f/zI61Ha5D07vebOF2hUA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MjeefHt4j/2aCWA8KGRMFqEY9QC4DaXvb0TMaC19Wk/sUuIIaXLJ2QgbPcb/GX02s5BVdRkoIjE3Gbw1x42TvFfFiY03Ai1KxyzkjKLQAuy7IvEZSpHorE5moBLLcXX7R2s5Wnkn/Sg61AO1RIKztL4KuChG+Fx22Xlwdi4LCaY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GmnlTe6G; arc=pass smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-66b2d49ffb0so2169558a12.3
        for <stable@vger.kernel.org>; Sat, 18 Apr 2026 08:40:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776526801; cv=none;
        d=google.com; s=arc-20240605;
        b=eZr+XefOUSWGVytNfw0GzQbPO0/ShEOrkUzpyBRmFx1STVpjqhy1IyN/0p9XBBsG1C
         YQmzrxYHYMOHdBg6HHZROd0gmUv5X4zNQ8mU5l8jxqNX5Twmc2GBaXgbKiMmk2Kn++ad
         RN9G/TRosd+zrLCMI7GjJfDuP7RFvxGbacxLK3TvIDFCM/li27xjRvA+okiy5MqrEetQ
         d/d0IL6gyLCfnFwnIvyowOGwgXuHpfehh/1n1DSFbqX/U31Yn67wEzYXK4AWYLp/0Eyh
         UAeXwUZIs5q+WmOSxpN9bCQEJ/S0wko7+IjRtMEGd46g1WfzSKld8MMeUsK7dKE9V4Uy
         XHYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cEvYDuFXuVic9scYpdvaU/f/zI61Ha5D07vebOF2hUA=;
        fh=GuNIVzhUMQmha5TzvnEl4+Xa9nRnTAGWe825gxaqN3c=;
        b=D7rHqu+HHoMrU9A1e1wj3Ff89U3xKJbFsnLG43r9JkTEVRQ7D6Lyph+N9UFZRqSqlO
         NJ5izKQsdG85H6NGPifeN/Y5CsTN2DCQRaLuFiMm62oIbJEmNNcBl8m7ACzbKUli05RW
         JTK6AxeOnMolBQ0H86OzZv6CvyafGVA+Q3XCbwtN3eSY3VUibY1r4xIvPgYHcnId1tN5
         wo69M2B17Oc1tmVsOkQI5Gd/GcaC9lUqLF2q+WvcbvMDuF4FVc5r4PRnE1jivINJ6ONG
         hASZQyST0JA8ON4BjTWY+bjsXrLs8ZzBo5oNACCOHO6DW369XF4BOYVtK8nGYGxte4N4
         Zn7g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776526801; x=1777131601; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cEvYDuFXuVic9scYpdvaU/f/zI61Ha5D07vebOF2hUA=;
        b=GmnlTe6Gt7g3mzOQJ3eMbzSphORZe47kZXX05KSaCBXAkhnxOaW6lpXZMabnSySTC2
         S6PzjSDN7oViDfAES1IdHkJ6Gkg74uEIu9BTRqtgAFww/ILi5Shag42ZjiEeZyoMMrMv
         GT6gNnKPyP6Ly8xBjQ+sUIgA/z3MeEhbzsr3KNxP5FAq+KUK5nxQu8vStidreIWEkUTS
         0cP7ewpgut8blDQ76qVl+sSap+wFHWaSe7gqfFGVeRBHvTEoeG8tUv7+Fte4o954cyWU
         NBEVmhh2DF3MZxVVD4AUoGunI8KPRZWg11narsSYaG3qXUmg3Z9dq6tcSqoUr4WcSIQw
         zFjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776526801; x=1777131601;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cEvYDuFXuVic9scYpdvaU/f/zI61Ha5D07vebOF2hUA=;
        b=MbFY1Tw+6jSUpwDG2J2q0YAjc6FeocoLcu729XIzbCKmjebXY0tB/30+jCmXY/idBv
         6EZ1eIuIlDzR9hpgNgUvB1WF2yvrQrXuzXeTtUttAQLIka1D4o7q64KUkBitI+S1tEK0
         5xa37auG6r8b/61G37yhcKWiFiQVOLAzczBAUiCq/1oLJLf7FtOL+HZXb9AmeZsMDx39
         zlEdBEhj9XH2DbLtMheDRJ4IpwztxByZ139wvwag9u7xwVSfaxx+q/u8EAfIDABeQpvf
         tncbUcRC1IKEnuaX6CJtRQWvllFKzqy2pGgbInbI5xOGs4WjN/476/4d4e7zrSC9eNeE
         C+UQ==
X-Forwarded-Encrypted: i=1; AFNElJ9HicKJzjrpuqWXPBjF47+VgzCGDVV0JV4lH4siWUjVNzqceXMkajm+6idUb41A5mz54l+vH+M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnxcUxBInnsjvTvlkt5wt0URL96ELuCMIJXGgdD2Kx3wCKDTrD
	qDobVBL1QF4SkTi2s+T9mNhANJe99ll1PG++ZyhcAFh0kkhn0jEHHCCnlUhFpH8ZkRLVILBAit+
	4uDdBgOmDy86WzjkPWphyo4kPZL2fIAk=
X-Gm-Gg: AeBDievG2nT3x2w8egjI1z1rOumej3YFodpev6EjUOpqw/mWHNtSZ0zHPiI49MT30uU
	z8H+N9CPlDIANJoY3AK9LSQW4uQCU0cauDAXNiMJj53GN53Fkgj1QhkOfaE9DeF3H2Ni5yYFla2
	qr/KyiwWy/Akrle3ygtaLhvHHSx1E/CTw7UAnzuB8Ykk/Gj3lSpQAzEJDDJo33VOGiOCPtJ9LOI
	x4IHl1IN63QR+RXvLDn8yvxfEt+YHXljRYTxoPbl6C1zKrlfpvGUvRe9pvtgy/yqdQ8XkLLA6Bk
	+fHxO/36KZUzuC77xPhEPUvAEnyecMDlaDNdRi18d1rPkUuU
X-Received: by 2002:a17:906:fe45:b0:ba5:7cce:979f with SMTP id
 a640c23a62f3a-ba57cce99dbmr117469966b.40.1776526800916; Sat, 18 Apr 2026
 08:40:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHWLEDHfXZScF5jNDzgOxGXf-MBDcVNtqW0DbNz8Ra8rtcuL+w@mail.gmail.com>
 <CAOdxtTbwipkyAfDakLAB6aVp6YkPWtKpDdVDUTz88WDB-18HXQ@mail.gmail.com>
In-Reply-To: <CAOdxtTbwipkyAfDakLAB6aVp6YkPWtKpDdVDUTz88WDB-18HXQ@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sat, 18 Apr 2026 17:39:49 +0200
X-Gm-Features: AQROBzCvSbGA03ROsg6cVMJlbAynfy2yIZAnavXEgKUY8bnKpwlWeH4xlKzfKLE
Message-ID: <CAOQ4uxhUn6oCBuVJqZu+FcMx8XeAQHZbXFAGon4Xeg2SPLJW_A@mail.gmail.com>
Subject: Re: [REGRESSION] Return change in 6.12.80+ with volatile mounting
To: Chenglong Tang <chenglongtang@google.com>
Cc: Derek Taylor <ddtaylor@google.com>, stable@vger.kernel.org, 
	regressions@lists.linux.dev, Kevin Berry <kpberry@google.com>, 
	overlayfs <linux-unionfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-238594-lists,stable=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[amir73il@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 3975F4217BB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, Apr 18, 2026 at 1:33=E2=80=AFAM Chenglong Tang <chenglongtang@googl=
e.com> wrote:
>
> CC Amir,
>
> For example, containerd 2.2.0 uses `volatile` instead of `fsync=3Dvolatil=
e`:
> https://github.com/containerd/containerd/blob/main/core/mount/temp.go#L91=
C1-L92C1
>
> On Fri, Apr 17, 2026 at 3:41=E2=80=AFPM Derek Taylor <ddtaylor@google.com=
> wrote:
> >
> > This change seems to have so far affected at least containerd in an
> > issue reported here
> > https://github.com/containerd/containerd/issues/13250.
> >
> > In stable versions 6.12.80+, commit
> > 6c0cfbe020c0fcd2a544fcd2931fbc366ee3cd12 with the specific change
> > being:
> > [*] The mount option "volatile" is an alias to "fsync=3Dvolatile".
> > In this scenario, code relying on checking "volatile" will now fail
> > due to the return being "fsync=3Dvolatile".
> >
> > #regzbot introduced:v6.12.80

Hi Chenglong,

Thanks for the report.

Is this problem in production containerd or in a test suite?
I did not understand the purpose of WithTempMount().

Is it possible to fix this function to use string.Contains() instead of
exact match to the "volatile" mount option?

If needed I can fix the kernel to show the legacy "volatile" option,
but I would like to first understand how bad the impact of this regression
is on real production workloads.

Thanks,
Amir.

