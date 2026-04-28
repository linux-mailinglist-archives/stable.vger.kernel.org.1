Return-Path: <stable+bounces-241757-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oBgGHqz+8GnubgEAu9opvQ
	(envelope-from <stable+bounces-241757-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 20:38:36 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D71848ABDC
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 20:38:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 362E23024DE0
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 18:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6135E47A0D8;
	Tue, 28 Apr 2026 18:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AWbQZXZy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 221B1477E35;
	Tue, 28 Apr 2026 18:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777400574; cv=none; b=q1268ptJ6aeDR776aqKkgcbcDkb2wapGJyZE/MtCs4v/qgCu80zTJCFI0UjPgNmjW1HXM8Mp8CaToIgRSZDNrN5GREpciIBr6WZibXzXfbwmBNOCotfuZt/20q5a7j2L7RRDhWvzzkDzBqCaMhSMCgKibzIUoIrrP8QMBBvVDSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777400574; c=relaxed/simple;
	bh=Qjsd3uIfQkniErIqXXZOa+Asxn83iT3n+U3qISVJt1M=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=qZR6wc7hiCqPNRGQkOA6GlM0BeFNC5+fEf3jzI/BlWBoGCAKh+QE/7QtM5tNkElCDNy8l/yU4aikp/i5P+6XKey0fQAG9wYqevHmxXpmygpLL4+pcjKlAmuBnEejr4VlPTjur5/WIovnVrBRo00k5oXlhkNHF3G3zXxnKbj+qb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AWbQZXZy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70F56C2BCAF;
	Tue, 28 Apr 2026 18:22:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777400573;
	bh=Qjsd3uIfQkniErIqXXZOa+Asxn83iT3n+U3qISVJt1M=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=AWbQZXZylojtQrJm96K/00Z5HfftGed0m/IUkZ6sl8o4/ixwCyGrwyPVAuFyzhCSZ
	 6i/r4xy2eQWOiCnM1PKKEpxMLOTwXYTV0PBt7uxVwiqtBNdD4pz80+CJ5DHUbuJ8+u
	 NZACczwZthExFB4THX3WKkWK2xeMNgIA2vUH11JEk8uFpCwoW0HeqzkY73REYvK/jI
	 lxJVSjN3R2eVWSYv4Xm6uksmcbBvqITKaooJEVP5EZtVdw4yrhwc25klQKMufQTMs8
	 nDGUF6tr5LtwpxQUxYABjhXY9m1/nllN+lTFUz+LXkEAzA1LqHma33d3Fia3IZXN1T
	 XVGyeCZju62kg==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 28 Apr 2026 20:22:49 +0200
Message-Id: <DI4ZX1HOWDNH.3G36YTI0MYC76@kernel.org>
Subject: Re: [PATCH] drivers: base: Set mod->async_probe_requested if needed
Cc: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Rafael J . Wysocki"
 <rafael@kernel.org>, <driver-core@lists.linux.dev>, "Luis Chamberlain"
 <mcgrof@kernel.org>, "Petr Pavlu" <petr.pavlu@suse.com>, "Daniel Gomez"
 <da.gomez@kernel.org>, "Sami Tolvanen" <samitolvanen@google.com>, "Aaron
 Tomlin" <atomlin@atomlin.com>, "Igor Pylypiv" <ipylypiv@google.com>,
 "Chung-Kai Mei" <chungkai@google.com>, <stable@vger.kernel.org>
To: "Bart Van Assche" <bvanassche@acm.org>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260407160511.56289-1-bvanassche@acm.org>
In-Reply-To: <20260407160511.56289-1-bvanassche@acm.org>
X-Rspamd-Queue-Id: 8D71848ABDC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-241757-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dakr@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,acm.org:email,atomlin.com:email]

On Tue Apr 7, 2026 at 6:05 PM CEST, Bart Van Assche wrote:
> If PROBE_PREFER_ASYNCHRONOUS is set for a device driver, and if loading
> other kernel modules depends on probing of that device driver to
> complete, e.g. because it is a storage driver, and if
> mod->async_probe_requested has not been set, then the
> async_synchronize_full() call in do_init_module() introduces a delay.
> Fix this by setting mod->async_probe_requested if
> PROBE_PREFER_ASYNCHRONOUS has been set. This patch reduces the Pixel 10
> boot time by 100 ms.
>
> Cc: Luis Chamberlain <mcgrof@kernel.org>
> Cc: Petr Pavlu <petr.pavlu@suse.com>
> Cc: Daniel Gomez <da.gomez@kernel.org>
> Cc: Sami Tolvanen <samitolvanen@google.com>
> Cc: Aaron Tomlin <atomlin@atomlin.com>
> Cc: Igor Pylypiv <ipylypiv@google.com>
> Cc: Chung-Kai Mei <chungkai@google.com>
> Cc: stable@vger.kernel.org

Why does this have Cc: stable? I think this is just an improvement and not =
a
regression? If it is a regression, what's the commit that is fixed?

> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  drivers/base/module.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/base/module.c b/drivers/base/module.c
> index 218aaa096455..e58fc189d389 100644
> --- a/drivers/base/module.c
> +++ b/drivers/base/module.c
> @@ -39,6 +39,9 @@ int module_add_driver(struct module *mod, const struct =
device_driver *drv)
>  	if (!drv)
>  		return 0;
> =20
> +	if (mod && drv->probe_type =3D=3D PROBE_PREFER_ASYNCHRONOUS)
> +		mod->async_probe_requested =3D true;

What if userspace did explicitly pass async_probe=3D0?

> +
>  	if (mod)
>  		mk =3D &mod->mkobj;
>  	else if (drv->mod_name) {


