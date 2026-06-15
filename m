Return-Path: <stable+bounces-263412-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id atxGKAg1MGquPwUAu9opvQ
	(envelope-from <stable+bounces-263412-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 15 Jun 2026 19:23:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F1B09688CF3
	for <lists+stable@lfdr.de>; Mon, 15 Jun 2026 19:23:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=hjEEIeAe;
	dkim=pass header.d=redhat.com header.s=google header.b=YgyBCN8r;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-263412-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-263412-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A138C30EA4FF
	for <lists+stable@lfdr.de>; Mon, 15 Jun 2026 17:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAE8C411695;
	Mon, 15 Jun 2026 17:18:13 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2947E4071FC
	for <stable@vger.kernel.org>; Mon, 15 Jun 2026 17:18:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781543893; cv=none; b=UDCafrEsiJaD1vqQGoD0UVDOiAyknAujs02D+bRzh8f15GduBvrrdqJHqD853H/J+S/Em9zx+0l1qa6wPABSX653YRj/JkBYyjr4+LSpseHJJJHuh9l2kvxuSRbpKLvppPTHK6qxupGbEaZ6ZP4PJL0/HWxqkSDjsgEaOLVTMHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781543893; c=relaxed/simple;
	bh=6MjK4Ekl6EgbuHurjrLkCh0S8WdwZwdwkLo1uggeUk0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aUyR7BII5Iu4ZeATHF7Vmko/6snaVeKj9ozpcw2SEV6ihAtqzFu0f9VzisvRZKv8qOggAU3k60yWgdQh/2sxFFUPHaawnPSdhHCcO2+9LbeAQZZHhJtvs1SN+gT4PCaHrmtCdoZNKyuv6QIQvfe8ClsomGum28UWPU6UOkgDkh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hjEEIeAe; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=YgyBCN8r; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781543891;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oZr+ycgvZUilxhhoW/bzv6nOUngq3yd4joV7dFf5q7I=;
	b=hjEEIeAeJim4/+7RWdVMN0u9XN07KW8mgqBuEHtQkSO6shWtkvBue+YBmUuBiWIQGC9f8Y
	zMmcjAoKr/cCfHUb3bfbyVE3ULBBHw+H4Mhc8Fe3t8VN4Vj3QckRWmeo/wU8TEgWqCL3wi
	3n2TSRaYTMaHxboQKBK+FZRzN8xODww=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-277-YoeR7lRLMZyiSMRnH1LcyQ-1; Mon, 15 Jun 2026 13:18:10 -0400
X-MC-Unique: YoeR7lRLMZyiSMRnH1LcyQ-1
X-Mimecast-MFC-AGG-ID: YoeR7lRLMZyiSMRnH1LcyQ_1781543889
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-51772325a64so47302971cf.2
        for <stable@vger.kernel.org>; Mon, 15 Jun 2026 10:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1781543889; x=1782148689; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oZr+ycgvZUilxhhoW/bzv6nOUngq3yd4joV7dFf5q7I=;
        b=YgyBCN8r3zHMlSL/SJ+pyavqbBJ9A1fxcVUkyrUzNxgEn8IoMqas5GxhTlryBLY8W4
         qQR+cwpgqHqPz9EBpOkxH/AvtrJ8OOHvMORiKNJIECXd6HMIFA9uk42cRP7/ybQT6jbh
         hewMQFmSDFE+l68yKEc7C0lbibXaW9Nyo+FMkxSDMvaIMvukFIuT6G/E2i0OA1doBDnW
         Tqvz+rGnOYd8dVHG0sU2spi4/23ZXGKI5xooSjCTXF4VI4ZEseD2VXqmwz8I3FDLcO1e
         7eS41HkBKXfKUns3g72Sf6/VsiRYWXvGFQz1gGjke60gN2ANEhXUd1Bf573GOYWO7Uzt
         TJCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781543889; x=1782148689;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oZr+ycgvZUilxhhoW/bzv6nOUngq3yd4joV7dFf5q7I=;
        b=odZwQwngCX3ilXQTWqGpARAPx5s9IbA6WtKFM9upppo0kZookkBxDAEhszSiza8Lq7
         QXgEZ6nVcNySAyxoz2SbWevRUszgXE5R0WTmxvVuPcQvBwxnH3Gv7GXSn6ak7VWNCy1o
         yxGzeGMOauss3GuAzTbbbUwHNSYpT9Y4DB9a+vlb5M9PpeHxQjSHc56u/FmwIluhH39X
         fyoImM0SGNvgh8ilBThV6hsABvYhbvzdDPINQDB2liM6mRHR4BVu6hS2xuBVlJSG2TvH
         aACizFU5NQGs8Neqh0dD1q8YKHtvSN3ooe7CSzF4dq7zfHhXr4ml4ZBQd4GIBEXigHAz
         L5Pg==
X-Forwarded-Encrypted: i=1; AFNElJ8AhNKPVF2cw2k4MO9075pvxBBUK8bfHv0Wpa0Cm+xH5lUaitZtNobd2PXCDX+iJ19fxYhKvrk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHxj+EDEih+xAxhC9p0kANdVWC2I4p8bHMKH1tRj5D0UVuHqus
	hPOl7jDqkdWaRA/96rD0FiZe7P7tgttIfEtA8jbNiVIaJeerOmlQAiwV/2J9GFnIECiPwDtHEjm
	abj0MjhNAkgNb8eNUrFsiK59JktWqnjcKCX1TU6CF5IuYCVHxZ7AldaTZ5w==
X-Gm-Gg: Acq92OHOe4Gl1e94oBAHPwjfGYCJ9U1KCedbNMcHZQBNIyOxOQPTGlADg52FB9SyOWS
	7Ou5oM3+xCkGE/0lJqZAIK3an3WRCvBr4qJe8cx8dM89C+kMYvAeytiVsECK7tbHOAdHyVY9XSc
	6nDPpOoQUGboK6TEyGrImDytlXUK7rwl/sAOb5ThDlN5WVAMBuzgVg9lC5HYQtOdNTyMc2etnir
	Ng6pOVT8c8fqhNPJRnaTH/cqvHvVzH+j9DvwOQX1X05ft1PlJUGLOS6IKjP9zw+tD69U04U37Zp
	ZGOwPyPRDGYDMUwAdflVM68VTXrX5Kui5Xe0YTKw07Q24XY6krM+VMG+d1qt3RjEdQy59DQ1K0N
	EciZWuaxG9GYHdvjPexxWud8gMbBY/zY7oaZf2tM94yQBzBZZ+HIRmk1D
X-Received: by 2002:ac8:5e11:0:b0:517:9206:10fd with SMTP id d75a77b69052e-517fe4f99aemr224740381cf.16.1781543889122;
        Mon, 15 Jun 2026 10:18:09 -0700 (PDT)
X-Received: by 2002:ac8:5e11:0:b0:517:9206:10fd with SMTP id d75a77b69052e-517fe4f99aemr224739901cf.16.1781543888617;
        Mon, 15 Jun 2026 10:18:08 -0700 (PDT)
Received: from redhat.com (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-517fb7a2227sm111888521cf.16.2026.06.15.10.18.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 10:18:07 -0700 (PDT)
Date: Mon, 15 Jun 2026 13:18:05 -0400
From: Brian Masney <bmasney@redhat.com>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: andrew@lunn.ch, gregory.clement@bootlin.com,
	sebastian.hesselbarth@gmail.com, mturquette@baylibre.com,
	sboyd@kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] clk: mvebu: ap-cpu: fix missing clk_put() in
 ap_cpu_clock_probe()
Message-ID: <ajAzzZQijess8tZf@redhat.com>
References: <20260604025115.3763823-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260604025115.3763823-1-vulab@iscas.ac.cn>
User-Agent: Mutt/2.3.1 (2026-03-20)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,bootlin.com,gmail.com,baylibre.com,kernel.org,lists.infradead.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-263412-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[bmasney@redhat.com,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:vulab@iscas.ac.cn,m:andrew@lunn.ch,m:gregory.clement@bootlin.com,m:sebastian.hesselbarth@gmail.com,m:mturquette@baylibre.com,m:sboyd@kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-clk@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:sebastianhesselbarth@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bmasney@redhat.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,iscas.ac.cn:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F1B09688CF3

On Thu, Jun 04, 2026 at 02:51:15AM +0000, Wentao Liang wrote:
> The function ap_cpu_clock_probe() calls of_clk_get() to obtain a
> reference to the parent clock for each CPU cluster, but it never
> releases it with clk_put().  The returned clk is used only to read
> the parent's name via __clk_get_name(), and the reference is leaked
> on every successful cluster initialization as well as on the error
> path when devm_clk_hw_register() fails.
> 
> Add the missing clk_put() after the name has been extracted and
> before returning on error to fix the leak.
> 
> Fixes: af9617b419f7 ("clk: mvebu: ap-cpu-clk: Fix a memory leak in error handling paths")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>

This calls:

                parent = of_clk_get(np, cluster_index);
                if (IS_ERR(parent)) {
			...
                }
                parent_name =  __clk_get_name(parent);

Can this all be replaced with a call to of_clk_get_parent_name() ?

Brian


