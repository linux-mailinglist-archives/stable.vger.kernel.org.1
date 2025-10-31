Return-Path: <stable+bounces-191935-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6634BC258F0
	for <lists+stable@lfdr.de>; Fri, 31 Oct 2025 15:25:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BBA5D351AE6
	for <lists+stable@lfdr.de>; Fri, 31 Oct 2025 14:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9B95346E62;
	Fri, 31 Oct 2025 14:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="EPfpt8ex"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C964224B1B
	for <stable@vger.kernel.org>; Fri, 31 Oct 2025 14:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761920722; cv=none; b=vAT+8FIQco7P69Ma6rdF4FqpuqpKqkzpHSmAh858Daf3bjujQ+h2o59KjnCEIl0RRe0gKg6u0o1oGIOd7htLEJ8GuGsKB33ykKmB4MRADOFuyDAloZ/wECq5w+ElyqJC/enzVEZ3SsJr1qlQMLcGGUeyB+Zj5j1mwTesg+LYETE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761920722; c=relaxed/simple;
	bh=5L76j+zuXHG1MHBpIZXuVQSIaQJX7GuLY5HJ6kmV/ko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dkq15k9Mx79czP5cVHTd62UWh7vDi3a7Jdw8hlyY6k8fR9xgvqKNiXpEvMN6Bzml32nbc+T9s7H+JOcvKAgIQCFySynHyYZXbSvNwDqxhcJhjBz4fHOYnu9WcJEweBeDoGPoWv0csboELeruVIjc9IIgEc4YX5c82wPu3uBH6WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=EPfpt8ex; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-880438a762cso858526d6.1
        for <stable@vger.kernel.org>; Fri, 31 Oct 2025 07:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1761920720; x=1762525520; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ts+XWgu1bIuF9gioKC8vzQc4NBdSlbXvz8mnrqcOtY8=;
        b=EPfpt8exaA/Bhwi+BUdvTAlmpUbJNWpxf13J70ussVRTkwzUSuj+1n/zGwt8YGhjmj
         eNdL3kPy3nlqfaiBoNTm24NYPOBFnvFaSvd79NbEaBx2e0Ax/U5Wi5qX9mjPgOyVGEme
         jSZR6TGqoE7FbFn9bJZSKg8y/KHK3usCLA9OPk4RXLRlDTdQXAvGH5QZwYOh1rm8s5Wo
         QAj//C1royiSJqNdmQ5iok5QLakMTPBpw2Vqart/aM+f0rpPFdIxe4EGBdrCzDv+evs5
         ylAHDydDoJ3bLy9mo3Wg+SR5M+gfv43tBzpRjG2KP5bVWiLshZBOVUtgbF+3fKvLkO9e
         pHuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761920720; x=1762525520;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ts+XWgu1bIuF9gioKC8vzQc4NBdSlbXvz8mnrqcOtY8=;
        b=ABSnHZg6BlYQUB33y/hOhBB8Uyu2XwLRxrbaWE11zvnBsSn9kG9dddVRcWx01DdKp4
         /rq9rajwdLT5kow8ZVRe819vxWQPc0WpATRkOVxPBj+e4SVKedQrLXrJR0sueWrdYlTd
         JsdyfM41DvuBByv5wzioPUqHJ5fhk+D7K18bc7S7rdB2bxZi0IQxxeY/kDbtHGyqwBH/
         PiL7aq/onT6vCb1MhPeXIyPcgz7af4+qTlKQbIA5JaOFo2NZLyPszQYTz9EvkIXsm6+E
         WCoR8Tlq0OkaVMlpchfVbBoKO3BOp5x7fSNn53bws2b8pOYrK9hLwk6xySwGJ3Ct8LjT
         2BAg==
X-Forwarded-Encrypted: i=1; AJvYcCVccil0urlor4d8BGf4Fm/n1Zs+5KvPhltEHyfySHdYA3GVA7qB7CjND59RP2hqDbr5Uqbnfi8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7dP/bN3qEz08K1aK96fo0ChQxTLxHxGOGeEkkecr+2fccUlI0
	7XyyhYiQgUeTUuueBu9EAjgGcF03gqmZhsWwxs5B+N2Y8UZKFxNrxJeATx5IXIDI9Q==
