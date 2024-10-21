Return-Path: <stable+bounces-86986-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74A409A593D
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 05:28:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3BDA1C20D6A
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 03:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 467391CF292;
	Mon, 21 Oct 2024 03:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="de0dWJBn"
X-Original-To: stable@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F92A197531;
	Mon, 21 Oct 2024 03:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729481310; cv=none; b=dVp3yoUfTTYvnBBXqecX9eLyOqUSwtlgcfFh6t3AAye7puCc5Wn7xckLIYurMK2T3ZAiCuCj3LQgbu9O4ifgj29FEEfbWynPCr3I0OQ73mnTjurq1JlJSu3yO+xeUZVSMvDlbOmW3/DEyuCFbMYs7EwkymMSumTLgONSHbuZiqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729481310; c=relaxed/simple;
	bh=WoyJUMtHDLbZHs8erOMKOVbMxOKaZr9THOlDK5ZZCfQ=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=I6BS/MxFdS14/lILoSRl9hiFMIYYv4mc5i/eNqcp2hpLgbhgbDdJ2Xl+zyYUdqnfO+odIiLu6qOK7YsToZI1tu0K4zPG5hQGJeF4ZrBuOIk91fsTrsbbZc2wfbAqSNxCHKok3psg4Ez1IyqWWl4AeuUqnwQH7nOxSGdIkGm+xGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=de0dWJBn; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:Subject
	:Cc:To:From:MIME-Version:Date:Message-ID:From:Sender:Reply-To:Subject:Date:
	Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=WoyJUMtHDLbZHs8erOMKOVbMxOKaZr9THOlDK5ZZCfQ=; t=1729481308; x=1729913308;
	 b=de0dWJBnDacWB6TbOYzSppT7vv8j9Dos/07rwvsAJa6IJUUG/lEptAhTiBGXK6LX818HfMW0PM
	jzIcYbPyWbZz6ViKdKpOchgy5EiTf9dgCZUGgSCEJtvIDWfrH8BZhBZaKVU+/LWbNtyUQXORtWKDK
	i+w9vfKwqv1S+3i9ecWc896FlfaM/7BjZjOsXaNaapuVGl2YPHTlyx0dfBt+CylfoTi1S5/at9+Tu
	HzWCl7QOzfInIxXCRFw4iXxGcCsFmVFpPc9L+0pKOw2v4LJYAZ2hy/td2V8yK4RDNFx1B9aBHZ91F
	VMkGS/PcDnW/ji+nQlKqt6VLSwwShx6/PPUUQ==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1t2j5l-0002lk-Qn; Mon, 21 Oct 2024 05:28:25 +0200
Message-ID: <2fad9d09-c328-4353-be0b-cfcfef33ed01@leemhuis.info>
Date: Mon, 21 Oct 2024 05:28:25 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: en-US, de-DE
To: Greg KH <gregkh@linuxfoundation.org>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>,
 Sasha Levin <sashal@kernel.org>,
 Linux kernel regressions list <regressions@lists.linux.dev>,
 LKML <linux-kernel@vger.kernel.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org
Subject: Pls pick up two bluetooth fixes
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1729481308;323c1754;
X-HE-SMSGID: 1t2j5l-0002lk-Qn

Hi Greg! Please consider picking up the following two bluetooth fixes
for the next round of stable updates, they fix problems quite a few
users hit in various stable series due to backports:

4084286151fc91 ("Bluetooth: btusb: Fix not being able to reconnect after
suspend") [v6.12-rc4] for 6.11.y

and

2c1dda2acc4192 ("Bluetooth: btusb: Fix regression with fake CSR
controllers 0a12:0001") [v6.12-rc4] for 5.10.y and later

For details see also:
https://lore.kernel.org/all/CABBYNZL0_j4EDWzDS=kXc1Vy0D6ToU+oYnP_uBWTKoXbEagHhw@mail.gmail.com/

tia!

Ciao, Thorsten

