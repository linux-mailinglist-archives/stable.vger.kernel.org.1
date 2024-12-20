Return-Path: <stable+bounces-105399-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A2189F8E25
	for <lists+stable@lfdr.de>; Fri, 20 Dec 2024 09:44:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72D847A2D46
	for <lists+stable@lfdr.de>; Fri, 20 Dec 2024 08:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 549F11A83E8;
	Fri, 20 Dec 2024 08:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=eurecom.fr header.i=@eurecom.fr header.b="NLpu3x8l"
X-Original-To: stable@vger.kernel.org
Received: from smtp.eurecom.fr (smtp.eurecom.fr [193.55.113.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12C50197A8F;
	Fri, 20 Dec 2024 08:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.55.113.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734684278; cv=none; b=uCjBSQbUHoH2SYSnvYmf4s0Z7PD4ncmzY6UGXVKDfHf26HqOBTz7tiatwm6Ue7gUSHl/J+h9X0JevCN69/Na1lRjBPjqiMIfDgYPTe/o/recgRHwgn1LK3yp3WzQxdoHiCTKrgi7SsJUlBLFIuOm2T5CZAh/Bk4v9Rxuc3McU7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734684278; c=relaxed/simple;
	bh=MhFL34B+Wvm9oSwNNFdcMDYglsbCPPNQyJ/6awuEq94=;
	h=From:In-Reply-To:Content-Type:References:Date:Cc:To:MIME-Version:
	 Message-ID:Subject; b=qdeYPvpOHPl1MPu5/OeBVIceIvRLOPi83VDQWnwX9esQ5eeCPe64sPXL8ztsHYXSXZUk3EZP33kjK7Pv7zRVit9r0g11DJ2Xg7NWuLpFqo31V07scdaEpRknQJ7kVpPM9yWHOj8J1HNCtEzz98oqY1Khdf/vXwAVsMeVN/9D6rI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eurecom.fr; spf=pass smtp.mailfrom=eurecom.fr; dkim=pass (1024-bit key) header.d=eurecom.fr header.i=@eurecom.fr header.b=NLpu3x8l; arc=none smtp.client-ip=193.55.113.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eurecom.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eurecom.fr
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=eurecom.fr; i=@eurecom.fr; q=dns/txt; s=default;
  t=1734684274; x=1766220274;
  h=from:in-reply-to:references:date:cc:to:mime-version:
   message-id:subject:content-transfer-encoding;
  bh=MhFL34B+Wvm9oSwNNFdcMDYglsbCPPNQyJ/6awuEq94=;
  b=NLpu3x8lVMuCoKbJ9cp6LwOGxa//WsKCEqHG3WY1MvfVhqYqnJQAyxzI
   mHDJcd7iaRsBOtWM9O/JFZ3h5iY2w2J1LjcnvmNOEunDeyXDAj3OqaXhI
   3IV1xNVKYJnGdH19mVcNZhhkBtr2jcKE+y9HR6eqHAG55Y4C+nLRQNlvI
   Q=;
X-CSE-ConnectionGUID: 3lLPQu7pSRCtQmZ3lBE9rQ==
X-CSE-MsgGUID: F0kXtgcrRpeBqb+3wzvApQ==
X-IronPort-AV: E=Sophos;i="6.12,250,1728943200"; 
   d="scan'208";a="28266527"
Received: from quovadis.eurecom.fr ([10.3.2.233])
  by drago1i.eurecom.fr with ESMTP; 20 Dec 2024 09:44:31 +0100
From: "Ariel Otilibili-Anieli" <Ariel.Otilibili-Anieli@eurecom.fr>
In-Reply-To: <2024122042-guidable-overhand-b8a9@gregkh>
Content-Type: text/plain; charset="utf-8"
X-Forward: 88.183.119.157
References: <20241219092615.644642-1-ariel.otilibili-anieli@eurecom.fr>
 <20241219224645.749233-1-ariel.otilibili-anieli@eurecom.fr>
 <20241219224645.749233-2-ariel.otilibili-anieli@eurecom.fr> <2024122042-guidable-overhand-b8a9@gregkh>
Date: Fri, 20 Dec 2024 09:44:31 +0100
Cc: linux-kernel@vger.kernel.org, "Jan Beulich" <jbeulich@suse.com>, stable@vger.kernel.org, "Andrew Morton" <akpm@linux-foundation.org>, "Andrew Cooper" <andrew.cooper3@citrix.com>, "Anthony PERARD" <anthony.perard@vates.tech>, "Michal Orzel" <michal.orzel@amd.com>, "Julien Grall" <julien@xen.org>, =?utf-8?q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>, "Stefano Stabellini" <sstabellini@kernel.org>, xen-devel@lists.xenproject.org
To: "Greg KH" <gregkh@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <2f7a82-67652e80-9181-6eae3780@215109797>
Subject: =?utf-8?q?Re=3A?= [PATCH v2 1/1] =?utf-8?q?lib=3A?= Remove dead code
User-Agent: SOGoMail 5.11.1
Content-Transfer-Encoding: quoted-printable

On Friday, December 20, 2024 08:09 CET, Greg KH <gregkh@linuxfoundation=
.org> wrote:

> On Thu, Dec 19, 2024 at 11:45:01PM +0100, Ariel Otilibili wrote:
> > This is a follow up from a discussion in Xen:
> >=20
> > The if-statement tests `res` is non-zero; meaning the case zero is =
never reached.
> >=20
> > Link: https://lore.kernel.org/all/7587b503-b2ca-4476-8dc9-e9683d4ca=
5f0@suse.com/
> > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > Suggested-by: Jan Beulich <jbeulich@suse.com>
> > Signed-off-by: Ariel Otilibili <ariel.otilibili-anieli@eurecom.fr>
> > --
> > Cc: stable@vger.kernel.org
>=20
> Why is "removing dead code" a stable kernel thing?

Hello Greg,

It is what I understood from the process:

"Attaching a Fixes: tag does not subvert the stable kernel rules proces=
s nor the requirement to Cc: stable@vger.kernel.org on all stable patch=
 candidates." [1]

Does my understanding make sense?

Regards,
Ariel

[1] https://docs.kernel.org/process/submitting-patches.html

>=20
> confused,
>=20
> greg k-h


