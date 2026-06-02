Return-Path: <stable+bounces-259750-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eGWzBcaaHmpllQkAu9opvQ
	(envelope-from <stable+bounces-259750-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 02 Jun 2026 10:56:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8019962AF06
	for <lists+stable@lfdr.de>; Tue, 02 Jun 2026 10:56:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B447A301739B
	for <lists+stable@lfdr.de>; Tue,  2 Jun 2026 08:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1DB331159C;
	Tue,  2 Jun 2026 08:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ajNcqyed"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ABD7314D35
	for <stable@vger.kernel.org>; Tue,  2 Jun 2026 08:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780390245; cv=none; b=i/D52HBrHME4zPcUa0D8fKSxRlw1LcJnDEHQqmFEuvEuaYeCeGkXsRhz5AgCWEVe7k40PAwxAYqtxfNKlCn0w97FkhwCrT33cZe/SBfvH1SNSMvirhOM+IIPB2w5HhhNWkFZWJwz1Zf9/b2NfVmGJZ7hfUG+2gAPgcdlZrG0DLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780390245; c=relaxed/simple;
	bh=d/Jmmkccq6m64xYLP8DHcAGOpIuwTZpCZ+GgDYFhE74=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I1UwVcwiQjBOqraFc345z77ATjQfHG31ayU2QzZuu4n8zDS4GCxzRCt7s2UcHrp2OZPrQBVQ45Ejh8NE969OYHWRZq59tCgwDu/IA4Ndm3kreSmEw3pdF+34NCe/Ao3QViUWwA4NwSWZnBzgCBAI21Fifhhj2aVf2yeriHECnmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ajNcqyed; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A57C91F00893;
	Tue,  2 Jun 2026 08:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780390244;
	bh=gs1YDxQOs1/Jv+Rm3Tfht7T6bHIW93ex5vfitXcPBJU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ajNcqyeduhLNBBjc1kNn7nqKrnT+ceffr01bUkCPXfrEZTnjFhs6JRv7ipjntw7XA
	 tc8XoAhzqZfkj2KkyEW4uZPDqchmV3kr1531burJPNB+Tl9N+DbXHBrp0h9MY2YcEU
	 OnmuPrsNkf/bZHIwyWoYDXXlVzpPErSgjKDfn8G4JNp9dwC3I9DYKJILA+Ja/UI/lZ
	 q8XbrVVhcjCduJoD5CZjmt1zpAPy6MNY7UNuqgAfHuG8UdQz/aN7GQk1DfZD+LtoI1
	 c9O6XuwAYnT3P15qiEezFUicXj4hzMHbM4ALnPQrVxIXj5wvFv57kO9FF3DKJ4xXgT
	 TWxsVtVFTw38Q==
Date: Tue, 2 Jun 2026 09:50:38 +0100
From: Keith Busch <kbusch@kernel.org>
To: Jeremy Erazo <mendozayt13@gmail.com>
Cc: security@kernel.org, Christoph Hellwig <hch@infradead.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, Hannes Reinecke <hare@suse.de>,
	Jens Axboe <axboe@kernel.dk>, linux-nvme@lists.infradead.org,
	stable@vger.kernel.org
Subject: Re: nvmet: pre-auth heap OOB read in DH-HMAC-CHAP authentication
 (data->hl unchecked in nvmet_auth_reply)
Message-ID: <ah6ZXmX1anVLrr76@kbusch-mbp>
References: <6a1e4ed5.f18a29c3.bfe2b.5229@mx.google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a1e4ed5.f18a29c3.bfe2b.5229@mx.google.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-259750-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kbusch@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 8019962AF06
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Jun 01, 2026 at 08:32:37PM -0700, Jeremy Erazo wrote:
>   @@ -119,6 +120,16 @@ static u8 nvmet_auth_reply(struct nvmet_req *req, void *d)
>                     __func__, ctrl->cntlid, req->sq->qid,
>                     data->hl, data->cvalid, dhvlen);
> 
>   +        /* Confirm the transferred length actually contains the
>   +         * rval payload the message body advertises. The host
>   +         * response is hl bytes; with cvalid set, hl more bytes
>   +         * of challenge follow; with dhvlen set, dhvlen more
>   +         * bytes of DH value follow.
>   +         */
>   +        if (tl < sizeof(*data) + data->hl +
>   +                 (data->cvalid ? data->hl : 0) + dhvlen)
>   +                return NVME_AUTH_DHCHAP_FAILURE_INCORRECT_PAYLOAD;
>   +

I think the fix should change the ternary condition from data->cvalid to
(data->cvalid || dhvlen):

  if (tl < sizeof(*data) + data->hl +
           ((data->cvalid || dhvlen) ? data->hl : 0) + dhvlen)
          return NVME_AUTH_DHCHAP_FAILURE_INCORRECT_PAYLOAD;

But this is a bit of an eye-sore, so let's make this easier to read by
lifting the ternary computation outside the 'if' section and store the
result in a temporary variable.

