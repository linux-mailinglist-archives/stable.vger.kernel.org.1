Return-Path: <stable+bounces-244998-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0AjMGSwJAGqaCAEAu9opvQ
	(envelope-from <stable+bounces-244998-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 10 May 2026 06:27:24 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E1653502861
	for <lists+stable@lfdr.de>; Sun, 10 May 2026 06:27:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1F7FE3037DF6
	for <lists+stable@lfdr.de>; Sun, 10 May 2026 04:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C97AF2D5932;
	Sun, 10 May 2026 04:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SRL3dz6m"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B622C0299
	for <stable@vger.kernel.org>; Sun, 10 May 2026 04:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778387155; cv=none; b=CDm7PDasTbZtgoHygKXknVlfnOyNyz39y8LXGCasQEoJ5kRJPjF6ua0TkuNDWMsfJeicTVuJzsuXhioTKEXxG7gq9XiyNBLoyp8VxkT6LCBYEPuMPbuup4hUK40zmxZSZ3i8EqOB0Ew15+MoOXXvLaKiaNtCPXB2QCLtD71D0Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778387155; c=relaxed/simple;
	bh=pA4TfuBRYBkm06/i9YIAhD/h0U3iNM8NSUZPBNTS74Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WhQOncv4meq3PV3mhq1sJ0Z0JV5m4JP3tsEH98lPM3bgsSXa7yJlR1KrGrvujFNvcDyAEXf76r6AgEy6Vn6Z8q0e6qaomQdisBJxtQQtsDxYb9JYy2nlrdHAQI/zwYyZMW4fAR7LY4WH6mkg47l+R+n7dbAeNf59bRO9qaoBw0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SRL3dz6m; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-2ecf9e398f4so8709107eec.1
        for <stable@vger.kernel.org>; Sat, 09 May 2026 21:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778387153; x=1778991953; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=td5pnPiFY8lI+NT0TWL0GRlUXHfAOrA1KjpGkurMjvM=;
        b=SRL3dz6mAKhpM97wNPLkGPM6pUFDZdj9+KJBMluwUO6wY9uEdKmQ41xx08h9zxVyda
         gc7dldKgXzC1D3bQydDsxUaQg5aXhFeyFDQVeUbU0pqUIjHcxxaCzjHh5UFtHWouz68Z
         mn5kg/9rZdsj5LNYReXbDXYV9BjTSkLZiXwGuXgqTjddQK0p8DxH7XTcOu4lGCMuz4py
         uCcKs1hNzxWkUmDDfXjZrcLoG9wz8d8bieJPI10/2z2N5OrB7itUpR9fgpeQs/MoLDwv
         T/xmDY43idmGu7lQA4gGzbZoZ6s+q/DrRKyzsOprUvgG3JavCxTRUT89a1atpNaOx5Cc
         uavQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778387153; x=1778991953;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=td5pnPiFY8lI+NT0TWL0GRlUXHfAOrA1KjpGkurMjvM=;
        b=lghPCTAFCaxxaAild1ZTzbloigIKpE4TD8lrU+fnfLtfpch83nL+aN/F65oyW1dVy1
         z+aV0/DJbJAnuh8tZxOKFsEK6RWOMTS5RPZ1QN2+UTJsCdUtB5GMFG2Z3OQ9WOrK8M7t
         euUdVsj8yRLL4FKvXeik9m86xR7lATKUSXojf57RzRQOxxEQdk9rJVkarcx7kFOH4AUi
         aNX/loIv5TzyaKS2+UrgsWUP4L85uMBFToW/slFjBywhg7mRzWcjedKkZq4lSIEW7w0U
         4HwOAk/OW94HCNkwmx6ktLzU6cqDemTtdMrEMemHTS5EY9nXEQjRoI2lmobLy826B1G5
         mWhQ==
X-Forwarded-Encrypted: i=1; AFNElJ/lPKnJN+fpew+KxjeLfemL/QL2mTbmQRGd/T0u3P35ZToux6jSrM2f25ihgGrOuCun8gtKilM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6+N+pJUTKHGAgtxynx7iC7IgcL4TXooGRvDyi91GwbySb9ON6
	WoIDMjFWOQYNRsPQHHfAFUrZ7xDgTUwdS2kFgvLcN1xcIz/a/xmqt1U4
X-Gm-Gg: Acq92OGpQ6pCFFOjjY7wtdB8UH7vPmeIhN3+mLeB/wYdgFP1RFoCe5qUXMKFrNxTlUz
	pJaESjaaRA1bmxQNDLPhuHhuLoUf7o4RfDpUo77THkqp7ncKwl6AMh87QBRjWpX4xX1MwGnGvsM
	Hh0DhjyVmkJn4/aajPrf/kVzdDgTU/CVu7ljrlfDqr98lnVC314NiGwNWTybi5Yj01eyq9A/iLG
	sX6ZgP8QlYik/aREAcQYqOY9qekZ9yMwUllLUDmB3+m9rASIlBCYmN0lLl0dNUJGHsvcJDM1W+r
	Rcy1lLcO2I1UdQ9pkUWZA7APqyeE4heKeCCiXB1Grg94cd02IbjVu0jY6CbcI/uHKmxF36nh+p6
	+LiSWoaKYrUNrwYjLu6GAfTXCYK14QnxPJJdNR5YDAzb2HPWikB57wscktBqCjASwXEKEUbXBIj
	5QTqKPMojtP/hmh5JZjbuUaxdKkODRYsw9DI91Nc5jIhREF6rSwyTKnUcXezi8ICYpVnbybCz+f
	mHcjLgNy1ygMDU=
X-Received: by 2002:a05:7300:df4b:b0:2be:142f:d499 with SMTP id 5a478bee46e88-2f54c971297mr8865848eec.16.1778387152746;
        Sat, 09 May 2026 21:25:52 -0700 (PDT)
Received: from lappy (108-228-232-20.lightspeed.sndgca.sbcglobal.net. [108.228.232.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f8862d3047sm10069960eec.10.2026.05.09.21.25.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2026 21:25:52 -0700 (PDT)
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
Subject: [PATCH v12 04/16] platform/x86: lenovo-wmi-other: Zero initialize WMI arguments
Date: Sun, 10 May 2026 04:25:34 +0000
Message-ID: <20260510042546.436874-5-derekjohn.clark@gmail.com>
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
X-Rspamd-Queue-Id: E1653502861
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_CC(0.00)[squebb.ca,gmx.de,lwn.net,rong.moe,gmail.com,valvesoftware.com,collabora.com,shzj.cc,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244998-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[derekjohnclark@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.986];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,squebb.ca:email,rong.moe:email]
X-Rspamd-Action: no action

Adds explicit initialization of wmi_method_args_32 declarations with
zero values to prevent uninitialized data from being sent to the device
BIOS when passed.

No functional change intended.

Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Fixes: 22024ac5366f ("platform/x86: Add Lenovo Gamezone WMI Driver")
Fixes: edc4b183b794 ("platform/x86: Add Lenovo Other Mode WMI Driver")
Reported-by: Rong Zhang <i@rong.moe>
Closes: https://lore.kernel.org/platform-driver-x86/95c7e7b539dd0af41189c754fcd35cec5b6fe182.camel@rong.moe/
Cc: stable@vger.kernel.org
Reviewed-by: Rong Zhang <i@rong.moe>
Tested-by: Rong Zhang <i@rong.moe>
Signed-off-by: Derek J. Clark <derekjohn.clark@gmail.com>
---
v12:
  Fix formatting of commit message.
v7:
  - Include lwmi_gz_profile_set() fix as well.
---
 drivers/platform/x86/lenovo/wmi-gamezone.c | 2 +-
 drivers/platform/x86/lenovo/wmi-other.c    | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/x86/lenovo/wmi-gamezone.c b/drivers/platform/x86/lenovo/wmi-gamezone.c
index 381836d29a96..ca559e6c031d 100644
--- a/drivers/platform/x86/lenovo/wmi-gamezone.c
+++ b/drivers/platform/x86/lenovo/wmi-gamezone.c
@@ -203,7 +203,7 @@ static int lwmi_gz_profile_set(struct device *dev,
 			       enum platform_profile_option profile)
 {
 	struct lwmi_gz_priv *priv = dev_get_drvdata(dev);
-	struct wmi_method_args_32 args;
+	struct wmi_method_args_32 args = {};
 	enum thermal_mode mode;
 	int ret;
 
diff --git a/drivers/platform/x86/lenovo/wmi-other.c b/drivers/platform/x86/lenovo/wmi-other.c
index a6be3463341c..1e06b894cfcc 100644
--- a/drivers/platform/x86/lenovo/wmi-other.c
+++ b/drivers/platform/x86/lenovo/wmi-other.c
@@ -166,7 +166,7 @@ MODULE_PARM_DESC(relax_fan_constraint,
  */
 static int lwmi_om_fan_get_set(struct lwmi_om_priv *priv, int channel, u32 *val, bool set)
 {
-	struct wmi_method_args_32 args;
+	struct wmi_method_args_32 args = {};
 	u32 method_id, retval;
 	int err;
 
@@ -773,7 +773,7 @@ static ssize_t attr_current_value_store(struct kobject *kobj,
 					struct tunable_attr_01 *tunable_attr)
 {
 	struct lwmi_om_priv *priv = dev_get_drvdata(tunable_attr->dev);
-	struct wmi_method_args_32 args;
+	struct wmi_method_args_32 args = {};
 	struct capdata01 capdata;
 	enum thermal_mode mode;
 	u32 attribute_id;
@@ -836,7 +836,7 @@ static ssize_t attr_current_value_show(struct kobject *kobj,
 				       struct tunable_attr_01 *tunable_attr)
 {
 	struct lwmi_om_priv *priv = dev_get_drvdata(tunable_attr->dev);
-	struct wmi_method_args_32 args;
+	struct wmi_method_args_32 args = {};
 	enum thermal_mode mode;
 	u32 attribute_id;
 	int retval;
-- 
2.53.0


