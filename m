Return-Path: <stable+bounces-240476-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mJqCO0wL6mnFsgIAu9opvQ
	(envelope-from <stable+bounces-240476-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 14:06:36 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B14C451C2A
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 14:06:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3A5F63009160
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 12:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E6613BD25A;
	Thu, 23 Apr 2026 12:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fOxPqJZ5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D66372ED7
	for <stable@vger.kernel.org>; Thu, 23 Apr 2026 12:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776945717; cv=none; b=VxjEd7t3wfUKzYHKz3YcR7zIeNutFMsrjph2ZT7WvpfdVRtlDkoIlbBgjCi7Ip/yQnE2iuO4BUfXUCm727/EDvDxB9BYGTFVnQqFhRzHGKcLD9zNpKPGXhiSN3uuvzavfC7VtXw6kNID9f8iEf/WOoqeGBuGRmQggHwBFUbR0oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776945717; c=relaxed/simple;
	bh=KM2UWxJdDtbafNJCdvc9QOth2uvBdUVM62K2HwN8lNM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BG6SukSfZvDwJ2CyE7QcWUuPx+IHRsPUdyEwFDj9CzfBn4xgv2yX5I/imBS4HxwauwHyxIVWv/sOxaM7+CIXz2nGMJ5zGqyfqZGCWvNJTX48zPRwWNps8E/040NdwFB6s4I0ZaOgggsZh287pW1HcEztTdDDWkG0sFVd0T0RvXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fOxPqJZ5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 834FAC2BCAF;
	Thu, 23 Apr 2026 12:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776945717;
	bh=KM2UWxJdDtbafNJCdvc9QOth2uvBdUVM62K2HwN8lNM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fOxPqJZ5wZhAIIJUFr+0WAhXKV4CDwc23++xvSzIv3L9zwTC5jtTssQt5dXWnatkj
	 kZAja9MlFhVucdq9Yl8xtAywM2dekjMidwIP1CAUqGL2b1evuH4KYc6mhnXDF/5IOl
	 gCEZZ1pj0goDqXqCg2CPQt6nli26qtRt7NYbUoqY=
Date: Thu, 23 Apr 2026 14:01:54 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: nobuhiro.iwamatsu.x90@mail.toshiba
Cc: sashal@kernel.org, stable@vger.kernel.org,
	cip-dev@lists.cip-project.org, pavel@nabladev.com,
	chris.paterson2@renesas.com
Subject: Re: [for 5.10.y] Please revert "8af1c121b0102 riscv:
 Sparse-Memory/vmemmap out-of-bounds fix"
Message-ID: <2026042343-recoil-retriever-8076@gregkh>
References: <TY7PR01MB1481866BE80F41418D964AE61CD4EA@TY7PR01MB14818.jpnprd01.prod.outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TY7PR01MB1481866BE80F41418D964AE61CD4EA@TY7PR01MB14818.jpnprd01.prod.outlook.com>
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-240476-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 8B14C451C2A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 18, 2026 at 02:03:44AM +0000, nobuhiro.iwamatsu.x90@mail.toshiba wrote:
> Hi Greg and Sasha,
> 
> Please revert "8af1c121b0102 riscv: Sparse-Memory/vmemmap out-of-bounds fix" in Linux-5.10.y branch.
> Since `phys_ram_base` is not defined in riscv, a build error will occur if `CONFIG_SPARSEMEM_MANUAL=y`.


Can you send a revert with this information in it?

thanks,

greg k-h

