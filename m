Return-Path: <stable+bounces-211180-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YMy2IU9acWnLGAAAu9opvQ
	(envelope-from <stable+bounces-211180-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 23:59:27 +0100
X-Original-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F59A5F2EE
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 23:59:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A1E4D380EC8
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 22:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81A473ACEE9;
	Wed, 21 Jan 2026 22:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="r3XBay5s"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f193.google.com (mail-dy1-f193.google.com [74.125.82.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56AB833FE23
	for <stable@vger.kernel.org>; Wed, 21 Jan 2026 22:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769036349; cv=none; b=l3aYHK60XsqE4/Z9itokbYURf3QwzGe8jVPEIXI2ZrEknyOmiBZ0kl2pFpF6QX0ZxD3nrqgEOC36LblkdxryMJMs93Cq/EultuOUl9uaBbZ2iM8PkKhu3TYnAV5ART8JOinCGM/5WAlQl+d+S2xTG0A78M1lGVtucImMsdtIiyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769036349; c=relaxed/simple;
	bh=hqXczniP1XrMxt/O1NWCrb+E4kIFvjsv32fYaB9zdoo=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=fauKnd5xL/7xEGgnADFQPoiAuRTkbobkuz3/yQmn/aRJyW37mDSoSQwaXnMC7i6WfPvRUmyG3LEVQc6AzpfKNtPv9vMsegqXg5TAPmtWzbV5YG8VC/xkwxbIGqtdu5abptrdCcyqGu33a3sG/GNjBuGHTMAIyEl2gNMxBn4gHnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=r3XBay5s; arc=none smtp.client-ip=74.125.82.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-dy1-f193.google.com with SMTP id 5a478bee46e88-2b71347ac0aso482926eec.0
        for <stable@vger.kernel.org>; Wed, 21 Jan 2026 14:59:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1769036345; x=1769641145; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2NzbTMmb+O9I8/joHgGozHSAA/dFFBZJk4QkWcDo03w=;
        b=r3XBay5sCEo0JUIynSGcoc8YRszAvdGlq8s94d11AOftbNY3uhP2t18Rjrf69t86pq
         fDjhV1MikJyAtcHzD7xSBnXVKnZGENGNYvD6uTivyqsa8Li5SoHiYcovs7PvLfinHGqF
         w5D/QAe5j9eCrDDt9YkLjr2iYJEb+jCDjL8YNgT80uhy1LdLHU6wyUGvy/WqzE1qihCs
         7LgyH59V8ZRpT9RkKRC+OP/FzAONs+gis2W1RDFkwZ6G7J594e67JsR7NywUGZ0/wkjz
         Upu2gj2h6xF6UwITcwqMp/n/ro0AAinxqm52C4S8Z61OFiRhQiW2acuDIuBz1KvXzM5J
         Ob4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769036345; x=1769641145;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2NzbTMmb+O9I8/joHgGozHSAA/dFFBZJk4QkWcDo03w=;
        b=GNzLTNzjUBceT/AkepHOVSJb10RDZHWclDizvFYF8dWyhZUVXxKPgVVdLQ/t1hMS3b
         LL1s7ttoywX+IVzO7CT/kE32PvJgXCwydPm7A5P8yHHSBVfguvK5RQ/R1hxjMVshWn0p
         3Bc43wgl7YWjzISHF39s2OJJPD+l2/ScXvxPvyIqBMUon244zpg2QJ3hYEX0B/riVMI8
         80t8JnoWEiHrnEoU9iPu2BbekdnISOzrUWNCI9f/qrj9SPbvp0T2ulbtolMOX/4H5I4r
         4C8heqhFi9PzK6KsZMoFBC8OFsWZvQNEKN2xtr/7WwoZZH3jm8VDMojvUL+A7rVmt8ka
         8o/A==
X-Forwarded-Encrypted: i=1; AJvYcCUH1z3CMKQGHkNsiXvpctonMCH8AJQVKFsPaduU7+uzOryetnmzA/T0+O7HEds96JbfUS7Kf/o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjOi0WUbvTewlrUWrSrIQRmtOelBgLm/U/79Jx1cCPVc1v8C7/
	fVgJBndpQ8/rDrwiu+XDLch5TdQTy3VOtXpf+MLBi1XAl0Bj+9HsYUMhp7aTk4GkmIY=
X-Gm-Gg: AZuq6aIohOHv3x5CmGcayNKDdKYIbmNDzeBrsWMHC+lm8Lp7QrIFwOq/dsNsFCmsTqL
	kqTnXa49rl9zTSjj0+9mVEEt9bEimW9bdakVsyumXetB+gAiq99HiHCv+e+Hj9W6kGWXarL7pjU
	X64osEfxmwX1xC49RqQFVulo3rI9orBs5B9gbZ8way0s3iUjbXc1CfSgvsUhqFQ73sB+58q/USk
	7ezZPsXgh1UylwNNg/04saWr4AKiEaz6upxIVB1jfsC95qPB49v86TCskbNhbhhH9L1AzKpDwNv
	t+hqxz/AFpbxc1gxRW5MgE/HeW+PAUsyuCs1OKR4FuMgjdtN2RMQKgTChEXgsQODtBYqdsC1kvK
	PVFJJT9hZLc4/D7nmMJ3jBoQ82fazHW8pZug5L8uwFYRXLQVb/wGoTrPnvm5r6rwdodV7Kyli40
	XkSReb
X-Received: by 2002:a05:693c:60c4:b0:2b7:bd6:a44 with SMTP id 5a478bee46e88-2b7247eaac3mr545195eec.16.1769036344614;
        Wed, 21 Jan 2026 14:59:04 -0800 (PST)
Received: from 22d5995788c3 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6b3502c91sm22864040eec.9.2026.01.21.14.59.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 14:59:03 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [REGRESSION] stable-rc/linux-5.15.y: (build) unused variable
 'atslave'
 [-Werror,-Wunused-variable] in drivers/d...
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: gus@collabora.com, stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Wed, 21 Jan 2026 22:59:03 -0000
Message-ID: <176903634331.621.370779796610338645@22d5995788c3>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://files.kernelci.org/kbuild-clang-21-arm-allmodconfig-69711882b2a19cc73abf1f42/.config];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernelci-org.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-211180-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[kernelci.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	HAS_REPLYTO(0.00)[kernelci@lists.linux.dev];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bot@kernelci.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernelci-org.20230601.gappssmtp.com:+];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.linux.dev:replyto]
X-Rspamd-Queue-Id: 1F59A5F2EE
X-Rspamd-Action: no action





Hello,

New build issue found on stable-rc/linux-5.15.y:

---
 unused variable 'atslave' [-Werror,-Wunused-variable] in drivers/dma/at_hdmac.o (drivers/dma/at_hdmac.c) [logspec:kbuild,kbuild.compiler.error]
---

- dashboard: https://d.kernelci.org/i/maestro:93ba1651d432804bf077e72829937d24ea9768dd
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  fe0f13600dbeac5cd9f59732e9c198584bd7e7b6


Please include the KernelCI tag when submitting a fix:

Reported-by: kernelci.org bot <bot@kernelci.org>


Log excerpt:
=====================================================
drivers/dma/at_hdmac.c:1342:23: error: unused variable 'atslave' [-Werror,-Wunused-variable]
 1342 |         struct at_dma_slave     *atslave;
      |                                  ^~~~~~~
drivers/dma/at_hdmac.c:1602:2: error: use of undeclared identifier 'atslave'
 1602 |         atslave = chan->private;
      |         ^~~~~~~
drivers/dma/at_hdmac.c:1603:6: error: use of undeclared identifier 'atslave'
 1603 |         if (atslave) {
      |             ^~~~~~~
drivers/dma/at_hdmac.c:1604:14: error: use of undeclared identifier 'atslave'
 1604 |                 put_device(atslave->dma_dev);
      |                            ^~~~~~~
drivers/dma/at_hdmac.c:1605:9: error: use of undeclared identifier 'atslave'
 1605 |                 kfree(atslave);
      |                       ^~~~~~~
5 errors generated.

=====================================================


# Builds where the incident occurred:

## defconfig+allmodconfig+CONFIG_FRAME_WARN=2048 on (arm):
- compiler: clang-21
- config: https://files.kernelci.org/kbuild-clang-21-arm-allmodconfig-69711882b2a19cc73abf1f42/.config
- dashboard: https://d.kernelci.org/build/maestro:69711882b2a19cc73abf1f42


#kernelci issue maestro:93ba1651d432804bf077e72829937d24ea9768dd

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

