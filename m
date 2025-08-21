Return-Path: <stable+bounces-172232-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 605C7B30884
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 23:40:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E831FAC3FBF
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 21:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14C022D7DD9;
	Thu, 21 Aug 2025 21:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iqJxCX9t"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F8F393DD8
	for <stable@vger.kernel.org>; Thu, 21 Aug 2025 21:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755812437; cv=none; b=WE7VUAfPBZ0OZkXB4TrJKZ5me9ScIePomvZfCLhHqkY5MdiApxtEAhuOZ9WGKk00OTFF7ozRj1pbrOFQINwgrHJ7XUHl6tAz18bH03WdoHmJhrceFB8PB5sEVKn8Eky6iLw/1cPHvTKJNch7Y6jRbIvtiRdAFxr2n/s4x4SPv74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755812437; c=relaxed/simple;
	bh=aiNY+ZTD3J8SFNTG73ygzdE3xlpHDbcZ32iFUva19kI=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=CW1R9ABuDgydMLwhNEPXPF79OW6htRJ6OEWWahi8WKCpZmE5+W1rIZFRv7JymCAr7Umy9vBzfBZ1BQcIvjZ48SZ4K5xBchXe7nH1zJOcwp66FgdsEMmITEhWlnhYV1AKXM9B4uJjuOeJOVelj0x2ei/CW92ZVQFDqHXiwXnphVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iqJxCX9t; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755812434;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=1+V6iqvdf26GZ2QBtVStSSy1lweCRThJvVkBRh8q3qs=;
	b=iqJxCX9tPUBa+W3meAf6dxw2xphfhppxcl1wpQTwSR6WcI/vguBclIQqAeqK8wt+sBUpLh
	gB0sq5RoUhaH7QubwphOZQtjmw4HTDO9fNbKMg9O5+Z/qa+wvWuZT/7AuA6mUOrXrlv8QZ
	CDZfbLqkdBvnE7rWLI5dW77OQhERAok=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-333-0UaUQJiLOiOgQT-WerdcOg-1; Thu, 21 Aug 2025 17:36:13 -0400
X-MC-Unique: 0UaUQJiLOiOgQT-WerdcOg-1
X-Mimecast-MFC-AGG-ID: 0UaUQJiLOiOgQT-WerdcOg_1755812173
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-88432ccc4f9so299837539f.0
        for <stable@vger.kernel.org>; Thu, 21 Aug 2025 14:36:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755812172; x=1756416972;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1+V6iqvdf26GZ2QBtVStSSy1lweCRThJvVkBRh8q3qs=;
        b=fUJSNmvGclXCwVGSE77Z1JCWebNRybJF1PTA74xeJHrFs4I44C23wQh8Qjt3R3JRxc
         dKpGuKXZVN4TF5UuJQbkwaX1+uGK9aAFGJZvxOr1pMABt1gwLy6Awk9akn4a5ffPSF9g
         JaWPxKO+xKpaJUWbtIV0NXMyNQjMxMCbqIMzTZgsWjdGsETj0uxRe1mKVIBMrJqn5Ey6
         mZPcpt3waYnDFN9+CkijGo08qNK4Rm2vW1Gs1FxUH17xjV0zlLnG96Jan6eh4uzN0tIM
         f0sioTAjOo06JERn0/MXpaoQQweI15NTLTZnm5vCGNfQ0Z1c4cq6aruJodKPEwHEbhMI
         cRPA==
X-Forwarded-Encrypted: i=1; AJvYcCVCOX6iV8QpjImQQipRqqpdcSyFEV6uhjvZn6CSm5K4Rrs/+MBTJtu8ieudPYGxQuMekHzDnhQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuLYmmjuQw7h5Sb97lagXjRM+fR1U1/2MLGI+8j5HrZqrnbwyl
	wcJe5dKvUlbEcbHgA75qUAoIYuCYKg4hf892vjJyNs5Dysf8sHV6e+RlGshe4W9+PxZ91s8fVQj
	lJpDbwWK3Xys66mUM5+T84zRqV91IUeakmYbA4hNFB38qh4wmsQxjRMASYw==
X-Gm-Gg: ASbGncuuzRgWZxzOhgNWzx8Vgt5lhOaFr+y8LcFT7lQGOzpzedana7PwA+GQG9yTwbR
	7E6CUjQ7qiecowtspp0yARFf99jdGmtrDnqDQY6H+3ZkLKFgHuAMdgkky2f8uMORbqN7tGPUARb
	IbJKnCjD0FtmlGztWZbTSUC9/GRhdOFJkPzsq8xK4uS9nvq+tMR6rl3d+iy+/PgKzecz/OpWU7Z
	JJ83TtHxw8WDK349Hd89H98GvxUV1ODnHlng3xAeIA9D0TLmJtqFcJlb6i6RCSciYa4T1jVnePL
	UBIZS5v+2ByTh1Oyq6CwNVWSb3svaLerAPdkeT2Bl8HxOt0QfyZDBR2HhO1AxTmWVEMX046O+YV
	E
X-Received: by 2002:a5d:8d09:0:b0:873:f23:ff5 with SMTP id ca18e2360f4ac-886bd20cc50mr130394439f.12.1755812172585;
        Thu, 21 Aug 2025 14:36:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFTXROUU0BOWkIwqW7aq87mNa1x6wTYMofjvoPwPlrk/Jtplx9tFC5q+tecaIxCLJG3XXs57g==
X-Received: by 2002:a5d:8d09:0:b0:873:f23:ff5 with SMTP id ca18e2360f4ac-886bd20cc50mr130391239f.12.1755812172215;
        Thu, 21 Aug 2025 14:36:12 -0700 (PDT)
Received: from [10.0.0.82] (75-168-243-62.mpls.qwest.net. [75.168.243.62])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-8843f83eb6dsm796958139f.9.2025.08.21.14.36.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Aug 2025 14:36:11 -0700 (PDT)
Message-ID: <a896ce2b-1c3b-4298-a90c-c2c0e18de4cb@redhat.com>
Date: Thu, 21 Aug 2025 16:36:10 -0500
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
Subject: [PATCH] xfs: do not propagate ENODATA disk errors into xattr code
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

(I get it that sprinkling this around to 3 places might have an ick
factor but I think it's necessary to make a surgical strike on this bug
before we address the general problem.)

Thanks,
-Eric

diff --git a/fs/xfs/libxfs/xfs_attr_leaf.c b/fs/xfs/libxfs/xfs_attr_leaf.c
index fddb55605e0c..9b54cfb0e13d 100644
--- a/fs/xfs/libxfs/xfs_attr_leaf.c
+++ b/fs/xfs/libxfs/xfs_attr_leaf.c
@@ -478,6 +478,12 @@ xfs_attr3_leaf_read(
 
 	err = xfs_da_read_buf(tp, dp, bno, 0, bpp, XFS_ATTR_FORK,
 			&xfs_attr3_leaf_buf_ops);
+	/*
+	 * ENODATA from disk implies a disk medium failure; ENODATA for
+	 * xattrs means attribute not found, so disambiguate that here.
+	 */
+	if (err == -ENODATA)
+		err = -EIO;
 	if (err || !(*bpp))
 		return err;
 
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
 


