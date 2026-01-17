Return-Path: <stable+bounces-210151-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B88ADD38EC5
	for <lists+stable@lfdr.de>; Sat, 17 Jan 2026 14:44:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3AAE030042BA
	for <lists+stable@lfdr.de>; Sat, 17 Jan 2026 13:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1679B23B63C;
	Sat, 17 Jan 2026 13:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="aAtA+9E9"
X-Original-To: stable@vger.kernel.org
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD3A372622;
	Sat, 17 Jan 2026 13:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768657456; cv=none; b=XGvGW1YOVDG1LZda0b2lldZPBIBqwQpQ0llEQUH3n0xsj0vtwOzFspeZFBc+nfhwxExZ3/NTQICAgrOZLLzHc9oGcQwVJOFhQExOGASOSo3x9QdGqkxFRa/4uvY3t0glbSKqhFWM7kTuz99ubuxNWmUas3sNrzeuvYqGbc704Kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768657456; c=relaxed/simple;
	bh=mldqYBCZY3/RMlNvvWVt9TO5oZYsp/HGg3SEiwKsANY=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=O7uratSLubmlN+O9YAuzDpx2f+BO2HlcxpKCud0Q5St5/Ia9bY/IRC4ZZbQVWEnm24a9+JtQeWvNrjFl2gQgwREY7zWzAOHWeV+PkZYPmQDoy6UotNDuL8PGnRNDTANpnT7AWJ0uCIZxuH235+vf/8puK3kG+hHUpxf0kYE8TAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=aAtA+9E9; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1768657443; x=1769262243; i=markus.elfring@web.de;
	bh=KlIKaB+G82StA8wXjn6n4Y+RaIcvyPEiC4bIkO3/wns=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=aAtA+9E9J7qs2moa+TOIgCetqYNTWvvviK6M+ndssPrPkVrxi8LDELv2EAGD5vg9
	 oIn1TOeY0tlMCItIKqk3ubN8fOf7nz6yvbzPs2lThbd7qLj8MOj7xcdJbC+ExGRXs
	 3RwaK4mJjCUcpzf+YV7UDkPowi6n29vFXjLZbRVqlhjrE6ApABjPczr40l5hnl/uW
	 C/0hFV+GYFV0T0fB4ujb0duw4n68l7tkI56KBjMAwpaQCvKLLyWHOh52obOuFPpNG
	 b06Ia2TYjnh40gUaWqQPisBldVziq/aGwQhv5i4cJzzflCJco4Zd75qmdPXe/Z4eI
	 6ZQR1ARmaml2whcrhQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.177]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MKdLK-1vOULm3MCa-00Vt1r; Sat, 17
 Jan 2026 14:44:02 +0100
Message-ID: <75f726c0-67c3-4400-ab1c-126b6752a7ca@web.de>
Date: Sat, 17 Jan 2026 14:43:57 +0100
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
References: <20260116113847.1827694-8-lihaoxiang@isrc.iscas.ac.cn>
Subject: Re: [PATCH 7/7] clk: st: clkgen-pll: Add clk_unregister for odf_clk
 in clkgen_c32_pll_setup()
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20260116113847.1827694-8-lihaoxiang@isrc.iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:NvjbY96d2PLG5TIWB5mHHEsw6wtT6zUITXqVdOanM501m8399Pa
 qTg+0FGqUIq/rs9tBUHFG/Tzfzpjg3hlMc6xFR7BW8ecUPgGDTsN+qVIdZPv1eCXQiZ13Zp
 EkwyQHqMk+UcbW/qNjc64Ozlx2agp+ROR00rFKGfi9cZAhJjT9rkw+BLztF5hGJZpWl0I/J
 QLTZh4Q5G4aQBYbieJqeQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:C8dCGWRyQSo=;vg/AncccFepDp/LYZnuDIE6lscC
 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

> In clkgen_c32_pll_setup(), clkgen_odf_register() allocated
> clk_gate and clk_divider memory and registered a clk. Add
> clk_unregister() and kfree() to release the memory if

You may occasionally put more than 58 characters into text lines
of such a change description.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.19-rc5#n659


> error occurs. Initialize odf to zero for safe.

                                                data processing?

Regards,
Markus

