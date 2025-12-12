Return-Path: <stable+bounces-200905-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 729C1CB8E1E
	for <lists+stable@lfdr.de>; Fri, 12 Dec 2025 14:19:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F06473009099
	for <lists+stable@lfdr.de>; Fri, 12 Dec 2025 13:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3392E1F3BA2;
	Fri, 12 Dec 2025 13:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="P2f+BXYg"
X-Original-To: stable@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1325F1AA7A6;
	Fri, 12 Dec 2025 13:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765545578; cv=none; b=jkbGqYZxNFT6VNZSw+zGu0AcTORFux2r6BBVviwD7aaeIkwmorfTz2WK1BymyOQHaz4TpUBccln6361BolMA2C9jMdUztGvgsAfZQ8pRjTbDGFLRKWrs0KhdFV145lVbL105vTb/28+/c2aQHQ8v9Ar+qY2I4wp2t4Jol/Hw3QI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765545578; c=relaxed/simple;
	bh=nDbmUHc2dj5euBkEod+E3WGAYdQOIp/oaUdJcJPX9SI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=lVkIBAQgglJMqiUtUBlEysUSmeCwfyhibXf/bjYUQuahDIxGLVrCQM7bhG+wYzr6fO3rTMt1ZBRDs2UrCzWKTgUhmPhV181Z2i8oSPiJaJoSb8aUpx62EJLdtRP/oAU3HB+ElPyFzVa5kh9T8v/xZ9i1NQ2tFQMriMn0wcZg/U8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=P2f+BXYg; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:To:Subject:MIME-Version:Date:Message-ID:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=nDbmUHc2dj5euBkEod+E3WGAYdQOIp/oaUdJcJPX9SI=; t=1765545576;
	x=1765977576; b=P2f+BXYgMrw/xkrpwLjREPCWSM6Xk88gYQM6hjzMpD9j5nwGfYxpskWbUEAD4
	BSO6C0N2ILtD2WcEeqJiBKDG+lqfxiKcfKdC5U67fxpGmM/lBGXIb3tg2AnBRotl3NpnByYnK6kiu
	wco6VEGpRpTZEXDKxKRBpkTYBi8UAh1yFTl4EOyzTjKDdO42gRW9hIorhnQzByHKEtRGywj5iGnij
	B9hpTV9SNZHMdc59FI2rpZkcXuR/fAakvuKYuEubVks/72JOE7emaWNl4PY26Ydto1bOMj5VB+mez
	vjrfY+vFjOZ7zk70VuzHCwxULTJV/PUcVZoNts5haWET0S/YlQ==;
Received: from [2a02:8108:8984:1d00:a0cf:1912:4be:477f]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128)
	id 1vU33O-00HLxA-2q;
	Fri, 12 Dec 2025 14:19:27 +0100
Message-ID: <ee6e0b89-c3d0-4579-9c26-a9a980775e55@leemhuis.info>
Date: Fri, 12 Dec 2025 14:19:26 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [6.12.61 lts] [amdgpu]: regression: broken multi-monitor USB4
 dock on Ryzen 7840U
To: =?UTF-8?Q?P=C3=A9ter_Bohner?= <peter.bohner@student.kit.edu>,
 Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
 amd-gfx@lists.freedesktop.org, stable@vger.kernel.org,
 regressions@lists.linux.dev, bugs@lists.linux.dev, Jerry.Zuo@amd.com,
 aurabindo.pillai@amd.com, ivan.lipski@amd.com, daniel.wheeler@amd.com,
 alexander.deucher@amd.com, gregkh@linuxfoundation.org,
 Mario Limonciello <mario.limonciello@amd.com>
References: <9444c2d3-2aaf-4982-9f75-23dc814c3885@student.kit.edu>
 <ea735f1a-04c3-42dc-9e4c-4dc26659834f@oracle.com>
 <b1b8fc3b-6e80-403b-a1a0-726cc935fd2e@student.kit.edu>
 <bfb82a48-ebe3-4dc0-97e2-7cbf9d1e84ed@oracle.com>
 <7817ae7c-72d3-470d-b043-51bcfbee31b1@student.kit.edu>
 <d5664e24-71a1-4d46-96ad-979b15f97df9@student.kit.edu>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
In-Reply-To: <d5664e24-71a1-4d46-96ad-979b15f97df9@student.kit.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1765545576;d9fe55e7;
X-HE-SMSGID: 1vU33O-00HLxA-2q

On 12/9/25 16:50, Péter Bohner wrote:
> note: reverting ded77c1209169bd40996caf5c5dfe1a228a587ab fixes the issue
> on the latest 6.12.y (6.12.61) tag.

That is 1788ef30725da5 ("drm/amd/display: Fix pbn to kbps Conversion")
[v6.18-rc7, v6.17.10, v6.12.60 (ded77c1209169b)] – and Mario (now among
the recipients) submitted a patch to revert in in mainline:

[PATCH] Revert "drm/amd/display: Fix pbn to kbps Conversion"
https://lore.kernel.org/all/20251209171810.2514240-1-mario.limonciello@amd.com/

But it has "Cc: stable@vger.kernel.org # 6.17+", so that revert won't
make it to 6.12.y; I wonder if that is just an accident or if there is
some good reason for that.

Ciao, Thorsten

