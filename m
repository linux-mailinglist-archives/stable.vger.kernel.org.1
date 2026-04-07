Return-Path: <stable+bounces-233713-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MM0JA8VU1Wkf4wcAu9opvQ
	(envelope-from <stable+bounces-233713-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 21:02:29 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 906B73B3239
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 21:02:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 96AA9301F31A
	for <lists+stable@lfdr.de>; Tue,  7 Apr 2026 19:02:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9B0F2C326D;
	Tue,  7 Apr 2026 19:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WtJt6pzs"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 540A123C4E9
	for <stable@vger.kernel.org>; Tue,  7 Apr 2026 19:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775588544; cv=none; b=hsooYE8XwDatljsC0uA1m/vzsE5H7v0pAoQi+30zNFbOSVsAUsPfLcPlcknSp2YSrdJpUNCoz50LeGaMalxvEVZocNvZs9OwFeeSHJnjjtgrLAtRtxylRfbyA+bZrtbF/TnYhhEeTyHFHUvA527JOeepcICBN0DAprWYOzOJNPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775588544; c=relaxed/simple;
	bh=A0dZxMKsbipHr+YmpPxr1arqOmaB/CImRgyj4hZWBZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dGHU2uFwHF5GpD+YdqGHm53Xq6AmeQZ7PcUj2+pG+Clv7r2j3nSmEiOtr0yikL1tir8CfOpVsRVo3rVTypXSgiLfPlv76pMRIzYwCYnUc6QvxEnktJS+/qCIM2+VFDTfCVs2yBGy4ZjxZoCGuyc2kGIxv1AZ5RAVCeKfIAUn4qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WtJt6pzs; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-488af9fdaa7so14713535e9.1
        for <stable@vger.kernel.org>; Tue, 07 Apr 2026 12:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775588542; x=1776193342; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SRNDi0acuS2EGtIgjauyvPjO7GwuUOFiV8WNTsIqSok=;
        b=WtJt6pzs5Gbz83gxDesHC+ElJ6rmks/QqhyxrGEr8J+2yp6pLYsj79tnZZjNzF2Ve6
         bcGZkojw/jf6exikiMebFrI6V5lTsa5J1ZgRBIkT8zxaF1/6OPlDoh3hr7Ya/WrQHbvY
         MMiefDGWZxFlHUKV/iUUwESFZoNqXL0S2Ha6I8kJJ3ialFQpUlruBQC/+at435K6dUnv
         Qj1nNoodK2maw2KO/vbKez2PS65/SaQ7A7w+fFwvC3ziXiWFQyUqvWBkqyDpGqlnf38f
         OVnjzCdPFjDJaAwFMCRpb+EO044eNWxM7RprdOA9RDUK9rQWlYxtOmdNvKcGbUjfjymU
         eBKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775588542; x=1776193342;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SRNDi0acuS2EGtIgjauyvPjO7GwuUOFiV8WNTsIqSok=;
        b=lChrKAR+XThC9F07b7tZcR/pbllflC9L4/VAx0nvUQXOibNBiDUNmyrScSK4QOasTm
         GX5d7HXJLI9P3omYTqH+gzrph0Zc20NgqgRgGAwOnPNyQhDeUGxAEG2IY+64Fs+61j+l
         b14bbQ9Ox5l4POiUZzyIg3X6rw3LCwbF2w0DAfL5Chl2sVVNEMgaEso6h+lNO/T1VsTK
         cW6M8A66hKFj2wFmRhPOf5b9zOmEH7GAuBV0crlPfkITfQ8Wj8fxvS2u3T/xt1FKs2Jn
         hZ44fqj0eh1bPu+kagXJgdH6xAGoxgiLxBv+o5osbjXKLQxkdc4l2pGS3Foa2x+wYLNM
         bndA==
X-Forwarded-Encrypted: i=1; AJvYcCVtfwfVCb06ekr7kj8dVHCN9RX7mufMzVTMu0QN4sP79noM15Z79/k57zYH/8XlIkTJCHWpn10=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzm8EfHOUdrFvLM2bNzdIck+VacZ+g9xwQSvkK0n3B7dN7Cn0IX
	NEZzkHXDQAf3uZ4xvPWaVXKNdPiXGTU6H7yxh7yDWzsm319lKQLoo3ffgz7M0ej4
X-Gm-Gg: AeBDievh8uXAHoBheEp1As5KT7+gWuZibTj/XxShNQEx8lZjXsX5mo9a0L5vNnaUPSg
	kYnc8yi4KE+sODeH/rlcrlvhDVBTa7AxKEDlVelhRwoe8LKYFO7+vmleyE6PiMuijUYRhBvFFLn
	3qzpOKnjBWj6aQuHTapaVPU7o3cgYlwysIr0R7kvhLoxUpbByYdlR0rLuIlegt6r8047xokyQzX
	Gp7py8cI8RZ4Lg+bqhdVasfzrZ1r+kktdGi+14nlVsysZuaEJ+lNnzUIeVJHBi80zSdVPK9NWpA
	c96zUbp8LuTeKxABroGawc8NoednVqT+YwktB/OuHEbKtjEa++1CCfvPAsJD6tAFkPyVnnuY8mU
	0Q1KIFbacP+GGW+DlaJsmEgyAT4uCyTzhRDY3QC/xOaMGRquTUv8vxf7tYtLpZQ2kBHr2jZGMKa
	1MGkZwxRoVqsbr9pwctvYs+QeaX+T3YUStRso0DLyI/iBq3j+H6gvWuu1wyNw=
X-Received: by 2002:a05:600c:8b06:b0:486:fdca:ea8d with SMTP id 5b1f17b1804b1-488997b7b3cmr252429445e9.25.1775588541621;
        Tue, 07 Apr 2026 12:02:21 -0700 (PDT)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4889f6843dfsm375944555e9.12.2026.04.07.12.02.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 12:02:21 -0700 (PDT)
Date: Tue, 7 Apr 2026 21:02:19 +0200
From: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	linux-security-module@vger.kernel.org, Jann Horn <jannh@google.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 1/2] landlock: Fix LOG_SUBDOMAINS_OFF inheritance
 across fork()
Message-ID: <20260407.c5bcf75b96bf@gnoack.org>
References: <20260407164107.2012589-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260407164107.2012589-1-mic@digikod.net>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-233713-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gnoack3000@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,gnoack.org:mid]
X-Rspamd-Queue-Id: 906B73B3239
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 07, 2026 at 06:41:04PM +0200, Mickaël Salaün wrote:
> hook_cred_transfer() only copies the Landlock security blob when the
> source credential has a domain.  This is inconsistent with
> landlock_restrict_self() which can set LOG_SUBDOMAINS_OFF on a
> credential without creating a domain (via the ruleset_fd=-1 path): the
> field is committed but not preserved across fork() because the child's
> prepare_creds() calls hook_cred_transfer() which skips the copy when
> domain is NULL.
> 
> This breaks the documented use case where a process mutes subdomain logs
> before forking sandboxed children: the children lose the muting and
> their domains produce unexpected audit records.
> 
> Fix this by unconditionally copying the Landlock credential blob.

As before, LGTM for both patches. Thanks for the fixes!

Reviewed-by: Günther Noack <gnoack3000@gmail.com>

–Günther

