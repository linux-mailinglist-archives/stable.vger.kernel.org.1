Return-Path: <stable+bounces-172485-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B28CB321D0
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 19:56:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADF581CC301C
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 17:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E49C52980A8;
	Fri, 22 Aug 2025 17:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LVC+t23U"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECFF129827E
	for <stable@vger.kernel.org>; Fri, 22 Aug 2025 17:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755885363; cv=none; b=MbPdawlsh9jJSUsXxUK+cgT6Lm7ZegDybYevuoB7F9rak9f/oozadcFUtn1z5plQmU7Fl+tjEFk9kT8FZI/lDIhddXujkGABu/DbVM8Qt69jhWefBX5BBzENKDAs6TlFVUCy7j/fh+AZGVfnRGGhpMuQpQ6iinrYR0+87NivFN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755885363; c=relaxed/simple;
	bh=xQ+zVOciUe9esHEkfPFHQqVaOS4MGWLxMv83onPRSEg=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=Ep0ao9S6A47jBko4OPgjL1nbFOfhOj/yXWRNZQWvmJWdtlY5aA4ZI6obUZJVGowt05MWZSn+Tm+8nb6s0upChUQfOQk7uoS2XBZ6XOD+Yjz/JqFQaWvTp1ZzEGnZlFsGp2f/KGh9TKfVWys+vqSdfe3l8QMsKpfzlsbdAe/lBx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LVC+t23U; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755885360;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=2C9uMmDzJgvIqVnkRpI+9UCzK4E2EO+0JQESM7awR7Y=;
	b=LVC+t23U1zJpYymZh0hfBEchgtPGtd9srp8RRxToWdBjU3Cg4v6lzBuayWpvshmPIdW0Ib
	sKm9zmSUJxJVagiykMUlbFu/DfoAkZHdFcO7SqGnze8GRJe368jOB4N1CqjmN7hncH1BVr
	FndSIfvyeVBPQK0LWApPp2qCMn8CEvk=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-437-UA6vXSfDMXS-0sCH06GHzQ-1; Fri, 22 Aug 2025 13:55:59 -0400
X-MC-Unique: UA6vXSfDMXS-0sCH06GHzQ-1
X-Mimecast-MFC-AGG-ID: UA6vXSfDMXS-0sCH06GHzQ_1755885359
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-88432d88f64so514794739f.1
        for <stable@vger.kernel.org>; Fri, 22 Aug 2025 10:55:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755885358; x=1756490158;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2C9uMmDzJgvIqVnkRpI+9UCzK4E2EO+0JQESM7awR7Y=;
        b=hujPKaGzXtVU2a/8FHD+8lJMNJ+rI9A5WXaw7FzBo5jd4NHO94sjqzlK3e+WX+1xvy
         8AN8MFEbPd3DC5nLIkrPgI2Q30skNdZHw6gMmo2li9sfBKyKkiT5lAzpbabW3SGQUrdJ
         yqgY3xcvm/GTNaD/S4TGKz/DI2nRBSqGCKDdvd4Q7EIfjwjH7x5pdhunginBUgvC824H
         u2UFJKnm9IEGmw9Vj6LMufR2O70qr3/9xk9vOKwmGRHB2vJFiuvlHQ3CnL52YJqiR6Dx
         OTzcSTVx76vwhq5RwgHRgS/SOaay/L3VnnFUYLw8kwEceoLLIfytcyxKL2azHTGOgxxT
         XAVQ==
X-Forwarded-Encrypted: i=1; AJvYcCUMkkgNsOrzRGOmZeX9NzbrfhfHXzc/AKnY0qSKYCOzS6KlVlZ6gt4JvVWbbuBSzO2YJSsxggc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6E0OI5Y6EFSvo4hs36iXYen3PLeWj/wwXsatmPgJoBatEU/u/
	VoeoD1znatMulHCHfS5QCOHX4YTd1oF4YyluBwLtiswUAWlpA1JUDtqgsZE4u5LnU1oAgygNnHV
	gVbFg22/bByt3sXk9Gd75LevqxRW4NTXEijxmYXXDJrb/m6BS4EVWWc64lg==
X-Gm-Gg: ASbGncuaMYFsQTInfZwGfN8vrcbd5DK1Nuqy+ll9DtjvLVMvMaQomJQC27gNYo6nTmA
	P8nubY9AIdD+gVAR133EPGRUpiGsQSa2qDPvVgIFDOxUcLH+1t0FrEE0nzWbGCWwX7RD57qFZTT
	wGnXf1JzVB4d3vXNAt5gwDo3nf/I32UfK7r3R+WU0M6+XPsET1DNtfHkr+sDfGkR5u33ZquxVuA
	6D49618J3MGX/nBuuw5tWDuUIlFjVOZqeLxFpspam/mkg3MDjB4h2CkplEHLhi/pPInqEg1/nZo
	SpVg8sCRhR3RsIU2tN9mPpOZaXCNFvkJ6Dz+UOEoOozYUeqC7aoKzILi3C+oRSCuABMCeAM1HIx
	i
