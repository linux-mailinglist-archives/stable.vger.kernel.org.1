Return-Path: <stable+bounces-236009-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EBj9NOfb3GlwXgkAu9opvQ
	(envelope-from <stable+bounces-236009-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 14:04:55 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D2A53EBAFA
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 14:04:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 385A830099AA
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 12:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A5FC31AF1B;
	Mon, 13 Apr 2026 12:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Bjm7TQmM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33093218B3
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 12:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776081890; cv=none; b=cb4thy/zpOWHHFb0FJmoPSnUhuox3yxFVClEd3x/CKdRM6VZqd42ateFwECRhnjGs1BbLAyaNbsKb/DLNaW8ZQg/vLbjNyzCpGDxrUTeyep1saoaA723A9IvAblZnDFQfCbrUFadJsVhhUwfwck5NlYIm+GUrI9QTvjx7e6Nc2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776081890; c=relaxed/simple;
	bh=dMutkLiyx6qfQhmqv9LhRSnD9/y0OHEuHZXN4RYR4+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UghA40+HnKfht9ElIr5eZ1EqOxqTit6vfYO+gZ/vOkDcUSWRgGkvYSFZPgf1NEj+aIeETJYQ8qo2ac4MOjLdeXTfmUCaWRZqwouqirSF+iuQ7WV0MYPm/CRT8NsVjR1jiN7HC123gsTIEtfTJy7YmKwqxb1SCZ5smkZCJ7CfdGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Bjm7TQmM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 174C4C116C6;
	Mon, 13 Apr 2026 12:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776081890;
	bh=dMutkLiyx6qfQhmqv9LhRSnD9/y0OHEuHZXN4RYR4+c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Bjm7TQmMsUQfyKoqEjUxB1+Q3d96tJavpKQQv8xit/W1MqPj6C4KtfLPWUFIZA064
	 lT422+9g3FPV6hDm5w7pH4LpQW+5bLPAoGKGnouvfirYGexkyK9yNp9lQos06HEMgi
	 ljt1kcaJ4ruyJRdjgTljBlhmMkWPBBefw7ThLdHw=
Date: Mon, 13 Apr 2026 14:04:48 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Charles Xu <charles_xu@189.cn>
Cc: wei.fang@nxp.com, vladimir.oltean@nxp.com, kuba@kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 6.1.y] net: enetc: VFs do not support
 HWTSTAMP_TX_ONESTEP_SYNC
Message-ID: <2026041329-recovery-disjoin-b370@gregkh>
References: <20260413032322.4206-1-charles_xu@189.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260413032322.4206-1-charles_xu@189.cn>
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[189.cn];
	TAGGED_FROM(0.00)[bounces-236009-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Queue-Id: 4D2A53EBAFA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 13, 2026 at 11:23:22AM +0800, Charles Xu wrote:
> From: Wei Fang <wei.fang@nxp.com>
> 
> [ Upstream commit a562d0c4a893eae3ea51d512c4d90ab858a6b7ec ]
> 
> Actually ENETC VFs do not support HWTSTAMP_TX_ONESTEP_SYNC because only
> ENETC PF can access PMa_SINGLE_STEP registers. And there will be a crash
> if VFs are used to test one-step timestamp, the crash log as follows.
> 
> [  129.110909] Unable to handle kernel paging request at virtual address 00000000000080c0
> [  129.287769] Call trace:
> [  129.290219]  enetc_port_mac_wr+0x30/0xec (P)
> [  129.294504]  enetc_start_xmit+0xda4/0xe74
> [  129.298525]  enetc_xmit+0x70/0xec
> [  129.301848]  dev_hard_start_xmit+0x98/0x118
> 
> Fixes: 41514737ecaa ("enetc: add get_ts_info interface for ethtool")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> Tested-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> Link: https://patch.msgid.link/20250224111251.1061098-5-wei.fang@nxp.com
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Charles Xu <charles_xu@189.cn>
> ---
>  drivers/net/ethernet/freescale/enetc/enetc.c         | 3 +++
>  drivers/net/ethernet/freescale/enetc/enetc_ethtool.c | 8 ++++++--
>  2 files changed, 9 insertions(+), 2 deletions(-)

This breaks the build, ALWAYS test-build your patches.

thanks,

greg k-h

