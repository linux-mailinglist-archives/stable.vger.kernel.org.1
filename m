Return-Path: <stable+bounces-233830-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KBjrKacy1mlZBwgAu9opvQ
	(envelope-from <stable+bounces-233830-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 12:49:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 035C33BAEAD
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 12:49:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6628D3015CA6
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 10:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74BAC3B0AC8;
	Wed,  8 Apr 2026 10:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Jh0ejZBu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3029639EF32;
	Wed,  8 Apr 2026 10:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775645175; cv=none; b=dqblCQQEQnETKtZPYawcNk1Lu/hmF23+/b076d2BkWDl7445MyMUDCUN3WWLhrdeXmS2bh1dqjcpoCbtduMXI4vxYKswNoiVTv+nx8DmUjhiwJgkWoHZ/xVtkcVH6RaAdNgJRSqz7T5oIAc7OgovCoRt8SceqL3AHn9GS2QCq38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775645175; c=relaxed/simple;
	bh=4h1CwtF278yYJjTLPSP1P9LbY0I2pL8N6Sph/eMspqw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PJED8yTV3Pgakhp2VIYe1VtjH2zets5dTVx8YC21wL3VSKYEDnWgQMNeR04ELzZ0KofQdf9T3TAbB81ZFARul4Dl3MumQQtIrkmWkMCKusF/qFa6GyqYC1GFNN2H0bC42VwAuxyzbwas1kDv5JpzRATpbrk7ZKVGMaQCkzC00+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Jh0ejZBu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72E6BC19421;
	Wed,  8 Apr 2026 10:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775645174;
	bh=4h1CwtF278yYJjTLPSP1P9LbY0I2pL8N6Sph/eMspqw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Jh0ejZBuEZnIOGK3V/V9FqLGrgG1kv6OLVjdUnn6eAD6UUi/wfgiBAojpzHGpqilJ
	 Jlmx3h58KjHrGi3Lc01NaikEYSZkglPKcOZUtyeSewlEHc/BvqdGSgePtqJ3eEJg8w
	 yVmhBvN9kivOwUWbakGNC0qfdNgF9VCC8rsycOFE=
Date: Wed, 8 Apr 2026 12:46:12 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Cc: lgirdwood@gmail.com, broonie@kernel.org, tiwai@suse.de,
	linux-sound@vger.kernel.org, kai.vehmanen@linux.intel.com,
	ranjani.sridharan@linux.intel.com, yung-chuan.liao@linux.intel.com,
	pierre-louis.bossart@linux.dev, stable@vger.kernel.org,
	liam.r.girdwood@intel.com
Subject: Re: [PATCH for 7.0 1/2] ALSA: hda/intel: enforce stricter
 period-size alignment for Intel NVL
Message-ID: <2026040848-stiffness-generous-94c3@gregkh>
References: <20260408084514.24325-1-peter.ujfalusi@linux.intel.com>
 <20260408084514.24325-2-peter.ujfalusi@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260408084514.24325-2-peter.ujfalusi@linux.intel.com>
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
	TAGGED_FROM(0.00)[bounces-233830-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,suse.de,vger.kernel.org,linux.intel.com,linux.dev,intel.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 035C33BAEAD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 08, 2026 at 11:45:13AM +0300, Peter Ujfalusi wrote:
> From: Kai Vehmanen <kai.vehmanen@linux.intel.com>
> 
> Intel ACE4 based products set more strict constraints on HDA BDLE start
> address and length alignment. Modify capability flags to drop
> AZX_DCAPS_NO_ALIGN_BUFSIZE for Intel Nova Lake platforms.
> 
> Fixes: 7f428282fde3 ("ALSA: hda: controllers: intel: add support for Nova Lake")
> Signed-off-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
> Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
> Reviewed-by: Liam Girdwood <liam.r.girdwood@intel.com>

This also needs a:

Cc: stable <stable@kernel.org>

As the commit you reference here is in the stable 6.19.y tree.

thanks,

greg k-h

