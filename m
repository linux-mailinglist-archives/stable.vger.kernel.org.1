Return-Path: <stable+bounces-3811-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DD91F802692
	for <lists+stable@lfdr.de>; Sun,  3 Dec 2023 20:14:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3833DB207FC
	for <lists+stable@lfdr.de>; Sun,  3 Dec 2023 19:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FF6E17993;
	Sun,  3 Dec 2023 19:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="C1SzQLKy"
X-Original-To: stable@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87BF9E3
	for <stable@vger.kernel.org>; Sun,  3 Dec 2023 11:14:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=91cBSBsaZuDf/yVzH7aZURJm0UvkLSdhHfheIQLFymQ=;
	t=1701630844; x=1702840444; b=C1SzQLKyrRwjTURJqO8+11leWK3fBP5oJcYNLoIjlZhDOL6
	ZVNB5dSBAAloxBU8whXw2akyEFCxTUTJEW7HOF6bscM/cJnKxCj5qNvE0quDw7h/GCQsoN1R9TdYp
	c0sdxHhTmfDMmHEXrC3ryAksFHZDloYU5a5A9CdNPbPqdCD0QdxupM8n6EjjJvFOvQsYB/XzombPL
	PtIoMeCQnnWvUs3wAbNxk3sEP1aYEU1r3M7/4W13wWYXvagBEQU7Wb98Z9PhnKlm3dYN0dlnFLWrT
	khI2YoPflZoN6hV/yPzm7hFdB3N/Oz+8i/An8fqNv04LHNev9vtmfrOx68eedoVg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1r9ruj-0000000DmuV-3lV1;
	Sun, 03 Dec 2023 20:14:02 +0100
Message-ID: <f7965d3bd612ade8535407c06f99bfee77432bfe.camel@sipsolutions.net>
Subject: Re: [PATCH 6.1,6.6] wifi: cfg80211: fix CQM for non-range use
From: Johannes Berg <johannes@sipsolutions.net>
To: kernel test robot <lkp@intel.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Date: Sun, 03 Dec 2023 20:14:00 +0100
In-Reply-To: <ZWzS5yuKKYCVIxz9@520bc4c78bef>
References: <ZWzS5yuKKYCVIxz9@520bc4c78bef>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned


> FYI: kernel test robot notices the stable kernel rule is not satisfied.
>=20
> The check is based on https://www.kernel.org/doc/html/latest/process/stab=
le-kernel-rules.html#option-3
>=20
> Rule: The upstream commit ID must be specified with a separate line above=
 the commit text.
> Subject: [PATCH 6.1,6.6] wifi: cfg80211: fix CQM for non-range use
> Link: https://lore.kernel.org/stable/20231203190842.25478-2-johannes%40si=
psolutions.net
>=20

OK, so I spelled it "Commit" and not "commit" ...?

johannes

