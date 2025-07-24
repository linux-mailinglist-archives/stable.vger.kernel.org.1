Return-Path: <stable+bounces-164685-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 81581B111A1
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 21:27:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88D0F7B7445
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 19:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B58322ED862;
	Thu, 24 Jul 2025 19:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mvista.com header.i=@mvista.com header.b="h6qAKVX4"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DFCD2ECD34
	for <stable@vger.kernel.org>; Thu, 24 Jul 2025 19:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753385199; cv=none; b=P8hX78KReki3QqGTGi+nWfEr+02aS0Berl+qb2QJpYBJ9e0qfES3fM+noSZ4C87GqYaVljVQjdok3k7c8rNoi3QZRx4lHsihZZYSU3jfPaUcBGOxbJG+0/aFYh9t8VXGqiQUCFFa5F9DL7PHjBDNT0DgsstywRQBC1jk1deOinU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753385199; c=relaxed/simple;
	bh=f9NkPCFmPgNi9xcOxUDGiaAQyrFncFEJZvZUTKxDp88=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AHQTLSZ2oEuvbf0eNVbnZdGx7ur42ZCGCjCA+S1m6jQ7/Nt4ARJJEfFwidN0kaHC6UxAj8UZBAhC7uGYxdsQKG2MKrFfvb+acV48sTraR4cy/wLVFEdOUoDifI4TsyLtWnDK+E2DW1ytmGMWfsbjrMCtVlM72Lw/nPUx0I6hBsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mvista.com; spf=pass smtp.mailfrom=mvista.com; dkim=pass (1024-bit key) header.d=mvista.com header.i=@mvista.com header.b=h6qAKVX4; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mvista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mvista.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-312f53d0609so37946a91.1
        for <stable@vger.kernel.org>; Thu, 24 Jul 2025 12:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mvista.com; s=google; t=1753385196; x=1753989996; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qx2maG5RP/Ok6epaJYGdra//eZr+FaXwEPJw8eKKRwo=;
        b=h6qAKVX4MNPwMl2RTuX9gCD33QejZUc+nibdpQwTw+YoL7Ze1WIRSz4bnXQIwP/gOR
         3TG81t0i6MOoYY2laqJT/5VPLWiUaIJCp7jr8sqoWCydvRfF7n90ye9dtd38zGBtGii4
         f2DiAjvvK/xRIyc/tcI8akh++YPTPfqPGz9Ko=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753385196; x=1753989996;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qx2maG5RP/Ok6epaJYGdra//eZr+FaXwEPJw8eKKRwo=;
        b=hOzWHBxDrp7A02Udhp5A2mYhMMlHD9/266owQAldbfRwYnGo4xk2gqObul2ut06Bg+
         EWbv+AiWYGlcag1n4DUxV1moLUStbCUkQttH0ajDlbYFnFC/UJdGehSvA52Vp1rlyssv
         /dTulqr/OVnT673iWusAZglY3kFZusOeWCY4SUZBTz70f3Q2Lbo8Dmw7w2xWVgs/pYmW
         ZbzK0nz5015riLgc0Jzp/eSdjDbf9GUiPPOMMFMqmy1es/d7elbb4pdgfqP5zZc08rIc
         U8Jk4O9gpu4ARfIw5/VaWRvo0Tqx+Fg+24Xd4q6J/Nn3Z3ukDFBdcoUu4roQ/ZmGLjMp
         9S8Q==
X-Gm-Message-State: AOJu0YxrJkzjD2BsQ1DNJMJiITC30s8svmTedpkSTaq8TDuvQUtxYXyi
	J3hgp26F+uaXFHy5MZSzDC4zGbtJOZl2diZWWRLkt2vQiAHUKJKaCEoeYDC5WDNXJdcEw695q/x
	st/BhLXw=
