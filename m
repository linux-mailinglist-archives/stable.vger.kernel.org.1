Return-Path: <stable+bounces-200780-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 40AFACB550B
	for <lists+stable@lfdr.de>; Thu, 11 Dec 2025 10:11:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AEF16300162B
	for <lists+stable@lfdr.de>; Thu, 11 Dec 2025 09:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C35326D4DE;
	Thu, 11 Dec 2025 09:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="ezyWWWcp"
X-Original-To: stable@vger.kernel.org
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D64829BDA2;
	Thu, 11 Dec 2025 09:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765444286; cv=none; b=CQf/ecycOmGflOujHNa9bAugKY4FkVUf6NtLxDg0Rmsoze0sPuLRHtob3YYpkUxniMQ/ajEplSoF4KndFexmImVtmAiUntR+aRVv/Y2fMOobzvE6F/+IuLoi/h6YosUc22VFwlXCnRftYw1w9CLHQbGeocRic0ae56rC/8W7Ke8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765444286; c=relaxed/simple;
	bh=pBzM7yzF6xsGZ6c/L6ZKb4WZGJGONCsOhSy6VCDbfMw=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=DV0nEhFWX7jCWEK2FzpLga8R/kqrJWy7zrFY1kaOSfC8gqmUFMl78HE5fUPa41JT7O3caC/lTKt4szyuiwhcaPHJxxjUo5Xt2sPDbIkS8ec6+xtZawoLsPrFlaYZa/Sr0W1daQ1be7SlhqIzDIFXVIG++EST5XKqYwHW2MzTdCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=ezyWWWcp; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1765444254; x=1766049054; i=markus.elfring@web.de;
	bh=pBzM7yzF6xsGZ6c/L6ZKb4WZGJGONCsOhSy6VCDbfMw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=ezyWWWcpZhC44ThGjXgX+yXYicj3BPreULHp2zGOYgQclnfKjMpF5cXlhLqPAdbf
	 JKsOP4OTylG2hzlxUpMPYk7DALaNxoG2RvjS0O2AJilOqco6se3yIRlxrI3IJLPMy
	 rh18MIksU3KEMzHEyBQD8Xmdjid5SsP/6u+tRMKpLYyxn8OPuwJnGt8djRLJsCFoa
	 QMBKzUakzEpgWOojnUy3S/Z9hMGXiMcYu8Qhzgp9VOLqLuQGtJIcpkCjku3E3XNej
	 dCrhhe4i8LR5Ai9BmaKaPwJAfAlZcVPCgG97iaK4U3RQD4KByDI9Q1yY3CQ4nh5mO
	 6W8QMht05GLEMpXJ+w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.70.1]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MeUc2-1w3mrR3KDc-00huqN; Thu, 11
 Dec 2025 10:10:53 +0100
Message-ID: <b3c0256b-b54b-49c7-91e3-8ac189613abe@web.de>
Date: Thu, 11 Dec 2025 10:10:37 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>, netdev@vger.kernel.org,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Taku Izumi <izumi.taku@jp.fujitsu.com>
Cc: stable@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
References: <20251211073756.101824-1-lihaoxiang@isrc.iscas.ac.cn>
Subject: Re: [PATCH v2] fjes: Add missing iounmap in fjes_hw_init()
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20251211073756.101824-1-lihaoxiang@isrc.iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:UYM5xr/Ol+IDuQpbHZnYSsRa1J5WF4zell/rMw+SBdaAUw3ZoXg
 dMsOQZulalUekswE+udsu1jMdZZYbWU8+YGUfduG/scp35TpJ0cirwefrSMCvHlfIb6c4x/
 KIaT17ERdeEMz6ONOazylf9mYj8hb8OP3OxS/MONh208j3O0uvd/c9CZ3BlQ/IdG3mlpzrX
 /ZJdlptvEvM6b3BN0APgA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Dz3259YJtfU=;3kVB8slhMFGDEzymSik1dM3e6ZR
 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
 NBBDwRXNjwzY7aUXnlQeN1anfTxcCbxAVvik4m

> In error paths, add fjes_hw_iounmap() to release the
> resource acquired by fjes_hw_iomap(). Add a goto label
> to do so.

Under which circumstances would you get into the mood to take more desirable
word wrap preferences better into account?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.18#n658

Regards,
Markus

