Return-Path: <stable+bounces-256423-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QH4KFBG8GGoumwgAu9opvQ
	(envelope-from <stable+bounces-256423-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 00:05:05 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BAD05FAC08
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 00:05:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4D29730547DB
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 21:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB4E03644CB;
	Thu, 28 May 2026 21:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b="ilqFaiW4"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2988436404B
	for <stable@vger.kernel.org>; Thu, 28 May 2026 21:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780005547; cv=none; b=VXde0BT5cNJP5+vhudQFA2ZFndc/RO6MqNRza6kuFSVFbcDuy4UUOOPCJPkWjdXhAA9FsjZxPYx+p3VfFOMmPtT8zgr0pQK1qLB9LJiGtjO5NBkvGeR2mGVwWUUSvqsy0trzrYmAfsxxAYXHSStJG6qxan6DtVe1R3Yb4zdsO5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780005547; c=relaxed/simple;
	bh=UOSBJ21xLCKSnZQIZCFptVFa41x8Q/0PKZPQUAzxHjM=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=mWeTUJbCRWc9YJixmV/a9oxvBVnikDI4syJ4PEivMP0Raa8LBudJSOVwOCggAFKpuVyMArrcybloKrorB7hYeVYfuHxBfhTUnPzxtiflb/nNKAJuuKiD4TEFwmHBcHG6rpdoM9CErKZNpy5zAWOWBEO0fHnL6fwzf0bj5dIns5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org; spf=pass smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b=ilqFaiW4; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-304cf518c9dso2161228eec.1
        for <stable@vger.kernel.org>; Thu, 28 May 2026 14:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1780005545; x=1780610345; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ocqYfTO5sjew5AdjEX97kzaUkvKzLvwGbdjLzmjyXtU=;
        b=ilqFaiW4CghsT289Vzlc++vSgEOIHakTcXZ5yRHiKYLF05DKbutGxa/DXdv/3Uxw2o
         D+NtVNbZznFVxL1slbNxE2PjUNTJXl0oyh0KeBOTTzGL3xjk0KukLoCCXIQVEQooD4Zh
         zw5s4niWiJANS6F3XDqC/Ikj0EOfj+jnQeYzxvnpDOKVRAug0PjEX9BeyyRquxyurKNe
         OE5AbrFWz+3QQOey/gXYxWcioyaTr9e1tZiKVIaGMmO7bomKvoowxv0dw3JiY3Zft0ED
         cfVhc9ZLwhgf+H3gpr5dY9W0BeUXeZZyYTYrEEgOjXVqqF1YPfHWvFWiImAfWIn6Zxpm
         3E1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780005545; x=1780610345;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ocqYfTO5sjew5AdjEX97kzaUkvKzLvwGbdjLzmjyXtU=;
        b=Y2QZzXxPkouPp80RxoE+M/Cr5l8YxxzxSDDpqje2wfjSURsAbSG/SlDamx1XusCxxm
         y6ABtbcE9MYjHwUuwrLqBHU8r7wWZoWXHNzwA9Q1/kOE54GgrTD3PREbIvNgU62I9zZq
         jPF659KwXLFOBfDPN97iKDIvApnwX4sQi99s4NCJd2vP970E4VlbNdaqRwl2Cpd/XufY
         XD4K9jI0W26nzhmRObAoV39RVzOqP3B55E+WqqFhg69Zhf1/dWQn8bIsBNGhoVy0IIqv
         dnILACKEEItYS2oRJqpSMq6upcXPNZuXkpYIItHLfYIqNX4rd0qqLkFxC+ocBuEdx3iJ
         kooQ==
X-Forwarded-Encrypted: i=1; AFNElJ/HoJo0R+YfPbtzcSvEUllmT7IXMHTBVihbCVUt4tjhe6nkDtUjODHweahMxQExcAmZwgGUY90=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+z4JbKu5wm8eX2PPFkCnul3dTluvn3dE71sGn3ChDO/02vn7Y
	F3LBc0ntR5IpvyeYlMKfdodgceAGF7KPL5BI1ModcBKCEFmmhm3vbTOccJgxWQCHzis=
X-Gm-Gg: Acq92OEMPKO6dAuzjdebmDNT0OL3ApprJcLMCd66VaXBHOdWFrjuzLPn2mz/zEP9e6z
	p6WCE2DDQFtN5r9EkWzEsZReyrVWCHEu4Z9s/e40XWZYcwtPrnTVYkmyYRISYVD8w5pvL9Mzs1D
	4boKmXtU7oe82XTv9e7v9ruZOdWszKIsrI2oy0/zxUJkHaYhUSzOibdMsYzRwJKLpA3wL3/mksC
	xrDY5lCgOkuWfIfCrkll+NRjbeU3Rk9IkRuLg/QGJaJliaSvJZKQy3mn2sVc19jwI745opsRdej
	pog/lycyRO39GkPBbbmN7Aoeg/K6BlI404J4D2wMjTBzB9W25JEFsMnWp2kDPJbu1uo14jObJuh
	rv/9Dq3RlkBDVjVEfPDkku9wv3zHw3YdD/AVYQO1vZCcgLZuhDV/ygwlqXRTp2CZU5iQTnf/LxO
	ifmqPgcaKd8Y6utISriQwCd1GX2ZE=
X-Received: by 2002:a05:7022:ff47:b0:12d:bab2:f213 with SMTP id a92af1059eb24-137aedca836mr81812c88.21.1780005545243;
        Thu, 28 May 2026 14:59:05 -0700 (PDT)
Received: from 330cfa3079ca ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-137afc9b26bsm142120c88.0.2026.05.28.14.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 14:59:04 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [REGRESSION] stable-rc/linux-6.12.y: (build)
 /tmp/kci/linux/include/linux/bio-integrity.h:101:12: error: unused...
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: gus@collabora.com, stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Thu, 28 May 2026 21:59:04 -0000
Message-ID: <178000554419.7114.5687032601791586484@330cfa3079ca>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernelci.org,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernelci.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	TAGGED_FROM(0.00)[bounces-256423-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernelci.org:+];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[kernelci@lists.linux.dev];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bot@kernelci.org,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,kernelci.org:url,kernelci.org:email,kernelci.org:dkim,lists.linux.dev:replyto]
X-Rspamd-Queue-Id: 9BAD05FAC08
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr





