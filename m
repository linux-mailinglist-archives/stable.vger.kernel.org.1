Return-Path: <stable+bounces-233596-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2ET+NGAD1WnOzQcAu9opvQ
	(envelope-from <stable+bounces-233596-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 15:15:12 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 833F53AEE81
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 15:15:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 221473018BFE
	for <lists+stable@lfdr.de>; Tue,  7 Apr 2026 13:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD64C3B6C1D;
	Tue,  7 Apr 2026 13:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MTdbOMJf"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 433EC3B6368
	for <stable@vger.kernel.org>; Tue,  7 Apr 2026 13:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775567704; cv=none; b=OdA0OX+Y2PJjeblKjIWaLRQcdNq/PVmFXafe+CE7vkYkdO7V3fcTqXboIWk5fnDp3Ni/wagxjUjVuEqB3QByANukxGnwUQSfbmlpfZNsdbo3zasQ/dCxNg2GAL1YOZTXRwWMxnjnKzJaPEHcyJm6wlVc9O90Yy17waJACB6YMAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775567704; c=relaxed/simple;
	bh=DF92KS7lR8TG5SktVvEPsLa9rP8Xq/XSF2frVXwEcDQ=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=TGkLqUivUk38LA3reKRIu17ME3f/R7nuXKd+ooi0FcfhOapwDduFRZ6JOynUJBN91CuUTxpKpzIOn19xzyg5lMb0Gmza8+bitdtAJORPNAixu0iCymsh1sEAlCgTMAqgj4YkRHI7gjngxgEqOBnVVGiQNsaA86bDn0Hxzw6h8kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MTdbOMJf; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-43cf7c58bb3so171955f8f.3
        for <stable@vger.kernel.org>; Tue, 07 Apr 2026 06:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775567702; x=1776172502; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uJvui/baQIu/txwJ5Ha20q2FY1f9Fze38J+v8nYikoA=;
        b=MTdbOMJfQ535jCQ+aiD+tMAPmx/VsEXx+6Y0bcx0sIxiTol37cEMuxS6culODqZQca
         ishbncW9tdovM9HTjasVIE6hCKx17mnpVx6CBUttgtJJESn9EXe2Wf3ruwAmgq3dGn8E
         DUKLk89UtUZrcq8O9kgqKq51u7HnamzEgce9iIdh3NKsogWIEEVdpVw0oZL52uqdPsOh
         QJoEwGwXgK6Gjcg8gJ7OnfVV3i1yZNqtc/845lVodh0KqMhRNjYlOcsj2Ti70YYcgYxF
         vygk2WzLzi9ZmMi4bDgHRAh7NFwB60PCfIae4nuE78VYSMY+u8P9KPCNEChZi+6JYLDE
         VXDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775567702; x=1776172502;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uJvui/baQIu/txwJ5Ha20q2FY1f9Fze38J+v8nYikoA=;
        b=bCO1QN1zq6XddkzOSdSmFCCAZR3FK+e0FlJbL9M8/hYlzXwJiwCu65DM3+8Jx6n/+v
         4eNXJMpXmySB6WYGFpcS2WhhiWi0PXAYblDIO5p1eaPf4VUR6HZTjF7syhbLZzEGOxm8
         0NG/SaRBWvzsP8Tx3mKXQ3s3vpzSJ8TruhEhysJJdQTDELa+VOo2DxlrNdetXIXqrfAT
         tVn+WFQFjS42A1Ri7XMX5azsaflhiTeVzYBwLoYcwxa4KYEEdcptV/FroZ68JSajzTaH
         tqmpSDII9f+PmDprcktVwnF1yGVnOi2pZ5CFPYjYJpcQ07Zy+EhJI5MG1Wfp0QfPCx+I
         sIiw==
X-Gm-Message-State: AOJu0YzRJTiP2Dh4aqEQKUUft1w3EiOE2gP99n3TMbIgiySgo6cMgdGQ
	nuajzVl3t16AYvgNejMpP2mThm/EIW6zAPHjxl6EWEeR8C+VgKAeD6rM
X-Gm-Gg: AeBDiesTaGmwuLdYmeStTW8VuMcYcoo+w6ZyKGz5Ljzi+8PkZ2E1ttL4p9xAn2pCcjO
	eIn7ktb6xPhHWaSo/x3nLi1y1seGGYVyd8T5bBaWpUkQDmgf/r+x2gq79tbPEu+s3biRJNCf0TV
	yCcdXQpZnOYvOMgnzlH/81BdSMvtw05slJQC5yrU6pi+5Oh29JxNlhijH4vZe+vfiy5mpYjcgG5
	8cj0B5i8oQLB3sUy8RzKN2ymv8XbhY1z23GzYLYQux+1Jc2TsyG7xh007DZlVqaWpNeNpUmKeN3
	UQ/7G7eXG9x5Z/3vQf3NQ+tsf0juIo2zZqxfWLRhL0yNzwBoPd2JSZpZGnMBGCtDWCAMHgyJghm
	tu/40/fN17iC5+Or/mdqaoXEbnlYg1IO70hIzXMn6ULMzwX7HtOfqHWG6qlOgcorSCFtFxWCS8N
	rfp61PZAsf9IWU2VlsEbsydCSTF7B06VJGBQ0blIBFyaER34QQL48LZ/pnHKcXSpDAtQ==
X-Received: by 2002:a05:6000:26c3:b0:43c:ff6f:d5c with SMTP id ffacd0b85a97d-43d29262a74mr12097140f8f.2.1775567701402;
        Tue, 07 Apr 2026 06:15:01 -0700 (PDT)
Received: from [128.93.82.131] (wifi-pro-82-131.paris.inria.fr. [128.93.82.131])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e2a6f1esm47942710f8f.2.2026.04.07.06.15.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Apr 2026 06:15:01 -0700 (PDT)
Message-ID: <0746a585-710c-4bf0-b54a-41573d56a2e5@gmail.com>
Date: Tue, 7 Apr 2026 15:15:00 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Thomas Fourier <fourier.thomas@gmail.com>
Subject: Re: [PATCH net] can: sja1000: Fix pci_iounmap() buffer
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: stable@vger.kernel.org, Vincent Mailhol <mailhol@kernel.org>,
 Wolfgang Grandegger <wg@grandegger.com>,
 "David S. Miller" <davem@davemloft.net>, linux-can@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260330154236.98665-2-fourier.thomas@gmail.com>
 <20260401-effective-piculet-of-will-704d4d-mkl@pengutronix.de>
Content-Language: en-US, fr
In-Reply-To: <20260401-effective-piculet-of-will-704d4d-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-233596-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fourierthomas@gmail.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 833F53AEE81
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 01/04/2026 12:59, Marc Kleine-Budde wrote:
> The cleanup functions in this driver are a mess. kvaser_pci_del_chan()
> should only delete one channel, but it deletes all. It also unmaps the
> iomem, which belongs into kvaser_pci_remove_one().
I'm not quite sure because  kvaser_pci_init_one() allocs and registers all 
channels, so kvaser_pci_remove_one() should too?

> What about switching the driver to pcim_enable_device(),
> pcim_request_region(), pcim_iomap() functions instead?
I can write a second patch to do so, this would for sure solve the problem. 
Should I? I have no way to test it.

> When called from kvaser_pci_remove_one(), "dev" points to the master
> dev, which uses priv->reg_base without an offset, as it's board->channel
> is "0", right?
I think you are right, the normal path is fine, but not in the error paths for 
devices with channel other than 0.

Regards,
Thomas

> When called from the error path of kvaser_pci_add_chan(), things go
> wrong, and in the error path of kvaser_pci_init_one(), the pci mem is
> unmapped again.
>
> regards,
> Marc
>


