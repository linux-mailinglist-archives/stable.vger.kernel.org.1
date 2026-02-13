Return-Path: <stable+bounces-216236-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IIsDJFQxj2mhLwEAu9opvQ
	(envelope-from <stable+bounces-216236-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 15:12:36 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A3C4136FC2
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 15:12:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C5328300C9A4
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 14:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3C5735FF4B;
	Fri, 13 Feb 2026 14:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XQ7qIbOH";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="I8rC6LkC"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F563451D5
	for <stable@vger.kernel.org>; Fri, 13 Feb 2026 14:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770991910; cv=none; b=mPfINuc3LSYViJjR5wjqEBJfKQw345mifIl1i3ls8w8o+77cy7l2XprJ0n/GP2PC3ThsDL+9fjmgG723KQ9a4qFTFE2jxr5kVae2ZfpJlyxC72RWYuy/Q+7R3S6inVDODxdPRoJ6Bk/dknffNMunx1iA3Va5TuVAbjHSFLiB0Y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770991910; c=relaxed/simple;
	bh=6cLnfUZAs+yk7KbeeS6F+Pq5kNHB19xTX2baVXfcN5o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=olZIE6Wb3ibxOK5Iw409mqnXpZg1DT/5HKi/inN9/WqDsf2OcVZGFRyRx7XXPhPcCtN6AJKbCiIuV1IwtQ4JH0gaHJah9vMkDoaiM0G2xKBYcxagrbpGxUuZy8iRFNcsz+PUzcO+f4s0gseQSbB+6R8vVeVNTCNNpTc6pcv5IyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XQ7qIbOH; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=I8rC6LkC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770991908;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ii0g1jv8fE87XK8ACC94JMMkpOuPMvHxDIekJymNWR4=;
	b=XQ7qIbOHGc94J7o5FmHuWloBlj6M/4cyo5LnePgwTpWtZ+3HBnDHrnW3ParLZ7Rf3Wqrbk
	0mjmPEmZE5cibe+zaRKm1yVxqn78x0SshCk5GGHnWX5F8fOjyF3BQONaAUfs1a2hXfNX4r
	MYcMBLP9oMPDanMg9zysb7LGMH2dX0M=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-P9-v2anpMDqOIrVxYsohUw-1; Fri, 13 Feb 2026 09:11:47 -0500
X-MC-Unique: P9-v2anpMDqOIrVxYsohUw-1
X-Mimecast-MFC-AGG-ID: P9-v2anpMDqOIrVxYsohUw_1770991906
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-437159d3ff2so1138535f8f.1
        for <stable@vger.kernel.org>; Fri, 13 Feb 2026 06:11:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770991906; x=1771596706; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ii0g1jv8fE87XK8ACC94JMMkpOuPMvHxDIekJymNWR4=;
        b=I8rC6LkC2sPSgHkgqIFQhe+yBWyn37Nj3Hkgm4CqNIvsDOL9qgjFSlXmYBH2083YEw
         ZnWR15jrT5CDG34pfPZEvvw5xArWEtO3yjg01sBUP1tGeakO7OIjGRfXchyrSVu4kx+c
         ogwx/SIiv2Im1FDC4eRcfvcIf47Tg9GEI117saJAd5TX0ELXNFq1+qYkhgMwzUHPTh5P
         ulpysba4Vnbi6+VEH5wGIfo/axR64P0yld0lXoVniZVVCfxK1HjyDGfCpbru/wLTZCdx
         CNIeZND4yZtQgtVQj6JUQamrsm3leS34yqoTD5u8KgFUj9u72T3sTAwCCPHmP8vsmRSB
         KOng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770991906; x=1771596706;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ii0g1jv8fE87XK8ACC94JMMkpOuPMvHxDIekJymNWR4=;
        b=CTvrYsByyL8AywkQHk3HGwLad83KIIEuvti4saSvp5uY/SehEags6texjQSpCuO5pY
         hbs8OCWa8WbIA3WbFhbLtuFyo871bJca3Xkik19HLRwCNwaPA4iM8jeR6r0mnCUQve2Z
         iNUoyFJys1a+mCI+kf9UTZy+P9lWE8bmLhLLhqc2i3gIpv+o20ZIm42H90LdkYBUvjBE
         WUqGLhJ9bR6ayUoO8znqoRQ2emwNuxYwl2zwSDd/aMNvDh5kOOqmhJJ/n3f58DLa9NlQ
         /bI4OCEa6Wj2vy8u6nMfDdGsnhaPhbcjqME6rF6jCMcrCSeVU1fW/FwsvxtztSISELGe
         sPng==
X-Forwarded-Encrypted: i=1; AJvYcCVvhnldrOdJoiQGYrXmDHieFidFyIZGtVtYD4AcHBeh9v1tGom7NlMQPT7hna6ChtoOt+rKJh0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz04mVF9ZLImuus/jnh6faQzJczQ7bUiD+3Txodz1+iUz1psUv3
	THvVoh07HVtiY7TH9viSpchJghHXwWbguw7kGx6JNxx7AWYf0jZ3ZvqCvATtxVzIrasT2/TvTGc
	09pZxR1tCb/DNMlqlU6e9jljB4KcARhvhjEefgUne4W2taz08/INBs2Samg==
X-Gm-Gg: AZuq6aJQGJAEMro4PNdC5A9TcLmJ21IH7/ShS5Y+RG9e0eGZQcxhiIU4WLz1Ki1p84r
	LCOVjWtOzRvwGzv6zpqXIQ7jvYb4rXkDDLOgXEGraVNp/A923P/ObZ2QIl20XXZhO2/z9rGrGs0
	kNsquPRTqUwNvlW68PGpVkevnLg+lrq2YyT6C9/Ejk+zo2Gq6wmfC9M8ww0UhLf+o5mYVhQ8PWs
	QYujas07sxm68sR9CIWuCh/xG+lXcgXxzUhC7dGN5zrs0Ky1a+sp3mAcXPzRPZs7Q8pRwSJeV+3
	kaoFoahUSuHSj9CpJMmB2YHCl3WTony8nOI0eA9I3If1G/kiV9aCOLCuVgU98RRSDMgfTH85XYU
	eigG8PEnYXgYhMD6HTmXv+Xy2+/Ku/9LofOGbyGApwQD4BthKCt9J1I2OhEZgc2kJ8IfZdKo=
X-Received: by 2002:a05:6000:220d:b0:436:d824:620b with SMTP id ffacd0b85a97d-43796aefa84mr4107130f8f.39.1770991905737;
        Fri, 13 Feb 2026 06:11:45 -0800 (PST)
X-Received: by 2002:a05:6000:220d:b0:436:d824:620b with SMTP id ffacd0b85a97d-43796aefa84mr4107073f8f.39.1770991905184;
        Fri, 13 Feb 2026 06:11:45 -0800 (PST)
Received: from sgarzare-redhat (host-82-53-134-58.retail.telecomitalia.it. [82.53.134.58])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43796a6ba57sm4915369f8f.15.2026.02.13.06.11.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Feb 2026 06:11:42 -0800 (PST)
Date: Fri, 13 Feb 2026 15:11:38 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Nicolas Schier <nsc@kernel.org>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, Steve French <smfrench@gmail.com>
Subject: Re: [PATCH 0/2] kbuild: rpm-pkg: Address -debuginfo build regression
 with RPM < 4.20.0
Message-ID: <aY8wyR572eZYWVJY@sgarzare-redhat>
References: <20260210-kbuild-fix-debuginfo-rpm-v1-0-0730b92b14bc@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260210-kbuild-fix-debuginfo-rpm-v1-0-0730b92b14bc@kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-216236-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sgarzare@redhat.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,find-debuginfo.sh:url]
X-Rspamd-Queue-Id: 0A3C4136FC2
X-Rspamd-Action: no action

