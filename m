Return-Path: <stable+bounces-106793-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BEFAA02209
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 10:39:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47AF81620F4
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 09:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 310EA1D63F6;
	Mon,  6 Jan 2025 09:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="FYjmLUIS"
X-Original-To: stable@vger.kernel.org
Received: from out203-205-221-239.mail.qq.com (out203-205-221-239.mail.qq.com [203.205.221.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 561131DA0FC;
	Mon,  6 Jan 2025 09:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736156363; cv=none; b=DpDYgPpKJRjmKPlWjRh2HBaV+r2aecQVJu81n0cdVrX+5Kdvt9We918nW1WCnzgW9WInf6EYF7Mzqiw5+fKpkNw++4QCdlBCB99p44vJ3Skv6o+4DWWhXmOwLgCzczE8BMVeDBc85C80NKwQZsLlhEYPSykJMhEBb8gbfZPCPr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736156363; c=relaxed/simple;
	bh=ZQYibejqE4TExO2iEVVmTrD/3+FAGumuR1B+opzCMKU=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=AujKvHmU/8rN/ekOZPoC6f7PG9q/dVGoe6kIwgEQH0/sIdEBmHLD27NtkUYsp2GfA9HC0mx5LhZdn1bChgHYRgtS1ZWzpOkd97Td+X3nZq/s+M7F2fwA+JSYxq5fsl/ug/bhnzVIbRXTxC06H0XYTYC7+H3Unt17fckM7WwDwdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=FYjmLUIS; arc=none smtp.client-ip=203.205.221.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1736156358; bh=VRd49/RdjOMtSF0Dp89uuTuLBYYB2XeayAQ74EgXOm8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FYjmLUISZQjSgm3tfw1a2lCgBCa4kQSTFj+LA9lTfPgpYfs1qwY7Uu5oODb1fZ19a
	 hbkWxcvA+vgZNKY3E9Gfi3FrH47sQ+oadXvp+96bLXohSqsSdsxmtIdhHZSoVLtSng
	 DIUR0UlizeeSQfN88cuNDOgqre3lwy5NKRQkjgwE=
Received: from localhost.localdomain ([101.227.46.164])
	by newxmesmtplogicsvrsza29-0.qq.com (NewEsmtp) with SMTP
	id 9CF2B06A; Mon, 06 Jan 2025 17:39:15 +0800
X-QQ-mid: xmsmtpt1736156355t15j3w3r0
Message-ID: <tencent_10B23944B666A0C0C456F8409D1E60DA750A@qq.com>
X-QQ-XMAILINFO: MDPfhejMR4aIlVM9r8e0L5JxqTxbH64A7KJOvXFnvEXsf/jdQTKVE7/EklZM0+
	 nMK7tHNdYGmTq3d+kn8+f/aP5iuC/PT73pXp605l6s4GoTMqLYvwIMtXgRsG21lOVhYE4VDleba3
	 BKH+TI2sZ3sKo9ToRAhLrgRQyiiQMSLfg7x3j9octvA5K0ptud5oLTbeno6Bm67vn0BgdHmCcIqh
	 1bXX0cCpv8PNND84rVsy255QnpOjloQA8J/Km97NqNY/GOUFBme6aDBI0jtWqfXcBO9k+w9s/MAB
	 eYEPR3VA4bewN4kCKHIGuvxf5Tsb1MNnqEFPn0iEgh4hcTaJWrgdCAal5O55KAYjcGSzqw9orf8d
	 GgbOre0bUczt119kpXuAbq88PoAycaobahG8yDto8EcCyxx4v4jSXuUx2sup3wUrPRVMzkRo13Dp
	 0RP1ZfXDJFRTBlcvAgh/ZG1Rqiisa9SjR+XQLd4k3JsnEMNkQh/2/H6HBgt1LTZz86aJkn6NNEaM
	 0+ClWZesaTPuBhRDQldezmriVl+yierlVcTbJtfHoH5lHYRWWV9sS+PkIQQd9+OWyuKz7Td1Xqri
	 Mh/5OOslcAmOjc+gtHdAcHKKtsOU/LPMqcmy34ZJmGyrHffw+3EIPCkq//GsrYNc+xJwCpwBgCYJ
	 AMWcqnho0YG+stFu7iv5oMPTgJkv70R9qO+i6bcpEKtSkZvOcjtHjImLuX1KlUAVaPQ645dSkbJG
	 RMibtPnXiw7bilyyi9/dL+JSPA12Juo3qxh3e02RyRsPHvaIXw/yv+uTNCRicTe6VNgZay8OMfzG
	 4Hh65maFzIXP/Atrf+ThrsQ4I6phHudUX7NI1/XXn9/dg3l6Ms7Lk9r2KnCjwUfIHlJX0kq9KIw5
	 uO7tgpoWme9z0Qcb4FRvlnflh+kAE+t8IcMJu9mObpwi/H2W2KnrPOr05yJNS9BbasKKyqwd/3Si
	 gDX7oVNG+uzfAp6Gu2mHEJCqkH4GJp8Gj/EODrEIrm/roUzDSiHA==
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
From: wujing <realwujing@qq.com>
To: peterz@infradead.org
Cc: gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	mingo@redhat.com,
	realwujing@qq.com,
	sasha.levin@linux.microsoft.com,
	stable@vger.kernel.org,
	yuanql9@chinatelecom.cn
Subject: Re: [PATCH] sched/fair: Fix ksmd and kthreadd running on isolated CPU0 on arm64 systems
Date: Mon,  6 Jan 2025 17:39:15 +0800
X-OQ-MSGID: <20250106093915.118822-1-realwujing@qq.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250106092134.GA20870@noisy.programming.kicks-ass.net>
References: <20250106092134.GA20870@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On x86 architecture, we have checked many machines in the cluster, and this 
issue does not exist.

> Your subject explicitly mentions arm64, however there is absolutely
> nothing arm64 specific to this patch, as such the subject is just plain
>wrong.


