Return-Path: <stable+bounces-223396-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YMyMKFhcq2mmcQEAu9opvQ
	(envelope-from <stable+bounces-223396-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 06 Mar 2026 23:59:36 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 04965228741
	for <lists+stable@lfdr.de>; Fri, 06 Mar 2026 23:59:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 288393014C34
	for <lists+stable@lfdr.de>; Fri,  6 Mar 2026 22:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84A4C35F8D1;
	Fri,  6 Mar 2026 22:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SLtzqqsx"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DA3D35F606
	for <stable@vger.kernel.org>; Fri,  6 Mar 2026 22:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772837935; cv=none; b=ncNXxCLnVqCzphFyB41sUNtCntM945FtEUj8KibzOVaBExPeiBIIBGalBsZ+7mD2PYT3+H9S6TkyduP+ivop3pv4dBS7ASbKHd+/c8sSm3n8Hgbjkdppb0E9zVxDc57yKKcxeIrqunx/MJhpZgx+Nt2lpxRyaEUE9sLjwvyxPGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772837935; c=relaxed/simple;
	bh=N9y5RAhCYUKybIGpF6z0XyF0IhHLh1Xb2RsgvYslKwk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P3uMpWajDBiYizoCHWNa2E5B//OLJGTOZV7Id4znxU1iSf3JEqaWgqk/0Mbx/QUBdpyN+MstiUQawpJv+X8DugHxnGEetGb5UubnhNCS8En6i0tR4HT848+sPGvUp/2B4LhWr6H2giks1U8ZSlzXJkAY0TtrdnBPpcZJXmJpiEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SLtzqqsx; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-5062fc5d86aso85475891cf.1
        for <stable@vger.kernel.org>; Fri, 06 Mar 2026 14:58:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772837933; x=1773442733; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=67LeBKFGIlYmB6wwTDabvnEnjwEifdPbBlAfgz15b6k=;
        b=SLtzqqsxvsgKHxIvA1sSNrxjDCUIOtAcHKSL0+ru7FRbzOqlWrelAYsKtezfYDKlMJ
         W9V631gz+0e32dB6MoTXnFwF2ogOMeJKkpIBUHBa+EOAvks+pq/OBRLxuMVloaunDx/e
         NKX9wi9E7+au/AoAqSBKogr7WCRiZJtTdn17EZb96SdTboZ6MO+KUdMIaBLGM2ZZ94SS
         +CSC1hGUPne4WdU1u/4rChcJpPy7oAmq6Juuk3R1fp3KM/ooZrRiZJ/xIVvEpS3dAi7i
         3kRfaBBywwCwXZgA3A6nUEO62ausbD6FspD994Hxu3g3DlBRAtlDT+53mDOX8Gq/e2i2
         kMHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772837933; x=1773442733;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=67LeBKFGIlYmB6wwTDabvnEnjwEifdPbBlAfgz15b6k=;
        b=XoFRm8ZSxrDlWjzPuxNad1n1ojAx7ii2/xANFsGqMt6M7Fl0fFwMgJg6iNwR+6M4lv
         uxQMd119d54MBLkrFfAkeZADbtAY3Ch1DduWmzFp3LeKzXdThGgN/5FO+8ZTyShYxvim
         A6vu3a9plCLvJkDi5pHZhcRQrdfY55l9i+iFgE5jYehCUnhvshBy2IXm6kPdgVD1MLNo
         YwjadwC7BSu4dzQZV5ryxgEXOb5VmF/t4BYm7iVAWjH06mCkrpcR5CLGsTmbCPDbLjV2
         HWUx8eQICeg/GmrRyA23EZmUQtN9pqP7Mcc9Tkcl63K/861B9IDutSaXtaWPY4YeNI4E
         dVXQ==
X-Forwarded-Encrypted: i=1; AJvYcCV3TD1nXLXFs9fcpax7Tabh6Iq4iJWKo+XW/t1UNmZBvo3Ff8siqCtYjk3j9ysMfI/KOwaWrxo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8aq1aY8aKDI44OuBZXV9kf0+dxdDllqPNiwiKMOOEolPPYsnh
	4sLTnkHkdqrSgNk4IlcFE0p1kWXH5gY2IdFL/Gqt1Sy2HEf0psbwimO3
X-Gm-Gg: ATEYQzwcvlr63a3Xu+q8dSzmEkkXlUtFjctirh9TR85OwpalFwXOZybvYcXY2UVIq4/
	P2NhgRrs/xYYSQpaC6QZ1A1T2SDMHz5MgVCv7aR/T2g37if1heRhN28OWnNxKt6N2dqTpc/Y8yg
	M70qqKbNUapdoHyQllLAf4j5eXXFRp1V95wtr99krn9KQc2Dw/QlHBRy+mRsgXm0HotNHOrch3R
	BuXBX+B3ddiCnna36P9ngh+5V/owoKEjy+rx//7O7+Y8OWLUMcDrc6BYBUeJGojdSzaJIujcJoV
	4/gnmRTqyI2pfm7jILhH6JJIklpNUp8twWEcRq7sBA0MaCRQhAteFzLSpAUJxsbH4swZ1wW7IDo
	MB67Cawjc7qbbTCplRgotUWZdenjujcU/E9aNC2kKwdTsHFy+h3mDrJAISn//dqMSR6eqi4NnzX
	20b9Ft8NiOuel7Ar6K3EreZ2/aFnr8WMg/9G5ibGD+KLVPNC5po886FU75s6ZfpeCwERE7Arv99
	gCJ
X-Received: by 2002:a05:622a:14cd:b0:4ec:f56c:afa5 with SMTP id d75a77b69052e-508f4711c82mr49280901cf.22.1772837932908;
        Fri, 06 Mar 2026 14:58:52 -0800 (PST)
Received: from instance-20260207-1316.vcn12250046.oraclevcn.com ([150.136.248.187])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-508f651149fsm22754481cf.2.2026.03.06.14.58.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 14:58:51 -0800 (PST)
From: Josh Law <hlcj1234567@gmail.com>
X-Google-Original-From: Josh Law <objecting@objecting.org>
To: Liam Howlett <liam.howlett@oracle.com>,
	Matthew Wilcox <willy@infradead.org>
Cc: Alice Ryhl <aliceryhl@google.com>,
	Andrew Ballance <andrewjballance@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Josh Law <objecting@objecting.org>
Subject: [PATCH v3] lib/maple_tree: fix swapped arguments in mas_safe_pivot() call
Date: Fri,  6 Mar 2026 22:58:49 +0000
Message-ID: <20260306225849.2824409-1-objecting@objecting.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 04965228741
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-223396-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[google.com,gmail.com,linux-foundation.org,vger.kernel.org,objecting.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[hlcj1234567@gmail.com,stable@vger.kernel.org];
	NEURAL_HAM(-0.00)[-0.986];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux-foundation.org:email,objecting.org:mid,objecting.org:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,oracle.com:email]
X-Rspamd-Action: no action

From: Josh Law <objecting@objecting.org>

The call to mas_safe_pivot() in mas_wr_extend_null() has the pivot index
and maple type arguments swapped. The function signature expects
(mas, pivots, piv, type) but the call passes (mas, pivots, type, piv).

This causes the pivot index to be interpreted as a maple node type and
vice versa, leading to incorrect pivot lookups. In practice, this means
a null-extending store into a maple tree node can read the wrong pivot
value, potentially corrupting the range tracked by the maple state. For
a VMA maple tree, this could cause an incorrect vm_area_struct range to
be returned during operations like mmap or munmap, leading to silent
memory mapping corruption.

Every other mas_safe_pivot() call site in the file passes the arguments
in the correct (piv, type) order; this is the only one with them
reversed.

Link: https://lkml.kernel.org/r/20260306200820.2819999-1-objecting@objecting.org
Fixes: 54a611b60590 ("Maple Tree: add new data structure")
Signed-off-by: Josh Law <objecting@objecting.org>
Cc: stable@vger.kernel.org
Cc: Alice Ryhl <aliceryhl@google.com>
Cc: Andrew Ballance <andrewjballance@gmail.com>
Cc: Liam Howlett <liam.howlett@oracle.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
Changes in v3:
- Included a changelog detailing modifications since v1.

Changes in v2:
- Added Link, Fixes, and Cc tags (including stable@vger.kernel.org) to the commit message.
- Appended Andrew Morton's Signed-off-by to expedite merging.

 lib/maple_tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 5aa4c9500018..f82000821293 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -3279,7 +3279,7 @@ static inline void mas_extend_spanning_null(struct ma_wr_state *l_wr_mas,
 	    (r_mas->last < r_mas->max) &&
 	    !mas_slot_locked(r_mas, r_wr_mas->slots, r_mas->offset + 1)) {
 		r_mas->last = mas_safe_pivot(r_mas, r_wr_mas->pivots,
-					     r_wr_mas->type, r_mas->offset + 1);
+					     r_mas->offset + 1, r_wr_mas->type);
 		r_mas->offset++;
 	}
 }
-- 
2.43.0


