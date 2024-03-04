Return-Path: <stable+bounces-25959-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F73187088F
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 18:49:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 110661F2265D
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 17:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2CCD61665;
	Mon,  4 Mar 2024 17:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pavinjoseph.com header.i=@pavinjoseph.com header.b="cyHehOvt"
X-Original-To: stable@vger.kernel.org
Received: from relay5.mymailcheap.com (relay5.mymailcheap.com [159.100.248.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12410612F6
	for <stable@vger.kernel.org>; Mon,  4 Mar 2024 17:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.100.248.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709574552; cv=none; b=i5D5aDtnTUG3TTR7lcwiQgAJX1ljp8LQbvSXU+oDFeEBICtKyek5D1F4m4ZhARFglV980XQwYabPL7dSm9PJXouZgrvTl4HfoIFEKWf10AMY0NDwXRaiHzE39UsDj3/m6cqRZBrY0mBabMV3QDa+Tf4NYx9ycocE8ARLkH/b4Cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709574552; c=relaxed/simple;
	bh=ccPdTJp3Uk6HHfgsE62VmoQ4mlajKldDF4M5V0Z/vPQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FQifMTY5OnaFai/LspSTsXyVOKj0/4H2Nq/hRzDu18vq8qjuTpgU0NIn3CGhkCIz7jpRB7DYuytKBwtUlbJk/5UQxYEk+gYH0I/N2apA+M363TDQCTPZ/JO6VxoKsY+8c0pj/Nrcw5GChQzYupod1eVe8JUptv4WQdBCqgmzjAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pavinjoseph.com; spf=pass smtp.mailfrom=pavinjoseph.com; dkim=pass (1024-bit key) header.d=pavinjoseph.com header.i=@pavinjoseph.com header.b=cyHehOvt; arc=none smtp.client-ip=159.100.248.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pavinjoseph.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pavinjoseph.com
Received: from relay1.mymailcheap.com (relay1.mymailcheap.com [144.217.248.102])
	by relay5.mymailcheap.com (Postfix) with ESMTPS id 40BF12615A
	for <stable@vger.kernel.org>; Mon,  4 Mar 2024 17:49:03 +0000 (UTC)
Received: from nf1.mymailcheap.com (nf1.mymailcheap.com [51.75.14.91])
	by relay1.mymailcheap.com (Postfix) with ESMTPS id 765623E875;
	Mon,  4 Mar 2024 17:48:55 +0000 (UTC)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
	by nf1.mymailcheap.com (Postfix) with ESMTPSA id 9715E40604;
	Mon,  4 Mar 2024 17:48:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=pavinjoseph.com;
	s=default; t=1709574534;
	bh=ccPdTJp3Uk6HHfgsE62VmoQ4mlajKldDF4M5V0Z/vPQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=cyHehOvtZcTpdq4ApFqOM+uNMHyZd4WqC/uPuAKz1tb6XfDTPgS8TB7NmwRZUF0ar
	 klZzZNMQKeYrrC6LhQ4kOJ0JLWUjwaUsHdZSe00gdsPvjrCgQFDEAfOJfqMpzDGNWB
	 7PKUQnnxMR9VES3/IPGvm0yydnoIki76eeYXtx4Q=
Received: from [10.66.66.8] (unknown [139.59.64.216])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail20.mymailcheap.com (Postfix) with ESMTPSA id 6AC684047D;
	Mon,  4 Mar 2024 17:48:51 +0000 (UTC)
Message-ID: <fe72c912-f1a0-4a53-88ab-b85e8c3f7bd9@pavinjoseph.com>
Date: Mon, 4 Mar 2024 23:18:49 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] kexec does firmware reboot in kernel v6.7.6
To: Steve Wahl <steve.wahl@hpe.com>
Cc: Linux regressions mailing list <regressions@lists.linux.dev>,
 Dave Hansen <dave.hansen@linux.intel.com>, stable@vger.kernel.org
References: <3a1b9909-45ac-4f97-ad68-d16ef1ce99db@pavinjoseph.com>
 <7ebb1c90-544d-4540-87c0-b18dea963004@leemhuis.info>
 <3a8453e8-03a3-462f-81a2-e9366466b990@pavinjoseph.com>
 <a84c1a5d-3a8a-4eea-9f66-0402c983ccbb@leemhuis.info>
 <806629e6-c228-4046-828a-68d397eb8dbc@pavinjoseph.com>
 <ZeO9n6oqXosX1I6C@swahl-home.5wahls.com>
 <f264a320-3e0d-49b6-962b-e9a741dcdf00@pavinjoseph.com>
 <ZeXzoTjki+1WR258@swahl-home.5wahls.com>
Content-Language: en-US
From: Pavin Joseph <me@pavinjoseph.com>
In-Reply-To: <ZeXzoTjki+1WR258@swahl-home.5wahls.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.09 / 10.00];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	ASN(0.00)[asn:16276, ipnet:51.83.0.0/16, country:FR];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_ONE(0.00)[1];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_THREE(0.00)[4]
X-Rspamd-Server: nf1.mymailcheap.com
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 9715E40604

On 3/4/24 21:45, Steve Wahl wrote
> There's a chance you may be running out of the memory reserved for the
> kexec kernel.  If you have the time to try adding the command line
> option "nogbpages" to a kernel that's working for you to see if that
> breaks it in a similar way or not, that would be valuable information.

I tried it and it breaks working kernels (6.7.4).

> My next steps are to read through your logs more closely, and load
> OpenSUSE somewhere to see if I can replicate your problem.

I wasn't able to reproduce the issue inside a VM (virt-manager, QEMU/KVM).

Kind regards,
Pavin Joseph.

