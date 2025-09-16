Return-Path: <stable+bounces-179673-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAA8CB58BBF
	for <lists+stable@lfdr.de>; Tue, 16 Sep 2025 04:15:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 602592A6A7A
	for <lists+stable@lfdr.de>; Tue, 16 Sep 2025 02:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DA29230BCE;
	Tue, 16 Sep 2025 02:14:55 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB521EF39E;
	Tue, 16 Sep 2025 02:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757988895; cv=none; b=OHjiEc6360r0Ylgc3wk8C8MiLIMa+lz5/rBDn/LIz2v19v0vkNTwvZ1dKiyENinjvTgIdyNkucbBvjZOTIKUpiIDmCipkf16K50m5J1Qb5N3SBXsPb2wZhXwofVjxt6e+qRgV6JOXr75l7ja/o8bIgYm48/aLhkrFzV7tx/8b3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757988895; c=relaxed/simple;
	bh=t0+pyJOE5A1fkkvqFafLdRCqE3pkM3MRMs8OarGPIeY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FzsOhXAoPahy7ZCHvd3aiFcOUNY2+vHmyzLQQx03j7KY2yyeWCcGj04EAp6H2drRG/MpR5ZmfSmUGc+h15BCi2wkvCSoQrwSzdBeWRB7bKMGrAfd+8fFYShUL+y9hT53IpTwPzx92ykJXaUYypTpbD/cHYqLImgx4IHkjt9QdWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com; spf=pass smtp.mailfrom=perches.com; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=perches.com
Received: from omf16.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id DDB32BA978;
	Tue, 16 Sep 2025 02:14:51 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf16.hostedemail.com (Postfix) with ESMTPA id AF5EA2000D;
	Tue, 16 Sep 2025 02:14:48 +0000 (UTC)
Message-ID: <8d7be334af3944f990b56c80a70b7691763c3af8.camel@perches.com>
Subject: Re: [PATCH v2 1/3] mm/ksm: Fix incorrect KSM counter handling in
 mm_struct during fork
From: Joe Perches <joe@perches.com>
To: Andrew Morton <akpm@linux-foundation.org>, Donet Tom
	 <donettom@linux.ibm.com>
Cc: David Hildenbrand <david@redhat.com>, Ritesh Harjani
 <ritesh.list@gmail.com>,  Xu Xin <xu.xin16@zte.com.cn>, Chengming Zhou
 <chengming.zhou@linux.dev>, Wei Yang	 <richard.weiyang@gmail.com>, Aboorva
 Devarajan <aboorvad@linux.ibm.com>, 	linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Giorgi Tchankvetadze	
 <giorgitchankvetadze1997@gmail.com>, stable@vger.kernel.org
Date: Mon, 15 Sep 2025 19:14:47 -0700
In-Reply-To: <20250915164248.788601c4dc614913081ec7d7@linux-foundation.org>
References: <cover.1757946863.git.donettom@linux.ibm.com>
		<4044e7623953d9f4c240d0308cf0b2fe769ee553.1757946863.git.donettom@linux.ibm.com>
	 <20250915164248.788601c4dc614913081ec7d7@linux-foundation.org>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Stat-Signature: o163tfrni7ocid8g349t8n5cua8zq9qz
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: AF5EA2000D
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/i3wGdkIngDc5k8Zy9mtT9x0Jsae1TNBU=
X-HE-Tag: 1757988888-560775
X-HE-Meta: U2FsdGVkX1/IiBxbokcBHqtrQxfWaIRW4VWdsUC4FwYwqm/5zOBA2s+BAamLDGjQe/aFn7eBn854xpZKTPl8Wiqn/QcEF1vW1Uw9OEf52Pq+BOiart5k8W/VWobc0YHPYAPa4IVrDZmy3fHGH3BpBjcbEdEWDGQmJjOtMGIzrjc3tILATrQm7nwc1uKHx+JcqgAznSoxX7cKwV7EPr2tidUMIg8gL8JbTGaEds0GlD1ZHzRpVayCEXOIeQkyC/QDmBqTc62s1mLNjBkegG/SNdySVqPcY1LGTpuF+NTwpqDHAcGbgn9UhoIgfN0RwdJYa8T1wPf1L17l0gkGKTV/OizrBdeJxMW/eLt/a54CB26/tlJXQ5NQ2g==

On Mon, 2025-09-15 at 16:42 -0700, Andrew Morton wrote:
> On Mon, 15 Sep 2025 20:33:04 +0530 Donet Tom <donettom@linux.ibm.com> wro=
te:
[]
> > Fixes: 7609385337a4 ("ksm: count ksm merging pages for each process")
>=20
> Linux-v5.19
>=20
> > Fixes: cb4df4cae4f2 ("ksm: count allocated ksm rmap_items for each proc=
ess")
>=20
> Linux-v6.1
>=20
> > Fixes: e2942062e01d ("ksm: count all zero pages placed by KSM")
>=20
> Linux-v6.10
>=20
> > cc: stable@vger.kernel.org # v6.6
>=20
> So how was Linux-v6.6 arrived at?
[]
> (Cc Joe.  Should checkpatch say something about this)?

Probably not. Parsing variants of versions seems, umm, difficult.

