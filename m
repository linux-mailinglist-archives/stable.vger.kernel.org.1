Return-Path: <stable+bounces-23761-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0272486833F
	for <lists+stable@lfdr.de>; Mon, 26 Feb 2024 22:38:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 838D51F2D987
	for <lists+stable@lfdr.de>; Mon, 26 Feb 2024 21:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78279131733;
	Mon, 26 Feb 2024 21:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dQpr8a0i"
X-Original-To: stable@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 195BD12F593
	for <stable@vger.kernel.org>; Mon, 26 Feb 2024 21:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708983521; cv=none; b=XM8udLmnabe8k6iaCSiwGE6n9eH2e9NDZQxdbJg5mUfd6Zb5ZdfyUxYyrivhnjWanY9Rr/Yu62370JYUez+KOMvp91CAh0kUb53932wufzNkICvssc0g+e3JujHZpxYct/Facd8GCyGUV/eJMzBPJHwFktcPIdEmTHzOXBu0TZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708983521; c=relaxed/simple;
	bh=VAZ8cuSBwzgnZrBMF09jQVz93n3eifr8LMKcpfCkYGk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d/KbIMF8QuRvFVAu2QzL4pLmsUlH+OhgpDxS+ObVY4RqTyPbPbvG3jMVk6HjyD8eZC13bKJQpsHM2u1YVkGhntu8zOiMiAMc2r9n7grhHqk5TSUe3/ktr4q/PFwYU6MhURrAdP1RP7FNldYx+QCrvPUwCB26S1hNC3PonVMlqMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dQpr8a0i; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708983517;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Vi4fxMLD4AI5JJ4SplJ8dz3PvfjkeOPxWhJ1PINrkRQ=;
	b=dQpr8a0i2D4Gujth1LKXhwiSHlVs0RX8LjG4Mi2j7BjQZJJFbBSQsTZKNzRanTZO1JuQyH
	Wc9ZA2MPNm4/N50+D0tyJ8xLDYuJWEuQl4SRdLqjFEEls8AhQpgTdLgc/rbbTFm10oQ71G
	iH+fAo7pkyijipkXy0k3xqXKS710heU=
From: Oliver Upton <oliver.upton@linux.dev>
To: stable@vger.kernel.org
Cc: maz@kernel.org,
	gregkh@linuxfoundation.org,
	Oliver Upton <oliver.upton@linux.dev>
Subject: [PATCH 4.19.y 0/2] KVM: arm64: VGIC ITS fix backports
Date: Mon, 26 Feb 2024 21:38:20 +0000
Message-ID: <20240226213822.1228736-1-oliver.upton@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Oliver Upton (2):
  KVM: arm64: vgic-its: Test for valid IRQ in
    its_sync_lpi_pending_table()
  KVM: arm64: vgic-its: Test for valid IRQ in MOVALL handler

 virt/kvm/arm/vgic/vgic-its.c | 5 +++++
 1 file changed, 5 insertions(+)


base-commit: ab219d38aef198d26083cc800954d352acd5137b
-- 
2.44.0.rc1.240.g4c46232300-goog


