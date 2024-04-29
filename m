Return-Path: <stable+bounces-41592-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A50F28B4F3A
	for <lists+stable@lfdr.de>; Mon, 29 Apr 2024 03:35:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E01EF1C21285
	for <lists+stable@lfdr.de>; Mon, 29 Apr 2024 01:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43FB6633;
	Mon, 29 Apr 2024 01:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rosalinux.ru header.i=@rosalinux.ru header.b="ENP6l33c"
X-Original-To: stable@vger.kernel.org
Received: from mail.rosalinux.ru (mail.rosalinux.ru [195.19.76.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 676877F
	for <stable@vger.kernel.org>; Mon, 29 Apr 2024 01:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.19.76.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714354516; cv=none; b=Js7X3uVJOUyGw/0IRja+SSvU3OziB2YuHQp7tWkLFrSRH6qGF3jEiI247DQjArJOl1k+0fM8gUeT6icuUgbpS3TSEuREveLS6fehvkMAzfXL93nBnqyGcRYrfgb7CRvQf7EhXi8TWhfvXU3RbqaAWd7CUl0LRB/thGb6R351UbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714354516; c=relaxed/simple;
	bh=kFOkdfu53r4f0dVziI0m6v4aaLTyulv1fQbdhR8cLUM=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=OMLN+5GQK7UsRXhgQ/UgNB2COe3l0djr/2oJmdpSCluMX7opsroIYY0Fl6CzzvZbiN59s4wWtsXF1HyDhMqRybYENNNDVtgKAXsXAwVH1oWB1cIL4y7SNan3Kwp+vruPDcUTDgXQjM9tgRsY0RzSZN/S3lDbibSSimiETsMeNv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosalinux.ru; spf=pass smtp.mailfrom=rosalinux.ru; dkim=pass (2048-bit key) header.d=rosalinux.ru header.i=@rosalinux.ru header.b=ENP6l33c; arc=none smtp.client-ip=195.19.76.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosalinux.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rosalinux.ru
Received: from localhost (localhost [127.0.0.1])
	by mail.rosalinux.ru (Postfix) with ESMTP id 1A10CE1A02B73;
	Mon, 29 Apr 2024 04:35:05 +0300 (MSK)
Received: from mail.rosalinux.ru ([127.0.0.1])
	by localhost (mail.rosalinux.ru [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id SQvVafterWTo; Mon, 29 Apr 2024 04:35:04 +0300 (MSK)
Received: from localhost (localhost [127.0.0.1])
	by mail.rosalinux.ru (Postfix) with ESMTP id BF0B5E26340F2;
	Mon, 29 Apr 2024 04:35:04 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.rosalinux.ru BF0B5E26340F2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rosalinux.ru;
	s=1D4BB666-A0F1-11EB-A1A2-F53579C7F503; t=1714354504;
	bh=kFOkdfu53r4f0dVziI0m6v4aaLTyulv1fQbdhR8cLUM=;
	h=Message-ID:Date:MIME-Version:To:From;
	b=ENP6l33cBMCOSPSYVhbInDOGxv6PfBEyAzEucWe8PBoymgiv7U2PvCu95BYJWIsoE
	 OJheMaFNPZCI7AK/iB+hvqCmEROk/1hF7J21u1Wxj3+EttUex3Yw13LyDlv1Hppghz
	 BawNILMDOE17u+ZN95kOSGl1IayNaLgNlM8oHb7T7tw5XeMglQtKvn+4mmkZc4/Yhh
	 FwO1A7B24mxkXuZR2QiZKJ18+QDzAUgyrD+FNb+FZZk/MQymjiDjMYwh/gj1kH6NsD
	 wmg4BhWvdaGWMyirObm5SBzGod7ZP5XkL4HrzsJJaePfRIG0GgefNLnj1lG+WEfGic
	 pSGkxGqHn6XyA==
X-Virus-Scanned: amavisd-new at rosalinux.ru
Received: from mail.rosalinux.ru ([127.0.0.1])
	by localhost (mail.rosalinux.ru [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id q7fE3t-fWoVA; Mon, 29 Apr 2024 04:35:04 +0300 (MSK)
Received: from [192.168.1.100] (unknown [89.250.9.26])
	by mail.rosalinux.ru (Postfix) with ESMTPSA id 86943E1A02B73;
	Mon, 29 Apr 2024 04:35:04 +0300 (MSK)
Message-ID: <1e5355c9-7444-031d-59bc-52535f773755@rosalinux.ru>
Date: Mon, 29 Apr 2024 04:35:04 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Content-Language: en-US
To: regressions@lists.linux.dev, stable@vger.kernel.org
Cc: =?UTF-8?B?0JHQtdGC0YXQtdGAINCQ0LvQtdC60YHQsNC90LTRgA==?=
 <a.betkher@rosalinux.ru>, i.gaptrakhmanov@rosalinux.ru
From: Mikhail Novosyolov <m.novosyolov@rosalinux.ru>
Subject: [REGRESSION] Serious regression on 6.1.x-stable caused by "bounds:
 support non-power-of-two CONFIG_NR_CPUS"
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello, colleagues.

Commit f2d5dcb48f7ba9e3ff249d58fc1fa963d374e66a "bounds: support non-power-of-two CONFIG_NR_CPUS" (https://github.com/torvalds/linux/commit/f2d5dcb48f7ba9e3ff249d58fc1fa963d374e66a) was backported to 6.1.x-stable (https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=428ca0000f0abd5c99354c52a36becf2b815ca21), but causes a serious regression on quite a lot of hardware with AMD GPUs, kernel panics.

It was backported to 6.1.84, 6.1.84 has problems, 6.1.83 does not, the newest 6.1.88 still has this problem.

The problem is described here: https://gitlab.freedesktop.org/drm/amd/-/issues/3347

#regzbot introduced: 428ca0000f0abd5c99354c52a36becf2b815ca21


