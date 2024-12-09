Return-Path: <stable+bounces-100260-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6C559EA118
	for <lists+stable@lfdr.de>; Mon,  9 Dec 2024 22:17:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59B8628251A
	for <lists+stable@lfdr.de>; Mon,  9 Dec 2024 21:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE50819CC33;
	Mon,  9 Dec 2024 21:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uYoQpPU4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E8416DC15;
	Mon,  9 Dec 2024 21:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733778934; cv=none; b=FwZxWHdJFnypwYJ+ooRzQd2zVq3YGx5mAjWAAgeOy90HJQ9Djfl5CRd9msSfMZGYjjRFEk5RxgOeFKSSItUrE7DNOd2/BN6Cu9DpVRjsJOk69jd1OZAovEnAd0DI6APFD8JF0WF/CRWsAk3dmGVne9GthBNh6PW/067jIAt03FQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733778934; c=relaxed/simple;
	bh=xKjC/vSbV+aSooAKXwQDJmCX7auHSoWRC6VwrKkVSTA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ke68KSPthZrHFcles8qNFPtAgN+32ujts7ikD6L1msAYuZtUNu6gVJfOBYbG0g/op4ThNOC/27VcKTBVVOWCES/OfnuCkMwdflZlWhIOTMVoldpIM4dtOA6b1TZKVDYpqbRXxLpTI7TM/iTT5j27dmvm+8/94DP0HptB2guemN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uYoQpPU4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47A77C4CED1;
	Mon,  9 Dec 2024 21:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733778934;
	bh=xKjC/vSbV+aSooAKXwQDJmCX7auHSoWRC6VwrKkVSTA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uYoQpPU4aSV3h+SL/BtwtslJMQdrwznYGyoN2qZDtBb0sV/Kk+8ibwqiFlYQ22g6f
	 MWeVCHdZiHak/YABZDCk70dlVop+icHWt8UP36e/X14f3c2BcCsagkeSaakLdWhqEU
	 IUtP+Csm4hwj0/wdahaQIEwZgojO8po7PL/K3AujtIsAdwARvsMkRO8+Br6DyM9rBT
	 5jSYRtF7A71hFnMB7t8qyuqkwNkFn3dd19bRhqGjaQWkJACCZaEfl99uP7MG2d5v3x
	 GdVPHm2JwJ4Qxcdmg9xXaaODyceYPh30vr4tSHMTS02rBUU5uLge/2r+an/4x4osjT
	 /2opjmVUrjvwg==
Date: Mon, 9 Dec 2024 15:15:32 -0600
From: Rob Herring <robh@kernel.org>
To: Zijun Hu <zijun_hu@icloud.com>
Cc: Saravana Kannan <saravanak@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Marc Zyngier <maz@kernel.org>,
	Stefan Wiehler <stefan.wiehler@nokia.com>,
	Grant Likely <grant.likely@linaro.org>,
	Tony Lindgren <tony@atomide.com>, Kumar Gala <galak@codeaurora.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Julia Lawall <Julia.Lawall@lip6.fr>,
	Jamie Iles <jamie@jamieiles.com>,
	Grant Likely <grant.likely@secretlab.ca>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Rob Herring <rob.herring@calxeda.com>,
	Zijun Hu <quic_zijuhu@quicinc.com>, stable@vger.kernel.org
Subject: Re: [PATCH 0/8] of/irq: fix bugs
Message-ID: <20241209211532.GC938291-robh@kernel.org>
References: <20241209-of_irq_fix-v1-0-782f1419c8a1@quicinc.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241209-of_irq_fix-v1-0-782f1419c8a1@quicinc.com>

On Mon, Dec 09, 2024 at 09:24:58PM +0800, Zijun Hu wrote:
> This patch series is to fix bugs in drivers/of/irq.c
> 
> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
> ---
> Zijun Hu (8):
>       of/irq: Fix wrong value of variable @len in of_irq_parse_imap_parent()
>       of/irq: Correct element count for array @dummy_imask in API of_irq_parse_raw()
>       of/irq: Fix device node refcount leakage in API of_irq_parse_raw()
>       of/irq: Fix using uninitialized variable @addr_len in API of_irq_parse_one()
>       of/irq: Fix device node refcount leakage in API of_irq_parse_one()
>       of/irq: Fix device node refcount leakages in of_irq_count()
>       of/irq: Fix device node refcount leakages in of_irq_init()
>       of/irq: Fix device node refcount leakage in API irq_of_parse_and_map()

How did you find these refcount issues? Can we get a unit test for 
these.

Rob

