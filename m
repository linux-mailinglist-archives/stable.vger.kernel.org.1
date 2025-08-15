Return-Path: <stable+bounces-169800-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 019B3B2856C
	for <lists+stable@lfdr.de>; Fri, 15 Aug 2025 19:56:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD351607170
	for <lists+stable@lfdr.de>; Fri, 15 Aug 2025 17:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3CEA3A8F7;
	Fri, 15 Aug 2025 17:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=polynomial-c@gmx.de header.b="TRYA26bA"
X-Original-To: stable@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C645D3176F2
	for <stable@vger.kernel.org>; Fri, 15 Aug 2025 17:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755280585; cv=none; b=Ol45wOJs+GYnRVKjITfJoqCm87wE/k6hh6f5AzP+FaIVAeOsEfRnLSdAm4WGRtzWhtq6Jq1nU2NdPmwG96Q7YTpIWfzRK3B4MXGEEYgm0j/OqAVgfq5xaI9qXr8hdiYX6yj/Ws5L3v5gvySUwLfKNes7ByHL1JOZ+vygJP/xezM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755280585; c=relaxed/simple;
	bh=ppgj6SYAZ6kJauMlEle42VDTb6lpqRktIc53niSLqCM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=HRfJ4w1izFECAdxgVTo8LIroJ1A2yMNHaEr4UfmbbZFxrth7A1MrJPSHpFGWcsN0q1guGaQlgvpGpL3Ak7lPEGwViYBn5al9LJETE3oZUGokudSoqiR+4mbB6ExFYvXxyVO0y4F/bZdLfBlSw69NKZmU8vdYcO+OtohiYmStKk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=polynomial-c@gmx.de header.b=TRYA26bA; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1755280577; x=1755885377; i=polynomial-c@gmx.de;
	bh=ppgj6SYAZ6kJauMlEle42VDTb6lpqRktIc53niSLqCM=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=TRYA26bAbw/5MscGOsDwdl/DokAmUVIO7blSrdWNRZXBm+qoLnocSwOvttPITGkC
	 LP7sMAW2lh0kU0YmU6iXqQyCShRFT/b2EqzRamFw2zvlw7UjboATGtjzg7qfRsj3z
	 VQGn3ULkuKAZMdIiEd6piQzH+OCNnfW1LDeB2iXYbTTZk2aZ7P4wVx22JmWH4Frw5
	 ydVauVZ8AUUt+nC9lRRSQXTyBuTke2JfUaksZWH2ToQYXZ21pyyBvyNKrI/wiL3tI
	 iucPIF2FCiUZv89FB/eXCEflSlCEAjswLjZ40sVD7L2+zx9cT+1YMuzxJqXk5/Pdg
	 ieTrt1/iIBQrfsE16w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from chagall.paradoxon.rec ([84.169.218.59]) by mail.gmx.net
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MD9X9-1uvT7Z3qgz-00Ailp; Fri, 15 Aug 2025 19:56:16 +0200
Date: Fri, 15 Aug 2025 19:56:16 +0200
From: Lars Wendler <polynomial-c@gmx.de>
To: wangzijie <wangzijie1@honor.com>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>, Linux kernel
 regressions list <regressions@lists.linux.dev>
Subject: [REGRESSION] [BISECTED] linux-6.6.y and linux-6.12.y: proc: use the
 same treatment to check proc_lseek as ones for proc_read_iter et.al
Message-ID: <20250815195616.64497967@chagall.paradoxon.rec>
Organization: privat
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:n5mb3sqFO8w5osK6MYqjPys10/5Mscdb8Vj4WXFhCNFJ2WOUugy
 +Ytbufa+qv08+70tfZA1Zti7KTfXdF3Q1fjLLaqc4XPd3djzJDhW7ieseiW/uHP7ArFkMx8
 SYylRU/cDxIiUNeRsxvccJ34qvA69Nnq5djLWa9Mc8ApU2jEI8FgHR0Pci8fWzjpOMFqfVz
 tQyLc2xtfJY7kiqFtLHDA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:TYdx7euePyo=;s8q0WBCERIPJ1MNEvut7466SN0s
 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

Hi,

the stable LTS linux kernels 6.6.102 and 6.12.42 have a regression
regarding network interface monitoring with xosview and gkrellm. Both
programs no longer show any network traffic with gkrellm even
considering all network interfaces as being in down state. I haven't
checked other LTS kernels so I cannot tell if there are more affected
kernel branches.

I have bisected the issue to the commits
33c778ea0bd0fa62ff590497e72562ff90f82b13 in 6.6.102 and
fc1072d934f687e1221d685cf1a49a5068318f34 in 6.12.42 which are both the
same change code-wise (upstream commit
ff7ec8dc1b646296f8d94c39339e8d3833d16c05).

Reverting these commits makes xosview and gkrellm "work" again as in
they both show network traffic again.

Kind regards
Lars Wendler

