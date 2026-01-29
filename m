Return-Path: <stable+bounces-212742-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uKo6JmcKe2k6AwIAu9opvQ
	(envelope-from <stable+bounces-212742-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 29 Jan 2026 08:21:11 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 10BE1AC8DA
	for <lists+stable@lfdr.de>; Thu, 29 Jan 2026 08:21:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6832630065C4
	for <lists+stable@lfdr.de>; Thu, 29 Jan 2026 07:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5258636F411;
	Thu, 29 Jan 2026 07:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sladewatkins.com header.i=@sladewatkins.com header.b="V6/qxqTR"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EABC36D4EC
	for <stable@vger.kernel.org>; Thu, 29 Jan 2026 07:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769671267; cv=none; b=WBowD0VO8DQqjVt6znqkLtTQTnvqet8MjngzanpTskfzF4ky8tw+PmSztdDj7N9NOcTLQE9LjWMZKZgz3ckZjQixfnZyhRHF7c5JLWbBnLgLRbCh95oGYUbc5JgNZh70ItJLqsm+ucbht0wjgo2FlxPgbdm8/VjNnGl7Kwoaehs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769671267; c=relaxed/simple;
	bh=+6MZh+J6Q+j70H4mwdTGsZHIfea6KyoRILUlX81FHvw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EvUVJ9AKd1v0hFFAlXyhgvBWogWAIuw+l9crIWjYPPNLLsOhUiIpoU8cIMHPGoHsOFQBAy9DFd6MnsUpX2mEpAi7yH5aWpIvpuuzLdx8RNqieVwzeh+NDgna+Tv6enRWc/Hcin21aPPhl5V7wTKB/jFMg5FY+NTb+WHnETljiB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sladewatkins.com; spf=pass smtp.mailfrom=sladewatkins.com; dkim=pass (2048-bit key) header.d=sladewatkins.com header.i=@sladewatkins.com header.b=V6/qxqTR; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sladewatkins.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sladewatkins.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-50145d27b4cso7071661cf.2
        for <stable@vger.kernel.org>; Wed, 28 Jan 2026 23:21:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sladewatkins.com; s=google; t=1769671264; x=1770276064; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=R4ZLd3/jNbY72izSr6t7mz2zRr9R0kLvny/XO+YV9P8=;
        b=V6/qxqTRdMugdjlBoe8/w1bkoVVAyfQj6thE+lEivvz/Ilo1YYInVllU5DSX7rFGW9
         qd7eAwJUQgUo7Ckbg3+9G4XV+v0701rEiGQ0vyO+fL1j6mHSOuOKBPR890mIB1fzqImt
         TcwBd4YW4mwJhBeMuw05TW5Wd6ML9HyqIHV2efUP1pCbKgV/bwXcILnErTy6njPyTcCN
         l6VP0MRQsEypg724xtAy3M+QP0z4XZphuS2G/jsLfKp+RzKiyXUP/w/pwpSrzFBBs7Ca
         X/cTlZj7IH1ODICSO1M77uVFWWQYtWO+UOnx27Y8K0x1ld0tGZFg+kUxhYn6hPJrI8qR
         TTNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769671264; x=1770276064;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R4ZLd3/jNbY72izSr6t7mz2zRr9R0kLvny/XO+YV9P8=;
        b=lvf59WfaRyUpIJR++uvtHhl2TegMuLPrLmBDe9bmDP42+rw3ibdGVRnC4kZLVzFqXJ
         aLyCFfgnC4cUgUYRqtRxOYw+eMXn5OA7R0bRnIK5uhN1qiSrn0+o1F6NrfN0eAWXiYlS
         sS9ZJjkT7xYKxY5x+3uGPO/xQYGRuch9U3mWU7RtCSa8XvBteGOH/1W4uvt3GI3ZQt+B
         Qwf5q2s2xm7RlZfVck6jsHioI9Q+LFNg8ttWgjy8huIsCMYE8p0hRCB/FhTMys+Y76aP
         AtecIfxgaDYlRnrodwATDdbKvFzTIBY2M0MHcxHZkYmSx5/V3TiIY2KUWRls79TGony+
         CgKg==
X-Gm-Message-State: AOJu0Yw3mTZCYLpgENRoupM5qTksVY2GTKR43T3rNRfxLevXEvqggvGe
	xV6yz+bziJ8aHAGal3YzRHWfUCFbtjTGxOG536SLHshk35eOj8wDb/guj5uklRUIt0S4PHISPAV
	shddeQNqnrtMhJhq1MWnOtQmXm495yoDoYd4vjZPykiFgUfsYlwSzfgksAMW7CYQaig==
X-Gm-Gg: AZuq6aIRH3WzgVfwVj0HcqmzSxSumEK8qQYy3/FJWzlus2oK3zp7HLvpyihvlcX1dO8
	TmE2twBFrZxempBG5vadDzvPLNujr7aPDugIl1MWrfGPZnYQt+xpAReaO4HI3a5XaeEq65L9NFb
	v78lKooH+XoDapGWzStxWIHXcXR/G0p6k4cyN2fIwyRv9o2EqymCQPGDczeXSr5O4t8vMggXSta
	4G1DshHZzY71DYb8M9oZzOg9ahr8twYHava8IJMiWfX8TvpRrFcV0He1aeilfeiP4ZeY5JEJo+L
	zbBC4JAngqMeGJXchkdiwfHnJVvcne11EofjUqLxKeRcEg9TwIXd0TtQ0u5dqMSrrhWJlVgDJh0
	Or8+co/L/VCxJELDY5ssEwJ6b5D5X9NM+cqX8XCxY6WA0RpacaOykPvfZW1BvAFxQlvG9KH/Mn9
	ZGOswK7AwHZEB7gJU2FJn6OVpnG3/RPonfNNeVKFtRXUlQFJp4KA==
X-Received: by 2002:a05:622a:1308:b0:501:43fa:5446 with SMTP id d75a77b69052e-5032f765dcbmr105766491cf.28.1769671264263;
        Wed, 28 Jan 2026 23:21:04 -0800 (PST)
Received: from localhost.localdomain ([2600:2b00:7880:1d00:9d39:38a7:5a17:856a])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-894d36c7591sm32957376d6.16.2026.01.28.23.21.02
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 28 Jan 2026 23:21:03 -0800 (PST)
From: Slade Watkins <sr@sladewatkins.com>
To: gregkh@linuxfoundation.org
Cc: stable@vger.kernel.org,
	Slade Watkins <sr@sladewatkins.com>,
	Pavel Machek <pavel@ucw.cz>,
	Pavel Machek <pavel@nabladev.com>
Subject: [PATCH] scripts/quilt-mail: update email address for Pavel Machek
Date: Thu, 29 Jan 2026 02:21:00 -0500
Message-ID: <20260129072100.33442-1-sr@sladewatkins.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SW-RGPM-AntispamServ: glowwhale.rogueportmedia.com
X-SW-RGPM-AntispamVer: Reporting (SpamAssassin 4.0.2-sladew)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[sladewatkins.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	R_DKIM_ALLOW(-0.20)[sladewatkins.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-212742-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sr@sladewatkins.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[sladewatkins.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sladewatkins.com:email,sladewatkins.com:dkim,sladewatkins.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,denx.de:url,ucw.cz:email,nabladev.com:email]
X-Rspamd-Queue-Id: 10BE1AC8DA
X-Rspamd-Action: no action

Pavel's denx.de address is no longer valid, this commit changes it to the correct one.

Link: https://lore.kernel.org/stable/aXpt7kUYDovR4Fxo@ucw.cz/
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Pavel Machek <pavel@nabladev.com>
Signed-off-by: Slade Watkins <sr@sladewatkins.com>
---
 scripts/quilt-mail | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/quilt-mail b/scripts/quilt-mail
index 7ef3f2fdbc..b4963620ba 100755
--- a/scripts/quilt-mail
+++ b/scripts/quilt-mail
@@ -173,7 +173,7 @@ CC_NAMES=("linux-kernel@vger\.kernel\.org"
 	  "shuah@kernel\.org"
 	  "patches@kernelci\.org"
 	  "lkft-triage@lists\.linaro\.org"
-	  "pavel@denx\.de"
+	  "pavel@nabladev\.com"
 	  "jonathanh@nvidia\.com"
 	  "f\.fainelli@gmail\.com"
 	  "sudipm\.mukherjee@gmail\.com"
-- 
2.52.0