X-Gm-Gg: ASbGncsjgUAWuIN7RE/Ovsyp5TcOwEZCZPFXH1JZpkVwKYAt39InesOYYZ8wRy9Br6/
	sEB3ncYJgzGplGAhTMPuVMFpdPCPogeDktYfGTUoxZTVuVgHBk8FgztaLwv7gkHqt44qPFEpGYZ
	c5skqvl410gZ7DfSYoGAeJIr8uA6GIkJm95ZuVjdkZtu8/3dr2LsgAbUERAyrirIT38ovBQKAGO
	FjIatwrleVDSxw8uIAzEory2f3IsueM3PcHHWRXBcsrgaqf4hPvxdx8IkwT59ZgyddFpOnZYjan
	UeKXoe82yvgtRBN1XEhPGdMtc3lRdXxdGyORVFebGfuaj1lME1KUxGLauTUeHCBRoqk6L9dQAv7
	Du6OunnJpAFwlNsnXIxYGva0lrsKQlqrpRQ==
X-Google-Smtp-Source: AGHT+IHNgEqHIY04Bqrdbkx/MeUVzmpWt2oOxJRCr+ECnjoi4Q9KHyYwJvBAB+K6NYqI3EcFDQRxsg==
X-Received: by 2002:a17:90b:4c09:b0:314:29ff:6845 with SMTP id 98e67ed59e1d1-31e507c808amr4476231a91.4.1753385196483;
        Thu, 24 Jul 2025 12:26:36 -0700 (PDT)
Received: from shubhamPC.mvista.com ([182.74.28.237])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31e6635f0a0sm1945884a91.24.2025.07.24.12.26.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 12:26:36 -0700 (PDT)
From: skulkarni@mvista.com
To: stable@vger.kernel.org
Cc: akuster@mvista.com,
	cminyard@mvista.com,
	Shubham Kulkarni <skulkarni@mvista.com>
Subject: [PATCH 5.4.y 0/8] Backport CVE-2022-4269 fix to stable kernel v5.4.y
Date: Fri, 25 Jul 2025 00:56:11 +0530
Message-Id: <20250724192619.217203-1-skulkarni@mvista.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Shubham Kulkarni <skulkarni@mvista.com>

Hi Greg/All,

This patch series backports the fix for CVE-2022-4269 along with its 7 dependency commits to 5.4 stable kernel.
These patches are already part of the next stable kernel v5.10.y and I have referred to those commits to generate
this series for v5.4.

[CVE-2022-4269 - kernel: net: CPU soft lockup in TC mirred egress-to-ingress action]

Patch 1: Dependency Patch #1 - mainline commit c8ecebd04cbb (v5.5-rc1)
Patch 2: Dependency Patch #2 - mainline commit 5e1ad95b630e (v5.5-rc1)
Patch 3: Dependency Patch #3 - mainline commit 26b537a88ca5 (v5.5-rc1)
Patch 4: Dependency Patch #4 - mainline commit ef816f3c49c1 (v5.5-rc1)
Patch 5: Dependency Patch #5 - mainline commit 075c8aa79d54 (v5.8-rc1)
Patch 6: Dependency Patch #6 -  v5.10.y commit bba7ebe10baf (v5.10.181)
Patch 7: Dependency Patch #7 -  v5.10.y commit f5bf8e3ca13e (v5.10.181)
Patch 8: CVE-2022-4269 fix   -  v5.10.y commit 532451037863 (v5.10.181)

---

Davide Caratti (2):
  net/sched: act_mirred: better wording on protection against excessive
    stack growth
  act_mirred: use the backlog for nested calls to mirred ingress

Jiri Pirko (1):
  selftests: forwarding: tc_actions.sh: add matchall mirror test

Vlad Buslov (4):
  net: sched: extract common action counters update code into function
  net: sched: extract bstats update code into function
  net: sched: extract qstats update code into functions
  net: sched: don't expose action qstats to skb_tc_reinsert()

wenxu (1):
  net/sched: act_mirred: refactor the handle of xmit

 include/net/act_api.h                         | 25 +++++++
 include/net/sch_generic.h                     | 13 ----
 net/sched/act_api.c                           | 14 ++++
 net/sched/act_csum.c                          |  4 +-
 net/sched/act_ct.c                            | 10 +--
 net/sched/act_gact.c                          | 14 +---
 net/sched/act_mirred.c                        | 55 ++++++++------
 net/sched/act_police.c                        |  5 +-
 net/sched/act_tunnel_key.c                    |  2 +-
 net/sched/act_vlan.c                          |  9 +--
 .../selftests/net/forwarding/tc_actions.sh    | 72 ++++++++++++++++---
 11 files changed, 150 insertions(+), 73 deletions(-)

-- 
2.25.1


