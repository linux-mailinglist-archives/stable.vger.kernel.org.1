Return-Path: <stable+bounces-94776-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA9D59D6F07
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 13:59:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29100162034
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 12:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2A081BC9EE;
	Sun, 24 Nov 2024 12:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="unp2/0P7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E2B1BD4FD;
	Sun, 24 Nov 2024 12:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732452351; cv=none; b=LRfJwiFo+Puida6qXpdjOdgBcbBjv0DhXx/kMi9BVPDvnk3ph/1EUKgO4ftjBcLzU3aGGk+jttJeQ+lFsRhoSvVaCRIY0HeoHJ5INhF8EoBaoheLWr6YfmZvbkkEHzKBhP/QtY3RKu4sKxfYoD+TzMU2l0YSwVeGk12Zw1e3OMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732452351; c=relaxed/simple;
	bh=k7MfGDglnKUYbss0POiLHVKeYeFMjLONHdm4EcpnFEg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b4DKmTCJ7kpEqBEpp24553OA7ehX6RcVJVlyY3MGt91GMVJzD10BX6DltKjzhtjN9hq++JUIvYqFnlpD++xFplA3pBEwKg81lgluYTfzxa1+0ADE4+JcGyE38dWbg1U+IQA50IL3c9Xe11cr28mzu4dT7b04fIjviuZ6hvTIAGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=unp2/0P7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24178C4CED6;
	Sun, 24 Nov 2024 12:45:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732452351;
	bh=k7MfGDglnKUYbss0POiLHVKeYeFMjLONHdm4EcpnFEg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=unp2/0P7znVK2zGQri42b9z40htLlGYOXwYYxZLuV5r87TjkmepMxyzfDhB3k+NuO
	 O/25bbtyD3sWwFpoRupV0zgmg88iR1/3HSK7tFqs+YhRMMMLnRr99tG9SemBrlS01h
	 fQovk2r/Vcg75QKsSPjkQH2Y92fBjSwNYWCK2hUyoYjPkensW0Ij3T+0770CBFWkXe
	 mcUSaR+NYPzbY99unhy2ZmNEmT9LOSyhasMwIBFeDBRmYOKjy+kdyzsVQAQXJRgx+C
	 N0LTJ4BE7O0F6InwjOd5xLY30EIo2Rbr/rhqUkyS7l9z4txnTS0c0giSGpwnbxsvfi
	 WTMTDkoLMiRQA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sarah Maedel <sarah.maedel@hetzner-cloud.de>,
	Tommy Giesler <tommy.giesler@hetzner.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Sasha Levin <sashal@kernel.org>,
	jdelvare@suse.com,
	linux-hwmon@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 2/3] hwmon: (nct6775) Add 665-ACE/600M-CL to ASUS WMI monitoring list
Date: Sun, 24 Nov 2024 07:45:44 -0500
Message-ID: <20241124124547.3337766-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124124547.3337766-1-sashal@kernel.org>
References: <20241124124547.3337766-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.63
Content-Transfer-Encoding: 8bit

From: Sarah Maedel <sarah.maedel@hetzner-cloud.de>

[ Upstream commit ccae49e5cf6ebda1a7fa5d2ca99500987c7420c4 ]

Boards such as
* Pro WS 665-ACE
* Pro WS 600M-CL
have got a nct6775 chip, but by default there's no use of it
because of resource conflict with WMI method.

Add affected boards to the WMI monitoring list.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=204807
Co-developed-by: Tommy Giesler <tommy.giesler@hetzner.com>
Signed-off-by: Tommy Giesler <tommy.giesler@hetzner.com>
Signed-off-by: Sarah Maedel <sarah.maedel@hetzner-cloud.de>
Message-ID: <20241018074611.358619-1-sarah.maedel@hetzner-cloud.de>
[groeck: Change commit message to imperative mood]
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwmon/nct6775-platform.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/hwmon/nct6775-platform.c b/drivers/hwmon/nct6775-platform.c
index 706a662dd077d..7e0ac3fcbc050 100644
--- a/drivers/hwmon/nct6775-platform.c
+++ b/drivers/hwmon/nct6775-platform.c
@@ -1350,6 +1350,8 @@ static const char * const asus_msi_boards[] = {
 	"Pro H610M-CT D4",
 	"Pro H610T D4",
 	"Pro Q670M-C",
+	"Pro WS 600M-CL",
+	"Pro WS 665-ACE",
 	"Pro WS W680-ACE",
 	"Pro WS W680-ACE IPMI",
 	"Pro WS W790-ACE",
-- 
2.43.0


