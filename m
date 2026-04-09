Return-Path: <stable+bounces-235450-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ALwiA6DX12mDTggAu9opvQ
	(envelope-from <stable+bounces-235450-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 18:45:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 825FE3CDC40
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 18:45:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8FB683007E30
	for <lists+stable@lfdr.de>; Thu,  9 Apr 2026 16:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBFEF3B19A1;
	Thu,  9 Apr 2026 16:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aECkl+1p"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B8F333E37D
	for <stable@vger.kernel.org>; Thu,  9 Apr 2026 16:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775753097; cv=none; b=kQ1S4GkxK2qGVjcyWXjBLvVFmsqFrujgT8n9SQTAtY2YPTWCFN9E8qmYfKDVoAL77csISyOcg4EOIWdIY/uJ4XXvMaGuzGYDni1gGF/RVe0f8FN1Bd0gW476Gcyb7/VbLbpRfr5SN/2sZE+Djy5yXtZZ0Hhj4V+Q/lB0NN/3Q6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775753097; c=relaxed/simple;
	bh=at+Kn5WfihQjcm4yibzwdlxwqIWstwl1ozb+5Syumys=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Zy/B4NIZ3D7n0UyQmappmz78na3b+JmOjW0nXioUlHe5ZU80ieRoSgZc+L+sV9OgObAQ+u/kkjq+pysVBzOYmOgaWs5pvmgJIwz5+f/RC079Mn1ajNDgDcwMITur93UPrsWGZDENgfalFwNUqs6NujCHnaNhwYhcjGrQV1MJKKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aECkl+1p; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-56a9a7e762bso951802e0c.3
        for <stable@vger.kernel.org>; Thu, 09 Apr 2026 09:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775753095; x=1776357895; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UszRydjgnil6xCBl66k6CnSI51I6E8fv26ecdhZ21os=;
        b=aECkl+1pZW+aSrZzxOxl787F2RCnFCMLM0I2UAuLCv1tBem9tKUD4tMhzP0t7LsLiS
         LWJaFUaj6jXkOyCaIx02TODG9SR5guhTC0MCksLrw153FjGVXDFgAw11pgCqUCAvYZzl
         WAUHkaIZZOPC3u5SeFlJAFMTS4ZNJC7aLuwiqv9aRHqKbPBhqM9p3gPvR1fNv2VqxHFc
         Uar9zzZjfxg0h7JMUqC2UjOk8Z2WGPf6a45Srlc++CMCW9dB8mp/bH6HrxP+7qSNlMtT
         1zlupp+bUmHXOkJr2ITjwW7IIL1TLSZX6lTs9tVM647Yz0dISgO0q+GG44H4QCpdMXRn
         A38g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775753095; x=1776357895;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UszRydjgnil6xCBl66k6CnSI51I6E8fv26ecdhZ21os=;
        b=tEK3AVLiRG032g06e8u+vUCRKyJcXd0NiEsEQSSIzn3SQfT7lj5jaGyNBXGbou7xAn
         Q8RLDzWuP9GqnwPRLZAgBUxujQq2jwIur3SS+mtjt9cW3H2nhNUBLpdq0WZNVl2x0QQA
         tnzp/xO+jebkZW+PYMwKI9dOjtffwclJLJPSILRclYBCVTxHek9M9n2jJGvb4I1qVHlN
         8h0v2L0MDUa9EgAyobone8rFTZdKQg4qN+pXcou4sIIkJa7QL1eZez2ht7dom/58LSx0
         EcuGkFXdRzDqCj782uxi0eyCZaQl91KN8lp7J4k+paJDhEwWJVHML4yEQNIdq7zl63dB
         8/Qg==
X-Forwarded-Encrypted: i=1; AJvYcCUh7ASr6Hz12g2+OVSsZuLz+CQ7N1J5PmkMwHydrJnomzeMpgBsnWhcTAlJ/SMwRKlDwM+5YHY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywg/YMxKs0/vCUNM+MQi62vSsvR79scjvJg59tp37uI9FkUSR++
	wXStnBufRYo1P2FadrfQbaaMSaCa56+mmKgaB0yIt1KbBdn7xLo5o5GQGyTmXasv
X-Gm-Gg: AeBDies9Wi625L8UI9U63hrGCMUT/JbQpv58kZ81z2Wa48h3yIjHby4Ma2Q5GVbP3hb
	QlubjCH9sDBLfuYRrsO43y3sLvEs24gXBxORnakP/VqyrgPDfxSc3FSwY5PKRLMvx8CRUUdFaUs
	GXHwb41HHwslmq7Gbhibwnx0DoeWIQpxq22Z8WNhefrxUlLrLsNr2XPXs0iyDJQyfUz6in/JhZO
	vdCyCSQPq0bN44HqKqs+J0Bue5OKHHN7uD2joetKZZgT37Eu248qDFhsGzSmojMYTYmfsNxTNay
	u2VV0RfsKI31qOPmsDbqQFuVjBIRsK5tXfGtyt3/iSoYk5Ofn6MDbRPyazd239Uja4u3kqpi0Kz
	ELkpXWDh8+qmOM19VC9Gd67dhHWPenY23C9ycOfEvbE5lpWsVVaVJPr3zimodU60wcBos+KY78F
	BfTpbTHWasFj9nud8ak600dW9lyQ==
X-Received: by 2002:a05:6122:4d0f:b0:56e:f2cb:190b with SMTP id 71dfb90a1353d-56ef2cb2ab1mr8821130e0c.0.1775753095396;
        Thu, 09 Apr 2026 09:44:55 -0700 (PDT)
Received: from localhost.localdomain ([2a09:bac1:76c0:1048::11:163])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56d9bc9b75dsm22740384e0c.12.2026.04.09.09.44.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 09:44:54 -0700 (PDT)
From: Sebastian Alba Vives <sebasjosue84@gmail.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com,
	jerome.forissier@linaro.org,
	stable@vger.kernel.org,
	Sebastian Josue Alba Vives <sebasjosue84@gmail.com>
Subject: [PATCH] net: nfs: fix buffer overflow in nfs_readlink_reply()
Date: Thu,  9 Apr 2026 10:44:40 -0600
Message-ID: <20260409164440.323405-1-sebasjosue84@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[konsulko.com,linaro.org,vger.kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-235450-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sebasjosue84@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 825FE3CDC40
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Sebastian Josue Alba Vives <sebasjosue84@gmail.com>

nfs_readlink_reply() validates rlen only against the incoming packet
length (inherited from CVE-2019-14195), but not against the destination
buffer nfs_path_buff[2048]. A malicious NFS server can send a valid
READLINK reply where pathlen + rlen exceeds sizeof(nfs_path_buff),
overflowing the BSS buffer into adjacent memory.

The recent fix in fd6e3d34097f addressed the same overflow class in
net/lwip/nfs.c but left the legacy path in net/nfs-common.c unpatched.

Add bounds checks before both memcpy calls in nfs_readlink_reply():
- relative path branch: reject if pathlen + rlen >= sizeof(nfs_path_buff)
- absolute path branch: reject if rlen >= sizeof(nfs_path_buff)

Fixes: cf3a4f1e86 ("net: nfs: Fix CVE-2019-14195")
Cc: stable@vger.kernel.org
Signed-off-by: Sebastian Alba Vives <sebasjosue84@gmail.com>
---
 net/nfs-common.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/nfs-common.c b/net/nfs-common.c
index 4fbde67a..72d8fd82 100644
--- a/net/nfs-common.c
+++ b/net/nfs-common.c
@@ -674,11 +674,15 @@ static int nfs_readlink_reply(uchar *pkt, unsigned int len)
 
 		strcat(nfs_path, "/");
 		pathlen = strlen(nfs_path);
+		if (pathlen + rlen >= sizeof(nfs_path_buff))
+			return -NFS_RPC_DROP;
 		memcpy(nfs_path + pathlen,
 		       (uchar *)&rpc_pkt.u.reply.data[2 + nfsv3_data_offset],
 		       rlen);
 		nfs_path[pathlen + rlen] = 0;
 	} else {
+		if (rlen >= sizeof(nfs_path_buff))
+			return -NFS_RPC_DROP;
 		memcpy(nfs_path,
 		       (uchar *)&rpc_pkt.u.reply.data[2 + nfsv3_data_offset],
 		       rlen);
-- 
2.43.0


