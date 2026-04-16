Return-Path: <stable+bounces-238307-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QNksMjHN4GkdmAAAu9opvQ
	(envelope-from <stable+bounces-238307-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 13:51:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D5AFB40DAC4
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 13:51:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1E0A33013C61
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 11:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E34413A544F;
	Thu, 16 Apr 2026 11:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nCM1o3sf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC5D3932C8;
	Thu, 16 Apr 2026 11:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776340266; cv=none; b=dVzJKiXDZDltFnhrvJgO8NF0qeOGCHdmYSijxKBnlTN/GYWgmkwzsR/hoqapQcgFJ/Zf2FeAGd/ojUHnwe2e3KwVbmfBYYMYj/nQxOj/xjYPcFkdV7dwroFrd9ma99q8y4BLzii9Ay7NIfqIk8TBkHHAJKFNKA4xQYrrH5kybls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776340266; c=relaxed/simple;
	bh=TKWJ8p/+klvL0Ji1UNdX/q0dpEHAd8EBWtNWvAoOKlM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YQy6a0+OEL0wKoYuOajzRxz7mUXRwP0wMMcpzXTqsveXxfOf8+ZoqqnUu/Vx1KE3gZgkiEQnLt23cqgE/dbgu+WgZBjiG34krsKgtFXH0TWg4T62Gb+fbRuBsxVJ3jnNaOjhLOzhpmPesYqQQ+FVsHfzD29Baq39xXONQ4TK0WA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nCM1o3sf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ED54C2BCAF;
	Thu, 16 Apr 2026 11:51:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776340266;
	bh=TKWJ8p/+klvL0Ji1UNdX/q0dpEHAd8EBWtNWvAoOKlM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nCM1o3sfSVWCuRBQvAz2WuLL01aelizpQ4AvmNNSkeao1dRvVn6UUzYsfkPRs0hyT
	 Ais/iZiV5nqtt2X1T/CBuyvPgNigq/doN8TPV2DnZkmnQ183yj9kRFtQ5NT59uHLCA
	 WpArX+bniLoMgUNR4j8gAq3mj5vDaKGTvDeJ594hdn4uGWNp8SOdVna3EZBznM9W2h
	 fjVru/YuFMa+CYYAZobqGlz87SXW4IOWk7XsnzQLBTvyIPLX/5Gc1+vteppKtYWRDe
	 lj/boQH+vzVDsfsVIzPfyxwE3TNdD6I5dPjYJOBfFy1Emi23fRbK47N0AEn1xWEc7T
	 8gn2tBRSBZGlQ==
Date: Thu, 16 Apr 2026 06:51:04 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	stable@vger.kernel.org, saravanak@kernel.org
Subject: Re: [PATCH] of: unittest: fix use-after-free in testdrv_probe()
Message-ID: <177634026285.2720630.713375833377138851.robh@kernel.org>
References: <20260409034859.429071-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260409034859.429071-1-vulab@iscas.ac.cn>
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-238307-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[robh@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[iscas.ac.cn:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D5AFB40DAC4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On Thu, 09 Apr 2026 03:48:59 +0000, Wentao Liang wrote:
> The function testdrv_probe() retrieves the device_node from the PCI
> device, applies an overlay, and then immediately calls of_node_put(dn).
> This releases the reference held by the PCI core, potentially freeing
> the node if the reference count drops to zero. Later, the same freed
> pointer 'dn' is passed to of_platform_default_populate(), leading to a
> use-after-free.
> 
> The reference to pdev->dev.of_node is owned by the device model and
> should not be released by the driver. Remove the erroneous of_node_put()
> to prevent premature freeing.
> 
> Fixes: 26409dd04589 ("of: unittest: Add pci_dt_testdrv pci driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/of/unittest.c | 1 -
>  1 file changed, 1 deletion(-)
> 

Applied, thanks!


