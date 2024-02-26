Return-Path: <stable+bounces-23768-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53DE386835E
	for <lists+stable@lfdr.de>; Mon, 26 Feb 2024 22:56:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D63528D5C9
	for <lists+stable@lfdr.de>; Mon, 26 Feb 2024 21:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09030131E20;
	Mon, 26 Feb 2024 21:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bNM3+XKb"
X-Original-To: stable@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6FD412F388
	for <stable@vger.kernel.org>; Mon, 26 Feb 2024 21:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708984586; cv=none; b=SvDjIDD9ZpXTFvfwUJt68aFjgVjm18iPuEOMCRcDGZLdcQwpMtRQOp1j8O4KUwUC+rTSbjlrAw66RV+uKGbQC80ghruhdCcSJmck+jOl02/CqldpA7Iz4ND6f3bfeGkuSW/uRrS4Groz7An6t2W6x47zv/9TVQmvrmQQcGOPulw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708984586; c=relaxed/simple;
	bh=n/PTpmi++/PLw5fVEnM26FoOgDpAaRMeCmhTjGFprew=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=phIrNPLS/0kqf6be1+QUyBquTyznTYwoblm0hPGCA4yzWG89ApYaRoGIyZr2cPmiOXSwBEGvDTTAaWZwV08QEnHE05CswaI+MPca2KCyBvaPqwy4Pvft7BSQgXK8/iCL+RkVqfUT0jA5BIPMMDmCBwSYGddPL22enzeC+5XqR8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bNM3+XKb; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708984581;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=O4gh7/OBZXPFWLvIy3UhlywDXnbnHJ+Ceeq6X1C/hjU=;
	b=bNM3+XKb1JObnBc2bdqCgLXrqR2/HJv+W7qfJJ2pzPjlVohNuve/EnfHRRGFbtX42SUBmx
	LSBIBYtexpUgo440aIwoOwI03BHZb6rNLsewo1AzKG+kXDJ5J7MdCq93HuXUIWUtj1STC8
	gkMv3f4oIflfStTFB2/J/KlrrK2SNIA=
From: Oliver Upton <oliver.upton@linux.dev>
To: stable@vger.kernel.org
Cc: maz@kernel.org,
	gregkh@linuxfoundation.org,
	Oliver Upton <oliver.upton@linux.dev>
Subject: [PATCH 5.4.y 0/2] KVM: arm64: VGIC ITS fix backports
Date: Mon, 26 Feb 2024 21:56:10 +0000
Message-ID: <20240226215612.1387774-1-oliver.upton@linux.dev>
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


base-commit: 6e1f54a4985b63bc1b55a09e5e75a974c5d6719b
-- 
2.44.0.rc1.240.g4c46232300-goog