Hello,

New build issue found on stable-rc/linux-6.12.y:

---
 /tmp/kci/linux/include/linux/bio-integrity.h:101:12: error: unused function 'bio_integrity_map_user' [-Werror,-Wunused-function] in block/bdev.o (block/bdev.c) [logspec:kbuild,kbuild.compiler.error]
---

- dashboard: https://d.kernelci.org/i/maestro:61a955022b749b020de003549d329ea7933021ea
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  97928cc88900a9fb07a4dddbd1db19eb0ce55c56


Please include the KernelCI tag when submitting a fix:

Reported-by: kernelci.org bot <bot@kernelci.org>


Log excerpt:
=====================================================
In file included from /tmp/kci/linux/block/bdev.c:15:
In file included from /tmp/kci/linux/include/linux/blk-integrity.h:6:
/tmp/kci/linux/include/linux/bio-integrity.h:101:12: error: unused function 'bio_integrity_map_user' [-Werror,-Wunused-function]
  101 | static int bio_integrity_map_user(struct bio *bio, struct iov_iter *iter)
      |            ^~~~~~~~~~~~~~~~~~~~~~
1 error generated.

=====================================================


# Builds where the incident occurred:

## x86_64_defconfig on (x86_64):
- compiler: clang-21
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6a189f3aee38c2a863e3d015

## x86_64_defconfig+kselftest+x86-board on (x86_64):
- compiler: clang-21
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6a189f44ee38c2a863e3d024


#kernelci issue maestro:61a955022b749b020de003549d329ea7933021ea

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

