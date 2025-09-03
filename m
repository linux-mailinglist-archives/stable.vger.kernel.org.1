Return-Path: <stable+bounces-177615-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63421B41F98
	for <lists+stable@lfdr.de>; Wed,  3 Sep 2025 14:48:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8AF577B0515
	for <lists+stable@lfdr.de>; Wed,  3 Sep 2025 12:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41AB8301006;
	Wed,  3 Sep 2025 12:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=akendo.eu header.i=@akendo.eu header.b="YFD0mQc2"
X-Original-To: stable@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 994603019D1
	for <stable@vger.kernel.org>; Wed,  3 Sep 2025 12:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756903612; cv=none; b=O2Z5YL2l58tOiqubelrXwfbk9DLWxPeF/7EJwbmtzfVCc+I2tQ5QpvBiX6CF0RuJE01vDoQOBE+Fpc3P3NqPsC/HtN9KVB/7tCC1D4uzhZYRxJzlzUqw6EHYv0aEjXxZ4vV4s1p3V6UtJWoFJgJhqkDv6GKqkR8MQJIItuQuvI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756903612; c=relaxed/simple;
	bh=Xxd1dyXtuiO/vyAgOf/TAAiroMqI4AvoPFU1q4bfRSw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o9YnUP/kDQXsC1eqPG4iLpSv19oYRZkVJMK4wZaSMLT9y5jz8ad2PQwO3iz3AzVrgfxxP5DylVDZ+magyzb+1NIxwLFE36+qu5+xK8V9rmEUDvkZ3X9ZwI+0V61b/wW1LVthtLlkCuad+vrTKDczlye9s9M2T1r1Wk1YHZ+3tt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=akendo.eu; spf=pass smtp.mailfrom=akendo.eu; dkim=pass (2048-bit key) header.d=akendo.eu header.i=@akendo.eu header.b=YFD0mQc2; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=akendo.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=akendo.eu
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4cH2Rg64v6z9t74;
	Wed,  3 Sep 2025 14:46:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akendo.eu; s=MBO0001;
	t=1756903599;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qzUaUXy5iH3CAhnFmGZ18vrkwgnM2qSLzKtf9EqQkCU=;
	b=YFD0mQc2iHUhiVs40C+8WcbN5r+XF4y0HAoOAT5G/BjY5QJbnToolEieijxUKbSBQ5zEcx
	+Wjb8pXVMPOyAB7cVhmrp0LA3CYeAtQf8cMkQ1zlb1gyNfo3agqEKvJp1h4sGlvCKpScxX
	YpboG+q4+rPITbXaxyckYkPEA/AzL4DSYeWW2P6hso9G23qYXCFXo0atvGQPZtiZjCD5kI
	PiZMaq11XMU1syRce8OkoKIxfYwc+w/9lYojFKxo0cqyuUQF8WnmigkM5oOLmDeFrqKVfT
	IFCEg8s9pc7Jc/ZBD7ZFUzS2pUXsyOCMVJmtnGdffK1IDrfeTzhINoMnziil1Q==
Message-ID: <22936b61-66e2-4b98-875b-bcb54896463a@akendo.eu>
Date: Wed, 3 Sep 2025 14:46:37 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] net/mlx5: HWS, change error flow on matcher disconnect
Content-Language: de-DE
To: Greg KH <greg@kroah.com>, "Subramaniam, Sujana"
 <sujana.subramaniam@sap.com>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>,
 Yevgeny Kliteynik <kliteyn@nvidia.com>, Itamar Gozlan <igozlan@nvidia.com>,
 Mark Bloch <mbloch@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
 Jakub Kicinski <kuba@kernel.org>, Sasha Levin <sashal@kernel.org>
References: <20250903083947.41213-1-sujana.subramaniam@sap.com>
 <2025090322-nervy-excuse-289e@gregkh>
From: akendo <akendo@akendo.eu>
In-Reply-To: <2025090322-nervy-excuse-289e@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello Greg,

Thank you for your responses. We’re in the process of learning the 
process and figuring out how to get the git send-mail out.

This patch aims for the kernel 6.12 and backports the changes for the 
mlx5 from 6.13 to it. We use the 
1ce840c7a659aa53a31ef49f0271b4fd0dc10296 commit from upsteam to do it. 
We had to update the path within the patch to make the patch apply 
that’s the only change we made. We roll this out in our kernel and test 
it already.

I forgot to add my full name to it, we will fix Sujana's Name is 
correct. Please, I apologize for the puzzlement we might have caused.

Best regards,
akendo

