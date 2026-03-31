Return-Path: <stable+bounces-231498-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4N1PKXX2y2kGNAYAu9opvQ
	(envelope-from <stable+bounces-231498-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 18:29:41 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 549F836CA49
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 18:29:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EB3C630DA2FD
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 16:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6B773E92A5;
	Tue, 31 Mar 2026 16:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Qave5F0M"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 393743F7A8B
	for <stable@vger.kernel.org>; Tue, 31 Mar 2026 16:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774974326; cv=none; b=KaNgvYK7yvpvbFJ6KB3L3nURQLE1y1fWDLrc3bbtY3+TPOfuAkanAqed3RyBMdrQdZLDUmrct/TvHJ+FCqaH6ARa8bolvWQmXDFCfnQy2nZXjTwKHLgegFJmdKeYOw2bQxhSI9LcLISJhgAbTGpg56aMuFEGqNtRiutyidQ0aeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774974326; c=relaxed/simple;
	bh=5t1FqBMRuAaBCjDjDh+ZUpJziqPUYp8Eoc3Ac0ouYOQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D7eTmeQXkTFY/1BPWUy2rg6ua2au7IRNpK/nSjt6aTfnqDg36CD4J7ww3MSMN0AS8x5YFnD6FdqIPXydIkLgoiSU0WGPr7hGU3O4Qz39JgCYPg7YnGTMTC4fRHqvcjsSsLJDsMzBSs569e/uofv0E+4lJU4wIR4fe8gmYL4i0QM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Qave5F0M; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-8cfdac74050so771333585a.3
        for <stable@vger.kernel.org>; Tue, 31 Mar 2026 09:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1774974324; x=1775579124; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LsKEfazYLGr0lh88GcHa3cSE8LWBmMeMFJDl+wqwlHE=;
        b=Qave5F0MYWxj+yVPZddoN7Ee7x0ZZswMgVH23P6XzC2SvgI9lMlJkAUMFfHPH1Nr/i
         bByA6uPTqI9LVa5zdaBRwHTQ3/ep/wdMDmyh+oMTx8V2EgWd4M0nUFnqupDE6I6MaBpQ
         V9GnXaBM+NYQYGz84wPlvjfmkZahMDlQZYU6UJfyDSuj211v6dsiU124MZoZeTAaMHAS
         zhCPfVIQX7bWQVGFBy3+dvcR0aXlxZI70GTaaRj2taLfe8AaW1oz1p1S0Kvljiac064c
         WWQ/r1OcUykFCNy48+4q2HVPibPYxI1qnD1hXfPAgzmd9oQu/McPVltuCmUfOQK4CYRn
         NTfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774974324; x=1775579124;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LsKEfazYLGr0lh88GcHa3cSE8LWBmMeMFJDl+wqwlHE=;
        b=TcTuctqaJ0UKZPqfSFR48BRNfbkjT/gVl9nh2lYKg/wELu05NSD9JZOeBxfGMXGiSe
         u6LjIht8p6g8Rs761Qp59DMLeAqDEmJ5NCAFGujTU63a/GGnVhGDAJ7NjAuxHQN8QZmx
         eZND6WaF9y2qJyzbIMNKFoHjqI8tEPErN1hFsRbRH0YXoC5/Ix1PcXHC60EGDyFo0V4P
         tGbIKi3A4VeP01nfkKuOG6jatKbKlGRcBLbHc31wRWMTH53PBLgulHKxUwsQCNekodEF
         GBG8TK0NgAy0Hcm1vVnefggV9cFRo79DH4j/C5f9HGPEhrpqJCoIN3TCQyu1tmCDiwtg
         nbUw==
X-Forwarded-Encrypted: i=1; AJvYcCUfx8IZzMgVhWqeKzuKbGkRYHGbZDQ7Tu/q9iDRvTsCiFjdkGDNu3CmI/nsn/WUbwtPQUM1GtU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhLNMY0DU4FdMheOTfuhxMoBxZvhOBG/9DW8+VQKwcjye0J/GZ
	MMis3kWQ7uwb0HWXkanXlfIZlN8zY+wAMRwjziaPn6/1ZLlRdewNkCLTnbmDlADM28o=
X-Gm-Gg: ATEYQzxco72Za/frRR3aThRPUnHyfYNCQDhnF7IC8X8Rsayq5eKSGsFb4oSW6X055hz
	yp3fsYI3bByqJYEk8T93fpp5WF5QVK8QRXqMaIldxL275Ab4hm72I6Ebfo04eSvhxVogRHU7Sq3
	IwUYvR9RKxPY6W9LkwZArxmqgGbzoa9cTW88rfNuv/V3kfiiB9xg0cdTsp4I8O65LVGRkHq2+Mh
	oIGebBM1DnHCPDUQPJlRsoszn844urQtX2RIsL40h3UUu/hzhuwnPkfJ+9SK6lmApbY5HSq2ODr
	N8n3xkCxRnvoxiMzLCudFBPkNak/tQdnak4R3YwV0getZacaDwl+C727wI27zXZV3DgKsNjHALH
	twwb23SWTmm2c6TWvo8PHmwDpQUEIjDWtynI7h/cmPnKYyNAOXfl1q9NK09PMeyxhqgvmrdSXvs
	oo7DijoDnpVBdG4Thn0IWCAHik1sAv4mu8culVQUR7Vv9PPEpjH8LTGVTjFXX2YvacbkLZrg==
X-Received: by 2002:a05:620a:390c:b0:8cd:8d79:6c6e with SMTP id af79cd13be357-8d1b5c67078mr37101785a.69.1774974319269;
        Tue, 31 Mar 2026 09:25:19 -0700 (PDT)
Received: from ziepe.ca (mctnnbsa70w-159-2-73-22.dhcp-dynamic.fibreop.nb.bellaliant.net. [159.2.73.22])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8d027edb7ddsm881241785a.9.2026.03.31.09.25.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 09:25:18 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1w7bu1-0000000A1cm-2DKX;
	Tue, 31 Mar 2026 13:25:17 -0300
Date: Tue, 31 Mar 2026 13:25:17 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Zhenzhong Duan <zhenzhong.duan@intel.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	kevin.tian@intel.com, joro@8bytes.org, will@kernel.org,
	robin.murphy@arm.com, baolu.lu@linux.intel.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] iommufd: Fix return value of iommufd_fault_fops_write()
Message-ID: <20260331162517.GJ246076@ziepe.ca>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	TAGGED_FROM(0.00)[bounces-231498-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[ziepe.ca];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ziepe.ca:dkim,ziepe.ca:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: 549F836CA49
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
> ---
>  drivers/iommu/iommufd/eventq.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Applied to for-next, thanks

Jason

