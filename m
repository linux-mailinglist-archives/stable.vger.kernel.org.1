Return-Path: <stable+bounces-83017-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBF71994FEE
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 15:31:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E60BC1C22560
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 13:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 018B91DFD9E;
	Tue,  8 Oct 2024 13:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="Rnkfu+wc"
X-Original-To: stable@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D531DFD93
	for <stable@vger.kernel.org>; Tue,  8 Oct 2024 13:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728394197; cv=none; b=gM8uuBSf0j61UNP4MY07k15Fqt/1sfjbuA2k15wezN4sVN4qtipBY9Cg1PeaQ7GP/RtIJeKuTyNyILJ7Fue3Z4/CxcjSLYnWOK3JN5uEjz44N7R1y70lg8Q8v9Hd4yOLodvbVo1RSsnz13AXvVSLgbVmQm+XUBjPqVZc6tRnkgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728394197; c=relaxed/simple;
	bh=wUJsYMjLnuE/iK4Bzv+FwlzUaqqNhg9YlaYjRKRiz4c=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=jIqiwd0xP5lEuIflHncs57o3EfEzNGzAWhKBYVEq3AXOCh1Y4MPo1sYh9YtQqZO+nQx9RUCGSPhnAF7zxYpMQhxWPCG52nQpHc4ULWtfp8LvlvgM8VSzRfVRNwzBI5cQDd+futaSAYfogZEBo4Snx9uQqNiOGaxEI63zK3J7+iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=Rnkfu+wc; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id E5BA1A07D0;
	Tue,  8 Oct 2024 15:29:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=iqKIw1C200HxWCKhJTWv
	rw0lyQ/ZThlhbXrIeKyy2Tg=; b=Rnkfu+wcUEAfLpYiv6mM3ZM3PR27lpEg4BZv
	HBvWzZu44jE8kky5wEY8drxERw8cYhbPr8yQ01zXFInOlNv0GUf1kRSK+9+Qjv9r
	r4t85w0EkBiEQSOnRwPqfN+PFOFZCFA6x1GGD82GV3nKwNiGm5oWMjxXRcUnw1ig
	aZ3DfnHpC8SGRM6A9rxEdoS0+qtJj9njBwWIs9KGmj3hOqjQurNfzzIa/OffqKdW
	l5MsDFNWxkFwpk93+9G+xweN32TXk2LNt0o2hlHLH36cZucW1dS2+ZwdZyj0YW7c
	Q/ve9anHvpvE3i1vRbfQVi5xxlI6gzmkPCmziXueGRCKajhCY4g5sfIiBcWBwmRC
	1ijKM5y3gk/y+Qx/YhvLLbdF+2exiExL08G4OrH8IrHgiQGkp8c4bih2+PJ/stI5
	APbgDW0FZ1mxmJm6zY/UvNc/N2OXkOPLYHQRrbUqKb3ww5UPG0eAxrY2SERmOlAs
	zpX+wqJHSuVPDBW/Z9hI7rwq0CmZOX7+unlNwYgIh6aPk/VTcNEWOXHhPM7DkfZe
	WUkBPvnndxH9wNjks7us86MpxeqodIpZFUUcPs68juRT13P4FUlLk8SqqcEJNwDa
	6B5ei2v0DbpRulH9iC+XFquqam6CjZoyHGHgoRs1hCS/vIocncPbKHceZmwt3XVs
	r2swZ54=
Message-ID: <ba0b3409-1cf6-4e16-8fdf-6d30b20217ce@prolan.hu>
Date: Tue, 8 Oct 2024 15:29:51 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.11 040/558] net: fec: Restart PPS after link state
 change
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, <stable@vger.kernel.org>
CC: <patches@lists.linux.dev>, Paolo Abeni <pabeni@redhat.com>, Sasha Levin
	<sashal@kernel.org>
References: <20241008115702.214071228@linuxfoundation.org>
 <20241008115703.801148899@linuxfoundation.org>
Content-Language: en-US
From: =?UTF-8?B?Q3PDs2vDoXMgQmVuY2U=?= <csokas.bence@prolan.hu>
In-Reply-To: <20241008115703.801148899@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ATLAS.intranet.prolan.hu (10.254.0.229) To
 ATLAS.intranet.prolan.hu (10.254.0.229)
X-EsetResult: clean, is OK
X-EsetId: 37303A2980D94855657D61

Hi!

On 2024. 10. 08. 14:01, Greg Kroah-Hartman wrote:
> 6.11-stable review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: Csókás, Bence <csokas.bence@prolan.hu>
> 
> [ Upstream commit a1477dc87dc4996dcf65a4893d4e2c3a6b593002 ]
> 
> On link state change, the controller gets reset,
> causing PPS to drop out. Re-enable PPS if it was
> enabled before the controller reset.
> 
> Fixes: 6605b730c061 ("FEC: Add time stamping code and a PTP hardware clock")
> Signed-off-by: Csókás, Bence <csokas.bence@prolan.hu>
> Link: https://patch.msgid.link/20240924093705.2897329-1-csokas.bence@prolan.hu
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>

There is a patch waiting to be merged that Fixes: this commit.

Link: 
https://lore.kernel.org/netdev/20241008061153.1977930-1-wei.fang@nxp.com/

Bence


