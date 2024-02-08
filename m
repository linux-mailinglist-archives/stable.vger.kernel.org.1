Return-Path: <stable+bounces-19311-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F064B84E763
	for <lists+stable@lfdr.de>; Thu,  8 Feb 2024 19:08:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C4431C2114A
	for <lists+stable@lfdr.de>; Thu,  8 Feb 2024 18:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09AD085957;
	Thu,  8 Feb 2024 18:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="RIIMAezQ"
X-Original-To: stable@vger.kernel.org
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3528C86129;
	Thu,  8 Feb 2024 18:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707415634; cv=none; b=gCPy6ATx99UTvjeIU0CkpHDOy/4N4f+NPuEXpxzUhLWQqGa5ITCSEKT5JaBHcZ4xHszPBJ05tX07MSH30P4QLqcHsD11fVZj2ivDiU2cusm48qKcgVpT/E33+M/cJkvbyqP4umKkup5/Z49Sr3WFizKdsAt2aQd/o7eaphKlUaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707415634; c=relaxed/simple;
	bh=Ci7wsEPK081CK0GKX0PVwPPgWdd+LPjwvSHBLjBsH+4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jRzAcgrFKIPMOTDGgJtBnu5EqgkAuIiQTWWeVXXKmDHlvRgJzoK7mnjiE0RB2FPsv6+os+q38PioaSFpJfQJI6/ZIqJpoKvZj10XA1yfwhCRlQ5AY7P5TZ/IiOchLnYcfBdbtJrm5wv4mz4815NjsIdI/kVudoIT/ZkWgjFvTVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=RIIMAezQ; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 4C92C47A94
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1707415618; bh=btqD/sUscpisRqIZMEeDyzD02G0Y49RLeYf+rtAUkyk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=RIIMAezQ6iwGAH+hWA0RykKqN1Phoiji/zRY0RS0nUQszD/0WTZgL+mJBCJ8nQG/O
	 L1ck7D2PteVX0W9cAoLG5hFv5TXjKzA7Weyjz50um8HGX1eo4j8Sixke+++mCuwJJT
	 qpnFjXv9xQxoSSCaLMtq0F2XCdwZCSOQrrV+xwfprCEEegz/V1xpzxpogVsT9uqzSd
	 3iY5CRcRQGf0XoJmAEflpLguHmOVJ71F0+ICP6ZIE7Pyj/Y6O90DoUsR+Q0dmAXDvZ
	 C3Tynq02roloZNincSDynAjNbbhL75MihAug10Ruki9np2jQB5w+esafZyWMN3H7E8
	 wEc3jB+OAjm/A==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::646])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 4C92C47A94;
	Thu,  8 Feb 2024 18:06:58 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Vegard Nossum <vegard.nossum@oracle.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, Jani Nikula
 <jani.nikula@intel.com>, linux-doc@vger.kernel.org, Justin Forbes
 <jforbes@fedoraproject.org>, Salvatore Bonaccorso <carnil@debian.org>,
 stable@vger.kernel.org
Subject: Re: [PATCH 1/8] docs: kernel_feat.py: fix build error for missing
 files
In-Reply-To: <5e316709-61d1-4c6f-a000-c45d7f9fdd31@oracle.com>
References: <20240205175133.774271-1-vegard.nossum@oracle.com>
 <20240205175133.774271-2-vegard.nossum@oracle.com>
 <8734u5p5le.fsf@meer.lwn.net>
 <bb4493e2-91bb-4238-ab77-b38b16cd2a57@oracle.com>
 <87ttmknxny.fsf@meer.lwn.net>
 <5e316709-61d1-4c6f-a000-c45d7f9fdd31@oracle.com>
Date: Thu, 08 Feb 2024 11:06:57 -0700
Message-ID: <87ttmihltq.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Vegard Nossum <vegard.nossum@oracle.com> writes:

>> The purpose is to point the finger at the file that actually contained
>> the error; are you saying that this isn't working?
>
> For kernel_feat.py: correct, it never did that.
>
> See my longer explanation here:
>
> <https://lore.kernel.org/all/d46018a3-3259-4565-9a25-f9b695519f81@oracle.com/>

OK, good enough.  I've applied the patch and will send it Linusward
after a bit of linux-next time.

Thanks,

jon

