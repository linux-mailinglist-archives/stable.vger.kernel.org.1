Return-Path: <stable+bounces-216722-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0DU9Om8/k2kg2wEAu9opvQ
	(envelope-from <stable+bounces-216722-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 16 Feb 2026 17:01:51 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D86E9145DD0
	for <lists+stable@lfdr.de>; Mon, 16 Feb 2026 17:01:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F15FB3007B97
	for <lists+stable@lfdr.de>; Mon, 16 Feb 2026 16:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E94B63321D4;
	Mon, 16 Feb 2026 16:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LCtA6DBC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3F83321B0;
	Mon, 16 Feb 2026 16:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771257698; cv=none; b=vD1zr4Kfs4dAaO1oH5X8jXc4RbKtOoD9xAnsQMPAqbMKxen61ynP17ML6285fMTOWypg4m9Bg4VFw3B7YMbpkczGANsIPE1QUzlW9Xcc/xnMuCIp/OlAaxDs0IS3NoSeJ+Maq9C1xT8RHZZF4R+H55ginl0XXizU1MkJnspb6CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771257698; c=relaxed/simple;
	bh=jIVr4EMhbxLfBhJVNM0uEaoaqlclfdp51xNGeOTr5GA=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:From:Subject:Cc:
	 References:In-Reply-To; b=RjPzreJPd4mEqFqymwT1uYnZs2VhmxcOO99RDAkTExEpVcuekrVShyJdsJMt1VHktCw1OptF7tGy95sOZlbLttQHNmqICSTPD6P1XMKnM3itJ/0QldcNpKuwO2eAHWJyPxrrd1e0igAyAUalpwAA93rrKzK8xvwbiBPbEtB1Q0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LCtA6DBC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 884F3C116C6;
	Mon, 16 Feb 2026 16:01:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771257698;
	bh=jIVr4EMhbxLfBhJVNM0uEaoaqlclfdp51xNGeOTr5GA=;
	h=Date:To:From:Subject:Cc:References:In-Reply-To:From;
	b=LCtA6DBCVr2TBT0CKrY9VzbcKdaAfJZKXvoj0/rq4OZKGoPR/Re+zt5a2cymZ2kDP
	 8fsXBmWb4FWDjLLH3kMul1dyw8djkfljTza8dDj5BsxWrV5PRKLTRIiOof0J/t0902
	 QzuwmEFerI/QaM6eYs4w8xkxTcT5I/t6HpQ9BoQ4n+Zi3gLQF8Mjbu6cQZnt1EKFiV
	 HBVCDGCbxAgj9RR09OluRcyPb1/RTNX3ZWwjJGdMz2/Z6VjCqwn/NHU9bUw3j4IexT
	 wyOacJbmuBKoDbzGysoiCy5qyl4lS1iS33dMxU5I8de2PCojIR9g6hsMGRUPcI5scz
	 YZu4FV30SqvIg==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 16 Feb 2026 17:01:33 +0100
Message-Id: <DGGIG6WA0F2Y.Q5UZ6D6EE43W@kernel.org>
To: "Mark Brown" <broonie@kernel.org>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH 6.12 00/24] 6.12.72-rc1 review
Cc: <stable@vger.kernel.org>, <patches@lists.linux.dev>,
 <linux-kernel@vger.kernel.org>, <torvalds@linux-foundation.org>,
 <akpm@linux-foundation.org>, <linux@roeck-us.net>, <shuah@kernel.org>,
 <patches@kernelci.org>, <lkft-triage@lists.linaro.org>,
 <pavel@nabladev.com>, <jonathanh@nvidia.com>, <f.fainelli@gmail.com>,
 <sudipm.mukherjee@gmail.com>, <rwarsow@gmx.de>, <conor@kernel.org>,
 <hargar@microsoft.com>, <achill@achill.org>, <sr@sladewatkins.com>
References: <20260213134704.728003077@linuxfoundation.org>
 <bde6d2f9-f554-49f1-9af8-084c4cdea035@sirena.org.uk>
 <DGGI5PT256ZX.E11J217J4EEK@kernel.org>
In-Reply-To: <DGGI5PT256ZX.E11J217J4EEK@kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-216722-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	RSPAMD_EMAILBL_FAIL(0.00)[hanguidong02.gmail.com:query timed out];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dakr@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: D86E9145DD0
X-Rspamd-Action: no action

On Mon Feb 16, 2026 at 4:47 PM CET, Danilo Krummrich wrote:
> On Mon Feb 16, 2026 at 3:27 PM CET, Mark Brown wrote:
>> On Fri, Feb 13, 2026 at 02:48:19PM +0100, Greg Kroah-Hartman wrote:
>>> Gui-Dong Han <hanguidong02@gmail.com>
>>>     driver core: enforce device_lock for driver_match_device()
>>
>> This breaks boot on at least the Arm Juno platform, upstream it
>> introduced regressions on quite a few systems due to drivers registering
>> in the probe of other devices.  That's obviously not a great pattern but
>> a regreession is a regression.
>
> Just for reference, I've also sent the following to the stable patch appl=
y
> notice:
>
> "This commit reveals a few driver bugs resulting in deadlocks without the
> following fixes:
>
>   - 1. ed1ac3c977dd ("iommu/arm-smmu-qcom: do not register driver in prob=
e()")

One additional note, we want this commit backported regardless, as it also =
fixes
commit 0b4eeee2876f ("iommu/arm-smmu-qcom: Register the TBU driver in
qcom_smmu_impl_init").

I.e. the current code is racy in terms of async probe and the driver is nev=
er
unregistered even if built as module and the module is unloaded, which is a
potential UAF.

>   - 2. 730e5ebff40c ("gpio: omap: do not register driver in probe()")
>   - 3. https://lore.kernel.org/lkml/20260212235842.85934-1-dakr@kernel.or=
g/
>
> The third one will hopefully be picked up by the clk folks soon.
>
> (1) should be required since v6.11, (2) since (basically forever) v2.6.22=
 and
> (3) since v5.11.
>
> We should also consider that we do not know if (especially older) stable =
trees
> have similar cases that we did not catch in linux-next."
>
> - Danilo


