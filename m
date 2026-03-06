Return-Path: <stable+bounces-223392-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 7UpAKf1Vq2lRcQEAu9opvQ
	(envelope-from <stable+bounces-223392-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 06 Mar 2026 23:32:29 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 15F74228544
	for <lists+stable@lfdr.de>; Fri, 06 Mar 2026 23:32:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9EB67301E7FC
	for <lists+stable@lfdr.de>; Fri,  6 Mar 2026 22:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A59F635C1AB;
	Fri,  6 Mar 2026 22:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bts63cZY"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8734359A82
	for <stable@vger.kernel.org>; Fri,  6 Mar 2026 22:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772836345; cv=none; b=aND8LLrCms58VTKdh2OJXNuVqbwJgWRYsjItBZ6TKdgmBJja+Z8PCQJKkS22w1kapQ3lhMWTbVIB3UWg7iml0TfE/3yIKMY/HLRT68X0p6gBUJP8BBFdIQjSySoGtkJIAzYmMsGec5G2xoLEdpf23MNAwO6WCGsTKJILvIjhSII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772836345; c=relaxed/simple;
	bh=ZwgW5mqmBZmhObh+8kXu026Oudf7Atc7326Ev2z66MU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YUOiakdZC4rDDJ9Z4e174qrwhfY1Fp5ACy3gkFqGnmHLlUvM/qIXINeFUvY9SrFxY41zd6UX99Zfu2XUWCdfNWaLh4iJJeOIxqjAxMMUeenlbpFgk7x9JunKbBKsG6YDo08QktW1a69NdF4QareBYtPvHs8ztSy68qHDlnx5fq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bts63cZY; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-8cb3825b0fbso953788685a.0
        for <stable@vger.kernel.org>; Fri, 06 Mar 2026 14:32:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772836340; x=1773441140; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=I43ZwIkTjWZSMomwFvfbkGBzNSzBl77P1JqN/Y31gvA=;
        b=bts63cZYPq21X3a9+Fl5lftZ5V/5YJNIXa3JGs+ZRJggTJdApU3n76L9fplCcZ+9Mg
         3ctaZ0yqrNzVpEQhdc9NdfWU2UwTVV3Hd0uWfoKN6vFuHXTlg5mNEF3yJpWxxE9zJTI3
         tTTgeyks2DAxDXqr/3TjLX6AT5HBw6SB8NYvm1z547k+CWZzV8VeT0G1oX58ibCLh64u
         ZVqynkPIt88cHhXr7U/gUcoJf9gTUa/grE6TJE40xUu2M/bu8gO7031hmIYtry+ud4vB
         Eb4lsN6Q/8x7ye4mXXwXIhG5RBC5o+Ye7Dn7mtqHNu+Q7ygGV2Zm8DuGBbxLBtrBSKUn
         s46Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772836340; x=1773441140;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I43ZwIkTjWZSMomwFvfbkGBzNSzBl77P1JqN/Y31gvA=;
        b=m+9V1omcy5PjvprhbqeV5WIkf59B/erOSSTWVIBKdRJNVdePuO30VPMMv/a9pbwi4Z
         MjB6ZvoVFP+b7eQf4TbgddWFDXielJefmVfrKVXuxfDcC+nYlrp2moSmUMst6uC32+Gh
         Gl9rUsqSXfOQ2RbZAwo3+PF1P8lw+3vnBhWelVyXMLKpBkH0BIhDWTepCEhx7jsPEl1S
         XcDwyI4L46eL/Vtnj15zRILQDKgInNhrcJXkdgGBKSYf1qqph62LSJ4Svpc+yCSZs9Q/
         liH5BMMVwu73ujqrSc8KlWCNlm/t4tlZ0qBymq6iX3xYeOizqSWprrQeSBPGkSQ42/cN
         hBXg==
X-Forwarded-Encrypted: i=1; AJvYcCXXLsOqF+ILZefrW/1WNwCShIHZjaXYrZ1nwSFGXFd/3kzF02ANiRKGDtwcwht4Iyra0577JUc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwADWPP+712mr1kvle7Q0In3TfvGZm/noUohikmY6WGmGu64iip
	V73QfoU9vX2/XYp4ewxjoVjccuRFMLWVNp9CxDet1WRV0V2+WSy698OM
X-Gm-Gg: ATEYQzzTKw0sBjmmdRpVSEFGN+7SHnh8WuLKi9MjWs2iAJjdda4X7mM40UTSDXSTgix
	H04bMy0lubYqNByIYGYuqbJvRa6htNGRM42xSm5c5pjxmO3y4mH1urvMnvDIY8nBRMMoN1Rpoi4
	cYFvA9hjC4xGooUovBxPNR/y2HMKXLAEB9D8dfjhrC/7CY3bY2O9aPQlw4VZjFCewjfUai/iGxL
	ZNLKkEH/byWpflFsde63uxszALjF+O6NiRKhv0sewIydaC1mvbIlizEU2VAheegEFKEYKDLjuaf
	MikoHPFtCLhQDw5WUoYf9U1TBDWyux08gPkdvi5lGZVm5uwp7QJDq/x90SCRUFBkQJkKx++h+FM
	5VoHTbbW/ec7EOxagVY7wdzqfqVXAWLvNELEhDnZRuogVAi1hHDVSmOwWykg2i88y4u4GMXKhtn
	1sDlLntGNZY+UhCj8Sfze8dWR/Fcj4eRo+Ot0nqVRCKgiJPtaHg43F024DKI/MVVusLX3T4yopi
	xPLH6qJtUmV/Ic=
X-Received: by 2002:a05:620a:1707:b0:8b6:134e:22f8 with SMTP id af79cd13be357-8cd6d51347bmr471278085a.60.1772836340486;
        Fri, 06 Mar 2026 14:32:20 -0800 (PST)
Received: from instance-20260207-1316.vcn12250046.oraclevcn.com ([150.136.248.187])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cd6f4ab874sm196429685a.22.2026.03.06.14.32.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 14:32:20 -0800 (PST)
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
Subject: [PATCH v2] lib/maple_tree: fix swapped arguments in mas_safe_pivot() call
Date: Fri,  6 Mar 2026 22:32:19 +0000
Message-ID: <20260306223219.2824040-1-objecting@objecting.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 15F74228544
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-223392-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[google.com,gmail.com,linux-foundation.org,vger.kernel.org,objecting.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_NEQ_ENVFROM(0.00)[hlcj1234567@gmail.com,stable@vger.kernel.org];
	NEURAL_HAM(-0.00)[-0.985];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,objecting.org:mid,objecting.org:email,linux-foundation.org:email,oracle.com:email]
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


