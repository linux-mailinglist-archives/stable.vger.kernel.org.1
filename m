Return-Path: <stable+bounces-15563-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 967F783966A
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 18:30:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 218AB28A7DD
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 17:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C48717FBB2;
	Tue, 23 Jan 2024 17:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="gNkDxKPS"
X-Original-To: stable@vger.kernel.org
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E1660277
	for <stable@vger.kernel.org>; Tue, 23 Jan 2024 17:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706031007; cv=none; b=rzcAmcK1LrsPtA1PhMFJyp2Zmas6kKzImqZYFpovk2LIzODaaJPZ9Yt8VVheolhcqjOsxL9NXXuIR++PTV1P2bQSCq2FwiSnRq55+DIdTLIC5swJYdOSOzG06Sdx3MUCQoYGfcv/adc1GhZ58Bmv10oIVOj6GFHiq0lIy4ThrIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706031007; c=relaxed/simple;
	bh=fIyOGZscd4Ddm0TD3zRUy1aeQD2b9C56SK/u2Ix1VxI=;
	h=Date:From:To:Message-Id:Mime-Version:Content-Type:Subject; b=nZOg2uwp7ZtDcpzBR/yUHJWinWLRcBAgjOGqH9v7RF6u0aKuVDAW2Mt+7Hz+VZ2Rq157rmu4fYre781dNAXWPV3/sqcZktsGpy2rbtyTeyCOkBnnTtQOjRpE6E/siWRv+8L4umISa5z4Ud8SS5dQzvJj8taJpcpM3fSbz1fIWuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=gNkDxKPS; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:Mime-Version:Message-Id:To:From:
	Date:cc:subject:date:message-id:reply-to;
	bh=fIyOGZscd4Ddm0TD3zRUy1aeQD2b9C56SK/u2Ix1VxI=; b=gNkDxKPSraBMCK5we5edJt4dk1
	31oVuJKJmdgWkhjVQJIk9y4geh+DvNtlnFf4DmK0lWmGXiv75xCJMykA9U57BKKI2tiX7BhP1ozXo
	MT9RdytpG3KUsepOJmkTbg6yyGC4asE2TRELxnGqPN3KcMJ27ZAh904wbTQrpgkfeemM=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:51514 helo=pettiford)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1rSKb0-0004OK-14
	for stable@vger.kernel.org; Tue, 23 Jan 2024 12:29:58 -0500
Date: Tue, 23 Jan 2024 12:29:57 -0500
From: Hugo Villeneuve <hugo@hugovil.com>
To: stable@vger.kernel.org
Message-Id: <20240123122957.9a88fb7839ae745975af6883@hugovil.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Level: 
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	* -0.0 T_SCC_BODY_TEXT_LINE No description available.
Subject: serial: sc16is7xx: improve regmap debugfs by using one regmap per
 port
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

Hi,
I would like the following patch to be applied to the stable
kernel 6.6:

3837a0379533 serial: sc16is7xx: improve regmap debugfs by using one
regmap per port

As noted in
https://lore.kernel.org/all/20231211171353.2901416-1-hugo@hugovil.com/raw :
---------------------
I did not originally add a "Cc: stable" tag for the above mentioned
commit, as it was intended only to improve debugging using debugfs. But
since then, I have been able to confirm that it also fixes a long
standing bug in our system where the Tx interrupt are no longer enabled
at some point when transmitting large RS-485 paquets that completely
fill the FIFO and thus require multiple and subsequent writes to the
FIFO once space in it becomes available. I have been investigating why,
but so far I haven't found the exact cause, altough I suspect it has
something to do with regmap caching...
---------------------

It applies cleanly and was tested on this kernel using a
custom board with a Variscite IMX8MN NANO SOM, a NewHaven LCD, and two
SC16IS752 on a SPI bus. The four UARTs are using RS-485 mode.

Thank you,
Hugo Villeneuve