X-Gm-Gg: ASbGncsi5GUlgOJa+kBHTye06d/dPdMRXygTz6i8Lkjx4zYVgRJCnf7CNDAIzGkmQBo
	e61m6AyvoYT93iijKfHaEAyRCL0qgUvvg/MutV/cCRvNshll3uh0nucJT2lWQr/MSo/VNCBEmzD
	OlG9ICzMGjQqB1AkDGBe6gd/5uBQ2jo+T00+NWhXI5zYHcaXj+oWUcnfCUDbUSrwFG5lPbsuK2F
	gE6BMoLFQBb3Ee0lR15q7GtD2cCaATyiIMlktBIcdjUDzPoOyQBx7BVXu4AkXIv7paCsP34NjAH
	a/qR4SzoWmDv/N2xEB4arNfRZ1KiKWDB3/UPvitNSfwgxT590izHGsXMTVH6+0tmPAUUFQrEiKE
	4y7TB7uXYiqGgRXyVhf95pOykQLGyKGwiZxgdw9DQGwT01PQ4qCe9ItBmnBRoqKmYBpuqY1A482
	4nY5na0SJ3qTUn
X-Google-Smtp-Source: AGHT+IF6emX81maeXlXvNR7Q+/JX5uqsOM8FgN5qPjqjUpWdjdqPZE4LA+SysAtKbX+FH1pFta/gMw==
X-Received: by 2002:a05:6214:29c5:b0:87f:9f18:49ba with SMTP id 6a1803df08f44-8802f2746d3mr38802496d6.13.1761920719781;
        Fri, 31 Oct 2025 07:25:19 -0700 (PDT)
Received: from rowland.harvard.edu ([2601:19b:d03:1700::db9a])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88036070868sm12264306d6.24.2025.10.31.07.25.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 07:25:19 -0700 (PDT)
Date: Fri, 31 Oct 2025 10:25:16 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Desnes Nunes <desnesn@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	gregkh@linuxfoundation.org, stable@vger.kernel.org
Subject: Re: [PATCH v3] usb: storage: Fix memory leak in USB bulk transport
Message-ID: <697fe35e-a3c2-47e2-891b-c25861c95dfb@rowland.harvard.edu>
References: <20251031043436.55929-1-desnesn@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251031043436.55929-1-desnesn@redhat.com>

On Fri, Oct 31, 2025 at 01:34:36AM -0300, Desnes Nunes wrote:
> A kernel memory leak was identified by the 'ioctl_sg01' test from Linux
> Test Project (LTP). The following bytes were mainly observed: 0x53425355.
> 
> When USB storage devices incorrectly skip the data phase with status data,
> the code extracts/validates the CSW from the sg buffer, but fails to clear
> it afterwards. This leaves status protocol data in srb's transfer buffer,
> such as the US_BULK_CS_SIGN 'USBS' signature observed here. Thus, this can
> lead to USB protocols leaks to user space through SCSI generic (/dev/sg*)
> interfaces, such as the one seen here when the LTP test requested 512 KiB.
> 
> Fix the leak by zeroing the CSW data in srb's transfer buffer immediately
> after the validation of devices that skip data phase.
> 
> Note: Differently from CVE-2018-1000204, which fixed a big leak by zero-
> ing pages at allocation time, this leak occurs after allocation, when USB
> protocol data is written to already-allocated sg pages.
> 
> Fixes: a45b599ad808 ("scsi: sg: allocate with __GFP_ZERO in sg_build_indirect()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Desnes Nunes <desnesn@redhat.com>
> ---

Reviewed-by: Alan Stern <stern@rowland.harvard.edu>

> V2->V3: Changed memset to use sizeof(buf) and added a comment about the leak
> V1->V2: Used the same code style found on usb_stor_Bulk_transport()
> 
>  drivers/usb/storage/transport.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/usb/storage/transport.c b/drivers/usb/storage/transport.c
> index 1aa1bd26c81f..9a4bf86e7b6a 100644
> --- a/drivers/usb/storage/transport.c
> +++ b/drivers/usb/storage/transport.c
> @@ -1200,7 +1200,23 @@ int usb_stor_Bulk_transport(struct scsi_cmnd *srb, struct us_data *us)
>  						US_BULK_CS_WRAP_LEN &&
>  					bcs->Signature ==
>  						cpu_to_le32(US_BULK_CS_SIGN)) {
> +				unsigned char buf[US_BULK_CS_WRAP_LEN];
> +
>  				usb_stor_dbg(us, "Device skipped data phase\n");
> +
> +				/*
> +				 * Devices skipping data phase might leave CSW data in srb's
> +				 * transfer buffer. Zero it to prevent USB protocol leakage.
> +				 */
> +				sg = NULL;
> +				offset = 0;
> +				memset(buf, 0, sizeof(buf));
> +				if (usb_stor_access_xfer_buf(buf,
> +						US_BULK_CS_WRAP_LEN, srb, &sg,
> +						&offset, TO_XFER_BUF) !=
> +							US_BULK_CS_WRAP_LEN)
> +					usb_stor_dbg(us, "Failed to clear CSW data\n");
> +
>  				scsi_set_resid(srb, transfer_length);
>  				goto skipped_data_phase;
>  			}
> -- 
> 2.51.0
> 

