Return-Path: <stable+bounces-6383-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E1BB80E05B
	for <lists+stable@lfdr.de>; Tue, 12 Dec 2023 01:40:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 164831F21C3A
	for <lists+stable@lfdr.de>; Tue, 12 Dec 2023 00:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FE7239B;
	Tue, 12 Dec 2023 00:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BD97TdaC"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A5B9A7
	for <stable@vger.kernel.org>; Mon, 11 Dec 2023 16:40:07 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-db084a0a2e9so5576917276.2
        for <stable@vger.kernel.org>; Mon, 11 Dec 2023 16:40:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702341606; x=1702946406; darn=vger.kernel.org;
        h=cc:to:from:subject:date:message-id:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UW9BPRtrX5yeOjPq63HaAVTX2kXYRY7LwoiqcuzWcDw=;
        b=BD97TdaCPMOjKCR2I6UJ69Q4d/r2uUv0bnw5jzfb0P9P4DKp6Bb7NY2H67Dm+S3aI6
         6x7iQRMrAUkBMrGlnCmFOD6aq+SU1pvzeSrivy6gQLSfjGKrikFwsxm5FzBT2+DvlKXY
         d2G+dPHgy8acFoIJXPECsdzjYQa030tVDzP8ZRNU5Z98WB7jit+zvLda6ZWfaROjyv6S
         kABn/yvcFqIXmfjBf596ZBxkMgJJlxlxB132+VN1KIX/x6L77SO5c53eM+9uZUg2AwhS
         Na45VAlsEBh0ZCGMdgcIVIW46OhVJJbrwjaIUAIX2+llZcg/9kfUApIf6Wci52vk9nPY
         rUSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702341606; x=1702946406;
        h=cc:to:from:subject:date:message-id:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UW9BPRtrX5yeOjPq63HaAVTX2kXYRY7LwoiqcuzWcDw=;
        b=NapNAktsCr2tx3j/6ExowXwXhlaoNpvSBY4qFxKQeAFgUb2cnwy2W64C4gcNohDnTh
         iYC7N1XN1hpw4G35xj0TZ1aAuUItMH5hgi4AAPA6Mc/wQbtxBknaBlb9sMBRtXcVwaVg
         /HqrmbSC6oRppZuMLV/2zuhMT1TG88RbLuBy8yviLuJzx1tFi54PczkMG4JOTLsFFzUf
         80cpkkV9IDG9oxCQESiufCon/6YWo0amY1wR2SYxkQsSTPoD+7YFkFB3h59HdQLNyTcq
         mD8S0rh7YE7tKqIf4q1eteaal2X6xT+8XgVX2TWX9AMq12RI0ahwxVoDfVikHt5Mw3DN
         z9lQ==
X-Gm-Message-State: AOJu0YyPtpBYyExXEtERR7jDtbpEoiFETyJJXvDtxretuzjNDYDNsP3S
	qv8B+/5C9gueqS/leciI+q7MKPe94YIpKIZG8o++5tf7/OgqEj6rlUgbX0+QvY8E7pqTP8d8MGO
	cYo/mmac9siv2vlTCnklKbqJHkY/8G+x6+hnF4EcpBEhzdbKyQCxDC001XksAyk4RsHyotllNHw
	==
X-Google-Smtp-Source: AGHT+IGpdRYKog8O3ECVxpAVaSQkHbxHaC25i2GNLin3TWnDgcTa1qXatdKnpeC2to6BrfdImiW9BfUPsiVppWbzmw==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: from rkolchmeyer.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:7f04])
 (user=rkolchmeyer job=sendgmr) by 2002:a25:3c4:0:b0:daf:6333:17c3 with SMTP
 id 187-20020a2503c4000000b00daf633317c3mr41492ybd.1.1702341605889; Mon, 11
 Dec 2023 16:40:05 -0800 (PST)
Message-ID: <000000000000b505f3060c454a49@google.com>
Date: Tue, 12 Dec 2023 00:40:05 +0000
Subject: IMA performance regression in 5.10.194 when using overlayfs
From: <rkolchmeyer@google.com>
To: stable@vger.kernel.org
Cc: linux-integrity@vger.kernel.org, regressions@lists.linux.dev, 
	eric.snowberg@oracle.com, zohar@linux.ibm.com, jlayton@kernel.org, 
	sashal@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi all,

5.10.194 includes 331d85f0bc6e (ovl: Always reevaluate the file
signature for IMA), which resulted in a performance regression for
workloads that use IMA and run from overlayfs. 5.10.202 includes
cd5a262a07a5 (ima: detect changes to the backing overlay file), which
resolved the regression in the upstream kernel. However, from my
testing [1], this change doesn't resolve the regression on stable
kernels.

From what I can tell, cd5a262a07a5 (ima: detect changes to the
backing overlay file) depends on both db1d1e8b9867 (IMA: use
vfs_getattr_nosec to get the i_version) and a1175d6b1bda (vfs: plumb
i_version handling into struct kstat). These two dependent changes
were not backported to stable kernels. As a result, IMA seems to be
caching the wrong i_version value when using overlayfs. From my
testing, backporting these two dependent changes is sufficient to
resolve the issue in stable kernels.

Would it make sense to backport those changes to stable kernels? It's
possible that they may not follow the stable kernel patching rules. I
think the issue can also be fixed directly in stable trees with the
following diff (which doesn't make sense in the upstream kernel):

diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/ima_api.c
index 70efd4aa1bd1..c84ae6b62b3a 100644
--- a/security/integrity/ima/ima_api.c
+++ b/security/integrity/ima/ima_api.c
@@ -239,7 +239,7 @@ int ima_collect_measurement(struct integrity_iint_cache *iint,
 	 * which do not support i_version, support is limited to an initial
 	 * measurement/appraisal/audit.
 	 */
-	i_version = inode_query_iversion(inode);
+	i_version = inode_query_iversion(real_inode);
 	hash.hdr.algo = algo;
 
 	/* Initialize hash digest to 0's in case of failure */

I've verified that this diff resolves the performance regression.

Which approach would make the most sense to fix the issue in stable
kernels? Backporting the dependent commits, or merging the above diff?

I'd be happy to prepare and mail patches either way. Looking forward
to your thoughts.

Thanks,
-Robert

[1] I'm benchmarking with the following:

cat <<EOF > /sys/kernel/security/ima/policy
audit func=BPRM_CHECK
audit func=FILE_MMAP mask=MAY_EXEC
EOF
docker run --rm debian bash -c "TIMEFORMAT=%3R; time bash -c :"

A good result looks like 0.002 (units are seconds), and a bad result
looks like 0.034.

