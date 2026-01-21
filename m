Return-Path: <stable+bounces-211150-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oOWBKs4ycWlQfQAAu9opvQ
	(envelope-from <stable+bounces-211150-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 21:10:54 +0100
X-Original-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 154545CE22
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 21:10:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A7F7388F86B
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 18:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5A2636214D;
	Wed, 21 Jan 2026 18:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="xUnTj+uw"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f68.google.com (mail-dl1-f68.google.com [74.125.82.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 342363A89BF
	for <stable@vger.kernel.org>; Wed, 21 Jan 2026 18:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769021954; cv=none; b=ee5Q99XIQ+mrH68QvpLkHaK+/WdKfBshD7ooGBDt886kmjv80h16MXxkwpe4ibXCKRw2x4dxIM7GEM3YyoJPR/cx0QWDgDfNbFtaohJoDhqdbZzjBaBm924LTSe9dekvX4p+Aqf43XLRK5yMtV53QChf4t7VrnUu4knX/7VdNpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769021954; c=relaxed/simple;
	bh=50UYl3xnSjiNtAL2Wp+YG24k+jRXrPIIY3GQfpx0sjM=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=NAy3DpCHQDLqkF7ZICWW8I2Rl22GPD8fjz5VozxoT0biB7227TsTlnU5rrF3oTLXsHX9V4fA3SXI+SqrHRgYaKEDnzXspC0EKFplAOYpIEXvtUsQE4EpPS0cbntwpn1ysJAsfjymGzbRNMjZcFtsEAs+qrPCLFJGTIpz50Wmzok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=xUnTj+uw; arc=none smtp.client-ip=74.125.82.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-dl1-f68.google.com with SMTP id a92af1059eb24-1233702afd3so348526c88.0
        for <stable@vger.kernel.org>; Wed, 21 Jan 2026 10:59:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1769021948; x=1769626748; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cSeKsSTY9/tFkwMQg9NDa/241vtRYddAlXPB1C+D9So=;
        b=xUnTj+uwl0jmVwjTAspHHfkwyvb1cbsWacXUbo6wvETLybuA2VuLKJjB0wb53geHPY
         WzeCFWRmnm7g5xfQKceuPTlSCOlPlTYk8o9yE5FHnHBVo40irS/D7USesh5kJFqbqUCr
         aa50A6hapf2Lt7ObrWhLrgUigUyxLIw+yP0xqw5kjPKppDNQeSS2RTFsG1OuQQFgV0KD
         ue89l3en3Zk8qAzgOtPZbk1n7gOA7YzVlZJPOlZhHJwJUoqnzUF/p7b/dRH0U64TsrFa
         GctGmxt2mZt7WNPNiXucS+wyFUbJoEyHbdCENPRmAJHTzscAlpTeZTTLicx+18m+Ddix
         4O1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769021948; x=1769626748;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cSeKsSTY9/tFkwMQg9NDa/241vtRYddAlXPB1C+D9So=;
        b=fHgjhZahNAxDSl39A6sEkpSNjqUWS6xvpY1B6beLULXvkypfFotfjltF00gMk5vPSo
         pq6EfIwbBgFTwlHNjomZUSLilIwvO1v/KCh/zLOvFmR7xxARwyZ/gDuCVX7+OFUczw9O
         9HInbDg8QRsgZm5tZPio075b96HmLJoSV2UQc3pY3LMgk+Erxyt+SHLxBNmPMqXo7YU0
         hQhCZqADRjs4Du0m3O/MMwvMZLqZAvSnv7ujNoHUD74Ozn+13k19/jFlFk08X/bcZs+7
         FpnAucT6OuUJY9qzhyxq4PO+nTO5XekI+KyVkvQ45Q7UrPmzoCXkgVGjs22gF2hNNlgy
         ozTA==
X-Forwarded-Encrypted: i=1; AJvYcCVrTJ4U/8cxActX2CLFlRJo2Gyaxl1LgTXFUu+/3YcEhKzl7tGfDy9s9wjI/pHBvCpj9busqJs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6ymHVXuaf1qj4X6eRnJB5MmIFaFgGf9xTzSC8Ug6SyjbPjfta
	1pSjTEvebHTEed/qymX/Y4yHDFTeBPSmFEqyAkWDvMr4+7IIuWfj015GizObbqR3f4UD6ja/G4o
	6TneXw24=
X-Gm-Gg: AZuq6aIrK1Kkxu1aA+XSKa6E2xmrTtySLymeBeGHoFnNGB60JkPDXWAZNrAUskIfH62
	Z20oPyxTPDdy8n9nBOGjwYzMU9rab8mP0Bmv5d0fdfRYU/+i5qL5YqAsRz0FombELLDKsoAxtfL
	EHAGbBuBXu8mzkGWaH56dCi/QUWV2ZVvwnYYyXZTPF3wLrMOp2o5h8UWPvN1Z2cpxU2thwPWBfW
	6fSIBYvqu36cMb6dcYrVW6BHA5uJO8WQW19LbGyu2wj+sWJSnaVz9EO7Z8BfizEmm7/4GUgfvP0
	ahlYEpKc3h/1CqMbCXzahJkkN4TBzQkLq0bJcoA4RMHWQqYMCD/DCSd26SJHwL+TvAOPatB+5fF
	Pj8ghgS2HpslAiODpeTXsaTCAc+LED6xrqSnyUyLO3f6ZoRqMBY7WGjCaG3Ikmn9vnY8ObuZ8BU
	amH7Lp
X-Received: by 2002:a05:693c:3117:b0:2ae:5b71:d233 with SMTP id 5a478bee46e88-2b6fd61e3b5mr4953461eec.19.1769021946325;
        Wed, 21 Jan 2026 10:59:06 -0800 (PST)
Received: from 22d5995788c3 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6fb72e477sm7954029eec.29.2026.01.21.10.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 10:59:05 -0800 (PST)
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
 [-Wunused-variable] in drivers/dma/at_hd...
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: gus@collabora.com, stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Wed, 21 Jan 2026 18:59:04 -0000
Message-ID: <176902194454.545.4871474039926617826@22d5995788c3>
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://files.kernelci.org/kbuild-clang-21-arm-6971187db2a19cc73abf1f3f/.config];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernelci-org.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-211150-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kernelci.org:email,kernelci.org:url,lists.linux.dev:replyto,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,linux.dev:email]
X-Rspamd-Queue-Id: 154545CE22
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr





Hello,

New build issue found on stable-rc/linux-5.15.y:

---
 unused variable 'atslave' [-Wunused-variable] in drivers/dma/at_hdmac.o (drivers/dma/at_hdmac.c) [logspec:kbuild,kbuild.compiler.warning]
---

- dashboard: https://d.kernelci.org/i/maestro:4d6a24c559237688aae946437262d62cff6c287d
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  fe0f13600dbeac5cd9f59732e9c198584bd7e7b6


Please include the KernelCI tag when submitting a fix:

Reported-by: kernelci.org bot <bot@kernelci.org>


Log excerpt:
=====================================================
drivers/dma/at_hdmac.c:1342:23: warning: unused variable 'atslave' [-Wunused-variable]
 1342 |         struct at_dma_slave     *atslave;
      |                                  ^~~~~~~
  CC      drivers/dma/at_xdmac.o
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
1 warning and 4 errors generated.

=====================================================


# Builds where the incident occurred:

## multi_v7_defconfig on (arm):
- compiler: clang-21
- config: https://files.kernelci.org/kbuild-clang-21-arm-6971187db2a19cc73abf1f3f/.config
- dashboard: https://d.kernelci.org/build/maestro:6971187db2a19cc73abf1f3f


#kernelci issue maestro:4d6a24c559237688aae946437262d62cff6c287d

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

