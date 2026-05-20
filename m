Return-Path: <stable+bounces-252790-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aFVNBLb+DWo95QUAu9opvQ
	(envelope-from <stable+bounces-252790-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:34:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A5AA3596A1F
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:34:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 20A783019E7F
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E1D43F9F25;
	Wed, 20 May 2026 18:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ksr47Umh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD57C3D1CC6;
	Wed, 20 May 2026 18:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779301597; cv=none; b=P+S6uNzZNCDwgT8csd5QWbzuLfRmA9NAEhDXkNoY5iGEBl24NpwfFXGn7+drOxUA+CqAIEu4l2IXkrzTxOu8IspLPD8a3yMPZoEp1ZsCFE4neM44abYpTT+FUEeiqIIMkIkEz31Um5UPO8NTZY6xUd2ujsKulCG/xli3Bt60ko8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779301597; c=relaxed/simple;
	bh=KUydEpovcBPYeR4C0UDAhGsJmHakOtdlzuyopm73MyY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o1MVGlg8Uxgxa5+cB0/+zTdyqvjsvCl/Cnu5rGeN0Oqcp2cNnjn1HPdJXZeGHF02o0b2wfU0wGmwuH33wlZxAg5AIPSo/PJ6vKXlOOTaO4CYILkgNBH0YvO8nwg7X3UBELUBe0UOisQHM5i7d3f2crXkL9oLiwv8T6NsAJGSJgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ksr47Umh; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 902251F000E9;
	Wed, 20 May 2026 18:26:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779301596;
	bh=3gdi3fMT6kGU35jxcpi4fygQbKR2yAaoq099sRj7Amw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ksr47UmhVHbr5BOqe2H0UftnrtEY2bK2sTK5b60EB1cwBxR+X89rIMzpZmDdMwGg+
	 H58nZRNvSArBUJcsZzafOq61zm6PY81SYrJ1aa8WtnUDuxdQ1RtrG1tcAmXECKYxkA
	 zxqbIlFV2UyzOFqvcypmt5tPDc8QUnX3BGQC6nWFwwY4d7p2HyCKYAHDx5VgIXg5lD
	 4fqHaXlIGB+C35vrjTcOtaPGAGAnX2B9o/6dDg8Y2FeOStvpBhuzDRbmylyLDiGbtg
	 kGqqYmekote8d7TgLQ9iOF2i91DiNE6l8Nn6Yrm8ZuS+HZobInqALIYvmLLUZGDFDC
	 WKu3g3AukS9GA==
Date: Wed, 20 May 2026 19:26:31 +0100
From: Simon Horman <horms@kernel.org>
To: David CARLIER <devnexen@gmail.com>
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net v2] idpf: handle NULL adev in idpf_idc_vdev_mtu_event
Message-ID: <20260520182631.GD988238@horms.kernel.org>
References: <20260514183019.49527-1-devnexen@gmail.com>
 <20260519195734.982404-1-horms@kernel.org>
 <CA+XhMqxFmJm_fQ9aqRmwbG10+Bs8RgJ5kAff9-qtcrvgmfFMug@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+XhMqxFmJm_fQ9aqRmwbG10+Bs8RgJ5kAff9-qtcrvgmfFMug@mail.gmail.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252790-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,horms.kernel.org:mid]
X-Rspamd-Queue-Id: A5AA3596A1F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 19, 2026 at 09:19:23PM +0100, David CARLIER wrote:
> > This is an AI-generated review of your patch. The human sending this
>   > email has considered the AI review valid, or at least plausible.
> 
>   Thanks for relaying this, Simon.
> 
>   The scenario this patch fixes is sequential, not concurrent:
>   idpf_idc_vport_dev_ctrl(adapter, false) has already returned and
>   vdev_info->adev is NULL by the time ndo_change_mtu reaches
>   idpf_idc_vdev_mtu_event(). The original code dereferenced
>   vdev_info->adev in device_lock() before the NULL check and oopses
>   deterministically; READ_ONCE() + early-return resolves that.
> 
>   A truly concurrent idpf_idc_vport_dev_ctrl(_, false) racing an
>   in-flight MTU event is a separate, pre-existing window: the original
>   code took no reference between reading vdev_info->adev and
>   dereferencing it either, so this patch neither introduces nor widens
>   it. I haven't constructed a concrete interleaving against auxiliary-bus
>   teardown and have no report of it triggering.
> 
>   Happy to post a follow-up bracketing the handler with
>   get_device()/put_device() if you'd prefer, but I'd rather keep this
>   one scoped to the Fixes: target.

Hi David,

Thanks for the clarification.
I agree we can treat concurrency as a separate issue.


