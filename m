Return-Path: <stable+bounces-3699-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C0C4801B3B
	for <lists+stable@lfdr.de>; Sat,  2 Dec 2023 08:58:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25710281E25
	for <lists+stable@lfdr.de>; Sat,  2 Dec 2023 07:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90479C153;
	Sat,  2 Dec 2023 07:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=moonlit-rail.com header.i=@moonlit-rail.com header.b="V/5S2pGx";
	dkim=permerror (0-bit key) header.d=moonlit-rail.com header.i=@moonlit-rail.com header.b="ndb7vWlm"
X-Original-To: stable@vger.kernel.org
Received: from hua.moonlit-rail.com (hua.moonlit-rail.com [45.79.167.250])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 406EDD9;
	Fri,  1 Dec 2023 23:58:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=moonlit-rail.com; s=rsa2021a; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=5+GvhBpMKVlbHJyFGxcjjhWJaJYZmDiUbPvU8BcjyOE=; t=1701503913; x=1704095913; 
	b=V/5S2pGxH67gVua/X7rHbTg5xToMi1JjKaB1VJKiJl0HwHBaP907qxvli6+3M3F/Rwg4C5hp+ev
	ZMzZF5AWvzPNZblaP3v17g5gMGb/+XmJM6ZZmVSV92a8NJDFEReSfXHmc49Clw41CUbufF/j05lkn
	EUlTspA9E3j4LI07mmVr7eRmknk8wWlgkOYACJpwcWhqNmShWhq/qw9YpgIUASpWmYQiQorUvbGzM
	ycdrJoDDFmN0nP7MvqSlevqzgYjJFIVRPhO5q2E7/uQdCeq3kNzPNyL/tYmV+Y5uAVoSAtCbZTgn+
	az4UZ3ssaUmsFHCTcVHM5h06/1p3VUqEqK0g==;
DKIM-Signature: v=1; a=ed25519-sha256; q=dns/txt; c=relaxed/relaxed;
	d=moonlit-rail.com; s=edd2021a; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=5+GvhBpMKVlbHJyFGxcjjhWJaJYZmDiUbPvU8BcjyOE=; t=1701503913; x=1704095913; 
	b=ndb7vWlmOtyLy/ESrVNMseaBU3pZLr93VTA56J4UxTckIhjTGs6twMp3HCr2I8ewyplcYCjfyJe
	8q+9JPcWDCA==;
Message-ID: <f1e0a872-cd9a-4ef4-9ac9-cd13cf2d6ea4@moonlit-rail.com>
Date: Sat, 2 Dec 2023 02:58:32 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Regression: Inoperative bluetooth, Intel chipset, mainline kernel
 6.6.2+
To: Greg KH <gregkh@linuxfoundation.org>, Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Basavaraj Natikar <Basavaraj.Natikar@amd.com>, stable@vger.kernel.org,
 Thorsten Leemhuis <regressions@leemhuis.info>, regressions@lists.linux.dev,
 linux-bluetooth@vger.kernel.org,
 Mario Limonciello <mario.limonciello@amd.com>,
 Mathias Nyman <mathias.nyman@intel.com>, linux-usb@vger.kernel.org
References: <ee109942-ef8e-45b9-8cb9-a98a787fe094@moonlit-rail.com>
 <8d6070c8-3f82-4a12-8c60-7f1862fef9d9@leemhuis.info>
 <2023120119-bonus-judgingly-bf57@gregkh>
 <6a710423-e76c-437e-ba59-b9cefbda3194@moonlit-rail.com>
 <55c50bf5-bffb-454e-906e-4408c591cb63@molgen.mpg.de>
 <2023120213-octagon-clarity-5be3@gregkh>
Content-Language: en-US, en-GB
From: "Kris Karas (Bug Reporting)" <bugs-a21@moonlit-rail.com>
In-Reply-To: <2023120213-octagon-clarity-5be3@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Greg KH wrote:
>> Am 02.12.23 um 07:43 schrieb Kris Karas (Bug Reporting):
>>> When Basavaraj's patch is applied (in mainline 6.6.2+), bluetooth stops
>>> functioning on my motherboard.
>>>
>>> Originally from bugzilla #218142 [1]
>> [1]: https://bugzilla.kernel.org/show_bug.cgi?id=218142
> 
> Should already be fixed in the 6.6.3 release, can you please verify that
> this is broken there?

Double-checked and confirmed.  6.6.3 shows the bug (hci0: Opcode 0x0c03 
failed: -110) and my currently-running system (6.6.3 with 
14a51fa544225deb9ac2f1f9f3c10dedb29f5d2f backed out) is running fine 
(with its MX Master 3S bluetooth mouse).

Cheers,
Kris

