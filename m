Return-Path: <stable+bounces-270125-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vi8eMVDlRGr+2goAu9opvQ
	(envelope-from <stable+bounces-270125-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 01 Jul 2026 12:00:48 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 856A86EBD2D
	for <lists+stable@lfdr.de>; Wed, 01 Jul 2026 12:00:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=mlLg6tN7;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-270125-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-270125-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8C60230621F5
	for <lists+stable@lfdr.de>; Wed,  1 Jul 2026 09:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECA09403B17;
	Wed,  1 Jul 2026 09:58:58 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C444403E87
	for <stable@vger.kernel.org>; Wed,  1 Jul 2026 09:58:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782899938; cv=none; b=kM3NBD2cIGvTL9ROgkyENjKhyttPDKOqW7UICP6X/0bL+Wjs+z/xoSNvjCWUD9VTNSRp5alx6Xxi0mOxYz/d24DdbNSpNizDAS3oOSqcTGHYhes9UBpyMsIOokGPfxKjh19LOyUnWPm4euPSOexBoWVcqgThiLAqUynoJsV8Aog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782899938; c=relaxed/simple;
	bh=v7yW10N5rdbaNr0AbgfvIKAE851swmfImkTSQtp0FiY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DRY7YxwT705v6sEljihnQHpDyjAugnnRxAnzt0Xyof2oEy2Ns4AbAqFAMMgWqrPhbW5mmPQg5eeIAo/sej06ETAAFhoeW6EXgdyrq8EDSJk70eRupTROnRJftavducK2MswpYBWj6WCZI4CqCn55DV2tspfWB1Lf6nDpLkPuahU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mlLg6tN7; arc=none smtp.client-ip=209.85.128.53
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-493b8d92a4eso27175e9.1
        for <stable@vger.kernel.org>; Wed, 01 Jul 2026 02:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782899936; x=1783504736; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7aPPO+1CYD+YBwvwpYgtZJkmXkRW2VjIt/FwgJ0T6qg=;
        b=mlLg6tN74O6CRQzUrm4inY4+UxBGv/bsVH6lXCQBdYsAsC28/bFRH2Q4uobIY+WmKd
         oV413GI6V25nKznPzDCORS+An95IrVWgghDeU4I/4soOgjvHub0Ml4C3wMqr+pVFo4/n
         Z/LBsKYFjItXy4eFKi27YmZ5MK2waGPN9hhCCk4Vy8j8wnIbrvXXi48AD7V3elwiwEL0
         g6q4wYM/LTKWV+wMScftHu9k6M58KCwURovjaUly3DQKtNp9/+qYcBAgpcWD4Bsp5sYd
         3NxNhRrdbCd5UgBb86Y7uTxDBJxPErAia6KqbNDEVpJfpueRJILKuSdVUSEElidPcSoR
         vnGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782899936; x=1783504736;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=7aPPO+1CYD+YBwvwpYgtZJkmXkRW2VjIt/FwgJ0T6qg=;
        b=g79uIuxpyiCCZ/dyRjUeI8Dqsok8GYDrXg9Wjd6ALhmqy99skKruVXhZVB3EJNrSxd
         o0eabyy+D9Jikp6LJixAdkLoWWkI3U1jf6u1F1VLZ7o6DCDob4irh8pUKCipNod4Au4l
         2h2PDYrTKdS2UO0TM95nI2NblvaqlOfpq6b/KHRNhjgsagB6bvyskqthi/VUP23N/WNX
         OL3vRMp8ktUuddyuBXIl/djCcVZX3lklNwGZsEdQNEc3lnmRfjUeBmKjBlxiqRsISnvt
         rD8fQDv4RIIbtnGS9osJFX1ZMSTDFStBuDy70V1EbfXUb6irWSZbKLuBYHmQqsw9n4yF
         x/Hg==
X-Forwarded-Encrypted: i=1; AFNElJ8kq+XAgNKazPWrv1sIBWyoza4UxzxkAiLihNHbs5TB4FzmNkF7TATVyO/S4Cq9UVirD/gd2xg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4os4PuJ4tEHEPNlHUQsts8OpAYkiT+whyRQcbs2esOPqoDxNw
	XQcKC+rDUnHABl6W6DtQ1ulMACteBtztBGPjjWMJZISQn5IfCfON+Bhh0JldtlAKgQ==
X-Gm-Gg: AfdE7clt+QbWP6K2fYa+BwsHhZXg0LUlTZsZ7et7CNJqQWxlMQGfuxjOZ2M3IXLvAqL
	hrIgQqvtcphUQUufLM4CsnQRGvK811x9lhmrJ4GRleXtZ9zM/6r+1xcIu20Nph8oUHEdrgkgvg1
	R9UkqGVQ7Dm/WimlvZ2COlwjfG+ZkIpfAKHb2+AC8oP01GN1hxApT1VV+9ikWcP6WfA6ojCgUSA
	y20K9gtcvBX3E/2dmWRzA0ryiiUcJJvMAoH/IcihthnsHpW7fiL+uv6K2Qp2SfBAmpdDJLPov5J
	+cGVkMHqAheshep9jurOzV85lmb2qMHyd3AnPxND7Pqh8MS8UZhe2YB+C/YbO3PzdE35U/2Sn9q
	I2FePvp08rZ/QArAJFmtVfOd77fdX4Z9tiAyXE1GBSNRl1ldt+KPv1K2+YPcLnmBfSe8KypNPKd
	Ez0yvo6waQTWWW3nFDaPM4jAdVsLICHTXuh3jb06N1QZGqiN2Nk3I=
X-Received: by 2002:a05:600c:22d4:b0:493:b47f:a24 with SMTP id 5b1f17b1804b1-493c0bcab48mr503405e9.6.1782899935171;
        Wed, 01 Jul 2026 02:58:55 -0700 (PDT)
Received: from google.com (140.240.76.34.bc.googleusercontent.com. [34.76.240.140])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493bef17c82sm31881885e9.1.2026.07.01.02.58.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 02:58:54 -0700 (PDT)
Date: Wed, 1 Jul 2026 09:58:50 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, robin.murphy@arm.com, jgg@nvidia.com, joro@8bytes.org,
	praan@google.com, kees@kernel.org, baolu.lu@linux.intel.com,
	kevin.tian@intel.com, miko.lenczewski@arm.com,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	jamien@nvidia.com
Subject: Re: [PATCH rc v7 0/7] iommu/arm-smmu-v3: Fix device crash on kdump
 kernel
Message-ID: <akTk2uM0Kat4Jvrg@google.com>
References: <cover.1782799827.git.nicolinc@nvidia.com>
 <akPB6l-fuJUcg4a2@google.com>
 <akQYpCdwGnpKTnjN@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <akQYpCdwGnpKTnjN@nvidia.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-270125-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:nicolinc@nvidia.com,m:will@kernel.org,m:robin.murphy@arm.com,m:jgg@nvidia.com,m:joro@8bytes.org,m:praan@google.com,m:kees@kernel.org,m:baolu.lu@linux.intel.com,m:kevin.tian@intel.com,m:miko.lenczewski@arm.com,m:linux-arm-kernel@lists.infradead.org,m:iommu@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:jamien@nvidia.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[smostafa@google.com,stable@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[15];
	DKIM_TRACE(0.00)[google.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[smostafa@google.com,stable@vger.kernel.org];
	RSPAMD_EMAILBL_FAIL(0.00)[smostafa@google.com:query timed out];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 856A86EBD2D

On Tue, Jun 30, 2026 at 12:27:32PM -0700, Nicolin Chen wrote:
> (I think Jason has answered most of the questions here.)
> 
> On Tue, Jun 30, 2026 at 01:17:30PM +0000, Mostafa Saleh wrote:
> > For example, patch 4 disables the EVTQ to avoid events as there might
> > be a lot, why are they not fatal also?
> 
> FWIW, the PATCH-4 doesn't disable the EVTQ: EVTQ is disabled in
> kdump case prior to the series; PATCH-4 just makes sure it won't
> get enabled transiently.

Yes, I meant the patch disabling it even transiently because of DMA
faults, which was confusing to me because I though they are fatal anyway,
but I see Jason’s explanation now.

Thanks,
Mostafa

> 
> Nicolin

