Return-Path: <stable+bounces-233869-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cIHaMzpE1mkFCwgAu9opvQ
	(envelope-from <stable+bounces-233869-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 14:04:10 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F5D03BBB65
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 14:04:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B048A30330B8
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 12:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7807C3BB9FA;
	Wed,  8 Apr 2026 12:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R60ZS7am"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 084E23BD258
	for <stable@vger.kernel.org>; Wed,  8 Apr 2026 12:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775649724; cv=none; b=Ss897DFz4dhXD2e8jpxS4oPlpO8Yz9KNFXU2btvtCjHKxGhoIPGh6QX/SFJQvDr8re9nUxzG6yJ3Qz6T+iSfTL/o5K125u8sT5SzeeE/gXOnrmGuCEYWssOwlUReB/8wl+Mxs2K5XXYIrYtBkeCXeivrWymiMqlu+03Z3NDZGEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775649724; c=relaxed/simple;
	bh=GdgHfu4NwRR5nHQPLhhd8u0gAQp21be2yqKo5lXv4k4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CP3jRFeREeSR4WPNs7Exs/eT/OGhFt+mWL46viYSU8H7OTtG/jxbNCnK5sQzJtE8kLTOxlaRSuLp29LPMuEzEjuDP3nAZVRDJIC394ou3i7l6rmAZY7F9P46noPC00Gn9EUKTuLlanV5czb0IXwz1keOQriWMqsqW2SUpTnv84E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R60ZS7am; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-82ce49785a0so2594227b3a.2
        for <stable@vger.kernel.org>; Wed, 08 Apr 2026 05:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775649722; x=1776254522; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PHdUj5TFH9dKxJLMiJUsQpHQaLsjedD8VYK/u5ysz28=;
        b=R60ZS7am8ikHKkUZLgQN0PLWPN0ZIXCAC+Ie1WkwR2cz02qjJ0q+BfyguPkocZexf+
         Zm88nyaqMrmvnpQid5vivRaiRV4JhAq7dP3OhvdlOraKEgqvHlHlXPsbCToKo5j+JSvh
         FhZ7J6JIEm4Zmco3BUT+EFA548+zI0A/9JU/EpUJQVQ1/OYj4a/1uY2Sjs2myh0+GCtS
         0VA0ok19DwYDJVONEO2gIcJLM+6yut+WmIb5+BN3MDyfv2QBYmEOyuqZh9dp8yiKbZ4k
         dtjxiWZAsrlzq6xmo2gf1aKF49MSCZ6kDtqZMPwOq2rYYVGR/fLpaAnz0E4gIFKHBlLD
         KMLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775649722; x=1776254522;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PHdUj5TFH9dKxJLMiJUsQpHQaLsjedD8VYK/u5ysz28=;
        b=g2mraIbgV/9dmX+r8OiAMimIS/m4+8ExsT9ZKjQwjhQYvObN6IlB51hEFGZzrUA3Tv
         FNeC5WlfAagwLU1N/cudk/32sLA3kNKTTbfsOZ455R79LdxpNJD0W3L2jk32VA5Zg22y
         d7XMSneVhNB25DPLBgWGANESgzHx1LOL3m+9snGOvIRz3wxgX6P/erXk3Ahadm01TFh9
         8QtJR2xiJVtGaDf8N0uGjNSZIJUyvzubz3/pk6B/woGhRm2SDrPnLWiBCMtbJVjoPFpt
         MdZZm15Fy8hHpzmdww7xcToGGeDfYGPOqgbUsRgIccuZFBdhv+OTrIuWb0vLpGqQyxjL
         2klw==
X-Forwarded-Encrypted: i=1; AJvYcCX8Ejr8d7XpZyOy1vugsTYHkGUjmJzGPAluUuBGX4dOsXHZ3wQFuO5v4mhvgNI/Vo8cj8pV63o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxINTYs/OQZYtMXvmf6eXyXAHoLiGalo9LtUMYq2d6xpJ6uCpWg
	1mgzQlL880iuvonJbcdDd1gq34Fg7QYDyCyGP5nQ2imWjYDtYbrdGZEk
X-Gm-Gg: AeBDietHgPdASC2CH83RTQb6+BbfoZphPhEAPuBCVmgsAkDaP+JLMIMdNuWmxPpiJ+/
	VNoSIo64hkI0ebhvvSWHrH/vXzvZhHyowtbR7qu3aUZ0BcnyE+WvMxByEgAHBBvnOhkOusU+2E6
	kOcw6U7+f6wNvmpYVDVSJk0UIHkIyFKhLooUwCX3Sga4qF76tFqHk6lLqkvn0zfYD5EFB8Mv0dN
	ZJFqq683ZeCKzx/+neGKburVwPfm0oA9L6cHVqbgje6iuThNzmH++TgWgVSQvC3BISxMJ9K89nU
	BtBXJ+SK+0lZVeJGBjvFxUPe8ivLEZZkIMUKiQHBFRbliIDiMHjDwynBReNW0CQa+wMMiABdT2A
	h+5XJwz+tfAVhHFHwOAp0LQzL54oJskIZBtpDuFtl+E2CPwjN9SU/KFaFF/tb5tkzA9Y19ROsM0
	+Y+e2+GptW/N11eLcGV5vetnmp7vZVnjx/xNKOBu/3bsUC
X-Received: by 2002:a05:6a00:4b50:b0:820:2f9b:fe31 with SMTP id d2e1a72fcca58-82d0db53786mr21789802b3a.30.1775649722177;
        Wed, 08 Apr 2026 05:02:02 -0700 (PDT)
Received: from Mac.localdomain ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9b3e169sm21209322b3a.18.2026.04.08.05.01.58
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 08 Apr 2026 05:02:01 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linuxppc-dev@lists.ozlabs.org,
	Haren Myneni <haren@linux.ibm.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	linux-kernel@vger.kernel.org,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	stable@vger.kernel.org
Subject: [RFC v2 02/10] pseries/papr-hvpipe: Prevent kernel stack memory leak to userspace
Date: Wed,  8 Apr 2026 17:31:32 +0530
Message-ID: <aafb835339cafc1544280c027200db8b28df6edb.1775648406.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1775648406.git.ritesh.list@gmail.com>
References: <cover.1775648406.git.ritesh.list@gmail.com>
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
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-233869-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linux.ibm.com,kernel.org,gmail.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[riteshlist@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.975];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4F5D03BBB65
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The hdr variable is allocated on the stack and only hdr.version and
hdr.flags are initialized explicitly. Because the struct papr_hvpipe_hdr
contains reserved padding bytes (reserved[3] and reserved2[40]), these
could leak the uninitialized bytes to userspace after copy_to_user().

This patch fixes that by initializing the whole struct to 0.

Cc: stable@vger.kernel.org
Fixes: 814ef095f12c9 ("powerpc/pseries: Add papr-hvpipe char driver for HVPIPE interfaces")
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 arch/powerpc/platforms/pseries/papr-hvpipe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/pseries/papr-hvpipe.c b/arch/powerpc/platforms/pseries/papr-hvpipe.c
index c41d45e1986d..3392874ebdf6 100644
--- a/arch/powerpc/platforms/pseries/papr-hvpipe.c
+++ b/arch/powerpc/platforms/pseries/papr-hvpipe.c
@@ -327,7 +327,7 @@ static ssize_t papr_hvpipe_handle_read(struct file *file,
 {
 
 	struct hvpipe_source_info *src_info = file->private_data;
-	struct papr_hvpipe_hdr hdr;
+	struct papr_hvpipe_hdr hdr = {};
 	long ret;
 
 	/*
-- 
2.39.5


