Return-Path: <stable+bounces-240979-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SB2LAAF662npNAAAu9opvQ
	(envelope-from <stable+bounces-240979-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 16:11:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B81C4600A2
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 16:11:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8E3E83025D18
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 14:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6987F3DBD4A;
	Fri, 24 Apr 2026 14:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Etqt9rUM"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E0B1862
	for <stable@vger.kernel.org>; Fri, 24 Apr 2026 14:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777039702; cv=none; b=Znldwzjyk/gWLmAydcUY0sIv0weJQgmK1Hv9TjXsk4NL5nX0W4e0ouXSgMDd90DgmtWYJh0lvJgyxnqSgAmD6qQOCNpDVGI8zsvmaQ/ny2FiE2W98M66tcbxSaj/056UEQw39YxFLljROZs9d/h96/LZqC5p1EJifMmnL3TFm78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777039702; c=relaxed/simple;
	bh=THAxbK6mdbOVtarKmn9UTK1imz6oPtEKp2BayRcElHM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VzEfmOtx5wFvXVF7Iecq486a4Pixweiy+uux07JIi2yLqVsSU0vJWyVN4cvjYFQ7hbx3W1oZthYctzoK39czXmgRl8smdVHTc/bLwcgI+7r1bMwgPmYACHtnIE/wt8A7ekdTflRYqgX6YCSBZPnwfd2eXAUlSVjTOO8R9vkk+DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Etqt9rUM; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-42c0b0ffac1so2831711fac.2
        for <stable@vger.kernel.org>; Fri, 24 Apr 2026 07:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777039700; x=1777644500; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Awi4viU8NvHRlCqV4pUg2d0xyjRYURsNTCZSqlhhrUI=;
        b=Etqt9rUMvX0Q117/6fAR3npEhuDiU2acTwDeG/Pa+0OkuopL0IjAfokoWIZrk8vpya
         BYVTZ7U8GgJTCJcj7IsaXN7JODg/AZUY7tIN4IPpnIdRB+AZxOoxroitrXzut9qK517h
         akZCTZtYMlojuKlL8eniXbl/ZZNs0mpPLzYVyP416gbPRaZFi0pwrX3UwxkTzQR6L1Sq
         m127IP5ZHQ1ISvYuQyHM0DwnC+Sxrb3w7UhUguqdmGLdGH8+3/C/rco6a3ljIZ0DghFx
         ff4uY3TpzuXNUXWsB38OMkFHVf8sdJmJdYBm5CkBFVFoUSCamo8Rx2bvIsC3w5lifYtU
         l53Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777039700; x=1777644500;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Awi4viU8NvHRlCqV4pUg2d0xyjRYURsNTCZSqlhhrUI=;
        b=kPz7HgfL7hYAIXLeK6B7J+9CQIdHWqnDCmbZkR7VvbAdD2URInrdvDQurn07KzA2iY
         9qWdsI+VtMJ7fpW3H2eZidJi1UMK1eU8cFO9sHOPf71Zies/D2sNp0LnAFu721Rnnd07
         Ejh6fW5Lt4cnuTsNzPOb+ZK8KWCcCJCQiLr4117S2AXNa3Q6+l1LJuVDw0pSoWou/EbX
         VB32KIYG9P52wGsYi5eveIDUCKQ3PriQivuiZRAAohdgzhaBWz6dQGkbv6/qiNcYVfy7
         gO6LDJsKM3i6lgk1NTurXte7Jq0IVtVucSuUUO5473jLmsi/qzPAGNi3muNfHTxs4sSo
         zl1A==
X-Forwarded-Encrypted: i=1; AFNElJ+mplWvw4wR2t8u8+uinl0RtyOKtvxIKF7dkb41z+uypVL6g+OXfVULcvr52XeW+OWF3HczHhw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDXtFFhad/1As0vouEmdmgSu8qp9Tm6iWdOcPZr4u/jwgrwKGE
	AiePD7X6IXPg3Zvh2QbDOFE3YlaXPzxz5I4mw0CXlGV1WWJrfTuLdBo=
X-Gm-Gg: AeBDietidNYZELRCwyVb3aYl42lAB3rvkVNrz1oA0Pv94q78aEy/VChTCWtjcmK9GKt
	2XPWpKDo0u1ba7fAYapmuiqsH19OUzWkYyfKn4Ss2kHvOxVZTHTTND/IuD0VOZ1iGA+UsMMeNen
	GLPsV/TTxcvuS3RxmUmFcx+eOc/Rkw7zup68jN28A0eqL8M86ibQ5KF+1LwmwbRUTGZxC/Rnfnx
	M0MXwagrUMK6VYsFkWI3t5RCgE6HdJpdKb7NFNXeBqlZ1WOCfJDnI9h+9g0iwf9cpxFBj41/xU4
	ZzKkqqosk+LtjXrly7PcHo+g6YRgSkyAljrbuALQZCBd5njYqVQvtUS8KTl+4m7aEtk9UP2BVJx
	aWynIx9Cb/KLLqRsuFONbkod0YINgFYSAbzxihtH+bkcOGi0U4MMv7PH10TsykyGeW4OQuB6zNP
	Pt1HUGFk+kGA33WFE3iHd5VQe3vviNjrdFonB1kW2idViyPY1J+KaJQeUU2zAUIc2XAMW2Nf0CC
	7GQAyIutUNZwfYZu1VMmKmdjp5PRAC7h/w=
X-Received: by 2002:a05:6870:9109:b0:42c:f89:7555 with SMTP id 586e51a60fabf-42c0f89783cmr10667903fac.11.1777039699909;
        Fri, 24 Apr 2026 07:08:19 -0700 (PDT)
Received: from localhost.localdomain ([47.188.191.104])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-42b934a2dd1sm22228653fac.9.2026.04.24.07.08.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 07:08:19 -0700 (PDT)
From: "John B. Moore" <jbmoore61@gmail.com>
To: alexander.deucher@amd.com,
	christian.koenig@amd.com
Cc: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	airlied@gmail.com,
	simona@ffwll.ch,
	stable@vger.kernel.org,
	"John B. Moore" <jbmoore61@gmail.com>
Subject: [PATCH v2 2/2] drm/amdgpu: remove superfluous BUG_ON in amdgpu_cs_vm_handling
Date: Fri, 24 Apr 2026 09:08:16 -0500
Message-ID: <20260424140816.43766-3-jbmoore61@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260424140816.43766-1-jbmoore61@gmail.com>
References: <20260424140816.43766-1-jbmoore61@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 6B81C4600A2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[lists.freedesktop.org,gmail.com,ffwll.ch,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-240979-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jbmoore61@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Remove the BUG_ON(!bo_va) in amdgpu_cs_vm_handling() that is
unreachable: bo_va is assigned from fpriv->csa_va on the line
directly above, inside an if (fpriv->csa_va) block, so it is
guaranteed to be non-NULL at that point.

Signed-off-by: John B. Moore <jbmoore61@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index 53f537f3e..556c62948 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -1137,7 +1137,6 @@ static int amdgpu_cs_vm_handling(struct amdgpu_cs_parser *p)
 
 	if (fpriv->csa_va) {
 		bo_va = fpriv->csa_va;
-		BUG_ON(!bo_va);
 		r = amdgpu_vm_bo_update(adev, bo_va, false);
 		if (r)
 			return r;
-- 
2.43.0


