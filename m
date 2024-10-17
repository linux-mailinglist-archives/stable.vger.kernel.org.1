Return-Path: <stable+bounces-86558-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EC949A1A36
	for <lists+stable@lfdr.de>; Thu, 17 Oct 2024 07:42:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22AEC284C4C
	for <lists+stable@lfdr.de>; Thu, 17 Oct 2024 05:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8F3C161326;
	Thu, 17 Oct 2024 05:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aurel32.net header.i=@aurel32.net header.b="Vm3ZbYyt"
X-Original-To: stable@vger.kernel.org
Received: from hall.aurel32.net (hall.aurel32.net [195.154.113.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F0913D24D;
	Thu, 17 Oct 2024 05:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.154.113.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729143764; cv=none; b=Eo62jtOKGfM/rLNbfCPqYmvD0QCUkAxNij5/mMMr8EEoIK6vx8/KbVoqfO5xOxu1DmnMXmogzRVOTxb2abXfnWaRWrIRegspPn/qyjE7xc5E3zlmHPoo3CYYlocBnQHgRQdJZrMJyelbwHtplA4+E7nuzCEEJpCuz/A3LFdmt8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729143764; c=relaxed/simple;
	bh=gvLp07rtsCC/gWsx6ZZ+sH2bfzg1fsP6IHdmY/4VqyQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EJ3QXQiGdOvOZuscRqOpUlL3nIzvoYoo5yafmKerz1IugX5dyUxLn6hsvepoSYi07yjWfOtLElJ+gOilODCDZrQQe9Dj4zibzwJe59vvoXw9uKIYC7tInI3bKW/6YSZmsQSm76Es7Hu4ndC97LB9yrhSIa9WSY64MNcP7uWqPsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aurel32.net; spf=pass smtp.mailfrom=aurel32.net; dkim=pass (2048-bit key) header.d=aurel32.net header.i=@aurel32.net header.b=Vm3ZbYyt; arc=none smtp.client-ip=195.154.113.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aurel32.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aurel32.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aurel32.net
	; s=202004.hall; h=In-Reply-To:Content-Type:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Content-Transfer-Encoding:From:Reply-To:
	Subject:Content-ID:Content-Description:X-Debbugs-Cc;
	bh=RaHIq55a6LBnXV+LFWzeAoe5CFUFd3OQ+yom3QaYLeE=; b=Vm3ZbYyti3LQ+4nHe4w2Uw33rz
	W4fx4Q+BywNaLd/qtX41BGm4xv/QS1icXKnvcFQEYm5EDMfR+7S5/VS9vnseyw424NG/qTuwFOciE
	rLVW2po83O0dSK0t+qOQzwcc9qopsxQ5FEBf7LkWn9IUupx/R9p4UHzELkou+XJC192pix2xX6SM2
	912fiBzS/jYm9rmLMRtpLrZFOR/RAUVUSzGIzSpTcV+MPnPTk0KnKbu/78xNo3i0aXmwSVHbP5r5r
	iYdijfPyhhBVFPflvuASPBLoZ6ifehVPvv49qVHQikJnPbT3WAF8RzIxjwWNrE1R2S/QrUnnZfwSb
	46kv3WkQ==;
Received: from ohm.aurel32.net ([2001:bc8:30d7:111::2] helo=ohm.rr44.fr)
	by hall.aurel32.net with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <aurelien@aurel32.net>)
	id 1t1JH4-0076ml-2m;
	Thu, 17 Oct 2024 07:42:14 +0200
Date: Thu, 17 Oct 2024 07:42:12 +0200
From: Aurelien Jarno <aurelien@aurel32.net>
To: Conor Dooley <conor@kernel.org>
Cc: linux-riscv@lists.infradead.org,
	Conor Dooley <conor.dooley@microchip.com>, stable@vger.kernel.org,
	Emil Renner Berthing <kernel@esmil.dk>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Changhuang Liang <changhuang.liang@starfivetech.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] riscv: dts: starfive: disable unused csi/camss nodes
Message-ID: <ZxCjtK5rE0SZuFvf@aurel32.net>
Mail-Followup-To: Conor Dooley <conor@kernel.org>,
	linux-riscv@lists.infradead.org,
	Conor Dooley <conor.dooley@microchip.com>, stable@vger.kernel.org,
	Emil Renner Berthing <kernel@esmil.dk>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Changhuang Liang <changhuang.liang@starfivetech.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241016-moonscape-tremor-8d41e6f741ff@spud>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241016-moonscape-tremor-8d41e6f741ff@spud>
User-Agent: Mutt/2.2.13 (2024-03-09)

Hi,

On 2024-10-16 21:11, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> Aurelien reported probe failures due to the csi node being enabled
> without having a camera attached to it. A camera was in the initial
> submissions, but was removed from the dts, as it had not actually been
> present on the board, but was from an addon board used by the
> developer of the relevant drivers. The non-camera pipeline nodes were
> not disabled when this happened and the probe failures are problematic
> for Debian. Disable them.
> 
> CC: stable@vger.kernel.org
> Fixes: 28ecaaa5af192 ("riscv: dts: starfive: jh7110: Add camera subsystem nodes")
> Closes: https://lore.kernel.org/all/Zw1-vcN4CoVkfLjU@aurel32.net/
> Reported-by: Aurelien Jarno <aurelien@aurel32.net>
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
> CC: Emil Renner Berthing <kernel@esmil.dk>
> CC: Rob Herring <robh@kernel.org>
> CC: Krzysztof Kozlowski <krzk+dt@kernel.org>
> CC: Conor Dooley <conor+dt@kernel.org>
> CC: Changhuang Liang <changhuang.liang@starfivetech.com>
> CC: devicetree@vger.kernel.org
> CC: linux-riscv@lists.infradead.org
> CC: linux-kernel@vger.kernel.org
> ---
>  arch/riscv/boot/dts/starfive/jh7110-common.dtsi | 2 --
>  1 file changed, 2 deletions(-)

Thanks for picking up that issue. I confirm this fix the "problem".

To give some more details, the problem for Debian is that it appears as
an error, with the line in red in dmesg or journalctl. However we would
like to be able to provide a kernel with such drivers enabled so that
users with a camera can just use an overlay or patch their device tree.

Tested-by: Aurelien Jarno <aurelien@aurel32.net>
Reviewed-by: Aurelien Jarno <aurelien@aurel32.net>

Regards
Aurelien
 

-- 
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                     http://aurel32.net

