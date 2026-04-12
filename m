Return-Path: <stable+bounces-235858-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4DeVG44K3GkTLgkAu9opvQ
	(envelope-from <stable+bounces-235858-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 12 Apr 2026 23:11:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 516B93E60AA
	for <lists+stable@lfdr.de>; Sun, 12 Apr 2026 23:11:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7AB793002B42
	for <lists+stable@lfdr.de>; Sun, 12 Apr 2026 21:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5950E38229D;
	Sun, 12 Apr 2026 21:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XlDBPag+"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A0B3822AA
	for <stable@vger.kernel.org>; Sun, 12 Apr 2026 21:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776028288; cv=none; b=hdbbqB7sm/Iv564GfvPK5AQy6mk/RFYknSQmeIEqBE+5nyocq4ahbaBSYT8TJbmLql9yO9s8MKLrA8PcXsZBOixSDpp13Gx5olj3EysU+8C6/nXGiPMU9NdS7sjeBQnzUu+277bNJKAreq/+JemKl17Dv+c3SstYLw7YMB1bIw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776028288; c=relaxed/simple;
	bh=6uvm7kxcoZxl4SJop0VuYLP778pizJEeCY5iHUnRujE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OS0LBlRbhxAJvOTUDOv71gMbianX9j3ipTucz7rVzbBeg+w0wN5M7JsxPGmpeKruu6YEbtBrLw26mWeSZvbqtrkTOJNlMC35EfIZMiH3OiekZNJpeZj8HiqApGeG8veJgqHsqLJk26LnJI12r8GPc+9v+W+HOa8XN/aDToyY27g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XlDBPag+; arc=none smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-12c42a23c8eso1124602c88.1
        for <stable@vger.kernel.org>; Sun, 12 Apr 2026 14:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776028286; x=1776633086; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4ki2zpxXcCZiQ654Cm5JOUD1c7/Sq7YjZSIjBtyxJhk=;
        b=XlDBPag+crpA0I4J8yPdJSXHpcmpVRVrPr5wixEHYBcaYrTSjJ5BokwgjaSbZLkX2u
         d9iAwUS5ywUnDV6yOcyUcEdJGLogfKAXbZ0VDn9lPQ/omWuwAKUanr7T3M+kJfI4ml7J
         QPXgrHiqPVhxa9H8VVEfCoKUIddvFu6G67izJeJGWf/m3wakhgs+y53w4h8efiWs+An/
         t1r4u7Tv5+rxYH/iHt40oJYWDKukAnvdjVrcj5sgWPxBM4SOQ6s4SkHUcj6k3xzzqJVn
         LxRKxgO54x1642ZKK8aRaIhChWGCWjlYcMDwUy2X5yfsYQO7A0j0yZEvDe+cgX+3diOG
         n7KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776028286; x=1776633086;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4ki2zpxXcCZiQ654Cm5JOUD1c7/Sq7YjZSIjBtyxJhk=;
        b=Kx3jAATN8S3nEezDvf5VqbpXVuQV3FvzjuF8QHZjbKdGsmgNv2J+kVqwMGF3e2jfAI
         deVd/4I03/udzaOHcKCl1a1cUOLJ2JepSTPqix1C7JCQq6to7eZ/kqcbyzA7Sd5Z/JTR
         z8z6ArJrtTOYaKgrRgiE8DXxYdUtRn5tLIN9DxIc9j0hG2fBnN0rO0DEK0IM8Z3mrA2O
         cR2i2nZWhR7QLiKhZO1VQoOJ13TWX3ckQqCSFZdn08SvUSsuIK/wYCZ6x28gc5KckB5a
         2kK8X2FGoSZoKTTp7d+GXIgz7T9KZBHDlVHdX+53RSUsPnEf6QHRxCrG9WN4bfprAoCu
         FZrQ==
X-Forwarded-Encrypted: i=1; AJvYcCVLwtSlSGx5nLnF83aOG7O5u01vURbEz/yCdKXmZPdCwIQ0mQowsTancez2g51xc/4cKE9Cj/w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy30X45cC2lQ7dyC/5/3ecRe6xEDnBNsPrdeyeRvd6nTYAtiWpT
	uhN1+n/hxBWMTQLkmulMRCbOmWjU4l1bSDqwDP4MJ/+2bDGizwxZlHCD
X-Gm-Gg: AeBDietHNI570mJE3d1ESd3IUdqYZmIYH4XPLt0iZygD9bjaHOAi93m3B3BP9vWgYQx
	n2bwC7oUOh26gdOsSRv7tOsckQnFaI/tMWshcLgYqjgOdKizWhHeyyuGQAxd/6zDafllC3+4UBp
	EJdi4WGDu/4UPOhF3G6wKRl2rHluG88ZZdXhYjmVyYj8Kos66+QqKOBAPz7FXabPnbAzfE3jStk
	rcSdfCqpHFbML3hvwri35+z5evwcGDlQomns57JFQYlQR3JV9AheuZ2x5USC7MfV2wLErFGBbNi
	NbodppMoWXpn/PTgjHn/hdf5rR4u/bV+aDI+1zTRRzyH2lI0W1PqAE+8GQNHIzQ4Bj36K9CoSnP
	KWNuz9eP/+D5cwYCbU2Mme8hyVoJqAwQGD/2YFJxQqPwvywpqv3xDGNGnUh6+Q3MOQCCAsI/ZNE
	WYojHfgeaQSJemQT8O7ihQgWtjYsqBepQ4QHXNQVGileuZRSHwRNWdHrplOO/0tLLSytJ54JGHR
	xG0ndPRIUZZ8d0=
X-Received: by 2002:a05:7022:4a2:b0:127:9ece:c47a with SMTP id a92af1059eb24-12c34f160e8mr5235469c88.36.1776028285938;
        Sun, 12 Apr 2026 14:11:25 -0700 (PDT)
Received: from lappy (108-228-232-20.lightspeed.sndgca.sbcglobal.net. [108.228.232.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c346fb141sm11520856c88.12.2026.04.12.14.11.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Apr 2026 14:11:25 -0700 (PDT)
From: "Derek J. Clark" <derekjohn.clark@gmail.com>
To: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Hans de Goede <hansg@kernel.org>
Cc: Mark Pearson <mpearson-lenovo@squebb.ca>,
	Armin Wolf <W_Armin@gmx.de>,
	Jonathan Corbet <corbet@lwn.net>,
	Rong Zhang <i@rong.moe>,
	Kurt Borja <kuurtb@gmail.com>,
	"Derek J . Clark" <derekjohn.clark@gmail.com>,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v10 03/16] platform/x86: lenovo-wmi-other: Balance component bind and unbind
Date: Sun, 12 Apr 2026 14:11:08 -0700
Message-ID: <20260412211121.2220556-4-derekjohn.clark@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260412211121.2220556-1-derekjohn.clark@gmail.com>
References: <20260412211121.2220556-1-derekjohn.clark@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[squebb.ca,gmx.de,lwn.net,rong.moe,gmail.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-235858-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[derekjohnclark@gmail.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Queue-Id: 516B93E60AA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Rong Zhang <i@rong.moe>

When lwmi_om_master_bind() fails, the master device's components are
left bound, with the aggregate device destroyed due to the failure
(found by sashiko.dev [1]).

Balance calls to component_bind_all() and component_unbind_all() when an
error is propagated to the component framework.

No functional change intended.

Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Fixes: edc4b183b794 ("platform/x86: Add Lenovo Other Mode WMI Driver")
Cc: stable@vger.kernel.org
Link: https://sashiko.dev/#/patchset/20260331181208.421552-1-derekjohn.clark%40gmail.com [1]
Signed-off-by: Rong Zhang <i@rong.moe>
Signed-off-by: Derek J. Clark <derekjohn.clark@gmail.com>
---
 drivers/platform/x86/lenovo/wmi-other.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/lenovo/wmi-other.c b/drivers/platform/x86/lenovo/wmi-other.c
index be3309d74e03..a6be3463341c 100644
--- a/drivers/platform/x86/lenovo/wmi-other.c
+++ b/drivers/platform/x86/lenovo/wmi-other.c
@@ -1068,8 +1068,11 @@ static int lwmi_om_master_bind(struct device *dev)
 
 	priv->cd00_list = binder.cd00_list;
 	priv->cd01_list = binder.cd01_list;
-	if (!priv->cd00_list || !priv->cd01_list)
+	if (!priv->cd00_list || !priv->cd01_list) {
+		component_unbind_all(dev, NULL);
+
 		return -ENODEV;
+	}
 
 	lwmi_om_fan_info_collect_cd00(priv);
 
-- 
2.53.0


