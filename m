Return-Path: <stable+bounces-20491-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66AF9859DD2
	for <lists+stable@lfdr.de>; Mon, 19 Feb 2024 09:10:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 186DC281ED7
	for <lists+stable@lfdr.de>; Mon, 19 Feb 2024 08:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60BF820B11;
	Mon, 19 Feb 2024 08:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=felix.moessbauer@siemens.com header.b="l/q8A9zv"
X-Original-To: stable@vger.kernel.org
Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3568320DF1
	for <stable@vger.kernel.org>; Mon, 19 Feb 2024 08:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708330172; cv=none; b=VhiTYaHOedplDBJ6za5UqeLhQkyWKcbUxdmxJqvZilB5Yq12HaAA/83Mfe2bQ3RaUqTLYzsWLRcydh532r3KSzO65qmfhxEOXzGBsWFLbeHSpnyj4YcNBaJMWB/f9Go8e36AKestN93MSgLMIKalLFZ38WQZG8CHqUyVWd7AA6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708330172; c=relaxed/simple;
	bh=n1v3NRXwxyRtyxpCEzmUxF08CXMN3RocTys00ef1kqg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QG2LmyTNZqcIG4/mSRi1nVj6Nf/lPLTcUQhen+eRrRWd0FlQFPy+kmZJl32pDnGBBq2Vf71gc/aBcrL8xN0aDyoJRmPXIDDVN7DnW4uVYwzXYtGMUNBWtqD/MEOlSHrI/SCxPSIt6dZiBz2ox7i8arDVXmx0oPjmvJu5CqLc1Ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=felix.moessbauer@siemens.com header.b=l/q8A9zv; arc=none smtp.client-ip=185.136.64.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 20240219080917d44aa608fc0b80974d
        for <stable@vger.kernel.org>;
        Mon, 19 Feb 2024 09:09:17 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=felix.moessbauer@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=C/qoZPCJcnCyni1HoQmKacGfjqKKV4MiTxseBfGZQ3M=;
 b=l/q8A9zvdEFZIYF6OnlMSw2vElUErJqG1i+xNxxWvE4KxCeax8Wphqv6+bnL83CZqixse/
 L5iNmVKKbo1ttpU/DEPh94zDZVAKnn0va4v7s0iucqmz1S6280UUQ0ibR2l68i8ObDNn49Ln
 a+JO5vFvD91IfeNprrGEWpeM3yxHg=;
From: Felix Moessbauer <felix.moessbauer@siemens.com>
To: stable@vger.kernel.org
Cc: dave@stgolabs.net,
	tglx@linutronix.de,
	bigeasy@linutronix.de,
	petr.ivanov@siemens.com,
	jan.kiszka@siemens.com,
	Felix Moessbauer <felix.moessbauer@siemens.com>
Subject: [PATCH][5.10, 5.15, 6.1][0/1] hrtimer: Ignore slack time for RT tasks
Date: Mon, 19 Feb 2024 09:08:50 +0100
Message-Id: <20240219080851.27386-1-felix.moessbauer@siemens.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1321639:519-21489:flowmailer

This suggests a fix from 6.3 for stable that fixes a nasty bug in the
timing behavior of periodic RT tasks w.r.t timerslack_ns. While the
documentation clearly states that the slack time is ignored for RT tasks,
this is not the case for the hrtimer code. This patch fixes the issue and
applies to all stable kernels.

Best regards,
Felix Moessbauer
Siemens AG

Davidlohr Bueso (1):
  hrtimer: Ignore slack time for RT tasks in schedule_hrtimeout_range()

 kernel/time/hrtimer.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

-- 
2.39.2


