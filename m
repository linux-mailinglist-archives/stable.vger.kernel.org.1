Return-Path: <stable+bounces-238236-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +OKTE3Yt4GmldAAAu9opvQ
	(envelope-from <stable+bounces-238236-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 02:29:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D054B40947C
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 02:29:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5C85730F674F
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 00:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C937C1A76BB;
	Thu, 16 Apr 2026 00:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="f+UuA9+c"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45815198A17
	for <stable@vger.kernel.org>; Thu, 16 Apr 2026 00:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776299146; cv=none; b=en/tDeLGZZi6gpAokbSI1t1P5MJZPgHwPNzrg4yu7sw+zTmZY1MR21fgnUzZzLULS+3RMdYFzJJ8F1LMVrw+uRMnbsIQW25yf14keIcGAZ+5alOl/mRKdIA7G1FQAh1nhGwcRw/XW1pxllVijmvLJkgfj4BALPXGhJAtKGqTT3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776299146; c=relaxed/simple;
	bh=AXyNXjDfVtCE0ZrJX0GJ8x2yqOZGd7+QRmcScIvKqZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UrxKejv19RyzXoeXr2zR1jEnbvHvofyzZRwIuSc4hQA2R47B0b8Z217oASSG7jiiNkNJmHilTGOfRTiCsHmZFAWxM35NKIViJ0U9dYrWGEybV7xTtrP04fmZSL6wh3T46hGbNmghMhOpXtt5lYLBIz5bfgM0Gdm9YzBil2dnDMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=f+UuA9+c; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-488b8efed61so961525e9.1
        for <stable@vger.kernel.org>; Wed, 15 Apr 2026 17:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1776299144; x=1776903944; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AXyNXjDfVtCE0ZrJX0GJ8x2yqOZGd7+QRmcScIvKqZI=;
        b=f+UuA9+c0xT+BHjeYoCfkIMu3defE5bzqQgNgayWkEJZ034Y7uKMKXw/wYmB0tQj5f
         Q/p0pBK63nCtlV1o0MrVzUZ9gis7HEcopv+TiKA7lDMwbcRSuYJLCIxGmT+o9qaz4mtm
         z4YnN+DG34KKEasOnX/Iv8COGepeP1DyILPNM/EDgbM9l/uqqsWQYehnCuDLsBuAKrhE
         ZafwX3FWgMTrOjtU1p1Mslhv42vebdtaKm0OWSS+rnMwqwAT+az4EF6ghljSOhX6nDSL
         akJVnmz697ub7ZkRfDqwSWnXOXM22BPc3zhFV3CnmUvvQk837dWLCnfdUQnWisD+RSNW
         TGaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776299144; x=1776903944;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AXyNXjDfVtCE0ZrJX0GJ8x2yqOZGd7+QRmcScIvKqZI=;
        b=a1z4WGZcUSqOO6qzNM8hwN9k58vFo09OCSLmgPZIy3I9WlHlKB1wF+upmcPWK2tTrN
         KqZ1829CY3Tmca1uPCiyU1Z5e+5EY+gFbSmuDk8HF4M4/lXD0a1QHOPNHFihxTLCERNX
         iV2/WEuS7fvWqYgVGP3dluCqPCEvwc1YfqrLZ7wDsND1V/yzrdJA5T961L34AZ8+V0p9
         lrbvor2d9s3G+UuZU/EsuC77KR/ev40g9EeHhSEsj7CXSIXP99frXhrVueEeMgeAbqNX
         GB6KJTkDO3ui4HkQfhexwVYWLoEnqtbubceh73Yn/jFtJchfrJv09dC1CxoZUyd5mUYZ
         sVvQ==
X-Forwarded-Encrypted: i=1; AFNElJ/yRhpbdwRMlUe2vqpRtKxstrepmi9wrUaK4h59IiWvb10vzUIDyDsJoFCfjrtTtMz15AKqxXo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlUJtW+Wdo9CwBzULPESjr4sl6uOiearpotbfH9wCW3qqou63P
	kmXYrJFB7hcUiChXGM+bIF22T+YP2/T+EsvTxrP5kpPRgU8RIZrMdoflpzCPdE3eOaQ=
X-Gm-Gg: AeBDietQm3HaqHLkHz5BzcvYQDdCjHboei9XT7W0ofUBFTa1AcLSCiGSUx0VbilGm7n
	qmOufroJ3L8B3Y3ic1EAa+bZVH/3T+C9p5anuJ4Lyctyh2/Xd0AjPfDcM0rGVWBPS+HfVn09YzU
	kWpd1Bt+2lEM71VMIw/zVqwKvTl0ngSBZ1k0HzQzT5OwZmkAf8ZEoA3fwc+XVfCUmMfUw6QEtMy
	PkBXIx/weQbDrGciXueWi+zpQWJktNao2eR77c6uAwxZG+q4NPj9kr3emMCmrGC3YnpKq6B8hVD
	bfGWSSD+oKkbJ3Wq5OoC8pmyHd1B9S0iafpMJ5vrVJHR/7aM2QNMYuHNK2Z2aXiM3wi8XYv78bX
	DPSdFijkZxnLOsQhCSAmF03/KmbhPD2z+P3Sh2omcGSUGt3mkefz+NOcsGHYnYK3F7X+03n41jv
	dv8uOjxbSSrOS0416tKYe60ohBfMY+xyesIbbOHG2G2Q==
X-Received: by 2002:a05:600c:a101:b0:488:9ec1:4976 with SMTP id 5b1f17b1804b1-488f45c6406mr15939765e9.8.1776299143583;
        Wed, 15 Apr 2026 17:25:43 -0700 (PDT)
Received: from precision ([2804:7f0:6401:5290:433e:afae:f475:c9f7])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c5e62b9d1sm4019937c88.5.2026.04.15.17.25.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 17:25:42 -0700 (PDT)
Date: Wed, 15 Apr 2026 21:25:36 -0300
From: Henrique Carvalho <henrique.carvalho@suse.com>
To: Werner Kasselman <werner@verivus.ai>
Cc: "linux-cifs@vger.kernel.org" <linux-cifs@vger.kernel.org>, 
	"sfrench@samba.org" <sfrench@samba.org>, "pc@manguebit.org" <pc@manguebit.org>, 
	"ronniesahlberg@gmail.com" <ronniesahlberg@gmail.com>, "sprasad@microsoft.com" <sprasad@microsoft.com>, 
	"tom@talpey.com" <tom@talpey.com>, "bharathsm@microsoft.com" <bharathsm@microsoft.com>, 
	"samba-technical@lists.samba.org" <samba-technical@lists.samba.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] smb: client: fix OOB read in symlink error response
 parsing
Message-ID: <adk3zcdqpl34l4ggvady2dbkb74gzxmhilolvchvhbmeubekix@q2u4fk73bzpv>
References: <20260414115040.552945-1-werner@verivus.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260414115040.552945-1-werner@verivus.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-238236-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,samba.org,manguebit.org,gmail.com,microsoft.com,talpey.com,lists.samba.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[henrique.carvalho@suse.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.com:dkim]
X-Rspamd-Queue-Id: D054B40947C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Isn't all this fixed by this patch?

https://lore.kernel.org/linux-cifs/2026040636-icy-constable-9e17@gregkh/

