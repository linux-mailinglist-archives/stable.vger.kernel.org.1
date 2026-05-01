Return-Path: <stable+bounces-242432-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WPanJ8mu9GlGDgIAu9opvQ
	(envelope-from <stable+bounces-242432-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 15:46:49 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F2E74ACDBC
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 15:46:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C57AE301CA4F
	for <lists+stable@lfdr.de>; Fri,  1 May 2026 13:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 021E73A63F8;
	Fri,  1 May 2026 13:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aDIWzTqM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B1A175A7B;
	Fri,  1 May 2026 13:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777643201; cv=none; b=dB8ls84D205asuAyQq9FRxH0bOPuv8F8TivJWa2KeS/r2eMEBxDEnunaj/QJ1t63n3ejR3rXNq7sSdRoKM42m0II+4Aj/iLKowC+zaYC0Ll1UXVhxI/yDq2YarQ/LmeiS4X9uJTF/12aunIo7F0K67IjDwA8SBDjVmsjXDc9v8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777643201; c=relaxed/simple;
	bh=DXShWkKHOypxgrHx51c+Dn3bDwcz+9RfvpjNu7ri7iA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ATVyqpH3vQCRW9Co8b3RWMRmLheP2PUdXW19jV44gqf+LqT32rlYnspmWzYPDK3yYtzaMaGmG7pyLwC+HKjwpKTSO6zl8B6imcwjB1hkDANVIY+BSCGD2sNjJyOdbK42KPtUd/az9HxeFFdnKkrJuBm+lWxLC30OeYS3gWF+ZyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aDIWzTqM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43BB5C2BCB4;
	Fri,  1 May 2026 13:46:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777643201;
	bh=DXShWkKHOypxgrHx51c+Dn3bDwcz+9RfvpjNu7ri7iA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aDIWzTqMtUmF/uEIAFcaZxO61bnWUc4w+fETV4yHkCWrWityyCnJnu7mqNiK/S+0d
	 9v5pPV82UKxCPYMwot/DfeQRPkVoo88x1qH8pXCJdRhX2GTs3eQ9QXufJ3X6KJ5blF
	 QHiXoB93Szw+ZZwZkFfIAa+r36wrhA3MwNY9vs/g77EOlhgE/gOUEzdwHYiZv9dNCj
	 DzD58SaHXwusVtgCbirmUlm4X8qzrFJFii42sJ8zZVf+3n4qPWhViBTAn5MqzM0GPu
	 hMp3HXi9W2z4VEnpX2UllyYRAnpUBsnhXsS/NZXKtkCUqUkl/1tVcdZYebHJORU2YN
	 ocdHlpVVieE9w==
Date: Fri, 1 May 2026 14:46:36 +0100
From: Simon Horman <horms@kernel.org>
To: mike.marciniszyn@gmail.com
Cc: Alexander Duyck <alexanderduyck@fb.com>,
	Jakub Kicinski <kuba@kernel.org>, kernel-team@meta.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net] net: eth: fbnic: Fix addr validation in pcs write
Message-ID: <20260501134636.GE15617@horms.kernel.org>
References: <20260429150049.1643-1-mike.marciniszyn@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260429150049.1643-1-mike.marciniszyn@gmail.com>
X-Rspamd-Queue-Id: 3F2E74ACDBC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-242432-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[horms.kernel.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Wed, Apr 29, 2026 at 11:00:49AM -0400, mike.marciniszyn@gmail.com wrote:
> From: "Mike Marciniszyn (Meta)" <mike.marciniszyn@gmail.com>
> 
> This patch contains a fix for addr validation in fbnic_mdio_write_pcs().

Hi Mike,

I think this warrants a bit more explanation: Why should addr 2 be
accepted? What happens from a user-perspective when it is not?

> 
> Cc: stable@vger.kernel.org
> Fixes: d0ce9fd7eae0 ("fbnic: Add SW shim for MDIO interface to PMD and PCS")
> Signed-off-by: Mike Marciniszyn (Meta) <mike.marciniszyn@gmail.com>

...

-- 
pw-bot: changes-requested

