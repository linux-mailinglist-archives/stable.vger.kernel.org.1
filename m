Return-Path: <stable+bounces-189967-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A60CEC0DADA
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 13:50:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A2833B5EB7
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 12:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BDD61C5F1B;
	Mon, 27 Oct 2025 12:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sladewatkins.com header.i=@sladewatkins.com header.b="GDRsHd5O"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCEFB2AE8E
	for <stable@vger.kernel.org>; Mon, 27 Oct 2025 12:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761569113; cv=none; b=fEYZz8VN8xYAvlJnFVzyPiIQ8lD0a0c/48hxnOm0qoQ5SLUvhVWdI9JIPLJlNIOEqjRAjLaVCqgFl3PcK471gV4/cbIl5/eveJQ3ubfjdYnAWSC58//ArHA0FCSrllkH131FyHAmtlLhc86B6zRz+ba6ctGKLtq5Y4+kHWbg1CE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761569113; c=relaxed/simple;
	bh=CyJi7fD5c1oeDNr7Tv93fobuOYeks19v4JQC0j1f4wQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nYsOqcDlY1tbylPDuzae4F1lDJFuHVnCRqPX/WMHPF0ioezEV+blgBf5cX+49xG3XQyp0eqcyjyFQ8+Xx9FXWX8c/dvkZA6Dx1/nNDqxQqYbo3fZUaCjcYNVUwGf9IfCRlLZQ6ozmPZMHWzjpNPpOt7W39+Mit5M++C5aVfUAq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sladewatkins.com; spf=pass smtp.mailfrom=sladewatkins.com; dkim=pass (2048-bit key) header.d=sladewatkins.com header.i=@sladewatkins.com header.b=GDRsHd5O; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sladewatkins.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sladewatkins.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-89f54569415so249396585a.1
        for <stable@vger.kernel.org>; Mon, 27 Oct 2025 05:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sladewatkins.com; s=google; t=1761569108; x=1762173908; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aIdlKHiNBcRsOdk0zhitg+CbnPREM81y40dFklcyMDo=;
        b=GDRsHd5O+w6etjDabOKAEampnhf/pf/GtJ5/u9DK9ksEkyAhjIL9T6WIaFDsNLJCby
         +34YlrQe3BE7Up7DxlkWnv/N7G1plhQY5+noIdPwp+9BxCvkyWRKZvOXF4jAOJuzBsfH
         Lt58wJlPcNThI6ar8eHQ0HCSlMKFygeeA9MFh9FeutoX4pzZgkxz9cv53Y4aEVje+Ky1
         EmEN404KreHSRzM5iy44CkCdCG821yxygNShYmFt9nCqaPxcdEr6VsN8OB0rvgE7o1mn
         rIqMRNVpigRE6hlQimzcGpHpoeXA0MGp7x/msYQSopBx45hGyeuMFIez+DAInJ1yDozS
         2U1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761569108; x=1762173908;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aIdlKHiNBcRsOdk0zhitg+CbnPREM81y40dFklcyMDo=;
        b=R7Lxbi00U1Ar5er5h0rslniQBoxEbHkV9I/Rgoyi9k+XPYDd/IEfy/pYLvA/ptLo4e
         01i/KowZcbUuxSYBBg9K1Tvu/VNHqY6gRfmqF51KKXszhHLDDVnYEynQqeFpywaYu1L4
         vWR1okWf07Q4cI3MZXUmvQ4zxb30tZI5kFXKUzGJeyjxmwsp9ymqY5eVsbotCxlKM+vc
         3jFdEAxhHiKyK62oO0KJplErUywxLU70d/LnrBZvrXk/kXJNxT+uCn3Gm4zeXcs8gr8P
         RAv21SeNBaG5q1j0itGztKlw5L3rDmmPMp1xnBXnOdKsRRT9BISjWoecMQT1h4GyTK4P
         XStg==
X-Gm-Message-State: AOJu0YwIBTikoKd69ATbzEAFHAxjIMGNb69gd5KR5zq2GamkxwKp3FN5
	ter7KL4I7ihUgufUUMB7HqdGA67RRsObQXm6vUqmqhv49ogLAShSD31SqACTbYtVunJrK2KyqIv
	1StSmounGYA==
X-Gm-Gg: ASbGncvJ9wGS2sXhlulOj9TNw7fTW2rFQ/C8WorId7lTUOZWITSC1jIsvyhin10V13c
	vjp1+VWP74AO6SaodsRmD+N0p8lGXwVom8WeegTDsvZ0d0fzMt5/EBofpaSFYMUiHX3iUHpisBE
	KusirKj76sS0GAclZtUrpZbPyJv4sNyPo7DerYjHjUqa5/9JkqsIOI19uNJKzy1jajLp/K6VpEK
	AOFqkQWMftzdALcK1BNlQbsyoImi6FyUV5sS6GxLU4RIIN6opPAlm+/GZcUsI4jTDZEjuszcc+o
	km6ELD2gg1D9NuwmPQciszWFszfzr6C2JOgp3gP0w2Vm+9Wqj7oEpZRAPheYtQyQUeuJpve0+QA
	BG7tQMod0yVJE/b03oh4yUF3V3zBkzeq3LCypR0s0gjj7bfKcNmh10oG0JYT82KU5ZshcnQwaNe
	aRGftQ2o918y+DREUETdunVVYRp6U0T661crU0rOuMFGz/+0o=
X-Google-Smtp-Source: AGHT+IEZhjPGg1BpMMX5sywEWMxaSYP7zsSMNgHJZTljZw9RTDV523RchX7AdFlPaKqJfcDbVN/MEQ==
X-Received: by 2002:a05:620a:190e:b0:8a2:473c:39d6 with SMTP id af79cd13be357-8a2473c4256mr511664885a.24.1761569108473;
        Mon, 27 Oct 2025 05:45:08 -0700 (PDT)
Received: from localhost.localdomain ([174.97.1.113])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-89f247fe594sm594170285a.16.2025.10.27.05.45.07
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 27 Oct 2025 05:45:08 -0700 (PDT)
From: Slade Watkins <sr@sladewatkins.com>
To: gregkh@linuxfoundation.org
Cc: stable@vger.kernel.org,
	Slade Watkins <sr@sladewatkins.com>
Subject: [PATCH] scripts/quilt-mail: add my new email address
Date: Mon, 27 Oct 2025 08:44:57 -0400
Message-ID: <20251027124457.36664-1-sr@sladewatkins.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

My old email address is no longer valid and was bouncing. Add my new one instead.

Signed-off-by: Slade Watkins <sr@sladewatkins.com>
---
 scripts/quilt-mail | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/scripts/quilt-mail b/scripts/quilt-mail
index 9790b65f0f..7ef3f2fdbc 100755
--- a/scripts/quilt-mail
+++ b/scripts/quilt-mail
@@ -181,7 +181,8 @@ CC_NAMES=("linux-kernel@vger\.kernel\.org"
 	  "conor@kernel\.org"
 	  "hargar@microsoft\.com"
 	  "broonie@kernel\.org"
-	  "achill@achill\.org")
+	  "achill@achill\.org"
+	  "sr@sladewatkins\.com")
 
 #CC_LIST="stable@vger\.kernel\.org"
 CC_LIST="patches@lists.linux.dev"
-- 
2.50.1 (Apple Git-155)


