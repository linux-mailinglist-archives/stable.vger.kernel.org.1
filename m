Return-Path: <stable+bounces-242235-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cIj7FZIq9Glp+wEAu9opvQ
	(envelope-from <stable+bounces-242235-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 06:22:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C7CC94AA4AF
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 06:22:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8EAFD3072841
	for <lists+stable@lfdr.de>; Fri,  1 May 2026 04:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B199B30C345;
	Fri,  1 May 2026 04:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aU4dpX23"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E7D30BB94
	for <stable@vger.kernel.org>; Fri,  1 May 2026 04:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777608745; cv=none; b=A1Uef0RvH7opXNz/pjLuoZJBLMFduyCBMBlpX0QktQjzGrW6ri3PvK3DIAUisSPEyjTKSKziZoO7dzuq3yow9zSovMPxnfhgVdjUW3RHdl3ZZGQTg/FnsyMgEpxYEhTRUiiejmxmK4MkpwEvGZy8/A1LGQzPxkdcwcF0tsPdX3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777608745; c=relaxed/simple;
	bh=yTxnDirvmnH5LGk1im4CZr5o+rO8DwmekAa/5S50bt4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C3aC9NtTB8qBZ/4R5O/kE3PatEcYjd/S96Y2T+A8OjyqChOTQ3Fiuek8BFNdPGNcQATGXmaR7NuajTCWoXDVBxxthQxbULvKxI1BhKfMSEH4I9gAqTHznym5Rf6qQwz3TIyPTasuvA9KnYYMoWV22X/8If2JDo1QAVWRyArqVAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aU4dpX23; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-8296d553142so1110684b3a.3
        for <stable@vger.kernel.org>; Thu, 30 Apr 2026 21:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777608744; x=1778213544; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t0UuqUvbVXxe7PO3IdsW6Ps33YC23onFgbsbMbzoM7M=;
        b=aU4dpX232Zx83qBZozzV8NNyNHSHipEWPFQE1bsAYUrugqMIyuhUYGiy0I3awW11xI
         YSBnMbKrLVGlMeFzROcH4m5w0ZE5CxiJzhrHUMnLThw1vKncxTJHpoT2EgUjUxfXyaUR
         KCvAB/amIr+XvV6Y7MRdsa4NZZafNtIMb7xU64AJBnme59/vftbgDYboWvISjW3gmk6D
         AEQDHaIxgvEoSdODa3rPpWjkDPxP3cwob9xNcEF/IBsx2oG/UqEkKFHvrTYAFYJocNkV
         mdo/k1e/g+xmza4Wj3HI73DyJAEmJ4GO6ngoRlhUH8CUt/zzBENeRo29lRmnlLUnc4Ep
         Tk7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777608744; x=1778213544;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=t0UuqUvbVXxe7PO3IdsW6Ps33YC23onFgbsbMbzoM7M=;
        b=V/zbBSVB4eofOHDXYOFNnkohariD5JEz5pJxxCAFgIc/2HcstMtUgsbWivY9kSmr05
         KzGEN5+lGhYF6AynpgZp7hbk3vb3dCL0bpY1D9V9HWcApBgSfphj8vimafnI/bhcS3Mk
         68ozgfxHfO9TzT98dCX0gQRK7hXBhH1ir+59NChoU7vlEmDRPo2lRZdplkGDS721FtAD
         UrxBzeU/GHDfLDXMCjNqTKcDARWtnDDVZf9o0mtG8Ju+Y0mZXtg77iBtA4dm5dbsLh0Q
         8UZ2Y0eUydCuF4ncguW6sm8YbH4R6wx/XcN0YgzjAyFUxDpFb9Tr3nC7U2hj+IAhAcIP
         fi9A==
X-Forwarded-Encrypted: i=1; AFNElJ/uN5NjIx73r4ywpLV8d3EfQM+kgLPNQOhPyClShW24Q0EXZET2rmUlMh26M06wK0CGx8JvNvA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyj3kE4RxF9DglFPEpbeMVoL0o3nX1sLGNqgXZKLrr37AXkZmSy
	PEJs7rBepyZn1wdv3BuOXBUEKfuQ504JWLt12RqNmjozXEeOELozzXEa
X-Gm-Gg: AeBDieujy/qdB6kSzGXSFz+AWSsjrq4bdzxDZqZOYktAF4JxMC8HfA9UtvxX/MZib3K
	O5CrDle1vKWNQV3o9/uj4DkmWxY6ieef5Li5r5NQcEBs4n2TpjmztsioIAWwyKQtyjToJPsMQEF
	eiFQExrwK6M1xx1otZxGggOQGXlSGUtHyrpDVdVgc5NQhaYv23m47miy8ZJXUNDuG0+D/+FB9D6
	8li6lNtbk1Kx+xppQUsRZFGuEXiZJAVmX8zvqTWpAZE6ebMrPHQCP0Fbf2fKWMXcapq9AwV7Kcv
	1en3Sl6C6KcitkOlsqWDj5EpqMqh1y85Di9Zr9BMxEswtJS1KoaS/4yO7NYCRF320Fu+S+PR0f+
	oejtZ07MhVam3QUYevxQ172BVVjiUBqhIczVqSCchLR1I1sjgje4IsF/MPowb06/D/13OiENW9h
	/f+cavzny+9g0cnGMQNnttKwLDTLPK+b7u+NYYfge8vPrpzUwwnC6Opfi5mbI00f8=
X-Received: by 2002:a05:6a00:181f:b0:82c:6b23:6d10 with SMTP id d2e1a72fcca58-834fdb58c54mr6377026b3a.3.1777608743787;
        Thu, 30 Apr 2026 21:12:23 -0700 (PDT)
Received: from localhost.localdomain ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83515b485eesm1159428b3a.48.2026.04.30.21.12.19
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 30 Apr 2026 21:12:22 -0700 (PDT)
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
Subject: [PATCH v3 2/9] pseries/papr-hvpipe: Prevent kernel stack memory leak to userspace
Date: Fri,  1 May 2026 09:41:41 +0530
Message-ID: <7bfe03b65a282c856ed8182d1871bb973c0b78f2.1777606826.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1777606826.git.ritesh.list@gmail.com>
References: <cover.1777606826.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C7CC94AA4AF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-242235-lists,stable=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.992];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

The hdr variable is allocated on the stack and only hdr.version and
hdr.flags are initialized explicitly. Because the struct papr_hvpipe_hdr
contains reserved padding bytes (reserved[3] and reserved2[40]), these
could leak the uninitialized bytes to userspace after copy_to_user().

This patch fixes that by initializing the whole struct to 0.

Cc: stable@vger.kernel.org
Fixes: cebdb522fd3ed ("powerpc/pseries: Receive payload with ibm,receive-hvpipe-msg RTAS")
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


