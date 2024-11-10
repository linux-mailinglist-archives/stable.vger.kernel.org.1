Return-Path: <stable+bounces-92047-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB6FA9C341C
	for <lists+stable@lfdr.de>; Sun, 10 Nov 2024 18:46:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C017B20ACA
	for <lists+stable@lfdr.de>; Sun, 10 Nov 2024 17:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30BA91C28E;
	Sun, 10 Nov 2024 17:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b="Egw9mr+U"
X-Original-To: stable@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F32A117C69
	for <stable@vger.kernel.org>; Sun, 10 Nov 2024 17:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731260758; cv=none; b=ZNKUDNXqHMfKNI/usqrSmzHPkT6GFiARqr3xo96lCWGr4iYX8SXtGjoZ2HkEwX1YJPVbHdaGNQRz9vAaeg6VMQ1sF7S5wjIPd7HzFQQJyiDwIU9iIWnxkpqCCzxEBHEGJaRv9LUoXpiakVy9cIR5bM+lCC5TND4OBMfOQRqmnos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731260758; c=relaxed/simple;
	bh=0jB8Je3YfNNIQmGlOym7It5QY+n05RMBFKWnmdPcCA4=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Cc:Content-Type; b=ZPuZNkXTrZWxG8PTdZoo33Bsy++3xVp18ZoyJSI1XrwNXWxUhShgqeqV9WGKNUxtRtlHQ+ZGoVXpxczM7N9gJY+Rxopr2kaNgCrUIg1GjNFf3TAf+DI/plBwUnOtykTglofBTkXB6lWLtyCNoQlYL0o3mc4DJf9cNZAgG1nj2iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de; spf=pass smtp.mailfrom=hauke-m.de; dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b=Egw9mr+U; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hauke-m.de
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4Xmfwn2KkNz9sq9;
	Sun, 10 Nov 2024 18:36:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
	t=1731260169;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=vNOFihfIY3UkN4wDwkkwwTxTFierH+79nleSATYud54=;
	b=Egw9mr+UetEoSPNZgqKBJasKbQG+wMW2JdvfZGm2OSgC/JB7wWSkxl388rw+ovw9AILocV
	hkxauSsqVvt8ryG8W3u7lYs+segys/3VttGoXPKvsz4F4iy99fOxcfcPAFne8FLwdntpsH
	8HYLxs+J0ECTgXa5vXFXO2vCdIdITscj0ju0jtNrMhPmJHCz/MDqtlk/a5w8iiVL8bhoTG
	RwddgT9Gep3vpbArDCAFzXhzcIosY04K2L1agH+3sT48Xy6UiwzPoHVcMmg/o8BC+tMQvO
	RaysopTm77Pr4XAOZakzAI0XZYhRibnDVIroHE3+NZ7vSZU/oZZbWEI+193WEA==
Message-ID: <8e759d2a-423f-4e26-b4c2-098965c50f9e@hauke-m.de>
Date: Sun, 10 Nov 2024 18:36:08 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Language: en-US
To: stable@vger.kernel.org
From: Hauke Mehrtens <hauke@hauke-m.de>
Subject: backport "udf: Allocate name buffer in directory iterator on heap" to
 5.15
Cc: jack@suse.com
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 4Xmfwn2KkNz9sq9

Hi,

I am running into this compile error in 5.15.171 in OpenWrt on 32 bit 
systems. This problem was introduced with kernel 5.15.169.
```
fs/udf/namei.c: In function 'udf_rename':
fs/udf/namei.c:878:1: error: the frame size of 1144 bytes is larger than 
1024 bytes [-Werror=frame-larger-than=]
   878 | }
       | ^
cc1: all warnings being treated as errors
make[2]: *** [scripts/Makefile.build:289: fs/udf/namei.o] Error 1
make[1]: *** [scripts/Makefile.build:552: fs/udf] Error 2
```

This is fixed by this upstream commit:
commit 0aba4860b0d0216a1a300484ff536171894d49d8
Author: Jan Kara <jack@suse.cz>
Date:   Tue Dec 20 12:38:45 2022 +0100

     udf: Allocate name buffer in directory iterator on heap


Please backport this patch to 5.15 too.
It was already backported to kernel 6.1.

Hauke

