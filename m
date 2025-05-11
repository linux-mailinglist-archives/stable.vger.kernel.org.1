Return-Path: <stable+bounces-143101-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC084AB2A7F
	for <lists+stable@lfdr.de>; Sun, 11 May 2025 21:23:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 410353A69DB
	for <lists+stable@lfdr.de>; Sun, 11 May 2025 19:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F835158DAC;
	Sun, 11 May 2025 19:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="h7n0X8ru"
X-Original-To: stable@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B72834C80;
	Sun, 11 May 2025 19:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746991423; cv=none; b=WL77pKWVg9MOeXiEvl8EFQLtEhJvwAZHHhpR4/vdx5zuVMyW2p5QuVDqQSeRFQCU8g6due+9h7zHvbovp+d3ZGTCvjzJYUwJ41GwJ6pLDxQlXUZnYBqDoPzFusR+rclHee9vQ+44vpDNkNFImHNArNHnQAi5qyRZQtLa06i3xtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746991423; c=relaxed/simple;
	bh=+OTFpMuvTlo08V9NAG4jWSYjc1KKfYrxW9G1gMBm4Jc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NjHpGhxudYrpWTodFqTWI2fROcI7A8BKUZ7nnJQiSy3cp0qUBjJjZYu4JwXihPOY7PUL5l3rHGiOVRechJXZ0v7vM2MeoNbhULeEaQ0QsuPvJivI86yfqTXJxsgIsnIdAGQIQWelZorh5uQ9y8GKbfN/p/bZvk2m/RhcwwvRiO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=h7n0X8ru; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=bggfRofGtQv41sMq7DiElPPeAu0aUPI8Xjg9f5re5GQ=;
	t=1746991421; x=1748201021; b=h7n0X8rurifnDVzA3O6Il4/0eE3Pfp3bYUP92JyWkaAFfk4
	BY/kLa8IZLMUycaIKLnNqU6n3xdf7C3un9QV5U74Vo/m63wHjZ12GEFAqxp68nqhhzmHpZkFSds4J
	WHEiRDDaI1DebkgKMYxLH8e+O2T4LrHOTVqcll2UZSo9a2XEdr+axkTbsewsnnizCfzFByZNwnHE2
	myUgmpoqMrv4I1LHvuS4di/Xcu2PWiRLUghl3vUYkGsxMGS1OqzP0mK66zoO5VBDSUYiCgfj7O2D1
	sn7u0hpaLj6et2PJmoZasiMTyv0fCopec3q+GJ/vdF0ZK09kvMwnJS41iTMRXg/w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.1)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uECGm-00000001bBk-3lWn;
	Sun, 11 May 2025 21:23:29 +0200
Message-ID: <b09d6b4ef6291a2109dd7e1bada4ecff931a553f.camel@sipsolutions.net>
Subject: Re: [PATCH 6.12] Revert "um: work around sched_yield not yielding
 in time-travel mode"
From: Johannes Berg <johannes@sipsolutions.net>
To: Christian Lamparter <chunkeey@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-um@lists.infradead.org
Cc: benjamin.berg@intel.com, sashal@kernel.org, richard@nod.at, 
	stable@vger.kernel.org
Date: Sun, 11 May 2025 21:23:28 +0200
In-Reply-To: <20250509095040.33355-1-chunkeey@gmail.com>
References: <20250509095040.33355-1-chunkeey@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Fri, 2025-05-09 at 11:50 +0200, Christian Lamparter wrote:
>=20
> What's interessting/very strange strange about this time-travel stuff:
> > commit 0b8b2668f998 ("um: insert scheduler ticks when userspace does no=
t yield")
>=20
>  $ git describe 0b8b2668f998
> =3D> v6.12-rc2-43-g0b8b2668f998
>=20

Come to think of it, often you just want "git describe --contains":

$ git describe --contains --match=3Dv* 0b8b2668f998
v6.13-rc1~18^2~25

johannes

