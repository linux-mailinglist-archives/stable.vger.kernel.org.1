Return-Path: <stable+bounces-211446-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YC7KKbCBdGl96QAAu9opvQ
	(envelope-from <stable+bounces-211446-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 24 Jan 2026 09:24:16 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F1D2E7CFC8
	for <lists+stable@lfdr.de>; Sat, 24 Jan 2026 09:24:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 29B1F3013A46
	for <lists+stable@lfdr.de>; Sat, 24 Jan 2026 08:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00AE429E0E9;
	Sat, 24 Jan 2026 08:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="R6Q67MmU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B79E12773EE
	for <stable@vger.kernel.org>; Sat, 24 Jan 2026 08:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769243023; cv=none; b=NAA6tn1a3BQXxnPH5bdTrmJJYlqzyrVsMbTFP+pulANw2mv7USczaSt8gQ0UOZRFwZwnbxoHojMYuP7gGrWVdMkMxOBop62H4Wf2aWrlK2zEGBX/f2044uZLb+b18SDru5ii3fCMWAlSCBJSPyBUPGYlpMkj5F3Y0/9Wz6/S+KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769243023; c=relaxed/simple;
	bh=5gt8Qj7KZSDASQSIIGjVZd+CVGqtMCgYMgh8vIbjklk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fziUU4KvFoPE0KdNVO2ozj98LQDaglBNy8kwuPM/Y7QlXsaPys7vmd8PVaRoeJ09ZR3ef91TQ2/4sNA9srkEFVYCATKfbpYG4CtQ/BbA88V5ixYlqBylUPTDX1JDJcTgQjhTapkKAWaMdOpN9YcUsN4lr9Hq8twaDkzEj/1VJQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=R6Q67MmU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EECB1C116D0;
	Sat, 24 Jan 2026 08:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769243023;
	bh=5gt8Qj7KZSDASQSIIGjVZd+CVGqtMCgYMgh8vIbjklk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R6Q67MmU2LcrHFA98nmI4CVD9J7cZCYQPxGCVNKsLejuiJ5oeMT7vkIsLfKEw4GQv
	 eTz5ycNZZWHbDhoeSym9MeBfa1TZqrZFBJwKreKQof3UIm+IqLbnQQ7YWgOTj2Quu9
	 qy4/4r2/wCxuZA5Kd+H3ayGr0GePZ68fsukzROuw=
Date: Sat, 24 Jan 2026 09:23:40 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: PRC Automation <prc@list.ti.com>
Cc: Siddharth Vadapalli <s-vadapalli@ti.com>, praneeth@ti.com,
	u-kumar1@ti.com, vigneshr@ti.com, stable@vger.kernel.org
Subject: Re: [tiL6.18 PATCH] FROMLIST: arm64: dts: ti: k3-am62d2-evm: Fix
 missing RX delay for DP83867 PHY
Message-ID: <2026012406-saga-tactical-fd5e@gregkh>
References: <20260124070651.2152967-1-s-vadapalli@ti.com>
 <20260124080029.2810485-1-prc@list.ti.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260124080029.2810485-1-prc@list.ti.com>
X-Rspamd-Server: lfdr
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
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-211446-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,couthit.com:email,ti.com:email,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: F1D2E7CFC8
X-Rspamd-Action: no action

On Sat, Jan 24, 2026 at 02:00:29AM -0600, PRC Automation wrote:
> ti-kernel / 6.18 / 20260124070651.2152967-1-s-vadapalli
> 
> PRC Results: FAIL
> 
> =========================================================
>   apply-patch: PASS
> =========================================================
> Summary:
> - Patch Series: [tiL6.18 PATCH] FROMLIST: arm64: dts: ti: k3-am62d2-evm: Fix missing RX delay for DP83867 PHY
> - Submitter: From: Siddharth Vadapalli <s-vadapalli@ti.com>
> - Date: Date: Sat, 24 Jan 2026 12:36:46 +0530
> - Num Patches: 1
> - Mailing List (public inbox) Commit SHA: 17b1d51fe2ff3be3a867d71baf22dbb3153135b6
> 
> Applied to:
> - Repository: lcpd-prc-ti-linux-kernel
> - Base Branch: ti-linux-6.18.y-cicd
> - Commit Author: Parvathi Pudi <parvathi@couthit.com>
> - Commit Subject: UPSTREAM: ARM: multi_v7_defconfig: Enable TI PRU Ethernet driver
> - Commit SHA: 3e1b5fb10cace2688eecd366e85af7c1f5a69fac
> 
> Patches
> ----------------------------------------
> All patches applied

Was this email ment to be sent to stable@vger.kernel.org?  If not,
please fix up your scripts.  If so, what are we supposed to do with
this?

thanks,

greg k-h

