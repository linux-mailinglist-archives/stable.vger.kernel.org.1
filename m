Return-Path: <stable+bounces-83756-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6659F99C593
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 11:27:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8704E1C224C7
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 09:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87AA5154C15;
	Mon, 14 Oct 2024 09:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="QAu1f+KT"
X-Original-To: stable@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F0F51BC58;
	Mon, 14 Oct 2024 09:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728898021; cv=none; b=e7LcMxmNx35fbUCQ6quoql3DJhpATNSFKJ3JS8tblYzfYFxR0rahZBmPlnGw3m3PHERX+wf84kv0q7Gi2Xx399A/YIW8iXN7IfmAwZRepOZkiwoynh/24ptcFMibh/Jg8udVqkGL/IHAjK8ZHS/h+/KxWFahklLv0F6ZGBaB47Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728898021; c=relaxed/simple;
	bh=ayWkFEgHtTpVIQyAnV0gua3gCdIq0DRPPTgdC6M4laU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RP1IDX92kd4Otq98UhwbNvyT7OSRTXSS5OTn2LoUaN8wSZjhZhUJbUw8R/sPTgOMzdlsYt8QLBclHMWTUkRJv5NSqk/ZmxhKLDAexADR+RNKi2FaHrZjNcxvSklcoOFg6sm6ui/SmuNbQ0wo0sI6jj9WO8FDbrRwf3fbiIZ6RZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=QAu1f+KT; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [IPV6:2405:201:2015:f873:55d7:c02e:b2eb:ee3f] (unknown [IPv6:2405:201:2015:f873:55d7:c02e:b2eb:ee3f])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 864998BE;
	Mon, 14 Oct 2024 11:25:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1728897916;
	bh=ayWkFEgHtTpVIQyAnV0gua3gCdIq0DRPPTgdC6M4laU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=QAu1f+KT/UlsfUQkjNRpDnS2at1ZOu5rFZSX1vIkGmP1vqVGEwA7BpbA3AIrpRPvZ
	 2RgBhkQj8f5u5diVXumv4S0eFz/4DJ/L1f5bk4rNT7W/9KrOLQbJbnxET+6J2PayTm
	 bucPPn1pQRzFww18VCZ2bFg5HV0uILs/eK7mWPMI=
Message-ID: <21116939-a868-4df2-8824-2b56f7ea68c1@ideasonboard.com>
Date: Mon, 14 Oct 2024 14:56:51 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] staging: vchiq_arm: Fix missing refcount decrement
 in error path for fw_node
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Stefan Wahren <wahrenst@gmx.net>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-rpi-kernel@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20241014-vchiq_arm-of_node_put-v2-0-cafe0a4c2666@gmail.com>
Content-Language: en-US
From: Umang Jain <umang.jain@ideasonboard.com>
In-Reply-To: <20241014-vchiq_arm-of_node_put-v2-0-cafe0a4c2666@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Javier,

Thank you for the patch

On 14/10/24 2:26 pm, Javier Carrasco wrote:
> This series refactors some useless goto instructions as a preparation
> for the fix of a missing of_node_put() by means of the cleanup
> attribute.
>
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>

For the series,

Reviewed-by: Umang Jain <umang.jain@ideasonboard.com>
> ---
> Changes in v2:
> - Refactor vchiq_probe() to remove goto instructions.
> - Declare and initialize the node right before its first usage.
> - Link to v1: https://lore.kernel.org/r/20241013-vchiq_arm-of_node_put-v1-1-f72b2a6e47d0@gmail.com
>
> ---
> Javier Carrasco (2):
>        staging: vchiq_arm: refactor goto instructions in vchiq_probe()
>        staging: vchiq_arm: Fix missing refcount decrement in error path for fw_node
>
>   .../vc04_services/interface/vchiq_arm/vchiq_arm.c     | 19 +++++++------------
>   1 file changed, 7 insertions(+), 12 deletions(-)
> ---
> base-commit: d61a00525464bfc5fe92c6ad713350988e492b88
> change-id: 20241013-vchiq_arm-of_node_put-60a5eaaafd70
>
> Best regards,


