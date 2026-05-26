Return-Path: <stable+bounces-254228-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wCPkKP7qFGo+RQcAu9opvQ
	(envelope-from <stable+bounces-254228-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 02:36:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 513155CF498
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 02:36:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 70306301991B
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 00:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F9BC274B4A;
	Tue, 26 May 2026 00:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y9AIeJka"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E14272801
	for <stable@vger.kernel.org>; Tue, 26 May 2026 00:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779755746; cv=none; b=mGqsCtEV2fXL8RiaK7frRJeUei5tveHisCL2rRWVKeAxeeesG1QD1bg4hERZ8zYM9b858WeypKiIEbaNI8ZwnterkgvtoMtZdDTBeKZP4x/uPciS70blOCirHXnuwfWVB7W3+xYKILbRmJ6FpH9YGbIz3Jz6lx5LR6gczIl1LCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779755746; c=relaxed/simple;
	bh=aI73dLAsoMnIz2OoRYSyNZeZBTVcQgWYmXKRdLg8hGw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nAg9+mC5+rrE+CJwCpvo2McEdB0OaMTafKeD9cTptJuvrVkeGSSy6cwDAW8fsFbqpxaYZDlsS2ciyYkKMYz6Q3jKniWKpZlGpvocwAUQBNhwPQteNhCAgnGsN6A4ab7fitHgfe96xG9zWnVio+93yMIw4Pr10+8VqvZZBErPPHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y9AIeJka; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-57746f02da7so6649530e0c.3
        for <stable@vger.kernel.org>; Mon, 25 May 2026 17:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779755743; x=1780360543; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xBgWuooGCwcYgQ+uND+oHD3Fi2ceyxPTaalSlSWEF5A=;
        b=Y9AIeJkaDSlZBfKPPfNoVDKTiS0PN8NGFY8+O915yNrpd319YFvHQTSn0d3duhIWAD
         ptcE4C8ks+HFox+IgxdqhuTLWKrhwFZjF4eK+4dKlyEf4PlsYVLuVVItFsxyiMby7bqS
         XqXbv4QD2BkK6jqTtZLLX2WufPpVJ1OZQXOoNKPIV6hm2ltvD/uY6XiZg74AMfI7i+53
         mZdUZjTIapI3ULQLxbckjJKfPGVFZ1UE02Fd7s/JJhgew//5PMXJn4DRYdBBjKHHq9tI
         VdN+JmLb8QyS32zYvnq6SsHZY9BeJTsGUUnRc5FsF+Dlg7IFPhiUyVjwHkHdMUaNPqdR
         y9jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779755743; x=1780360543;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xBgWuooGCwcYgQ+uND+oHD3Fi2ceyxPTaalSlSWEF5A=;
        b=KibgTB+xjWMwMSxifi+eqdKpSjOwZfmRIXlOt6eCREFkhsx0205Lp8vFmy59uQcGgb
         btRsRxS+tkXPExP2x3BAg0ut2GM25vDqh9IUvvkM2PvRqmEP0jJTfl2mb6TkjFIxSb67
         m8OVjDL6UOhXS2BTJTvO7i7dVnMseki2cwXQ7WD0m1yJzS6qI+PXNv1TLPlCShpY596i
         vmt61VBh+w8NQXjKKgEt+lDhioLaRNhXbb+svOop/Fmf+7igt0QN7Kf6Ob+RUag1hMv2
         tes6dpQcXgrVJWMXByKPY18XgivD9u6WtfVmcQqFYSXn+LBOtmPp7JzXI69addf5NG2I
         FMsg==
X-Forwarded-Encrypted: i=1; AFNElJ9monxc3u072HCkhvPVeKn1DJ8gKAODCnELGJrFcOl9SImyAzI4pd0hnlpr23iTKJx/3DuqjR4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtElYeIBg5bvi40tJbLLyiSRN5XTyyB2HI+yCPdA70WdN3sNZh
	3cnDpZuBfzOQP72Ok8hsaopOJuxV4xQGG+SlgrbRf8csv/B6JE1E0FhM
X-Gm-Gg: Acq92OHXzAECdRfZmby79JEiTMtN6NWSJzdtb2KaSfG2QGRRJO0+xAOIEESdip+gEhZ
	HA2ocYvD7FaU5rVkbKlqjSqgkOecHUP3oNc8bAlH7DsbYX8LKMnPh+TlKrwSXKzQXLf512278u3
	FyBeHSvhbT6YaF9mUAodax+28o4UxCgFlC/gP40EDGMMXim5VlONyeHUg2D/PzMZ8rDODTlgeBk
	iv4U90qtweFMOtxX/oWkEtjSKYAVnTbeoR8HAR41/MsQX8CNr+JRQbgLle3V9nDVOMTK/C+8CWG
	jN4KhBHrzTtZHSKFt0j1Ha7vT+KUxsG9HBvA++o/xHVr/ZYr/7O4ckt8JMGv+8sxDPAgi5oO0G3
	xxHPYlyue+Od9qth9ECz3GCZE/n3yb5/Ws28h6upHXxYTjsHTzC3fDYnE1F5mGXVtbWTaDJVZJe
	aKQe72n8UoXlGCPKEZ5QazP4KU6eXpy6XTN5cfaZ+IcCL4dNhJsUS13DwXKtKxgaU0JBc2a1auW
	UyU7qTe/xjY1G7rwpJPLPkZyhEUTzZv5UAL8sQiif+DevUwFF2O5Q==
X-Received: by 2002:a05:6122:e250:b0:56d:2ca7:fbc3 with SMTP id 71dfb90a1353d-5865fc0355cmr8472321e0c.5.1779755743551;
        Mon, 25 May 2026 17:35:43 -0700 (PDT)
Received: from sekiura-Standard-PC-i440FX-PIIX-1996.. ([186.122.244.96])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-586f791f719sm13955006e0c.11.2026.05.25.17.35.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 17:35:43 -0700 (PDT)
From: Takao Sato <takaosato1997@gmail.com>
To: netdev@vger.kernel.org
Cc: steffen.klassert@secunet.com,
	w@1wt.eu,
	davem@davemloft.net,
	herbert@gondor.apana.org.au,
	chopps@chopps.org,
	pfalcato@suse.de,
	stable@vger.kernel.org,
	Takao Sato <takaosato1997@gmail.com>
Subject: [PATCH net v4] xfrm: iptfs: preserve shared-frag marker in iptfs_consume_frags()
Date: Mon, 25 May 2026 21:35:37 -0300
Message-ID: <20260526003537.998848-1-takaosato1997@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260522142504.1394864-1-takaosato1997@gmail.com>
References: <20260522142504.1394864-1-takaosato1997@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[secunet.com,1wt.eu,davemloft.net,gondor.apana.org.au,chopps.org,suse.de,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-254228-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[takaosato1997@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 513155CF498
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

iptfs_consume_frags() transfers paged fragments from one socket buffer
to another but fails to propagate the SKBFL_SHARED_FRAG flag. This is
the same class of bug that was fixed in skb_try_coalesce() for
CVE-2026-46300: when fragments backed by read-only page-cache pages are
merged, the marker indicating their shared nature must be preserved so
that ESP can decide correctly whether in-place encryption is safe.

Apply the same two-line fix used in skb_try_coalesce() to
iptfs_consume_frags().

Fixes: b96ba312e21c ("xfrm: iptfs: share page fragments of inner packets")
Cc: stable@vger.kernel.org # 6.14+
Signed-off-by: Takao Sato <takaosato1997@gmail.com>
---
Changes since v3:
- Corrected Cc: stable tag from "# 6.8+" to "# 6.14+". IPTFS was
  introduced in v6.14, so earlier stable branches do not need this
  fix. Pointed out by Pedro Falcato.

Changes since v2:
- Removed security impact paragraph from commit message as requested
  by Steffen Klassert.

 net/xfrm/xfrm_iptfs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/xfrm/xfrm_iptfs.c b/net/xfrm/xfrm_iptfs.c
index 97bc979e5..4db85e158 100644
--- a/net/xfrm/xfrm_iptfs.c
+++ b/net/xfrm/xfrm_iptfs.c
@@ -2168,6 +2168,8 @@ static void iptfs_consume_frags(struct sk_buff *to, struct sk_buff *from)
	memcpy(&toi->frags[toi->nr_frags], fromi->frags,
	       sizeof(fromi->frags[0]) * fromi->nr_frags);
	toi->nr_frags += fromi->nr_frags;
+	if (fromi->nr_frags)
+		toi->flags |= fromi->flags & SKBFL_SHARED_FRAG;
	fromi->nr_frags = 0;
	from->data_len = 0;
	from->len = 0;
-- 
2.43.0

