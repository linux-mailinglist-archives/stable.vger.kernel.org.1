Return-Path: <stable+bounces-241911-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2LRYFSon8mm/oQEAu9opvQ
	(envelope-from <stable+bounces-241911-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 17:43:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E14E64972A6
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 17:43:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9B8DA307CFF3
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 15:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A61EE1E98E3;
	Wed, 29 Apr 2026 15:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TM0IbcRK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 677BC32B9B6;
	Wed, 29 Apr 2026 15:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777476780; cv=none; b=TIZVq3ZdRltt5M4nl5SxTp9lQ8/3s43j4Zq2J8w3TmFddHyKvbTTkVKkHN2NfdaXbYAk65uwJs12nkWNXG+WoZ7FRYkAlr3Ew/MPHHDliA1WahswR+DYDFtppuFc7ah/5yA1LoSxWIfVNv3AQMmKHU2gcA9Y5raGfVzU4QyAD8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777476780; c=relaxed/simple;
	bh=URdb+bnsd6YoFNNE4DWPPmw9+dR0csjdqtSLfFG0srw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h6xrQOToEv+5INVK2PW0Z8ZGVfyVNLJyV7xsGLqaiDkka6yRnAFhwbdT0vcMU4xV3W4PAahWZdDm+ndl75Vxo3c1ogGBlEAJJCb9fwb54YBbrE27t6NayD88rYxYtBghX/rbPvB4BokJK0tIyYRPCgfpiFxda383gO+qFTY9MXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TM0IbcRK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28A4CC19425;
	Wed, 29 Apr 2026 15:32:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777476780;
	bh=URdb+bnsd6YoFNNE4DWPPmw9+dR0csjdqtSLfFG0srw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TM0IbcRKFLYSceNS6aSZfRh7JxeorJxw6jxS9zUWkoML+3ofDheDiYgySL4q9FmWm
	 7NF9joYgQ3VZ4limSl5zZkq87z02VoNFek4Jf9nxjyzSRny9DLL3DYS+/cGjJtnxAe
	 SD1v4g9pEIoHC5tHKlMBgEMWCiK1wBkBoOsxBIJYb4af3NCZzTaeKJgZI6LWH8MeJX
	 NaIXRhFg9UwYuc+otB9t0Qh9q2HGDXhsminvbT0ND4NzMLhSHBdMTSSXfH+bvR94LU
	 87zv+oWQr4627FYdDmjGB6uUie+B3lxsjLJqWDluW8koFhFvs39kN9bdKpdiQr4CQ6
	 v0VBoluW1XSew==
Date: Wed, 29 Apr 2026 21:02:51 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Bo Sun <bo.sun.cn@windriver.com>
Cc: linux-pci@vger.kernel.org, stable@vger.kernel.org, 
	Bjorn Helgaas <helgaas@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Rob Herring <robh@kernel.org>, Lizhi Hou <lizhi.hou@amd.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: of_property: Omit 'bus-range' property if no
 secondary bus
Message-ID: <yegeytft4bgmvodslsjfwdeepnjkefd2xm62tiu6hvvfnqcl7r@yl4us3jznn4o>
References: <20260224062104.140453-1-bo.sun.cn@windriver.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260224062104.140453-1-bo.sun.cn@windriver.com>
X-Rspamd-Queue-Id: E14E64972A6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-241911-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mani@kernel.org,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]

On Tue, Feb 24, 2026 at 02:21:03PM +0800, Bo Sun wrote:
> The previous implementation of of_pci_add_properties() and
> of_pci_prop_bus_range() assumed that a valid secondary bus is always
> present, which can be problematic in cases where no bus numbers are
> assigned for a secondary bus. This patch introduces a check for a valid

Imperative tone, please.

> secondary bus and omits the 'bus-range' property if it is not available,
> preventing dereferencing the NULL pointer.
> 
> Cc: stable@vger.kernel.org
> Fixes: 407d1a51921e ("PCI: Create device tree node for bridge")
> Suggested-by: Bjorn Helgaas <helgaas@kernel.org>
> Signed-off-by: Bo Sun <bo.sun.cn@windriver.com>
> ---
>  drivers/pci/of_property.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/pci/of_property.c b/drivers/pci/of_property.c
> index 75a358f73e69..cade01ea6e68 100644
> --- a/drivers/pci/of_property.c
> +++ b/drivers/pci/of_property.c
> @@ -95,6 +95,9 @@ static int of_pci_prop_bus_range(struct pci_dev *pdev,
>  				 struct of_changeset *ocs,
>  				 struct device_node *np)
>  {
> +	if (!pdev->subordinate)
> +		return -EINVAL;

Returning errno is not 'omitting'. This will result in a failure of
of_pci_add_properties(). I hope that's not what you wanted.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

