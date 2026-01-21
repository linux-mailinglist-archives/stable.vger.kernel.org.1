Return-Path: <stable+bounces-210723-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kCvOAq6tcGkgZAAAu9opvQ
	(envelope-from <stable+bounces-210723-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 11:42:54 +0100
X-Original-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id CF6CA55657
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 11:42:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8A47E604B85
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 10:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 487FE3D34B7;
	Wed, 21 Jan 2026 10:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="OH3a5uea"
X-Original-To: stable@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A799629D29D;
	Wed, 21 Jan 2026 10:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768990549; cv=none; b=ZHOuQdqG2a0/CBzv0JxWi4Bo7BOltoJNZhNiLQdA+bCE3NbSwTjTTBjwDMDddIvZfA1h1D0BDPw+aa4UMjzprwYHBLfm0cpgfqZdVLc+GlclIBqg7GXRzVYDcHhUfpi47heRUAZqfeG4t32zfnHC5H+pQ5vIjhGzmtpJ+ks/vm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768990549; c=relaxed/simple;
	bh=IVwPvwGGVsIHZhauyDeARBFdfVpY2wktKPKaTMKTxZU=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=GAKugelABEOorsQu1WCVtV295VSG6jld62atT1ZYBZs/zw8gTHD5I7Cr7AgKGwueirQhdjuzqxXt+2+/Odv5fxU2NGodtmoLxIQjZ2Ii+QMSzshHY1rz8aJ+VJaFmxse1Kp+jA2/Mel5HZkft7L6zRSZk///qdy47/9UK5OOxtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=OH3a5uea; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1768990534; x=1769595334; i=markus.elfring@web.de;
	bh=zklX6eC3QZKUic/5wndxDMsNWSZS39xhI4eeIc/XzEE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=OH3a5ueaXQCPeT/9D4Yg1G+pwy3AtGnCJTEICSv5cuDokPuKM3t1mnUNp/wtf0rz
	 AmKa56d9U/rZyP3blEQl7ipIxmGY53FM8N3yqHsUrqWO/f0KHpRSY/K3CPXIlVdSM
	 gvbn9ow4tpSGB+v3ceBnQmKOCCzEuw43pSbx3TffhXFiAuBa+KbZ1WVbKf3+3LCMw
	 0Nao8L7n+cS5fnYQ6BpS2kRCmHYk30x7cFab+K5AYboky870MobGFEbHmPyu08baB
	 WPwPjwVf9MStlo71zt9nCfNzzikZEzNndOl4Up2Kqb1mSfcscmqODkE0weCGbkdhu
	 2AGz/lIbglN/5q6a5A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.226]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MXoca-1vH3og1wAm-00Jq6A; Wed, 21
 Jan 2026 11:15:34 +0100
Message-ID: <1e130a9f-a729-4610-8936-b167186cea4b@web.de>
Date: Wed, 21 Jan 2026 11:15:32 +0100
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
References: <20260121012223.186199-8-lihaoxiang@isrc.iscas.ac.cn>
Subject: Re: [PATCH v2 7/7] clk: st: clkgen-pll: Add clk_unregister for
 odf_clk in clkgen_c32_pll_setup()
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20260121012223.186199-8-lihaoxiang@isrc.iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:vLB2bhjJr4F4vfZcNNZqVCgi/okBpUuohdIELsrYOfl/03brsp5
 yRYca8E+KFGemXrm49wnnUy8DqX0ttLRPYi+5qs0B0D/NBVG65XwyT5zZJynjLC4Z7swMvY
 IMt+nmZKjGzAMOLqQ0ARIMXSPGsWANtAkuf2gwzd8OgkKeynMUfE1Rop4VKoEamwdZCasy2
 nTaSRUUj6/CeFx11KWyXg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:EoSj6WD5Fyw=;3/MAgcHCWrUjoi+rhzJnAc+4vIo
 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
 ANuH7IYTvhwq9Hl2U=
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[web.de:s=s29768273];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[web.de,quarantine];
	TAGGED_FROM(0.00)[bounces-210723-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[web.de:+];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	FREEMAIL_FROM(0.00)[web.de];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Markus.Elfring@web.de,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: CF6CA55657
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> In clkgen_c32_pll_setup(), clkgen_odf_register() allocated
> clk_gate and clk_divider memory and registered a clk. Add
> clk_unregister() and kfree() to release the memory if

Would an other word wrapping become more desirable for an improved change description?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.19-rc6#n659


> error occurs. Initialize odf to zero for safe.

                                                data processing?

Regards,
Markus

