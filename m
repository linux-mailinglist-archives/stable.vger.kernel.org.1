Return-Path: <stable+bounces-249241-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QAXSOJzbCmog8wQAu9opvQ
	(envelope-from <stable+bounces-249241-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 11:27:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 52A67569B22
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 11:27:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 80D7B30470DF
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 09:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA4153E63AD;
	Mon, 18 May 2026 09:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="agCGlQmD"
X-Original-To: stable@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85F093E51F9;
	Mon, 18 May 2026 09:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779096244; cv=none; b=ZQW9ouKa1Mc9Pwj+TlObK6SrBjPNe/AFblVmd7cCICqw/0HTRM7iL9vO8G6XmWHdP9pAljLQ6NmGoMH56QMSAQTsOVAT27/C1q8hX9AtanZutQauox2QoqhB38n8Rno8ab9Cvun/gPA7gFWDw43u12uHFHcif2mU+VvgSnWd7e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779096244; c=relaxed/simple;
	bh=WaZAx8sto+fmSFfxWyX6/+zrHDOr9JMLs7T+Flg1/OI=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=c2auu9nyddhr7jEBgoy46TiHvyCKbEGskmDTIPMoIJvOP5PmmLIDu72bIp5lPoVLTUV4+0tJDU8XCJJpt8q/JyT/oERsVFimO77FXNml7Sfr68P9zxY+WjQjj3uOQzK4GWf2WPQk0zPq4UwHgugOknwwaiJfB0W3ZkpmauxnAos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=agCGlQmD; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1779096212; x=1779701012; i=markus.elfring@web.de;
	bh=+tcHiekk8HmJDLSxs+xi2fJP6VjUPhRMlaOETHKwrlg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=agCGlQmDPvFxxWRcIU6pD4IffB8rn4/YYQMl+iulXUcP/zdR5D8GEUo+GMvEPrCN
	 n6HTjCUFShGdE9sksQCEFs2rYTT05Yj8VCwdvYkTduHYO1/GYYTI3pqQEfSDe829p
	 WiUwlGNsJclJoTRcDTHIbLv0SND36IER1w08ngoEq3Oa+Z8megaMN96JuNDnVlEld
	 s6EJqKWPKRM8pgojN8D1OTm8hUjKickZuNFEoKCrYEEKbkVtv+I2F2WMg/7GwJW1R
	 YyOi6xo2y5CY+85jEuXS1vFCxuHkT8uXa+RJcxHwQ1eEtovpb1rs4x9CGmW6MUkoE
	 yA3kVEbqozRcaiWMqg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MNfU1-1wiKkx0hVj-00Hqm3; Mon, 18
 May 2026 11:23:32 +0200
Message-ID: <fe233758-26b8-4abc-ada9-d1f7c4102b08@web.de>
Date: Mon, 18 May 2026 11:23:30 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Dawei Feng <dawei.feng@seu.edu.cn>, Zilin Guan <zilin@seu.edu.cn>,
 netdev@vger.kernel.org, Sunil Goutham <sgoutham@marvell.com>
Cc: stable@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>,
 Geethasowjanya Akula <gakula@marvell.com>, Jakub Kicinski <kuba@kernel.org>,
 Jianhao Xu <jianhao.xu@seu.edu.cn>, Paolo Abeni <pabeni@redhat.com>,
 Subbaraya Sundeep Bhatta <sbhatta@marvell.com>
References: <20260515151826.1005397-1-dawei.feng@seu.edu.cn>
Subject: Re: [PATCH net] octeontx2-pf: avoid double free of pool->stack on AQ
 init failure
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20260515151826.1005397-1-dawei.feng@seu.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wdeGwjw3DbqnoA9n3L3Fx0IFLlWHSEDEf1YLiptbvNdP3IbP2Hz
 GrPj2+RujOY3RZlmhomz91vst8jW03cTUIJrajnHYZ7rM34zxPEyovEkILpDe8uKTOyBeAu
 K1WTL1MAKxFACOl/ywDhnuS7oTtabKaUwwQgEjBFnT3gSpzqEy0PedA7bN1FSL7+adVZvPL
 I1PF/ehaenLk+dmTfU/nQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:XgmTwrs6QYs=;HqrNxgNKVyLrNuAM5Tvh9lnkEER
 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
 qQZgoYpAoY1TL7g==
X-Rspamd-Queue-Id: 52A67569B22
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[web.de,quarantine];
	R_DKIM_ALLOW(-0.20)[web.de:s=s29768273];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249241-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[web.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Markus.Elfring@web.de,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[web.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

=E2=80=A6
> Set pool->stack to NULL immediately after the local free so the shared
=E2=80=A6
                                                 so that?

How do you think about to avoid a bit of duplicate source code
in affected function implementations?
https://elixir.bootlin.com/linux/v7.1-rc3/source/drivers/net/ethernet/marv=
ell/octeontx2/nic/cn20k.c#L615-L629
https://elixir.bootlin.com/linux/v7.1-rc3/source/drivers/net/ethernet/marv=
ell/octeontx2/nic/otx2_common.c#L1478-L1492


> The bug was first flagged by an experimental analysis tool we are
> developing for kernel memory-management bugs while analyzing
> v6.13-rc1. The tool is still under development and is not yet publicly
> available. Manual inspection confirms that the bug is still present in
> v7.1-rc3.

Under which circumstances will the mentioned software revision gap
be adjusted accordingly?

Regards,
Markus

