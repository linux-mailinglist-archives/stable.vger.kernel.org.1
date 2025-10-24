Return-Path: <stable+bounces-189214-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FCDEC05313
	for <lists+stable@lfdr.de>; Fri, 24 Oct 2025 10:53:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0241854297B
	for <lists+stable@lfdr.de>; Fri, 24 Oct 2025 08:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 045283090E1;
	Fri, 24 Oct 2025 08:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="krvNaJbb"
X-Original-To: stable@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A41B306B0D;
	Fri, 24 Oct 2025 08:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761295187; cv=none; b=d5F3zYZFEHu02fnOMqw0xN6qyXqNQdunXHyJu371/NUbD/AsbUCFY93NLhW0623+mKYXRw9XWyElbLmZeFPGbg+wSZzW4tdlknt32lZjXAhu3yHDtorJuI3qbRxEH8wWuJro73TSowvmboFWSfVz9FTaJHeUWFWCWRXBiqzbL6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761295187; c=relaxed/simple;
	bh=0jFenninAF/hgduw9GfWU0HOuF4au/RFUfhZZruyXsI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HVFiiW57C+Ie+aabP+PAgNdsYKAGjf8CoadJQcVLOCieyr4xECW2x5jHZ4Y9knkp1tF30/TxHHQ8Gd75sfcNK/YqVsskUimP2yjMYn8AP/+D4PjFlYYIkh9Igc1gl2OAwcHTyv8WwP0ZyJmdC3nGGeyPL124QEi/zODPLxTdCq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=krvNaJbb; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=2cMlx6dBNBmuoC08wN2ZIHtm4MB/TmlTbPKY6RErk4M=;
	t=1761295186; x=1762504786; b=krvNaJbbmSFgtM6XZGmhKbQPgyCu2IQ8sT9rNiTTpp4x0As
	ixCtI7HysVETY/E4Lvli0wEljlavlv7FEnDlxckOCIm9ZSfrXqxaBPGalX5RyU/XHJWPNo5QV/CpU
	QpHIpOQdTZRARjj0p8nvO5B7C/AkaCp7T1OS5tV+b4e66XSlKC1Z7IjARcNVSweYDoEXMnAxfvdP5
	2x1SS8OmBR8jYoJr/YgEGfdJ0gvesBKgVXVMRKUG0IxVgUHUgpRG16v+l/Us/jFoYHDzXrUVR9sXt
	ApHcJL4w0U3UrOlVeokeXEuKOIGZivH0P4ajvLc6DsER3r/G/a0/ZnoveSzSaj4w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vCDKm-00000002PRW-3W1T;
	Fri, 24 Oct 2025 10:39:41 +0200
Message-ID: <247568f47e1955be454e951e80a9063123f97c66.camel@sipsolutions.net>
Subject: Re: [PATCH] devcoredump: Fix circular locking dependency with
 devcd->mutex.
From: Johannes Berg <johannes@sipsolutions.net>
To: Maarten Lankhorst <dev@lankhorst.se>, linux-kernel@vger.kernel.org
Cc: intel-xe@lists.freedesktop.org, Mukesh Ojha <quic_mojha@quicinc.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Danilo Krummrich	 <dakr@kernel.org>,
 stable@vger.kernel.org, Matthew Brost <matthew.brost@intel.com>
Date: Fri, 24 Oct 2025 10:39:39 +0200
In-Reply-To: <c4bd0ddb-4104-4074-b04a-27577afeaa46@lankhorst.se>
References: <20250723142416.1020423-1-dev@lankhorst.se>
	 <e683355a9a9f700d98ae0a057063a975bb11fadc.camel@sipsolutions.net>
	 <c4bd0ddb-4104-4074-b04a-27577afeaa46@lankhorst.se>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Fri, 2025-10-24 at 10:37 +0200, Maarten Lankhorst wrote:
> >=20
> > CPU 0				CPU 1
> >=20
> > dev_coredump_put()		devcd_del()
> >  -> devcd_free()
> >    -> locked
> >      -> !deleted
> >      -> __devcd_del()
> > 				-> __devcd_del()
> >=20
> > no?
> >=20
> > johannes
>=20
>=20
> Yeah don't you love the races in the design? All intricate and subtle.

:)

> In this case it's handled by disable_delayed_work_sync(),
> which waits for devcd_del() to be completed. devcd_del is called from the=
 workqueue,
> and the first step devcd_free does is calling disable_delayed_work_sync, =
which means
> devcd_del() either fully completed or was not run at all.

Oh... right, I totally missed the _sync. My bad, sorry.

I guess I really should say

Reviewed-by: Johannes Berg <johannes@sipsolutions.net>

since I finally _did_ review it carefully. Sorry it took forever.

johannes

