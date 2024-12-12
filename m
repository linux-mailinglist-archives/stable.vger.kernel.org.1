Return-Path: <stable+bounces-100866-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D4269EE26A
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 10:14:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3DC3281A63
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 09:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D796920E305;
	Thu, 12 Dec 2024 09:14:47 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EB1A20E318
	for <stable@vger.kernel.org>; Thu, 12 Dec 2024 09:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733994887; cv=none; b=LYoJ+TI/JTXnWtWzs+K5SLYWz3Q0RT/xDZ/4PSyceD9V+pcEqU9nsBpXSwzvPC0yBB97W6ZmAk3yx8FB9CudAViK4iK5Dc+XVVJVPXVfMVe0KVsjBYVtZAcZTxfra/fsG4/FjY0kf42HoybowGH3ScXlRrPY+WFhZs0WMXZNFDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733994887; c=relaxed/simple;
	bh=1uG3AT+w+KMD+eDdASAVXbxw5+buL6T48QnEG/Ye4ZM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=f0CWhVQl69eh6Z6I2x6RKwe+/I/RJoqh57bnkKYANmKwiqRHZxmjHTOm+EKHyIGE/P4HvbmNZbo2dSjlKQUWeZI78pnU3NF4QrZANacJPbZZaHM31TwBMnqSlAl+m2mILyFW2ER/KfaTSQmVzvUQuaomWRRAD/EawrMXS13u3a0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
From: =?utf-8?Q?Ulrich_M=C3=BCller?= <ulm@gentoo.org>
To: Jiri Kosina <jikos@kernel.org>
Cc: WangYuli <wangyuli@uniontech.com>,  ulm@gentoo.org,
  helugang@uniontech.com,  regressions@lists.linux.dev,
  stable@vger.kernel.org,  regressions@leemhuis.info,  bentiss@kernel.org,
  jeffbai@aosc.io,  zhanjun@uniontech.com,  guanwentao@uniontech.com,
 Dmitry Savin <envelsavinds@gmail.com>
Subject: Re: "[REGRESSION] ThinkPad L15 Gen 4 touchpad no longer works"
In-Reply-To: <687qoq24-o1p4-519q-1r8p-s59680noorq3@xreary.bet> (Jiri Kosina's
	message of "Thu, 12 Dec 2024 09:56:17 +0100 (CET)")
References: <uikt4wwpw@gentoo.org>
	<7DAFE6DAA470985D+20241210030448.83908-1-wangyuli@uniontech.com>
	<687qoq24-o1p4-519q-1r8p-s59680noorq3@xreary.bet>
Date: Thu, 12 Dec 2024 10:14:38 +0100
Message-ID: <ucyhxs1oh@gentoo.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

>>>>> On Thu, 12 Dec 2024, Jiri Kosina wrote:

> On Tue, 10 Dec 2024, WangYuli wrote:
>> Thanks to Jeffbai's reminder. And I apologize for the late reply to the =
bug report
>> by Ulrich M=C3=BCller.
>>=20
>> He Lugang has left our company, which explains why he hasn't responded t=
o your
>> emails as they were sent to his old corporate email address.
>>=20
>> As his good friend, former colleague, and one of kernel maintainer for a=
nother Linux
>> distribution, I understand the urgency of this issue.
>>=20
>> I'm currently testing with the affected hardware and will provide a patc=
h soon.
>>=20
>> Regarding the temporary workaround for Gentoo, while reverting the previ=
ous changes
>> is a viable temporary solution, I'm committed to providing a more compre=
hensive fix
>> that supports both Lenovo ThinkPad L15 Gen 4 and Lenovo Y9000P 2024.
>>=20
>> Thank you all for your patience and understanding.

> Thanks for looking into this. I have now queued the revert in=20
> hid.git#for-6.13/upstream-fixes

After the revert, there are now duplicate entries in hid-multitouch.c
lines 2082-2048 and 2085-2087 ("Goodix GT7868Q devices").

Maybe this should be fixed in a follow-up commit? It looks like a
copy/paste error in commit c8000deb68365b461b324d68c7ea89d730f0bb85.
CCing its author.

