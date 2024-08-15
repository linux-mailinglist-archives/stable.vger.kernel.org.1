Return-Path: <stable+bounces-68485-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 263FD95328E
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 16:07:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC1E628856E
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 14:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 248D81A76B5;
	Thu, 15 Aug 2024 14:05:19 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from ciao.gmane.io (ciao.gmane.io [116.202.254.214])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B921A08DD
	for <stable@vger.kernel.org>; Thu, 15 Aug 2024 14:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.202.254.214
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723730719; cv=none; b=mwlZko02KZwrkyxkane00k3wjQPgu+Tr1j3zLVttfi8I6Z+isvPIN0UzXGjvWgrMTHIU5G8wVvfFctNR+ZHxUZOrOQ45wvyhk4vgmVuUCWPDctjN31F+jWNfSCax6lepMTLAWBbEf3eld23jVygR6aC0TZWwL8wuMbpKNk4vyUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723730719; c=relaxed/simple;
	bh=4aZ/oO2nmJFXZ8IT0V5tZwULYNrQ/IrKZ9OYu7pqan4=;
	h=To:From:Subject:Date:Message-ID:References:Mime-Version:
	 Content-Type:In-Reply-To:Cc; b=tnVRxzKZy4a13BkBp7dQWo/XzSQ+WeWG/akuF1UCe4bIuICdTC/QVWMkTjZGB7So6l1OHxtxM3VzXAsNo+alzsT66aR7I8xAEpzBRSuccid9sj6v1sPmTpoBsqIVciHJc/+vS6qKMeAJZsZY0nGHMRGm4EXC6sgbJyDCCpEu43k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=m.gmane-mx.org; arc=none smtp.client-ip=116.202.254.214
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=m.gmane-mx.org
Received: from list by ciao.gmane.io with local (Exim 4.92)
	(envelope-from <glks-stable4@m.gmane-mx.org>)
	id 1seb6D-0003E3-Bf
	for stable@vger.kernel.org; Thu, 15 Aug 2024 16:05:09 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: stable@vger.kernel.org
From: Ian Pilcher <arequipeno@gmail.com>
Subject: Re: [PATCH] Revert "ata: libata-scsi: Honor the D_SENSE bit for
 CK_COND=1 and no error"
Date: Thu, 15 Aug 2024 09:05:04 -0500
Message-ID: <v9l1ug$10ii$1@ciao.gmane.io>
References: <20240813131900.1285842-2-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
User-Agent: Mozilla Thunderbird
Content-Language: en-US
In-Reply-To: <20240813131900.1285842-2-cassel@kernel.org>
Cc: linux-ide@vger.kernel.org

On 8/13/24 8:19 AM, Niklas Cassel wrote:
> This reverts commit 28ab9769117ca944cb6eb537af5599aa436287a4.

Reviewed-by: Ian Pilcher <arequipeno@gmail.com>

-- 
========================================================================
Google                                      Where SkyNet meets Idiocracy
========================================================================



