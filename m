Return-Path: <stable+bounces-210144-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FDB8D38DA2
	for <lists+stable@lfdr.de>; Sat, 17 Jan 2026 11:15:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 121FC3008C84
	for <lists+stable@lfdr.de>; Sat, 17 Jan 2026 10:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBA36222566;
	Sat, 17 Jan 2026 10:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="qtbiSr46"
X-Original-To: stable@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84AD02AF1D;
	Sat, 17 Jan 2026 10:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768644941; cv=none; b=L/Zq+SXPvuirq8hI2HwlasNDiEwSR6mS60T4GXhdGLNPDGTjXj2ahT/AZVWG2GlDUe0llahs52+77/SMPp0EiLDeCzU5wq+K8y8uTvN6aH5JV4pvkpYzQG5DsiMVUlBPUQ7u+ew4/EpKZrA/gY18EwU0g7HGsabZuvAZLdywFK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768644941; c=relaxed/simple;
	bh=WlDu/kL1qmIdf/AYZ8utNV5Icv6uFtizvReTaXdHMec=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=YgHCEec7BhMebbiMNkcXZr3Yj0iUkOpEGdv42UROvQb2lLOm89aUPdoyG7/KlP32idPWW91ShTJEsy7WFQ2NHC3/tjuap74Sxjc7tUdRS+iaMtLOcM2I5LWt/aL34n/HMUmIFKhTlKPny9y36ykEE9lgRkFGkzOlkgL6kYiJocY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=qtbiSr46; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1768644937; x=1769249737; i=markus.elfring@web.de;
	bh=WlDu/kL1qmIdf/AYZ8utNV5Icv6uFtizvReTaXdHMec=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=qtbiSr46cjbBHM+2cIygsy55mIxz/1Vy9sA/UPlXZYtPwkCctyhhLf2JZ4qgEa1Q
	 jwMnUuqCOn1IfK/gI1FZdYMfbXfjiBpLnAkvSY58lyZTGiZKS6dBS/Etk04bSkzNc
	 kAilSRm+e+mO3TpjsCSTNnwd+LcC9N/RluI+WhW3vn5nbcTDtyyeiyaI3C2cWilda
	 qMydLSBClBLZZPTJdH7moNfXhRptyh2LZEvXmOgGrGSLNBjM8G3oUDuA18k2Dfsqr
	 NLHQOAdyQtmdWey7eJM4riEhiLpDFL0I2tHFVgYT959r+Lq92fULpkWrLsJX2cqhP
	 E1TD5SINBZuvxybtwQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.177]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M4sXt-1vhKj13IzH-00FbGh; Sat, 17
 Jan 2026 11:15:36 +0100
Message-ID: <84e63139-556f-4095-a03d-b1260ef35049@web.de>
Date: Sat, 17 Jan 2026 11:15:23 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>, linux-clk@vger.kernel.org,
 Brian Masney <bmasney@redhat.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>
Cc: stable@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
References: <20260116113847.1827694-2-lihaoxiang@isrc.iscas.ac.cn>
Subject: Re: [PATCH 1/7] clk: st: clkgen-pll: Fix a memory leak in
 clkgen_odf_register()
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20260116113847.1827694-2-lihaoxiang@isrc.iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:JEDjU5Ym5Kpe9caCP2UFChZSOfu7AfaOyCiAEhBkD6KCJ+9MQVS
 RBKtpw3GH6Kob1yLksL9MhHi4MSdZSPuinLrBZXpk2tCV8Yr3GbsrDXodRUjn0xTlLivNMA
 HbMds0RleSR7pqhyrA0cOFGCMfKglUctTQz0fFTT2QpNW9o1UXWW0DAnqRS0hGw+3V94yVI
 wAsGoUIorTDV7Be2gHzBw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:N1UFYlNsjRI=;Tncke0MIPYKrwHIU+xo0IGS4E2n
 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
 Dq72s2Zk=

> If clk_register_composite() fails, call kfree() to release
> div and gate.

You may put such information also into a single text line.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.19-rc5#n659

How do you think about to avoid a bit of duplicate source code here?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/coding-style.rst?h=v6.19-rc5#n526

Regards,
Markus

