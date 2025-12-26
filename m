Return-Path: <stable+bounces-203417-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DBE57CDE5B4
	for <lists+stable@lfdr.de>; Fri, 26 Dec 2025 06:58:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0CCA2300A1D6
	for <lists+stable@lfdr.de>; Fri, 26 Dec 2025 05:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B34BE19309C;
	Fri, 26 Dec 2025 05:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IY/Mb+fA"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E12751448E0
	for <stable@vger.kernel.org>; Fri, 26 Dec 2025 05:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766728693; cv=none; b=QGdXsLkUxyTdstdWRAz6J0hrlMPIQnOwnhqadD8+s9kkyBheXAOWoHDxFFFdcYNXLsP1zleJPBEgwCpvUgJRn7+ZMODXTzgZ2vXFc0qX6J+DRSUebpMVghrLfzsgf4it79Jp/80dtu9CF1qj4VidrZ0q4S592h1aGLwPw/xtyhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766728693; c=relaxed/simple;
	bh=SWafGHchQ/WupSVFE44reC0oea2jmGzjOwOgHXp6duk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dbjnD3YCDGbPkE8nwomUiGlQr1WH2DfK0TL/J+cN/3ptmVPLjGKyofFkEvo9WqFieV1p44Tp+Ecw96YWh8sbxhq0mk+Bh23stemxxW5eAkFUTsWzFfWZdv+Jb1JlOdEE44f8bQ5QUC4KZT4p74pMKWZjneYFziUUAp9K1hmOF94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IY/Mb+fA; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7c765f41346so3048694a34.3
        for <stable@vger.kernel.org>; Thu, 25 Dec 2025 21:58:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766728691; x=1767333491; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GEDLwh/JQNESRj4Jh747I4xTT7R/UMI4uSVnVsPwLP8=;
        b=IY/Mb+fASCdl3sbylhgh2CSqNx4DElHzy8DAXQjWW3sCyB7WmzApXNBwiauH1lfU1E
         tKe7dwMmHu3zpRpO+zq0rGq6FDJA7zZijA9MwdSRKJDi9qRMlLbxMRTqPnr0yOApJgZs
         /t1o5YVXZ2hupQA6LpYiaEIfMXc9Y9qfV7vPn2/067fzAwjITGj5r9W5InYZDIOY/pEa
         P/rJQ0RZYS34cGFUpoE4bt50APduFuXG1WypmQiBF8mlDD9ViZ9eL1dVPMvigEMHvxQe
         tq8jhRUdA8dckUBxv3CGk+jxowLfTAbatQUaGcezfuzhhxjJb1BMl3nDEKF9my+QGJJd
         05aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766728691; x=1767333491;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GEDLwh/JQNESRj4Jh747I4xTT7R/UMI4uSVnVsPwLP8=;
        b=tyb4aYD9ZoVeUtQfQVJ9Y4gQ1UhTC6mLWMgKzhZk9vbRDx+jFVpqDHpFIXlTkCmhSo
         bxQPXacHDOLu8bGzeERkyT8nac15fu/UrQ/6IU+2NQo66R+i10EvFoqIJOb9EY0nbg0R
         Nzrod1Urm3hl0kEj7fXPYnUJBvuQBcgueKKwtkoHZigSxfLNNFPCDGnXoc+1AumukHmh
         tou+OdrhF4c/26Df3K/JW7d4aZT/U/O6jFRempcfX9/PQMsqcPDEg3iOrf48lNSB5y4F
         Xey6tQ7oqGxnY2ERvKEK6iYBSXwVHGYorAz4ejULAcUHuXHsClcDCVxPazVGypCSM7KC
         slTA==
X-Gm-Message-State: AOJu0YyZGRDKZCTO5TS4ObeJA5qQcGosdihNn3lCmW9UIlYoNEY9p8Hv
	CHFbYqobejJ98WjdiIeSWI1kHUsZTflZ8wDobio+HD0deuWKidoBGEHnpKG4AA==
X-Gm-Gg: AY/fxX77dzDsHrXTep+MfkIU7Ocb4hrdawCgizHAnae3SjUwXFmHOfhzbbvuhN6RxLp
	gyq6XYIkj3m9I4EBmZD372S3S+uAkqGHJQCc0gSutBXpSpvVfdnb92lY0hP1bzxrDyNCIi7OCGz
	N7P+6NO6JfH4UvmBIlZxwJ/HSfWtVX6iH8a2aKQstN5L/m49aw5IdD8i1M8VZ9nm1bhyJc/sBV0
	wh/g9Chc2zZ3O0zpGosS76b2CCwUKCXOy8PpMOT4HTzPg6DdjU/s7JyjA1T+Ta/sywZGeCnRokl
	hhqJcgosa+waXEatiqxXkZEoqcfAc68Uw8lgvlUM4T95MKqyEehPp7eHQ/BRU36Y3ZsCvfU9XRV
	++toIn+9vHjUl2sySs0w+eQHyJ1bWE72MDdnFYypG4MmzbsA2TmLujUcF33Ms0+nYm9O60e1kmF
	szMRnRmq2UiYkDNN0m6roxWHjQx8n+KGWSWQThpjGghn0wIslNsIgpMzzfNKM=
