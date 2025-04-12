Return-Path: <stable+bounces-132315-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 261E1A86BFB
	for <lists+stable@lfdr.de>; Sat, 12 Apr 2025 11:27:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 180C8446565
	for <lists+stable@lfdr.de>; Sat, 12 Apr 2025 09:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28DB719F421;
	Sat, 12 Apr 2025 09:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=herecura.eu header.i=linux@herecura.eu header.b="xvCZyP3H"
X-Original-To: stable@vger.kernel.org
Received: from o28.p25.mailjet.com (o28.p25.mailjet.com [185.189.236.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5CF4199EB7
	for <stable@vger.kernel.org>; Sat, 12 Apr 2025 09:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.189.236.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744450047; cv=none; b=Gf/SVslA3RDHqo4q8Frwg9myVzyMX3TMNrwc2KivmCc0rw/hutWd+Lu35BbxH3SQHDSfoKsWlx240oztSCMbVQF8MVRMIlhF2e4f5HJEtdP3GduCgxQNJKC098XB05R/6R7BuN04NaxeUbceg6kOfbf3ZoSGUO3NoLdQpS4Zk2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744450047; c=relaxed/simple;
	bh=j5jV4FYbM8Hq8DaeSb7opCaZ01laZe72zt1avgpjZ5k=;
	h=Message-Id:MIME-Version:From:To:Subject:Date:Content-Type; b=KFIAUyJhX5ngEBaHSsVRRH2hTAG3gOjRTzjOPkB7rvLgq16s5GJo2MUdo7uiqHf6c7a55PlroRwv+r4Ki3HC7gPe6d0jZ6wlA/JS+IbqRGNSLoGFtnJkwVKTeWNH/2uf20D0XQm6uAfuqisHUbPiSBCnDjNeKCQ/GqbP5Vl5pfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herecura.eu; spf=pass smtp.mailfrom=a1780319.bnc3.mailjet.com; dkim=pass (1024-bit key) header.d=herecura.eu header.i=linux@herecura.eu header.b=xvCZyP3H; arc=none smtp.client-ip=185.189.236.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herecura.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=a1780319.bnc3.mailjet.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; q=dns/txt;
  d=herecura.eu; i=linux@herecura.eu; s=mailjet; x=1744457241;
  h=message-id:mime-version:from:from:to:to:subject:subject:date:date:list-unsubscribe-post:list-unsubscribe:
  feedback-id:x-csa-complaints:x-mj-mid:x-mj-smtpguid:x-report-abuse-to:
  x-spamd-bar:content-language:content-type:content-transfer-encoding;
  bh=j5jV4FYbM8Hq8DaeSb7opCaZ01laZe72zt1avgpjZ5k=;
  b=xvCZyP3HKhgWEmygmFRjk32LqDTlAkDPgtr+e0JX9Xg7aUcv4xRS1MzFi
 EfLs+hVhxLrisbdnhkV56kzcJD3XbJQ1A8Qhd/5GfIwAEceiYVzyH24x0r6J
 W9Ls4wsJ3blgCJ507f23lMPCjke+SyBFIrkipjGJrbqHqoyGfA01NE=
Message-Id: <3e1b616b.AMcAAGjWv5wAAAAAAAAAA9W7g6YAAAAANfgAAAAAABsqXwBn-jH5@mailjet.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Ike Devolder <linux@herecura.eu>
To: stable@vger.kernel.org
Subject: Missing paravirt backport in 6.12.23
Date: Sat, 12 Apr 2025 11:27:18 +0200
List-Unsubscribe-Post: List-Unsubscribe=One-Click
Feedback-Id: 42.1780319.1710535:MJ
X-CSA-Complaints: csa-complaints@eco.de
X-MJ-Mid:
	AMcAAGjWv5wAAAAAAAAAA9W7g6YAAAAANfgAAAAAABsqXwBn-jH5qmlQ98zAT86rOJsi4t3rEwAaGcc
X-MJ-SMTPGUID: aa6950f7-ccc0-4fce-ab38-9b22e2ddeb13
X-REPORT-ABUSE-TO: Message sent by Mailjet please report to
	abuse@mailjet.com with a copy of the message
X-Spamd-Bar: /
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

Can I report an issue with 6.12 LTS?

This backport in 6.12.23
[805e3ce5e0e32b31dcecc0774c57c17a1f13cef6][1]
also needs this upstream commit as well
[22cc5ca5de52bbfc36a7d4a55323f91fb4492264][2]

If it is missing and you don't have XEN enabled the build fails:

```
arch/x86/coco/tdx/tdx.c:1080:13: error: no member named 'safe_halt' in 
'struct pv_irq_ops'
  1080 |         pv_ops.irq.safe_halt = tdx_safe_halt;
       |         ~~~~~~~~~~ ^
arch/x86/coco/tdx/tdx.c:1081:13: error: no member named 'halt' in 
'struct pv_irq_ops'
  1081 |         pv_ops.irq.halt = tdx_halt;
       |         ~~~~~~~~~~ ^
2 errors generated.
make[5]: *** [scripts/Makefile.build:229: arch/x86/coco/tdx/tdx.o] Error 1
make[4]: *** [scripts/Makefile.build:478: arch/x86/coco/tdx] Error 2
make[3]: *** [scripts/Makefile.build:478: arch/x86/coco] Error 2
make[2]: *** [scripts/Makefile.build:478: arch/x86] Error 2
```

To make it work I have added the backport of 
[805e3ce5e0e32b31dcecc0774c57c17a1f13cef6][1] as patch in my local build[3].

Best regards,
Ike

[1]: 
https://web.git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=linux-6.12.y&id=805e3ce5e0e32b31dcecc0774c57c17a1f13cef6
[2]: 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=22cc5ca5de52bbfc36a7d4a55323f91fb4492264
[3]: 
https://gitlab.com/herecura/packages/linux-bede-lts/-/blob/0d7e313f13fdae9bde7f79967481f186cc1ba8fd/0003-x86-paravirt-Move-halt-paravirt-calls-under-CONFIG_P.patch

