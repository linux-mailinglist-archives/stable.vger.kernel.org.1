Return-Path: <stable+bounces-235424-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OHlrGgS812l0SAgAu9opvQ
	(envelope-from <stable+bounces-235424-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 16:47:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B71C63CC2D9
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 16:47:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0CBE93008620
	for <lists+stable@lfdr.de>; Thu,  9 Apr 2026 14:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78EF5317174;
	Thu,  9 Apr 2026 14:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XqY+n6TF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8991F3C9EDF
	for <stable@vger.kernel.org>; Thu,  9 Apr 2026 14:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775745977; cv=none; b=rGjHTSD02daN0FZh5ztSNVJQKB3nPxsnE8ns4JwbAjGh61nTe8Sd8f3DRoVwNNk8NCTTuzHcyZW/T7KIwmTdaaKlj3cprENG8zI2KyC/E5jzZ7pCZEzyFS/5aNkI+cuhtvhV52C8SIn7EuKsdQd+gIKOUoZWGSIZLw1SLBfTj98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775745977; c=relaxed/simple;
	bh=T35BGxbe9vba0/1akVI7mx/ig6bpncunsVmmRE4j47U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JYNGskgGWqIUnhCGywl/a6yFLvusJDSDpjDVgiaweCI05oqzFhAEb/R9xEWQxtjNMPJaWk05h1PubhLj3h4Qr71StKJVeGz7CecbULZ81XLfSV7XB3lvFz0+7JdNzznILIh0Vbm/ZZr0w8VzoXNReMnmLNkxjfdVFUnYfrDz/g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XqY+n6TF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51276C4CEF7;
	Thu,  9 Apr 2026 14:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775745976;
	bh=T35BGxbe9vba0/1akVI7mx/ig6bpncunsVmmRE4j47U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XqY+n6TFYujmsfoNO86609Rb6EwRKuZyXEzmohjog791ZVu3RQ+fwO6NiDsbNleyi
	 g4W5qQ7HqNROsA15JgQkxNgY5XNU6sKlRnb86yPeqUrBpX0SBXE7hihirIoAhkymdQ
	 6tqwKkatvYLsVgPA8FQweuXddrhNCHgCkD5ubwgfMd5myZAJtycPrD1EL+8yy770j5
	 Tc0Kl1184pQO3kP2Qj21y9WeQhFI5+63J5gEiQ317YXHY+sdUFMJ/vKHAT+rRgPkCa
	 Rbmyo07D0OTGiH99Q+GGqQT2DrFFlEhN0mQzQIdLprcMkrS6zn1VkKKcMDuuOnmKPr
	 PSsfx1CFYvgQA==
Date: Thu, 9 Apr 2026 08:46:14 -0600
From: Keith Busch <kbusch@kernel.org>
To: Chaitanya Kulkarni <kch@nvidia.com>
Cc: hch@lst.de, sagi@grimberg.me, roys@lightbitslabs.com,
	linux-nvme@lists.infradead.org, stable@vger.kernel.org
Subject: Re: [PATCH] nvmet: avoid recursive nvmet-wq flush in nvmet_ctrl_free
Message-ID: <ade7trJ74HWR5AY5@kbusch-mbp>
References: <20260409005647.112289-1-kch@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260409005647.112289-1-kch@nvidia.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-235424-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kbusch@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Queue-Id: B71C63CC2D9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 08, 2026 at 05:56:47PM -0700, Chaitanya Kulkarni wrote:
> nvmet_tcp_release_queue_work() runs on nvmet-wq and can drop the
> final controller reference through nvmet_cq_put(). If that triggers
> nvmet_ctrl_free(), the teardown path flushes ctrl->async_event_work on
> the same nvmet-wq.

Thanks, applied to nvme-7.1.

