Return-Path: <stable+bounces-33837-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A92F892B76
	for <lists+stable@lfdr.de>; Sat, 30 Mar 2024 14:50:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DF9A1F21BE9
	for <lists+stable@lfdr.de>; Sat, 30 Mar 2024 13:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A17221105;
	Sat, 30 Mar 2024 13:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b="Ff2rF0HL"
X-Original-To: stable@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D021E500
	for <stable@vger.kernel.org>; Sat, 30 Mar 2024 13:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711806609; cv=none; b=pY3ZUlLCFOZAM/2g3eBpxYLo6SYZaQqnyu7CLxtYtoZeG1AZdtfpku0SuzbbUvK4k4rPF1v6CRkjnRSgtPcObeylMBjzTbi9otQ210YU7ACSb71ZeayiJJ778Mc/al80VBTkoso/iFeGH2SJMzeXcA6q17ZHdZpJsIVhu41YPgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711806609; c=relaxed/simple;
	bh=DoW4hW7/00YU0rjJo39Z33LBzOzV/j+pyJYQuss5RS4=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Cc:Content-Type; b=saD/85W19Hg7v3b3N1CWNoJKz/Ya35s+WV/NIBQi3IBwWdifjKB1UP+Qmy3w9JroRrLXSgSXlTtqZ/OXCs4WURXicfYH/9n83QIWURgcn3SyxCnGFgRMaMwyveYtaYS6FHzALK7iCGH8nFRga7QLIRDuH5CkmornbAaoRdHxYDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de; spf=pass smtp.mailfrom=hauke-m.de; dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b=Ff2rF0HL; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hauke-m.de
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4V6JYd3SBdz9sd5;
	Sat, 30 Mar 2024 14:49:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
	t=1711806597;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=QBITO0QHOJI7RWnxD7EVnkWW9XcuiIgw2NIbh4lFNZ0=;
	b=Ff2rF0HLOA0deDYzV3OqpFnuhRdgLXjkonwAhJB01LzYmDfXDLjvAZV/epJtzKWxB8Q9Ch
	TEuB+HeXQB47XWO+Tu4Scx/DaErDXm/q2rjeBlqon3mrxi5iHsglSSrGAKpb6wC1ImSTgK
	ySCtz4LMSGxcY3EeQ1WU6WsjoTvo3u6m+I3o9E5y6nHIxBCcXKsnYzmUyDMrKaftOxYDEI
	AMxR5E7c5mdHMhhyoBFEXChyuWMEL6UuTo2fMo8gl1Ufolu8+ndOAd8dC1waIBmudMQ239
	sT0dyuBY6UdtISdoZ9BsiXrNjKTcAW6nCRVbuoNthyPJh/Nkvgfo7vMwb/P+Jw==
Message-ID: <de171eb5-3e95-4529-9228-9a4ed526ed46@hauke-m.de>
Date: Sat, 30 Mar 2024 14:49:56 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Language: en-US
To: stable@vger.kernel.org
From: Hauke Mehrtens <hauke@hauke-m.de>
Subject: Backport "mtd: spinand: Add support for 5-byte IDs" to 6.6, 6.7 and
 6.8
Cc: John Audia <therealgraysky@proton.me>,
 Ezra Buehler <ezra.buehler@husqvarnagroup.com>,
 linux-mtd@lists.infradead.org, Miquel Raynal <miquel.raynal@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 4V6JYd3SBdz9sd5

Hi,

Please backport the following commit back to the Linux stable kernels 
6.6, 6.7 and 6.8:

commit 34a956739d295de6010cdaafeed698ccbba87ea4
Author: Ezra Buehler <ezra.buehler@husqvarnagroup.com>
Date:   Thu Jan 25 22:01:07 2024 +0200

     mtd: spinand: Add support for 5-byte IDs

     E.g. ESMT chips will return an identification code with a length of 5
     bytes. In order to prevent ambiguity, flash chips would actually 
need to
     return IDs that are up to 17 or more bytes long due to JEDEC's
     continuation scheme. I understand that if a manufacturer ID is located
     in bank N of JEDEC's database (there are currently 16 banks), N - 1
     continuation codes (7Fh) need to be added to the identification code
     (comprising of manufacturer ID and device ID). However, most flash chip
     manufacturers don't seem to implement this (correctly).

     Signed-off-by: Ezra Buehler <ezra.buehler@husqvarnagroup.com>
     Reviewed-by: Martin Kurbanov <mmkurbanov@salutedevices.com>
     Tested-by: Martin Kurbanov <mmkurbanov@salutedevices.com>
     Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
     Link: 
https://lore.kernel.org/linux-mtd/20240125200108.24374-2-ezra@easyb.ch


This will fix a regression introduced between Linux kernel 6.6.22 and 
6.6.23 in OpenWrt. The esmt NAND flash is not detected any more:
<3>[    0.885607] spi-nand spi0.0: unknown raw ID c8017f7f
<4>[    0.890852] spi-nand: probe of spi0.0 failed with error -524
See: https://github.com/openwrt/openwrt/pull/14992


The following commit was backported to 6.6.22, but the commit it depends 
on was not backported.
commit 4bd14b2fd8a83a2f5220ba4ef323f741e11bfdfd
Author: Ezra Buehler <ezra.buehler@husqvarnagroup.com>
Date:   Thu Jan 25 22:01:08 2024 +0200

     mtd: spinand: esmt: Extend IDs to 5 bytes


Hauke

