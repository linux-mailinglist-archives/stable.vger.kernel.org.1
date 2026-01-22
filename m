Return-Path: <stable+bounces-211250-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ELDaBUQ8cmnTfAAAu9opvQ
	(envelope-from <stable+bounces-211250-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 16:03:32 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E9554684C2
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 16:03:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B60653002D3A
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 15:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01A3C2ED87C;
	Thu, 22 Jan 2026 15:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gK2cujjm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C0226D4EF;
	Thu, 22 Jan 2026 15:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769094157; cv=none; b=QrWOLvYuwFhq0NJIWHhmXggKdDFYLH7N0nVjo22+sgmrvBAeQsR13Ll8EDGotSpXI+kqiPPpU3DkN9+0LbxOtNXY7/tGjqOIshXUT+YKSsjx2p61isQPfLNp6Yu3rNI4CeAj9Db+WeWjyjz1d+bNUa2340Ikm5gW0c//r1H8tn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769094157; c=relaxed/simple;
	bh=FS/3Zs7nsDXrEKGlXb5BBxbZ/HRhrpXAqkdEcmopUUc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SUEWDNViSrGskBiiQxQ6nmDC3zoV3Hki0HXP2auW0Aq0TokFWU+WZuSBmpEu+QTBC/RhQ6lUcWpuXo5WEvd6FKzj19BGQlPFRCUJgAdkZ3412EpoE3z8CDXibR7cnBRwkadSbdO0oj+NUGlqwyUJapXxCBCgf4q+5JsT+jv8BlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gK2cujjm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 894D0C19423;
	Thu, 22 Jan 2026 15:02:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769094157;
	bh=FS/3Zs7nsDXrEKGlXb5BBxbZ/HRhrpXAqkdEcmopUUc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gK2cujjmYB20cORjPTmXZZEjgiwJLJvVsqkp+d1Fbg+6fAaTt+SbtOr7N/JSUAKO5
	 sTjKJnlWd3yqaFRhBfxgO3AxPQZe1Vl8+XHtQVJ4WumQdOl9H94KPnpprJ/3pKI+co
	 KxKdAw7eDGVVX3USlL1+qLyx7a9WQlr7hIPkwfm5+u+WQix/rIij83xVivg42dd9Cw
	 DSxtobWDHLzn74ZLk9xGoQceomQt8Kg7Pmotf7gBLkDKFtaXQzEpzVHyR3WgJ+lXao
	 qGdPRiCornOZd7NPCsg+FUI3Y/mKSednDU71vJy1oeKEZjBaJgh/kLeOeEiFwNKcwU
	 5ZoN/U+P6q33Q==
Date: Thu, 22 Jan 2026 16:02:31 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Frank Li <Frank.Li@nxp.com>,
	Serge Semin <Sergey.Semin@baikalelectronics.ru>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	macro@orcam.me.uk, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/3] PCI: dwc: Fix skipped index 0 in outbound ATU
 setup
Message-ID: <aXI8ByG3RlLpIRRa@ryzen>
References: <20251229-ecam_io_fix-v2-0-41a0e56a6faa@oss.qualcomm.com>
 <20251229-ecam_io_fix-v2-1-41a0e56a6faa@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251229-ecam_io_fix-v2-1-41a0e56a6faa@oss.qualcomm.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-211250-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,google.com,nxp.com,baikalelectronics.ru,vger.kernel.org,orcam.me.uk];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cassel@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: E9554684C2
X-Rspamd-Action: no action

On Mon, Dec 29, 2025 at 04:12:41PM +0530, Krishna Chaitanya Chundru wrote:
> In dw_pcie_iatu_setup(), the outbound ATU loop uses a pre-increment
> on the index and starts programming from 1, effectively skipping
> index 0. This results in the first outbound window never being
> configured.

This in not true.

outbound iatu at index 0 is used for CFG IOs, see dw_pcie_other_conf_map_bus()
and:
https://github.com/torvalds/linux/blob/v6.19-rc6/drivers/pci/controller/dwc/pcie-designware-host.c#L888


Also see my series here:
https://lore.kernel.org/linux-pci/20260122145411.453291-4-cassel@kernel.org/T/

That tries to clean up this mess.


Kind regards,
Niklas

