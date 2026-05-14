Return-Path: <stable+bounces-247224-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uPcGMAbhBWpsdAIAu9opvQ
	(envelope-from <stable+bounces-247224-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 16:49:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 885FC54376F
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 16:49:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5038B30EF87F
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 14:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56A4C40DFC3;
	Thu, 14 May 2026 14:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hsiUv2jW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 191D22580EE;
	Thu, 14 May 2026 14:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778769653; cv=none; b=Vg6Boq4BFbcYKxIUF2gX5tve2Q8rowSy0mC8DjeVjMET3HdAJdQSR6fKZb0hO8uhqcyDLPnfgUqAbb3IO3jfA7HRxxQYvKWqYTZcyY8+R/ox+M/U0djdfqRqcaVGGzJ9bB7Iqqh7qxK7QXfgDlwHJOWadbXOzOZm27T43hRMnMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778769653; c=relaxed/simple;
	bh=0x75qfZ974oSd0DncU4aTxFtPQ8gBmzZoEemuSqf3zc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZKbh11ndctaFWbF4sjLwA6u3ZYqc2spRb2qt4SxJ82jRAxsXOkyl8mcR9NYvFeIoSK+RyeFWq9RM9WUCNXhPkq4BuO7bwebb9hZ+L9WMRUEoukxjeWgf6PpDLgNqVTBlrGnAUoUtUXoEmy0nfD9IAJVACS11PKrOEP+nsjHsUi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hsiUv2jW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CC21C2BCB3;
	Thu, 14 May 2026 14:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778769652;
	bh=0x75qfZ974oSd0DncU4aTxFtPQ8gBmzZoEemuSqf3zc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hsiUv2jWzSZcTZyJ3ZxI4lwIXNvq6oZk0wdTmalRDH6gmavvQVOau0eatDbAmNE3E
	 dKMmjjjqB5w7o8AAE5Gx0bDZjjXftJaMOVzbTlcKvHDOY5RghDgdx7AEiqxHmw0Uea
	 0uPRNF0VaaA1bWhUx53DrHwBL+qjuFHb4zI4WReKoYuaE8350LwwkwWuibHeERtE4b
	 FhjLcGiK6RZLKw7LH0OhI7xnwr+uCbpBVyX6IxX+RlfbL2diZi4omvTa849vbNUDP4
	 zur04KOX4onh4bcnu0lPpDb1Bdt3w3nYVTCvNxUmPPLWRBU2GD8ZNgHIudj9ukZsAW
	 4uHikaYewcDSg==
Date: Thu, 14 May 2026 08:40:50 -0600
From: Keith Busch <kbusch@kernel.org>
To: Nick Chan <towinchenmi@gmail.com>
Cc: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>,
	Neal Gompa <neal@gompa.dev>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Yuriy Havrylyuk <yhavry@gmail.com>
Subject: Re: [PATCH v2] nvme-apple: Reset q->sq_tail during queue init
Message-ID: <agXe8lAqUu8Uwb1l@kbusch-mbp>
References: <20260514-nvme-apple-sq-reset-v2-1-84cbb5c70bf5@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260514-nvme-apple-sq-reset-v2-1-84cbb5c70bf5@gmail.com>
X-Rspamd-Queue-Id: 885FC54376F
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
	TAGGED_FROM(0.00)[bounces-247224-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,jannau.net,gompa.dev,kernel.dk,lst.de,grimberg.me,lists.linux.dev,lists.infradead.org,vger.kernel.org,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kbusch@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Thu, May 14, 2026 at 09:16:01PM +0800, Nick Chan wrote:
> Fixes a "duplicate tag error for tag 0" firmware crash during controller
> reset while setting up the admin queue on Apple A11 / T8015.

Thanks, applied to nvme-7.1.

