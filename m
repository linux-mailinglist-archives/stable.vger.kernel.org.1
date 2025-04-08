Return-Path: <stable+bounces-128815-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B31DBA7F3CC
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 06:52:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35C2C3B4318
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 04:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E87C41EE7BE;
	Tue,  8 Apr 2025 04:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b="mylrOe9U"
X-Original-To: stable@vger.kernel.org
Received: from out0-215.mail.aliyun.com (out0-215.mail.aliyun.com [140.205.0.215])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7996223AD;
	Tue,  8 Apr 2025 04:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.205.0.215
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744087924; cv=none; b=rPY+ZKtbzzPEsFZWjNc1paiFrTetD15MByLJz3FyD8HrTQD3cvW2gLHx3AfV9YuTJ5E8LmtCsPRSSbUItgdclTngqXXxDYOmmqUoG2GuG7y1t9xRGEohlFIBN85O0Bw4ZL92ADc33IHBa7f7rNCcxIjlov03JJ/l0u2OS4pVTlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744087924; c=relaxed/simple;
	bh=OwgXVT4MJwOJzqVS32ZbXbe5I0UVIFilWS1LKeJRDhQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sfAyJhfIcJ4zHA1G2VtJdW9JtBndw4/IFKD2cL//WsIjigm2g2uzi5cbo9P3XcSswQKiBWIG5vhh1pQnqnl9NtTieHon66AUgEE/l1jHMRf9KEkxnRcU4Pjc7vLqntYRdK/wvopy29j42P/V99uS9/tzBtTIme85L5rnkTf5bnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com; spf=pass smtp.mailfrom=antgroup.com; dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b=mylrOe9U; arc=none smtp.client-ip=140.205.0.215
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antgroup.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1744087917; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=bwkiWIhCqcHRhh2byO+xlA819heH6mmGnapUcjYd90c=;
	b=mylrOe9U5aCYivBuUNzS4swS3Oi3MRE//1bm+PDhXcEEJv8IUVknjPZFjKngN3fqo2E54sZ5fc4AxRJhitafm/Z2fwp4F5QlTe0SQzcwd/2Gv54ciSsjYdqMDnkHwfFJE5RzWPJ7TR7r2DXAVx+kyHejr1c/mMgSz/qJG3y18TY=
Received: from 30.174.97.68(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.cGaosiy_1744086978 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 08 Apr 2025 12:36:18 +0800
Message-ID: <ab2a3e64-b8ef-4e27-9d73-3b08b4364528@antgroup.com>
Date: Tue, 08 Apr 2025 12:36:17 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH AUTOSEL 6.14 26/31] um: Rewrite the sigio workaround based
 on epoll and tgkill
To: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>, richard@nod.at,
 anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net,
 benjamin.berg@intel.com, linux-um@lists.infradead.org
References: <20250407181054.3177479-1-sashal@kernel.org>
 <20250407181054.3177479-26-sashal@kernel.org>
Content-Language: en-US
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
In-Reply-To: <20250407181054.3177479-26-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2025/4/8 02:10, Sasha Levin wrote:
> From: Tiwei Bie <tiwei.btw@antgroup.com>
> 
> [ Upstream commit 33c9da5dfb18c2ff5a88d01aca2cf253cd0ac3bc ]
> 
> The existing sigio workaround implementation removes FDs from the
> poll when events are triggered, requiring users to re-add them via
> add_sigio_fd() after processing. This introduces a potential race
> condition between FD removal in write_sigio_thread() and next_poll
> update in __add_sigio_fd(), and is inefficient due to frequent FD
> removal and re-addition. Rewrite the implementation based on epoll
> and tgkill for improved efficiency and reliability.
> 
> Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
> Link: https://patch.msgid.link/20250315161910.4082396-2-tiwei.btw@antgroup.com
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  arch/um/drivers/random.c       |   2 +-
>  arch/um/drivers/rtc_user.c     |   2 +-
>  arch/um/include/shared/os.h    |   2 +-
>  arch/um/include/shared/sigio.h |   1 -
>  arch/um/kernel/sigio.c         |  26 ---
>  arch/um/os-Linux/sigio.c       | 330 +++++----------------------------
>  6 files changed, 47 insertions(+), 316 deletions(-)

Please drop this patch. Thanks! Details can be found here: 

https://lore.kernel.org/linux-um/ffa0b6af-523d-4e3e-9952-92f5b04b82b3@antgroup.com/

Regards,
Tiwei

