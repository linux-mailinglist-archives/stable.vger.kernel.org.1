Return-Path: <stable+bounces-210235-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C3A93D39945
	for <lists+stable@lfdr.de>; Sun, 18 Jan 2026 19:57:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 78ACD3001629
	for <lists+stable@lfdr.de>; Sun, 18 Jan 2026 18:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73DAB261B8C;
	Sun, 18 Jan 2026 18:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kKAXgJ2d"
X-Original-To: stable@vger.kernel.org
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C4A1A316E
	for <stable@vger.kernel.org>; Sun, 18 Jan 2026 18:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768762663; cv=none; b=ZLVuklAiQjwcRyrevD4qkpPQRt5ypWDg05UlVpXU75KfiKxLLBTrLfMmjg5oV7DY+Y+ZO6DHeT6pKjpveBxMG+dq6swqsxr3Fx9ekDGk8J/ftsKd4dTDYU/4yJmaAT5mChbgRKzJoCYzcBEgfgPrbAgkj4+16l1XMchfq460CKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768762663; c=relaxed/simple;
	bh=uEH6tkrhwnjKM1uvdiIJIJXExMuu7hcx+AmXyWxFOOA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nI2/WoWgZmsZ9/8aC+xPUCLoIuZgdYCEyYXjNiV5te6WQ9BUnxkAUMelI0+F1zFyS4wYjx60e0tp0SMYCLrcVxr5fVRPW7H4gvPYLir45MURbUb8W0Tt0rYEKne3yU4Kk+3JenJPiyn4ldiQDd2lO8PvseDzSPCOF9nT1cEF+u4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kKAXgJ2d; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-6611b4edbe6so1212706eaf.0
        for <stable@vger.kernel.org>; Sun, 18 Jan 2026 10:57:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768762660; x=1769367460; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sIn7kPGIfDc+QhgxXADc8Eo2fOwVdn5dCfxtYkZG0x8=;
        b=kKAXgJ2d7wLGFb0j/dkkCRwufxMtPBJCUaQN6ThbCOQ6tp2Wj8fSjdAPrXIGCAPqoG
         FafTl+jcrnm4vcEO/cgcXXsBKZQCFJtRg+zjz/3GgpGqHoMUmjqw2Ng8UyE8+Wui8UgX
         44Mqik+9op7pPFEf4Mv/EjVxKX2BCMBVdVBWzSdiboGcHN+eCvk/XaASp3k8A64S/dob
         7qeAfHCiXLFNcz4kAIduE9FMDe0jdE6QHx0q2Effy4gbW+u4acpQB4GijkaygAZyCn9O
         KHJwI60ZSiSF+6kpvOsbs6Pl5X8ZAxseYzXNqINVRsyS/eJ6oU8LXytKRgrRW2mizEMp
         PFRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768762660; x=1769367460;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sIn7kPGIfDc+QhgxXADc8Eo2fOwVdn5dCfxtYkZG0x8=;
        b=kvCgbW/RP+Twguh7JVF0d2W8BbXlqPP/BW2OgswS8TvbNSYae59khZQUTJyGfj1kMX
         gMfFaPBqgSAkpGzQWovVJCpX0ryX5CnOoDXVBhsosZdCyu8mJKtab5iWr08dRaRC2QnV
         HICBQfBoMvDpCV+KuK9A9H6yombImcdIUNm1hDtn+nVp3+K3W5R6x69OZQ7oToXyC0nc
         q7fWU2IAo9tdjPl0Aq4FpfwemtT0UG5mz2tE85pndpC3o8TKdPHm5qoJcDhx0J4h5b60
         gFV31oz8MgHnQIiLHpTHuD9EWYAwfQXW+PhMSttG6N7xTQoXolAEJAO0d6NcCuN15Lh3
         bN4Q==
X-Forwarded-Encrypted: i=1; AJvYcCUIEaOG+1+QCGWHcCSr0AHwOFDidzVxN7zfxKtipSPrUrpiekcYGPZNRzJ6cpLfqsaO1XMDTAY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywgi0Y1icsFwW8IZNcfGEZcbzOuS+exOm62kKnspVN2GvZR+JXb
	Y6LH4MjVzz4eAw/oBIV/WOuWaClfXOyKnqy8Jg4G6+mT5Z3/VBwg7qj0
