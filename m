Return-Path: <stable+bounces-244618-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yAuGCo7U/GlvUQAAu9opvQ
	(envelope-from <stable+bounces-244618-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 07 May 2026 20:06:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D20CA4ED2A7
	for <lists+stable@lfdr.de>; Thu, 07 May 2026 20:06:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5D383304C9DA
	for <lists+stable@lfdr.de>; Thu,  7 May 2026 18:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D02046AECC;
	Thu,  7 May 2026 18:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZAbJzQBV"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB754611CA
	for <stable@vger.kernel.org>; Thu,  7 May 2026 18:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778177126; cv=none; b=Kdfr/oBjvlbePkz+Wuo4ecCGhS02Bv/eUTgmAjpDHv1ile64H5AH9Cnxx5IRaMSN37riJr2+n8isjU9cUvk7xXCfsjDyUnWHsBPrROhmTheZMiit7PPWjC07ZJCTenRTLyBV5sr8OPTa85urTg6vlK0KkrHSJGqiK6wSw5Tvhqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778177126; c=relaxed/simple;
	bh=6uvm7kxcoZxl4SJop0VuYLP778pizJEeCY5iHUnRujE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oCRV4Ir0aOOYeQlZ5uvgxqPUR0VTS84+LYju5es84OwQOy+DgceIlKP3g5PapRK/RnIBT7NF7OMQNUk6LrxkaUHZI5LhMLg4XWrAc17MyWnuRbIw8LyHsxzln0qm1LFEeiVBzOpOotopScF/K4ta3hr3g11EIJPqBNJ82f3qj8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZAbJzQBV; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-2f0d3e07e30so2975160eec.0
        for <stable@vger.kernel.org>; Thu, 07 May 2026 11:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778177124; x=1778781924; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4ki2zpxXcCZiQ654Cm5JOUD1c7/Sq7YjZSIjBtyxJhk=;
        b=ZAbJzQBVI0cLGmwvL10G6q18zhdo8D4tLW2JaIVPv62Q0sd3lkm5WaEGSRgCqPakDD
         gMJ7XxQk22EExn/wquItvA7iItdR4zvtXI6R1fden0+wSKwCSsTfsvSUYCOmqHVNGE5u
         Zqnq5r5jSol/aCE95DJsdXMsgm/FZv1VY6csxjT5ZmDKYJGYv5izFz9x+nXurrENXnXl
         TokzK3kG0XARajmZNTxeJXtQ/6IdvXfoMPpD5rq3NKf7HFHCwSPU9R1kHW9vs+Ii5qQP
         g7jM2irEwrB7KDPm+/yL0mNn2c14J12ssaSc5IVJptacVB+dX3VHLII7YxyVI2B8DTaz
         V9qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778177124; x=1778781924;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4ki2zpxXcCZiQ654Cm5JOUD1c7/Sq7YjZSIjBtyxJhk=;
        b=ZoukMGCu2oql0/2PYfmPhBlCDTXr4Keaiwjri9gVs+gW8znATAFS4G/Zk/DSJ9dvqR
         emaaWUa59JZgsUG2EB03ks6JKIAb0Y7S6cB8k/RadE9nf6xxJ2oCT0Af0RYxrV0xT46V
         PH5g7uk9zx7bmq0S0g9FHgsETBYRlcE0XPiMFiRNMYd0BvAbZci/3mLikB+O46SlcyHX
         MY0lUE6mPEyjc8CjNISTNQvjlMTYaTjQRiHoxgqWyplVMq8I1RESZOhgVVGW4BjaIGcF
         ROW2SOGGYClxATd7jqQZC8giwkJMVdGDcqp5JK85l0NwIYEaRguUeCcXRbPVUyCq9kiK
         JTKA==
X-Forwarded-Encrypted: i=1; AFNElJ87E2w8hjK8ISk69owh5TtGzNlfA+mQG5SPJzvK/MCCnxUQu+EtjY1iILVQMYwDuUmUiiGZhWw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/nMcTAVL4XfzDFDLkAq07IN2wbmWOBBP+4eyjPvm409u7WH+r
	S57X+wYeS7VAUiCMviVdZEj/ZDkDq6mX1VWOF09uGU34rq4Ru8BqqPd2gkbXfw==
X-Gm-Gg: Acq92OFtm0bOeUNc1btKpAVEH7c56W5l2RNSLHj//2JfFi+9Ti6sxvfN2OnkarPEgQ/
	IF52ri5HkWT/kvi7G1ieosHFRD4QU1GRlqYeH8mTUWEg1KoVheKHDrIGclRQSDrZPK1+aN06U4U
	ctjs3j1bjhGWmRKHOfD3WG/6NV4lkTYbSQnjDLIocCEdLZqmTXMBVTzxITfYnRo70MuWKLQ4WgS
	U8mMN/aVcjEJ8iWCbvDET9b9YpgbLLloFN1We6yJIoNSg6IILaaXRAi/iur9HGL2qvckIZMSl5i
	j6X9pXKdNcOB2CXCJ41vO8eYpqu5bQFetyXX45i7KmW4fhl77kPVx5oISSjaPbSzVVuUbPLtnNw
	WrDZJNSBhq+/MjmyDwq1mFXsjdKX2GFDfBsBSAV4K9WFV9GToddViyXJCFMf39dz9atY1wljbwZ
	bGM8U1WAiidY/ic5exNXem4YxPqDj3HttjtF2JAs6K5Id5Hmq5Ogav8diWEhY53cDDfXJZi0CfU
	nx2CwomJUUak9o=
X-Received: by 2002:a05:7300:72d1:b0:2f1:6252:f8ef with SMTP id 5a478bee46e88-2f548a9b30cmr5316897eec.1.1778177123686;
        Thu, 07 May 2026 11:05:23 -0700 (PDT)
Received: from lappy (108-228-232-20.lightspeed.sndgca.sbcglobal.net. [108.228.232.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f82bd73a64sm44332eec.12.2026.05.07.11.05.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 11:05:23 -0700 (PDT)
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
Subject: [PATCH v11 03/15] platform/x86: lenovo-wmi-other: Balance component bind and unbind
Date: Thu,  7 May 2026 18:04:55 +0000
Message-ID: <20260507180507.912966-4-derekjohn.clark@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260507180507.912966-1-derekjohn.clark@gmail.com>
References: <20260507180507.912966-1-derekjohn.clark@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D20CA4ED2A7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-244618-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[squebb.ca,gmx.de,lwn.net,rong.moe,gmail.com,valvesoftware.com,collabora.com,shzj.cc,vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[derekjohnclark@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[squebb.ca:email,sashiko.dev:url,rong.moe:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Action: no action

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


