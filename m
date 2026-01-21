Return-Path: <stable+bounces-211171-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sKifDCo5cWnKfQAAu9opvQ
	(envelope-from <stable+bounces-211171-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 21:38:02 +0100
X-Original-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 94F0D5D65D
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 21:38:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 051D7B02568
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 20:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E9583E958F;
	Wed, 21 Jan 2026 19:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="zEqr+Gc8"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f194.google.com (mail-dy1-f194.google.com [74.125.82.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6217E3D3016
	for <stable@vger.kernel.org>; Wed, 21 Jan 2026 19:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769025552; cv=none; b=OTJJm0bUJMxekDrpbZ2oK/wmX44/F9bMZaXmOUkh9uvDj9Sf3V9eEYEFgG/xMmXZpcG4OWb0TdoAbnpv7xmZYxTRKdSXGa0cYpDNN7m1kqLGgPOBcF+puzvHNKuCrHd4yW7cOgm32d2ZaAm8GD86N/zP2Epf0RX6c/2VDHwEatA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769025552; c=relaxed/simple;
	bh=qLWtcDRiIuED+PWC18gybWPbZN0Wruf9mT4YnjWHRUw=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=nHHTRlVTGpHpc7eTkTMTXQf/K22IPecAVL56IbG/HukRub0SDNlvnb63jmphx4c/sZG+g6dtAq2GwssubK+rX6MQePZASfZJkKSxLaKm2P7lrNs4HNFNqa7ySLXXky0fZvGeQQa+m+x3eowMWYRjApDO2Huye9354Mab4FxH5Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=zEqr+Gc8; arc=none smtp.client-ip=74.125.82.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-dy1-f194.google.com with SMTP id 5a478bee46e88-2b6f85470b6so383502eec.1
        for <stable@vger.kernel.org>; Wed, 21 Jan 2026 11:59:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1769025549; x=1769630349; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2NZ967ZyTa4ywnuna2qpl/5LPy9MFQqMeXocQpN7nJo=;
        b=zEqr+Gc87Lg3oTbRXNcGbJ6yHumfhp5TrWuEeCUfzcggsu4MGJYpV7AyBXcXDONMHL
         hogCIu5sHA185g3pbfQVLSys7vd6sI0HaQShJzx8h5sh2weVRddVnUutEwrA/tjdEf+5
         d+rhVM1ye7pknmHPC4AkCvTzvshLE3q8JIr8T5fhPjphGzVib/jKOGw+CB178gFNBIm0
         sHH8mIB06i9ycppa0a39SYoB/aSTCbtydTVQEKD/zqJ7Kx8dGPOSqvC6JGvdmGbTGikL
         YqWaJ2pfUUb4ynIVxpeCf514r+abgwqRsLOyYE1oh0EOZCpBQsL/L3QfVm1+PJ2XTvUm
         /Q4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769025549; x=1769630349;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2NZ967ZyTa4ywnuna2qpl/5LPy9MFQqMeXocQpN7nJo=;
        b=d/yQiQxquhOik/5QCjbU6z6S3/oW11wXM3YHrkdnDEJiJVjly68qNLY16+yUr14kuv
         YishtX3G822GAgLFQplloEQcpryLzCcnXQHPqAaenfAx7KtuII+b7VyXG4iPUBNPhvXb
         +OG3Q+Kg7m76yA04hr3UWlpG/uxMaRmvaFixTvChTU1MruaVmGL4zEslQi6HdUjB6AnH
         omEDF0l2IUZXomQztyigpia3uUIAHeKOAsGRrtJWsG/G0yPPO3h2ks9U9cCKdaOrfwjD
         H6/tJgGxCu2+1dL1BekA8+mY/Chgfv9bpFzNVaRZ3s/gqCdXcB8jgS8rCxnEMajVrQq7
         OHEA==
X-Forwarded-Encrypted: i=1; AJvYcCXZwMuDDt0Ne3Vyif49BaYS6oGY6ZO61YjUCzT80GLRsxR7kCe7PZes6inDJP/T/ROpsP4u6n4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfHxR4FIocO+mamSX7J6E5Cw5P3rSWm+vj/soNLXSumXeN9ZWg
	07fz9etLxR1sGUwQXgJed2wZ2cp8PqQlvuA8ulymIWt8mS8rgsjAm6UUNYS9JwgLtI8iTPj6EbI
	2XjkHl1k=
X-Gm-Gg: AZuq6aI8w4hbpZhC0tw9EvfMRaV5hZagNLjvZOrOzq4QdPxJnfPIBrW/meBJblS++Y8
	uD2jtLyseZtOX7ABvfqmCG7YfUbU4MLg/l/7S/g22q2fuY4eAxljHqs7ZB/vX8a6M2gSa4BSECU
	61CKAj9ALuU7d5HjM97SPuQsf722bl01xLJ15v/5cIuQ/ecWMY7HDj6+IrL85vsas0XDu1faimF
	Zvsxp/m7GzAqsZVgO7m4Lx1JcAfyZ8AbcYpvgTJH63EJbu85zqTbKA0CaksSQBrphEQ4PZ5Blvg
	IRdrfF/ORaymm7RtM1IXwwtCe4ACZZVllWgXAVR36tzVXmoDhuaRN2WEo3eWVguVUbKJ4ttlNef
	DVrDC55EuYuooC+8rVWzoUCayTU9IUPMCiLGEgbzeD02lQEOVogQEBF9yDFVnynvHXjrtKLdric
	h5H3UT
X-Received: by 2002:a05:7300:3b08:b0:2b1:7910:b102 with SMTP id 5a478bee46e88-2b6fddb16bamr3739065eec.37.1769025547620;
        Wed, 21 Jan 2026 11:59:07 -0800 (PST)
Received: from 22d5995788c3 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b70b3c8ea3sm5420618eec.22.2026.01.21.11.59.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 11:59:06 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: 
 =?utf-8?q?=5BREGRESSION=5D_stable-rc/linux-5=2E15=2Ey=3A_=28build=29_unused_?=
 =?utf-8?q?variable_=E2=80=98atslave=E2=80=99_=5B-Wunused-variable=5D_in_dri?=
 =?utf-8?q?vers/dma/at=5Fhd=2E=2E=2E?=
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: gus@collabora.com, stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Wed, 21 Jan 2026 19:59:06 -0000
Message-ID: <176902554641.564.4454360832911623906@22d5995788c3>
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://files.kernelci.org/kbuild-gcc-14-arm-multi_v5_defconfig-697118a4b2a19cc73abf1f68/.config];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernelci-org.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-211171-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.linux.dev:replyto,linux.dev:email,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 94F0D5D65D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr





Hello,

New build issue found on stable-rc/linux-5.15.y:

---
 unused variable ‘atslave’ [-Wunused-variable] in drivers/dma/at_hdmac.o (drivers/dma/at_hdmac.c) [logspec:kbuild,kbuild.compiler.warning]
---

- dashboard: https://d.kernelci.org/i/maestro:e018093dae090d68c1e52935361f9398c6bf76f5
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  fe0f13600dbeac5cd9f59732e9c198584bd7e7b6


Please include the KernelCI tag when submitting a fix:

Reported-by: kernelci.org bot <bot@kernelci.org>


Log excerpt:
=====================================================
drivers/dma/at_hdmac.c:1342:34: warning: unused variable ‘atslave’ [-Wunused-variable]
 1342 |         struct at_dma_slave     *atslave;
      |                                  ^~~~~~~
drivers/dma/at_hdmac.c: In function ‘atc_free_chan_resources’:
drivers/dma/at_hdmac.c:1602:9: error: ‘atslave’ undeclared (first use in this function)
 1602 |         atslave = chan->private;
      |         ^~~~~~~
drivers/dma/at_hdmac.c:1602:9: note: each undeclared identifier is reported only once for each function it appears in

=====================================================


# Builds where the incident occurred:

## multi_v5_defconfig on (arm):
- compiler: gcc-14
- config: https://files.kernelci.org/kbuild-gcc-14-arm-multi_v5_defconfig-697118a4b2a19cc73abf1f68/.config
- dashboard: https://d.kernelci.org/build/maestro:697118a4b2a19cc73abf1f68

## multi_v7_defconfig on (arm):
- compiler: gcc-14
- config: https://files.kernelci.org/kbuild-gcc-14-arm-6971189ab2a19cc73abf1f55/.config
- dashboard: https://d.kernelci.org/build/maestro:6971189ab2a19cc73abf1f55


#kernelci issue maestro:e018093dae090d68c1e52935361f9398c6bf76f5

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

