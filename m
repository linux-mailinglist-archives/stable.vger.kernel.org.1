Return-Path: <stable+bounces-165681-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0322B1756E
	for <lists+stable@lfdr.de>; Thu, 31 Jul 2025 19:07:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F89EA82841
	for <lists+stable@lfdr.de>; Thu, 31 Jul 2025 17:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26797213E9F;
	Thu, 31 Jul 2025 17:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e62FE+iq"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4FD1C07C3
	for <stable@vger.kernel.org>; Thu, 31 Jul 2025 17:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753981672; cv=none; b=mkkbbJlaLS/9+Azp8B9OJhQ8yhepEjLZvetU9uRDkeGJwD+31Lklm2qaIe5gxiwpyBx6gmPWYHtwKd6Me9/YWivqUs2LWdroGYNLgJ3Nx1IxM1s01fvHXaGY27DmZz0VllI5kkavZ1rkUKFRIZN5z7BHqdEY0KA+CdXuldCYYp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753981672; c=relaxed/simple;
	bh=+2WEWkxO2XBNPcVgfr9midutx7eBQLn7Ih+Z6y/lz10=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d1MEsQiNoWuaNRabAv8DvI83wkedJIXwjWVc66qIuTzqtpU08iBUtdR/jiKNZIDsaHgTO+FBTVnBzJNz2fevWBZEt8rSQ6OhW5v6YwPQZ/u8DkSJqNa8ebh7IFfkqQL/jADIQfd7/pHyC6UL2Ie6WF1zfMuhgO1iqSaajctUpFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e62FE+iq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753981670;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=W95fwcngNFVN7Dw8Ifafjvzeu2sGcCu0bDX4W6mcjRc=;
	b=e62FE+iqqhFn9mlbtj4z0CRCpAJp/iu7EjQM4r+XRrDKz2btSbKtNwdX8CFU/LPMcrY9xG
	zYNvQt1OrWgKq2LNfSALPLJWcFJpbpKpDtL1QT9KsIwvBQSPr4F5om6SixLgq8S0YiDsTk
	IjMCTbXgdhDi7gxnRbtFTQADzmbH2GY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-300-Dw9zymN4MkyVfF9afuXumg-1; Thu, 31 Jul 2025 13:07:48 -0400
X-MC-Unique: Dw9zymN4MkyVfF9afuXumg-1
X-Mimecast-MFC-AGG-ID: Dw9zymN4MkyVfF9afuXumg_1753981667
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4562985ac6aso8471185e9.3
        for <stable@vger.kernel.org>; Thu, 31 Jul 2025 10:07:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753981667; x=1754586467;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W95fwcngNFVN7Dw8Ifafjvzeu2sGcCu0bDX4W6mcjRc=;
        b=VUYR5LymKV/D2BeRUv5gezc27JZvT9/Y+eGUo5eybozc7ZGGsgWTGQQ8NvxOcs5tfH
         4gbObrHXvAqUw7oZbqHP/n9bigrD6FPFrnUJ5CFFcCioM+07o2XP5BNNtOKplgDsU9ER
         tTsB9cCEkZKbcXu/KIziqaIBVjSUAGQktn5nKo3qK29rP2ROLUgnogMvMXmhP8ah0UpC
         cDmfMUNf32eeDcVkppNy2jaL7/aMpECK4usGnD0dqJcIqPA8xWTSOLAkX6HasnJJ+/Ou
         K1nmAmgdNI7U1lZOmgutA0A4WBpxceHvNSHaRTmfHhmVq7D9t/OaYaWHtFao6UHaQKvC
         ZIGg==
X-Forwarded-Encrypted: i=1; AJvYcCWzVcjKr0gWgMFFO39fGxskPtQf+q8pmtKT9n9is5jHCBoJG3P3p282ZlerfxIHBSVHcrqibZM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlmMF06PAeMTt+TLSu+TuNICSpvhGYH5/LMuM47JBYsuCewuqf
	WkDDZQwiDqeEFYofeGTIHrrS0ZbqC7lUrm1Yl5gP+uOfjkUBdyqAufaROlETxWdZfd/SUAt7eOa
	Qt/K84K3T0GliHIGYNxqxrZUXQKLl86wNQxMNjHusJeTPznRYRLUyJ/II
X-Gm-Gg: ASbGnctJaLE1a8AwVDr1GjbuhRx7/KisdeEOLt9gIoLvnqeA4sWo6VTIAxLDaIa3/uL
	xDdalLtrN6bHKcv1+adapxgFAIRihldRJNVQGLLp4t5y/EHfj3SkMBokfX9Lg4E4uxWa8S6GVnw
	RgyvcrckZMYpewuN3GroEtZYcWDxE38yovSgHon+wKZhhb8Ks+8uHxbvwpHd4o55FLRjYPZ64Gq
	R/JmO8rUnDvD3Yp5OcUQ7zVFIAHqrlC3fqFEptk9eh6/FZkcMq6NE7FUuerwwxE3N00bvjzuASu
	8jGon5wKlgVPZ5Zg7jt8gPD1pocr4y9s2qiqwq336VqCXC/9AROqGA0wQ0PDQBbH/h69U+0ICsO
	6
X-Received: by 2002:a05:600c:a345:b0:456:2ce8:b341 with SMTP id 5b1f17b1804b1-45892bc48e1mr78580025e9.17.1753981667453;
        Thu, 31 Jul 2025 10:07:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEF6o5/vv6lNd3QYeNpO1xKq81HEgcr1sVdbp0YqpyF3awQbNrbMJ8dFKmysleE1fre88AIVw==
X-Received: by 2002:a05:600c:a345:b0:456:2ce8:b341 with SMTP id 5b1f17b1804b1-45892bc48e1mr78579815e9.17.1753981667058;
        Thu, 31 Jul 2025 10:07:47 -0700 (PDT)
Received: from thinky.alberand.com (ip-217-030-074-039.aim-net.cz. [217.30.74.39])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-458953cfcadsm76942415e9.18.2025.07.31.10.07.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 10:07:46 -0700 (PDT)
From: Andrey Albershteyn <aalbersh@redhat.com>
X-Google-Original-From: Andrey Albershteyn <aalbersh@kernel.org>
To: linux-xfs@vger.kernel.org,
	cem@kernel.org
Cc: djwong@kernel.org,
	Andrey Albershteyn <aalbersh@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH] xfs: fix scrub trace with null pointer in quotacheck
Date: Thu, 31 Jul 2025 19:07:22 +0200
Message-ID: <20250731170720.2042926-3-aalbersh@kernel.org>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The quotacheck doesn't initialize sc->ip.

Cc: <stable@vger.kernel.org> # v6.8
Fixes: 21d7500929c8a0 ("xfs: improve dquot iteration for scrub")
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
---
 fs/xfs/scrub/trace.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/xfs/scrub/trace.h b/fs/xfs/scrub/trace.h
index 1e6e9c10cea2..a8187281eb96 100644
--- a/fs/xfs/scrub/trace.h
+++ b/fs/xfs/scrub/trace.h
@@ -479,7 +479,7 @@ DECLARE_EVENT_CLASS(xchk_dqiter_class,
 		__field(xfs_exntst_t, state)
 	),
 	TP_fast_assign(
-		__entry->dev = cursor->sc->ip->i_mount->m_super->s_dev;
+		__entry->dev = cursor->sc->mp->m_super->s_dev;
 		__entry->dqtype = cursor->dqtype;
 		__entry->ino = cursor->quota_ip->i_ino;
 		__entry->cur_id = cursor->id;
-- 
2.50.0


