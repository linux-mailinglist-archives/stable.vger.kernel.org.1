Return-Path: <stable+bounces-241916-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YEGWBKsw8mlvogEAu9opvQ
	(envelope-from <stable+bounces-241916-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 18:24:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 97018497B0C
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 18:24:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 85C7E305BF07
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 16:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 992B240FD85;
	Wed, 29 Apr 2026 16:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ajauS0IW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F345B40756D;
	Wed, 29 Apr 2026 16:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777479486; cv=none; b=MvG/FV55kjLUr0pSZGdYhullbAeNA68A89mGTtHPR3GsI3iFMUC/J8XD0VNdk52EGCtPk8iR3bnP37g70olmRfuWyG3htv/HkzUGkq5VFctVRSc/pVf3MehpsUEfLuZiQM/MCIEUWn4hYBY3kFxovd463LfIvavXPxwyrvTnexs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777479486; c=relaxed/simple;
	bh=7fONDqNyo/LJDMc44vVtEzOc7fJ2y7pveDW55Yz+9zc=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=pTfb8jVsGZssyKFh4+aFQ5ekwB6LJdo12e/9QdbEpDaCfxsWidCYPcHaZkXKoVJkLEvm4VehJZ6rw1uYNSFdwc2UFBZad74VBCGzSML1PNx8B/xQ25AmXr6JRKtCfa0rPCThMTwviGUMFh+Uy9nS0qbSDcEigk3aTUZBFykVyGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ajauS0IW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B19FC19425;
	Wed, 29 Apr 2026 16:18:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777479485;
	bh=7fONDqNyo/LJDMc44vVtEzOc7fJ2y7pveDW55Yz+9zc=;
	h=Date:From:Subject:Cc:To:References:In-Reply-To:From;
	b=ajauS0IWMXt34EtZsGSM5hp5OXOTR3jrCduB0RXBO07iB3JmU0z+8FeRagCBbKWcc
	 LpSYcNp16nKLxb4eTyGWBDrCjtSkt1K7nWUih1MDH5TODZCnKSUkX5IqbWUUirCvnw
	 twxc/B74V0Qd/C6ug+RAy+xVm8a1SlJGLFEa6MsdWY8OLbilasQWmi/GtuEQZDTJ9R
	 Rm66VNxDXR4+ktRWqhjrSQdPD/qkpmf4lJW5aQ7u+teZJPPypV4oaRVJVnW97nZ90z
	 gLgMIKPJNb9G93k+zq/ENpYC6XJlYMRExaXxu16D38CzGDv9x9tBSyAVjKnslf0foP
	 XyzlSJiTV2FZg==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 29 Apr 2026 18:18:01 +0200
Message-Id: <DI5RW1116MXY.3C53BWGR52Q0L@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH] driver core: reject devices with unregistered buses
Cc: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Rafael J . Wysocki"
 <rafael@kernel.org>, <driver-core@lists.linux.dev>,
 <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
To: "Johan Hovold" <johan@kernel.org>
References: <20260427102852.2174-1-johan@kernel.org>
 <DI50WG9XK1I4.1R6DXSZSWFRDC@kernel.org>
 <afHZWasOhRaeBCnt@hovoldconsulting.com>
 <DI5LDIQW45PE.LPIWCARJV7WC@kernel.org>
 <afHsgv9SUqfn-G1x@hovoldconsulting.com>
 <DI5Q29QMNVNH.1B2N4VBA2ZVQW@kernel.org>
 <afIe495IbAe7EeDt@hovoldconsulting.com>
 <DI5QUINEJC6U.32I161SD0KU76@kernel.org>
 <afIrCO3QSL3hx10S@hovoldconsulting.com>
In-Reply-To: <afIrCO3QSL3hx10S@hovoldconsulting.com>
X-Rspamd-Queue-Id: 97018497B0C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-241916-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dakr@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

On Wed Apr 29, 2026 at 6:00 PM CEST, Johan Hovold wrote:
> namely that
>
> 	 registration [...] succeeds [but] without the device being
> 	 added to the bus.

[...]

> Perhaps I can add "(i.e. as if it were a bus-less device)" to stress it
> more but I'm not sure it's needed.

I think that would be good, thanks!

Your above quote only vaguely implies that and I think it is pretty hard to
infer that without already being aware of this implication.

It even deserves more emphasis; the current commit message reads as if it's=
 only
about adding an additional warning.

Thanks,
Danilo

