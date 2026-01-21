Return-Path: <stable+bounces-210728-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yL48AOG0cGndZAAAu9opvQ
	(envelope-from <stable+bounces-210728-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 12:13:37 +0100
X-Original-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4585755CAC
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 12:13:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 36E3296232C
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 11:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B68147DFA0;
	Wed, 21 Jan 2026 11:05:14 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BAA62D8DDD
	for <stable@vger.kernel.org>; Wed, 21 Jan 2026 11:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.248.49.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768993513; cv=none; b=ayi2A4/KBBnXD6Pza1JiqTbdJcLCS0+W8z3djjrHted/A8I4z163ijTiLCLCO0dEOWGoVp9DHdpHetlkWmoMNhVsdV/NCvzkUPtBC5ArJFkhz8WmCVLzN3Reg+8MK5UxTTbAWZknKkpCliwgpI/7hg7iVCskURqkyYBMepjAttI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768993513; c=relaxed/simple;
	bh=eezuRGoxXuRYKtLQ/9I2o1c2Kbh+5AybBP30dipSIzw=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=HZoZwoaSsZR3mLoJ8lDp7/Z6IoADhhhFQKs+xczb3+m4e1V11zE/DlkWyAOedJyDcI53bB80PO2wbWMq0f5K7BlDBIpUumE8aKRYc7XLtmgyPKJfRqJn67/4O7aZbYQkM6RfBmwElSy5TwxLNyY4OivwzjmS07gDW+vC/aniupk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=socionext.com; spf=pass smtp.mailfrom=socionext.com; arc=none smtp.client-ip=202.248.49.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=socionext.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=socionext.com
Received: from unknown (HELO kinkan3-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 21 Jan 2026 20:03:59 +0900
Received: from mail.mfilter.local (mail-arc02.css.socionext.com [10.213.46.40])
	by kinkan3-ex.css.socionext.com (Postfix) with ESMTP id 02E0E2069FE9;
	Wed, 21 Jan 2026 20:03:59 +0900 (JST)
Received: from iyokan3.css.socionext.com ([172.31.9.53]) by m-FILTER with ESMTP; Wed, 21 Jan 2026 20:03:58 +0900
Received: from [10.212.247.110] (unknown [10.212.247.110])
	by iyokan3.css.socionext.com (Postfix) with ESMTP id 8FE3A1071A3;
	Wed, 21 Jan 2026 20:03:58 +0900 (JST)
Message-ID: <d0a7accd-3d7d-41ec-b85e-469adf156a91@socionext.com>
Date: Wed, 21 Jan 2026 20:04:03 +0900
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [REGRESSION] v6.6.120: i3c crash caused by commit 82a09b9965ed
To: stable@vger.kernel.org
Cc: Frank Li <Frank.Li@nxp.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sasha Levin <sashal@kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[socionext.com : No valid SPF, No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	R_DKIM_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hayashi.kunihiko@socionext.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_FROM(0.00)[bounces-210728-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 4585755CAC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Dear stable maintainers,

After updating from v6.6.119 to v6.6.120, I noticed a kernel crash
when I3C was enabled.

This regression is caused by:

     commit 82a09b9965ed ("i3c: fix refcount inconsistency in i3c_master_register")

The issue is resolved when the following upstream fix commit is applied:

     commit 3502cea99c7c ("i3c: Move device name assignment after i3c_bus_init")

I also confirmed that commit 82a09b9965ed is applied to other stable trees,
including at least linux-6.1.y, so the same regression may affect them
as well.

Applying the fix commit or reverting 82a09b9965ed resolves the issue.

Thank you,

---
Best Regards
Kunihiko Hayashi

