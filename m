Return-Path: <stable+bounces-142051-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B74BDAAE05A
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 15:14:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C776161DFA
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 13:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1E392165EA;
	Wed,  7 May 2025 13:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="A3TMBgoC"
X-Original-To: stable@vger.kernel.org
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B37E0288C03
	for <stable@vger.kernel.org>; Wed,  7 May 2025 13:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746623457; cv=none; b=n9Rgn6ZtoRq4FOnfkZjH31XMLNorCghlOR96v2Z279TZGEIGoBdGTXlxdYeZ4BDg0nwgzPG5QUUflkgratFvk/yhn6ZsBHCamSjI8n7YwgZEZ+gQM0JZIdfnulC5Ny4a3y1gkMqqNpewO4Ph9XA2nmNwo3bF045iQJ5kHZdenu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746623457; c=relaxed/simple;
	bh=WfOna0qgipSseGCor8cmqiZDQkKFDIjCxDAj9rUOqxo=;
	h=MIME-Version:Date:From:To:Cc:Subject:Message-ID:Content-Type; b=DITn4gEp1PTerBSrRjqXxLmDUWRmhG4dOEulkcklhwNoy7IQoH3BrISRnB0hjtID6OheTsaS18aYQ+D1LvHHtvhIZKv1+w9PVxrOAtrdDIetlAMu8mhmV6GbNoe8GFRDsBNCySqJ3tTT63d8FS5DUqsU5/DUJ5tBuxA5EFmaVPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=A3TMBgoC; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id C412525BEF;
	Wed,  7 May 2025 15:10:53 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id k_f4BkDSiUgk; Wed,  7 May 2025 15:10:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1746623453; bh=WfOna0qgipSseGCor8cmqiZDQkKFDIjCxDAj9rUOqxo=;
	h=Date:From:To:Cc:Subject;
	b=A3TMBgoCVyygCkWMdgP9DTqPuj45j7FovrgekqUkC8DBsuFcbE1QVG+k0aXPZBdmg
	 kFaR/2Aa9+N3B4dH6sAxmGukQRn66bTh2iZsG3/qOJiIPLWyuVR5VKWX6MtAU0u5Ct
	 DmtXwj2ZO6TWIOLJzsVDM+w2zTPNTWPpN37MXZYnigiXTdLxTswHMuC/NPCfJgfTs2
	 gcFcqYVDBbGN7adqsYrPZdC7r1tE7bQx9ia+zHFIn249ytoxmNMFv0ZAj1sCLmGnTs
	 YGbPVmigk4gJKQx+s+z125YMLG9N37f4uC/uX9EPlIX8tvD7XLCoPXyTVSFaOiFkbt
	 bEYq5ur37jUbQ==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 07 May 2025 15:10:53 +0200
From: machion@disroot.org
To: stable@vger.kernel.org
Cc: regressions@lists.linux.dev, amd-gfx@lists.freedesktop.org,
 alexander.deucher@amd.com, christian.koenig@amd.com
Subject: Unplayable framerates in game but specific kernel versions work,
 maybe amdgpu problem
Message-ID: <c415d9e0b08bcba068b01700225bf560@disroot.org>
X-Sender: machion@disroot.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit

Hello kernel/driver developers,

I hope, with my information it's possible to find a bug/problem in the 
kernel. Otherwise I am sorry, that I disturbed you.
I only use LTS kernels, but I can narrow it down to a hand full of them, 
where it works.

The PC: Manjaro Stable/Cinnamon/X11/AMD Ryzen 5 2600/Radeon HD 7790/8GB 
RAM
I already asked the Manjaro community, but with no luck.

The game: Hellpoint (GOG Linux latest version, Unity3D-Engine v2021), 
uses vulkan

---

I came a long road of kernels. I had many versions of 5.4, 5.10, 5.15, 
6.1 and 6.6 and and the game was always unplayable, because the frames 
where around 1fps (performance of PC is not the problem).
I asked the mesa and cinnamon team for help in the past, but also with 
no luck.
It never worked, till on 2025-03-29 when I installed 6.12.19 for the 
first time and it worked!

But it only worked with 6.12.19, 6.12.20 and 6.12.21
When I updated to 6.12.25, it was back to unplayable.

For testing I installed 6.14.4 with the same result. It doesn't work.

I also compared file /proc/config.gz of both kernels (6.12.21 <> 
6.14.4), but can't seem to see drastic changes to the graphical part.

I presume it has something to do with amdgpu.

If you need more information, I would be happy to help.

Kind regards,
Marion

