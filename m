Return-Path: <stable+bounces-191948-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DFDB4C264D2
	for <lists+stable@lfdr.de>; Fri, 31 Oct 2025 18:13:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D58AC421E55
	for <lists+stable@lfdr.de>; Fri, 31 Oct 2025 17:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BB9C302144;
	Fri, 31 Oct 2025 17:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="AC+KR0IZ"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66368264612
	for <stable@vger.kernel.org>; Fri, 31 Oct 2025 17:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761930540; cv=none; b=j0Z7EkdyULs78YUWaJkHbhOPPTa4f639itoBxq1rqQU/pU69b+CQoIB/8SD2SLFliIjhAaOI1XofgJkZXmX0wxsFXzsrplPgLrutXzGBWxI1cgtl73IlxnjFg7g7SfOFtbJVfRboLzQUy0wAS/IFsCvRMevhA+HHe3NV4W5cULo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761930540; c=relaxed/simple;
	bh=+i8ZQoycELSQ103UOhO+mdZBcfAiIIrnA4J6dDV9Rf8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gCE36SNt+w1qpm90WHWnv6FovF5y7SRI4Y0LKLfHx7iJbw3cdp6TtelWib7hpNJSDAxLavXYXvtgByALoImImeD6Xth4G9priYacNzo48GFM8CM+XnS8mKSRm82x3sRECWBmhQuNqqF/K1lCWj9r0ocD0PQSetFSbU/uztNbv+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=AC+KR0IZ; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-87c1a760df5so42501146d6.1
        for <stable@vger.kernel.org>; Fri, 31 Oct 2025 10:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1761930536; x=1762535336; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RBTAuVS/sQ3VXQZHeQmZFPYxDEAuSifyHPnjgyaRJZ8=;
        b=AC+KR0IZfRGme+akB6A0fwMMIQFg4vdjSSOMlJbqdk89PL/G7m1abGKO7O/6hIwq2J
         ApoJ4nvNKi+7RiC8ivdrQmFmf1UIG5GKipNYB2rRdynzkZTiwHfMQc11KCvmGM8Bf4He
         9uDU3pVbWOqDYu2TGuii3C8aEo9/VxlIRDkwTFlQYxvbs4jXeU2rY4sh1FdDb7xJrZTM
         CHj3XQqRBsAPplzoGnUO3HovhH3Igw7CMCGZ4H7hCZ2zDpfVEVVNefvEUkNUZekneX8A
         SxpGEraPvKN7JaO7GWIhi5dAIkEX6or2y8OjNFViWkx0yU7wK8o04uQN6p/yI2qGOVWS
         BIqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761930536; x=1762535336;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RBTAuVS/sQ3VXQZHeQmZFPYxDEAuSifyHPnjgyaRJZ8=;
        b=kipjS69COUJtiJc5hLhpnLhiFtanCG8+s2nxGeS1oxxMFddUc9ypvCWAkElcWkE5Ro
         vPc3IaeMId8sG6jXRmMnPTphNpbHiyXRw/oBW6vAL46kpAYJqGB+IzVjEaqBt4Q4GeJF
         eeqc1qdCFrtF9xejBrlarw2Zu92gtuxmiD76CNhgP0kZgUaHaXMWBDMqkq6AyjwaBpEK
         aZN5XfPZxcZaU1BupEYSXxNOW98ytyFSKytit1EvmKdGe0oJW3/91PqlLEjhDRaKLYK/
         YQzobEvPJw/tfsJmCbw/H1YJpZF/Z8RVLGfEm1V49fRRtwnpG6zeq/L9mRMkFnmNptC8
         xtLg==
X-Forwarded-Encrypted: i=1; AJvYcCU7lBzbV5I4aXVCBN9hHSDhAF34HuORcgnDvyCgjJQmarVo1/vMMXGxvTojDOxpDfZ7FUOlIqg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzjbn/5Llhvqul95HsD4UkXTTHz5tVIr6Ucsr/9LYayn2g56bNM
	o0lgLORwVV64V5jpTpQ//J0lgCLxEdG5OsuiC0WzEcLJRgjvnPN2AL4tfMnwFojxqoE=
X-Gm-Gg: ASbGnctR0IZlo0ZCVyASCV07dqG1tu1LFvPbmgEBiy/BU+VwpZ6Fin1H1SwMA3upleD
	q4KFwECD53kL01wRVx0WLYIvqAxFXBSFBKwpOd1GVQlm1kIUN0TZza8IvO9Xl3ZhgaPEjn5iS4S
	uVVaPLobvCceFvvnvF0BEbOOBEV8t1ZVgX0PFollx5GOz0CSXRfZNzy3YixgD9RlVzzmhIWcbrU
	P4B6632dUmPtYb9JvyHLvCikr0/6Xp9O4UXJCdaH+TG9ApNlS0MMAqwGvZ02dZr5kCkvEuOtx5O
	e3KDSDfRyffxWcZ5VShQxzwmDILDHdDLxYt77yuSpVOG5tuMhRiFE9ChxYdikHU7sIX5Bd9nzLw
	6Be5CoXXF0B3hWtmqD+9Yn/pdt41ivcLNKLWR9vNyLp1YF/fe9sgdGWf+Dj+35e+TIUwi7lCWB2
	2xlHFPl9uP0fmz9VITx7pq8CUFh5+Ifsod2e6oWtb8aQbciw==
X-Google-Smtp-Source: AGHT+IGG5ZGx6z+RQHh9WYWUaZzZke4tiLtpbh29MnMDJ7MHc4q2Mxi4KBypDwpLY9ZKti48DkZCFQ==
X-Received: by 2002:a05:6214:246d:b0:87c:16e7:892e with SMTP id 6a1803df08f44-8802f4ea951mr56300486d6.62.1761930536323;
        Fri, 31 Oct 2025 10:08:56 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88044879326sm2392456d6.32.2025.10.31.10.08.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 10:08:55 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vEscR-00000005mGA-0THn;
	Fri, 31 Oct 2025 14:08:55 -0300
Date: Fri, 31 Oct 2025 14:08:55 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Raghavendra Rao Ananta <rananta@google.com>
Cc: Alex Williamson <alex@shazbot.org>,
	Alex Williamson <alex.williamson@redhat.com>,
	Longfang Liu <liulongfang@huawei.com>,
	David Matlack <dmatlack@google.com>,
	Josh Hilke <jrhilke@google.com>, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 2/2] hisi_acc_vfio_pci: Add .match_token_uuid callback
 in hisi_acc_vfio_pci_migrn_ops
Message-ID: <20251031170855.GE1204670@ziepe.ca>
References: <20251031170603.2260022-1-rananta@google.com>
 <20251031170603.2260022-3-rananta@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251031170603.2260022-3-rananta@google.com>

On Fri, Oct 31, 2025 at 05:06:03PM +0000, Raghavendra Rao Ananta wrote:
> The commit, <86624ba3b522> ("vfio/pci: Do vf_token checks for
> VFIO_DEVICE_BIND_IOMMUFD") accidentally ignored including the
> .match_token_uuid callback in the hisi_acc_vfio_pci_migrn_ops struct.
> Introduce the missed callback here.
> 
> Fixes: 86624ba3b522 ("vfio/pci: Do vf_token checks for VFIO_DEVICE_BIND_IOMMUFD")
> Cc: stable@vger.kernel.org
> Suggested-by: Longfang Liu <liulongfang@huawei.com>
> Signed-off-by: Raghavendra Rao Ananta <rananta@google.com>
> ---
>  drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

