Return-Path: <stable+bounces-225576-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aAVUDDkhuGmdZQEAu9opvQ
	(envelope-from <stable+bounces-225576-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 16:26:49 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 88E5029C4BB
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 16:26:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0A032327D47E
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 15:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 807A931A807;
	Mon, 16 Mar 2026 15:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BkRj1vQw"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1358819ADB0
	for <stable@vger.kernel.org>; Mon, 16 Mar 2026 15:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773674209; cv=none; b=aT+Nr4aUfbrNQo62YJKHt2bRmriyptmBpUmmuthtRuiToO0fJb8TNnbPnP49Db+gnFJMQnca1Rpk6b8pd4sLpNg8cz+EP/ufN1aGjRuehKb8fWlVrIx82gF0E5B0cbLWqCwIYlIijVY1+D5vumAVy8aoq8QGt7ZHE3mPINm3IM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773674209; c=relaxed/simple;
	bh=AYgreJrEMOBolclyn/OmUTGFy0iYyGaUnfeLO4Yf5XY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ULt8K7ZsX/YczO9TmxFyvSQuICmFtd0YPT0nsS5WU+UrgUiskcvPiIFvsb8sfGam9QjTED281n31muLrg29wpxtyScD+p0RCIH6Ik1ZKCaEEGZZnkl7yssiaoEj0jm/5mdbERws2T3vSu7ul7YpaYBWcqOojNYuDzaV+Ip7b7+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BkRj1vQw; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-43a03cb1df9so4635364f8f.1
        for <stable@vger.kernel.org>; Mon, 16 Mar 2026 08:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773674206; x=1774279006; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GVRLeXaP+scdPe7yJ2McKwjwTUisbGcHJ9Hw5wkSV2o=;
        b=BkRj1vQwT3EXysbwEAufBqOPk0zimzTvFXSYsceOTO9/+PYA6pEHGt4lmPNGYokSJF
         51l+58QeSUNIWlVxMZZG/HU+tv8Btaq/dDa1ZwUzPT+khqZiNOrPbutJHYMNoK+z43gE
         AJfh0djcWXys9J04zwuIwMfR1gCM3pwSxO2n4aF4IpxNR1YZvamdhaL8BbB5EmVtT+eI
         uKMocNWwY6LIY18sluP0xLykNXgMG94+tf1kDKcYSHldq+zUXEJlTlJY7dRNQG6XfUys
         9R29n+C2nEthc67D9IezUz92bu+lzvS5hnJRpQwSmH9woHF8dZy1hI2O2IRwFkYST8hq
         d9mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773674206; x=1774279006;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GVRLeXaP+scdPe7yJ2McKwjwTUisbGcHJ9Hw5wkSV2o=;
        b=CL4oE/mdoNRrwZkCZPFm2ne5JuPnN9k2HZSbuthvzeY4OvwbOPWm+irTadJKlpVRx6
         ABqMR4oQxi4lZhZN912CT5sOv8ZzAtpyRBkDH8KHbvqoCpKNdQAI8dwfBh/sD5eX2qsF
         WKCCBTFOD3TtF+y4AMjPeWQWWlEePlYiI6aZ1W1FEjZsmC7BRM3PoxKCk58Kw6F/ilKm
         dGFhV4o0uhPH70K5zd01RFzDiQjhrGTCDnRycElD1sb2h7uweMpsTZj8fMfB6ZOxiFHe
         P7KG1RUDcMrKGpUUUFTrZiYxOKaFiYwsKe7PVnlpMNr+O+IOfN1AurmQJRZiUUoiLtoa
         Dd1Q==
X-Forwarded-Encrypted: i=1; AJvYcCVgZ7v9tjHMzneon2EQq1DAAKtuK05DX5g2ExSkXagrFdc5hydwzi65vAmHjLQSfc8KPNvqw64=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRmW+qLojrsvZR1MStYUeadOLCqiGLn0OKVVcQZ8Y6NbSxSfOL
	yZgZwLD8XfgIEAVBRlBUQqIIZxd/t2RrNMqa5j4GTL6jQ64SnRKRVN19
X-Gm-Gg: ATEYQzxdEbn8/K4iktBV2h2pPOdWLOZdgJ6Y0WmgxMqqsH6Ak6U8zGOkJMaPdpBuV3R
	UI8gMcP+W6cdz09lKpbz2N9ZzKNbxdgXYAsaWB2ULzLPYdAX7AFC5yAdHGpMYdI+jK4bfBTqn2M
	mMmoIzPO/V/85DAL2IS3Gf6bAwQkgRmWZRHgXtSV45l9UpIXMuFkWxCVzHKcwIVrNB6OE9i9muE
	bdj/4jSSe9grQNM6TPxdyW3zKy0TORD5l44vpPZ8jB1zBBB8jr6+S9pnygVkvyURSfj/Di2/0Ma
	kZPXC0qRb92gG9SwAzlGQ1gGTdJxHwsRmpOnRXbElVXpZ8SDEodJdNRhvemKgXmLvEd33Risnqj
	gOF77Xss+8IeYcAuYdtU3CLb1i8r7vDLDDcxqvR6LYciM00A520eBlW/HgT+wYz7W6JfX3dPTXO
	mIu2ymO6rN5ojXnx3iALcpLs5er40q6/DQtAQ4ibDdQ9i9BgWpKyPoaIlcZw==
X-Received: by 2002:a05:6000:4011:b0:43b:4720:10f2 with SMTP id ffacd0b85a97d-43b4720135cmr3807182f8f.43.1773674206375;
        Mon, 16 Mar 2026 08:16:46 -0700 (PDT)
Received: from osama.. ([102.46.166.30])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b457cfa07sm6753634f8f.6.2026.03.16.08.16.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 08:16:45 -0700 (PDT)
From: Osama Abdelkader <osama.abdelkader@gmail.com>
To: Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Suren Baghdasaryan <surenb@google.com>,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>,
	Qi Zheng <zhengqi.arch@bytedance.com>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Osama Abdelkader <osama.abdelkader@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] riscv: mm: add null check for find_vm_area in __set_memory
Date: Mon, 16 Mar 2026 16:16:39 +0100
Message-ID: <20260316151642.13738-1-osama.abdelkader@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-225576-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[osamaabdelkader@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 88E5029C4BB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

find_vm_area() can return NULL. Add a null check to avoid potential
null pointer dereference, matching the pattern used by other arches.

Fixes: 311cd2f6e253 ("riscv: Fix set_memory_XX() and set_direct_map_XX() by splitting huge linear mappings")
Cc: stable@vger.kernel.org
Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
---
v2:
- Add Cc: stable@vger.kernel.org
- Add Fixes: tag
- mention __set_memory in the commit message
---
 arch/riscv/mm/pageattr.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/riscv/mm/pageattr.c b/arch/riscv/mm/pageattr.c
index 3f76db3d2769..46a999c86b26 100644
--- a/arch/riscv/mm/pageattr.c
+++ b/arch/riscv/mm/pageattr.c
@@ -289,6 +289,10 @@ static int __set_memory(unsigned long addr, int numpages, pgprot_t set_mask,
 		int i, page_start;
 
 		area = find_vm_area((void *)start);
+		if (!area) {
+			ret = -EINVAL;
+			goto unlock;
+		}
 		page_start = (start - (unsigned long)area->addr) >> PAGE_SHIFT;
 
 		for (i = page_start; i < page_start + numpages; ++i) {
-- 
2.43.0


