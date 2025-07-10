Return-Path: <stable+bounces-161611-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E1FC1B00944
	for <lists+stable@lfdr.de>; Thu, 10 Jul 2025 18:53:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D0EB16B701
	for <lists+stable@lfdr.de>; Thu, 10 Jul 2025 16:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48AFF2836B0;
	Thu, 10 Jul 2025 16:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="BysCcMAO"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 011D5285062
	for <stable@vger.kernel.org>; Thu, 10 Jul 2025 16:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752166395; cv=none; b=M6uRoD0y3LS5Z0S2YSox6+1ldLOeygzdLtstJFV5RmDEFGKvvtH80YYXAXuUFwHEOJKm1n64W/T9CWBOvqLc1i74qCabJRoac6evf8n/kvA6mQoHjc3Be/e7xgdwnL2fRnY3NmzJpi7ik5iZ3ijAlY/T6j70pY3WEIJRJqBcc3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752166395; c=relaxed/simple;
	bh=z4Wq8TqyeIjjgk+V/Gm4DspBzsLgkVjkd8sZF5ysnNc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XFgMsCd3Arf+9F3KVqR9TmODubwrPUeT4YFMk7qVPrhci7jmUH6uyVmeMmjJqCzLEBeXpAvdr2NAhTWI02cUK8Ogr2+/SOaVmxC+KBEkWhIM6GUUr6gIpw3Y3Y9lyWnsLGHfChYECm0R8V+CxRb+4kkLGwujSvfvldLHSjiklDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=BysCcMAO; arc=none smtp.client-ip=209.85.221.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f67.google.com with SMTP id ffacd0b85a97d-3a54690d369so1233766f8f.3
        for <stable@vger.kernel.org>; Thu, 10 Jul 2025 09:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1752166390; x=1752771190; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8Q1IK3GqKF8NVWixUC1jFkt7PBtdZyjJHmShjCXxIzw=;
        b=BysCcMAOKMpMRDVCns2GhQYaLNO8M8KXsi67VbnAYGRPAiXcSjsaDG+sEjcak98sFF
         kiZkPrsPqvoRwmdVWWUT3agwLp6+Uy2lQt6XT04JiX3a31XvyvBgX7WMcduzLVB061he
         p8dqMgNCr5oDnly3NQrNDdf5wMFlSgIZwKb1GX+ipsygSBhnLSseMOtx62bmVl8X+4NS
         jL143QmGsCBXnAnjVGZ4XIc+iqPw72wNkHeXfnLhDy68slI9jr+DOOPt/IxLVC57UD5a
         RbNDGIoQiGMbe8lRkXQCcfyw834Fd90ZK2P0TxOKKMoeaZMTOza2WHQV9WVDOeFQoLgC
         c0XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752166390; x=1752771190;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8Q1IK3GqKF8NVWixUC1jFkt7PBtdZyjJHmShjCXxIzw=;
        b=luXwWuTcnlkgx7wF4qlD7heWTs8M91PCQE659kKT03BoYwTrnSYB7VemlZizyJbs3b
         jQbhEAyfmUuT79dYKhDzQAPfv+vkZpF8Apwnt0JFVkxAkF/yEMa8gpZrXCO1M+qHnoAo
         +teGtf40lvRG3iGjsW8UIDrS9yXlS6NcPI6lzB9G1PSPYlPl7trMSQStIuCUOyaGud6X
         wzxJLIp7RZELgUrmYbZYUN4W0oHxlgwconZPZIJt6ImjOAD6KbNOnIMNqOMZWavzVOmi
         MYHgHEMLWKbaWJPMz8QUSQHDkMp11ymqpOn2ySfJUbLtaw6LugQg066tQxhBfenItQT2
         Bobg==
X-Gm-Message-State: AOJu0YwKR8k4ywDMlCTG+B9bwZMdXOgprS9JdUtcg8EgYgy+jGc6yu2c
	BjJOxTvPUWYP2JkxBzfZPGyFdX7Qc1WzIUW/6F/GE6/+aay6Upw+L6HmZSMY+VEYHWTxafaV0p6
	DdnklQ3NXBQ==
X-Gm-Gg: ASbGncskKJEFTHF7dcDC8m4dZ2sDUxPT6b8dyNuG9byEAKveQLSSwh2TNF2DsoS5iPO
	M35z4Lklc59AmiZjciSINcQJWI1seTxIbWygiTMt1lAxAgTzSpJyCyHNsSsXfNSj2vgj0POIcbQ
	JgxPyd7kYPU3bWK91nmWLUMauu6tsbhhctaIHQHHHMqmwFHjL8g6fBZVJaWjRfLwDehM49NKGcJ
	rjVU3qUznatMHs220wgAgwAjhA9gqZKRiDwq7yAQFSgiG0ndqpJcYg0YMWH1zPmd4/FPlms4Vtv
	2iMKsxryXhL6PxLmL7J315RLD6WuW10BapZiPW8zZQsWqaiohVLZqz0+BP0N3GA+UOYF1s43PbH
	sHZllWa30vV8=
X-Google-Smtp-Source: AGHT+IGrdz31l8ytEw4slUi213DBNuveM59F6Vrt68zhWC15A/FqHaYihvruZySsSw86Xhh/El72Ng==
X-Received: by 2002:a05:6000:220e:b0:3a1:fa6c:4735 with SMTP id ffacd0b85a97d-3b5f1891105mr288332f8f.35.1752166390078;
        Thu, 10 Jul 2025 09:53:10 -0700 (PDT)
