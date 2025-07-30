Return-Path: <stable+bounces-165167-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B90F6B15739
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 03:54:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACE9D5A2765
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 01:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F68E1EE033;
	Wed, 30 Jul 2025 01:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XGnvmT4F"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE901E5711
	for <stable@vger.kernel.org>; Wed, 30 Jul 2025 01:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753840388; cv=none; b=mJ0j/GWf+i7Wj3gMLWPyjXP+A3mMwWCDl9Ol9dQGboNHrS37h7aywTAF80oiA90axS2v9rlXcwHYMSOa3+e0XSsswSQww7pWtc0xqPK7BTkWtt8sP0bTsPWVMkUfGll4vQRG4R+VWNDvH5XZV3y1xeJzQLi8Glvqfd1B02TFbyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753840388; c=relaxed/simple;
	bh=9mfsWfmUsxiv7jb5H3bplGyE+CRlpRWvLjb17tNh4ZQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=G1o3DGAt4Ot9QBCoQeiwQHmKDrhDVZ+2jWduW3zusM7ios9jGPOL67qmHt9ycygS7OuQ6kFnvUOslngcXCms0N/0cko23+yjBQopPrreTrmreIWWrEfiDzRF1W8fe7tp2//YP7UXGQE6FZlSfOzR2d8Fcjj5RNoh+KXwINIs4tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--isaacmanjarres.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XGnvmT4F; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--isaacmanjarres.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e8e0c26d27eso3893538276.3
        for <stable@vger.kernel.org>; Tue, 29 Jul 2025 18:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753840385; x=1754445185; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WwXkEgtGYM3RCYPAf/S015/LYrl5duHz2m34ToaHnr4=;
        b=XGnvmT4FZkWNJnA+CoRcSrPJbdTvpsu7qIg5P/cXi3Gc436+eTrcGlIUo2Y2CxFFPk
         HKT2CPdPqJjvUKFLwznA+WB6Eigr/u4OQ2udiDYqnjrhybLT5fOdDrF8GOYU2FcT5sD9
         +9Y5Hssp+EDog0kHCNJQW/leQOGjcadjZGj+kWKX0k12z2+pQ/jnPtlcOi4BZOCKAais
         85LXpj40z55LhReBZkaBMoIEGzGpUI6s5lCXHJMXdjxHYPaONR5IEYBe/V4IiAvlrqUx
         YyXeN+SUFD77aRxQym9zgNLUG92UkSxC9eSLnGJw3Qs05qovF45RUNnWIlchTkz9oLI7
         Mmog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753840385; x=1754445185;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WwXkEgtGYM3RCYPAf/S015/LYrl5duHz2m34ToaHnr4=;
        b=d/2/RSYDCWlJYAcg7POQ2MAsJGYx0w3LRodMjprJ4gkpQxUIE4yfG9OTdaUu2S+eh7
         5oiKpiO85L57/YcsXAlsvjcJuein9GAorO0m2HdCHZQFrsXGLTYuDJKOXfa3785m/im5
         mi1G23l8S2i4UezbNXK0L+vC555DVG3zJcrgFS1wUe2o8rK5mTnc9SCPjL9NgHUYpmWV
         iXlnrtRxlZzGG98062qmgCQLmd/ftR6vQX7lHiRI+232ILeiqEPTxNx4s2Q2BmVNJSSE
         rCh0/UIC94ZcLp+3HCsnbkfmtKb2j+7VZHnefUnNlDt7WyHK4Chc+mpmL/AYd9ESlNl5
         UFlg==
X-Forwarded-Encrypted: i=1; AJvYcCU1Zq781Y/m0lZzN7VJVbZZ2eu7MGBg0Vf4I4sxVQ9xFKfYnHt/8LuokkyEpklUDkjTudUxR7k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXlUmSMxHEijXj5F27DoUL/C5Gnt2HlPv5iXkIwjbRuRbbUZgQ
	6N4OQUzBdibv1NNJoVSIi6NZbmZnmtbT4PViFEeKt/aGmR2GdzTSAREu9F6ckRtZS5S/QNgWmqK
	6Fn/M0zoUEXHBPrXlwoWUZy4vYvut571E9AdYzA==
