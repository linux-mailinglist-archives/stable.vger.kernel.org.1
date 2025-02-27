Return-Path: <stable+bounces-119870-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99343A48BE6
	for <lists+stable@lfdr.de>; Thu, 27 Feb 2025 23:44:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D406E1883006
	for <lists+stable@lfdr.de>; Thu, 27 Feb 2025 22:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28745229B07;
	Thu, 27 Feb 2025 22:44:19 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mailout03.t-online.de (mailout03.t-online.de [194.25.134.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F47927781A
	for <stable@vger.kernel.org>; Thu, 27 Feb 2025 22:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.25.134.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740696259; cv=none; b=u79Vj4uNLuJVGIwCJd6co84QJ67o0+gJMV99FaKTqe0Mk2/prLUNrgV9nYWhWx9/4bh95RRfppLfg2Uxj2KcRk50m1Pt3pMD6qqthq0sMjKkf0nGZeUSJqeCxF4xun6jz+nJUh2RDd9gjvUxZCoDNOEzR4ZvB2SWAIdNqfxFhNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740696259; c=relaxed/simple;
	bh=KoAelO3UQhx4BiU0JlCnoBne078B35Gbito6xzKiVTs=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=bfm5pcgbKTp2haQmFG3NIxEn0NyHCe7HiskJmgxi+tVHW9sqdJ9nmjmz2ZN8Gx1UBRMkAV+maYqbFaPT3kgdLrkSrM92CmlViTIcdqPs1cHVsOxOjaNvefz09BrKg1N1zU+dcJd8GicBlA3yZBfJuPb0c0qT7i3Sr/nLYywxbbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=t-online.de; spf=pass smtp.mailfrom=t-online.de; arc=none smtp.client-ip=194.25.134.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=t-online.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=t-online.de
Received: from fwd79.aul.t-online.de (fwd79.aul.t-online.de [10.223.144.105])
	by mailout03.t-online.de (Postfix) with SMTP id 06BE915FA
	for <stable@vger.kernel.org>; Thu, 27 Feb 2025 23:35:37 +0100 (CET)
Received: from df1tl.local.here ([93.220.88.198]) by fwd79.t-online.de
	with (TLSv1.3:TLS_AES_256_GCM_SHA384 encrypted)
	esmtp id 1tnmTd-24T8eP0; Thu, 27 Feb 2025 23:35:33 +0100
Received: from [192.168.168.33] (df1tl.local.here [192.168.168.33])
	by df1tl.local.here (Postfix) with ESMTP id 6540354A3AC
	for <stable@vger.kernel.org>; Thu, 27 Feb 2025 23:35:33 +0100 (CET)
Message-ID: <abfeb45a-2af0-4754-9fff-35d96c1182c1@t-online.de>
Date: Thu, 27 Feb 2025 23:35:33 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: kladit@t-online.de
Content-Language: de-DE
To: stable@vger.kernel.org
From: Klaus Dittrich <kladit@t-online.de>
Subject: Unknown bug in linux-6.13.x running qemu
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TOI-EXPURGATEID: 150726::1740695733-91FF897D-4B73868E/0/0 CLEAN NORMAL
X-TOI-MSGID: fbb6f419-06de-4ba6-9627-be54144027c5

I discovered a bug that appears in any 6.13 kernel within quemu
but not in any 6.12 kernel.

I use quemu-9.2.2 to run windows10 in it and there I use a program
called sprint-layout-6.0.

This program saves and loads his files via samba,
so I have them on my linux-ext4 disk and not in the
disk-file quemu uses.

It worked for years now and it still works with all 6.12.x
kernels up to now.

But it does not work with any 6.13.x kernel up to date.

The bug shows up when I try to load a file from within this program,
then the emulated windows10 pops up a window with "exeption 8000004".

I do not know what this is trying to tell me, but under any 6.12.x
and older kernels this did not happen.

So I assume a bug in 6.13.x kernel is the cause.

I also reported this to qemu but got now answer up to now.

Any help is welcome, thanks.

-- 
Best regards
Klaus


