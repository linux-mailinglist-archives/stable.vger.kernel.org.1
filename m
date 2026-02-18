Return-Path: <stable+bounces-217316-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sFbDK90MlmlZZQIAu9opvQ
	(envelope-from <stable+bounces-217316-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 18 Feb 2026 20:02:53 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E971158DC8
	for <lists+stable@lfdr.de>; Wed, 18 Feb 2026 20:02:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8C8AC301E22F
	for <lists+stable@lfdr.de>; Wed, 18 Feb 2026 19:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9346345CB0;
	Wed, 18 Feb 2026 19:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vCnDsVCh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 690CC2D0C79;
	Wed, 18 Feb 2026 19:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771441324; cv=none; b=rzuINlvARx7GKTevqIXSM82jvr7VXeNS/wCpuLcT+UlNXv6b3rV8QR0HbaPiAZwjcvpzUES0BogXuXzdiuo3wLTxDRFv4f2qM54o3HF8gqGGeqIWAKXaZu+U7gLSq2Wec42RF3XQhtTLPk7BEEfROb3Cop1kXxUCxfejxtFY5x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771441324; c=relaxed/simple;
	bh=wJbdnD9kDur8MQo4aCLViU38ZVna+QFDEBCwfpRr6BI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W+ifdnVIMfLaVmWcJDL+7ZP6jRP/la4eITqGwCYA0keye92oLd9YOo6jAt1gUFR1IW1XiY0XSX8wlvYO3jSvncSUwjFYqxnGcEu1qhytHl2ZY4ixZIzL+u4pZjQ9UMNKwrsKHnLaqYzA1iP3uyGeFpkOGNGNZHikIkHCAOjHDNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vCnDsVCh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 840ACC116D0;
	Wed, 18 Feb 2026 19:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771441324;
	bh=wJbdnD9kDur8MQo4aCLViU38ZVna+QFDEBCwfpRr6BI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vCnDsVChhf1kdLnFSEyX2IbcZCgizz8434IM/RUCtHjiApJwq4weFdMcszTnwPCW6
	 Q1vKs1mkOXjFmD0+Yt/dvlaKRFE/s0ela1QwOAC2jbXVZZL9edjBSluvc19BGoGLNR
	 m26eIbjRGoxVYcgExFTPPRdDZQS+ML/26/Bo89zhL02fiGwGrSY47elLrpnFRz+m4v
	 TrjOD5ZnhDAsCnP/UYsRUbTyikFBRiNG2GUe28kUyadyysyfPle72MSMljsRH9Umfp
	 vz3/OVnEgkj0OHU/42XIwALJlGGFPv6atNN8wC3x39dDmlG75StDoo2xQjycEwmGlr
	 /E2pQhdPWjwFw==
Date: Wed, 18 Feb 2026 12:02:01 -0700
From: Keith Busch <kbusch@kernel.org>
To: Farhan Ali <alifm@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, helgaas@kernel.org, lukas@wunner.de,
	alex@shazbot.org, clg@redhat.com, stable@vger.kernel.org,
	schnelle@linux.ibm.com, mjrosato@linux.ibm.com,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v9 3/9] PCI: Avoid saving config space state in reset path
Message-ID: <aZYMqQhB6nZNMh8i@kbusch-mbp>
References: <20260217182257.1582-1-alifm@linux.ibm.com>
 <20260217182257.1582-4-alifm@linux.ibm.com>
 <aZS9X_CQBuo7gQpC@kbusch-mbp>
 <2818bf62-54c0-4416-82fe-b47f5ae2fcd0@linux.ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2818bf62-54c0-4416-82fe-b47f5ae2fcd0@linux.ibm.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-217316-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kbusch@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7E971158DC8
X-Rspamd-Action: no action

On Tue, Feb 17, 2026 at 11:55:43AM -0800, Farhan Ali wrote:
> 
> Yes I think you are right, with this change the PCI Command register gets
> restored to state at enumeration. So we will lose the updated state after
> pci_clear_master() and pci_enable_device(). I think we can update the vfio
> driver to call pci_save_state() after pci_enable_device()?

Either that, or move the pci_enable_device() call to after the function
reset.

