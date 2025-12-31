Return-Path: <stable+bounces-204333-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AB6DCEBC9D
	for <lists+stable@lfdr.de>; Wed, 31 Dec 2025 11:28:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 530CD3029C42
	for <lists+stable@lfdr.de>; Wed, 31 Dec 2025 10:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31C2731AAA7;
	Wed, 31 Dec 2025 10:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="CG6E3ytb"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f227.google.com (mail-pf1-f227.google.com [209.85.210.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E8A6275AE4
	for <stable@vger.kernel.org>; Wed, 31 Dec 2025 10:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767176934; cv=none; b=SCVIog6wisk1lxR1aeEBERHmwIZmCpARSzBgM7OqSs1sOshCbWB1TPBGuLZVZ8trVloJiyB0XnyBQXRTBH3f+4sRXqEzzMv3SEMzIi6hbMIRPHXf2zsE+qL6Ws4W4m8BvZIjUBqwjaYwCOivpcyPtmhW4nkoAs5objV37n9ElNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767176934; c=relaxed/simple;
	bh=G/ZhUjmDDhcPrFgzKSf53vaiynE6E43XY/+UxifF9h0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VYkjxXi7EXWIG1RN6KmB5lttIKI6HKhVcEV4H/IK+WkeSMjzsGFFkOaKSAFb1LtyMD8KlH4VyH8pzDvMDfLwKGM89ndYBJvActij9kl7QhQpOTbGCFvFPGcOna1qEk0bsMRo2+B3Wy8BbtW7WOhUAHci+94eI+EZ4BGrFP4BsnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=CG6E3ytb; arc=none smtp.client-ip=209.85.210.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f227.google.com with SMTP id d2e1a72fcca58-7f651586be1so5107117b3a.1
        for <stable@vger.kernel.org>; Wed, 31 Dec 2025 02:28:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767176932; x=1767781732;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=17YsCloS89Rp+LrUIY8Ph1LvawoB0k2+NF16uLKUGNs=;
        b=KkfavOYfbGKU0tMHLOmHwWXzJnDCpV43eKFBDThvnjORmWZyPHTNL/OxedwasqgU1D
         eVQo0lUCbEoidQ5nG+mCkaYHUG7EHiOEQyxvvWlQ7aFSv3dRLrcprG6TEo+oq8k4Kn4J
         WbL5zEICR5t81KQLLtDh3vCd0ms7POmhxw/nemAQkYe36Skk819qDw5lg9nXnMnvvCSs
         QxzGKV/p4gkoekRy4easHnaDimCvBT/cEKA8FLjzRqajyjRHq/VFAuZhw63iICAWVMCb
         WLVz9tubxz5Dndd6w01V2aXqEKcTIElBOoXK0ZmFCZNqGAkd+ko3MXcK1lgpBY32ABxg
         Q6oA==
X-Gm-Message-State: AOJu0YxL0NdY6Fn+oW8H24qFl1Tlb+y9e0KTiHYTIFsui1R1QDLeMVk9
	i4kuGNzQiLv5Z9Z3C65qbThx/vjXEbTmXLBRO/jPLTzrfpJT2r4WcOq19s7wv6xTLFkJtyC+4VU
	zPLqDXBFYtyqwOS+cmN1CpkVuVlDnhQkW1nZGsDSM/QXAbwev7PqPNQPxc9LpKDrmQ3Z52iYhfR
	3tPwmEDcvs70mqjktRN04AAzcXoGPJ3eNZJF3krMZonHgva2lXrHdH8ZbDCKijLSjqxw71GY/+A
	eBMQBP/Wfetd+zKmg==
X-Gm-Gg: AY/fxX6pWJ8Ufei182G3wJnzY9VvPQ3FDR26+R5VOlowkQMKl0Mv/wxgGgkQUBnMfgA
	sezJX3w3ZS0Ju5BNnKuGLpEmaumdep5Wdl1naMPUW7vWF/wxCfhVzJPRUsWGV1EA1lKw7WOcrM4
	OX9cuW/Wv5d/FcyeEbxXSunbQdUuYw7kGwNx4RpHrRis+VGzhMAiW/SxKtuQ5PnjOIsOwZRHR6C
	OT69Mw9COFSB5Ts+Cx5L3JXSp87ASOoRxFRsZq0jmMWWOZPp6A0nao7EP7kAy2y+ZqmH1TPGvRn
	4JNFUiBr/jCXeYNlTP45Laj3NtuJEKL2hV1Yp/GAzkipgyPOJayypukvTAa9J96fF52mhdNGs1L
	6W3cFCp635Fydzv1aLdSdSxbEOr+fmJAOMB/jI4UQ4YgzstBjkKeOsumXXHDA8uRXGYhYVGCkIQ
	/BNfkLYk1tOKF9gJ+33BMslnTU39lrKo0b/zZGau9PXcpeAm+042A=
X-Google-Smtp-Source: AGHT+IF7bjgNFlp+Dd235Unu3KceodBtHb+Aw2zT1YlJrOpQdS8i++/S9Jos+qC8KDwFYRXqX2bfidLg4k4A
X-Received: by 2002:a05:6a00:8e02:b0:7dd:8f68:a812 with SMTP id d2e1a72fcca58-7ff5284dc0cmr30667759b3a.6.1767176931794;
        Wed, 31 Dec 2025 02:28:51 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-101.dlp.protect.broadcom.com. [144.49.247.101])
        by smtp-relay.gmail.com with ESMTPS id d2e1a72fcca58-7ff7d9c77bdsm4126368b3a.9.2025.12.31.02.28.51
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Dec 2025 02:28:51 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-11ddcc9f85eso20261390c88.0
        for <stable@vger.kernel.org>; Wed, 31 Dec 2025 02:28:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1767176930; x=1767781730; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=17YsCloS89Rp+LrUIY8Ph1LvawoB0k2+NF16uLKUGNs=;
        b=CG6E3ytb7GTrRoLviwY+HQ4chjiidzeAQ/A/eazj1P2ntX/baFhTroNumoHT81k7lQ
         LBHGERPlAWcBGsw5e1ppHTF6u3XkMza6W08Hhi+K5JXaQUSDx/ALZPKWpo3DyveFpLSu
         97+toV7FOESq9McllKVLVLyerc4FfBOTcg3tU=
X-Received: by 2002:a05:7022:688:b0:119:e569:f86c with SMTP id a92af1059eb24-12171a75857mr35097136c88.9.1767176929979;
        Wed, 31 Dec 2025 02:28:49 -0800 (PST)
X-Received: by 2002:a05:7022:688:b0:119:e569:f86c with SMTP id a92af1059eb24-12171a75857mr35097111c88.9.1767176929152;
        Wed, 31 Dec 2025 02:28:49 -0800 (PST)
Received: from shivania.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121725548b5sm138692126c88.17.2025.12.31.02.28.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Dec 2025 02:28:48 -0800 (PST)
From: Shivani Agarwal <shivani.agarwal@broadcom.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: miklos@szeredi.hu,
	amir73il@gmail.com,
	linux-unionfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	vamsi-krishna.brahmajosyula@broadcom.com,
	yin.ding@broadcom.com,
	tapas.kundu@broadcom.com,
	Kees Cook <keescook@chromium.org>,
	syzbot+9d14351a171d0d1c7955@syzkaller.appspotmail.com,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	Miklos Szeredi <mszeredi@redhat.com>,
	Shivani Agarwal <shivani.agarwal@broadcom.com>
Subject: [PATCH v5.10] ovl: Use "buf" flexible array for memcpy() destination
Date: Wed, 31 Dec 2025 02:08:09 -0800
Message-Id: <20251231100809.642262-1-shivani.agarwal@broadcom.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

From: Kees Cook <keescook@chromium.org>

commit cf8aa9bf97cadf85745506c6a3e244b22c268d63 upstream.

The "buf" flexible array needs to be the memcpy() destination to avoid
false positive run-time warning from the recent FORTIFY_SOURCE
hardening:

  memcpy: detected field-spanning write (size 93) of single field "&fh->fb"
  at fs/overlayfs/export.c:799 (size 21)

Reported-by: syzbot+9d14351a171d0d1c7955@syzkaller.appspotmail.com
Link: https://lore.kernel.org/all/000000000000763a6c05e95a5985@google.com/
Signed-off-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[Shivani: Modified to apply on 5.10.y]
Signed-off-by: Shivani Agarwal <shivani.agarwal@broadcom.com>
---
 fs/overlayfs/export.c    | 2 +-
 fs/overlayfs/overlayfs.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/overlayfs/export.c b/fs/overlayfs/export.c
index f98128317..dd3e1969e 100644
--- a/fs/overlayfs/export.c
+++ b/fs/overlayfs/export.c
@@ -788,7 +788,7 @@ static struct ovl_fh *ovl_fid_to_fh(struct fid *fid, int buflen, int fh_type)
 		return ERR_PTR(-ENOMEM);
 
 	/* Copy unaligned inner fh into aligned buffer */
-	memcpy(&fh->fb, fid, buflen - OVL_FH_WIRE_OFFSET);
+	memcpy(fh->buf, fid, buflen - OVL_FH_WIRE_OFFSET);
 	return fh;
 }
 
diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index 87b7a4a74..5ac968f70 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -104,7 +104,7 @@ struct ovl_fh {
 	u8 padding[3];	/* make sure fb.fid is 32bit aligned */
 	union {
 		struct ovl_fb fb;
-		u8 buf[0];
+		DECLARE_FLEX_ARRAY(u8, buf);
 	};
 } __packed;
 
-- 
2.40.4


