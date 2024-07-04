Return-Path: <stable+bounces-58098-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFEFD927E81
	for <lists+stable@lfdr.de>; Thu,  4 Jul 2024 23:24:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C37091C2291E
	for <lists+stable@lfdr.de>; Thu,  4 Jul 2024 21:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F3E913D53B;
	Thu,  4 Jul 2024 21:24:07 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D56C4131736
	for <stable@vger.kernel.org>; Thu,  4 Jul 2024 21:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720128247; cv=none; b=i4qLfBdnDdbmbYIeJm7NibibDjWMoSYbodnn1ywPpJZXMkaFKWadzCCQSpikxyAXYjDFV4ZDQQn0V/KGwFgyafqMkk6arznd5D3DZn7fEOhdjhIYafaox5505tnkffLQqiVyJ2AS2CT/L20j48Eq2K43JCnU2AsDBtUNH19IlXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720128247; c=relaxed/simple;
	bh=kEfmnGTrSFvZ0/R+w8Xhs2oBYsSpp/wcSpRdbNcvl0g=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dv1CCmK8yR/xoBXXM35VQwTGpZzZevD1x0eVwSkZL/7IRfd1QbCb9RWy9hhYi5/9/p9EDsVzD/qZyRdQsXfYd12QnjGtnXt/Yzdb6fWTb7m19yN1jmCh+W6v5QjUNqObk9i10tpxsWY1hsRdzX8uftVWQcXbwmD+/lahYs11wgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com; spf=pass smtp.mailfrom=perches.com; arc=none smtp.client-ip=216.40.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=perches.com
Received: from omf19.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay07.hostedemail.com (Postfix) with ESMTP id B596E1614C0;
	Thu,  4 Jul 2024 21:23:44 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf19.hostedemail.com (Postfix) with ESMTPA id 2AC0320029;
	Thu,  4 Jul 2024 21:23:41 +0000 (UTC)
Message-ID: <0e3bf011f0b402f7913164deacd964f02db8ec7d.camel@perches.com>
Subject: Re: [PATCH 4.19 093/139] scsi: mpt3sas: Add ioc_<level> logging
 macros
From: Joe Perches <joe@perches.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, Suganath Prabu
	 <suganath-prabu.subramani@broadcom.com>, "Martin K. Petersen"
	 <martin.petersen@oracle.com>, Sasha Levin <sashal@kernel.org>
Date: Thu, 04 Jul 2024 14:23:40 -0700
In-Reply-To: <2024070449-tarantula-unwieldy-9b51@gregkh>
References: <20240703102830.432293640@linuxfoundation.org>
	 <20240703102833.952003952@linuxfoundation.org>
	 <f054ce9050f20e99afbed174c07f67efc61ef906.camel@perches.com>
	 <2024070449-tarantula-unwieldy-9b51@gregkh>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 (3.52.2-1.fc40) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 2AC0320029
X-Rspamd-Server: rspamout06
X-Stat-Signature: 9n6craygkn9jg4u4h37aapmr3hxmap5s
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX19bZ2itIB0Y8MkTZZPSeh55cGaj2sUb1PU=
X-HE-Tag: 1720128221-131808
X-HE-Meta: U2FsdGVkX1/3PHzWtQa5ms88/ICqACkAp3G+y3fB5oyfG7FcefCW8Yj9nvMJCJVgd/nXBwZ490aZ5OmT29pjro7hJyhzhK5PlHuFCuK4FpyfLdxXykOiIEywb5e0QmyoWaQTUEaFSeYHugCWE2yQocNlWog0enDSszvBY1T++Ubx8lzvcuq5P6f+Y7mxtzl9PjcvGeomud5qXdoXUt0uYIFH2BkIc/hKL7YyhETyUo9g9TkAFl+bmlttZ2gZctsRY6rlKM3HkaEj7QtmPjjORvL29rdouc+hxWAu7DegeunYzACrdsHhk+d0x1JWxQzFq3KfT8S95p52OLCtGmHOfL2fgE4XuZLdHSfrjFpGYEjXgCk89pnu+8JDKVybA2LUuWb09tMyobD3G7+MpLDaqA==

On Thu, 2024-07-04 at 11:38 +0200, Greg Kroah-Hartman wrote:
> On Wed, Jul 03, 2024 at 04:10:43AM -0700, Joe Perches wrote:
> > On Wed, 2024-07-03 at 12:39 +0200, Greg Kroah-Hartman wrote:
> > > 4.19-stable review patch.  If anyone has any objections, please let m=
e know.
> >=20
> > Still think this isn't necessary.
> >=20
> > see: https://lore.kernel.org/stable/Zn25eTIrGAKneEm_@sashalap/
>=20
> It's needed due to commit ffedeae1fa54 ("scsi: mpt3sas: Gracefully
> handle online firmware update") which is in this series and uses the
> io_info() macro.

Swell, but the dependency chain is not correct

The patch says:

> Stable-dep-of: 4254dfeda82f ("scsi: mpt3sas: Avoid test/set_bit() operati=
ng in non-allocated memory")


