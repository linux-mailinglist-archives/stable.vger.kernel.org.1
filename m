Return-Path: <stable+bounces-43634-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05A6D8C41BE
	for <lists+stable@lfdr.de>; Mon, 13 May 2024 15:22:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 375961C22EEF
	for <lists+stable@lfdr.de>; Mon, 13 May 2024 13:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82A55152171;
	Mon, 13 May 2024 13:22:35 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B94071514E5
	for <stable@vger.kernel.org>; Mon, 13 May 2024 13:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715606555; cv=none; b=cncFaCKinmIP4orElmFUWr3WKKU81B+om/moaCJyzkdFCZd1wbnT6SJGxX4a6PxyuLO9AS4xDMMLhyrgip3iyUPm2WovrCB5Q9deuSIggC8ey3L0Ie+a/T/lvm0LsDdCa6oV8YXur34aEghVK9ITnO5HgPK3Kb2+JR6mNkGIsJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715606555; c=relaxed/simple;
	bh=kQF9wBbFME7j1QPFOoShAhDexN2agZ8oPWJ5/heEkhc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=asJjXQeXzeLB+Z0wer9i88O9B4aVdoHcEdDhrS4OpgLfGRe0uGRlzpYqcp5y8daLQW6PqEzNyDdIHJottk39DymGjiM3ZpaX4tG55rFtRSiFv6KEUPwZ6a+7gURrppIGc7yS+PipnhZ4G6cIyP8xWB/qKYhhZp0tRk3k9srGubc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VdKsV11dhz4wcp;
	Mon, 13 May 2024 23:22:22 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, Hari Bathini <hbathini@linux.ibm.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Christophe Leroy <christophe.leroy@csgroup.eu>, stable@vger.kernel.org, Christian Zigotzky <chzigotzky@xenosoft.de>
In-Reply-To: <20240510080757.560159-1-hbathini@linux.ibm.com>
References: <20240510080757.560159-1-hbathini@linux.ibm.com>
Subject: Re: [PATCH] powerpc/85xx: fix compile error without CONFIG_CRASH_DUMP
Message-Id: <171560652136.57553.2176515778576014967.b4-ty@ellerman.id.au>
Date: Mon, 13 May 2024 23:22:01 +1000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Fri, 10 May 2024 13:37:57 +0530, Hari Bathini wrote:
> Since commit 5c4233cc0920 ("powerpc/kdump: Split KEXEC_CORE and
> CRASH_DUMP dependency"), crashing_cpu is not available without
> CONFIG_CRASH_DUMP. Fix compile error on 64-BIT 85xx owing to this
> change.
> 
> 

Applied to powerpc/next.

[1/1] powerpc/85xx: fix compile error without CONFIG_CRASH_DUMP
      https://git.kernel.org/powerpc/c/7b090b6ff51b9a9f002139660672f662b95f0630

cheers

