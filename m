Return-Path: <stable+bounces-33872-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FDFD893786
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 05:00:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B794028171F
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 03:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44F667F;
	Mon,  1 Apr 2024 03:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quaintcat.com header.i=@quaintcat.com header.b="FAEL7gcu"
X-Original-To: stable@vger.kernel.org
Received: from mx3.quaintcat.com (mx3.quaintcat.com [51.222.159.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B38A48
	for <stable@vger.kernel.org>; Mon,  1 Apr 2024 03:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.222.159.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711940408; cv=none; b=UPTplhxEyAVo2fCQ8d9QOx2+4T0M5c+oJn0ZV5Z50HS5u537MFduUp7uDjUHxbhc5ljvG3J6RvqrQoF+kOn7wJCZaFsjqSB3Or/6YavkdSNU4YDXoAaEc4+a4sux2w7ieNDbXGFPJFv8GFkw6aN5GzAMnBlIzrkAZ/BPg9Gqtds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711940408; c=relaxed/simple;
	bh=UJxpacrwDaVWlcL6wdltxcCwbnV3A4usFHwLYbQpL4s=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=C/a4xl6oLvTeE4aYNhFilqcD4j43/9Tiq+1xwog94BzeoZAcI3XTH/caJukEtiFn41dNa6sJPUlJ/j2cocZ4fBLOypJAzyAzJH3ikLAks4/WbLAPJBvRRVQezRjbo3aY045eTvbpFIesgGOG6HxqL8SYh1Txx77Wo9yXxrocCTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=quaintcat.com; spf=pass smtp.mailfrom=quaintcat.com; dkim=pass (2048-bit key) header.d=quaintcat.com header.i=@quaintcat.com header.b=FAEL7gcu; arc=none smtp.client-ip=51.222.159.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=quaintcat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quaintcat.com
Date: Sun, 31 Mar 2024 22:00:04 -0500 (CDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx3.quaintcat.com 26A572004C31
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quaintcat.com;
	s=mx3v3; t=1711940405;
	bh=UJxpacrwDaVWlcL6wdltxcCwbnV3A4usFHwLYbQpL4s=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=FAEL7gcuUIGzbCqIKJZgHZtiVU1xjaS/CtJoIbDc/o2zA18R8qNebkIfUkmeWizvv
	 FoOM4eD3dFQCcNva6qnja7dJ0YgViVzZUXNutxEtF8JGhfgg+Z9XR3mYk6FzMBb5ly
	 gjayIoRlRW+RacsP2wY6akM6SRk5UARF9TcZtb6qbaD/KhJ9gAl6b74V4/1Wxhqsi8
	 Aifvo6o85clBz+D5Zh9eXM8G0tsonKg0EXP2u6rgfT2zKb5MuQXF98hVgPAfI8TqQQ
	 2Xxa5MM+5HwSc7gFhY9B/eHYfY6/0Zskt6z1nv3Ifjg9ZMoIip+G3MBHwbm8MHm2oC
	 kWohaRgWV0hsQ==
From: Andrei Gaponenko <beamflash@quaintcat.com>
To: Linux regressions mailing list <regressions@lists.linux.dev>
cc: Andrei Gaponenko <beamflash@quaintcat.com>, stable@vger.kernel.org
Subject: Re: [REGRESSION] external monitor+Dell dock in 6.8
In-Reply-To: <ce448389-bc61-4c71-85ca-e6c445e1a2bb@leemhuis.info>
Message-ID: <2061d773-879b-2a5-809f-7918c5b85ca4@quaintcat.com>
References: <22aa3878-62c7-9a2c-cfcc-303f373871f6@quaintcat.com> <e9e23151-66b4-4d4f-bf55-4b598515467c@leemhuis.info> <7543f75e-6a96-8114-cef9-779594a36460@quaintcat.com> <ce448389-bc61-4c71-85ca-e6c445e1a2bb@leemhuis.info>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

Hi Thorsten,

On Sun, 31 Mar 2024, Linux regression tracking (Thorsten Leemhuis) wrote:

> I see that it contains a warning from nouveau that might be hinting at
> the problem. Then I'd say: go and file a ticket here:
> https://gitlab.freedesktop.org/drm/nouveau/-/issues

Working kernel versions issue a similar warning; I am not sure it it related to the regression.
Perhaps I should file a report for it, but I want to deal with one issue at a time.

git bisect pointed to a range of drm/i915 commits, so I filed an updated regression report at
https://gitlab.freedesktop.org/drm/intel/-/issues/10637

Best regards,
Andrei

