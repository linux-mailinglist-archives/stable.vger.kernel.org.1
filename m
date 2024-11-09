Return-Path: <stable+bounces-92008-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA3D79C2DE8
	for <lists+stable@lfdr.de>; Sat,  9 Nov 2024 15:54:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D50C1F21AC8
	for <lists+stable@lfdr.de>; Sat,  9 Nov 2024 14:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09BFE1487DC;
	Sat,  9 Nov 2024 14:54:43 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 927C71991CA
	for <stable@vger.kernel.org>; Sat,  9 Nov 2024 14:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731164082; cv=none; b=VqszHenZF1kJ+FwF10y9LnsYjLj6YoQRHmNzWQiktPG10yYHfvGUOsrscQlzIClB3OCRdf6Mhdqe3LUxIJqKfkkWlr8LQcSm2TYuZ0Bh4ee1OzQEPflvEz3M4VRLvaySWJxFIBDvFUhU56PdpNLEmfbvkan/WMddMyJYZdp3tZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731164082; c=relaxed/simple;
	bh=iYifo8ZvWHr/K4r81W2teRDYrrpPR7lszO+IvzWuG20=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bXp6rMWk5engB97y0y5R00kPnWMDjezkCAZkEEPKxIpKb8Zfiu+lYv5CRvXgeuiGRl/miE9tZAbti7gGZgkRGLyokbbblGFhHTBk/qh/DAWHbB10AKWpFQlEPgVB/48jAPEjMDgoFz1/L2JHWoICzLrwI64fWpOwUFvi2ylrpaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
From: =?utf-8?Q?Ulrich_M=C3=BCller?= <ulm@gentoo.org>
To: "Linux regression tracking (Thorsten Leemhuis)" <regressions@leemhuis.info>
Cc: Ulrich =?utf-8?Q?M=C3=BCller?= <ulm@gentoo.org>,
  stable@vger.kernel.org,  Linux
 regressions mailing list <regressions@lists.linux.dev>,  He Lugang
 <helugang@uniontech.com>,  Jiri Kosina <jkosina@suse.com>
Subject: Re: [REGRESSION] ThinkPad L15 Gen 4 touchpad no longer works
In-Reply-To: <a4b1bae4-5235-4f19-bcdb-5ed9b67449b1@leemhuis.info> (Linux
	regression tracking's message of "Sat, 9 Nov 2024 13:42:21 +0100")
References: <uikt4wwpw@gentoo.org>
	<a4b1bae4-5235-4f19-bcdb-5ed9b67449b1@leemhuis.info>
Date: Sat, 09 Nov 2024 15:54:36 +0100
Message-ID: <ucyj4h2z7@gentoo.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

>>>>> On Sat, 09 Nov 2024, Linux regression tracking (Thorsten Leemhuis) wr=
ote:

> On 03.11.24 09:24, Ulrich M=C3=BCller wrote:
>> After upgrading from 6.6.52 to 6.6.58, tapping on the touchpad stopped
>> working. The problem is still present in 6.6.59.
>>=20
>> I see the following in dmesg output; the first line was not there
>> previously:
>>=20
>> [    2.129282] hid-multitouch 0018:27C6:01E0.0001: The byte is not expec=
ted for fixing the report descriptor. It's possible that the touchpad firmw=
are is not suitable for applying the fix. got: 9
>> [    2.137479] input: GXTP5140:00 27C6:01E0 as /devices/platform/AMDI001=
0:00/i2c-0/i2c-GXTP5140:00/0018:27C6:01E0.0001/input/input10
>> [    2.137680] input: GXTP5140:00 27C6:01E0 as /devices/platform/AMDI001=
0:00/i2c-0/i2c-GXTP5140:00/0018:27C6:01E0.0001/input/input11
>> [    2.137921] hid-multitouch 0018:27C6:01E0.0001: input,hidraw0: I2C HI=
D v1.00 Mouse [GXTP5140:00 27C6:01E0] on i2c-GXTP5140:00
>>=20
>> Hardware is a Lenovo ThinkPad L15 Gen 4.
>>=20
>> The problem goes away when reverting this commit:
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commi=
t/drivers/hid/hid-multitouch.c?id=3D251efae73bd46b097deec4f9986d926813aed744

> Thx for the report. Is this a 6.6.y specific thing, or does it happen
> with 6.12-rc6 or later as well?  And if it does: does the revert fix it
> there, too?

It still happens with 6.12-rc6, and the revert fixes it.

