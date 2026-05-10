Return-Path: <stable+bounces-244999-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8NBMJD4JAGq9CAEAu9opvQ
	(envelope-from <stable+bounces-244999-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 10 May 2026 06:27:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0505D502871
	for <lists+stable@lfdr.de>; Sun, 10 May 2026 06:27:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C4A3130209F7
	for <lists+stable@lfdr.de>; Sun, 10 May 2026 04:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 722322BEC5E;
	Sun, 10 May 2026 04:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F4yqSHb5"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC462D0C64
	for <stable@vger.kernel.org>; Sun, 10 May 2026 04:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778387156; cv=none; b=js//v/UrLBJNqysqRsBfT/kqXm9phPiYw8W33v72j1aXRlXGlbVrgrGLljW0kzCes/h5/QuF0fMTefNdKq8QRNtqCXc2yXPpcov3rFEJkKDB7may1xLozQgHbYgNBt0D2M05UesZc1Quz0eEWnzVHEwOqM5EST5U8TUt5+ElWhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778387156; c=relaxed/simple;
	bh=Tk/2aJhhC1s684/DYFLDntYmRO/aqAyYK0+/EXewrns=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GozyGyJPubGilNaf8dA+VFBODERmyRBGgr6UwD37y+yiKufGOkagBeJQ3MlpX1dIGNXMFVA//eNe8kHQnY5AkMlXW7d5GMiIfCY93jeyB3qWaPAOjSxxN0d/S3RIUI6XtlZU3bCxjLbu0m4iewhDb3miXDfEwd0oKz9+oC/zg9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F4yqSHb5; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-2ecf9e398f4so8709122eec.1
        for <stable@vger.kernel.org>; Sat, 09 May 2026 21:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778387154; x=1778991954; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4+i5mv8Vqi4F1/QxRhQ01iidaQ4oFBJaEVmCvLgpSXI=;
        b=F4yqSHb5Ndk+NeL4fWDRY4HOAtYUIex+1HQVhZWD0aT29e82OxWT1kZfVPLQlnwygG
         YqNhjI37mNkXdHWM/tjcQlA3Eppdz5+R5oif22VqjEnDfC64LNQmOVFdnclWJDRShHpO
         AdAWQQelW2+7qcXDkvs3KifSBpPDJfTL37RI9mfo9wnEY8itVRzmZcMmwipmaE7W622r
         mCvdG5ZPxtdzXe2r1923NluYeMi6d5DSikkBQ7YyaFjwLKZdRYzqGvlkpNrG2zKap17e
         xOMfq41S0uwfWhcl5U/0kzXwVhG/wwfoKoBs58uH5ycRIDS6DhgDnFWq/eTVUtHlPYOn
         8SRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778387154; x=1778991954;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4+i5mv8Vqi4F1/QxRhQ01iidaQ4oFBJaEVmCvLgpSXI=;
        b=brg2U7rArmwfHEVhLxVLySRNXd9TVz6VcuWYfHanHVI7vouR4LCS895XfmJIxbFwlj
         Jz5MreUBUW+9r2Tx6yDq45poEcKpw2rvh/jO4jOJ0P3lVVCHdvmklHgQIsp08m9a1J4m
         DzpJJsAoZC7LAZwW2pXzfvC8Fa8ONsy5xafngIb8tOCYtD82CXjDSc2kHFmXoP+VLDRx
         p9s7gt/y+qadpv/NBhPUtdMsOEc2kqvKE0hPqbGn24K9C/D5ew6Ltlns6DUcYm5DMLiO
         lRZdbXI1/du8yCH5yNGIbVXsV7tU8u3P2eybrQDZuO9QHGwWczE+PZUsdXST+joq6lii
         TxFg==
X-Forwarded-Encrypted: i=1; AFNElJ8zAbFGFY4Pb4prwO9m2aEi7z7In+s6760DH+MT5tAh7N+GM/WIIilBOEY9F8TdAEvSBY1g3pI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsCwqh0LGSn6O/lD3gQlrrc6T6m31H766n7s2xxTZ9+oEsvCIw
	SJGC3upN8SZaON9eklWvuaIaMxKh6fHPzX6qsd+CNi+JiiA6YKh3cH6o
X-Gm-Gg: Acq92OHn9IsQvOizOL9DI3Y/HN7iEzUeGqKb9/s7Kb5x8IlIo3a1NY4S1X1ljv98nVM
	tpwC0oky89/tJ0F+31pDsUQcW6sFng7j0bTmghUMd9udrr6E7qjvSiJJS2tI610t9Z37rRIf7NC
	P1KIimlYZ7+dXz8YM9KseFv6Zja9GJo5TYSDFuP8IGTzr76NmrN8Aqps94+6aRUVy4I8atQsZ3e
	ec2TSKbPNnlCmpOzoAIN2PeY7tjsV2cFzyf2OifARaGhKMcIpFLv8FzHyKzHdSwxLrpsXA2ga95
	677qjM4Cdtla8HIELzHQ2PRQQ6Jn0VFYX8gcSvlfHEcptv1Nym0hglZ3GMW5Q5kwo5X4Gg1oY64
	tz53Cpbf2wiVZUNDKfyCcij38Ulz3uFCbhf/QsvxS9ffmPuQvwfa++vI3t+eFwGeuiHDlAZGQV9
	S1ySIAX+BhcUj20q5xNJWq7PypQdTbzPCOpk9pdRnhQQm4kbcxaeLoNXZ3y0S5XwnJk1z6t8ook
	cbOhAdw063Wj5vQgLo9gamlPg==
X-Received: by 2002:a05:7300:6ca8:b0:2f5:3641:f110 with SMTP id 5a478bee46e88-2f54d790853mr9736990eec.31.1778387153587;
        Sat, 09 May 2026 21:25:53 -0700 (PDT)
Received: from lappy (108-228-232-20.lightspeed.sndgca.sbcglobal.net. [108.228.232.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f8862d3047sm10069960eec.10.2026.05.09.21.25.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2026 21:25:53 -0700 (PDT)
From: "Derek J. Clark" <derekjohn.clark@gmail.com>
To: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Hans de Goede <hansg@kernel.org>
Cc: Mark Pearson <mpearson-lenovo@squebb.ca>,
	Armin Wolf <W_Armin@gmx.de>,
	Jonathan Corbet <corbet@lwn.net>,
	Rong Zhang <i@rong.moe>,
	Kurt Borja <kuurtb@gmail.com>,
	"Derek J . Clark" <derekjohn.clark@gmail.com>,
	"Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>,
	=?UTF-8?q?N=C3=ADcolas=20F=20=2E=20R=20=2E=20A=20=2E=20Prado?= <nfraprado@collabora.com>,
	marshall@shzj.cc,
	hyacinth@shzj.cc,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v12 05/16] platform/x86: lenovo-wmi-other: Fix tunable_attr_01 struct members
Date: Sun, 10 May 2026 04:25:35 +0000
Message-ID: <20260510042546.436874-6-derekjohn.clark@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260510042546.436874-1-derekjohn.clark@gmail.com>
References: <20260510042546.436874-1-derekjohn.clark@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 0505D502871
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_CC(0.00)[squebb.ca,gmx.de,lwn.net,rong.moe,gmail.com,valvesoftware.com,collabora.com,shzj.cc,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244999-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[derekjohnclark@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,squebb.ca:email,rong.moe:email]
X-Rspamd-Action: no action

In struct tunable_attr_01 the capdata pointer is unused and the size of
the id members is u32 when it should be u8. Fix these prior to adding
additional members.

No functional change intended.

Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Cc: stable@vger.kernel.org
Reviewed-by: Rong Zhang <i@rong.moe>
Tested-by: Rong Zhang <i@rong.moe>
Signed-off-by: Derek J. Clark <derekjohn.clark@gmail.com>
---
v12:
  - Drop fixes tag in formatting only patch.
---
 drivers/platform/x86/lenovo/wmi-other.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/x86/lenovo/wmi-other.c b/drivers/platform/x86/lenovo/wmi-other.c
index 1e06b894cfcc..50a03f5fd6ab 100644
--- a/drivers/platform/x86/lenovo/wmi-other.c
+++ b/drivers/platform/x86/lenovo/wmi-other.c
@@ -546,11 +546,10 @@ static void lwmi_om_fan_info_collect_cd_fan(struct device *dev, struct cd_list *
 /* ======== fw_attributes (component: lenovo-wmi-capdata 01) ======== */
 
 struct tunable_attr_01 {
-	struct capdata01 *capdata;
 	struct device *dev;
-	u32 feature_id;
-	u32 device_id;
-	u32 type_id;
+	u8 feature_id;
+	u8 device_id;
+	u8 type_id;
 };
 
 static struct tunable_attr_01 ppt_pl1_spl = {
-- 
2.53.0


