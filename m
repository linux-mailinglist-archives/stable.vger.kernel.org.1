Return-Path: <stable+bounces-125805-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5B23A6CA8E
	for <lists+stable@lfdr.de>; Sat, 22 Mar 2025 15:27:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26ECA481E8E
	for <lists+stable@lfdr.de>; Sat, 22 Mar 2025 14:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97CC022155E;
	Sat, 22 Mar 2025 14:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="ABq535O4"
X-Original-To: stable@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6023F136E3F
	for <stable@vger.kernel.org>; Sat, 22 Mar 2025 14:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742653645; cv=none; b=n9YcsmhjI69naGQpt/+TUaHbGVRbIMcqWmOob6LvhyD81YJChWoQukFPTUxOCNGak0KXIDNg8fMJpVbEe7Pto++31chemTUqmwqW5GLQ0BKg5LMpWgI9lluC63o28oHWJeV0t3wJcjjmB87/M60XnjdNuHMrNMjttan1WptQKzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742653645; c=relaxed/simple;
	bh=SInFQBXy8v6VGM0Bj/llKgw4eIXx49g+0nlyMvZxouE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SaF/ULZRkt4/yIlVdal936bFV4wmcdDYzxVwNpsVK+ie4RDOA481cvMH8y5hAUzedGPc7TxMJcgpJsBBXJqjq1H1mEn/plwgn3F3ikijDxY4nhTqGJ03Wbu4VvPQCSZat6AhJdNx9Jj95C/Xm7uAYxkc43SWAeQiqZ47UKt3cEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=ABq535O4; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from localhost (unknown [10.10.165.6])
	by mail.ispras.ru (Postfix) with ESMTPSA id 7DA644076164;
	Sat, 22 Mar 2025 14:27:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 7DA644076164
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1742653633;
	bh=UCLyE65jhG1tenAq/Xe9qE/qxAn6cImMDBNKE5vkfrM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ABq535O4KVMDnl/QzzdxIPito8a5pVQs+CDPAn/nuuBl7pr5WlG66uwVWsrY+qDnr
	 LfifcgIfTr98erB/aPubO10fVoLB/sJXYJjIHPHlT3vTFUe+J5hafZYisX829Cqd0f
	 yoZLaDaGue9vgoA5FOIsVCVnq5JKGCC8vEJZIRHI=
Date: Sat, 22 Mar 2025 17:27:13 +0300
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Leah Rumancik <leah.rumancik@gmail.com>
Cc: stable@vger.kernel.org, xfs-stable@lists.linux.dev, 
	"Darrick J. Wong" <djwong@kernel.org>, Christoph Hellwig <hch@lst.de>, 
	Catherine Hoang <catherine.hoang@oracle.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	lvc-project@linuxtesting.org
Subject: Re: [PATCH 6.1 14/29] xfs: use xfs_defer_pending objects to recover
 intent items
Message-ID: <oowb64nazgqkj2ozqfodnqgihyviwkfrdassz7ou5nacpuppr3@msmmbqpp355i>
References: <20250313202550.2257219-15-leah.rumancik@gmail.com>
 <6pxyzwujo52p4bp2otliyssjcvsfydd6ju32eusdlyhzhpjh4q@eze6eh7rtidg>
 <CACzhbgRpgGFvmizpS16L4bRqtAzGAhspkO1Gs2NP67RTpfn-vA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACzhbgRpgGFvmizpS16L4bRqtAzGAhspkO1Gs2NP67RTpfn-vA@mail.gmail.com>

On Fri, 21. Mar 10:42, Leah Rumancik wrote:
> Hey Fedor,
> 
> Thanks a bunch for the report! I don't see xfs/235 running on my
> setup. I will look into why and see if I can repro.
> 
> Few questions,
> 
> Were you able to confirm that e5f1a5146ec3 fixes the issue on 6.1.y?

Oh, it probably wasn't obvious from my initial report but the problem
concerns only 6.1.132-rc1 at the moment. It's in testing phase and hasn't
been finally released yet. So it hasn't reached 6.1.y.

Unfortunately, it's hard to port the proposed fix directly on top of
6.1.132-rc1 since it depends on a number of non-trivial changes done in
mainline. The conflicts are huge and require a solid amount of expertise
in the code and I'm not ready to do this to be honest.

Well, as I perceive, the reason to port the following patches

[PATCH 6.1 13/29] xfs: don't leak recovered attri intent items
[PATCH 6.1 14/29] xfs: use xfs_defer_pending objects to recover intent items
[PATCH 6.1 15/29] xfs: pass the xfs_defer_pending object to iop_recover
[PATCH 6.1 16/29] xfs: transfer recovered intent item ownership in ->iop_recover

to stable (6.1, in particular) is to fix a UAF when intent recovery fails.
This is stated in upstream patchset [1] where the patches come from.

[1]: https://lore.kernel.org/linux-xfs/170191741007.1195961.10092536809136830257.stg-ugh@frogsfrogsfrogs/

Taking as a fact that 6.1.y is vulnerable to that bug (though I failed
to find an exact blamed commit), I think that the whole series of 8
patches should be ported, otherwise it looks not complete. But only 4/8
patches have been taken to 6.1-queue and 6.6 so far.

> If so, we can just port this patch, otherwise we might want to drop
> the xfs set while we investigate further.

I'd suggest to drop the xfs set from 6.1-queue for now until the problem
is addressed in some way.

> 
> Also, the backport set you mentioned was based on a set from 6.6.y. I
> don't see the suggested fix (e5f1a5146ec3) there either. If it's not
> too much hassle, could you see if we have the same problem for 6.6.y
> as well?

Yes, the crash occurs there, too. And for 6.6 case it actually is for a
released kernel (since v6.6.24).

The remaining four patches of the original upstream series [1] - one of
which is e5f1a5146ec3 - can be applied there without many problems,
fortunately.

I'll send them to you in a separate thread.

