Return-Path: <stable+bounces-165177-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47080B15752
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 03:56:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D448218A7A40
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 01:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 848891D63D8;
	Wed, 30 Jul 2025 01:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Va9InuCp"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD271F30B2
	for <stable@vger.kernel.org>; Wed, 30 Jul 2025 01:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753840466; cv=none; b=rrkzj6hfy/fadDxMUBJLGAuKLD6XoA8CLbOUiJfVprr8lHuxdR0qRT5kLYTF4IW4gSF1yWi/2i4pzVkMaK4B4pkSQBOg0/HSngOGJsLBLRr42PoUIm0nb3ulyslwPZbdWvcfYGZBQ+IrZmiJuq/P0qjP06bxVq/YEKohKUhcxjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753840466; c=relaxed/simple;
	bh=nPJJLP1zR91c9Y7ZN8HF7eAeTILNv1bxL9VL0/fy/6A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Jp3QQlHHpO3VWybGorPRYXcIMFjQQJA+DHrC7ZFEJqGY9vs/FTjesZliKmTUR1m7tdGzMCuLv+qMqTuFC2BpHyTBYQhE9O63Y5TjxENCcNzgRUWE+lu1rUKYD9E1WkKKspAeRCSq3sjYl3KaiEIk4zY8982BbSSjlQbyRA4RIrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--isaacmanjarres.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Va9InuCp; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--isaacmanjarres.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b31cc625817so360071a12.0
        for <stable@vger.kernel.org>; Tue, 29 Jul 2025 18:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753840464; x=1754445264; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=L3flim+Na7xCLw8vVOZ8w5OEJGJTOj64xaI7scCyCdg=;
        b=Va9InuCp3r4FpkSSL9l7XB8DwN2ZwfmdFGlITrr9fdfDZjXrbmEZm9oWl0xch/4ScI
         hKbxHJzlVL6F6B7vD9Pyc3O32ww5xvhct2//r5NErF1wGavShp0H8Z+CBKHAcmFBt5o1
         fhJg5dLB+1ozl4247AeqyP765G/Ku2UxygPKb/9FYp8t7s8Osbv+IGeLsfn5N9kPG5pn
         DXxdpRUZS+9EqquImECuU/PrCyMkQEyq8rMqdsmpRmMNtR4V2OVC8weKMmamwEqb7WZK
         TcoiMT+lgNmEDczz4IlUhay0nKYKFywI8Oj+Gamf8kP5OLWV/ypEphcRV6GFSZRhE97f
         iaeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753840464; x=1754445264;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L3flim+Na7xCLw8vVOZ8w5OEJGJTOj64xaI7scCyCdg=;
        b=KT9rZsPDpg+gKnntxU4DRmc47igAFNIh5ihoskUwoTscLS2rvXlWIOgAoKfeoUAC8p
         qZeGvZxl/LCpsnvEpFRqr0KIaUddRFDyxw5kSmg2pHvk/jJupshJmun75TvxDxcLirz9
         aUW8yQ+I5wva6iqIT9xE2OSxhomVZzH6h0stLdnD92mxtQV2n96YI+oNkWcbT+S0cKO/
         BgR4ngTvHTJJEgbV/H4vaVdrvh/BbLemtbhL7Tbm0Rux86V7xkolUgzVKq61wFSMHVF+
         xOGUdUqa9eRwuxZlablogSFDzIrB16A4XAUSqEPBF5X9V2dBjrmavmXorAkeMUUhWLAD
         PIcA==
X-Forwarded-Encrypted: i=1; AJvYcCUPgzVRGOrx8VRDvtPxrGXRd7OsxomfdtI1TCXwlnbwcs7iQ9MF68bKLJKuFsVvkwTt7Lq+5aw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6Jq19jzGxEsQPMUxObixkgoGWJAw+/r5qrtfrMRZJzE/axBeb
	XBuH/+JDaP1L8wzPed5ne+NUACjawZTwqaIUN6j6D3eNigB2SIIuPnfKdXBZisAWSRLU1aTglK3
	H1L4yR/Gpfkla0iK2hKleKGNbYzP2ROoWdoaHEw==
X-Google-Smtp-Source: AGHT+IGSsezyA6LC++SZ5I/UxQYHh/BgAfaZ3ltdoNiNEdtr06IoSwJQnz/o3hhQJ+ktgve5ykzzrjxSLeVPY67bFzlSZw==
X-Received: from plkv11.prod.google.com ([2002:a17:903:1a2b:b0:240:608a:938d])
 (user=isaacmanjarres job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:90c:b0:231:9817:6ec1 with SMTP id d9443c01a7336-2409689f466mr22524815ad.17.1753840463916;
 Tue, 29 Jul 2025 18:54:23 -0700 (PDT)
Date: Tue, 29 Jul 2025 18:54:02 -0700
In-Reply-To: <20250730015406.32569-1-isaacmanjarres@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250730015406.32569-1-isaacmanjarres@google.com>
X-Mailer: git-send-email 2.50.1.552.g942d659e1b-goog
Message-ID: <20250730015406.32569-5-isaacmanjarres@google.com>
Subject: [PATCH 5.10.y 4/4] selftests/memfd: add test for mapping write-sealed
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
index fba322d1c67a..5d1ad547416a 100644
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


