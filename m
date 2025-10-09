Return-Path: <stable+bounces-183694-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 623BFBC908D
	for <lists+stable@lfdr.de>; Thu, 09 Oct 2025 14:33:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D48E04FB13B
	for <lists+stable@lfdr.de>; Thu,  9 Oct 2025 12:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E35252E7F1A;
	Thu,  9 Oct 2025 12:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BbTo9IoO"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC572E2DF3
	for <stable@vger.kernel.org>; Thu,  9 Oct 2025 12:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760013046; cv=none; b=GDA0bP2ouGuX28tr4JrzwfmsXN2lhHvSS2LDtOU8Ulx4Ync6NJJq2zCpbUASEk7/u18aQ85U1pxCYZQoCyyBkRUf6QircD//gQzojOfK/q021PU3UnX6UlevLRzZKqJgJ7VBUNqeNUwU49zhtuOKJMud/6EjhOO0Qs0NZCEocJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760013046; c=relaxed/simple;
	bh=x/xBOWDUp28sfsBV56l3ubXJEEtbz5ccQGgEvAY4eak=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZAr1/GABn4pbHjCVmhmMlRc+LfcBSiRQrVp/HKeA+FQfn8jen6N8Tdauy/VJbkrwtdirWguIB3vxriUsFUL33d/2g7qZhMqyCZEDMwzOb7r9qZGXnojWPnjuKPlgK5N7OQG6xNNKD0FUXoFdEZJiqm3m9Au9fIjy+Qax3cJijQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BbTo9IoO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760013043;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Cn5dPHJR4fGLCx+LL6EWkDNRU/ebLqiGoCggED75pSc=;
	b=BbTo9IoOa5PSWGs8ZxXulWfNhyKxuMCeIlrR3ss99y2RfygZ8SVgfhh5HkELLtEvU+gcx/
	4ZLB5nIdh8ZJMgF2WnQabC+vDwFmuPrFz6WQKQVUYy78xWT4OluvtKudhyKXL3fxrPdRyq
	W+U9gTxRECfMW/515ibud6ZXmk3dg6A=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-15-uVIGwZ_LMbGTAMeUefY4JQ-1; Thu,
 09 Oct 2025 08:30:35 -0400
X-MC-Unique: uVIGwZ_LMbGTAMeUefY4JQ-1
X-Mimecast-MFC-AGG-ID: uVIGwZ_LMbGTAMeUefY4JQ_1760013034
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 288F4195608E;
	Thu,  9 Oct 2025 12:30:34 +0000 (UTC)
Received: from hydra.redhat.com (unknown [10.45.225.212])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BEF51180035E;
	Thu,  9 Oct 2025 12:30:30 +0000 (UTC)
From: Jocelyn Falempe <jfalempe@redhat.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Jocelyn Falempe <jfalempe@redhat.com>,
	Javier Martinez Canillas <javierm@redhat.com>,
	linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Cc: stable@vger.kernel.org
Subject: [PATCH 5/6] drm/panic: Fix divide by 0 if the screen width < font width
Date: Thu,  9 Oct 2025 14:24:52 +0200
Message-ID: <20251009122955.562888-6-jfalempe@redhat.com>
In-Reply-To: <20251009122955.562888-1-jfalempe@redhat.com>
References: <20251009122955.562888-1-jfalempe@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

In the unlikely case that the screen is tiny, and smaller than the
font width, it leads to a divide by 0:

draw_line_with_wrap()
chars_per_row = sb->width / font->width = 0
line_wrap.len = line->len % chars_per_row;

This will trigger a divide by 0

Signed-off-by: Jocelyn Falempe <jfalempe@redhat.com>
---
 drivers/gpu/drm/drm_panic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_panic.c b/drivers/gpu/drm/drm_panic.c
index 69be9d835ccf..bc5158683b2b 100644
--- a/drivers/gpu/drm/drm_panic.c
+++ b/drivers/gpu/drm/drm_panic.c
@@ -523,7 +523,7 @@ static void draw_panic_static_kmsg(struct drm_scanout_buffer *sb)
 	struct drm_panic_line line;
 	int yoffset;
 
-	if (!font)
+	if (!font || font->width > sb->width)
 		return;
 
 	yoffset = sb->height - font->height - (sb->height % font->height) / 2;
-- 
2.51.0


