Return-Path: <stable+bounces-191771-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6234FC22EA4
	for <lists+stable@lfdr.de>; Fri, 31 Oct 2025 02:48:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BC36E4EA860
	for <lists+stable@lfdr.de>; Fri, 31 Oct 2025 01:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 535D7223707;
	Fri, 31 Oct 2025 01:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="XAB9vnQY"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC5E1F462D
	for <stable@vger.kernel.org>; Fri, 31 Oct 2025 01:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761875317; cv=none; b=G3F8eZlKSTtWotDNbDpPlAiVeAfzJ4D2HIQism4NiiPmnVMreQPxIh8aq1T85BdeQpe+LmtCRlQHzMXfrS6jTG468A7yAGkX2AvVm3GDRZ2i5BqB9pfupAJLGGBh1tGQ76lDx56BY7u+NENdsQJBQVlNbaKWgcRzhHM4b1SO2nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761875317; c=relaxed/simple;
	bh=CGQoH/JE7RMcpARc0jVV3Qw00UqxSIi0see9VSUJ5T0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rOJNYHcaxW/mysLgCU8LufYgQvekeuSaYtp/YBM7eN9gWuIvM4LOyY808AupiUSrSpYe+5xcnVlTJ44LrWjX5+INqG0fK8rAUnoE8OfZcqHX5tTgGgYZKSOHI84LX10pssyaiy5YI3z11OJsSJf3YYd9UExMmya4eqYoc39H9rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=XAB9vnQY; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-89e93741839so104073285a.3
        for <stable@vger.kernel.org>; Thu, 30 Oct 2025 18:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1761875313; x=1762480113; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5Nw7ZJvHJNNjuGTUIlC/U+5S3zQdlNMXANqVv6299UA=;
        b=XAB9vnQYsOIjtQK2Fj2G77Dc621PcYfLDJ2H15bSau7Fj6E0YLlvt5gj+ZN30HaAT0
         xZW7hEU28J0lYonxoiUkWahKn38dCHgYk/z+amSQb8wtgwUT1mBeQJPsKHJJd4teko+V
         ftOE2wSyVuECwNL2wGu8EXh4s4eXlU94ATUGreKMgyYvgHC0lwjL/5aftQXNAx8v5O45
         ZE1c3XkLJFeKDxcX9Fbckxtwy13LL1oV/0sIUjOnp4oVIqJiqBjRMDN/N+HnTwfLyA7T
         tq7ZQUn5mesYGQj0cbjyVUwHzPT0Slf+hKIzwgWc7h2lN4VYNpOMRBggg+2uJG7l3gNj
         kmJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761875313; x=1762480113;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Nw7ZJvHJNNjuGTUIlC/U+5S3zQdlNMXANqVv6299UA=;
        b=SfbFHTlyGFojLcDVr0zP9gzY2pJ42wrsMftnSAchci/kz7bWGyVUxhYsgbnZaTKW2f
         12tyuTNt0A33tsYxmBOXa+HSrp2GmN7vtm47ByrCGubBFTGib0MNnI6hTvgbPjj4IGst
         PixBKy1N8Wk/Lql/vDKa1BnmBl+3KeOuj2ASt1odjNURdCFIxQ1a2HqwbKr2vmIHGl+5
         off2G/cGT8fIYHGVsG0BzRmiQNc1C59J+rSpHqkhs2MEuUyOHXN2NWey8e5UP3ZVIReH
         ubrexH6cc0YLvObqEPreJTcCkmMe/BII9iYZJXz7hBDPHX3GsOTjS69py7koAnNxrY3l
         XvmQ==
X-Forwarded-Encrypted: i=1; AJvYcCXF75t245hxI6rySCgG98VNlCmvIEk5vl6c+6VNDYonX/OknA9NW/nEIiRxSY4HXutp3ak6dPQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmYS+PKtZpetk4HikKHbjv4KeClUEQHWY6VrsL503N/O8XrWkz
	IEKPpQJrXeL5dUIB/uYsvtTxTC5xtZ0vOWjsHXnKMwpYj8VznbkWHmxATG+kdnLsNw==
