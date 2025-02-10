Return-Path: <stable+bounces-114714-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AC5A3A2F943
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 20:46:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CBC287A2FC0
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 19:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDBC324C688;
	Mon, 10 Feb 2025 19:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XY1IkaGU"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1210124C673
	for <stable@vger.kernel.org>; Mon, 10 Feb 2025 19:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739216719; cv=none; b=XT7TDg9pgB9bO6fDWMuoYuDG+6nGFVfXXK9RreKLErDHoJuheZRIVpgVi9UffVdBtsKBE2VhS78KU3xBwp2H/V1eYk4GITGXyPnXy+GFKjeA+L7K3ACKXBMPSzKRHb+x9Xnh6Q8GU2CMALQNyMhLuZM+4BT7j032enAjpkUNXZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739216719; c=relaxed/simple;
	bh=dz7LxZV1nfgCzmAuep2NZbFxKl1hjyf7lLkOJCVdldw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CG/SP0Rit9Af3gxVJAM0WBfiivJEOyioWP/3tevQD5CV/xy+yGn6eL5bkyEPdbONS3ZOA0DIQm/msTmQIYDrLaDGTruMN4ysAcGaFrAnR+jANtIOYtQhwqfTxhX13pjipdTqNHa266kyB0ORsfvCCNHTn+dYokxxq3VleXY98Sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XY1IkaGU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739216717;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=QqCXjtSE10Zs+4B0p2/DvM2wnpUl444vokiGOL6h4dA=;
	b=XY1IkaGUj6rIW+axO+K4aT5D4X2FJayNGMOw3lJkJvY7+IwuhJsM3F3hQSU+K0o4Z9oVF0
	HIPjUl1EHEbtZy0PGm2EvQT97ZY7r9aqopKLPq4nBp+wtyLs6wDySy6UQyMDRm6cS5irFj
	/wRIKUC6I7ZY6CNTyl+CW8Vi0VEtSWs=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-577-pYKZsSH1MPq6HxIQjf3FIA-1; Mon, 10 Feb 2025 14:45:15 -0500
X-MC-Unique: pYKZsSH1MPq6HxIQjf3FIA-1
X-Mimecast-MFC-AGG-ID: pYKZsSH1MPq6HxIQjf3FIA
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-5da15447991so4181187a12.3
        for <stable@vger.kernel.org>; Mon, 10 Feb 2025 11:45:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739216714; x=1739821514;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QqCXjtSE10Zs+4B0p2/DvM2wnpUl444vokiGOL6h4dA=;
        b=Ol2OxuYNKeVRrQsgYeJuTLRPrvXzIVze+OUvIiNyGgHvM9sinQ65aNulpI0g0d8C86
         AFbQnkmDTGpyczBnJWddiLNRXaRuphN8pXqa47/H0TY1D6d4gsu0ys/NOQKGc5JOpNdl
         Bb9EBceRnxvy9tr3/UrTq2AX4m36Wta2t2frNUWVjWXFo/18hNkCnAoyL/n0gJR26t/b
         g0HawDWXmNNc5c1QuRWYfFWhAqSe4IO5/jQiPtgsLrprda0+HLbfC2shT12TTDqAB0Xg
         qiZ6MnCrQrgamoDRRQt6YdGeJ57CFb2mb15GAWCRVlPsHQtvnTEEc5nu64JvDgJIpEzC
         bgyw==
X-Forwarded-Encrypted: i=1; AJvYcCVrS01d0wO/st7Ndc6fgmMcvTWY79hjP50m7jm1ojgwXa5zAT9MgDpOEy7tzmvrthzcfXfATBM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwtLij5CTiHYAPoXbVZeOaBf0hNCz3IVYB+p2gQM85ZZfYDyHG
	cVPWw/h6PHqyGGDckhQ5eUorTZTlPFhTKVorF1jxCmwx1BgZPOFPKOIW1YAsRiJidQKf+K7241z
	9ef3wpyFtU+t2ZkAqXvHG40NAwq9TfTOM2dHPi3bITvT7X7zVm0RKgA==
X-Gm-Gg: ASbGncuZloJKAqIBx6fAE8qdy+0bRMEkzLv3nxH8MtTsgPUfCPCEGt1om2Ze+0oGDmA
	OXv6q4OC2YLP/Msy6VsOl659gGm9/GBPQhjFSJQdtUD74wvXDPKdD+whZL0SjiqLhfksFrrMAl1
	GNKrVmgB4xIm1edOl4igjPP+A1f7Rqu7eYXE7uZ+gNRlXw3dLBOYM1tBrBPp8/opKblo/uwHQJ2
	PsEqnTXfQEvV81kCNuZxhfa4lJ1FzFh33/RO4dPWG4C2jWaT0/LgSuCLcFAdNEM8BFfGu5o8oxR
	7mF6JdxWw9CYDzBQ4rNUyDCHZDShEU+zpIrTVL4lDLPhh1XjXl2V5g==
X-Received: by 2002:a05:6402:5386:b0:5dc:74fd:abf1 with SMTP id 4fb4d7f45d1cf-5de45017b76mr39887439a12.15.1739216714187;
        Mon, 10 Feb 2025 11:45:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFkVngYg1NEXt/C5/FojOQgVIut41Geeor5s6D+qJmWdODol38eHGIfsFnlwT7mUxGvmQgf7g==
X-Received: by 2002:a05:6402:5386:b0:5dc:74fd:abf1 with SMTP id 4fb4d7f45d1cf-5de45017b76mr39887397a12.15.1739216713837;
        Mon, 10 Feb 2025 11:45:13 -0800 (PST)
Received: from maszat.piliscsaba.szeredi.hu (84-236-3-29.pool.digikabel.hu. [84.236.3.29])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab7922efbb7sm702006666b.2.2025.02.10.11.45.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 11:45:13 -0800 (PST)
From: Miklos Szeredi <mszeredi@redhat.com>
To: linux-unionfs@vger.kernel.org
Cc: Amir Goldstein <amir73il@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	Giuseppe Scrivano <gscrivan@redhat.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/5] ovl: don't allow datadir only
Date: Mon, 10 Feb 2025 20:45:05 +0100
Message-ID: <20250210194512.417339-1-mszeredi@redhat.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In theory overlayfs could support upper layer directly referring to a data
layer, but there's no current use case for this.

Originally, when data-only layers were introduced, this wasn't allowed,
only introduced by the "datadir+" feture, but without actually handling
this case, resuting in an Oops.

Fix by disallowing datadir without lowerdir.

Reported-by: Giuseppe Scrivano <gscrivan@redhat.com>
Fixes: 24e16e385f22 ("ovl: add support for appending lowerdirs one by one")
Cc: <stable@vger.kernel.org> # v6.7
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/overlayfs/super.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index 86ae6f6da36b..b11094acdd8f 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -1137,6 +1137,11 @@ static struct ovl_entry *ovl_get_lowerstack(struct super_block *sb,
 		return ERR_PTR(-EINVAL);
 	}
 
+	if (ctx->nr == ctx->nr_data) {
+		pr_err("at least one non-data lowerdir is required\n");
+		return ERR_PTR(-EINVAL);
+	}
+
 	err = -EINVAL;
 	for (i = 0; i < ctx->nr; i++) {
 		l = &ctx->lower[i];
-- 
2.48.1


