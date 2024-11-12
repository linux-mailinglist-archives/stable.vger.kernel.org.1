Return-Path: <stable+bounces-92852-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F1859C6525
	for <lists+stable@lfdr.de>; Wed, 13 Nov 2024 00:27:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE5E9B29577
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 22:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7061221B42F;
	Tue, 12 Nov 2024 22:48:31 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from air.basealt.ru (air.basealt.ru [193.43.8.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8439421A4D2
	for <stable@vger.kernel.org>; Tue, 12 Nov 2024 22:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.43.8.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731451711; cv=none; b=cU/OUONno0IJruacJmkoF9ZViDMOAUh22DFWTAaPjstP6+G1V/93qzBBB/fooc3mIi7OYh1lRIrmouOQeRa/OObEfZTMw3MfDlJPbR6xjxEegsbiSVeLE42YwwUTmrsdXJ+ZmYdvQ60HItv4BKdP7zfN2Ai3VSrWNbrDPOd0dss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731451711; c=relaxed/simple;
	bh=y+C9ed4i7ryqtTmqjHhkwB4gyxiatnfjX879qWc3C04=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UmOThpVEFRfGdPwhOzjeVnSjPDWDAHqy4btTx8upVKc0o4bk84bPXO7o7Y9C+rVGwE6K05295wICqEs3uE24d9yt+5NOAl+XNWhkbYRQbXC9e4wc7uM+seDP9PweDSii/jGfJIc92YC7/F/QWAZRZ0ObmXILVbZAk7k7WGQuwvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=193.43.8.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: from altlinux.ipa.basealt.ru (unknown [178.76.204.78])
	by air.basealt.ru (Postfix) with ESMTPSA id E2C692339E;
	Wed, 13 Nov 2024 01:42:26 +0300 (MSK)
From: Vasiliy Kovalev <kovalev@altlinux.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org
Cc: lvc-patches@linuxtesting.org,
	nickel@altlinux.org,
	dutyrok@altlinux.org,
	gerben@altlinux.org,
	kovalev@altlinux.org
Subject: [PATCH 5.10/5.15/6.1 0/5] x86/mm: backport fixes for CVE-2023-0597 and CVE-2023-3640
Date: Wed, 13 Nov 2024 01:41:56 +0300
Message-Id: <20241112224201.289285-1-kovalev@altlinux.org>
X-Mailer: git-send-email 2.33.8
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series addresses two security vulnerabilities (CVE-2023-0597 [1],
CVE-2023-3640 [2]) in the x86 memory management subsystem, alongside
prerequisite [3] patches necessary for stable integration.

[PATCH 5.10/5.15/6.1 1/5] x86/kasan: Map shadow for percpu pages on demand
Ensures KASAN shadow mapping on demand for per-CPU pages.

[PATCH 5.10/5.15/6.1 2/5] x86/mm: Recompute physical address for every page of per-CPU CEA mapping
Calculates accurate physical addresses across CPU entry areas.

[PATCH 5.10/5.15/6.1 3/5] x86/mm: Populate KASAN shadow for entire per-CPU range of CPU entry area
Populates KASAN shadow memory for debugging across CPU entry areas.

[PATCH 5.10/5.15/6.1 4/5] x86/mm: Randomize per-cpu entry area
Randomizes the per-CPU entry area to reduce the risk of information leakage
due to predictable memory layouts, especially in systems without KASLR, as
described in CVE-2023-0597 [1].

[PATCH 5.10/5.15/6.1 5/5] x86/mm: Do not shuffle CPU entry areas without KASLR
Prevents CPU entry area shuffling when KASLR is disabled, mitigating information
leakage risks, as stated in CVE-2023-3640 [2].

[1] https://nvd.nist.gov/vuln/detail/CVE-2023-0597
[2] https://nvd.nist.gov/vuln/detail/CVE-2023-3640
[3] https://patchwork.ozlabs.org/project/ubuntu-kernel/cover/20230903234603.859937-1-cengiz.can@canonical.com/#3176047


