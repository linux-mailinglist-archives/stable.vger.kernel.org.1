Return-Path: <stable+bounces-188876-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0EEBBF9DFC
	for <lists+stable@lfdr.de>; Wed, 22 Oct 2025 05:52:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6972C462A46
	for <lists+stable@lfdr.de>; Wed, 22 Oct 2025 03:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 969FD199BC;
	Wed, 22 Oct 2025 03:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=hardfalcon.net header.i=@hardfalcon.net header.b="j+Sy4Uph"
X-Original-To: stable@vger.kernel.org
Received: from 0.smtp.remotehost.it (0.smtp.remotehost.it [213.190.28.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4AB2230BCC
	for <stable@vger.kernel.org>; Wed, 22 Oct 2025 03:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.190.28.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761105144; cv=none; b=S7jTf7GaVv2gHRMHRLxC30QBs/SVFcZpkd5WsGp1XjLcudEvjK6yMAQafkVOJTagTuxgnYTwLU+hQMLdPx3bQHxDqk4Lpz8Q71VNBspB4c370XDT1D6qchtoLxANDm+fMqhbZeYquYWx0bqYNiWEZ1L4YivziEWSEnaNBbGGOWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761105144; c=relaxed/simple;
	bh=k7lHmvzNN7Trh8hjUaxeuHBCsfktS42yeEXRAMFTb40=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=gQbzavjw1l4emDVw/yqNMUK19e73O9TA7AmEtjVNnobKWHsubDl6sfnRVQ18/3E+8hd3PAtH1PzLpYSA+vFakyx6jaQPi1OGyJ/pnsx48+NDx8Kd8n2vECwmye0jO4AqC+zopCTwMu8ns8R0AMsFTsLfpoIjiuUQys3NH9LSvVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hardfalcon.net; spf=pass smtp.mailfrom=hardfalcon.net; dkim=permerror (0-bit key) header.d=hardfalcon.net header.i=@hardfalcon.net header.b=j+Sy4Uph; arc=none smtp.client-ip=213.190.28.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hardfalcon.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hardfalcon.net
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=hardfalcon.net;
	s=dkim_2024-02-03; t=1761105137;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k7lHmvzNN7Trh8hjUaxeuHBCsfktS42yeEXRAMFTb40=;
	b=j+Sy4Uphuldmt+RUhtJFiPh0W2ve0d5TWd2jy0pUWHmBu4AhyD0pXMDuGjSv+JR7iGW5Cc
	WQMzmoGjOy/xhsBw==
Message-ID: <49b53fad-586e-4b6d-bb66-a35faea2afd9@hardfalcon.net>
Date: Wed, 22 Oct 2025 05:52:17 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: Patch "PM: hibernate: Add pm_hibernation_mode_is_suspend()" has
 been added to the 6.17-stable tree
To: "Mario Limonciello (AMD) (kernel.org)" <superm1@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org,
 Sasha Levin <sashal@kernel.org>
References: <2025102032-crescent-acuteness-5060 () gregkh>
 <2745b827-b831-4964-8fc5-368f7446d73e@hardfalcon.net>
 <8c4d1326-512c-4b98-bac0-aa207b54aa2a@kernel.org>
 <19c7ba58-7300-4e10-bd81-367354f826db@hardfalcon.net>
 <1f15260b-684e-4b8c-807f-244bbfd31f1c@kernel.org>
 <edffeaca-e52a-4ecc-b788-3120e11bbef2@kernel.org>
 <c5038e5a-ebb1-464f-9b79-905168ac7e44@hardfalcon.net>
Content-Language: en-US, de-DE, en-US-large
From: Pascal Ernster <git@hardfalcon.net>
In-Reply-To: <c5038e5a-ebb1-464f-9b79-905168ac7e44@hardfalcon.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

[2025-10-21 23:34] Mario Limonciello (AMD) (kernel.org):
> Alternatively does picking https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=bbfe987c5a2854705393ad79813074e5eadcbde6 help your issue?

Thanks again, this patch does indeed fix the build issue for me :)


Regards
Pascal

