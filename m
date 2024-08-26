Return-Path: <stable+bounces-70122-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47F8D95E63B
	for <lists+stable@lfdr.de>; Mon, 26 Aug 2024 03:23:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A25A1C2090A
	for <lists+stable@lfdr.de>; Mon, 26 Aug 2024 01:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3591D7F9;
	Mon, 26 Aug 2024 01:23:33 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from herc.mirbsd.org (bonn.mirbsd.org [217.91.129.195])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A647E6
	for <stable@vger.kernel.org>; Mon, 26 Aug 2024 01:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.91.129.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724635413; cv=none; b=Z3HVToyA6LATzddSkR3aYNz+hvNRwwzQELlU2vkMTJI7q4y0ifsZrApz8MMz1rGt2h5dL0sGe2Pa1ryKs6td6rKaZJcDAsJEo+ZSvDJkqe5pBzwALzHW7ACpJE/OKb734ix6OT3mxGfhlbZFNrvTIyDb60sTLofpzy8+M8F8Doc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724635413; c=relaxed/simple;
	bh=MBWmttdRK7NTTI+D9loonZ5t6n5yWYakyjBU7lXvLGM=;
	h=Date:From:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=e1DXj4mGSjc+8lLNxZTlPAUYLsG9PFfWL2hho0V7QX6DGRIEE/D5i1vj/P8wwlEAKrYrakILnR8+cyl3dmv3Hs85iB/4PAzMzJT+ypVgDSmNrY3mI6Igy3mWlUryDp4CJqdhJ4TWvvJfxYmy8sEb9lTkAI0GGqNvCDjAxUnQztA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; arc=none smtp.client-ip=217.91.129.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
Received: from herc.mirbsd.org (tg@herc.mirbsd.org [192.168.0.82])
	by herc.mirbsd.org (8.14.9/8.14.5) with ESMTP id 47Q1A8vD000720
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 26 Aug 2024 01:10:16 GMT
Date: Mon, 26 Aug 2024 01:10:07 +0000 (UTC)
From: Thorsten Glaser <tg@debian.org>
X-X-Sender: tg@herc.mirbsd.org
To: stable@vger.kernel.org
cc: Laurent Vivier <laurent@vivier.eu>, YunQiang Su <ysu@wavecomp.com>,
        Helge Deller <deller@gmx.de>
Subject: [proposal] binfmt_misc: pass binfmt_misc flags to the interpreter
Message-ID: <Pine.BSM.4.64L.2408260104111.16173@herc.mirbsd.org>
Content-Language: de-Zsym-DE-1901-u-em-text-rg-denw-tz-utc, en-Zsym-GB-u-cu-eur-em-text-fw-mon-hc-h23-ms-metric-mu-celsius-rg-denw-tz-utc-va-posix
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

commit 2347961b11d4079deace3c81dceed460c08a8fc1

I would like to propose this commit from 5.12 for stable,
or rather, ask whether it=E2=80=99s a candidate and leave the exact
picking/backporting to the experts (if it has other commits
as prerequisites and/or later fixups).

This is because qemu-user needs it, and it arrived just too
late for the current Debian LTS kernel (5.10), and qemu-user
in Debian until yesterday had a workaround, but now doesn=E2=80=99t
because it=E2=80=99s in the stable kernel (6.1), so qemu-user-static
cannot be just used as-is on Debian LTS any more.

I=E2=80=99d like it to be applied to 5.10 (obviously), but perhaps
others would appreciate more broad coverage.

Thanks in advance,
//mirabilos
--=20
=E2=80=9ECool, /usr/share/doc/mksh/examples/uhr.gz ist ja ein Grund,
mksh auf jedem System zu installieren.=E2=80=9C
=09-- XTaran auf der OpenRheinRuhr, ganz begeistert
(EN: =E2=80=9C[=E2=80=A6]uhr.gz is a reason to install mksh on every system=
=2E=E2=80=9D)

