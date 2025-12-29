Return-Path: <stable+bounces-204115-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 00B52CE7BBA
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 18:25:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A2CEC300EDE4
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 17:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1664C31A062;
	Mon, 29 Dec 2025 17:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="QmNdO+9X"
X-Original-To: stable@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5828F27A107;
	Mon, 29 Dec 2025 17:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767029155; cv=none; b=JEGhCg3TL77IohsGe4ovMbQWTuqB+ia87YzkT/7TlKh/RYk+33zxMuYMRZvX5J2l0v0sJDReE12dL3u1GvpMk46MvXg1DXAfKACetmdOpd2WBiVYINhoueElUr+bQJiTOsY17ZLFBx1wbAALadVNyqklZHgA7Qf9oZSCOd8MYLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767029155; c=relaxed/simple;
	bh=OdliW2XI0tC0CYA58OHNZ5lng6AqmLSu2MUF9H9uS+E=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=oyolquR/PHTmqnjyQ5Z/eP2B4ApGuBh1gAzbNWcmLYUKyHyu776Xwr3GFvxkPzAPTtPLynJdzgxLDZpPaz63IdULRoPQa9JBCh2AEvmrhELNblps3Ss3uCHtbkT2GUHHyjGvNCkTbLYXoSv/MT/k5IGZim8OOuen1RbIr/khMe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=QmNdO+9X; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1767029150; x=1767633950; i=markus.elfring@web.de;
	bh=OdliW2XI0tC0CYA58OHNZ5lng6AqmLSu2MUF9H9uS+E=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=QmNdO+9XDOBxZI1f4b7hfdyLWVOKV0G8dX0A+bKk0uCH6B+HtkHyQwF9sVivMflI
	 OTMkjYxEFI01an1l8G2QGFszg+62EZpwj30VL7yq0sH9ZIfQavJnwWxrUiOADHirn
	 IjioIBcyaBsMw8V3MANzXnPFzTlUxjyD7opMxu8OHSrmxitSnGybGSnMB8BMvFzAc
	 YRjEg2SSPp7yPWKqULkUoX1+pPrOzbdypfTnRu5nisyzsJEBnwpOrhsUylckJDgak
	 zbDSFnIpH4MQfF+igozYwHvUGOdLaQL3kEHOjqTZ5C33kjTIrkUha15hjpwH3AyUq
	 yOOS6q+c0xeH6U4LcA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.231]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M2xvy-1vdZJp3w56-00BpwG; Mon, 29
 Dec 2025 18:25:49 +0100
Message-ID: <1c3ede9c-3dc8-4ad4-9068-4e8747305856@web.de>
Date: Mon, 29 Dec 2025 18:25:48 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Ryota Sakamoto <sakamo.ryota@gmail.com>, gfs2@lists.linux.dev,
 =?UTF-8?Q?Andreas_Gr=C3=BCnbacher?= <agruenba@redhat.com>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 syzbot+4cb0d0336db6bc6930e9@syzkaller.appspotmail.com
References: <20251230-fix-use-after-free-gfs2-v1-1-ef0e46db6ec9@gmail.com>
Subject: Re: [PATCH] gfs2: Fix use-after-free in gfs2_fill_super
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20251230-fix-use-after-free-gfs2-v1-1-ef0e46db6ec9@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:LLTOByfoHkgkmOUYYap/x4W+iFXyEOaBNBy3j3E3llWBp4dT9q1
 ewGOA+74HSD5ZIAussFqWbRnPlWev9TThmbax/Hp5YUv7St9iBcdDIPFF/Fv+es7rC2aCJo
 jFrrJ0GTXzDVPJItdOB2+dFIAteay3fAbiuF6vVEpuFf0+sD/8ATX+8Yu+JXg5QZQgtg+4K
 fcMGrrQhSFh0tWUWhla9A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:zXgXkpLudU0=;PwGMlnPfGp7kf6sS0O6DkOysqqh
 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
 GKwlv+giDzxQtq6FFs4nIjGXht1IP004cO/cZ/

=E2=80=A6
> This patch introduces fail_threads =E2=80=A6

See also once more:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.19-rc3#n94

Regards,
Markus

