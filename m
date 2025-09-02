Return-Path: <stable+bounces-177504-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FB13B40768
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 16:46:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3663B56639F
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 14:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E0E7314A8B;
	Tue,  2 Sep 2025 14:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dyc4xh0l"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD09314A62
	for <stable@vger.kernel.org>; Tue,  2 Sep 2025 14:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756824119; cv=none; b=J8pzpQA/9Uf7joBccMMv2T0z411BjnL4VGZiF5ZqFVRTfJUw0OKsv1s4co9YwUfPFQaWGKI8Yt0ckLjKMNbqvcutKK1kXeFSHUiXLow7ii7OrdTTlUxf1EBeGybrm5H1OpY5nimRc5JE9nOuBMv6OtmB84kGMg9+Fvki2IINFGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756824119; c=relaxed/simple;
	bh=qfrVAGjHWJB3gsB3fYztZc8uu3b4btKHcgatz0q3kYA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nAT60oYA1T+vWFHTPmUlDmANhC/U/qMWwfwRJ1vBEiYwaYfg0SOARscAqil2mESW+MFR+RMepe7Uf0gGM9Ig7K+5aDnWapC7CdL09eRf5Z5HzhijoP/uhD8/H1gVENF/wVqpaQdpTlUFTBTlDjIAleNqAlCU/1vbj3eXqgbR4Lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Dyc4xh0l; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756824116;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TQ6jbAuiS+tbmDjSvZTGdhF/BtTp5JKUp4bByQ/q1ck=;
	b=Dyc4xh0lObZbBNZYcdnz7J6TswK1vmDhSbESkb5MzOEa0SAVGetca2U3ZWLEPJ+VT3QYJh
	zI953g3vHKWwmcT44kXEQbq64na3VL4mfklL4Diw+UHr+/xSqONgj/ndw1wQH1+7HyPSrq
	48BWuo+pQXLs2oSZvJmAjq0KfUwUrhA=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-462-HrUY60KVObiJ5So73RSWTA-1; Tue, 02 Sep 2025 10:41:52 -0400
X-MC-Unique: HrUY60KVObiJ5So73RSWTA-1
X-Mimecast-MFC-AGG-ID: HrUY60KVObiJ5So73RSWTA_1756824111
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-61d31626bb5so3181883a12.0
        for <stable@vger.kernel.org>; Tue, 02 Sep 2025 07:41:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756824111; x=1757428911;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TQ6jbAuiS+tbmDjSvZTGdhF/BtTp5JKUp4bByQ/q1ck=;
        b=PSM6L0E4b5e2aE15ve86kaGSOoZoVtL4/C+PfCrJ7NRhG+H+0zBVe3eHmIdUbTnvl+
         t5LiIZPDCA5GEpE7+GpvmXs5CtC4XKK2M254hOw8o4wuHqS2HWptI+CZI4hHvct2WMUm
         p6d+7XOpF1CU5Qtkq+Rvy6ean45lXPHOVteJvfnKzy/Np7NE8fienYhqd1gGFl8RM5zh
         7NpZCLyBMOh0VpROZtjmmhnUg2XsQJcc/3jCmaGThhQfS+iQTUvwMVY48fvmAeGSKWQ5
         MX0T5DK1A/FZV42zofc+Cy6lulhwhl6qoDu9C2h9d0SzyW/oOul/rvbzL0jo10gPnqI5
         4vGQ==
X-Forwarded-Encrypted: i=1; AJvYcCXs6BIgZMaskEtn14F3uuW4mqm7JxSyGJwcdGyiFEKrbqbONIdeGci11RJbNX06osV3UY5lGTQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWgoyjoPQp/utGnDngwJWUJbSbMWvIREHWgZBVHXhqTmpceRDJ
	yBDqAh2Jto9N3hjtHP2JtZkUIAFtTXyRv5BAFumctRfWvRJgKPtu5K5pijOw2P0Roh4lSaPgI9j
	1WOJqYW9zZPxQK45tTOlCm+lbnBoRdoJorCU5K/13xun24uinDOXLuucvGw==
X-Gm-Gg: ASbGncvpDmNOKVeso3B9i/98598LWSCMhbok1qU/QR1kIRe9lUEwb/x+x+G7UilSouV
	wX9KtllBvIyJZUzhYJhB5RsSsxG2HeuEP6oQQL+7rDhVISSrp6Uoo37rkgLc2GDKrPfKhDIyTjs
	TActjHf0pPFerHzE8hnrKfmdSS7VB1WO6sJLzu0MAzhk39tbnnD42V7b7xJLlERcBApSPPBeuaG
	8pW8UYymBPk/MWf8itSML3DpoFqMG3i6jjfTOiWUsYNCjDN7JeDb6QBCCKSHNkebQedybYJzTi4
	bvtQBs5+IHxHIs+phhIdZAb7aUxa+Z2kGQDyfUVHiSs5HVTG8ZpbJonpbYCbNw6eo0Jl+B8NxPS
	3C/GNTz3u/re+BdCJTiZNKPE=
X-Received: by 2002:a05:6402:43c8:b0:61c:9970:a841 with SMTP id 4fb4d7f45d1cf-61d26d7874dmr9875747a12.25.1756824110824;
        Tue, 02 Sep 2025 07:41:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH/zlcG/d/cHFeJp3GE3kprzB3EdU2LFLiWq0oBCRTmlqo4xIQXiq8R425IKyUlqVRb5OXIHg==
X-Received: by 2002:a05:6402:43c8:b0:61c:9970:a841 with SMTP id 4fb4d7f45d1cf-61d26d7874dmr9875724a12.25.1756824110409;
        Tue, 02 Sep 2025 07:41:50 -0700 (PDT)
Received: from maszat.piliscsaba.szeredi.hu (188-142-155-210.pool.digikabel.hu. [188.142.155.210])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61cfc1c77f9sm9704514a12.8.2025.09.02.07.41.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 07:41:50 -0700 (PDT)
From: Miklos Szeredi <mszeredi@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: Jim Harris <jiharris@nvidia.com>,
	stable@vger.kernel.org
Subject: [PATCH 2/4] fuse: fix possibly missing fuse_copy_finish() call in fuse_notify()
Date: Tue,  2 Sep 2025 16:41:44 +0200
Message-ID: <20250902144148.716383-2-mszeredi@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250902144148.716383-1-mszeredi@redhat.com>
References: <20250902144148.716383-1-mszeredi@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In case of FUSE_NOTIFY_RESEND and FUSE_NOTIFY_INC_EPOCH fuse_copy_finish()
isn't called.

Fix by always calling fuse_copy_finish() after fuse_notify().  It's a no-op
if called a second time.

Fixes: 760eac73f9f6 ("fuse: Introduce a new notification type for resend pending requests")
Fixes: 2396356a945b ("fuse: add more control over cache invalidation behaviour")
Cc: <stable@vger.kernel.org> # v6.9
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/fuse/dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index df793003eb0c..85d05a5e40e9 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -2178,7 +2178,7 @@ static ssize_t fuse_dev_do_write(struct fuse_dev *fud,
 	 */
 	if (!oh.unique) {
 		err = fuse_notify(fc, oh.error, nbytes - sizeof(oh), cs);
-		goto out;
+		goto copy_finish;
 	}
 
 	err = -EINVAL;
-- 
2.49.0


