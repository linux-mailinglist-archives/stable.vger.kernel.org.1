Return-Path: <stable+bounces-254834-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OJgEEuoVGGoBdAgAu9opvQ
	(envelope-from <stable+bounces-254834-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 12:16:10 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CBCF5F0696
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 12:16:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AB693305FED1
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 10:16:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A390A3B6C1D;
	Thu, 28 May 2026 10:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="hf2UkpOi"
X-Original-To: stable@vger.kernel.org
Received: from mail-m82104.xmail.ntesmail.com (mail-m82104.xmail.ntesmail.com [156.224.82.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ACFA3B6352;
	Thu, 28 May 2026 10:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.224.82.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779963358; cv=none; b=MwQmSruxHVVbNaGJTUfj4dg90+kSJe9slS/4qug/mFoa2UjYgtQ0BX4sSt/KEm7eFWGlqDCeV9Pd2UUApX2ebxc0kPeAVYmDPpGG3DfaXCWl5RqwiIp5rExBgzVfoFOS6hWx8HVuk35ogx+UUAkkseBmg0nmGQ4ul+eO0MPUriY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779963358; c=relaxed/simple;
	bh=62qjLgq1oKM6QYwtvkJtRjfY+z8djIogWp3aL/Gpas0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=riwzBjsjOS8aWqJIAmZGhOjHF1AJHmwUp/cg+JG0gYu7C2IUo5Cb4fLsw28zBs9uTpAKpm1F7+oNAxyxFwFb0tE1CNLzDr6e85/cbtLfRvwSaSOfkFyAFMWoVoy5bX/B7gpBWGt9CNwfSILHMD7Joj50f4uHI69fsXEggcX0wA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=hf2UkpOi; arc=none smtp.client-ip=156.224.82.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Received: from DESKTOP-SUEFNF9.taila7e912.ts.net (unknown [221.228.238.82])
	by smtp.qiye.163.com (Hmail) with ESMTP id 402d03124;
	Thu, 28 May 2026 18:15:42 +0800 (GMT+08:00)
From: Dawei Feng <dawei.feng@seu.edu.cn>
To: error27@gmail.com
Cc: gregkh@linuxfoundation.org,
	omer.e.idrissi@gmail.com,
	hansg@kernel.org,
	hi@josie.lol,
	straube.linux@gmail.com,
	xela@viard.dev,
	ethantidmore06@gmail.com,
	liangjie@lixiang.com,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	jianhao.xu@seu.edu.cn,
	stable@vger.kernel.org,
	zilin@seu.edu.cn
Subject: Re: [PATCH] staging: rtl8723bs: fix mismatched free of HalData in rtw_sdio_if1_init()
Date: Thu, 28 May 2026 18:15:42 +0800
Message-Id: <20260528101542.2395619-1-dawei.feng@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <ahfvCpI6YOA9Gpyh@stanley.mountain>
References: <ahfvCpI6YOA9Gpyh@stanley.mountain>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9e6e152e5d03a2kunm1d63080577846
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDQk0eVksfSkodSUNISxhIQ1YeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUpVSUlDVUlIQ1VDSVlXWRYaDxIVHRRZQVlPS0hVSktJSE
	5DQ1VKS0tVS1kG
DKIM-Signature: a=rsa-sha256;
	b=hf2UkpOi3frLhM5+YMBnuRHRvJnZtPyomka90RTF9EUef+4rGlKuBKkFKGmwNgs80lcLAOnCpX/wYcBSEkAOvNHzlndKrwefHORJBs2e9MMYhBNFgm9S0rBVUUdWUOZlkPggUCYdiiNijuFqp/sZlIRWVutTpk/dw1fYULrkyMU=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=cm1IXCghAruZxMXm5ndJwzdSK/e/RcJeQCV3orZya5o=;
	h=date:mime-version:subject:message-id:from;
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[seu.edu.cn,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[seu.edu.cn:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[linuxfoundation.org,gmail.com,kernel.org,josie.lol,viard.dev,lixiang.com,lists.linux.dev,vger.kernel.org,seu.edu.cn];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-254834-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dawei.feng@seu.edu.cn,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[seu.edu.cn:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.994];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[seu.edu.cn:email,seu.edu.cn:mid,seu.edu.cn:dkim,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 3CBCF5F0696
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, May 28, 2026 at 15:30:18 Dan Carpenter wrote:
> > Manual inspection
> > confirms that the issue is still present in current mainline.
> > 
> > An x86_64 allyesconfig build showed no new warnings. As we do not have
> > suitable RTL8723BS SDIO hardware to test with, no runtime testing was
> > able to be performed.
>
> to HERE should be put
>
> > 
> > Fixes: 554c0a3abf21 ("staging: Add rtl8723bs sdio wifi driver")
> > Signed-off-by: Zilin Guan <zilin@seu.edu.cn>
> > Signed-off-by: Dawei Feng <dawei.feng@seu.edu.cn>
> > ---
>   ^^^
> Here under the --- cut off line.  We don't need this kind of meta
> commentary about testing in the permanent git log.  Otherwise
> the patch is correct.

Hi Dan,

Thank you for the review and for pointing this out. 

The reason the manual inspection and testing commentary was placed above
the `---` line is that we were strictly following the example template
provided in Documentation/process/researcher-guidelines.rst. 

In the researcher-guidelines[1], the example explicitly places the build
and hardware testing disclaimer before the Signed-off-by tags, which is
why we included it directly in the commit message.

Please let me know if you would like a v2 to adjust the position of the
mentioned commit log details.

[1] https://docs.kernel.org/process/researcher-guidelines.html

Best regards,
Dawei

