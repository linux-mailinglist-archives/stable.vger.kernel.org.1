Return-Path: <stable+bounces-235421-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eBHAGv6112lURwgAu9opvQ
	(envelope-from <stable+bounces-235421-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 16:21:50 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 149513CBEB7
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 16:21:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A72EE3008986
	for <lists+stable@lfdr.de>; Thu,  9 Apr 2026 14:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3994932692C;
	Thu,  9 Apr 2026 14:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jgwBgatI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0FB43BBA1F
	for <stable@vger.kernel.org>; Thu,  9 Apr 2026 14:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775744493; cv=none; b=iwnbn4iE0leh5S82ym5EGmpTOBN9l+LtL4OwOlzVGZP5OEMbZIzCLdx5ZRJL21SqLWtkGrl8I4gUBRu7+rw4J//EhaCGdNe0v/sUlepRymKaF+pOXVgnrx7WMtN2F/B2HyaUyI/9eVZ/2jGWlAVWh+Z1XR7Ss6Ppn+2WxnaBirg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775744493; c=relaxed/simple;
	bh=XicQCsg1xLD0EvZzKpw7Ml61zswDMzAai5aJo1k2FtY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D4ELPbPWzpmEAyAbfuCvPZfaw0xHpIrRqJDSiQoDqfA+dywDV/0ZA1vYZ5SN01sOCNZa22IMc61TnagjBqd2KnvOP/Uk78/8ozZ/9iaRJKB8Q+oLBuvSvbqhmf7Da+yKTnGuwoVNJfWOtThBhWH3UdqJAEnx4t0QE7I9aULKl+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jgwBgatI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41240C4CEF7;
	Thu,  9 Apr 2026 14:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775744492;
	bh=XicQCsg1xLD0EvZzKpw7Ml61zswDMzAai5aJo1k2FtY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jgwBgatImg74bo08kTBEwRgREjX0eqYeNLjGWphF3btnblTtBsCgd4/TmsT6qy+Y1
	 H8NtOOsSbpfO303NhfKlZ6PlOBguAUon9cGYu8Vvc6XXYLv24H2VxhCIGr9kPXdcq3
	 G9q6oAl3PnJOhbpW4zeICbCwaus4+oK6xLO7Mwvwh84Eq89zEb+93yPlXmOP1rcW1R
	 RQPUQ+6qaTo6njLvlJ2ekzxheVypLYSEW63YUY/CNgzVEVF3cPepalMov5Q1exfCkc
	 dR1K7QI6McP0qgu6X3QOPe6nAQHwXniSXvWPKZ9M3984pIcz304dPGlEehXroVaXe5
	 ZAUotwShfW9lg==
Date: Thu, 9 Apr 2026 08:21:30 -0600
From: Keith Busch <kbusch@kernel.org>
To: Chaitanya Kulkarni <kch@nvidia.com>
Cc: skumar47@syr.edu, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, stable@vger.kernel.org
Subject: Re: [PATCH] nvmet-tcp: fix race between ICReq handling and queue
 teardown
Message-ID: <ade16pEF-OrE8vz2@kbusch-mbp>
References: <20260408075131.6221-1-kch@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260408075131.6221-1-kch@nvidia.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-235421-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kbusch@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 149513CBEB7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 08, 2026 at 12:51:31AM -0700, Chaitanya Kulkarni wrote:
> nvmet_tcp_handle_icreq() updates queue->state after sending an
> Initialization Connection Response (ICResp), but it does so without
> serializing against target-side queue teardown.

Thanks, applied to nvme-7.1 with the overly long line fixed up when
applying.

