Return-Path: <stable+bounces-58922-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C71992C2B3
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 19:43:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 150351F26A0D
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 17:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADAB417B04F;
	Tue,  9 Jul 2024 17:43:14 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from a3.inai.de (a3.inai.de [88.198.85.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6793D157470;
	Tue,  9 Jul 2024 17:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=88.198.85.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720546994; cv=none; b=ByW6gQ9BmEndxl1tGKOORT07gKx22r19mTypyFwAo6a90gx00CWRMvDdbLUWzVDNhVP/Q9h9osagOVrYJApltNa8VXQICiev7+AnLM6p8NIjQHC/Kkl4OQgUuMtR1wEqMc4fgkp0G/zbfKhcgrsg8iUyRd7VMCBUmDRiC7deFG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720546994; c=relaxed/simple;
	bh=sXS06RG7mRvH47DVMkm9hcVYched9n2sZ2yUgDnfv2M=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=aUgFNuSOJ7S9jckgFRO+qJgucuSKmjCey62/6cCc3HceYIKb85r4+Ka2SoeLOPsDDfjx+j/pIs4PcrNPIeKlND7lMwbsX77Yaz086CGvKFVxYgnCsybu7WiRnmZ8pK6pJdjwNbLzSrVHEB3m7CTzm4BWXfeBdoTn/RwQ8fLi8N4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inai.de; spf=pass smtp.mailfrom=inai.de; arc=none smtp.client-ip=88.198.85.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inai.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inai.de
Received: by a3.inai.de (Postfix, from userid 25121)
	id D9BE658725FF2; Tue,  9 Jul 2024 19:33:13 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by a3.inai.de (Postfix) with ESMTP id D72B760C6495C;
	Tue,  9 Jul 2024 19:33:13 +0200 (CEST)
Date: Tue, 9 Jul 2024 19:33:13 +0200 (CEST)
From: Jan Engelhardt <jengelh@inai.de>
To: Sasha Levin <sashal@kernel.org>
cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
    Tejun Heo <tj@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH AUTOSEL 6.9 01/40] workqueue: Refactor worker ID formatting
 and make wq_worker_comm() use full ID string
In-Reply-To: <20240709162007.30160-1-sashal@kernel.org>
Message-ID: <pp021o2p-2025-7nor-7257-sons6q59rorp@vanv.qr>
References: <20240709162007.30160-1-sashal@kernel.org>
User-Agent: Alpine 2.26 (LSU 649 2022-06-02)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT


On Tuesday 2024-07-09 18:18, Sasha Levin wrote:

>From: Tejun Heo <tj@kernel.org>
>
>[ Upstream commit 2a1b02bcba78f8498ab00d6142e1238d85b01591 ]
>
>TASK_COMM_LEN is only 16 leading to badly truncated names for
>rescuers. For example, the rescuer for the inet_frag_wq workqueue becomes:
>
>  $ ps -ef | grep '[k]worker/R-inet'
>  root         483       2  0 Apr26 ?        00:00:00 [kworker/R-inet_]

* very old Linux: process names are fixed to 16 bytes
* Linux 6.something: we relaxed it for kthreads in principle, but
  oopsie-daisie forgot one case so it's still 16 bytes for that one case
* 2a1b02: now that one case also has length limit lifted

which for me makes this count as a feature rather than a bugfix,
and I would not add it to -stable.
There might even be a poor soul who tests for exact process names in one
obscure shell script of his… would not want to break his setup when going
6.9.8->6.9.9, only with 6.9.8->6.10.

