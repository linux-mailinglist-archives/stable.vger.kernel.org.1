Return-Path: <stable+bounces-254524-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IFEaBui6FmqHqQcAu9opvQ
	(envelope-from <stable+bounces-254524-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 11:35:36 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8113B5E1DDA
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 11:35:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2C359303F25E
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 09:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98F1D3ECBE7;
	Wed, 27 May 2026 09:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="UWp9fVmg"
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B82EF282F27;
	Wed, 27 May 2026 09:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779874503; cv=none; b=PxL6P0BMQ8zaaA8aC7izn39L/WveJ1NvTnUAEtVoIJslqtn5za1CyldugqNi7t8SuwXRNbQ/NtQLBeQ/ZbN4oioLlXfUDzfXzA3eASmb4qw1avRMuZ0ArqZLW6nCG+oq6HSUenkj/vHT9EV3vE3rm0Ga+M+1pumE3BDQVrGMM3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779874503; c=relaxed/simple;
	bh=pucLOH67JCbJzlHfMWr3MHIL2RqxwwPOtwYVFS7lMcw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S8emtgMt+mZh710HW8U9e2graVqX3XVKvfXdQi7IEAEouRPGjVfSvp+RVtM7MbN5FykyNy6KQz4e7VO3vps8Hn7fQqTz+dbIXFBA9VGQzU50qqkEV7LAcz/rpEN2Wa+zjTcKR0Bti7xlIgjsZq++8WnUuy/+g+TDQzWBkJAVnHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=UWp9fVmg; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E8178169C;
	Wed, 27 May 2026 02:34:54 -0700 (PDT)
Received: from pluto (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3A2003F632;
	Wed, 27 May 2026 02:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1779874500; bh=pucLOH67JCbJzlHfMWr3MHIL2RqxwwPOtwYVFS7lMcw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UWp9fVmgXu0Iry4AFP6BdSo8C3KNKyNmkku9D/G3bGW3st4t/rPs9o1Z8fIfpd1g/
	 QArpI4D+vyIxkmxuCsD7N0lT1eYtYNdwQ4JKl6yqJqZNMFk8ajMPczN9zS/VsPPqJa
	 0WNJYTU6yW9LNteThP8Q6Zbjm/in/wKXFTtbswoY=
Date: Wed, 27 May 2026 10:34:32 +0100
From: Cristian Marussi <cristian.marussi@arm.com>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: Sudeep Holla <sudeep.holla@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Cristian Marussi <cristian.marussi@arm.com>,
	arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] regulator: scmi: fix of_node refcount leak in
 scmi_regulator_probe()
Message-ID: <aha6qETcWKIclqeS@pluto>
References: <20260527092521.866310-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260527092521.866310-1-vulab@iscas.ac.cn>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[arm.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[arm.com:s=foss];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,arm.com,vger.kernel.org,lists.infradead.org];
	TAGGED_FROM(0.00)[bounces-254524-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[arm.com:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cristian.marussi@arm.com,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 8113B5E1DDA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 27, 2026 at 09:25:21AM +0000, Wentao Liang wrote:
> scmi_regulator_probe() calls of_find_node_by_name() which takes a
> reference on the returned device node. On the error path where
> process_scmi_regulator_of_node() fails, the function returns without
> calling of_node_put() on the child node, leaking the reference.
> 

Hi,

I have NOT really reviewed the need for of_node_put...BUT...

> Add of_node_put(np) on the error path to properly release the
> reference.
> 
> Cc: stable@vger.kernel.org
> Fixes: 0fbeae70ee7c ("regulator: add SCMI driver")
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/regulator/scmi-regulator.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/regulator/scmi-regulator.c b/drivers/regulator/scmi-regulator.c
> index 6d609c42e479..f1fe20b0fd76 100644
> --- a/drivers/regulator/scmi-regulator.c
> +++ b/drivers/regulator/scmi-regulator.c
> @@ -345,8 +345,10 @@ static int scmi_regulator_probe(struct scmi_device *sdev)
>  	for_each_child_of_node_scoped(np, child) {
>  		ret = process_scmi_regulator_of_node(sdev, ph, child, rinfo);
>  		/* abort on any mem issue */
> -		if (ret == -ENOMEM)
> +		if (ret == -ENOMEM) {
> +			rof_node_put(np);
		        ^....

...but you clearly not built this... 

Thanks,
Cristian