X-Google-Smtp-Source: AGHT+IEBxDfwWRrZ1vDRbVLUN+XMFV3KU+eNVhr6y4k9b09yPfFabGcvaVkj8qpo0djiX4KdJQ2C9Q==
X-Received: by 2002:a05:6830:dc6:b0:7c7:1c77:f107 with SMTP id 46e09a7af769-7cc66a9e05dmr11412583a34.34.1766728690767;
        Thu, 25 Dec 2025 21:58:10 -0800 (PST)
Received: from nairdora (108-75-189-46.lightspeed.wchtks.sbcglobal.net. [108.75.189.46])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7cc66645494sm14532416a34.0.2025.12.25.21.58.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Dec 2025 21:58:10 -0800 (PST)
From: Adrian Yip <adrian.ytw@gmail.com>
To: stable@vger.kernel.org
Cc: Adrian Moreno <amorenoz@redhat.com>,
	Pravin B Shelar <pshelar@ovn.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel-mentees@lists.linux.dev,
	skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com,
	khalid@kernel.org,
	Aaron Conole <aconole@redhat.com>,
	Adrian Yip <adrian.ytw@gmail.com>
Subject: [PATCH 6.6.y 1/2] selftests: openvswitch: Fix escape chars in regexp.
Date: Thu, 25 Dec 2025 23:56:04 -0600
Message-ID: <20251226055610.3120437-2-adrian.ytw@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251226055610.3120437-1-adrian.ytw@gmail.com>
References: <20251226055610.3120437-1-adrian.ytw@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Adrian Moreno <amorenoz@redhat.com>

[ Upstream commit 3fde60afe1f84746c1177861bd27b3ebb00cb8f5 ]

Character sequences starting with `\` are interpreted by python as
escaped Unicode characters. However, they have other meaning in
regular expressions (e.g: "\d").

It seems Python >= 3.12 starts emitting a SyntaxWarning when these
escaped sequences are not recognized as valid Unicode characters.

An example of these warnings:

tools/testing/selftests/net/openvswitch/ovs-dpctl.py:505:
SyntaxWarning: invalid escape sequence '\d'

Fix all the warnings by flagging literals as raw strings.

Signed-off-by: Adrian Moreno <amorenoz@redhat.com>
Reviewed-by: Aaron Conole <aconole@redhat.com>
Link: https://lore.kernel.org/r/20240416090913.2028475-1-amorenoz@redhat.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
(cherry picked from commit 3fde60afe1f84746c1177861bd27b3ebb00cb8f5)
Signed-off-by: Adrian Yip <adrian.ytw@gmail.com>
---
 .../selftests/net/openvswitch/ovs-dpctl.py       | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
index 8b120718768e..9f8dec2f6539 100644
--- a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
+++ b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
@@ -489,7 +489,7 @@ class ovsactions(nla):
                     actstr, reason = parse_extract_field(
                         actstr,
                         "drop(",
-                        "([0-9]+)",
+                        r"([0-9]+)",
                         lambda x: int(x, 0),
                         False,
                         None,
@@ -502,9 +502,9 @@ class ovsactions(nla):
                     actstr = actstr[len("drop"): ]
                     return (totallen - len(actstr))
 
-            elif parse_starts_block(actstr, "^(\d+)", False, True):
+            elif parse_starts_block(actstr, r"^(\d+)", False, True):
                 actstr, output = parse_extract_field(
-                    actstr, None, "(\d+)", lambda x: int(x), False, "0"
+                    actstr, None, r"(\d+)", lambda x: int(x), False, "0"
                 )
                 self["attrs"].append(["OVS_ACTION_ATTR_OUTPUT", output])
                 parsed = True
@@ -512,7 +512,7 @@ class ovsactions(nla):
                 actstr, recircid = parse_extract_field(
                     actstr,
                     "recirc(",
-                    "([0-9a-fA-Fx]+)",
+                    r"([0-9a-fA-Fx]+)",
                     lambda x: int(x, 0),
                     False,
                     0,
@@ -588,17 +588,17 @@ class ovsactions(nla):
                                 actstr = actstr[3:]
 
                             actstr, ip_block_min = parse_extract_field(
-                                actstr, "=", "([0-9a-fA-F\.]+)", str, False
+                                actstr, "=", r"([0-9a-fA-F\.]+)", str, False
                             )
                             actstr, ip_block_max = parse_extract_field(
-                                actstr, "-", "([0-9a-fA-F\.]+)", str, False
+                                actstr, "-", r"([0-9a-fA-F\.]+)", str, False
                             )
 
                             actstr, proto_min = parse_extract_field(
-                                actstr, ":", "(\d+)", int, False
+                                actstr, ":", r"(\d+)", int, False
                             )
                             actstr, proto_max = parse_extract_field(
-                                actstr, "-", "(\d+)", int, False
+                                actstr, "-", r"(\d+)", int, False
                             )
 
                             if t is not None:
-- 
2.52.0


