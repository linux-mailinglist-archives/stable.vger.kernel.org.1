Return-Path: <stable+bounces-230184-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cBNvOvWswmkyggQAu9opvQ
	(envelope-from <stable+bounces-230184-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 16:25:41 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EABCE317F83
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 16:25:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7E8063081018
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 15:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FDB84070F0;
	Tue, 24 Mar 2026 15:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ElhEJc24"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131D34035CA;
	Tue, 24 Mar 2026 15:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774364749; cv=none; b=HzZf80qb6IBRQ4SJXUzuRBqOEzomy7mKFWHS08xftwiHBm6ZZmtT38tSlS6KYrftI0kDadufm9tf52K4kVYIiAQHPQGaGsMYC9a5RwGsASryHOnFgDmw5G0eNb+c1NAM6NVAoPU+dmQBc6cw1TpU31WTy/g+XqspdE76h/WTRCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774364749; c=relaxed/simple;
	bh=5hFAGOIzp/eMo2BkSnj3ruVd7WQWbN7gZFXvH2KCv+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nodc0yXbdoyOQ/VFG1GW5I/B2c3ScdocPwjGg5Y8RX/YHRaUVzoFCNpJ9B+dluHYIWIsI/5/Rl+POgdV1ATq8knGVHzNY1Bv96pJZ8WrEniIuZBZN0KwChEyG/TYpxXrwU780/RaGBw4QzlUyhbBco9JFwR39aJ8ZHNRS1Jm1c8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ElhEJc24; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D306C19424;
	Tue, 24 Mar 2026 15:05:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774364749;
	bh=5hFAGOIzp/eMo2BkSnj3ruVd7WQWbN7gZFXvH2KCv+Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ElhEJc243dMRGNhh5WR3M6+3lYx8CnlrfHG+ghChZamKkWoPDQTO8mDTNXbRSn+Fi
	 Jyr7agja58P1NlLahPI91zRrfVd9dxvRY+tiNS1QtfmW7ruOF1uw+UuBo3FJMRDM1T
	 M+nLih80AFFJ2fN9TferKAiM/QvyaKNdEkIdWIxtJQkt91chTTAE9FVcqlJkMJ5/WR
	 UkiQMy0r5A2y1HOxMnXifQG34eVN3HN4wCEYj1QFqXmt6uMHHH1vAkbXAzNClTHxbH
	 ZAoxmXMXwrWyAImGq3OH0zZxusWTaq6eYoDSW9cQ+M8HxTXwkUmLZ57v281NAEl13u
	 Or+9f1wZ2RE0Q==
Date: Tue, 24 Mar 2026 09:05:46 -0600
From: Keith Busch <kbusch@kernel.org>
To: Bob Beckett <bob.beckett@collabora.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, kernel@collabora.com,
	stable@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] nvme: respect NVME_QUIRK_DISABLE_WRITE_ZEROES when
 wzsl is set
Message-ID: <acKoSnQ4p8rhBe4P@kbusch-mbp>
References: <20260320192217.365936-1-bob.beckett@collabora.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260320192217.365936-1-bob.beckett@collabora.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230184-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kbusch@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EABCE317F83
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 20, 2026 at 07:22:08PM +0000, Bob Beckett wrote:
> ---
>  drivers/nvme/host/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 766e9cc4ffca..ce25c8a4e84b 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -3388,7 +3388,7 @@ static int nvme_init_non_mdts_limits(struct nvme_ctrl *ctrl)
>  
>  	ctrl->dmrl = id->dmrl;
>  	ctrl->dmrsl = le32_to_cpu(id->dmrsl);
> -	if (id->wzsl)
> +	if (id->wzsl && !(ctrl->quirks & NVME_QUIRK_DISABLE_WRITE_ZEROES))
>  		ctrl->max_zeroes_sectors = nvme_mps_to_sectors(ctrl, id->wzsl);

Interesting. This is from a more recent identification that I would have
hoped devices going through the trouble of implementing it would have
figured out by now how to report write zeroes support correctly.

Patches applied to nvme-7.1, thanks.

