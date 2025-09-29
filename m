Return-Path: <stable+bounces-181941-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D003BA9B88
	for <lists+stable@lfdr.de>; Mon, 29 Sep 2025 16:55:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA778173CD4
	for <lists+stable@lfdr.de>; Mon, 29 Sep 2025 14:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17C8430AACE;
	Mon, 29 Sep 2025 14:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=mboxify.com header.i=@mboxify.com header.b="ji2BGdh4"
X-Original-To: stable@vger.kernel.org
Received: from mail-108-mta50.mxroute.com (mail-108-mta50.mxroute.com [136.175.108.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B46C3090D2
	for <stable@vger.kernel.org>; Mon, 29 Sep 2025 14:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.175.108.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759157710; cv=none; b=YIpEpnOPoIjYqIgp29h+pptb6PmOq0Lgv2Fs0N1NyWhvJYyGKGJ6u5PslJBUzqhDJ29Qvjky63+yTl8T12zV+jH1rgOFXh9cFRBx6Jj2vpa/raYpy6bYYlahRzQTFQzECrYEcu6STZ/uKjn8QeeIZujrGr6VFEQ9DGOBaZkxtkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759157710; c=relaxed/simple;
	bh=hO5a1/vkd7Dni4yGzOpI0f6LLe0jkbH2EodzjvCuRYo=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=fULRehdosCbwlED1PJ8aTMZ7CI16cEzSavoJnn2U3SwQkHbGEXsyXFyVOqWqmZmVPLIePnGgxR0jQCqQvStSWj+u4jXK/qAMVJ+WLdQog6YsPkwlUuMqUBo93Jv75B7CYo+koebptY25gqhETCjU5hYXhxiJLwK9O4mZ6lXFQ5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mboxify.com; spf=pass smtp.mailfrom=mboxify.com; dkim=pass (2048-bit key) header.d=mboxify.com header.i=@mboxify.com header.b=ji2BGdh4; arc=none smtp.client-ip=136.175.108.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mboxify.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mboxify.com
Received: from filter006.mxroute.com ([136.175.111.3] filter006.mxroute.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by mail-108-mta50.mxroute.com (ZoneMTA) with ESMTPSA id 19995f3a484000c244.008
 for <stable@vger.kernel.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Mon, 29 Sep 2025 14:49:56 +0000
X-Zone-Loop: 56db775bdaa4a7cff2c60db39f97bb277abf38c6030e
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mboxify.com
	; s=x; h=Content-Transfer-Encoding:Content-Type:References:In-Reply-To:
	Subject:Cc:To:From:Date:MIME-Version:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=AljqcaWaZXtvzNqWDvXUhVw0YtH+OrsswYByjzLE7UA=; b=ji2BGdh47RoDoRdWlUN94tHRhF
	l7/Vdfo34LJ/0bBumXuNxsT31oBFHnQyA3cHU2s0FQLmckFhbB3+RvXfUcX4ikNxB9eeAkVmcnUlG
	Z9YZGF3Q8C7CkHKaahbGBlLvgTTUH6gCBd+0qBs25/Ol5fn3YwXgZtbo7aV5Du9ZVWto10fmuVVQk
	qFl/Dm1VdAP1yIpwHhkHsaeeq2bVKw89CPTBWIZTUKEnpMIXQBoIF4ZxDXZ2zFpUxAmWK7Ht88QHp
	GPO8FiYiQoBK/fHXp+6GVALFAYETQtD7Itu+MDbvbcX0IEWnKlYZAu7wKFoOP+oUEcWaTkncrgpEH
	h0RWRaCA==;
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 29 Sep 2025 22:49:54 +0800
From: Bo Sun <bo@mboxify.com>
To: Simon Horman <horms@kernel.org>
Cc: sgoutham@marvell.com, gakula@marvell.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH 1/2] octeontx2-vf: fix bitmap leak
In-Reply-To: <aNpbZkQZxa3HkrJj@horms.kernel.org>
References: <20250927071505.915905-1-bo@mboxify.com>
 <20250927071505.915905-2-bo@mboxify.com> <aNpbZkQZxa3HkrJj@horms.kernel.org>
Message-ID: <0bb6cec0e6bcf22a43bfff4b0813b201@mboxify.com>
X-Sender: bo@mboxify.com
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Authenticated-Id: bo@mboxify.com

On 2025-09-29 18:11, Simon Horman wrote:
> On Sat, Sep 27, 2025 at 03:15:04PM +0800, Bo Sun wrote:
>> The bitmap allocated with bitmap_zalloc() in otx2vf_probe() was not
>> released in otx2vf_remove(). Unbinding and rebinding the driver 
>> therefore
>> triggers a kmemleak warning:
>> 
>>     unreferenced object (size 8):
>>       backtrace:
>>         bitmap_zalloc
>>         otx2vf_probe
>> 
>> Call bitmap_free() in the remove path to fix the leak.
>> 
>> Fixes: efabce290151 ("octeontx2-pf: AF_XDP zero copy receive support")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Bo Sun <bo@mboxify.com>
> 
> Reviewed-by: Simon Horman <horms@kernel.org>
> 
> For reference, as a fix for code present in net, this series
> should be targeted at net, like this:
> 
> Subject: [PATCH net 1/2] ...
> 
> See: https://docs.kernel.org/process/maintainer-netdev.html

Thanks for pointing this out.
I’ll resend v2 for the net tree with the correct subject prefix.

Best regards,
Bo

