Return-Path: <stable+bounces-55821-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E6D19178E5
	for <lists+stable@lfdr.de>; Wed, 26 Jun 2024 08:28:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E99211F225CD
	for <lists+stable@lfdr.de>; Wed, 26 Jun 2024 06:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64EB814D6EB;
	Wed, 26 Jun 2024 06:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UpbWcsvZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1865813A869;
	Wed, 26 Jun 2024 06:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719383314; cv=none; b=uZ3Csl3FTPtHDO1IGjfabrRyDH3sZr+rsQtW9Q8b3PnQlBI1/UFe+ns3d0qLSgSwSAH07etVXKFtqa8VNPb9ZC2VXMqhUJfe1I7qzIjysa2kjy4JsbjOJZ+Mn8GMq7oaNSp3StfbbpfoW5hSWDL57hxRqu+n49MVkCMcQ2HwJOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719383314; c=relaxed/simple;
	bh=9jEpfg2N6J4shrk3c2BQLjUO0Oh8yhjDyDDFjwgJmF0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CcOfU5tv3jBafRMVsUzDK0xQiYwPYlzxvxdHxyH8VLSGdUO0ithY+YsVEX66h4ZZTJ7OjchmZUfzQ3OsAJdRpRjS/rCO9WeueMDBFlDZW29IrMi6JbuhGqdGe0zL0ND7m1zpiM7RTlTgXA3jB8rb1qb/yMPljoosaelUPwQuwhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UpbWcsvZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57E87C32782;
	Wed, 26 Jun 2024 06:28:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719383313;
	bh=9jEpfg2N6J4shrk3c2BQLjUO0Oh8yhjDyDDFjwgJmF0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=UpbWcsvZXyok0rtpT+Af+1xZBhZm+izvj8SKJMUxtIdULTRz22LhN838Im7/SLnf+
	 wpxD3koR8IIME2G4+Zzq1U18rzpKg2HeQu404xYcVyG2tab+FVI0iySeGfVxgJErOt
	 1KiufFfbz0ssMdOy19N8g5n3Gz2BqBaMH5RlNr1L3nJgfIDaCQv4ogIr1Iajchwm44
	 9ICgw/ilndevhOStH+a+dqGRXpAMQ/ZW6qsWVdvaK97iia/zQinZBZ+ax1SZDCE8Hf
	 ltvYOSYfC4ebDr9JFzy1FtkUbk01dKyCWy8F40A0Iaz8EEvTIOC+mP9BBPUqlcmuFP
	 UztnB10h13IrA==
Message-ID: <afffc35d-ca69-47b8-8a09-6a5fe4a80479@kernel.org>
Date: Wed, 26 Jun 2024 15:28:31 +0900
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/6] ata: libata-scsi: Fix offsets for the fixed format
 sense data
To: Igor Pylypiv <ipylypiv@google.com>, Niklas Cassel <cassel@kernel.org>
Cc: Tejun Heo <tj@kernel.org>, Hannes Reinecke <hare@suse.de>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Jason Yan <yanaijie@huawei.com>, linux-ide@vger.kernel.org,
 linux-kernel@vger.kernel.org, Akshat Jain <akshatzen@google.com>,
 stable@vger.kernel.org
References: <20240624221211.2593736-1-ipylypiv@google.com>
 <20240624221211.2593736-3-ipylypiv@google.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20240624221211.2593736-3-ipylypiv@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/25/24 07:12, Igor Pylypiv wrote:
> Correct the ATA PASS-THROUGH fixed format sense data offsets to conform
> to SPC-6 and SAT-5 specifications. Additionally, set the VALID bit to
> indicate that the INFORMATION field contains valid information.

This needs to go before patch 1. Then patch 1 modification introducing the new
function ata_scsi_set_passthru_sense_fields() will be doing so using the
corrected code.

-- 
Damien Le Moal
Western Digital Research