X-Google-Smtp-Source: AGHT+IFMN87Pheb34MK37buANyT4ygN7EuRFMXC1Jr/7dhlCcyElEAYQTT7X5PQ8XI+jtHMXndENYbmFMJ7WOBut09j/6Q==
X-Received: from ybbgf9.prod.google.com ([2002:a05:6902:6009:b0:e8e:19a8:976a])
 (user=isaacmanjarres job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6902:1604:b0:e8e:219f:a662 with SMTP id 3f1490d57ef6-e8e315b5213mr2128772276.26.1753840384801;
 Tue, 29 Jul 2025 18:53:04 -0700 (PDT)
Date: Tue, 29 Jul 2025 18:52:43 -0700
In-Reply-To: <20250730015247.30827-1-isaacmanjarres@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250730015247.30827-1-isaacmanjarres@google.com>
X-Mailer: git-send-email 2.50.1.552.g942d659e1b-goog
Message-ID: <20250730015247.30827-5-isaacmanjarres@google.com>
Subject: [PATCH 6.1.y 4/4] selftests/memfd: add test for mapping write-sealed
 memfd read-only
From: "Isaac J. Manjarres" <isaacmanjarres@google.com>
To: lorenzo.stoakes@oracle.com, gregkh@linuxfoundation.org, 
	Shuah Khan <shuah@kernel.org>
Cc: aliceryhl@google.com, surenb@google.com, stable@vger.kernel.org, 
	"Isaac J. Manjarres" <isaacmanjarres@google.com>, kernel-team@android.com, 
	Jann Horn <jannh@google.com>, Julian Orth <ju.orth@gmail.com>, 
	"Liam R. Howlett" <Liam.Howlett@Oracle.com>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Vlastimil Babka <vbabka@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

[ Upstream commit ea0916e01d0b0f2cce1369ac1494239a79827270 ]

Now we have reinstated the ability to map F_SEAL_WRITE mappings read-only,
assert that we are able to do this in a test to ensure that we do not
regress this again.

Link: https://lkml.kernel.org/r/a6377ec470b14c0539b4600cf8fa24bf2e4858ae.1732804776.git.lorenzo.stoakes@oracle.com
Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Jann Horn <jannh@google.com>
Cc: Julian Orth <ju.orth@gmail.com>
Cc: Liam R. Howlett <Liam.Howlett@Oracle.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Cc: stable@vger.kernel.org
Signed-off-by: Isaac J. Manjarres <isaacmanjarres@google.com>
---
 tools/testing/selftests/memfd/memfd_test.c | 43 ++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/tools/testing/selftests/memfd/memfd_test.c b/tools/testing/selftests/memfd/memfd_test.c
index 94df2692e6e4..15a90db80836 100644
--- a/tools/testing/selftests/memfd/memfd_test.c
+++ b/tools/testing/selftests/memfd/memfd_test.c
@@ -186,6 +186,24 @@ static void *mfd_assert_mmap_shared(int fd)
 	return p;
 }
 
+static void *mfd_assert_mmap_read_shared(int fd)
+{
+	void *p;
+
+	p = mmap(NULL,
+		 mfd_def_size,
+		 PROT_READ,
+		 MAP_SHARED,
+		 fd,
+		 0);
+	if (p == MAP_FAILED) {
+		printf("mmap() failed: %m\n");
+		abort();
+	}
+
+	return p;
+}
+
 static void *mfd_assert_mmap_private(int fd)
 {
 	void *p;
@@ -802,6 +820,30 @@ static void test_seal_future_write(void)
 	close(fd);
 }
 
+static void test_seal_write_map_read_shared(void)
+{
+	int fd;
+	void *p;
+
+	printf("%s SEAL-WRITE-MAP-READ\n", memfd_str);
+
+	fd = mfd_assert_new("kern_memfd_seal_write_map_read",
+			    mfd_def_size,
+			    MFD_CLOEXEC | MFD_ALLOW_SEALING);
+
+	mfd_assert_add_seals(fd, F_SEAL_WRITE);
+	mfd_assert_has_seals(fd, F_SEAL_WRITE);
+
+	p = mfd_assert_mmap_read_shared(fd);
+
+	mfd_assert_read(fd);
+	mfd_assert_read_shared(fd);
+	mfd_fail_write(fd);
+
+	munmap(p, mfd_def_size);
+	close(fd);
+}
+
 /*
  * Test SEAL_SHRINK
  * Test whether SEAL_SHRINK actually prevents shrinking
@@ -1056,6 +1098,7 @@ int main(int argc, char **argv)
 
 	test_seal_write();
 	test_seal_future_write();
+	test_seal_write_map_read_shared();
 	test_seal_shrink();
 	test_seal_grow();
 	test_seal_resize();
-- 
2.50.1.552.g942d659e1b-goog


