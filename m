Return-Path: <stable+bounces-244616-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id /O+sB2rU/GlvUQAAu9opvQ
	(envelope-from <stable+bounces-244616-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 07 May 2026 20:05:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A76BE4ED263
	for <lists+stable@lfdr.de>; Thu, 07 May 2026 20:05:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AE6D4301223B
	for <lists+stable@lfdr.de>; Thu,  7 May 2026 18:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65F0C45BD71;
	Thu,  7 May 2026 18:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X4sr41SQ"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F14F73AB29D
	for <stable@vger.kernel.org>; Thu,  7 May 2026 18:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778177124; cv=none; b=dAowAg4JqSN0cVBLzp3cDtpKRcupCEpe02/ByUx+P/8zxhOwQSdTCpG0ys1pJ3ZCazfa39HBioW47SDF3TtfqXcWQw8X54oT1eYWXQYHPgAf3dQ/h0st/1J0QAuV1XNa5A3+d24JjQzQ1RVhGsB9XGvwIffVGEdml73DtBZbuZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778177124; c=relaxed/simple;
	bh=as/Y6rgrCLbxvFJK4woRt4WCiXpZGU5Bmcl75dpz1Ic=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f8vAAAvsqV5sx1maRg8GMORh2Ugkf5H+j/IssMW/hlDm1a3cgJ0wWuVK5owXsjPqgraBf/KTv5p5UZwOp80FAcZweLrc6Y6lZqeusNQfV6wjg/v77cSN4QwsbHYK1vW5/l+ohdjRibPjaRmHNEWmpponlHIkIsg2hwdV5Ygz3Lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X4sr41SQ; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-2f0ad52830cso1761621eec.1
        for <stable@vger.kernel.org>; Thu, 07 May 2026 11:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778177122; x=1778781922; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Epvlpqxnk7CA+C9ymJCfGqy8SHrtqDJZ4fsM6TY9RM=;
        b=X4sr41SQPF6gq2J2TXbUY/C1NKf75OUu3x8t5VPcC9gHvOHZOpAwilembEyz3Bi9qP
         2TX+A2YgxM7T8pKKRPcFfXrwtBgPSCFvVKpYdr58CsONFbIh5+xvtQ3kWF0jJVVmvrUV
         IJbf1BZZ6iSNwvhjlyiSqiLsNiTWFdF1ez4USxUPQrkFvOKH+7svAoIeHC8MOmSoTYms
         MAlJuzRFfroHFxnXD5bhRmN6SesZobjkVs39TNcMCPBkx8CU9eDnrR9zwOqfzKW07jBB
         DyAplEsAfdN9kFWjAvPcekD8670suArcjaptjIqWBBlDJYXG6w5jCWlhEZb8PdSDpCZR
         ZPhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778177122; x=1778781922;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6Epvlpqxnk7CA+C9ymJCfGqy8SHrtqDJZ4fsM6TY9RM=;
        b=j2hwSLj2diWKy+hi4k6ckULdk/v/vSX4QDNuhHrng9ZhFaOAfVRzNN2NDGXGgFs28Q
         SIaI9SD3LuvqtPEbNTLzOEuB8xgAvMNeRYawzjkSBQ7dcncSiLb1Pt7078mkdTDeMDnL
         ZO31t4KNs1QXOyvAEN5uOzOuukWOr7u5a1JOP/0HpyvLQEVJ5od17DlkFoKYa2bNQFpK
         y95oABjdEPnuHaPtSPXexX8k5Ra/q1qBQ62GMMtvrJhxgQpxU051Bjr8+gedyHBbzjgS
         TfLGAsnpQi3CUex6L/nuq7WtoUuedZjfBy7bnm0OCQhaGFvYQYNlpVTfhbwFu2dypDSF
         Fl6w==
X-Forwarded-Encrypted: i=1; AFNElJ8sThoxiy/6si5yTuzgFa4IshHjoHsesSPDhDt53STc4hwFDwNsMzfq2+gvPJfB45isfJBdu28=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhOwgBWTBJhbrXB8rvEywLZYOmG14YCJ/EbqhBhK8Utu7kPWvm
	vc00o4g1DDgR1C/BOxP0hAmtd+kCdwJJB8sCj32KX5Pe9aFWhDjbsWGG
X-Gm-Gg: Acq92OElcXUfMnB3h/5/BA4o4fiV7JtyPzr9kImmgVMos4kWAHSu1HI64DSN597TIJc
	aen2bSjHiwQnjYDkcakBPLIas1zTnmJPwOY2iEJe+i+/MC8pgzwmv2g+9yhLalTADAYbwMOyJG+
	N7vRBC/hfPAVDojP0P7+3oQmghGl2Ajzr0GjRXNup1k8r1bP0/2241rKhpz2dub/ZhMxF4psPgx
	y9SafbwfibmUEzeAGxoHvMpXEWQYBPi6KuYCK2w79OP1fWNkhlEYwvrUUH+PCkof5nL3CPF4Kik
	mTE1F8gVRkalOB3mWymqAEtOZQSJ5WNOt7FWcdWcKkbJOjRLSVCCGS8jdnhqqlGd1ibfd9tOYhP
	T7edPX6dMwSgBWqM9ku0u0In5Dk8zdVYbSXrA1gvRjDUBrTXTBk0z7SVBYvxOipHhQsyKeKcmvS
	k7Y+UwAmezEZU37YYpsbz6ELI1vzvJb+mmO5bAfuaXyxhSf29tYyezbkEIFriDWsuOxG1Mvt2/6
	YlX
X-Received: by 2002:a05:7300:a987:b0:2c5:60d0:702e with SMTP id 5a478bee46e88-2f54a77f55cmr4538191eec.18.1778177122069;
        Thu, 07 May 2026 11:05:22 -0700 (PDT)
Received: from lappy (108-228-232-20.lightspeed.sndgca.sbcglobal.net. [108.228.232.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f82bd73a64sm44332eec.12.2026.05.07.11.05.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 11:05:21 -0700 (PDT)
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
Subject: [PATCH v11 01/15] platform/x86: lenovo-wmi-helpers: Fix memory leak in lwmi_dev_evaluate_int()
Date: Thu,  7 May 2026 18:04:53 +0000
Message-ID: <20260507180507.912966-2-derekjohn.clark@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260507180507.912966-1-derekjohn.clark@gmail.com>
References: <20260507180507.912966-1-derekjohn.clark@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A76BE4ED263
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_CC(0.00)[squebb.ca,gmx.de,lwn.net,rong.moe,gmail.com,valvesoftware.com,collabora.com,shzj.cc,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244616-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[derekjohnclark@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,squebb.ca:email,rong.moe:email]
X-Rspamd-Action: no action

From: Rong Zhang <i@rong.moe>

lwmi_dev_evaluate_int() leaks output.pointer when retval == NULL (found
by sashiko.dev [1]).

Fix it by moving `ret_obj = output.pointer' outside of the `if (retval)'
block so that it is always freed by the __free cleanup callback.

No functional change intended.

Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Fixes: e521d16e76cd ("platform/x86: Add lenovo-wmi-helpers")
Cc: stable@vger.kernel.org
Link: https://sashiko.dev/#/patchset/20260331181208.421552-1-derekjohn.clark%40gmail.com [1]
Signed-off-by: Rong Zhang <i@rong.moe>
Signed-off-by: Derek J. Clark <derekjohn.clark@gmail.com>
---
 drivers/platform/x86/lenovo/wmi-helpers.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/lenovo/wmi-helpers.c b/drivers/platform/x86/lenovo/wmi-helpers.c
index 7379defac500..018d7642e2bd 100644
--- a/drivers/platform/x86/lenovo/wmi-helpers.c
+++ b/drivers/platform/x86/lenovo/wmi-helpers.c
@@ -46,7 +46,6 @@ int lwmi_dev_evaluate_int(struct wmi_device *wdev, u8 instance, u32 method_id,
 			  unsigned char *buf, size_t size, u32 *retval)
 {
 	struct acpi_buffer output = { ACPI_ALLOCATE_BUFFER, NULL };
-	union acpi_object *ret_obj __free(kfree) = NULL;
 	struct acpi_buffer input = { size, buf };
 	acpi_status status;
 
@@ -55,8 +54,9 @@ int lwmi_dev_evaluate_int(struct wmi_device *wdev, u8 instance, u32 method_id,
 	if (ACPI_FAILURE(status))
 		return -EIO;
 
+	union acpi_object *ret_obj __free(kfree) = output.pointer;
+
 	if (retval) {
-		ret_obj = output.pointer;
 		if (!ret_obj)
 			return -ENODATA;
 
-- 
2.53.0


