Return-Path: <stable+bounces-81204-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 286AA9921AB
	for <lists+stable@lfdr.de>; Sun,  6 Oct 2024 23:31:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03D081C20AA5
	for <lists+stable@lfdr.de>; Sun,  6 Oct 2024 21:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A91A171E76;
	Sun,  6 Oct 2024 21:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="MI/SefkJ"
X-Original-To: stable@vger.kernel.org
Received: from master.debian.org (master.debian.org [82.195.75.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E263618A940
	for <stable@vger.kernel.org>; Sun,  6 Oct 2024 21:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728250251; cv=none; b=Ja7tEw7rR7jCJNVd4Wq1BR76AUk2+lMliQaOgqeuQ38sOWg8njAFW1Dm70T4LeRA8H2+0qn8IKR3N2vn3p6Exs1Ak5kYcHiPOCn7trwvoYukEO3zYX0JyZvtvleLlmpfmnkcyXK2rtF2aiUnhjqsVsIaB6Rn6DyPsuluJ5eOnro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728250251; c=relaxed/simple;
	bh=+6g1fszOSIb91jRV347tncP9GHmGVEQUisEmopc7tRE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jqUrPvVFjfP/oiCQuiGJP6eljYSj7twk39g9RDO2T3C0obPF77pxAc6wL2aX9wtg3Lav8SXR1dUKNz1uMDG4ZUvDvYZGAr5jOPZI4NuNFpfQYzduWqW/r0Xw16sCp1LTOuHfF2qZDKPggzSRsyQWxcGCReVGyHwmr4lGRYEEExc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=master.debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=MI/SefkJ; arc=none smtp.client-ip=82.195.75.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=master.debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.master; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:
	Subject:Cc:To:From:Reply-To:Content-Type:Content-ID:Content-Description:
	In-Reply-To:References; bh=+6g1fszOSIb91jRV347tncP9GHmGVEQUisEmopc7tRE=; b=MI
	/SefkJUzmT6+SWIFGRpW/uLty5yFRtT7C29t6hzIfYQdYJWI1icf29eSXITVp0eBbvBzg1Foqf3q1
	fJ93Sz6mCgq0cyCuNj1NZvNBcObByzHwunwwEgmxYB16WXCwq9juazW/OIBMRASRG0UmtPn27UyCS
	KCybpP6AUVl38rnfmBGVdgTReVEHmQs6WGtEj0GHEZTdgWDonLM3pzvUcrpHD5uJQK4UMzLnooO6J
	19ieSagGga+yoYXVeeBPOHDCVC6Javt2ur9SLhxV0aNeDWGsnLFEEm0uo9mSAvyRzU78dxNFYKK3C
	6md3oIqrnUFnPJnG/HeLKKOyeOugMPIQ==;
Received: from ukleinek by master.debian.org with local (Exim 4.94.2)
	(envelope-from <ukleinek@master.debian.org>)
	id 1sxYDt-003U6L-Hj; Sun, 06 Oct 2024 20:51:25 +0000
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@debian.org>
To: stable@vger.kernel.org
Cc: xiao sheng wen <atzlinux@sina.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: Backports for 8b4865cd9046 ("cpufreq: intel_pstate: Make hwp_notify_lock a raw spinlock")
Date: Sun,  6 Oct 2024 22:51:05 +0200
Message-ID: <20241006205106.385009-4-ukleinek@debian.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=327; i=ukleinek@debian.org; h=from:subject; bh=+6g1fszOSIb91jRV347tncP9GHmGVEQUisEmopc7tRE=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBnAvg60O1x0vhJ/GwEjZQGlmOwwTBxV8btB680x DlgHXoAhU6JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZwL4OgAKCRCPgPtYfRL+ Ton8B/95Zqk0vGPmuKU4QiofxrvwVpU+rruyqVysR0gxsKYx1wln1HYeAXRreIjdh5jeWV9pTtC yR/kfFgV11rq/WW9qCnc5pgixW5wRwhaDS7agYLLffg3efaQ5IMYIgAbnzeIi8CB0LDpo534gPL yJvdso89/pY8rNjRGGm3DPlZ5sgoxPCbYl2q+2vUG/sLk7VfMOfT5mhy0dFtJtbMcvPbWtMB9Yn u0VA2PC75mRg0KphzGHPt2Bx4hMSE5Scyt8zKoS06kyR9ltTF2SJzk5fI5QvMYnKj0KKtCgMq6B 5WGihtjH21rQJKqIXu01aaI2YKGE+PVZ32sZ/UrQXdAu3IrJ
X-Developer-Key: i=ukleinek@debian.org; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Hello,

commit 8b4865cd904650cbed7f2407e653934c621b8127 is marked for backport
to stable. The patch does apply cleanly to 6.11.y, but not to earlier
versions. In reply to this mail I send a backport for 6.10.y and 6.6.y.
The 6.6.y patch also applies to 6.1.y. I didn't test earlier stable
branches.

Best regards
Uwe

