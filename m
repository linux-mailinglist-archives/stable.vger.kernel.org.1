Return-Path: <stable+bounces-93060-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B73319C948A
	for <lists+stable@lfdr.de>; Thu, 14 Nov 2024 22:28:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7260F282999
	for <lists+stable@lfdr.de>; Thu, 14 Nov 2024 21:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F33DC1ADFE0;
	Thu, 14 Nov 2024 21:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b="pViJmXag"
X-Original-To: stable@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D30EF4CB36
	for <stable@vger.kernel.org>; Thu, 14 Nov 2024 21:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731619678; cv=none; b=rWofwD6S4KchrOToRZaiNUfz2P+QzQ2DPZV4QfRBky9b/Mdlv5iob+boyqb/1oEySDBVQDtBE4yrmWowVgTA/arlXUpWn92nBAPFIvcTBIwp3VjmxKNRP8Fu2EVdmepWuuQZULTWivXkkzP2Zh37q0jpxxgrAHB8OEWIADUqv60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731619678; c=relaxed/simple;
	bh=d3qBP3HHK5zyozxNsi1SIipFMbYbv0J4/K24uRWKyDk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Gd/sPp/a+tjNkka36glpzkhRGKo7IyWDWKGjsnw9yFFvpymO3IMd7ngnjOl37PoThu0cYAi0z8di+m0xCx8KvBRHbDRxdkzJu7hpggwYVd6GqbCisMGZ0lwOcTELRhAhiw/GMYJYR1huVxmmQmHXnv4nH4nMfp5FkDJgkdujYfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de; spf=pass smtp.mailfrom=hauke-m.de; dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b=pViJmXag; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hauke-m.de
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4XqCtB3LLQz9stj;
	Thu, 14 Nov 2024 22:27:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
	t=1731619666;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=nqtEoWg86YzXhxXuFptYluouK8PE1Lyw25Qz2/DaXhg=;
	b=pViJmXaggOLvxfQSgH1FOiKNs0n18+Ci9t9X1+ZxJUvhq66hw3+daRVzT8PzHg5xzWOMT+
	7n3ULURkBSGu1Gl4gEt51Bz0UDDCWwoXaxr3dLN7BnKzxFElLtKTJ32rvB5zGv8jsPmJXh
	pzkqJME2H9TanSik/1y0I6x5e82nqg5pFbr628v3Tm2kyESyfQ/O31BCO99qnXqzv9Y1c1
	TO7wShJrYouI35e+giNR0fSlIz48iTb9HxcD0x8oD+6oAizZvXf0iHNErlo4FPNP+O5PfY
	KH1ByZBCcZRxxNYZAl3tkAIT5wo0vOEu7TPXt7Zw2hB4RJgjEbuRzkOuz810gg==
From: Hauke Mehrtens <hauke@hauke-m.de>
To: stable@vger.kernel.org
Cc: jack@suse.com,
	gregkh@linuxfoundation.org,
	Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH stable 5.15 0/2] backport: udf: Allocate name buffer in directory iterator on heap
Date: Thu, 14 Nov 2024 22:26:55 +0100
Message-ID: <20241114212657.306989-1-hauke@hauke-m.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I am running into this compile error with Linux kernel 5.15.171 in OpenWrt on 32 bit systems.
```
fs/udf/namei.c: In function 'udf_rename':
fs/udf/namei.c:878:1: error: the frame size of 1144 bytes is larger than 1024 bytes [-Werror=frame-larger-than=]
  878 | }
      | ^
cc1: all warnings being treated as errors
make[2]: *** [scripts/Makefile.build:289: fs/udf/namei.o] Error 1
make[1]: *** [scripts/Makefile.build:552: fs/udf] Error 2
``` 

This problem was introduced with kernel 5.15.169.
The first patch needs an extra linux/slab.h include on x86, which is the only modification I did to it compared to the upstream version.

These patches should go into 5.15. They were already backported to kernel 6.1.

Jan Kara (2):
  udf: Allocate name buffer in directory iterator on heap
  udf: Avoid directory type conversion failure due to ENOMEM

 fs/udf/directory.c | 27 +++++++++++++++++++--------
 fs/udf/udfdecl.h   |  2 +-
 2 files changed, 20 insertions(+), 9 deletions(-)

-- 
2.47.0


