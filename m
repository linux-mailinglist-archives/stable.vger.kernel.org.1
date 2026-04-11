Return-Path: <stable+bounces-235742-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OBc1A5h12mn82ggAu9opvQ
	(envelope-from <stable+bounces-235742-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 11 Apr 2026 18:23:52 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B37DC3E0C90
	for <lists+stable@lfdr.de>; Sat, 11 Apr 2026 18:23:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 394D7305FD97
	for <lists+stable@lfdr.de>; Sat, 11 Apr 2026 16:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDD803B961F;
	Sat, 11 Apr 2026 16:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KUzk9Ifn"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E233B776A
	for <stable@vger.kernel.org>; Sat, 11 Apr 2026 16:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775924622; cv=none; b=EVa92bFoIGpL57CyS6bhj58DnSjSGHj7Ee51mUhfsYAUJNWGrS0adVmIaP6sSEes934pF+WDo2r506+j4TCTMMHEdEsg5sF4xBkTH4kuX2Y5zkvaDNuo/7Uh7yuWXL/B49RjVvmGv0KywDpX0rOWvyr7/CPNNwjblJLdbzfQHnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775924622; c=relaxed/simple;
	bh=6uvm7kxcoZxl4SJop0VuYLP778pizJEeCY5iHUnRujE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fwC60ocnRDTJrx5ZrzvBY9EjHDerSSoX6ygIplpFPI6IxDdhlRlUwitmE0rmYLdTiJFJviOx2npccU49nQmYAEcyp5TyXYuB7rCCACk4XppKMkZMbWva+OSLMJXdbWQtY5j0JdraN69a2F5NO/y8FWC86X+R0ecyWh8kKPes7Kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KUzk9Ifn; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-2d52c7f92b1so2324827eec.0
        for <stable@vger.kernel.org>; Sat, 11 Apr 2026 09:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775924620; x=1776529420; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4ki2zpxXcCZiQ654Cm5JOUD1c7/Sq7YjZSIjBtyxJhk=;
        b=KUzk9Ifnj5+YJOpYGDqwGAvQAtvvSO/BeEaFOvino4nA2HIAsIsBc0q6Hcni0HHUvI
         +gXxcOFvjzWSx83/iucAP1KY5j6kUybhqBA53NOKdaCzk14pGfpu4mxNxNIUeZxEH9Lp
         0E6wb/lZDrH72UJ/5Y7l3QQnNh0EtNmZf9D2mQOIcknOWIPMOFqjd0tmyIHQGefrVMYq
         RPDRAlnqr9torRjrDTA+0U8NiEe88sAn5xmwaF2DL4e00xo4qNqn+SHWBOxvJeZT27W5
         v5MLRrQBdmBqHF2gUBRaucOV/Dh2FnGNiaXRVP/jpsWXbtJKXHi7EOguB+PyTnuP8cNM
         e2Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775924620; x=1776529420;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4ki2zpxXcCZiQ654Cm5JOUD1c7/Sq7YjZSIjBtyxJhk=;
        b=R3f9eL0uM6ANv5OeFaZH6QGZ7h2lBG0Pis9q0iQn/poKCurdaL08rrv9Crezc8K+hG
         3HfAbKeCXwcDKFlxZdcOaNPy1m37+zxD5Cd37wODKzlEjLzYqedkpzECwmKrmZE5DDob
         a1KJ/zpYnW+WmBdVlvHXwTrWhFcuaOjb1Yg/W1DGJs57jYckkc2o//tYM7EihtCBcMIm
         LX2yHeyZ4gRKGU3TI9DW0e/KWVRkZIi8faBrlexGg37bsL0JvGwenB9edYJW/xnsUFDf
         Y+xOLTTY6hh+ptC4/e1oUVwzS8GgBqCD3bitaNRrgEH/65JOM8k1UJFVV18SH5qHid4O
         V7Aw==
X-Forwarded-Encrypted: i=1; AJvYcCWa4jBtz6AdE+SrmoyOBspX9wJzPJn5O0GO30kYG04BRRMt4knKvkmfM/7rmM4F5D6cc22vOw0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxC8MC/egwgvfKasZ3Q2j5wkC8VmTqQlHGgyMbEotMwvKbuTK5g
	FRwFsrrrPRDTGM+lkBzqXTSyqXChJv0VjAHQBwCj5VcsGfo/R6Fagi0v
X-Gm-Gg: AeBDietAjhAPg1FNI2fTbg3rABXG+zgGEPzb57lBuRMB6Gu8Ae3q1aBlb+o7ZATgGOK
	RAutuJnoeuYWBDs9qzFsDyyV8qkGL/dKVXdwakvo2UHpA+VhDIPmA4Pb/SiuViUnyddNfZ7DgBD
	h1xo144N4oW+RE9X19Xc326uTgRsb22Y8CbQY+ECE4Tb6KHhoZUMO1VYinyN+VkX/45AggvHJDm
	EJqG5X0XjmEKbUyPWA46BO4II8w8zpe0DwQ//bMs7Ob9q6VUHGqJWvz1n8TK7922edJr1szaVBf
	FZ0Kr6Engn0/OTP3DjqFKQZ35CMBGhvS4K4F3mUOiSsBQHMWamDiqDuXveN9jnfBpEn+n8VqdPv
	BengQntBCIC29/TBoykoG2VUz9on/M/VrdogOIuaMyJTekjCwjgbIVojQwTTfZcIijrUurqE4u8
	f0oDTXItch94QG6seAeWj1vfzfNa0JEV2Fonz+YBiqpmnNMQWOgjtd0uCoY1yC5q5OI2AXq/pj4
	R3c
X-Received: by 2002:a05:7300:d183:b0:2d6:526c:55cc with SMTP id 5a478bee46e88-2d6526c5736mr2258532eec.6.1775924620224;
        Sat, 11 Apr 2026 09:23:40 -0700 (PDT)
Received: from lappy (108-228-232-20.lightspeed.sndgca.sbcglobal.net. [108.228.232.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2d55ce46a65sm9358907eec.0.2026.04.11.09.23.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Apr 2026 09:23:39 -0700 (PDT)
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
Subject: [PATCH v9 03/16] platform/x86: lenovo-wmi-other: Balance component bind and unbind
Date: Sat, 11 Apr 2026 16:23:21 +0000
Message-ID: <20260411162334.25682-4-derekjohn.clark@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260411162334.25682-1-derekjohn.clark@gmail.com>
References: <20260411162334.25682-1-derekjohn.clark@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[squebb.ca,gmx.de,lwn.net,rong.moe,gmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-235742-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[derekjohnclark@gmail.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sashiko.dev:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,rong.moe:email,squebb.ca:email]
X-Rspamd-Queue-Id: B37DC3E0C90
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


