Return-Path: <stable+bounces-232898-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OJDaNL7hzWlVigYAu9opvQ
	(envelope-from <stable+bounces-232898-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 05:25:50 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 501AD3831B8
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 05:25:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3E4BB3040FBD
	for <lists+stable@lfdr.de>; Thu,  2 Apr 2026 03:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08D89345CD0;
	Thu,  2 Apr 2026 03:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hUw/J7E4"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F1453328FA
	for <stable@vger.kernel.org>; Thu,  2 Apr 2026 03:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775100271; cv=none; b=fBhG7clAdxiqj8C+0L8UF2LPl1WmYmoaWOtfoL3MpXnqP2D3cXzOImmMJ06XaHij/4u1A1ZijTX/vHi/AJqf2/jcASJmD+XDbJHCxdhmRcVYM/RiRvblEmIfYDQoY7BVoe0eLHem4ZjJGJC2uKxTF4o/JfB9+LumqxhKwmUlIfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775100271; c=relaxed/simple;
	bh=A5nBMBkWkafHNY7USWwQbGA1Gg3Rjn8l3CkT7z4RWhQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BPPagICWj/8EMNOyh3HwjshVp6WD+jZDfWsujwMW32w91+4NrcyUOhtYhIVyKSI4X3tVHuXEZfGFDygjwmM6yheAAQV+iLGFxVzCUQXF5ozJu5Dln715ECGYAyno/Fmfy0sZvmaiymGsDrrmy7MnCoy+JzxoaZDdOZS40sXH7Xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hUw/J7E4; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-2ba895adfeaso560957eec.0
        for <stable@vger.kernel.org>; Wed, 01 Apr 2026 20:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775100270; x=1775705070; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c2sfsoM3eXXD/i3TYQHRzXUhUiniPGPfrTop9I4lCjo=;
        b=hUw/J7E4U1BhrHIYa3Pmfgd/JKI+CLxkxZpt8bWa7Y2tEcOA+pF3rpncf6Vw6fU1to
         ujNF6k9XWW1RSGFW3S8JACg4lvAi1pfYQyYXShDXOm2d3ZhiptWXJqj7p4flMKACo3gK
         7SDluwTG2VfGwvjM1xLtYCHoDOoxcjoqHhVF6aS+rKsI8BF3fwFNR9N5Py1vXIV5kSDe
         0Op7IPpw9J1Byo1wQrUoqVLWoaUhS+cZCtJGdKDJMqxVpJTcDQFkO9dilkSIXuz8U/QF
         Rx/zFC1Lf0fPEAbCTfXgooml3m2yZYk56jRgtKIPyrcKRfvbHDDGbHnsE0C3xnvsUf4c
         JWaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775100270; x=1775705070;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=c2sfsoM3eXXD/i3TYQHRzXUhUiniPGPfrTop9I4lCjo=;
        b=MxmHcbhn4AXzdQ8Nz719KoM1mnO50w8bcruI3quQfQxfV0bgBHAbwRVX1vgpijkVaG
         7LLvPj8+pnnwnQUfLJlzHmyoTaS3wk91VBhvpLpM9zVv/Z2yaB4q5ZMZ6LCAd5guSCg6
         shkKeBaWvRR+GGHsYpv274Nzenc2rTfbnFsQ+aWQPCeiJHytUW+D42UwkPrTNNV+KFjx
         jHM1JVJjvu3b4QWd9vKwbJgX1duAfDwzxDljvexnrC8EsVb4Fxn8e3ylUJn1IZV92Ehr
         YX0pWoxGMMMahHO/p7MbSbBxklkFtrYRgIe0PT5GpX76DcmUqgJBS3yiQ4zugq8iu32t
         aQsg==
X-Forwarded-Encrypted: i=1; AJvYcCXpc7pJ0AFfMP9MAP5aN1QV4h+JdOPZn8VJsKeWkAzVkWLJ5xtJcnUVhNTE7jWtoZRC895YjfA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUYZNJ6999YXIZbVJAIwryvfMDn1KFyqlCApWNgFEWnIC7fCsZ
	xWiPtcgXF0eXg3i9VgKB9QCz4CNjtNKL7zXzc0cJL3x1q82KZN3ohLOn
X-Gm-Gg: ATEYQzyj+Py86ADt849qzm/U/3CG6XO0I9ULOi84WH32clbl9zgSAKpwjgm4qONhbA5
	touJAY5oKZOzEcXEFL5yF+cGigHzkzDcFZ64rVvYGTk0TyxcIghVufSBwTEMtM33vWCqmpvvwN/
	h2O2RJY4zUq+iwbCnvi8gLaMvG+EG88J0kEZL0UAhP2vHLt8uPCWB0tRq9S+eSwZ5su8celV9EU
	4uNWzsRgjCTZaTAUCpDUG//Gfdef1TjLK/nig8zQUxKaY4jDGuRCHAxTMzkyJGPwXVku02o27Zk
	vx7KXjp/5+tq3DJxt/jKLF+kTY2klWgr80XNQx1OlurFTjdLA4J9AW8h4S/FdK50KbAXf8xX7Lv
	5CMorUwrqYyzOLkxa5sicEIQ452Xqgfgq0zs0hvMgFqLPtNGDcesf+iIhelSZUlAUQYt2slo076
	Aw62vRz2xHfInuQhTjURrRKso2wyPYeLnd0FfGovEdke6/N95Rkrep0m9wVS0syj3UlbBV68eGS
	dsa
X-Received: by 2002:a05:7300:6413:b0:2c0:dc7e:ed17 with SMTP id 5a478bee46e88-2c93116f5d6mr3146575eec.10.1775100269336;
        Wed, 01 Apr 2026 20:24:29 -0700 (PDT)
Received: from lappy (108-228-232-20.lightspeed.sndgca.sbcglobal.net. [108.228.232.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ca7cae9e9esm1265981eec.23.2026.04.01.20.24.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 20:24:29 -0700 (PDT)
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
Subject: [PATCH v7 03/16] platform/x86: lenovo-wmi-other: Balance component bind and unbind
Date: Thu,  2 Apr 2026 03:24:11 +0000
Message-ID: <20260402032424.678528-4-derekjohn.clark@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260402032424.678528-1-derekjohn.clark@gmail.com>
References: <20260402032424.678528-1-derekjohn.clark@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-232898-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[derekjohnclark@gmail.com,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[squebb.ca,gmx.de,lwn.net,rong.moe,gmail.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 501AD3831B8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Rong Zhang <i@rong.moe>

When lwmi_om_master_bind() fails, the master device's components are
left bound, with the aggregate device destroyed due to the failure
(found by sashiko.dev [1]).

Balance calls to component_bind_all() and component_unbind_all() when an
error is propagated to the component framework.

No functional change intended.

Fixes: edc4b183b794 ("platform/x86: Add Lenovo Other Mode WMI Driver")
Cc: stable@vger.kernel.org
Link: https://sashiko.dev/#/patchset/20260331181208.421552-1-derekjohn.clark%40gmail.com [1]
Signed-off-by: Rong Zhang <i@rong.moe>
---
 drivers/platform/x86/lenovo/wmi-other.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/lenovo/wmi-other.c b/drivers/platform/x86/lenovo/wmi-other.c
index b47418df099f..4b47b5886e33 100644
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


