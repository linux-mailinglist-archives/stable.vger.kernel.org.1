Return-Path: <stable+bounces-128812-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AD7FA7F3A6
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 06:37:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 079733A4DBC
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 04:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDD11202F92;
	Tue,  8 Apr 2025 04:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b="t9t8RrZQ"
X-Original-To: stable@vger.kernel.org
Received: from out0-210.mail.aliyun.com (out0-210.mail.aliyun.com [140.205.0.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD5E35973;
	Tue,  8 Apr 2025 04:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.205.0.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744087069; cv=none; b=JC22BDrzV10tM7JIOdWLEP/glF/2KNa50YeBlP2qyDtRIXT9DLuX3FyhCMrGsw+HaPtTk9YByy3ogfjNC4ozMoi21aXGAlGlrF6ZBVfdIj5XzwpbvQW5Yjl49vk72QkhCrjNW4mYP2MXRnc+jXAl4dmbJIRp+Y5NFpS67vAMExk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744087069; c=relaxed/simple;
	bh=F7uidL7sixLMVmNW/hl5KkkuqtCEo4Ko+agC4108UJk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WDS39eEP89AwyLMg5iJIcLUnP9pYwK6aabhR9xXv8lDVDHSvj79clB2WFvGq4pPPX2z5UtGdk/Gyo4wreVBSseLp/TLOkQCD2OTFtcGmIBPh0s1QuG2OVe+pMuy04VNjyI3N97807bQIJgWsrlSqozQLHUj6pAxnZlfTWg4e9Ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com; spf=pass smtp.mailfrom=antgroup.com; dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b=t9t8RrZQ; arc=none smtp.client-ip=140.205.0.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antgroup.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1744087062; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=O8emNOLgchaMA6FNToPtETTCX+MdTAGIvuUPFGMciYA=;
	b=t9t8RrZQEIy47g9tIee7IXJKwlv5i7gsbQQNjJSKabwrTjN0x+F2Yxd+/d2kMzSBvmepJrBR2JCFraE7w93wx2TtaK8Mr5FYkoJjpq3BaKQdpb0Hu6Xpb8wtKxFNjWLIYeuAcrBpa1EEPDyiy4vhwtYLJAD+ywHtgjxnPxxLJgU=
Received: from 30.174.97.68(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.cGaotJt_1744087060 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 08 Apr 2025 12:37:41 +0800
Message-ID: <d9125f9e-4ec2-40aa-b186-798f53bcd2c6@antgroup.com>
Date: Tue, 08 Apr 2025 12:37:40 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH AUTOSEL 6.13 22/28] um: Switch to the pthread-based helper
 in sigio workaround
To: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>, richard@nod.at,
 anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net,
 linux-um@lists.infradead.org
References: <20250407181224.3180941-1-sashal@kernel.org>
 <20250407181224.3180941-22-sashal@kernel.org>
Content-Language: en-US
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
In-Reply-To: <20250407181224.3180941-22-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2025/4/8 02:12, Sasha Levin wrote:
> From: Tiwei Bie <tiwei.btw@antgroup.com>
> 
> [ Upstream commit d295beeed2552a987796d627ba7d0985b1e2d72f ]
> 
> The write_sigio thread and UML kernel thread share the same errno,
> which can lead to conflicts when both call syscalls concurrently.
> Switch to the pthread-based helper to address this issue.
> 
> Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
> Link: https://patch.msgid.link/20250319135523.97050-4-tiwei.btw@antgroup.com
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  arch/um/os-Linux/sigio.c | 44 +++++++++++++++++-----------------------
>  1 file changed, 19 insertions(+), 25 deletions(-)

Please drop this patch. Thanks! Details can be found here: 

https://lore.kernel.org/linux-um/ffa0b6af-523d-4e3e-9952-92f5b04b82b3@antgroup.com/

Regards,
Tiwei

