Return-Path: <stable+bounces-119773-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8D85A46FB6
	for <lists+stable@lfdr.de>; Thu, 27 Feb 2025 00:53:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C62873AD98E
	for <lists+stable@lfdr.de>; Wed, 26 Feb 2025 23:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2979E25DB00;
	Wed, 26 Feb 2025 23:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="KA+cbgny"
X-Original-To: stable@vger.kernel.org
Received: from pv50p00im-ztdg10012101.me.com (pv50p00im-ztdg10012101.me.com [17.58.6.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79B725D217
	for <stable@vger.kernel.org>; Wed, 26 Feb 2025 23:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740613974; cv=none; b=aIbWm7BB7HNft/kF/Il5WISQtDiHdM9DxOwVBJT8ttv49uhh2Bj9k4V8QcpKTvFyhMwL+vVcIEcDtnzXxV0E8hNRmjYWffOLNS2YbHsbRD505T+n4DPV8mIzsY/N5sWvAliNPwUTgiH+2kwmlwLtjSB+QCZ4s3mjyl1x0ezJ+Eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740613974; c=relaxed/simple;
	bh=MRaEsWys87Pn4a0qFFl/SQ4wZqGYEGJJfYgg4Zvyktg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lfsVRNZpiEwmGNlUQngFCS2TolLHd4mFcX2m+0HDb31RwuEtpLyNJx6SQzHwHNrAW6a903kzsrt5ljwdcaPvYPpUcGD/QgaeLfazA1+4ZkYAyAwj6Yw66zeUl+taG6ncW7jKfjuScMvBFlLWgxV9doujT/jeT04TluyiXzLEubQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=KA+cbgny; arc=none smtp.client-ip=17.58.6.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; bh=i7mhFoUi2tw6qZatddnr2O9pvtJog0jFw0rliAU9o6A=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:x-icloud-hme;
	b=KA+cbgnyDoqsho3Q5gI5znPAuKp2oQfrJDAeF5jYGHtDbBWw5F6EaB4nM6J8CECnI
	 f07mP0H9If/o0dwnt0zNYHSy2L4YM1PqRI+3C3RvNdR1HaGsKIuivxxB9HEK8EVUnE
	 RQg2fGLLtEsQb0F1EYnOEa93lMZ/+s3+oWCzILuxcvEpOeU0fERWoID4oJi1JBB8AS
	 k3OQy9WEARP2E86PFlOqxsByo4yvs+b0bLR2yAHvt60/fVXcEunGM0tnuHHJn143zM
	 J7s+6oz1sCjnJ9F6qNKUfTrDjeb+cfAlz9cnuV64WVCvPyfQLokQQEhErWv+Ixp/7A
	 gfSBD6DhAQBjw==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-ztdg10012101.me.com (Postfix) with ESMTPSA id E4903740566;
	Wed, 26 Feb 2025 23:52:46 +0000 (UTC)
Message-ID: <67308adf-65bd-489c-80cb-5354ef202b51@icloud.com>
Date: Thu, 27 Feb 2025 07:52:13 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 09/14] of: reserved-memory: Fix using wrong number of
 cells to get property 'alignment'
To: Rob Herring <robh@kernel.org>
Cc: William McVicker <willmcvicker@google.com>,
 Zijun Hu <quic_zijuhu@quicinc.com>, Saravana Kannan <saravanak@google.com>,
 Maxime Ripard <mripard@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Grant Likely <grant.likely@secretlab.ca>, Marc Zyngier <maz@kernel.org>,
 Andreas Herrmann <andreas.herrmann@calxeda.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Mike Rapoport <rppt@kernel.org>,
 Oreoluwa Babatunde <quic_obabatun@quicinc.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, kernel-team@android.com
References: <20250109-of_core_fix-v4-0-db8a72415b8c@quicinc.com>
 <20250109-of_core_fix-v4-9-db8a72415b8c@quicinc.com>
 <20250113232551.GB1983895-robh@kernel.org> <Z70aTw45KMqTUpBm@google.com>
 <97ac58b1-e37c-4106-b32b-74e041d7db44@quicinc.com>
 <Z74CDp6FNm9ih3Nf@google.com> <20250226194505.GA3407277-robh@kernel.org>
 <f81e6906-499c-4be3-a922-bcd6378768c4@icloud.com>
 <CAL_Jsq+P=sZu6Wnqq7uEnGMnAQGNEDf_B+VgO8E8ob4RX8b=QA@mail.gmail.com>
Content-Language: en-US
From: Zijun Hu <zijun_hu@icloud.com>
In-Reply-To: <CAL_Jsq+P=sZu6Wnqq7uEnGMnAQGNEDf_B+VgO8E8ob4RX8b=QA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2025/2/27 05:30, Rob Herring wrote:
>>    this change ?
> We don't know that unless you tested every dts file. We only know that
> no one has reported an issue yet.
> 

Sorry, my mistake to post the question here for convenience.

actually, i want to ask William this question, and he/she shared applet
of the downstream code.

> Even if we did test everything, there are DT's that aren't in the
> kernel tree. It's not like this downstream DT is using some
> undocumented binding or questionable things. It's a standard binding.
> 

IMO, that may be a downstream bug since they don't refer to binding spec
to set property 'alignment'.

> Every time this code is touched, it breaks. This is not even the only
> breakage right now[1].
> 

indeed.

>> 2) IMO, the spec may be right.
>>    The type of size is enough to express any alignment wanted.
>>    For several kernel allocators. type of 'alignment' should be the type
>>    of 'size', NOT the type of 'address'
> As I said previously, it can be argued either way.
> 
> Rob
> 
> [1] https://lore.kernel.org/all/20250226115044.zw44p5dxlhy5eoni@pengutronix.de/


