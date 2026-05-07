Return-Path: <stable+bounces-244538-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8F9WItla/GndOQAAu9opvQ
	(envelope-from <stable+bounces-244538-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 07 May 2026 11:26:49 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D47B4E5DA8
	for <lists+stable@lfdr.de>; Thu, 07 May 2026 11:26:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CE4EE309AE9E
	for <lists+stable@lfdr.de>; Thu,  7 May 2026 09:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A95F13BA23A;
	Thu,  7 May 2026 09:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="e/RE5v25"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C56C392C56
	for <stable@vger.kernel.org>; Thu,  7 May 2026 09:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778145795; cv=none; b=mKmmrZpuL9SIMe3O1iIkbtDVcN1vL3eMZSpGn4furnI3Zdlkrh/8HUGEZtgXlIaX0dnT7JVVKBqM01vhhSCPQCZbgppCMVmPeNRAvPUuW+hOfTMI/yi6b8jIXHGd2SKOL34yU+8F4uR4B/eQT8ZpG0uqMWITBuan7ISmyRwcMx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778145795; c=relaxed/simple;
	bh=ZBf4ynZPqPT5uWa/taFgDuLy8niujpvGYBqmwsuITN0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uMtQaY1l1Cj0xBZGUjIR/M3qw4jegxB1a8g7lyPf1LQkmnZ9GoYWHhIkcgGcaWgzwFyJIh4BW6eLQ4KDI/AdmTPd/8uIvrpVOhI042BeFemqExXcfqoI9iGvY68i9JiS7PUh0yve22X0fJGq2LRc5KAH9yBn5lSQUnjaigl/vuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=e/RE5v25; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94F68C2BCB8;
	Thu,  7 May 2026 09:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778145795;
	bh=ZBf4ynZPqPT5uWa/taFgDuLy8niujpvGYBqmwsuITN0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e/RE5v25vxKvwE0nsx1sr6R45RD/32G4pwwLskK8x7jBbJZtOmsfwmFe9jiKF75Ec
	 0Zr9tX8K57LNL2/b9Pin26igWNjRMUxWaohuldYC/VkOpPu8Jv48n2lZn/WZiUvw4w
	 U5BxPaXFTXxL+letlsD+79jIKlcjYnOIqslmlpQk=
Date: Thu, 7 May 2026 11:22:32 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Yuan Tan <yuantan098@gmail.com>
Cc: stable@vger.kernel.org
Subject: Re: [STABLE] Backport requests for net/crypto fixes
Message-ID: <2026050731-copper-enactment-3ca4@gregkh>
References: <f0c6e3a5-2043-4611-9f6d-515aeb4922f6@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f0c6e3a5-2043-4611-9f6d-515aeb4922f6@gmail.com>
X-Rspamd-Queue-Id: 0D47B4E5DA8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	TAGGED_FROM(0.00)[bounces-244538-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On Wed, May 06, 2026 at 11:07:50PM -0700, Yuan Tan wrote:
> [STABLE] Backport requests for net/crypto fixes
> 
> Hi Linux stable team,
> 
> Please consider backporting the following 3 upstream bug fixing commits to
> the relevant stable trees. After my inspection, they have not been
> backported.
> 
> I am grouping these requests together for convenience. If you would prefer
> that I send one backport request per email, please let me know. 
> 
> MAINLINE_COMMIT                               MERGED_TO_MAINLINE_AT         TITLE
> 629ec78ef8608d955ce217880cdc3e1873af3a15    2026-04-02T09:57:06-07:00    mpls: add seqcount to protect the platform_label{,s} pair
> 426c355742f02cf743b347d9d7dbdc1bfbfa31ef    2026-04-09T08:39:25-07:00    net: af_key: zero aligned sockaddr tail in PF_KEY exports

These both are in stable releases, what specific tree(s) do you want it
in?

> 01d798e9feb30212952d4e992801ba6bd6a82351    2026-04-15T15:22:26-07:00    crypto: jitterentropy - replace long-held spinlock with mutex

What kernel tree(s) do you want this in?  Why was this not tagged for
stable already?

thanks,

greg k-h

