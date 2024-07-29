Return-Path: <stable+bounces-62418-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E31CA93EFEE
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 10:32:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65B62B217A6
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 08:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7DB113C904;
	Mon, 29 Jul 2024 08:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="c9xan/wY"
X-Original-To: stable@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF4213C3C0;
	Mon, 29 Jul 2024 08:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722241911; cv=none; b=LM/msSngbqN0+qrqMzVLvHzgUMAolE1VOhgC1pr188a49TVKo8K5t0LHy4h0uFljpjubjlHmR0wRWYzEc7xnbYbJdhRouaH90yPxFwixWU1StelSw5QGxi+2x2KUi8eu4pLfwXZZS6k3uuip1g2DCsj3YXCp60EXz9bk8n3h/WQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722241911; c=relaxed/simple;
	bh=wgqII0t9SoZqDfvnh59PKPv/8nJS/un6vg66uWyrRlk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JvCFz/3CNJy0+HcSH8EoyKdDLs8BdOirrl7jIT5gD+qYRixDiqxUvaM7wE8SPc68zaXTh+JFCMBZm3k66wXHSPbpJ0cwK0bMNEDNCMmR9FIgNYcG2EK3unAq7tk95ItkuDS6awUQiDh7KHCuQsdHLoo2ZeebSaj4lujeAwXq0T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=c9xan/wY; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:Reply-To:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=BzIiocqu7ai5BzKHxI8W6PqIYtEJSWNtQSgp6jZijik=;
	t=1722241909; x=1722673909; b=c9xan/wYAuDv9IiCuzYjjAxyWrIIr6aIBA84Wh7D4Q9Vp+A
	MwEwv0TZiiL5EwImzp0oO81JVhxdefsW2DYK6b1jXwC4V10F1sxvg5UuAQvZrPQtdOfNtI1osr4fr
	J1s9Y69+vPgCBMJkvyV4QSeKG/cgpDi9V7TQzVvvNmJ65uoIp4gPAfgHqX8W+VxYKzFyqRXfVQO6W
	RH52tg0W9MfJFBB0GK8xdGNLO4ds/P6sxa8N6qHmKTtsr62903O3BY90NyqUGwwltNf21ut3R1wPT
	rUk0PN0tWdDJy8zVAbeUWw8p0tHUWJiQRZR3RnwnGtMdYM+S0SEjMhQ7VaiAjlvw==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1sYLn8-0004K5-QN; Mon, 29 Jul 2024 10:31:38 +0200
Message-ID: <a3af3f0b-df81-4407-a38d-2fa35b33b08c@leemhuis.info>
Date: Mon, 29 Jul 2024 10:31:38 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Re: [PATCH] drm/amd/display: fix corruption with high refresh rates
 on DCN 3.0
To: Greg KH <gregkh@linuxfoundation.org>
Cc: mikhail.v.gavrilov@gmail.com, Rodrigo Siqueira
 <Rodrigo.Siqueira@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 amd-gfx@lists.freedesktop.org,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 Linux kernel regressions list <regressions@lists.linux.dev>
References: <20240716173322.4061791-1-alexander.deucher@amd.com>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Content-Language: en-US, de-DE
In-Reply-To: <20240716173322.4061791-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1722241909;deb203e7;
X-HE-SMSGID: 1sYLn8-0004K5-QN

On 16.07.24 19:33, Alex Deucher wrote:
> This reverts commit bc87d666c05a13e6d4ae1ddce41fc43d2567b9a2 and the
> register changes from commit 6d4279cb99ac4f51d10409501d29969f687ac8dc.
> 
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3478
> Cc: mikhail.v.gavrilov@gmail.com
> Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> [...]

Hi Greg, quick note, as I don't see the quoted patch in your 6.10-queue
yet: you might want to pick up e3615bd198289f ("drm/amd/display: fix
corruption with high refresh rates on DCN 3.0") [v6.11-rc1, contains
table tag] rather sooner than later for 6.10.y, as the problem
apparently hit a few people and even made the news:
https://lore.kernel.org/all/20240723042420.GA1455@sol.localdomain/
https://www.reddit.com/r/archlinux/comments/1eaxjzo/linux_610_causes_screen_flicker_on_amd_gpus/

Ciao, Thorsten

