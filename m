Return-Path: <stable+bounces-158835-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97FEFAECC62
	for <lists+stable@lfdr.de>; Sun, 29 Jun 2025 14:10:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 697B31896265
	for <lists+stable@lfdr.de>; Sun, 29 Jun 2025 12:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07FA821D3D9;
	Sun, 29 Jun 2025 12:09:58 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from ciao.gmane.io (ciao.gmane.io [116.202.254.214])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CEAD78F2E
	for <stable@vger.kernel.org>; Sun, 29 Jun 2025 12:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.202.254.214
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751198997; cv=none; b=u2hswJ0ZtHTN3HYthCyqTpE7Cwa13SFyPlMq8X/sVP1lSG6eLftInt50QaBQ618llGfCTQcXEh3DkOcKmrZaf74juZMy3oOGY8I0bIMMGfu0WQJ+6nijT8SuJXI0jnn0uaNN9KhCgEf1Zm+NqS7DDdg0zFdnxeqGGDEE1st37jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751198997; c=relaxed/simple;
	bh=vNJGeZBJUgNzM31Y4tDflhOdXXVSaXHD7wX/h7XV2hE=;
	h=To:From:Subject:Date:Message-ID:References:Mime-Version:
	 Content-Type:In-Reply-To:Cc; b=gG/DW9Y8e6lVtLXlDV4UqOB6vZDb9noUIZ/JjlLssrW0f6sjsCacoR29UMQL+wTFPpf56+xOuSNEJd/Mth/bncrjxp5ZU7AvIpIN9pAk64yklsxF0v0+MwrAAT9u6Lw7nFDp89Sx9DHnFGv6Sgo124sS/ikqjSqzbrfoTs6lW+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=m.gmane-mx.org; arc=none smtp.client-ip=116.202.254.214
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=m.gmane-mx.org
Received: from list by ciao.gmane.io with local (Exim 4.92)
	(envelope-from <glks-stable4@m.gmane-mx.org>)
	id 1uVqr3-0008Ps-6v
	for stable@vger.kernel.org; Sun, 29 Jun 2025 14:09:53 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: stable@vger.kernel.org
From: =?UTF-8?Q?J=C3=B6rg-Volker_Peetz?= <jvpeetz@web.de>
Subject: Re: Linux 6.15.4
Date: Sun, 29 Jun 2025 14:09:48 +0200
Message-ID: <c7b240ad-03d0-460f-be05-0a61e1267695@web.de>
References: <2025062732-negate-landless-3de0@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
User-Agent: Mozilla Thunderbird
Content-Language: en-US
In-Reply-To: <2025062732-negate-landless-3de0@gregkh>
Cc: linux-kernel@vger.kernel.org

Jörg-Volker Peetz wrote on 29/06/2025 12:22:
 > Hi,
 >
 > upgrading from linux kernel 6.14.9 to 6.15.2 and still with 6.15.4 I noticed
 > that on my system  with cpufreq scaling driver amd-pstate the frequencies
 > scaling_min_freq and scaling_max_freq increased, the min from 400 to 422.334
 > MHz, the max from 4,673 to 4,673.823 MHz. The CPU is an AMD Ryzen 7 5700G.

I should add that of course cpuinfo_min_freq and  cpuinfo_max_freq increase in 
the same way.

 > Has anybody else noticed?
 >
 > Is it intended?
 >
Regards,
Jörg



