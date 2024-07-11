Return-Path: <stable+bounces-59062-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DB4392E054
	for <lists+stable@lfdr.de>; Thu, 11 Jul 2024 08:52:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDA3728266D
	for <lists+stable@lfdr.de>; Thu, 11 Jul 2024 06:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5756E12E1D9;
	Thu, 11 Jul 2024 06:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="Tmj/efhF"
X-Original-To: stable@vger.kernel.org
Received: from mail-43166.protonmail.ch (mail-43166.protonmail.ch [185.70.43.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AFB184E1E
	for <stable@vger.kernel.org>; Thu, 11 Jul 2024 06:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720680759; cv=none; b=PVUJdOA7rBVG8+E3wLL5F70cd7uH1A5e4n5plfibOAqlg72l61/Gklnj6gMLrqc9PDb/oidJiUTn92LIP/6qOzIz5eLBLQVau+PPWJVTQxxS+nrc583j4xeERrEfBDadvDkmBlrgR5Dn7gQ41ULINXaAAmvfXaTa4RCnBcjCK7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720680759; c=relaxed/simple;
	bh=qmAOufjbRTMxAik2LKh+vat3ilq/owKUsub4PmqcQqU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G1eyPxMV/JnGMzE1F4tt2UpDHvYnP6QCNY1R0TNEl+sQHVPKSDdsIvy3HLINSFi3rF7TDzSULpsTuGn9hpp3zkHDIElHutAv0MHDKfvrONOMy/6mNveeie/N2tOW5DHq+mKUufHTnwdzVas8Qp5NYpcbVdpYkISLjN4SYKH/SWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=Tmj/efhF; arc=none smtp.client-ip=185.70.43.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1720680749; x=1720939949;
	bh=qmAOufjbRTMxAik2LKh+vat3ilq/owKUsub4PmqcQqU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=Tmj/efhFP6OUsuAS0b+JDHo4vMQ/4a4PwDtKGR4SceXbdrZp0t3ojF2FU3mTYoL/q
	 D5M/bBghp90g9rbngygTcCj4ckBtnNLK/eOUxxftn+cYHd/B/MVkBJ3aMRg/c3eQ/Y
	 W9898kfdnWk+H+Hhw6/uPP2lZxULmCrFP7s3jhJQ6+Ks+OavbSeed4vszxwnW1PGII
	 Fvx7E/6ZrzVdjBbqsrNe7iMNmwjUd5q4GjnUh9G6IhczXOdPfZzZLt4bUrsOmyZbqj
	 4Pi0ZrV59mAnPNi55pnSTIzbGGrRzd620gFNIBh0HnK8kTSwekghyUQEH6e7OmIQLw
	 dgdlxEozhcBaw==
Date: Thu, 11 Jul 2024 06:52:22 +0000
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
From: Jari Ruusu <jariruusu@protonmail.com>
Cc: Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, linux-kernel@vger.kernel.org, x86@kernel.org, Robert Gill <rtgill82@gmail.com>, Brian Gerst <brgerst@gmail.com>, "Linux regression tracking (Thorsten Leemhuis)" <regressions@leemhuis.info>, antonio.gomez.iglesias@linux.intel.com, daniel.sneddon@linux.intel.com, stable@vger.kernel.org
Subject: Re: [PATCH v4] x86/entry_32: Use stack segment selector for VERW operand
Message-ID: <m2A7GXQAIf62-3nxzvPWE28Spw3Jn2JuIgtsZbMrXN2HF-mZwtMOQ7BKcrmRD3A_nocJYD8YgnFmC9kK0CONp8DxzZnuvBq6D3vaYFsBRUQ=@protonmail.com>
In-Reply-To: <20240710-fix-dosemu-vm86-v4-1-aa6464e1de6f@linux.intel.com>
References: <20240710-fix-dosemu-vm86-v4-1-aa6464e1de6f@linux.intel.com>
Feedback-ID: 22639318:user:proton
X-Pm-Message-ID: a9d51c473115ecc45c188040c536af694d9fb87c
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wednesday, July 10th, 2024 at 22:06, Pawan Gupta <pawan.kumar.gupta@linu=
x.intel.com> wrote:
> Fixes: a0e2dab44d22 ("x86/entry_32: Add VERW just before userspace transi=
tion")
> Cc: stable@vger.kernel.org # 5.10+
> Reported-by: Robert Gill rtgill82@gmail.com
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D218707
> Closes: https://lore.kernel.org/all/8c77ccfd-d561-45a1-8ed5-6b75212c7a58@=
leemhuis.info/
> Suggested-by: Dave Hansen dave.hansen@linux.intel.com
> Suggested-by: Brian Gerst brgerst@gmail.com # Use %ss
> Signed-off-by: Pawan Gupta pawan.kumar.gupta@linux.intel.com
>=20
> v4:
> - Further simplify the patch by using %ss for all VERW calls in 32-bit mo=
de (Brian).
> - In NMI exit path move VERW after RESTORE_ALL_NMI that touches GPRs (Dav=
e).
>=20
> v3: https://lore.kernel.org/r/20240701-fix-dosemu-vm86-v3-1-b1969532c75a@=
linux.intel.com
> - Simplify CLEAR_CPU_BUFFERS_SAFE by using %ss instead of %ds (Brian).
> - Do verw before popf in SYSEXIT path (Jari).
>=20
> v2: https://lore.kernel.org/r/20240627-fix-dosemu-vm86-v2-1-d5579f698e77@=
linux.intel.com
> - Safe guard against any other system calls like vm86() that might change=
 %ds (Dave).
>=20
> v1: https://lore.kernel.org/r/20240426-fix-dosemu-vm86-v1-1-88c826a3f378@=
linux.intel.com

Pawan,
Your patch looks OK to me.

Greg,
I have verified that patch hunks go correct places on
kernel.org linux-5.10.221, linux-6.1.97 and linux-6.6.38
kernels. All tests run inside 32-bit VM. The patch fixes
show-stopper issues with virtual-8086 mode and dosemu. Once
the patch is accepted upstream, it should go to all 5.10+
stable kernels.

--
Jari Ruusu=C2=A0 4096R/8132F189 12D6 4C3A DCDA 0AA4 27BD=C2=A0 ACDF F073 3C=
80 8132 F189