X-Received: by 2002:a05:6e02:1a02:b0:3e5:50a5:a7ef with SMTP id e9e14a558f8ab-3e921a5d65emr63056315ab.15.1755885358563;
        Fri, 22 Aug 2025 10:55:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG99RzF6KCqfmUFjX3cBBUX7QwUbXxiwJZ9DeMwhOkE+Oq4K7yuee4+FqmL1gWqJYt+egCtJg==
X-Received: by 2002:a05:6e02:1a02:b0:3e5:50a5:a7ef with SMTP id e9e14a558f8ab-3e921a5d65emr63055755ab.15.1755885357953;
        Fri, 22 Aug 2025 10:55:57 -0700 (PDT)
Received: from [10.0.0.82] (75-168-243-62.mpls.qwest.net. [75.168.243.62])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3ea4ec1f7d2sm3425805ab.42.2025.08.22.10.55.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Aug 2025 10:55:57 -0700 (PDT)
Message-ID: <06c9617f-a753-40f3-a632-ab08fe0c4d4d@redhat.com>
Date: Fri, 22 Aug 2025 12:55:56 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>
Cc: Donald Douwsma <ddouwsma@redhat.com>, Dave Chinner <dchinner@redhat.com>,
 "Darrick J. Wong" <djwong@kernel.org>, Christoph Hellwig
 <hch@infradead.org>, stable@vger.kernel.org
From: Eric Sandeen <sandeen@redhat.com>
Subject: [PATCH V2] xfs: do not propagate ENODATA disk errors into xattr code
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

ENODATA (aka ENOATTR) has a very specific meaning in the xfs xattr code;
namely, that the requested attribute name could not be found.

However, a medium error from disk may also return ENODATA. At best,
this medium error may escape to userspace as "attribute not found"
when in fact it's an IO (disk) error.

At worst, we may oops in xfs_attr_leaf_get() when we do:

	error = xfs_attr_leaf_hasname(args, &bp);
	if (error == -ENOATTR)  {
		xfs_trans_brelse(args->trans, bp);
		return error;
	}

because an ENODATA/ENOATTR error from disk leaves us with a null bp,
and the xfs_trans_brelse will then null-deref it.

As discussed on the list, we really need to modify the lower level
IO functions to trap all disk errors and ensure that we don't let
unique errors like this leak up into higher xfs functions - many
like this should be remapped to EIO.

However, this patch directly addresses a reported bug in the xattr
code, and should be safe to backport to stable kernels. A larger-scope
patch to handle more unique errors at lower levels can follow later.

(Note, prior to 07120f1abdff we did not oops, but we did return the
wrong error code to userspace.)

Signed-off-by: Eric Sandeen <sandeen@redhat.com>
Fixes: 07120f1abdff ("xfs: Add xfs_has_attr and subroutines")
Cc: <stable@vger.kernel.org> # v5.9+
---

V2: Remove the extraneous trap point as pointed out by djwong, oops.

(I get it that sprinkling this around in 2 places might have an ick
factor but I think it's necessary to make a surgical strike on this bug
before we address the general problem.)

Thanks,
-Eric


diff --git a/fs/xfs/libxfs/xfs_attr_remote.c b/fs/xfs/libxfs/xfs_attr_remote.c
index 4c44ce1c8a64..bff3dc226f81 100644
--- a/fs/xfs/libxfs/xfs_attr_remote.c
+++ b/fs/xfs/libxfs/xfs_attr_remote.c
@@ -435,6 +435,13 @@ xfs_attr_rmtval_get(
 					0, &bp, &xfs_attr3_rmt_buf_ops);
 			if (xfs_metadata_is_sick(error))
 				xfs_dirattr_mark_sick(args->dp, XFS_ATTR_FORK);
+			/*
+			 * ENODATA from disk implies a disk medium failure;
+			 * ENODATA for xattrs means attribute not found, so
+			 * disambiguate that here.
+			 */
+			if (error == -ENODATA)
+				error = -EIO;
 			if (error)
 				return error;
 
diff --git a/fs/xfs/libxfs/xfs_da_btree.c b/fs/xfs/libxfs/xfs_da_btree.c
index 17d9e6154f19..723a0643b838 100644
--- a/fs/xfs/libxfs/xfs_da_btree.c
+++ b/fs/xfs/libxfs/xfs_da_btree.c
@@ -2833,6 +2833,12 @@ xfs_da_read_buf(
 			&bp, ops);
 	if (xfs_metadata_is_sick(error))
 		xfs_dirattr_mark_sick(dp, whichfork);
+	/*
+	 * ENODATA from disk implies a disk medium failure; ENODATA for
+	 * xattrs means attribute not found, so disambiguate that here.
+	 */
+	if (error == -ENODATA && whichfork == XFS_ATTR_FORK)
+		error = -EIO;
 	if (error)
 		goto out_free;
 



