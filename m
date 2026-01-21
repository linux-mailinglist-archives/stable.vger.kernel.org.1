Return-Path: <stable+bounces-211169-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UIGCAS84cWnKfQAAu9opvQ
	(envelope-from <stable+bounces-211169-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 21:33:51 +0100
X-Original-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 779C05D51C
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 21:33:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B457590FDF0
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 20:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F41953D6694;
	Wed, 21 Jan 2026 19:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="GNYOxXpJ"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f65.google.com (mail-dl1-f65.google.com [74.125.82.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B9734E744
	for <stable@vger.kernel.org>; Wed, 21 Jan 2026 19:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769025550; cv=none; b=ECeq3Qi4K8r0t768BF+j1lKxg0+3Bky5qjSb/ZpW+brlsmKVMvJTK6hspYeYk/4GgxCMwj4NIEYMQ6po5qjatEsTanF++xoo1lbTG7cX37rilGzikNxBZjLKgpaueWqe3gLgcdCI1Y3OHyXzfL0lJja3BEH/K+aPJJXcjL//KpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769025550; c=relaxed/simple;
	bh=s07JPc00mUEVoQ0XHwQDkbdIcHbJcAGS6t+R3P7QcIo=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=QNcKejUczucsVCc/4Dduln6G6htHUPJQl4hpVK8j0XR41y1CsVYLeNKXi0NT/LUDEemI7hrOniA0lhcF6+YQoyHT6Y2Jcc5dP2rgquhn/v1t6bYCygC2lhOxn9LXFKwB8zZuPDf2XsRGDdMwGhcmQtxWQgw4iOWcnk6zLdb8ogk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=GNYOxXpJ; arc=none smtp.client-ip=74.125.82.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-dl1-f65.google.com with SMTP id a92af1059eb24-11f1fb91996so558479c88.1
        for <stable@vger.kernel.org>; Wed, 21 Jan 2026 11:59:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1769025546; x=1769630346; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P+iBkurWmvHhLVblgznkZBR373OOCn9ayRrIJZxLAkA=;
        b=GNYOxXpJSmYljM4rwg5RmBqZyzsomq0oDJB6jz2qY26rlKjHrpd+Yva+pESswTRrjh
         9mIZfADIDm5YYNOV7qVF2bCe7mupuE25ac4NN18ybkS5iSn736tGmY5C5nOBGDHXsBK3
         NTnqjGsXeG4lbg6+KG6p7BQLRuI2Rkpc6/1H1MwVp3TURgcpUIWLiWNR/iTQ3jcDk2bo
         9o6Xvx92c+n3Wne5Tw6LLRegYOouqKaKFnd58iNZ5CaLoFv7XkLakxR9VG9eyuQkgpib
         IxER4DFrpWzWIIFiim8oJiv4eDgUlf4MxO6UfqxH/pOtCtHw+NYewMbekH5wstJ1Xi94
         Mg/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769025546; x=1769630346;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P+iBkurWmvHhLVblgznkZBR373OOCn9ayRrIJZxLAkA=;
        b=L4LS3ayyaZXIcBhwZ90qXJkBbfrxbJr7K8S5wMMuyUG5KSe4QApZMPBu28Uv5Pno1S
         LTQVCmWJ622OZNID8mBv6F4RfqLSG3Fz9EO+8c/YcRHFSLBJF8O4E1AlQORNeAQMjPJJ
         n0a4jeUo0MIjE0cX1PK6FtL6p4EXl2fo4y1h62eW5710ij2Kvxc3reLI0VbKfnAwclNJ
         4rtfAlR1bljjEGa6iZKUFeepZ5x4agCFN+mGHSaEb2Ld55zYwF7BtXCckmjKrjJjpe/f
         sr38OlmcvF3uGQVd/yccrfGTo8p3Bv88Q74A87uxd6qTHW05HpJPHXnvRMFQpT+8FlH7
         5ghw==
X-Forwarded-Encrypted: i=1; AJvYcCUhxthJwvMbJ0DwXJyo+/2Aot+5Zg4tEWSW9HzJ2JhPukonvVOi71BviBbvRDdh/I7CluEq1jk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4hIvLEOZQvnEAt7pdFk6uofuvSLW+dFAcJ39BbFg6W2e/Bvb1
	tCTa9/AcTguPcIiyDAwCHErXTAuZ1hBYT68a8WGaB5q81bS/5nRyLfXSAJd5/IS3WKg6UQdXCal
	inZGxhfs=
X-Gm-Gg: AZuq6aKYqrToQyV7ClQpFyV0+pQFzXjW+i/wwwsBWY1plmeQyxOPusD/WCnIjgHGvTT
	SALxq7o0q7wB7/luk9s5ROI4axBud2aVSDPm8aXMGaLT3nNH3deMu+8QA+I3AcjR/RAT3FkiPc1
	wDt6HQjBu24J9uX6NIuE+BUV4eRuVUPbXfxe1ipZ7WLY+Res/XqxcjcjVn9aLn9shOR2yDAxdGQ
	q2RJzBK1YB445KaccLRD2gT7Vyb0R8RmwnLDI3NpPK+jUCW5x8JHa68yyNbvrYeRvfgnVn0u8zc
	OQ4f+zJAU1YJHoj/q1TOD9H3mKRoVfR03wVRsgIgNVyjzOtmmtDU792FLnvyzkDa/rfkHXI7Eti
	bsePIxHokk/zxeU0+mNPAgUxotuJnOycA3qsTLiBE5y1nUTa+rwq7L+7F7NSArTKbkIXWexhr1S
	bDmOQv
X-Received: by 2002:a05:7022:2514:b0:11d:f440:b758 with SMTP id a92af1059eb24-1244b3705bemr14070591c88.25.1769025546214;
        Wed, 21 Jan 2026 11:59:06 -0800 (PST)
Received: from 22d5995788c3 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1244a8938ddsm23982452c88.0.2026.01.21.11.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 11:59:05 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [REGRESSION] stable-rc/linux-6.1.y: (build) unused variable 'atslave'
 [-Werror,-Wunused-variable] in drivers/d...
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: gus@collabora.com, stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Wed, 21 Jan 2026 19:59:05 -0000
Message-ID: <176902554516.564.1164922755829282859@22d5995788c3>
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://files.kernelci.org/kbuild-clang-21-arm-allmodconfig-6971191cb2a19cc73abf20cc/.config];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernelci-org.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-211169-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[kernelci.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernelci-org.20230601.gappssmtp.com:+];
	RCPT_COUNT_THREE(0.00)[3];
	HAS_REPLYTO(0.00)[kernelci@lists.linux.dev];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bot@kernelci.org,stable@vger.kernel.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,lists.linux.dev:replyto]
X-Rspamd-Queue-Id: 779C05D51C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr





Hello,

New build issue found on stable-rc/linux-6.1.y:

---
 unused variable 'atslave' [-Werror,-Wunused-variable] in drivers/dma/at_hdmac.o (drivers/dma/at_hdmac.c) [logspec:kbuild,kbuild.compiler.error]
---

- dashboard: https://d.kernelci.org/i/maestro:337d06708c4eefd41fbec489248bb1f354e094a9
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  48e9d0fb9fdb9a69863f2a421103e555511e3f16


Please include the KernelCI tag when submitting a fix:

Reported-by: kernelci.org bot <bot@kernelci.org>


Log excerpt:
=====================================================
drivers/dma/at_hdmac.c:1350:23: error: unused variable 'atslave' [-Werror,-Wunused-variable]
 1350 |         struct at_dma_slave     *atslave;
      |                                  ^~~~~~~
drivers/dma/at_hdmac.c:1610:2: error: use of undeclared identifier 'atslave'
 1610 |         atslave = chan->private;
      |         ^~~~~~~
drivers/dma/at_hdmac.c:1611:6: error: use of undeclared identifier 'atslave'
 1611 |         if (atslave) {
      |             ^~~~~~~
drivers/dma/at_hdmac.c:1612:14: error: use of undeclared identifier 'atslave'
 1612 |                 put_device(atslave->dma_dev);
      |                            ^~~~~~~
drivers/dma/at_hdmac.c:1613:9: error: use of undeclared identifier 'atslave'
 1613 |                 kfree(atslave);
      |                       ^~~~~~~
5 errors generated.

=====================================================


# Builds where the incident occurred:

## defconfig+allmodconfig+CONFIG_FRAME_WARN=2048 on (arm):
- compiler: clang-21
- config: https://files.kernelci.org/kbuild-clang-21-arm-allmodconfig-6971191cb2a19cc73abf20cc/.config
- dashboard: https://d.kernelci.org/build/maestro:6971191cb2a19cc73abf20cc


#kernelci issue maestro:337d06708c4eefd41fbec489248bb1f354e094a9

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

