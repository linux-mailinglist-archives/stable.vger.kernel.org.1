Return-Path: <stable+bounces-143036-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9E5CAB0FCB
	for <lists+stable@lfdr.de>; Fri,  9 May 2025 12:03:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 992703A86D1
	for <lists+stable@lfdr.de>; Fri,  9 May 2025 10:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3520F222576;
	Fri,  9 May 2025 10:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="jD68dace"
X-Original-To: stable@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F16222B8C6;
	Fri,  9 May 2025 10:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746785004; cv=none; b=nfRmOgsUrTYyAusF0UzuMIMpwaAID3J+cQR2+BayNjbZ1lh8kwbzZ17Wc197W8zoKAW1dthAbcaPBzlJHeb18Y7iEcZ/QYxcNpt0FgT5hsH+Lga5INf5MW45qUkPQdLeEz8Z7XQhGpVVR5LPdn5p21XQphJmd0vIyzMnZzHMlVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746785004; c=relaxed/simple;
	bh=o3762g+GuSJsrko3ED8b4sId/L19pQq5bBo6syEWPvg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jp+B0QjslmM3zV+TvjZdn1xOak2XjXGsUPHfDFCGA+kCu20mUsLnPMw1XkwPqIGm53xARvsbyfAtktWmcyflvyOTKskSWqP4fzKWUZoxxhWwLrhma2mD6n7bcpTpaGPFcX7y/lRBPFzSe+UZ6m3LshTpDZ1IFxfeoWfRv8/f0S8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=jD68dace; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=k54YIIAt1HX3qxqsLaJ9Pdr+Jyv+TK7yUdd/QX5Nw1g=;
	t=1746785002; x=1747994602; b=jD68daceGGLvl/qj3rb4kIRjACpuj9aboDtIgiln/gm9WO/
	quwiO8EvyNBSGB/Xv9y9766BYlXJQD62vhiop/Rs24++4j2UAva0zshIws/l+hQwR2rGoExbHO/3N
	4OJeWM4G2HYI+P6AmRe+CQjlnWEo0IuOzvIIr0AXKCnAc228k3NMg0FDsyPntCJ0DK/YddQvChj2u
	6n6TGOJbCQ7zIh7i/oEDJ2tCH95ANSYYaUSl6f5vDE0Y4GJSgPCiRMzWz7yAxkEOfwg9PPLdQ0uZv
	C98mYo+YaOMensBCkLK3XBKdhyvphtdsNLWkKpdLx5a/e61zoeZvH8qgiour/LdQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.1)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uDKZQ-0000000DFW4-1AvP;
	Fri, 09 May 2025 12:03:08 +0200
Message-ID: <05954e6dde3369a0ecf26f5225643afa15850f60.camel@sipsolutions.net>
Subject: Re: [PATCH 6.12] Revert "um: work around sched_yield not yielding
 in time-travel mode"
From: Johannes Berg <johannes@sipsolutions.net>
To: Christian Lamparter <chunkeey@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-um@lists.infradead.org
Cc: benjamin.berg@intel.com, sashal@kernel.org, richard@nod.at, 
	stable@vger.kernel.org
Date: Fri, 09 May 2025 12:03:07 +0200
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
> (from what I know this is 43 patches on top of v6.12-rc2 as per the man p=
age:
> "The command finds the most recent tag that is reachable from a commit. [=
...]
> it suffixes the tag name with the number of additional commits on top of =
the tagged
> object and the abbreviated object name of the most recent commit."
>=20
> But it was merged as part of: uml-for-linus-6.13-rc1 :
> https://lore.kernel.org/lkml/1155823186.11802667.1732921581257.JavaMail.z=
imbra@nod.at/

That's not all that implausible - UML maintenance is slow and we all
have a lot of things to do... so chances are we just didn't send a pull
request for 6.12-rc even though the tree was already there. I'm trying
to improve that but it's not really a focus for any of us.

johannes

