Return-Path: <stable+bounces-195392-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A563EC75F1E
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 19:42:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 347AF358701
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 18:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F12A368DED;
	Thu, 20 Nov 2025 18:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VYmvfNx6"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6755D368DF5
	for <stable@vger.kernel.org>; Thu, 20 Nov 2025 18:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763664169; cv=none; b=Grn5Toj0NYLXk2K867G32QbbPL1PS8vwPd39lJEpJKdUDsufTD/fx8r8ueBLEYMXXHpMFd99X6ONejuWJOaZS7KP4RwEOgebGz1czIR605FK31EUvVbEGtScwhu3L85rJyoXymGVgUAq5BhzQKhhSD9aqdAL2Po6lRQ+NBT9nbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763664169; c=relaxed/simple;
	bh=siy+keN0iuo5QUebKEOpIUF4lKjEhoZX2+I6swXKS/s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t6hIh/lO+Hf/X8Uex2BCWColuWXJCkMRLCv7vS9UILMoTJiN75Jr2sfpt2d+MfMmxbxdsaLVuExEt8RML67xSMIC5ym9Cm2zMwJphBMG8K5CTKteQhgTgdE1fk+evRf7jH7tAs8NrZ3BC4e+iSCr/H54PQuowgXtaWwbD8I8ORI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VYmvfNx6; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-343774bd9b4so973563a91.2
        for <stable@vger.kernel.org>; Thu, 20 Nov 2025 10:42:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763664166; x=1764268966; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4SdOHNqAWfToMGBCQSO9tHleaQeM6zla4PftQMCtKtA=;
        b=VYmvfNx6RKsqQfL2/Clrn2pwnWB3d5nGlBQPco26O9B6ibHMrXgmPl04tS8QuWQjBL
         +8nkgyOeZnPLVKOFWIvWcc6MklQALp2mEyAN/PBY/wsFv3UFd1EACoEpgLA8wCLK55r9
         mfhD3ipsIuuEl1gSF6Un7a6jmRO/Xl11W7tlsIDLwnBspU118xiPTgJyL3z34NfP1zp/
         KxLfNwJxy6MP/JoNDUTdGHXkXj3wgmgbIOJYXo3h/LlRhu2rXHc8y4jStJFwDlFu1SWE
         ZOtappjrL0Hc9bpSyp7mHyPPTdA2gMiQuRdV/7ayAFb65DFOuE1GbZ5VrF5fv/Vu5TxC
         BC+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763664166; x=1764268966;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4SdOHNqAWfToMGBCQSO9tHleaQeM6zla4PftQMCtKtA=;
        b=vAJ9KVE/UZDvojcHfvbN0YFHr7kE4cFaVHFOMCaqfhVKfex+rWkp5dFMj64wKP2YEn
         UakbVUp5KUqdemHHeT6AeUrPcr65RaxHbMiPWCb++p1I8sLNOorSqaV9XuDe66Yu5osA
         GlfDGu2lCtGf3yR3jh3pGkRPpysDDGFL23jKk1p6rT6ECzqmraxxuyjP6KJiiGD4GL4A
         c1twA7coFHDoSKi289gtA5mwRDQWU1y4fSQ7ogy1LVvoEYREFWe6nYrPYlU493dOgTFy
         K6Td+WWLrhhW1NthqX81EZVOujWT0T4QkIN96HBFLNUWBDBWZ4SKq7FQDntUJMSeq4kX
         JXEg==
X-Forwarded-Encrypted: i=1; AJvYcCUDLUG9xkjgDxUmIMSTugWUQeMF4JJ2fg5S7YOwiK5tBSH5Z0e8VfHqzCReU1hOtaMq+Pjkf10=@vger.kernel.org
X-Gm-Message-State: AOJu0YzL3jcoKWIsTjhIKhHFRonjBWgs8SDK4qT6ce+GiC/IlqqDuk0G
	uVgYnJVSbwtQq0BJB6N1mRrG3FJLoifrx1+jtol2ScmKTdp0/sVfpL5Q
X-Gm-Gg: ASbGncuyBb9vRRwbZw2KTZ1irBA8FgR6JH4vWBxZIPnNu8ShtYPN3E3x6+4scoG+HJn
	MhLvcLt5wbr+aaUxZ/ySRILADLadLU0PN4e3/TQMQyPXzNS7lEugKoSqcz1w4nLWAC94tOsKH1a
	mBTiZy6DaIhCle6lMA+DLdEJkt7/eCZb5bhZ0WXGWjEbvlLsxs/elC+Ii1FWtmMdpQXmzyvYokz
	DzzCgO+trw8vLDxWGbALFo3VKqTFjUUpe4FYboD+lOAz8HlAag28w5PTeZ2Mjgfnz6i9fv6ninZ
	82F9AAJ68eHardoDwlPp5CkrGtk9wfX3dDzsQZ0KUDUurKwu9V34FSTk6a362HxyRG4AawU5rEy
	v/A8/L0FN6tTCaf73yhMwBg38oBZtmitH/0j1VsRw3E5GWkzy5aVTLF4Pfcya7vMv3skI8OrJag
	NebzromKDLQsFxiqc3
X-Google-Smtp-Source: AGHT+IGMQdvAAHN149Yn6LgRqFI4HzPl0k7Zd7jTCi6NSREDlb5zLOE7+bQWEE9AUu/iFrbJVTRTJQ==
X-Received: by 2002:a17:90b:274b:b0:340:d1b5:bfda with SMTP id 98e67ed59e1d1-34727bca9b5mr4408688a91.3.1763664166234;
        Thu, 20 Nov 2025 10:42:46 -0800 (PST)
Received: from localhost ([2a03:2880:ff:5::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3472693c501sm3229945a91.16.2025.11.20.10.42.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 10:42:45 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: akpm@linux-foundation.org
Cc: david@redhat.com,
	linux-mm@kvack.org,
	shakeel.butt@linux.dev,
	athul.krishna.kr@protonmail.com,
	miklos@szeredi.hu,
	stable@vger.kernel.org
Subject: [PATCH v1 2/2] fs/writeback: skip inodes with potential writeback hang in wait_sb_inodes()
Date: Thu, 20 Nov 2025 10:42:11 -0800
Message-ID: <20251120184211.2379439-3-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251120184211.2379439-1-joannelkoong@gmail.com>
References: <20251120184211.2379439-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

During superblock writeback waiting, skip inodes where writeback may
take an indefinite amount of time or hang, as denoted by the
AS_WRITEBACK_MAY_HANG mapping flag.

Currently, fuse is the only filesystem with this flag set. For a
properly functioning fuse server, writeback requests are completed and
there is no issue. However, if there is a bug in the fuse server and it
hangs on writeback, then without this change, wait_sb_inodes() will wait
forever.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Fixes: 0c58a97f919c ("fuse: remove tmp folio for writebacks and internal rb tree")
Reported-by: Athul Krishna <athul.krishna.kr@protonmail.com>
---
 fs/fs-writeback.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 2b35e80037fe..eb246e9fbf3d 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -2733,6 +2733,9 @@ static void wait_sb_inodes(struct super_block *sb)
 		if (!mapping_tagged(mapping, PAGECACHE_TAG_WRITEBACK))
 			continue;
 
+		if (mapping_writeback_may_hang(mapping))
+			continue;
+
 		spin_unlock_irq(&sb->s_inode_wblist_lock);
 
 		spin_lock(&inode->i_lock);
-- 
2.47.3


