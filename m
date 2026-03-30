Return-Path: <stable+bounces-231092-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IBOmIcpGymkQ7QUAu9opvQ
	(envelope-from <stable+bounces-231092-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 11:47:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ED7C33587F6
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 11:47:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4BEF9304FF87
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 09:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC8C13B4E9B;
	Mon, 30 Mar 2026 09:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UI9VL4lo"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D22826B098
	for <stable@vger.kernel.org>; Mon, 30 Mar 2026 09:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774863541; cv=none; b=hy0Oec34UKP3qPdq7DoIv4Ybf33hMdnslSjWEmmJ4XmmFHaxZjLLjMjno1e3Z1cSwKCPesTm50Cb4Q+1H8jp6Q5Cyx/8ElpIcwjL+LO/Mm+bjSPPLDSwGmkSfn8oaI45/GU1MmzCYFriTJQLaSkgeqenWBJAbu3KuatTa7v/N/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774863541; c=relaxed/simple;
	bh=MTNOj6ynMachv6R2Eweg4n7R8rKOuF6OM147NJPcIrw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kxpBVLQM51ZtyBUihBfArPzEQLymy83yzpVeCov/zjLLzpoDJG8E54O8JwLdnxq5XRUG2rvzoC0DhbIoa8J6v8EVL3OMyAlhG6SWek/V/RX/UEBJErShzqlP4kccCc7wySGAP5DDBw14gm08CdepdNyZJq5gvsGoGHcr59UjNNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UI9VL4lo; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2b0b260d309so118525ad.1
        for <stable@vger.kernel.org>; Mon, 30 Mar 2026 02:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774863537; x=1775468337; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vWT7ljauT3GJtk0p4Kr5YKMZTjRAnUxPGa2dI3sggKc=;
        b=UI9VL4loOJLQF6edE6XPUFh1w6L0oEFSu4ex7/dk7lhHJ8XPcSQyGGg0+wxdZtn1VY
         FewjK7+yQLoeYl+A9FpocOIfXY3pZznPubxLICH7GUMb1D2S4wEb5BQSp54JLSvICeJ3
         yvTYheLhKQGj82RAyShpQD0yE4E8ljw6viF7aLXIKFP/DydNQ5rLAt4bDRcKvbD5NDb9
         oFFEgFq+7l3K+3koqvYF+hBgNraB3KTc7E/Vt7ePS6IT3wANzsIGhsP204qI9HEQtoh4
         z6m/HTRVF0BWn70dw5KzakWTMDqRZE47GyoBDLSONSo7rWUiBo0KWs7K5gSnNXI7/veX
         Zi5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774863537; x=1775468337;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vWT7ljauT3GJtk0p4Kr5YKMZTjRAnUxPGa2dI3sggKc=;
        b=m18spI2dQ3qEWR/8gN3ZIJttVpO3aYM15HRwiLynW+RAQZcSsJnIz0rh8PZSwQIDdQ
         xj5G59PkONPaiV+NmKeh3LrsiXxmgFN2UcHkxaWo0OhSfV/HSQ9DluJPIZtRRhelp/fT
         F+EjcNSG7TAnX4602OvRP3XjIYORrIAxxfmwEqUaqAIPItg28RWYHQq6SbdngxgRGFIc
         uoYB/lG3tog6U5vvZq4vsQsiHbUBMb5Ux2PQsVK9bp/Q48zQzqQn2LU8JP5LJ2G0oLTv
         ugwYoPfzl0U/9w7Iw03mXqMHQ84URXrRl8725O99ZjCcMBQhW3UTSRTz2xCgniybC5kb
         kDGw==
X-Forwarded-Encrypted: i=1; AJvYcCXxR1AwPRSLztb+zw7ZoEvZkhrAT+RD0HlTTWwL+2bv/mezHIjt7fzOwRL60TZ2Oeb4CDlYOj8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCOep6Fn6WJVmdcs/IFOC4C9L2Lur1lJyqK+9eZ9OyNDfy6q3M
	wkCfCE5dtNxQKEs+2BknFnKmc2WQo0AFiTI3GJRVJTbrJez/KNR9V+lVnJiEaT5J8JxZlMGu0vv
	Kl0P5bw==
X-Gm-Gg: ATEYQzxzJdjS5F1RKItVtE+gSI8pNOH6dno2RNGJuuL+5dNxv1865fQ499s9g+jx9aV
	G+Rg7Rg94b8fkw6VldfkOy6rFKNbeT7zwYytyAM/HWYW7QUUCsYfzl/lOtwaF2uVAqYtwjMP1S0
	VqjjIR4LPMkOqgTBiQ7q5mysCWo5+dlhVndfjQZWlxiySCgis/Cd0sqKC8yAFIgd/f3od9iL6cT
	RH/PNf6IPrijc5tD9shzSH/chczRPqUMfEDrbZkzkF4BfWNIOTPTFvtsvvO0v8o2psz8FLu4a3c
	QJMIR8T2lNd4OPiEegvNaNTvYsUWpLkj5qdMVvQMqQXLOxRdJ3erlNVIOkfM2xzciJK87Z3lkhp
	HNSvOvZLBRL/p9gHsnoFSj6JgehrkRc6ZziuSkVNQtm822ni14vkVCYyDjXVn7euiFbzG0AcsuJ
	UtIeMIo8P8gSYK2h56zlu6BlXFWGxrwZl5VrlxReyc54TNbuxqtbJp3YaOs50/PVSfaWkM
X-Received: by 2002:a17:902:e54f:b0:2b0:b458:2dc3 with SMTP id d9443c01a7336-2b242d37d20mr493545ad.21.1774863536692;
        Mon, 30 Mar 2026 02:38:56 -0700 (PDT)
Received: from google.com (10.129.124.34.bc.googleusercontent.com. [34.124.129.10])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b242765b9fsm88519465ad.43.2026.03.30.02.38.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 02:38:55 -0700 (PDT)
Date: Mon, 30 Mar 2026 09:38:49 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Zhenzhong Duan <zhenzhong.duan@intel.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org, jgg@ziepe.ca,
	kevin.tian@intel.com, joro@8bytes.org, will@kernel.org,
	robin.murphy@arm.com, baolu.lu@linux.intel.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] iommufd: Fix return value of iommufd_fault_fops_write()
Message-ID: <acpEqc61YLOwrgzm@google.com>
References: <20260330030755.12856-1-zhenzhong.duan@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260330030755.12856-1-zhenzhong.duan@intel.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-231092-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[praan@google.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: ED7C33587F6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, Mar 29, 2026 at 11:07:55PM -0400, Zhenzhong Duan wrote:
> copy_from_user() may return number of bytes failed to copy, we should
> not pass over this number to user space to cheat that write() succeed.
> Instead, -EFAULT should be returned.
> 
> Cc: stable@vger.kernel.org
> Fixes: 07838f7fd529 ("iommufd: Add iommufd fault object")
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Reviewed-by: Pranjal Shrivastava <praan@google.com>

Thanks,
Praan

