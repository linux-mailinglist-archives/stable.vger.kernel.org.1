Return-Path: <stable+bounces-160443-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 361CBAFC191
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 05:50:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6605D426B30
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 03:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB44B19D065;
	Tue,  8 Jul 2025 03:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="Yugk+CyG"
X-Original-To: stable@vger.kernel.org
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22CF61990A7
	for <stable@vger.kernel.org>; Tue,  8 Jul 2025 03:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751946634; cv=none; b=suwqqZM1XsNG5M5MDLQoX8jRKJkFK/2m9GmljBjZ2IGBzt+fLgg+w3BKWOB5Cl5wU/X/ycuKZbbU2FLhKU7fqizyjWi1u5BXVYKozo1hWlmEGpFOaFkEpYgeW0XQkHK8/Ki8kZNsavUkP6SMqyOuOIVvyR/82tsr93T3006um0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751946634; c=relaxed/simple;
	bh=lGCclWXlatkY5vsKkO8/RoY2XuA+KbX7Iof9LK3V1vs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JLLXAb8OdCMWy8yZIJFTsG11SlmANyjUWyuB31DwwpgP70SzA49rjRXROpg4mZ2hFVNNfCHq67XoRU4wJK2f6EmFJjxCaLpKR9XoqwFO3n6gWzQV4VYWT8eDdQnFNVU5AaCfFJE1Ks45UuxEt7qK+mmydYQnxbpLt9SzjA4TWiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=Yugk+CyG; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1751945227;
	bh=lGCclWXlatkY5vsKkO8/RoY2XuA+KbX7Iof9LK3V1vs=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=Yugk+CyGKMKw7OMCKJ1hzlKtTFr5RQ58KjEPPCnvIG9RJgucagRAFV0vwhx0T/9xS
	 TpnUrFHZZLmsm7BFGBMzkXdvj5sETNqmdp0qYYvrr1syZQO3CR8GBXRIJ5nUerNHuI
	 dJGteDPKyPFOf3XXjx8JKAdjKgAd7mhao4Nz1mmE=
X-QQ-mid: zesmtpip2t1751945206t1c0f221f
X-QQ-Originating-IP: rlSyvvFy1U9RsJt6yICitCUa28xBwuGjBpybJaCR1ik=
Received: from avenger-e500 ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 08 Jul 2025 11:26:44 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 4491923407326219963
EX-QQ-RecipientCnt: 9
From: WangYuli <wangyuli@uniontech.com>
To: gregkh@linuxfoundation.org
Cc: chuck.lever@oracle.com,
	masahiroy@kernel.org,
	nicolas@fjasle.eu,
	patches@lists.linux.dev,
	stable@vger.kernel.org,
	dcavalca@meta.com,
	jtornosm@redhat.com,
	guanwentao@uniontech.com
Subject: Re: [PATCH 6.6 129/139] scripts: clean up IA-64 code
Date: Tue,  8 Jul 2025 11:26:44 +0800
Message-ID: <E845ABA28076FEFB+20250708032644.1000734-1-wangyuli@uniontech.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250703143946.229154383@linuxfoundation.org>
References: <20250703143946.229154383@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: N6+UlSQllctNp5jANuzqlaMAsNSNol9HG6zc76wQHn7n8X7hEm6WrdZx
	knliQXtZ3IWIep8pEmqcVW8dQaYuWkZuQP4BWQzZvXV+x25idUry+2r3gyEOK2Ngl8zYOuh
	z/KHcgnafNAIQogT+gfKLiHkpV0noay3yLxM5aVf/0MXmJLUdJ6FmQfuyg96WABRFFGSD+2
	lx84RpKUs8YyWKieb8/vG6k3u4AjZN4e8tYwaHi+5AOIE7FYS0rR3DZyN2fKxHjoFwfb/2G
	r5/pWjqsIG+KIJYNagcIVL60/5bWdKIniXltRr/ka8LFgTWF4VPcE1wWiVbmiJ9NutXCjKu
	uHyhy+tHm7hnLzBff13biwuRNDrjXLxuNTul4kQZja7i+ycjBCIwK+6wUh+foyHa86O1v0+
	6iMj/51Rau4fN1moKhzxxM/o/4VS/J4LvrrvEg2NkpxSdwG2MP+jRPxtyyw6rtzP1TOONWK
	8/aOEdv74XaQ3rsmpRM5COAv3qr7cRNSvXnj/8/67LIVwI9B5rBRcuXeX1UIiY6CD6KFb3f
	ut98pjzD3AT50mTX46suNus8uEsHZGqPdurC3eQP97UNmeUZc4RYpnd6fOxQ/+w9W1CKySH
	RUKu2f0ZYa88Rff3AkahqLZ0CSH67n/gUWRVO3nCEbvmkC0Uik1tLrotgFb+cWn/8jreu13
	ecLJ7vBw8x3+EFBV+3HPRpc6Zs/6meTEumLD7KuuKfVIk71HcAUVm2TZgfz4a37N5wfxT2L
	HqKpWmeLWPW3ye9fGKlfTxUGF6iXxAAuR+GS958arW7uyUnWzJQBe/ZozK9vJLQ1ECi1+Cz
	bxBtxXp/6MRmkM2r3kUhCMPx4FBypmG+jtUG+u4mE/KLGrdjhlyAbtNotSJs2gsRp9lk668
	AuTdmAHEB+EaDpN1t6PtF36p6aZ5PbOWQOYh6m4TXFCK7hS3n1qxjBcsx3kg4oFl7q3Jjnb
	bFJ7vyPw/NWKsI3EqrFRnHDmKMAlRyhwF+8V0crIODx0ykXkvzZ5v7WeIkTdKerD3pto=
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
X-QQ-RECHKSPAM: 0

Hi all,

This commit is a refinement and cleanup of commit cf8e865 ("arch:
Remove Itanium (IA-64) architecture"). However, linux-6.6.y and earlier
kernel versions have not actually merged commit cf8e865, meaning IA-64
architecture has not been removed. Therefore, it seems commit 0df8e97
("scripts: clean up IA-64 code") should not have been merged either.

I stumbled upon this while tracking the v6.6.69 update. It appears
commit 358de8b ("kbuild: rpm-pkg: simplify installkernel %post")
depends on commit cf8e865. We should perhaps consider reverting both
of these commits and then refactoring commit 358de8b to prevent any
issues with the IA-64 architecture in future linux-stable branches.

Thanks,
--
WangYuli