On Tue, Feb 10, 2026 at 12:04:47AM -0700, Nathan Chancellor wrote:
>Steve reported a build issue with commit 62089b804895 ("kbuild: rpm-pkg:
>Generate debuginfo package manually") on RHEL9, which has an older
>version of RPM than what I tested. Turns out that RPM 4.20.0 fixed an
>issue with specifying %files for a -debuginfo subpackage.
>
>The first patch restricts the new -debuginfo package generation process
>to CONFIG_MODULE_SIG=y and RPM >= 4.20.0 to ensure it is actually
>necessary and working. The second patch restores the original -debuginfo
>package generation process from commit a7c699d090a1 ("kbuild: rpm-pkg:
>build a debuginfo RPM") when CONFIG_MODULE_SIG is disabled to keep the
>-debuginfo package around for older versions of RPM.

Yeah, I had similar issue on Fedora 42 (RPM version 4.20.1) and this 
series fixed my issue.

>
>---
>Nathan Chancellor (2):
>      kbuild: rpm-pkg: Restrict manual debug package creation
>      kernel: rpm-pkg: Restore find-debuginfo.sh approach to -debuginfo package
>
> scripts/package/kernel.spec | 57 +++++++++++++++++++++++++++++++++++++++------
> scripts/package/mkspec      | 38 +++++++++++++++++++++++++++---
> 2 files changed, 85 insertions(+), 10 deletions(-)
>---
>base-commit: 05f7e89ab9731565d8a62e3b5d1ec206485eeb0b
>change-id: 20260209-kbuild-fix-debuginfo-rpm-718f81dbcaa6

Tested-by: Stefano Garzarella <sgarzare@redhat.com>

Thanks,
Stefano


