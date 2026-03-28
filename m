Return-Path: <stable+bounces-230783-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id XC9qMAXFx2mTcAUAu9opvQ
	(envelope-from <stable+bounces-230783-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Mar 2026 13:09:41 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 58DDF34E518
	for <lists+stable@lfdr.de>; Sat, 28 Mar 2026 13:09:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5FC76301326B
	for <lists+stable@lfdr.de>; Sat, 28 Mar 2026 12:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50B7733436A;
	Sat, 28 Mar 2026 12:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k/r4m/ue"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1412C35CB91;
	Sat, 28 Mar 2026 12:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774699778; cv=none; b=KdeUaq05wmAV10mcoBI+CLcJaip7qHXeq6v6U3BK/vMuk1ptR7wGbvm1JrVzrmkTiwn6CY886VhbooSLIJUd4pmDpk/xWK7KEDWLu8PIx1fPuoIjcu8fzc+FpiNa+CjnnaVWTUrf0P6LqvyrAl7OwQxLmv/Cyk0ahZeALIiYCPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774699778; c=relaxed/simple;
	bh=aj2WoZSD4Ghz0WN0CvxQLhesl3mrrJl9JZMEkXD6iJs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AT15ZKjW4ycEjNEMZygP7LA9H9XzUAOw1xB02WcXK+uoqmQ+xL1OJNqdUyDRrKFIoA0Wmm5cuogPbBQ6eeugT/3i2FGkhkHTFljoiZd0Q1ZwQNrrzAn9PJtLh1814Iu6Hf9QGcQ1Iwdz8P2xT5fjoChwVKHnx9OATGKkSOtbOcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k/r4m/ue; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 100CAC4CEF7;
	Sat, 28 Mar 2026 12:09:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774699777;
	bh=aj2WoZSD4Ghz0WN0CvxQLhesl3mrrJl9JZMEkXD6iJs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=k/r4m/ueX4BHo3KpJu/EnzGu9hUWVECJ9zT43JbN/vOCG9z6Gnjl/MCj9KDym5wY7
	 neYO7SvL/1stOEBVXgVmmwlml7aAlX2WSW/IAPRNjXJPUFxhfnwk5xCehkqjQf7RDS
	 K1vNH4lR04IJWfDU+t/Betv8YLU8kJ4jUAQrTVP6vEZmNvQr1NHeH+vG6x99PokfiG
	 1P/ZhIc23nYpHyF33u6y5nhbBXp/hDkea3hwiGNz4EtbkgdjJOXtmm7ZgiNrmc7HuO
	 XWEtUeMRudf3FCXBvPIWjBPud2IEgBzp7fV6VgRWxoGkVbS8wy3w1q5ACAfXM9RS+Q
	 8HWkcVP97AgeQ==
Message-ID: <7d1b7aa6-aaa8-4116-abc2-382511823a9c@kernel.org>
Date: Sat, 28 Mar 2026 13:09:32 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] soc: fsl: qe: panic on ioremap() failure in qe_reset()
To: Wang Jun <1742789905@qq.com>, Qiang Zhao <qiang.zhao@nxp.com>,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, gszhai@bjtu.edu.cn, 25125332@bjtu.edu.cn,
 25125283@bjtu.edu.cn, 23120469@bjtu.edu.cn, stable@vger.kernel.org
References: <780c1ba3-6639-478e-896f-e35ec059b58c@kernel.org>
 <tencent_FED49CF5331CC0C7910618883332A08E2606@qq.com>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <tencent_FED49CF5331CC0C7910618883332A08E2606@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-230783-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[qq.com,nxp.com,lists.ozlabs.org,lists.infradead.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chleroy@kernel.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	REDIRECTOR_URL(0.00)[aka.ms];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,qq.com:email,aka.ms:url]
X-Rspamd-Queue-Id: 58DDF34E518
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



Le 27/03/2026 à 01:12, Wang Jun a écrit :
> [Vous ne recevez pas souvent de courriers de 1742789905@qq.com. Découvrez pourquoi ceci est important à https://aka.ms/LearnAboutSenderIdentification ]
> 
> When ioremap() fails in qe_reset(), the global pointer qe_immr remains
> NULL, leading to a subsequent NULL pointer dereference when the pointer
> is accessed. Since this happens early in the boot process, a failure to
> map a few bytes of I/O memory indicates a fatal error from which the
> system cannot recover.
> 
> Follow the same pattern as qe_sdma_init() and panic immediately when
> ioremap() fails. This avoids a silent NULL pointer dereference later
> and makes the error explicit.
> 
> Fixes: 986585385131 ("[POWERPC] Add QUICC Engine (QE) infrastructure")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wang Jun <1742789905@qq.com>
> ---
>   drivers/soc/fsl/qe/qe.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/fsl/qe/qe.c b/drivers/soc/fsl/qe/qe.c
> index 70b6eddb867b..9f6223043ee3 100644
> --- a/drivers/soc/fsl/qe/qe.c
> +++ b/drivers/soc/fsl/qe/qe.c
> @@ -86,8 +86,12 @@ static phys_addr_t get_qe_base(void)
> 
>   void qe_reset(void)
>   {
> -       if (qe_immr == NULL)
> +       if (qe_immr == NULL) {
>                  qe_immr = ioremap(get_qe_base(), QE_IMMAP_SIZE);
> +               if (qe_immr == NULL) {
> +                       panic("QE:ioremap failed!");
> +               }
> +       }
> 
>          qe_snums_init();
> 

Applied, thanks.