X-Gm-Gg: AY/fxX66rpE/Dv51hoY8drb+ZBCwjxLV+0DiV953koYgVuW8FucPF4/QssE8Azl+Yhs
	/gR1oknIBF0L7ylqUhsGmEzg27fi5uwPDEaCYZ5K83XWrZ4gL013vkjFwsRagMNEoipqpyqiRc6
	JQp0W7jKUCYkt6LQGanTi4VpoiaeURSQ9ENyqe8X8aYfUES3hFpKjcZJMoUGdpRFGJRkC3rsV/2
	hv37phziaIk6whZRvWAHpdLjP5qTE93LUYkrO/0prarTIiCrYEmaQKUuEhB6gECMHFZTnQ3M+Q6
	cm27hzs9WQybT5hakT9ub980H2JbpL4FUTP7grIqIg+GnBYxIcxQTnkrDunqN5P9Rab8miUOVva
	p9VjYJ9irNP/cj7pnFyAO9WJMw2LwC4rAsbnanu6mwrh460wF9n8S6okFWIIpbvS2aMlVdGdAzW
	fpsyGQ5WZhYZ9zgAbCXAyBOiNpyR1zmFkie5OEVIfyTCs=
X-Received: by 2002:a05:6820:490c:b0:660:fd8d:954e with SMTP id 006d021491bc7-661179cc735mr3331882eaf.42.1768762659937;
        Sun, 18 Jan 2026 10:57:39 -0800 (PST)
Received: from newman.cs.purdue.edu ([128.10.127.250])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-661187820a5sm3867685eaf.10.2026.01.18.10.57.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jan 2026 10:57:39 -0800 (PST)
From: Jiasheng Jiang <jiashengjiangcool@gmail.com>
To: markus.elfring@web.de
Cc: almaz.alexandrovich@paragon-software.com,
	jiashengjiangcool@gmail.com,
	linux-kernel@vger.kernel.org,
	ntfs3@lists.linux.dev,
	stable@vger.kernel.org
Subject: [PATCH v2] fs/ntfs3: Fix memory and resource leak in indx_find_sort
Date: Sun, 18 Jan 2026 18:57:36 +0000
Message-Id: <20260118185736.41529-1-jiashengjiangcool@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <17914287-640d-4500-b519-5f3d3aed2878@web.de>
References: <17914287-640d-4500-b519-5f3d3aed2878@web.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function indx_find_sort() incorrectly uses kfree(n) to cleanup the
'struct indx_node' instance in error paths.

The 'struct indx_node' is a container that manages internal allocations
(n->index) and holds a reference to a buffer head (n->nb). Using kfree()
directly on the node pointer only frees the container itself, resulting
in a memory leak of the index buffer and a resource leak of the buffer
head reference.

This patch replaces the incorrect kfree(n) calls with the specialized
helper put_indx_node(n), which correctly releases the internal resources
and the buffer head, consistent with other functions like indx_find_raw().

Fixes: 82cae269cfa9 ("fs/ntfs3: Add initialization of super block")
Signed-off-by: Jiasheng Jiang <jiashengjiangcool@gmail.com>
---
Changelog:

v1 -> v2:

1. Add a Fixes tag.
---
 fs/ntfs3/index.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/ntfs3/index.c b/fs/ntfs3/index.c
index 7157cfd70fdc..c598b4b2f454 100644
--- a/fs/ntfs3/index.c
+++ b/fs/ntfs3/index.c
@@ -1248,7 +1248,7 @@ int indx_find_sort(struct ntfs_index *indx, struct ntfs_inode *ni,
 		    sizeof(struct NTFS_DE) + sizeof(u64)) {
 			if (n) {
 				fnd_pop(fnd);
-				kfree(n);
+				put_indx_node(n);
 			}
 			return -EINVAL;
 		}
@@ -1261,7 +1261,7 @@ int indx_find_sort(struct ntfs_index *indx, struct ntfs_inode *ni,
 		/* Try next level. */
 		e = hdr_first_de(&n->index->ihdr);
 		if (!e) {
-			kfree(n);
+			put_indx_node(n);
 			return -EINVAL;
 		}
 
@@ -1281,7 +1281,7 @@ int indx_find_sort(struct ntfs_index *indx, struct ntfs_inode *ni,
 		/* Pop one level. */
 		if (n) {
 			fnd_pop(fnd);
-			kfree(n);
+			put_indx_node(n);
 		}
 
 		level = fnd->level;
-- 
2.25.1


