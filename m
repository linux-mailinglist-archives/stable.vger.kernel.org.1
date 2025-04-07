Return-Path: <stable+bounces-128546-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B656A7E032
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 15:58:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C97CC189AD1D
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 13:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15961188596;
	Mon,  7 Apr 2025 13:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="VNJMmaC/";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="jdaZzsAS";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="uGJyDKb4";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="jrbnxU05"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCAB11420DD
	for <stable@vger.kernel.org>; Mon,  7 Apr 2025 13:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744033872; cv=none; b=HTzhmNwrkqPxV9QacWYZEEnqcXKdurTNSFtBLl1IYcpLhBS4jFmhKhbKbRVKhyYR0N++8OoTXj6lmimSJE/ORuRC4jHcsxi3iLRYVns53HtdHgs9wd1kDUfa/RWf2czqHLKZDGqn8tLeNq3jXR2L4aAifCoK+WeUs0UPWdpyoLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744033872; c=relaxed/simple;
	bh=U0RqFq5xSIcc13hYMtFJVf19cXYjTp7G07vnBYS07v0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s6U4yybWpd3xgosMCBCyJjxuWpoaXFhH1DBO+yDSKtqs0ZN6I528Q9jzdCZXbnP1v92w6hJ2Nn5+UT3FUoSuUdYRegDlz5QGiQo3GNnzzA/EXpmQGEqg013B4+Bi2PQ0/eLtG7hrkF9lttJgahxyqrRxz0iyARwxc5Xq0eIHmvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=VNJMmaC/; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=jdaZzsAS; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=uGJyDKb4; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=jrbnxU05; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id EF5771F38D;
	Mon,  7 Apr 2025 13:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1744033869; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2m2Jk4TVW2yXI+o/u9MUll8DXnNZy/l+PE+gbANBI2U=;
	b=VNJMmaC/90f9rOCKnW+CzKLtKS/xlO8OeiyWXYG969QZbDjiy2TDnD67VCwUn/vUD5p5ye
	RtvnxkM6PnIn5Y9OJUIOuPRdRHzzzmHxFajO0hg/WI4b8hodRHDy1JHRMgmdXwadSnvw/O
	W8f5TMEDIpDngvJTNMe6f1/8z1cH5kE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1744033869;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2m2Jk4TVW2yXI+o/u9MUll8DXnNZy/l+PE+gbANBI2U=;
	b=jdaZzsAS2CPPaUUnWEIFpqWbi70/+bZqpgH5uLG9Bai9FShaXV9WxJ/Am2nuXnsNNQp4ym
	G3LIo/r9CfRf0ICQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1744033868; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2m2Jk4TVW2yXI+o/u9MUll8DXnNZy/l+PE+gbANBI2U=;
	b=uGJyDKb4L9h/RTdBBkz8dZEJJkZOLuBj1WD2iYUBdz4c9mhiaWrK9ViXKbO85+nMZiKBK3
	Yh7cYBnANSJihVuHSEA50MiGcn7LFtLN2BtzZm67LmT8aoGii2bGI+DnY90Y74Y4jkIivY
	eJ2Gh+280/yYOBB+PRKpUPFpjV7kvcY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1744033868;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2m2Jk4TVW2yXI+o/u9MUll8DXnNZy/l+PE+gbANBI2U=;
	b=jrbnxU05G20M4FKbPFkCDZ00FvNIS1A6AVHRR3ijLMIFKKRoAWo78n6ig8jflvO2AO4qRi
	tYV/ijDA33NMQvBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C717313AB8;
	Mon,  7 Apr 2025 13:51:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id sMtZL0zY82eEHQAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Mon, 07 Apr 2025 13:51:08 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: javierm@redhat.com,
	jfalempe@redhat.com
Cc: dri-devel@lists.freedesktop.org,
	Thomas Zimmermann <tzimmermann@suse.de>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] drm/simpledrm: Do not upcast in release helpers
Date: Mon,  7 Apr 2025 15:47:24 +0200
Message-ID: <20250407134753.985925-2-tzimmermann@suse.de>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250407134753.985925-1-tzimmermann@suse.de>
References: <20250407134753.985925-1-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.991];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -2.80
X-Spam-Flag: NO

The res pointer passed to simpledrm_device_release_clocks() and
simpledrm_device_release_regulators() points to an instance of
struct simpledrm_device. No need to upcast from struct drm_device.
The upcast is harmless, as DRM device is the first field in struct
simpledrm_device.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Fixes: 11e8f5fd223b ("drm: Add simpledrm driver")
Cc: <stable@vger.kernel.org> # v5.14+
---
 drivers/gpu/drm/sysfb/simpledrm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/sysfb/simpledrm.c b/drivers/gpu/drm/sysfb/simpledrm.c
index cfb1fe07704d7..78672422bcada 100644
--- a/drivers/gpu/drm/sysfb/simpledrm.c
+++ b/drivers/gpu/drm/sysfb/simpledrm.c
@@ -275,7 +275,7 @@ static struct simpledrm_device *simpledrm_device_of_dev(struct drm_device *dev)
 
 static void simpledrm_device_release_clocks(void *res)
 {
-	struct simpledrm_device *sdev = simpledrm_device_of_dev(res);
+	struct simpledrm_device *sdev = res;
 	unsigned int i;
 
 	for (i = 0; i < sdev->clk_count; ++i) {
@@ -373,7 +373,7 @@ static int simpledrm_device_init_clocks(struct simpledrm_device *sdev)
 
 static void simpledrm_device_release_regulators(void *res)
 {
-	struct simpledrm_device *sdev = simpledrm_device_of_dev(res);
+	struct simpledrm_device *sdev = res;
 	unsigned int i;
 
 	for (i = 0; i < sdev->regulator_count; ++i) {
-- 
2.49.0


