Return-Path: <stable+bounces-230453-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eNHQEjUjxWmC7AQAu9opvQ
	(envelope-from <stable+bounces-230453-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 13:14:45 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B1A513350EA
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 13:14:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D51883062410
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 12:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 342B83F0777;
	Thu, 26 Mar 2026 12:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="oPZJKLSG"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93DD138F929
	for <stable@vger.kernel.org>; Thu, 26 Mar 2026 12:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774527145; cv=none; b=DVurJhHU+ETt7JOwcW2PMkVmdVhaAZ2DCAGswRRZvnnobynzwpAu3eqve1YFDxgcIZ6r+dyPCbqawNefUj2yGOSLtVvfPpnA3msPe9lTz0apcEmO1w3VsPjuQC2aQwOzAK5zirwFO0q2Tb4XWMv6/Yec+WWoHtdvrImOaqo1QRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774527145; c=relaxed/simple;
	bh=3ldpM/1Nn1J9v2DDBv/PiC6XkAeKsSKc8aJ9GttZn1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=umGi+OoL2eazHxgcYw0fKgPIYfUlQeNdgBSa3ADQFUWKnziQtVzKSE08ZsSzxySJxDpHjaLkU93iroDyve4jUAJfomvj3MDJna+vXVoH0AolXxbeiBYkxHc9ilir5kiuvwcSLIeTNFI8dhMpBRWQlp1uMpEpZH9TbIhCdTh5YCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=oPZJKLSG; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-8cfc795ca97so87302885a.0
        for <stable@vger.kernel.org>; Thu, 26 Mar 2026 05:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1774527142; x=1775131942; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TOQcKHhSbpnRXlvxZdOJhqpuwk1wdptQ8/fVLC7kjw0=;
        b=oPZJKLSGqle2AKFXsmp615JnYjm0PYz42wtIOelUmoIfRLhFj3Qc1513KNacTLmZdW
         oI4lncJOfn//9pAuD5IXmNnyrIf2Zwf1uwlPHH04hayZqqYKd+bnoFYq9z1zIsA43F41
         7+ka9df4ohPSROrbRI4UNHlhjPkA3UklltGoprZYOjAjfdNwwvRIXG+bojNuU+Z6TuAK
         TR8EnMI5chSBO7zI6ehwbmkcb+WX0nQUtRPDc3qBIoGdKeHisyHiXv4oeQpiS19adkth
         JLNE5P51h1ucDjkZ5kwBjhnw+yfRpmeG46cplq1aaYUz+jDKHpVgwrNOt/PYZjZM8v8P
         a5YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774527142; x=1775131942;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TOQcKHhSbpnRXlvxZdOJhqpuwk1wdptQ8/fVLC7kjw0=;
        b=k6iIVx3dAKP9ktaRI+yDa6afQVZhkj3VTxpUSyM8OGCChA2r5mD7Ojg91FNrnAJa/Y
         ezf9kWy4KRGHuu6vWhS5YjTp85C64vybc10cWJKhnCbRl/eE1FCsns7J3X2ZxTCZ6s0T
         zd12J8xH2DcekZHcDLVEG/5HNk3e/WOaduhHu0xq1+UFsLEJXjqv6JmwgbTubXc8sOY4
         vYjhX5TPG1UHvrOaZYybA2r5WMjcBnRrhfsVr6bzWeLR7yGmC6lzP4pt2e0kz91CS+rq
         HK/TaOVxbd5ZbDRjrLYHTvWNBbl4TsxkqAW4Mm5EEwqqNRTjPPrcbVh6tB3vY6mic2La
         CeEQ==
X-Forwarded-Encrypted: i=1; AJvYcCUqfgB+VrPjs67cULzbOgI3tlWUcQDFj6xIXNj2Qq5JCezOgJxOFnrGYnq7k+eblG5rU0yTKvc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0Iht38zT8mpy5sQAKA++PCJxXrGaq7Re5tqY/bUPMg9eTbPQX
	GI8gL9j02GPSpMKuJh94CzCUBj3+JeTrM+4PIuh4cY3IS5hxQfxrl53E/rIh8BHLers=
X-Gm-Gg: ATEYQzzXZeiFpjY8S5h9ayAgCH64wXEAkVqfdEdPslgq42xQaOC5e/6clIyBIjZYLcq
	FmBRoPD4j+MIt7K66JsQyokJwVye0W6ryj4GJB6dKS3mQEkxuH2y2QMqCRKmvFFp0mkPGcdIDEo
	r7uROS+eJtBDsFUolCIfxeUqN3I+I7aBLZn+lO3kxisXrsRJhIwoMLNhuiU+THL/3EESH2Jrge0
	v9UuF/lE8/xCBxVj4Xle5XFGcsegZcjjYZw5fENUkOm/QeMyCrdspTfhg5zuciy7dSXUC/32qmh
	AzDWqyXWWxJNNoXFJjMc/CcMhCjRfa7+yiA99rL7PSLBiVjNr5hPySQOsMQUkbmWO9r2nWyQRVp
	RP3vZaJlpDhOH0rJ9gv2Szd8R2gwdgIGy5fxNMP/uwE6wUcrL2N0GJ/2ByQ64OfmihOgVa/IA7h
	2E/frfABxSz947EPT5KPnUO2Na2DtwUmcKBIYSdEWuSwYPwTlrwxnxCnHOJ8Bmk/FD3IIlaA==
X-Received: by 2002:a05:620a:44cd:b0:8cf:c877:ed1d with SMTP id af79cd13be357-8d001092beamr972621985a.69.1774527142407;
        Thu, 26 Mar 2026 05:12:22 -0700 (PDT)
Received: from ziepe.ca (mctnnbsa70w-159-2-73-22.dhcp-dynamic.fibreop.nb.bellaliant.net. [159.2.73.22])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8d00e4fa7d9sm237271885a.32.2026.03.26.05.12.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 05:12:21 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1w5jZU-00000000mo9-1zIg;
	Thu, 26 Mar 2026 09:12:20 -0300
Date: Thu, 26 Mar 2026 09:12:20 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Alex Williamson <alex.williamson@nvidia.com>
Cc: alex@shazbot.org, kvm@vger.kernel.org,
	Renato Marziano <renato@marziano.top>, stable@vger.kernel.org,
	Leon Romanovsky <leonro@nvidia.com>
Subject: Re: [PATCH] vfio/pci: Fix double free in dma-buf feature
Message-ID: <20260326121220.GH8437@ziepe.ca>
References: <20260323215659.2108191-3-alex.williamson@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260323215659.2108191-3-alex.williamson@nvidia.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230453-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	DMARC_NA(0.00)[ziepe.ca];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B1A513350EA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 23, 2026 at 03:56:58PM -0600, Alex Williamson wrote:
> The error path through vfio_pci_core_feature_dma_buf() ignores its
> own advice to only use dma_buf_put() after dma_buf_export(), instead
> falling through the entire unwind chain.  In the unlikely event that
> we encounter file descriptor exhaustion, this can result in an
> unbalanced refcount on the vfio device and double free of allocated
> objects.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