X-Gm-Gg: ASbGncs3N9VIumZL0yqPbQ1BHFzFZobgS52a5ccoEo9Y+83gG6wMn/EncFOmENBD8u5
	Xummd94dIWWkoSCjGBdyceqt24L6tBO045bm8/PtbTgdJ689bwsucbv1Md1rzVHCq+WFqgkT4YI
	VFcEqftMQmQzHHMqP65UwPV08uvnO2BeDTdrwG926xBbfmBM0mdILNr3az3ScuhL5hbg/AER1bF
	gM74U1dKFxJMT6Gek8JafKESrg4iVYZBRUuo7+3sqCoWYE+70ffBahiloTbdd6bgr/jVNEozxrL
	LHtivdS63z17YeoqJ0DKXI7DMX60yE1fnTNaegEcHWOH3try+SCFH349zZAfCKuTBCK5Y4ATWEP
	sYCqTjrbG/viZj9V+UhoEtAvsSl5nKjX6trEZa8GY1ZkrrTPPDSdJbmHeJSkPYBr7VZAq4uH91I
	KGsA==
X-Google-Smtp-Source: AGHT+IFPRF3nHMnMN4v7NDKYZrDBxuPNtmp9qyChBVjZlNRHuaz6ttavXZv9Tap/e+QcijC+0d5oUA==
X-Received: by 2002:a05:620a:1a1f:b0:850:b7ad:c978 with SMTP id af79cd13be357-8ab9b2b6238mr209085385a.49.1761875313404;
        Thu, 30 Oct 2025 18:48:33 -0700 (PDT)
Received: from rowland.harvard.edu ([2601:19b:d03:1700::db9a])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8ac02f85391sm19200085a.29.2025.10.30.18.48.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 18:48:32 -0700 (PDT)
Date: Thu, 30 Oct 2025 21:48:29 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Desnes Nunes <desnesn@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	gregkh@linuxfoundation.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] usb: storage: Fix memory leak in USB bulk transport
Message-ID: <b2ec533d-9f87-4d65-a20f-99488ffe56e9@rowland.harvard.edu>
References: <20251030214833.44904-1-desnesn@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251030214833.44904-1-desnesn@redhat.com>

On Thu, Oct 30, 2025 at 06:48:33PM -0300, Desnes Nunes wrote:
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
> v2: Use the same code style found on usb_stor_Bulk_transport()

Minor nit: The version information is supposed to go below the "---" 
line.  It's not really part of the patch; when people in the future see 
this patch in the git history, they won't care how many previous 
versions it went through or what the changes were.

> 
> Fixes: a45b599ad808 ("scsi: sg: allocate with __GFP_ZERO in sg_build_indirect()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Desnes Nunes <desnesn@redhat.com>
> ---
>  drivers/usb/storage/transport.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/usb/storage/transport.c b/drivers/usb/storage/transport.c
> index 1aa1bd26c81f..ee6b89f7f9ac 100644
> --- a/drivers/usb/storage/transport.c
> +++ b/drivers/usb/storage/transport.c
> @@ -1200,7 +1200,19 @@ int usb_stor_Bulk_transport(struct scsi_cmnd *srb, struct us_data *us)
>  						US_BULK_CS_WRAP_LEN &&
>  					bcs->Signature ==
>  						cpu_to_le32(US_BULK_CS_SIGN)) {
> +				unsigned char buf[US_BULK_CS_WRAP_LEN];
> +
> +				sg = NULL;
> +				offset = 0;
> +				memset(buf, 0, US_BULK_CS_WRAP_LEN);
>  				usb_stor_dbg(us, "Device skipped data phase\n");

Another nit: Logically the comment belongs before the three new lines, 
because it notes that there was a problem whereas the new lines are part 
of the scheme to then mitigate the problem.  It might also be worthwhile 
to add a comment explaining the reason for overwriting the CSW data, 
namely, to avoid leaking protocol information to userspace.  This point 
is not immediately obvious.

> +
> +				if (usb_stor_access_xfer_buf(buf,
> +						US_BULK_CS_WRAP_LEN, srb, &sg,
> +						&offset, TO_XFER_BUF) !=
> +							US_BULK_CS_WRAP_LEN)

Yet another nit: Don't people recommend using sizeof(buf) instead of 
US_BULK_CS_WRAP_LEN in places like these?  Particularly in memset()?

> +					usb_stor_dbg(us, "Failed to clear CSW data\n");
> +
>  				scsi_set_resid(srb, transfer_length);
>  				goto skipped_data_phase;
>  			}

Regardless of the nits:

Reviewed-by: Alan Stern <stern@rowland.harvard.edu>

Alan Stern

