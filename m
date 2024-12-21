Return-Path: <stable+bounces-105542-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8E599FA2C6
	for <lists+stable@lfdr.de>; Sat, 21 Dec 2024 23:42:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DA851676E4
	for <lists+stable@lfdr.de>; Sat, 21 Dec 2024 22:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32A1D1D9A5F;
	Sat, 21 Dec 2024 22:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=svmhdvn.name header.i=@svmhdvn.name header.b="trl652hQ"
X-Original-To: stable@vger.kernel.org
Received: from diary.svmhdvn.name (diary.svmhdvn.name [174.136.98.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E397189BBB
	for <stable@vger.kernel.org>; Sat, 21 Dec 2024 22:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=174.136.98.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734820941; cv=none; b=L3seDsYdrRvfxJXD+oTSZseG8sWjgwRLw2NsPbym4RD0EegeKRjZyk1aZytFw9W30nh3Nd4yq5M7cm+RXcW1xKUMURebVT38zoPmFrM74OLAc3cu5/QCiF19EL7iaeCgig22gGuuFxRI/eyLzAE+hgPW4YPgtG0B6Gb8kNh4Fgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734820941; c=relaxed/simple;
	bh=yS+bnikUls+gxphI2NHeQo2aumEG3eqFwSybwO5fkrE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To; b=UxrRMFRPNlHQxTT147GiBM+orULuJW8cCTkazvl+xYHmDKZifho+Q5bYtgZH4GH08MrKgLv4tjsTK7J73w7DJEnmwVutMKOgYn0bpPx+jvJ5WYvhSM959pIe8hoxqHaD3pBs9oKQLk32BB9N7z423exdbgQDgCk94kWerj1UwQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=svmhdvn.name; spf=pass smtp.mailfrom=svmhdvn.name; dkim=pass (2048-bit key) header.d=svmhdvn.name header.i=@svmhdvn.name header.b=trl652hQ; arc=none smtp.client-ip=174.136.98.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=svmhdvn.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=svmhdvn.name
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svmhdvn.name;
	s=diary1; t=1734820548;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=h9vROm/ucFrO1Zn4KeEKv/82NzYWKSb+97vYad00O+U=;
	b=trl652hQOgNnOU5zQ6CZeRa2MYaQA3yT9JHZ+kaD5IU5bLnPZ/rD2U/ES0YvhKijfUQLdV
	UG9LahF9SPPDaX94egagfw0Rps/YtczC24pZCjpocYdf9cX0SjhqZ4CNPTVLvw0Fhc/+Lc
	5QQpA3PSiG+VY+oi2cvHY/QLDRVun0GEgfXQVafTQWQ6WqYXihLF1oLmQ9D5rqYQ/hifDT
	iJWGIaMxgzCeoNrTUOGOG1bb+vm2ykjhfpg2j2lt17d+lFaS1lhQix1OSLuhr94Yn4ZtuN
	CWs3JJ4fVV1i4e2kPREX2ZvASlvlac5fwfpeStNJzdc7e/fAh7R8cPJkkZm2RQ==
Received: 
	by diary.svmhdvn.name (OpenSMTPD) with ESMTPSA id 5ec79cca (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Sat, 21 Dec 2024 22:35:46 +0000 (UTC)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 21 Dec 2024 17:35:37 -0500
Message-Id: <D6HQK0PSRVBC.XEUGZC9N1O5K@svmhdvn.name>
Subject: [REGRESSION] amdgpu: thinkpad e495 backlight brightness resets
 after suspend
Cc: <regressions@lists.linux.dev>, <stable@vger.kernel.org>,
 <amd-gfx@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 <Xinhui.Pan@amd.com>, <christian.koenig@amd.com>
From: "Siva Mahadevan" <me@svmhdvn.name>
To: <alexander.deucher@amd.com>
X-Mailer: aerc 0.18.2

#regzbot introduced: 99a02eab8

Observed behaviour:
linux-stable v6.12.5 has a regression on my thinkpad e495 where
suspend/resume of the laptop results in my backlight brightness settings
to be reset to some very high value. After resume, I'm able to increase
brightness further until max brightness, but I'm not able to decrease it
anymore.

Behaviour prior to regression:
linux-stable v6.12.4 correctly maintains the same brightness setting on
the backlight that was set prior to suspend/resume.

Notes:
I bisected this issue between v6.12.4 and v6.12.5 to commit 99a02eab8
titled "drm/amdgpu: rework resume handling for display (v2)".

Hardware:
* lenovo thinkpad e495
* AMD Ryzen 5 3500U with Radeon Vega Mobile Gfx
* VGA compatible controller: Advanced Micro Devices, Inc. [AMD/ATI]
  Picasso/Raven 2 [Radeon Vega Series / Radeon Vega Mobile Series]
  (rev c2)

