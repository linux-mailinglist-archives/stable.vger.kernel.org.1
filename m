Return-Path: <stable+bounces-212749-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sON5KYEZe2lCBQIAu9opvQ
	(envelope-from <stable+bounces-212749-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 29 Jan 2026 09:25:37 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 52F81AD7A5
	for <lists+stable@lfdr.de>; Thu, 29 Jan 2026 09:25:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 680B730039BE
	for <lists+stable@lfdr.de>; Thu, 29 Jan 2026 08:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0E411ADFE4;
	Thu, 29 Jan 2026 08:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W/h+6m4x"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B51D37B41F;
	Thu, 29 Jan 2026 08:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769675049; cv=none; b=AC8fHjWefT4a49dCyovOl8ovsnVY/v7oldvG/yu2U0eEtfjeBndc4zbWhTw2omGtq/R+F9nTvtFlI+6pHy4wxqlu9K0beDOK6PYIsmbmt946VP08UHqAjynYPce1+gJnoikyB9cdj/ofoJFD7DLeOE0pvWFc8sh8Abwr1SNjfNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769675049; c=relaxed/simple;
	bh=R6TXWjTNCaE5AzthwywAMdfo2/yy5F8CD4Qfds49V5Y=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=fgaBgm0YMFF4VaFxxqELIfRx5uH31Mg6OK+Qunw0xKQ6+QOJ1WZ+hssFwK4shJguN57bkKnSEkErSzA6Kh1LuSI+UW5DyR2d4pQ0mUo6inBWx6qxJtUWHBSaSZyikJ6XkFfoJgMhtZwAEnZiZ/Uhhyn3O8u842P4p6YndUbZ8l0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W/h+6m4x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 500B5C4CEF7;
	Thu, 29 Jan 2026 08:24:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769675047;
	bh=R6TXWjTNCaE5AzthwywAMdfo2/yy5F8CD4Qfds49V5Y=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=W/h+6m4xplRhqbh/THpe2Hyw+CP6HV1Cw7NX2B3XGGpP3U6JZF9YFINP+tou5NOO7
	 AK5oAugshKrByUBZ1N3dj12OnVIQ+/boRH0VZ+VtBAWcTmtqA8K9RpuDTbHzcnJKHe
	 VzBXgkkWGGIOCFTqJzCy4qmG5B5IrmJktvmPnPH10Yh1oM7memKDl5/X2eEX1AzKdS
	 BYXGMo/LdkNY3D36+f6N5f4CoS+/nA0UErrdijnmRtk6Qx+2IOCs1isp+GwoanmWBt
	 GaNvd2ArZfmfAB5T8s1t/RglTIRbVtQa6iFO8z2UtGYeUF+YJeCdpGwVUbQmNGEk4V
	 Q1f4C1d5nGR9g==
Date: Thu, 29 Jan 2026 01:24:03 -0700 (MST)
From: Paul Walmsley <pjw@kernel.org>
To: Han Gao <gaohan@iscas.ac.cn>
cc: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
    Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
    Guo Ren <guoren@kernel.org>, linux-riscv@lists.infradead.org, 
    linux-kernel@vger.kernel.org, Han Gao <rabenda.cn@gmail.com>, 
    stable@vger.kernel.org
Subject: Re: [PATCH] riscv: compat: fix COMPAT_UTS_MACHINE definition
In-Reply-To: <20260127190711.2264664-1-gaohan@iscas.ac.cn>
Message-ID: <a5dcb225-0e94-5cf9-450c-010fa8e53533@kernel.org>
References: <20260127190711.2264664-1-gaohan@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,dabbelt.com,eecs.berkeley.edu,ghiti.fr,lists.infradead.org,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-212749-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pjw@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,iscas.ac.cn:email]
X-Rspamd-Queue-Id: 52F81AD7A5
X-Rspamd-Action: no action

Hi,

On Wed, 28 Jan 2026, Han Gao wrote:

> The COMPAT_UTS_MACHINE for riscv was incorrectly defined as "riscv".
> Change it to "riscv32" to reflect the correct 32-bit compat name.
> 
> Fixes: 06d0e3723647 ("riscv: compat: Add basic compat data type implementation")
> Cc: stable@vger.kernel.org
> 

No blank lines between tags, please.

> Signed-off-by: Han Gao <gaohan@iscas.ac.cn>

Thanks, queued for v6.19-rc.


- Paul

