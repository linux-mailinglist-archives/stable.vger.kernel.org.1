Return-Path: <stable+bounces-235425-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GINhNQ2812l0SAgAu9opvQ
	(envelope-from <stable+bounces-235425-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 16:47:41 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FA3F3CC2F8
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 16:47:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1C612300DA5F
	for <lists+stable@lfdr.de>; Thu,  9 Apr 2026 14:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D775433FE10;
	Thu,  9 Apr 2026 14:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DlAisKje"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6992B3DE432;
	Thu,  9 Apr 2026 14:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775746055; cv=none; b=U06dXAh/8YOyO1lZNJZZp5qIl8D4l9WqEzYdfUrX1d+LFIaTI2omMJKm7WHqPgPKncyHu6B71TWgZdaGbeuOQP/pqc2qynIhWOlenPobcV2LfrJTKx9lYVKyySV6CaektzF2muHndJ9916siSLyfRfK52fPCznqb4cVHXQDNIEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775746055; c=relaxed/simple;
	bh=djRqfPBkNVahcZFjp0o5BzT6Z5NlQchfQKtyM/aCpRo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zr8QAlFnMNLQG2GyGmD9UcG+d186Bz7vevTZK4JHndtxfcJLLc8djlDa9eSw8Eaa929OAeDQRPdt+ynwumnXs/jQxVRgv0al50QSw5Er+femENsW6auQR9R9PrQCxNJurLX1uTzIvxok+V/Lkgv9v99ljuKvAdUSJtTA+6Msoz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DlAisKje; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9B80C19424;
	Thu,  9 Apr 2026 14:47:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775746054;
	bh=djRqfPBkNVahcZFjp0o5BzT6Z5NlQchfQKtyM/aCpRo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DlAisKje+O0Lnmqr+zVussfrUGx5EyoJKtv8uEoz3CJtl+tT6wWPZNX39aDECpJ8b
	 bVgP93SURRCtuaDuBFe+9ehf+jfHND0Y1/cVmfADHpr++Gl7ctLO5oUJLX9eJZ2/9S
	 UxQGVmAfT/RdYtlu4mU0wJ0T2zdB3CQVdSb8xai6em7u+iDDRmCIILxqWML+yCeKF1
	 CVmu/mYqQuz+1x+nv9+ido/yjHwdANbjiN6pfavqgqrK7+7VEVgeZG+2JYjg54j3fj
	 0qs+Viz4C1LIby2TdVLejtg1KpnWQjSfUHE0Kfpm7iYbEbLiUSbC6eMcyd6u0fpayd
	 ITvz+7dpj/YoA==
Date: Thu, 9 Apr 2026 08:47:32 -0600
From: Keith Busch <kbusch@kernel.org>
To: Fedor Pchelkin <pchelkin@ispras.ru>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>,
	Neal Gompa <neal@gompa.dev>, Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>, Ming Lei <ming.lei@redhat.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	"Heyne, Maximilian" <mheyne@amazon.de>, asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] nvme-apple: drop invalid put of admin queue reference
 count
Message-ID: <ade8BAxGrW9q3DFM@kbusch-mbp>
References: <20260408141815.375695-1-pchelkin@ispras.ru>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260408141815.375695-1-pchelkin@ispras.ru>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-235425-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kbusch@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 8FA3F3CC2F8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 08, 2026 at 05:18:14PM +0300, Fedor Pchelkin wrote:
> Commit 03b3bcd319b3 ("nvme: fix admin request_queue lifetime") moved the
> admin queue reference ->put call into nvme_free_ctrl() - a controller
> device release callback performed for every nvme driver doing
> nvme_init_ctrl().

Thanks, applied to nvme-7.1.

