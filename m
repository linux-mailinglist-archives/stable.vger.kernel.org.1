Return-Path: <stable+bounces-272562-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id GQ9oNtPrTWqJAAIAu9opvQ
	(envelope-from <stable+bounces-272562-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Jul 2026 08:18:59 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7588872223A
	for <lists+stable@lfdr.de>; Wed, 08 Jul 2026 08:18:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=Ncm56dnO;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-272562-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-272562-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DA5CC300C0EE
	for <lists+stable@lfdr.de>; Wed,  8 Jul 2026 06:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5670B3BB695;
	Wed,  8 Jul 2026 06:18:56 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C03367B98
	for <stable@vger.kernel.org>; Wed,  8 Jul 2026 06:18:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783491536; cv=none; b=ERkaIMutY6c7x6MdmT/LzcHB3BGxKKRpn/fDHsAvU9fFpjssdwZrKDAWJZ0O5bHGl6Y/jc0zOy+aiPx5WXlL9fLGEvk8iyRs2Si1i9FhagI+fKGqJ/PnPzOXKUvioTrN145dlNoFpb2l2PnX78SxOpF7KFnlaVexMkJS1yLg1qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783491536; c=relaxed/simple;
	bh=DDVqik3g024djbtq8wKsjUTyoUV/gR/76I31qdIO8Gs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s7hS5J4cg5DJM4kE9/5rxMxEXTfpwMe6EyEs7QgV3UFBEgByxHLZlOOpGMrv6uUKgzIId2458iU7XlVJ80HA7XPSvZHs5MLXGY5cj3zIYyd4heXm4pEM4Y13r08C2Sics9xYoOJevQQ5dwAoCgsrHLR25ymkjhZOAVApKg7TCaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ncm56dnO; arc=none smtp.client-ip=209.85.216.50
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-38096590070so27433a91.3
        for <stable@vger.kernel.org>; Tue, 07 Jul 2026 23:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783491534; x=1784096334; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IeKjljjW0rbzKqDo5+JHTj1l65dd8fRajYjS5rdVpUg=;
        b=Ncm56dnOmxWEZqFw+UiCfm7QHIwmrAZCmFkSHZE1YNvpuwT9phCGNFjyjicDT7SiSf
         iEaw1X0RC8vlGdq7QqVr6mWOZNRfDUaGF2nzwq5EOchTcE5NY0o/3J2PRDWA4NJxj6yP
         8w/ZvoercZ7Wb8crVq9pLG/eFT5LiYwYrEU1He7L+0rGeeLnIV2zQ+d4BOggVJIfGSM1
         h7dqWB5168hFOTHBuAMhnZ7hhV3DGCuGoWJb6Tg9Nc9BkLx5bGFv/Ey7dYGjTZhZZ+B4
         wok78O9Q6IrrDMbaFs9xZLc/+U832lB9c/vghiQlSWx4wQNFbqQ2kDQaBY8UVy+1vVzV
         RsNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783491534; x=1784096334;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=IeKjljjW0rbzKqDo5+JHTj1l65dd8fRajYjS5rdVpUg=;
        b=fFZnX86uG3neztjwjBXy0E9ZOgFEYdqZh3o3tM/sE8pcj9mbvl8ZomRs6VVL0cAkYJ
         b4qTCWrKAaDDAMGRj+PfrC5CRjLhqk5e0CD2b6UZRAD7taS48e8v4MIXeBfUiljlW9zQ
         frv8M80NpAfBypXs3tXgmCVDUH28BPGs0fTc3KRE4WElKb0Z8T0q7H8rXx/lMjyFZfEe
         lhrVeWbrkbAE8bYrL5OWTqhI4PQffTypJsy5piDCBbVB5soCycLZRrO4wL1fnNoQR8wn
         I6qutlgvgsIkUPv6qQ5OyZVRIOIjZeopsbHyZ07r/ZJmdysEXSRJZMZrA9IXYgkul+n3
         UYaQ==
X-Forwarded-Encrypted: i=1; AHgh+RqeJ/hkpjAlmCJecLR7BEuij0kDUU9JRkICI7KcVlguu/ePKCwEbcbtOW+89rTjULLUv1yK9uE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNkT5sRPoxAtdNVz7UAZjaUhVso9zmCP/LX6Dik7qvNeKTzCQD
	YfsgCfCtTsWZHRfRnHzVkFFWbaIX6w2kMeFmWgmfkVi9fQelf/Yo2Rng
X-Gm-Gg: AfdE7cnS7wcc0+rEgFDccN3/GVWnxsCZMhrZqJaTPa6gx/BaI90fAg6HbDjQiZFVHmE
	Yauw003ukAKP2wEdCxQ1lYqpzTMdw5JEbpwPOZOl4rBcyw7iScTo+P7i76eGYtDFeW2+y/mzd5a
	H4Cu6+Jh/MSeESR9V+8Kr2Nc2n98Q1UuKnftLRp+RDN9t39I5wonKuqHLeBilQh72zVqClrMAVG
	l5GFzTB//DhrMLqb4TOxToOpi8p2nk78KZi5EjMhIxFwOXPjxch96TjDM9W7VX9k7jeR4pTasGI
	mNQyS/wKrhm8UsT+E2zREstYnI/sj96uG3E7HojcqAe201sK3EBK4Si6xk5p5Qh5unhyINQCiWK
	Ja/p+NhesEneFY7y+tQtQe7nvkhfGdMWOKw07qw94POu6h6rDd6lBKp22vj3atb+nqpJHHStnfI
	IHw3Uk3gSu5winhefZdg==
X-Received: by 2002:a17:90b:57cd:b0:381:77cd:38ca with SMTP id 98e67ed59e1d1-389417e432fmr977538a91.4.1783491534182;
        Tue, 07 Jul 2026 23:18:54 -0700 (PDT)
Received: from kali ([122.162.146.188])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3117d847e17sm12888463eec.18.2026.07.07.23.18.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 23:18:53 -0700 (PDT)
From: Pavitra Jha <jhapavitra98@gmail.com>
To: alexander.deucher@amd.com,
	christian.koenig@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch
Cc: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Pavitra Jha <jhapavitra98@gmail.com>
Subject: [PATCH v2] drm/amdgpu/discovery: validate table offset before IP discovery header cast
Date: Wed,  8 Jul 2026 02:18:34 -0400
Message-ID: <20260708061835.111986-1-jhapavitra98@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260624184444.D4A401F000E9@smtp.kernel.org>
References: <20260624184444.D4A401F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER(0.00)[jhapavitra98@gmail.com,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[lists.freedesktop.org,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-272562-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:alexander.deucher@amd.com,m:christian.koenig@amd.com,m:airlied@gmail.com,m:simona@ffwll.ch,m:amd-gfx@lists.freedesktop.org,m:dri-devel@lists.freedesktop.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:jhapavitra98@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[amd.com,gmail.com,ffwll.ch];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhapavitra98@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7588872223A

Sashiko AI review of the previous fix flagged three remaining gaps in
the discovery blob parser, all stemming from the same root cause: the
ip_discovery_header pointer itself is constructed from a firmware-
controlled offset with no validation before the cast.

  ihdr = (struct ip_discovery_header *)(discovery_bin +
                    le16_to_cpu(bhdr->table_list[IP_DISCOVERY].offset));

This offset is a firmware-controlled u16 read directly from the
discovery blob's table_list, with no bounds check against
adev->discovery.size before being used to construct ihdr. Every
subsequent read from ihdr, including num_dies and die_info[], is
downstream of this unchecked pointer.

The other two items in that review (unbounded ip_offset advancement
via num_base_address, and num_dies exceeding die_info[]'s capacity)
were already addressed in the previous fix.

Fix by validating the table offset in amdgpu_discovery_get_table_info(),
which is the common path used by all callers except
amdgpu_discovery_read_harvest_bit_per_ip() (which reads
table_list[IP_DISCOVERY].offset directly rather than going through
get_table_info()). Add the equivalent check at that direct access site
as well, so all paths that construct an ip_discovery_header pointer
from a table offset are covered.

The check validates the offset itself against adev->discovery.size,
independent of any specific downstream struct size, since
get_table_info() is shared across ten different table types
(IP_DISCOVERY, HARVEST_INFO, GC, MALL_INFO, VCN_INFO, NPS_INFO, and
others) each with differently-sized table structures.

Fixes: d0c647a6aae2 ("drm/amdgpu/discovery: support new discovery binary header")
Cc: stable@vger.kernel.org
Signed-off-by: Pavitra Jha <jhapavitra98@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index b4ee5fc8e..9b55c56cb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -564,6 +564,12 @@ static int amdgpu_discovery_get_table_info(struct amdgpu_device *adev,
 		return -EINVAL;
 	}
 
+	if (le16_to_cpu((*info)->offset) >= adev->discovery.size) {
+		dev_err(adev->dev, "invalid table offset %u for table_id %u\n",
+			le16_to_cpu((*info)->offset), table_id);
+		return -EINVAL;
+	}
+
 	return 0;
 }
 
@@ -766,6 +772,14 @@ static void amdgpu_discovery_read_harvest_bit_per_ip(struct amdgpu_device *adev,
 	int i, j;
 
 	bhdr = (struct binary_header *)discovery_bin;
+
+	if (le16_to_cpu(bhdr->table_list[IP_DISCOVERY].offset) >=
+	    adev->discovery.size) {
+		dev_err(adev->dev, "invalid IP_DISCOVERY table offset %u\n",
+			le16_to_cpu(bhdr->table_list[IP_DISCOVERY].offset));
+		return;
+	}
+
 	ihdr = (struct ip_discovery_header
 			*)(discovery_bin +
 			   le16_to_cpu(bhdr->table_list[IP_DISCOVERY].offset));
-- 
2.53.0