Received: from localhost.localdomain ([2804:7f0:bc00:fc9b:1aa7:f529:d2f7:747d])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9f1b54bsm2852250b3a.90.2025.07.10.09.53.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 09:53:09 -0700 (PDT)
From: Henrique Carvalho <henrique.carvalho@suse.com>
To: stable@vger.kernel.org,
	smfrench@gmail.com,
	dhowells@redhat.com
Cc: linux-cifs@vger.kernel.org,
	Henrique Carvalho <henrique.carvalho@suse.com>,
	Laura Kerner <laura.kerner@ichaus.de>
Subject: [PATCH 6.6.y] smb: client: support kvec iterators in async read path
Date: Thu, 10 Jul 2025 13:50:40 -0300
Message-ID: <20250710165040.3525304-1-henrique.carvalho@suse.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit 3ee1a1fc39819906f04d6c62c180e760cd3a689d upstream.

Add cifs_limit_kvec_subset() and select the appropriate limiter in
cifs_send_async_read() to handle kvec iterators in async read path,
fixing the EIO bug when running executables in cifs shares mounted
with nolease.

This patch -- or equivalent patch, does not exist upstream, as the
upstream code has suffered considerable API changes. The affected path
is currently handled by netfs lib and located under netfs/direct_read.c.

Reproducer:

$ mount.cifs //server/share /mnt -o nolease
$ cat - > /mnt/test.sh <<EOL
echo hallo
EOL
$ chmod +x /mnt/test.sh
$ /mnt/test.sh
bash: /mnt/test.sh: /bin/bash: Defekter Interpreter: Eingabe-/Ausgabefehler
$ rm -f /mnt/test.sh

Fixes: d08089f649a0 ("cifs: Change the I/O paths to use an iterator rather than a page list")
Reported-by: Laura Kerner <laura.kerner@ichaus.de>
Closes: https://bugzilla.suse.com/show_bug.cgi?id=1245449
Signed-off-by: Henrique Carvalho <henrique.carvalho@suse.com>
---
 fs/smb/client/file.c | 46 ++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 44 insertions(+), 2 deletions(-)

diff --git a/fs/smb/client/file.c b/fs/smb/client/file.c
index d883ed75022c..4878c74bae6f 100644
--- a/fs/smb/client/file.c
+++ b/fs/smb/client/file.c
@@ -3527,6 +3527,42 @@ static size_t cifs_limit_bvec_subset(const struct iov_iter *iter, size_t max_siz
 	return span;
 }
 
+static size_t cifs_limit_kvec_subset(const struct iov_iter *iter, size_t max_size,
+				     size_t max_segs, unsigned int *_nsegs)
+{
+	const struct kvec *kvecs = iter->kvec;
+	unsigned int nkv = iter->nr_segs, ix = 0, nsegs = 0;
+	size_t len, span = 0, n = iter->count;
+	size_t skip = iter->iov_offset;
+
+	if (WARN_ON(!iov_iter_is_kvec(iter)) || n == 0)
+		return 0;
+
+	while (n && ix < nkv && skip) {
+		len = kvecs[ix].iov_len;
+		if (skip < len)
+			break;
+		skip -= len;
+		n -= len;
+		ix++;
+	}
+
+	while (n && ix < nkv) {
+		len = min3(n, kvecs[ix].iov_len - skip, max_size);
+		span += len;
+		max_size -= len;
+		nsegs++;
+		ix++;
+		if (max_size == 0 || nsegs >= max_segs)
+			break;
+		skip = 0;
+		n -= len;
+	}
+
+	*_nsegs = nsegs;
+	return span;
+}
+
 static int
 cifs_write_from_iter(loff_t fpos, size_t len, struct iov_iter *from,
 		     struct cifsFileInfo *open_file,
@@ -4079,6 +4115,13 @@ cifs_send_async_read(loff_t fpos, size_t len, struct cifsFileInfo *open_file,
 	int rc;
 	pid_t pid;
 	struct TCP_Server_Info *server;
+	size_t (*limit_iov_subset)(const struct iov_iter *iter, size_t max_size,
+				   size_t max_segs, unsigned int *_nsegs);
+
+	if (iov_iter_is_kvec(&ctx->iter))
+		limit_iov_subset = cifs_limit_kvec_subset;
+	else
+		limit_iov_subset = cifs_limit_bvec_subset;
 
 	server = cifs_pick_channel(tlink_tcon(open_file->tlink)->ses);
 
@@ -4113,8 +4156,7 @@ cifs_send_async_read(loff_t fpos, size_t len, struct cifsFileInfo *open_file,
 
 		max_len = min_t(size_t, len, rsize);
 
-		cur_len = cifs_limit_bvec_subset(&ctx->iter, max_len,
-						 max_segs, &nsegs);
+		cur_len = limit_iov_subset(&ctx->iter, max_len, max_segs, &nsegs);
 		cifs_dbg(FYI, "read-to-iter len=%zx/%zx nsegs=%u/%lu/%u\n",
 			 cur_len, max_len, nsegs, ctx->iter.nr_segs, max_segs);
 		if (cur_len == 0) {
-- 
2.47.0


