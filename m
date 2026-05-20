Return-Path: <stable+bounces-250724-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UC6kDwj3DWry4wUAu9opvQ
	(envelope-from <stable+bounces-250724-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:01:44 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A792595211
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:01:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3BD6135721FC
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 16:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CDF53D75D3;
	Wed, 20 May 2026 16:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mUGjWLEY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 453253F1AD8;
	Wed, 20 May 2026 16:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779296151; cv=none; b=P2+wKBG3q4wg8ks+wHO2yFxzOUakiLY9b7nEQL6T/lVKG6jIhMucuvXM+Q2kIX2Ev9DBli1aWflgw31wSYtH1Hy3hgbG7QNaKMArBZ3lv6FM/nZBksihkXLn85eFfmTl5rEMo4OhZlQ7Q+l+tWRSMwgOV+znoVi2a+3nvj+hAPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779296151; c=relaxed/simple;
	bh=gHL6+wGXClavdghORm1zdwReUgl+ZOSLivbmC7/eTko=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FClcbcedZaaMEMM+GAjgG4PWdi28wnOG+YkkfCeYkyFCjKviwKvWzpjejqv4ML/4Ti/3ioil7GyWqpel18/+VzSEUuYVcq3Ly8UTJ0fa6BMBTcsxtFfTsUlzeOO04PZwKdw7XBz2qQo3VngG11YQS7FhIo1r9TvAsoN+Mu/aPDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mUGjWLEY; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 713CE1F000E9;
	Wed, 20 May 2026 16:55:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779296149;
	bh=WJ5dATWEz906xtfdgfUxlTEJifOwP/Oh1J+THkYjohU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mUGjWLEYS1aBbpviRk1plA3BmwPtXzu9xK2/OJZB6zFSfFWQswb9Lwprxv6utmS6P
	 zpVphZunvUWvndkYm6N58tHGuEcseYfX8TkKjQbhNU4NK5mDqhLeD5acCVje0Kl+YZ
	 7mwCHayqmDqKzvlfz34NH7k6kcH/k7F+mxheEqU0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Emre Cecanpunar <emreleno@gmail.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 0688/1146] platform/x86: hp-wmi: use mod_delayed_work to reset keep-alive timer
Date: Wed, 20 May 2026 18:15:38 +0200
Message-ID: <20260520162203.759388810@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162148.390695140@linuxfoundation.org>
References: <20260520162148.390695140@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-250724-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,linux.intel.com,kernel.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,linuxfoundation.org:mid,linuxfoundation.org:dkim,intel.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 9A792595211
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Emre Cecanpunar <emreleno@gmail.com>

[ Upstream commit 6297443beb0c5606399ec7d4f4b335e2e7379147 ]

Currently, schedule_delayed_work() is used to queue the 90s keep-alive
timer. If a user manually changes the fan speed at T=85s,
schedule_delayed_work() leaves the existing timer in place as it is a
no-op if the work is already pending. This results in the keep-alive
timer firing unnecessarily at T=90s, just 5 seconds after the user
action.

Replace schedule_delayed_work() with mod_delayed_work() to reset the
90s timer whenever fan settings are applied. This guarantees a full 90s
delay after every user interaction, preventing redundant keep-alive
executions and improving efficiency.

Fixes: c203c59fb5de ("platform/x86: hp-wmi: implement fan keep-alive")
Signed-off-by: Emre Cecanpunar <emreleno@gmail.com>
Link: https://patch.msgid.link/20260407142515.20683-4-emreleno@gmail.com
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/hp/hp-wmi.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/x86/hp/hp-wmi.c b/drivers/platform/x86/hp/hp-wmi.c
index 4dd7e4a118ea4..273fa95bc9bab 100644
--- a/drivers/platform/x86/hp/hp-wmi.c
+++ b/drivers/platform/x86/hp/hp-wmi.c
@@ -2366,8 +2366,8 @@ static int hp_wmi_apply_fan_settings(struct hp_wmi_hwmon_priv *priv)
 		ret = hp_wmi_fan_speed_max_set(1);
 		if (ret < 0)
 			return ret;
-		schedule_delayed_work(&priv->keep_alive_dwork,
-				      secs_to_jiffies(KEEP_ALIVE_DELAY_SECS));
+		mod_delayed_work(system_wq, &priv->keep_alive_dwork,
+				 secs_to_jiffies(KEEP_ALIVE_DELAY_SECS));
 		return 0;
 	case PWM_MODE_MANUAL:
 		if (!is_victus_s_thermal_profile())
@@ -2375,8 +2375,8 @@ static int hp_wmi_apply_fan_settings(struct hp_wmi_hwmon_priv *priv)
 		ret = hp_wmi_fan_speed_set(priv, pwm_to_rpm(priv->pwm, priv));
 		if (ret < 0)
 			return ret;
-		schedule_delayed_work(&priv->keep_alive_dwork,
-				      secs_to_jiffies(KEEP_ALIVE_DELAY_SECS));
+		mod_delayed_work(system_wq, &priv->keep_alive_dwork,
+				 secs_to_jiffies(KEEP_ALIVE_DELAY_SECS));
 		return 0;
 	case PWM_MODE_AUTO:
 		if (is_victus_s_thermal_profile()) {
-- 
2.53.0




